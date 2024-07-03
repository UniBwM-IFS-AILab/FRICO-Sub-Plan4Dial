# Plan4Dial

Generates a chatbot given a simple YAML configuration using automated planning for conversation navigation and machine learning for NLU.

## Documentation
https://dialogue-planning.github.io/plan4dial/

## Requirements - Docker
To ensure development works identically accross systems, Docker should be used to run Plan4Dial.
Inside the repository, follow these steps to run with Docker:
1. Retrieve a copy of the rbp.sif executable from Christian Muise (christian.muise@queensu.ca) and place this in the cloned repository.
2. Build the docker image from Dockerfile: `docker build -t plan4dial:latest .`
3. Run a bash session inside a new docker container: `docker run -it --name plan4dial --rm --volume $(pwd)/plan4dial:/root/app/plan4dial --net=host --privileged plan4dial:latest bash` Here `pwd` is present working directory. So ensure that you are inside the root folder of plan4dial, so that it works. 
    - OR if you are using Windows in CMD run: `docker run -it --name plan4dial --rm --volume %cd%/plan4dial:/root/app/plan4dial --net=host --privileged plan4dial:latest sh`
4. Run the command in the bash session: `python plan4dial/main.py ijcai_bot` . Note that if you want to use the `gold_standard_bot` you have to switch to the `main` branch. 
5. Now you should see output files were created and successful output in the bash session in the container. You can copy these output files out from the filesystem outside the container, the /plan4dial subdirectory is mounted. If you plan on pointing to this location from hovor directly, you can skip copying files. 

Note: You can make changes to python files inside subfolder /plan4dial without rebuilding the docker container as it is mounted as as simple volume.

## Usage/Tutorial
See [here](https://dialogue-planning.github.io/plan4dial/tutorial.html) for the full tutorial.

## Citing This Work
Coming soon!


# Whats added in this branch compared with main

    1. Essentially, we only define a slot_fill_more action type, that concatenates different slot_fill type of actions together in the beginning of the conversation.   