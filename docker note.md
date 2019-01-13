# docker 学习笔记

~~~shell

# 交互式ubuntu
docker run -i -t -d ubuntu:18.04

# 创建一个容器, 并运行
docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8000:8000 v2ray/official  v2ray -config=/etc/v2ray/config.json

# 查看容器信息
docker container ls

# 使用查看得到的ContainerID, 进入正在运行的容器中
docker exec -it c2e015bad753 /bin/sh

# 若修改了配置文件, 则需要: 停止容器, 并删除容器, 重新创建, 并运行
docker container stop v2ray && docker rm v2ray

tail -f /var/log/v2ray/access.log

# docker 的基本单位:
    image       一般由Dockerfile产生
    container   运行image之后会产生container
    volume
    plugin



# docker 命令帮助

# Commands:
    attach    Attach to a running container                 # 当前 shell 下 attach 连接指定运行镜像
    build     Build an image from a Dockerfile              # 通过 Dockerfile 定制镜像
    commit    Create a new image from a container's changes # 提交当前容器为新的镜像
    cp        Copy files/folders from the containers filesystem to the host path
              # 从容器中拷贝指定文件或者目录到宿主机中
    create    Create a new container                        # 创建一个新的容器，同 run，但不启动容器
    diff      Inspect changes on a container's filesystem   # 查看 docker 容器变化
    events    Get real time events from the server          # 从 docker 服务获取容器实时事件
    exec      Run a command in an existing container        # 在已存在的容器上运行命令
    export    Stream the contents of a container as a tar archive   
              # 导出容器的内容流作为一个 tar 归档文件[对应 import ]
    history   Show the history of an image                  # 展示一个镜像形成历史
    images    List images                                   # 列出系统当前镜像
    import    Create a new filesystem image from the contents of a tarball  
              # 从tar包中的内容创建一个新的文件系统映像[对应 export]
    info      Display system-wide information               # 显示系统相关信息
    inspect   Return low-level information on a container   # 查看容器详细信息
    kill      Kill a running container                      # kill 指定 docker 容器
    load      Load an image from a tar archive              # 从一个 tar 包中加载一个镜像[对应 save]
    login     Register or Login to the docker registry server   
              # 注册或者登陆一个 docker 源服务器
    logout    Log out from a Docker registry server         # 从当前 Docker registry 退出
    logs      Fetch the logs of a container                 # 输出当前容器日志信息
    port      Lookup the public-facing port which is NAT-ed to PRIVATE_PORT
              # 查看映射端口对应的容器内部源端口
    pause     Pause all processes within a container        # 暂停容器
    ps        List containers                               # 列出容器列表
    pull      Pull an image or a repository from the docker registry server
              # 从docker镜像源服务器拉取指定镜像或者库镜像
    push      Push an image or a repository to the docker registry server
              # 推送指定镜像或者库镜像至docker源服务器
    restart   Restart a running container                   # 重启运行的容器
    rm        Remove one or more containers                 # 移除一个或者多个容器
    rmi       Remove one or more images                 
              # 移除一个或多个镜像[无容器使用该镜像才可删除，否则需删除相关容器才可继续或 -f 强制删除]
    run       Run a command in a new container
              # 创建一个新的容器并运行一个命令
    save      Save an image to a tar archive                # 保存一个镜像为一个 tar 包[对应 load]
    search    Search for an image on the Docker Hub         # 在 docker hub 中搜索镜像
    start     Start a stopped containers                    # 启动容器
    stop      Stop a running containers                     # 停止容器
    tag       Tag an image into a repository                # 给源中镜像打标签
    top       Lookup the running processes of a container   # 查看容器中运行的进程信息
    unpause   Unpause a paused container                    # 取消暂停容器
    version   Show the docker version information           # 查看 docker 版本号
    wait      Block until a container stops, then print its exit code
              # 截取容器停止时的退出状态值


## docker-compose 常用命令

Commands:
    build              Build or rebuild services            # 构建或重建服务
    bundle             Generate a Docker bundle from the Compose file
    config             Validate and view the compose file
    create             Create services
    down               Stop and remove containers, networks, images, and volumes
    events             Receive real time events from containers
    exec               Execute a command in a running container
    help               Get help on a command
    kill               Kill containers                      # 杀掉容器
    logs               View output from containers          # 显示容器的输出内容
    pause              Pause services
    port               Print the public port for a port binding # 打印绑定的开放端口
    ps                 List containers                      # 显示容器
    pull               Pull service images                  # 拉取服务镜像
    push               Push service images
    restart            Restart services                     # 重启服务
    rm                 Remove stopped containers            # 删除停止的容器
    run                Run a one-off command                # 运行一个一次性命令
    scale              Set number of containers for a service   # 设置服务的容器数目
    start              Start services                       # 开启服务
    stop               Stop services                        # 停止服务
    top                Display the running processes
    unpause            Unpause services
    up                 Create and start containers
    version            Show the Docker-Compose version information  # 创建并启动容器


# http://blog.justwe.site/2018/06/28/docker-arg-env
arg 是在 build 的时候存在的, 可以在 Dockerfile 中当做变量来使用
env 是容器构建好之后的环境变量, 不能在 Dockerfile 中当参数使用


# 终止整个服务集合
docker-compose stop

# 终止指定的服务 （这有个点就是启动的时候会先启动 depond_on 中的容器，关闭的时候不会影响到 depond_on 中的）
docker-compose stop nginx

# 查看容器的输出日志
docker-compose logs -f [services...]

# 构建镜像时不使用缓存（能避免很多因为缓存造成的问题）
docker-compose build --no-cache --force-rm

# 移除指定的容器
docker-compose rm nginx


~~~