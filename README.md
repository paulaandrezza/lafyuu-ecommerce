# 🛍️ Lafyuu – E-commerce Mobile App

**Lafyuu** é um aplicativo de e-commerce desenvolvido em **Flutter**, com foco em usabilidade, responsividade e experiência moderna. A aplicação permite aos usuários navegar por produtos, visualizar detalhes, editar perfil e agora conta com **geolocalização integrada com Google Maps**.

---

## 🎬 Demonstração

[📽️ Clique aqui para ver o vídeo demonstrativo](https://drive.google.com/file/d/1Kg3d95sFoZiTpBRksrMmJUEg9QJKMVIh/view?usp=sharing)

---

## 🧪 Tecnologias Utilizadas

- Flutter + Dart
- Google Maps SDK (`google_maps_flutter`)
- Geolocator (para obter localização atual)
- Backend em Node.js (para APIs de produtos, usuários, etc.)

---

## 🔧 Pré-requisitos

Para rodar este projeto, você precisará ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Android Studio ou VS Code](https://flutter.dev/docs/get-started/editor)
- Um dispositivo/emulador Android com Google Play Services
- Um projeto no [Google Cloud Console](https://console.cloud.google.com/) com a API do Maps habilitada

---

## 🚀 Como Rodar o Projeto

### 1. Clone o repositório:

```bash
git clone https://github.com/paulaandrezza/ADS-6-Semestre.git
cd .\PDMI6\Projetos\lafyuu
```

### 2. Crie o arquivo `.env` na raiz do projeto:

```env
GOOGLE_MAPS_API_KEY=AIzaSyA...sua-chave-aqui...
```

### 3. Instale as dependências:

```bash
flutter pub get
```

### 4. Rode o backend (recomendado):

O app consome a API de um backend. Você pode acessá-lo neste repositório:
🔗 [Link do backend](https://github.com/MichellyNonatto/projetoWeb)

### 5. Execute o aplicativo:

```bash
flutter run
```

---

## 📦 Funcionalidades

- Autenticação de usuários
- Listagem e detalhes de produtos
- Gerenciamento de perfil
- Integração com localização em tempo real
- Visualização de mapa com o Google Maps

---

## 🗺️ Observações sobre o Google Maps

- Ative o **Maps SDK for Android** no seu projeto do Google Cloud
- Cadastre a **impressão digital SHA-1** do seu app
- Cadastre o **package name**: `com.example.lafyuu`
- Use a chave da API no arquivo `.env`

---

## 👨‍💻 Autor

Desenvolvido por [Paula Marinho](https://github.com/paulaandrezza)
