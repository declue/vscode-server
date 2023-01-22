# vscode-server

# 목적
- vscode에 대한 web ide를 손쉽게 구성하고자 dockerfile, helm chart를 생성하였습니다

# branch 정책
| BRANCH | 설명                                                    |
|--------|--------------------------------------------------------|
| main   | extension 없이 vscode만 설치된 구성, helm repo 가 구성되어 있음 |
| python | python을 위한 최소 extension 이 구성되어 있습니다.             |

# 주요 기본 설치 패키지
- python3.8
- openjdk-11-jdk
- build-essesntial 
- git
- openssl
- vim

# 사용법
### extension 없는 기본 vscode web
```
docker pull ghcr.io/declue/vscode-server:default
docker run --rm -e PASSWORD=changeit -p 28080:8080 -it ghcr.io/declue/vscode-server:default 
```
### python용 vscode web
```
docker pull ghcr.io/declue/vscode-server:python
```

# vscode web 버전 출처
- https://github.com/coder/code-server
