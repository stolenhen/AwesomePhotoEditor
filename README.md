# Example of a photo editor app 

## For launching the app it needs to be set the following scripts to the target build rules:

For source files with names matching ci.metal:
```
script: xcrun metal -c -fcikernel "${INPUT_FILE_PATH}" -o "${SCRIPT_OUTPUT_FILE_0}"
output files: $(DERIVED_FILE_DIR)/$(INPUT_FILE_BASE).air
```


For source files with names matching *.ci.air:
```
script: xcrun metallib -cikernel "${INPUT_FILE_PATH}" -o "${SCRIPT_OUTPUT_FILE_0}"
output files: $(METAL_LIBRARY_OUTPUT_DIR)/$(INPUT_FILE_BASE).metallib
```
