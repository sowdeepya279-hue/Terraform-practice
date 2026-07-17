def lambda_handler(event, context):
    name = "Deepa"

    print("Hello", name)
    print("Welcome to Python Programming!")
    print("Have a great day!")
    print("Happy Learning!")

    return {
        "statusCode": 200,
        "body": "Hello sow! Welcome to Lambda-s3!"
    }