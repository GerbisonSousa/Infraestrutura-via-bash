#!/bin/bash

echo "Criando os Diretórios: publico, adm, ven e sec!"

for i in publico adm ven sec; do
  mkdir $i
  echo "Diretório $i  Criado!!!"
done

echo "Criando os Grupos: ADM, VEN e SEC!"

for i in GRP_ADM GRP_VEN GRP_SEC; do
  groupadd $i
  echo "Grupo de Trabalho $i Criado!!!"
done

echo "Atribuindo os diretórios a cada grupo de trabalho!"

chown root:GRP_ADM /adm/
chown root:GRP_VEN /ven/
chown root:GRP_SEC /sec/

echo "Gerando os Usuários de cada Grupo de Trabalho!"

for i in carlos maria joao; do
  useradd $i -c "$i ADM" -m -s /bin/bash -p $(openssl passwd Senha123) -G GRP_ADM,adm
  echo "Usuário $i criado e atribuído ao grupo ADM!"
  passwd $i -e
done

for i in debora sebastiana roberto; do
  useradd $i -c "$i VEN" -m -s /bin/bash -p $(openssl passwd Senha123) -G GRP_VEN,adm
  echo "Usuário $i criado e atribuído ao grupo VEN!"
  passwd $i -e
done

for i in josefina amanda rogerio; do
  useradd $i -c "$i SEC" -m -s /bin/bash -p $(openssl passwd Senha123) -G GRP_SEC,adm
  echo "Usuário $i criado e atribuído ao grupo SEC!"
  passwd $i -e
done

echo "Atribuindo permissões dos usuários dentro de cada diretórios!"

chmod 777 /publico/

for i in adm ven sec; do
  chmod 770 /$i/
  echo "----- Permissões do Dono, Grupo $i e Demais atribuídas! -----"
done

echo "Tarefa realizada com Sucesso! Processo Finalizado!!!"
