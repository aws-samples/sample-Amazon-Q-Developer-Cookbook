## Prompts for creating code to extract data from unstructured document

# Promp to generate notebook file

``` bash
Generate a jupyter notebook file with the following cells:

#1 Text Cell: "Step 1: Install dependencies"
#2 Code Cell: Pip install commands for all dependencies that are gonna be needed
#3 Text Cell: "Step 2: Normalize PDFs to PNGs"
#4 Code Cell: Python code to read the current directory and, using pdf2image, convert all PDF files to PNG. Save each file with same name as the PDF file and add 01/02/03 etc for each page. Example <file>_01.png, etc. Use tqdm to display a progress bar by file.
#5 Text Cell: "Step 3: Extract content from all PNG files"
#6 Code Cell: Python code to read the current directory, and use AWS SDK to call textract to extrat all text from all PNG files.
Note that files might be named <anything>.png or <anything>_01.png, <anything>_02.png

VERY IMPORTANT: For both examples above we only want <anything>.txt - so make sure to group multiple pages into one full txt file at the end
Save them as txt files with same name as the PNG files besides them. PS: don't process files that already have a TXT file for it. Use tqdm to display a progress bar by file.

#7 Text Cell: "Step 4: Process all the information"
#8 Code Cell: For each TXT file on the current directory, Use AWS SDK to call Bedrock using Nova Pro to process the contents of the TXT file with the following prompt: 
>>>
Go through this transcript of an electric bill and parse all the relevant information (name, address, phone, usage, cost, etc) into a JSON in the following format: 

{
  "name": "<customer name>",
  "account": "<account number>",
  "address": "<address broken down into sub-properties for address, city, zip, etc>",
  "phone": "<phone number>",
  "email": "<customer email>",
  "dueDate": "<Due date in YYYY-MM-DD format>",
  "amount": <amount in number format>,
  "usage": <total kWh usage in number format>
}

Don't include anything on the response other than the JSON.
>>>
Parse the resulting information into JSON and it to a JSON file with same name as the TXT file beside it.
While parsing, make sure to parse from the first `{` to the last `}` - in the case model output any prefix/suffix content with the JSON.
PS: Don't process files that already have a JSON file processed. Use tqdm to display a progress bar by file.

Here's a documetation example on making a call to the model and processing result:
```python
import boto3
import json
from datetime import datetime

# Create a Bedrock Runtime client in the AWS Region of your choice.
client = boto3.client("bedrock-runtime", region_name="us-east-1")

MODEL_ID = "us.amazon.nova-pro-v1:0"

# Define your system prompt(s).
system_list = [
            {
                "text": "Act as a creative writing assistant. When the user provides you with a topic, write a short story about that topic."
            }
]

# Define one or more messages using the "user" and "assistant" roles.
message_list = [{"role": "user", "content": [{"text": "A camping trip"}]}]

# Configure the inference parameters.
inf_params = {"maxTokens": 2048, "topP": 0.9, "topK": 20, "temperature": 0.7}

request_body = {
    "schemaVersion": "messages-v1",
    "messages": message_list,
    "system": system_list,
    "inferenceConfig": inf_params,
}

start_time = datetime.now()

# Invoke the model with the response stream
response = client.invoke_model_with_response_stream(
    modelId=MODEL_ID, body=json.dumps(request_body)
)

request_id = response.get("ResponseMetadata").get("RequestId")
print(f"Request ID: {request_id}")
print("Awaiting first token...")

chunk_count = 0
time_to_first_token = None

# Process the response stream
stream = response.get("body")
if stream:
    for event in stream:
        chunk = event.get("chunk")
        if chunk:
            # Print the response chunk
            chunk_json = json.loads(chunk.get("bytes").decode())
            # Pretty print JSON
            # print(json.dumps(chunk_json, indent=2, ensure_ascii=False))
            content_block_delta = chunk_json.get("contentBlockDelta")
            if content_block_delta:
                if time_to_first_token is None:
                    time_to_first_token = datetime.now() - start_time
                    print(f"Time to first token: {time_to_first_token}")

                chunk_count += 1
                current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S:%f")
                # print(f"{current_time} - ", end="")
                print(content_block_delta.get("delta").get("text"), end="")
    print(f"Total chunks: {chunk_count}")
else:
    print("No response stream received.")
```

Overall notes:
1/ use os.listdir to iterate directory
2/ Don't use dotenv
```