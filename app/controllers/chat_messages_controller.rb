class ChatMessagesController < ApplicationController
  before_action :set_chat_message, only: %i[ show edit update destroy ]

  # GET /chat_messages or /chat_messages.json
  def index
    @chat_messages = ChatMessage.all
  end

  # GET /chat_messages/1 or /chat_messages/1.json
  def show
  end

  # GET /chat_messages/new
  def new
    @chat_message = ChatMessage.new
  end

  # GET /chat_messages/1/edit
  def edit
  end

  # POST /chat_messages or /chat_messages.json
  def create
    @chat_message = ChatMessage.new(chat_message_params)

    respond_to do |format|
      if @chat_message.save
        ProcessMessageJob.perform_later(id=@chat_message.id)
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace(:chat_message_form, partial: "form", locals: { chat_message: ChatMessage.new })
        ]}
        format.html { render partial: "form", locals: { chat_message: ChatMessage.new } }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(:chat_message_form, partial: "form", locals: { chat_message: @chat_message }) }
      end
    end
  end

  # PATCH/PUT /chat_messages/1 or /chat_messages/1.json
  def update
    respond_to do |format|
      if @chat_message.update(chat_message_params)
        format.turbo_stream
        format.html { redirect_to @chat_message, notice: "Chat message was successfully updated." }
        format.json { render :show, status: :ok, location: @chat_message }
      else
        format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_messages/1 or /chat_messages/1.json
  def destroy
    @chat_message.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to chat_messages_path, status: :see_other, notice: "Chat message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_message
      @chat_message = ChatMessage.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def chat_message_params
      params.expect(chat_message: [ :prompt, :response ])
    end
end
