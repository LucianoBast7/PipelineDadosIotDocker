
<pre class="overflow-visible!" data-start="147" data-end="575"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-markdown"><span><span># Projeto de Análise de Dados IoT de Temperatura</span><span>

</span><span>## 📌 Descrição</span><span>
Este projeto consiste em um sistema para coleta, armazenamento e visualização de dados de temperatura provenientes de dispositivos IoT.  
O fluxo inclui:

</span><span>-</span><span> Importação de dados de um </span><span>**CSV**</span><span>.
</span><span>-</span><span> Armazenamento em um banco </span><span>**PostgreSQL**</span><span>.
</span><span>-</span><span> Visualização em um </span><span>**dashboard interativo**</span><span> com </span><span>**Streamlit**</span><span> e </span><span>**Plotly**</span><span>.

---

</span><span>## 📂 Estrutura do Projeto</span><span>
</span></span></code></div></div></pre>

├── connect.py                # Teste de conexão com PostgreSQL

├── inserir_dados.py          # Importa dados do CSV para o banco

├── dashboard.py              # Dashboard em Streamlit

├── dados_kaggle/             # Dataset de entrada (ex: IOT-temp.csv)

├── sql/

│   └── views.sql             # Views SQL para análise

├── requirements/

│   └── requirements.txt      # Dependências do projeto

└── .env                      # Variáveis de ambiente (senha, configs)

<pre class="overflow-visible!" data-start="1040" data-end="2105"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>
---

</span><span>## ⚙️ Funcionalidades</span><span>

</span><span>1</span><span>.</span><span></span><span>**Conexão</span><span></span><span>Segura**</span><span></span><span>com</span><span></span><span>PostgreSQL</span><span></span><span>usando</span><span></span><span>senha</span><span></span><span>com</span><span></span><span>caracteres</span><span></span><span>especiais.</span><span>
</span><span>2</span><span>.</span><span></span><span>**Carga</span><span></span><span>de</span><span></span><span>Dados**</span><span></span><span>a</span><span></span><span>partir</span><span></span><span>de</span><span></span><span>arquivos</span><span></span><span>CSV.</span><span>
</span><span>3</span><span>.</span><span></span><span>**Dashboard</span><span></span><span>Interativo**</span><span></span><span>com:</span><span>
   </span><span>-</span><span></span><span>Média</span><span></span><span>de</span><span></span><span>temperatura</span><span></span><span>por</span><span></span><span>dispositivo.</span><span>
   </span><span>-</span><span></span><span>Contagem</span><span></span><span>de</span><span></span><span>leituras</span><span></span><span>por</span><span></span><span>hora.</span><span>
   </span><span>-</span><span></span><span>Temperaturas</span><span></span><span>máximas</span><span></span><span>e</span><span></span><span>mínimas</span><span></span><span>por</span><span></span><span>dia.</span><span>

---

</span><span>## 🚀 Pré-requisitos</span><span>

</span><span>-</span><span></span><span>Python</span><span></span><span>3.10</span><span>+</span><span>
</span><span>-</span><span></span><span>PostgreSQL</span><span></span><span>(porta</span><span></span><span>padrão</span><span></span><span>5432</span><span>)</span><span>
</span><span>-</span><span></span><span>Bibliotecas</span><span></span><span>do</span><span></span><span>`requirements.txt`</span><span>

---

</span><span>## 🔑 Configuração da Conexão</span><span>

</span><span>A</span><span></span><span>conexão</span><span></span><span>com</span><span></span><span>o</span><span></span><span>banco</span><span></span><span>de</span><span></span><span>dados</span><span></span><span>é</span><span></span><span>feita</span><span></span><span>com</span><span></span><span>SQLAlchemy.</span><span>  
</span><span>Se</span><span></span><span>sua</span><span></span><span>senha</span><span></span><span>contém</span><span></span><span>**caracteres</span><span></span><span>especiais**</span><span></span><span>(como</span><span></span><span>`@`,</span><span></span><span>`#`,</span><span></span><span>`!`),</span><span></span><span>você</span><span></span><span>deve</span><span></span><span>**escapá-la**.</span><span>

