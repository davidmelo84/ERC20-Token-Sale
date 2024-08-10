Descrição
O contrato inteligente TokenSale é uma implementação básica de um sistema de venda de tokens no Ethereum, permitindo a compra de tokens ERC20 com Ether. Ele oferece um mecanismo para comprar tokens, gerenciar a autorização de transações através de assinaturas digitais, e permite a retirada segura de Ethers acumulados no contrato.

Funcionalidades Principais
Compra de Tokens: Os usuários podem comprar tokens ERC20 enviando Ether para o contrato. A quantidade de tokens comprados é calculada com base no preço do token definido no contrato.
Autorização de Transações: Utiliza assinaturas digitais para verificar a autenticidade das transações. Isso garante que apenas transações autorizadas possam ser processadas, aumentando a segurança.
Gestão de Autorização: O proprietário do contrato pode definir uma nova chave pública autorizada para assinar transações, permitindo flexibilidade na gestão de permissões.
Retirada de Ethers: Somente o proprietário do contrato pode retirar Ethers acumulados, assegurando que os fundos sejam gerenciados de forma segura.
Fluxo de Trabalho
Implantação:

Implante o contrato TokenSale no Ethereum, fornecendo o endereço do contrato ERC20 e a chave pública autorizada no construtor.
Compra de Tokens:

Os usuários enviam Ether e uma assinatura digital para o contrato para comprar tokens. O contrato verifica a assinatura e transfere os tokens para o comprador, devolvendo qualquer Ether excedente.
Gerenciamento de Assinaturas:

O proprietário pode atualizar a chave pública autorizada a qualquer momento para ajustar quem pode assinar transações.
Retirada de Fundos:

O proprietário pode retirar Ethers acumulados no contrato chamando a função de retirada.
Segurança
Assinaturas Digitais: Garantem que apenas transações autorizadas sejam processadas.
Controle de Acesso: Apenas o proprietário pode alterar a chave autorizada e retirar Ethers.
Exceções e Verificações: Inclui verificações rigorosas para garantir a segurança e precisão das transações.
Este contrato serve como um exemplo de como implementar um sistema de venda de tokens com segurança e flexibilidade, utilizando práticas recomendadas para a gestão de permissões e fundos.

