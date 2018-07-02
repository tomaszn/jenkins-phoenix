FROM evarga/jenkins-slave

# universal tools
RUN apt-get update -y && apt-get install -y curl wget git sshpass unzip

# add node.js repository
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

# node.js, python3, libraries to build Python dependencies: psycopg2 and Pillow
RUN apt-get install -y nodejs python-virtualenv python-pip python3 python3-pip python3-dev libpq-dev python-imaging libjpeg-dev libpng-dev postgresql-client libgdal-dev
RUN pip install --upgrade pip virtualenv
RUN pip3 install --upgrade pip virtualenv

# install browsers (Firefox, Chrome) for UI testing with Selenium WebDriver
RUN apt-get update && apt-get install -y xvfb x11vnc firefox
RUN wget "https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz" -O geckodriver.tar.gz && tar xvzf geckodriver.tar.gz && mv geckodriver /usr/local/bin
RUN cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y
RUN wget https://chromedriver.storage.googleapis.com/2.40/chromedriver_linux64.zip && unzip chromedriver_*.zip && mv chromedriver /usr/local/bin
RUN update-locale LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN Xvfb -nolisten tcp -screen 0 1200x1000x24 :99 &
ENV DISPLAY :99

COPY startup.sh /tmp/
ENTRYPOINT "/tmp/startup.sh" && "/usr/sbin/sshd" -D