</span><span>Exemplo:</span><span>

</span><span>```python</span><span>
</span><span>from</span><span></span><span>sqlalchemy</span><span></span><span>import</span><span></span><span>create_engine,</span><span></span><span>text</span><span>
</span><span>from</span><span></span><span>urllib.parse</span><span></span><span>import</span><span></span><span>quote_plus</span><span>

</span><span>password</span><span></span><span>=</span><span></span><span>"Iz@791206@"</span><span></span><span># sua senha real</span><span>
</span><span>escaped_password</span><span></span><span>=</span><span></span><span>quote_plus(password)</span><span>

</span><span>engine</span><span></span><span>=</span><span></span><span>create_engine(</span><span>
    </span><span>f"postgresql://postgres:{escaped_password}@localhost:5432/postgres"</span><span>
</span><span>)</span><span>

</span><span>with</span><span></span><span>engine.connect()</span><span></span><span>as conn:</span><span>
    </span><span>result</span><span></span><span>=</span><span></span><span>conn.execute(text("SELECT</span><span></span><span>version();"))</span><span>
    </span><span>for row in result:</span><span>
        </span><span>print("Conectado</span><span></span><span>com</span><span></span><span>sucesso!",</span><span></span><span>row[0])</span><span>
</span></span></code></div></div></pre>

Isso converte `Iz@791206@` para `Iz%40791206%40`, evitando erros.

---

## 📥 Instalação

1. Clone o repositório:
   <pre class="overflow-visible!" data-start="2224" data-end="2293"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>git </span><span>clone</span><span> <url-do-repositorio>
   </span><span>cd</span><span> Estudo-de-Caso
   </span></span></code></div></div></pre>
2. Crie e ative um ambiente virtual:
   <pre class="overflow-visible!" data-start="2335" data-end="2454"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>python -m venv venv
   </span><span>source</span><span> venv/bin/activate   </span><span># Linux/Mac</span><span>
   venv\Scripts\activate      </span><span># Windows</span><span>
   </span></span></code></div></div></pre>
3. Instale as dependências:
   <pre class="overflow-visible!" data-start="2487" data-end="2549"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>pip install -r requirements/requirements.txt
   </span></span></code></div></div></pre>
4. Configure variáveis de ambiente no arquivo `.env`:
   <pre class="overflow-visible!" data-start="2608" data-end="2730"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-env"><span>POSTGRES_USER=postgres
   POSTGRES_PASSWORD=Iz@791206@
   POSTGRES_HOST=localhost
   POSTGRES_DB=postgres
   </span></code></div></div></pre>

---

## ▶️ Uso

### 1. Testar conexão

<pre class="overflow-visible!" data-start="2770" data-end="2799"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>python connect.py
</span></span></code></div></div></pre>

### 2. Inserir dados no banco

<pre class="overflow-visible!" data-start="2831" data-end="2866"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>python inserir_dados.py
</span></span></code></div></div></pre>

### 3. Rodar o dashboard

<pre class="overflow-visible!" data-start="2893" data-end="2931"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>streamlit run dashboard.py
</span></span></code></div></div></pre>

---

## 🗄️ Estrutura do Banco de Dados

Views disponíveis em `sql/views.sql`:

* `avg_temp_por_dispositivo` → média de temperatura por dispositivo
* `leituras_por_hora` → contagem de leituras por hora
* `temp_max_min_por_dia` → máximas e mínimas por dia

---

## 🛠️ Tecnologias

* **Python**
* **Pandas** (análise de dados)
* **SQLAlchemy** (conexão com PostgreSQL)
* **PostgreSQL**
* **Streamlit** (dashboard web)
* **Plotly** (gráficos interativos)
* **python-dotenv** (variáveis de ambiente)
