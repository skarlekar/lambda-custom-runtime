#!/bin/bash
aws lambda invoke --function-name bash-runtime --payload '{"text":"Hello"}' response.txt
