# Chat API

## A Sample Chatting REST API to broadcast messages to all chat readers

<p align="center">
    <a href="https://github.com/3omar-mostafa/Chat_API/actions/workflows/ci_pipeline.yml" alt="CI Pipeline">
        <img src="https://github.com/3omar-mostafa/Chat_API/actions/workflows/ci_pipeline.yml/badge.svg" />
    </a>
    <a href="https://documenter.getpostman.com/view/18745377/2s84DsrztQ" alt="Postman docs">
        <img src="https://img.shields.io/badge/Postman-docs-orange?style=flat&logo=postman&logoColor=white&labelColor=orange" />
    </a>
</p>

---

<p align="center">
<strong>Used Tools & Technologies<strong/><br/><br/>
<img src="https://img.shields.io/badge/ruby%20on%20rails-%23CC0000.svg?style=for-the-badge&logo=ruby&logoColor=white" />
<img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white" />
<img src="https://img.shields.io/badge/redis-%23DD0031.svg?style=for-the-badge&logo=redis&logoColor=white" />
<img src="https://img.shields.io/badge/-ElasticSearch-005571?style=for-the-badge&logo=elasticsearch" />
<img src="https://img.shields.io/badge/IntelliJ%20IDEA-000000.svg?style=for-the-badge&logo=intellij-idea&logoColor=white" />
<img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white" />
<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white" />
</p>

---

## API Structure

*   **Chat Application**: A collection of chats, where each application will have a ***name***, and ***token***
*   **Chat**: A collection of messages, where each chat belongs to a ***Chat Application***, have a ***name*** and ***chat_id***
    *   ***chat_id*** is specific to a certain ***Chat Application*** and starts from ***1*** for each ***Chat Application***
*   ***Message***: The content actually sent, each message belongs to a ***Chat***, have ***content*** and ***message_id***
    *   ***message_id*** is specific to a certain ***Chat*** and starts from ***1*** for each ***Chat***
    *   **Messages' content are searchable**

---
## Dependencies
Application is dockerized, all you need is to have `docker-compose`

## Getting Started
1. Checkout this repository
    ```sh
    git clone https://github.com/3omar-mostafa/Chat_API.git
    ```
2. Run using docker
    ```sh
    cd Chat_API
    docker-compose up -d
    ```
3. The API is now served by `http://locathost:8080` by default

4. Testing `[OPTIONAL]`

    To run the Specs (Tests) 
    ```sh
    cd Chat_API
    docker-compose run backend /app/docker/entrypoints/test.sh
    ```
---

## API Documentation

[![Postman docs](https://img.shields.io/badge/Postman-Docs-orange?style=for-the-badge&logo=postman&logoColor=white&labelColor=orange)](https://documenter.getpostman.com/view/18745377/2s84DsrztQ) 


---

