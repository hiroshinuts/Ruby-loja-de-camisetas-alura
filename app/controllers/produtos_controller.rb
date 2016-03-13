class ProdutosController < ApplicationController

	before_action :set_produto, only: [:edit, :update, :destroy]

	def index
		@produtos_por_nome = Produto.order(:nome).limit 5
		@produtos_por_preco = Produto.order(:preco).limit 2
	end

	def new
		@produto = Produto.new
		renderiza :new
	end

	def create
		@produto = Produto.new produto_params
		@departamentos = Departamento.all
		if @produto.save
			flash[:notice] = "Produto salvo com sucesso"
			redirect_to root_url
		else
			renderiza :new

		end
	end

	def edit
		renderiza :edit
	end

	def update
		if @produto.update produto_params
			flash[:notice] = "Produto atualizado com sucesso!" # dando certo aparecer a mensagem
			redirect_to root_url #volta para pagina inicial
		else
			renderiza :edit
		end
	end


	def destroy
		@produto.destroy
		redirect_to root_url
	end	

	def busca
		@nome_a_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"
		
	end

	private

	def renderiza(view)
		@departamentos = Departamento.all
		render view
		
	end

	def set_produto
		id = params[:id] #busca o parametro "id"
		@produto = Produto.find(id) #procura o produto
	end

	def produto_params
		params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id # igual o metodo create
	end

end
