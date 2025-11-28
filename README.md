1. make shell - собирается и запускается докер c настроенной средой разработки
1. napi new


сборка проекта под платформу:
  napi build --target x86_64-unknown-linux-gnu

cборка релиза:
  napi build --platform --release -o ./output
