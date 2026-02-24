## Running the demo in a CHTC interactive job

This demo uses verl `v0.7.0`, which is the latest stable version at the time of writing.

> **Development Philosophy:**
> We do all code development on your local machine, but we submit jobs from CHTC. We use automated scripts to sync your code to CHTC and submit the jobs. When submitting jobs, we'll only use scripts in the `chtc` directory. We won't run any Python code on the CHTC submit node.

### 1. Local Setup
Clone this repo on your local machine.
```bash
git clone git@github.com:Badger-RL/llm-starter.git
cd llm-starter
```

### 2. Set Up Credentials
We'll be using wandb and huggingface for logging and model storage. Navigate to the `chtc` directory and copy the template file to create your own hidden `.env` file:

```bash
cd chtc
cp .env.template .env
```
Open `.env` and fill in your CHTC username, Weights & Biases API key, and Hugging Face token. **Do not commit this file to version control.**

### 3. (Optional) Global Login Script
Note that `login_chtc.sh` can be used in any project you build, so it's useful to make it globally executable. On a Mac, you would do this:
```bash
mkdir -p ~/bin
cp login_chtc.sh ~/bin/
chmod +x ~/bin/login_chtc.sh
```
Add this to your `~/.zshrc` (or `~/.bashrc`):
```bash
export PATH="$HOME/bin:$PATH"
```
Restart your terminal or run `source ~/.zshrc`. You should now be able to run `login_chtc.sh` from anywhere! *(Note: because the script relies on your `.env` file, ensure your terminal is inside a project directory containing a valid `.env` when you run it).*

### 4. Sync Code to CHTC
Transfer your code and environment variables to CHTC. This script automatically packages your code for the CHTC staging directory and securely mirrors your `.env` and scripts to your CHTC home directory. Assuming you are still in the `chtc` directory:

```bash
./transfer_to_chtc.sh
```
*Note: If you make changes to your code locally, simply run this command again to ensure CHTC has the latest version.*

### 5. Login to CHTC
Use the automated login script to SSH into the submit node (it will pull your username directly from your `.env` file):

```bash
./login_chtc.sh
```

### 6. Submit an Interactive Job
On your CHTC submit node, navigate to your synced directory and submit an interactive job:
```bash
cd llm-starter/chtc
./submit_interactive.sh 1
```
> The argument after `submit_interactive.sh` is the number of GPUs you want to use. You can use at most 4 in an interactive job.

### 7. Run the Demo
Wait for CHTC to match you to a machine (this can take a few minutes). Once the job starts, run the demo:
```bash
chmod +x job.sh
./job.sh
```
You can also just copy-paste the commands from `job.sh` directly into your terminal, which is useful when adding/removing commands for testing/debugging/etc.