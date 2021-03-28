# Template

## pre-instalado
* login
* rotas
* autenticação no Cloud
* autenticação no V3
* pre-menu de navegação bottom e lateral


## como iniciar um novo projeto
* criar o novo projeto:  flutter create -org com.storeware meuprojeto
* copiar a pasta lib do template para o lib do novo projeto
* ajustar o pubspec.yaml com as dependências do template
* fim

#Organização
\routing.dart -> rotas de navegação
\theming.dart -> criação de themas customizados
\injects_build.dart -> injetar dependências
\firebase_adpater.dart -> compatibilidade windows/android/linux e macos

\views -> estrutura de navegação nas paginas 
\config -> configurações e constantes do projeto
\models -> estrutura de dados  e modelo de negócios
\wingets -> componentes utilizados

# organização \views
\views\home\home_view.dart -> pagina de entrada
\views\home\home_menu.dart -> menu da pagina de entrada

\login\login_view.dart -> pagina de login

\painel\painel_view.dart -> modelo de exemplo para uma entrada no painel (somente para ter navegação no template - poderá ser sbustituido para o desejado

\views\pedidos\pedidos_view.dart -> exemplo herdado de outro projeto e agregado ao novo projeto - substsiuir para o desejado ou descartar o exemplo.


# detalhes técnicos
* algumas dependências estão associadas a projetos "private", será necessário solicitar liberação desses projetos para uso.
