# Elixir-Testnet-Validator
----------------------------------------------
**Go to** [Elixir Testnet Dashboard](https://testnet-3.elixir.xyz/) to mint some MOCK tokens and stake them.

**Update and Install Docker:**
 ```bash
 sudo apt update && sudo apt upgrade -y
 curl -fsSL get.docker.com -o get.docker.sh && sh get.docker.sh && systemctl start docker && systemctl enable docker
 docker --version
```
**Prepare Environment:**

```bash
mkdir -p ~/elixir && cd elixir
wget https://files.elixir.finance/validator.env -O ~/elixir/validator.env
```
```bash
nano validator.env
```
**Edit validator.env File:** 

STRATEGY_EXECUTOR_IP_ADDRESS=YOUR_PUBLIC_IP

STRATEGY_EXECUTOR_DISPLAY_NAME=your_node_name

STRATEGY_EXECUTOR_BENEFICIARY=YOUR_WALLET_ADDRESS

SIGNER_PRIVATE_KEY=YOUR_PRIVATE_KEY(without 0x)
```bash
screen -S elixir
```
```bash
docker pull elixirprotocol/validator:v3
```
**Run Docker Container:**


```bash
docker run -it \
  --env-file ~/elixir/validator.env \
  --name elixir \
  elixirprotocol/validator:v3
```
*wait one hour and should see yours here*
[Elixir Testnet Dashboard](https://testnet-3.elixir.xyz/)

![image](https://github.com/user-attachments/assets/01639a2a-8add-40d8-aca0-d32bf9d655cb)

**update**
```bash 
cd elixir && wget https://files.elixir.finance/validator.env -O ~/elixir/validator.env
```
```bash
nano validator.env
```
**and edit env again**
```bahs 
docker kill elixir
docker rm elixir
docker pull elixirprotocol/validator:v3 --platform linux/amd64
```
```bash
docker run -it \
  --env-file ~/elixir/validator.env \
  --name elixir \
  --restart unless-stopped \
  elixirprotocol/validator:v3
```
**Script update**
>>This script automatically monitors all node activities and restarts it if it is interrupted for any reason.
```bash
cd ~ && cd elixir && rm -f monitor.sh && wget https://raw.githubusercontent.com/Onixs50/Elixir-Testnet-Validator/main/monitor.sh && chmod +x monitor.sh && ./monitor.sh
```
