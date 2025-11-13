# HSTAT SEP Codespace

This repository is a **ready-to-use GitHub Codespace** setup for HTML, CSS, JavaScript, and Java. Everything you need is pre-installed.

---

## **Quick Start**

Go to https://github.com/hstatsep/codespace/codespaces
   - Press the green button: **Create codespace on Main**
   - Wait a few minutes while the container builds.
   - It will install:
     - Node.js & npm
     - Java 17
     - Git
     - `http-server`
     - VS Code extensions for HTML, CSS, JS, and Java

3. **Open the terminal**  
   - Check your tools (test commands in bash):
```bash
node -v
npm -v
java -version
http-server --version
git --version
```

4. **Test a simple project**  
```bash
mkdir web-test
echo "<h1>Hello Codespace</h1>" > web-test/index.html
cd web-test
http-server
```
   - Click the forwarded port link in Codespaces to see your page in the browser.

---

## **Tips**

- Find all your Codespaces: [https://github.com/codespaces](https://github.com/codespaces)  
- Save your work often using Git:
```bash
git add .
git commit -m "My first changes"
git push
```
- If you did the last one, then: Don't be worried about your terminal breaking.

---

## **How to do this on your own :)**

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)  
- [Dev Containers Documentation](https://containers.dev/)  
- [VS Code Remote Development](https://code.visualstudio.com/docs/remote/containers)  
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
