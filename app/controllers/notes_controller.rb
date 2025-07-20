# app/controllers/notes_controller.rb
class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[show destroy delete_file]

  def index
    @departments = Department.all
    @subjects = Subject.all
    @semesters = (1..8).to_a
    @q = current_user.notes.includes(:department, :subject, :user).ransack(params[:q])
    @notes = @q.result(distinct: true)
    @notes = @notes.where(department_id: params[:department_id]) if params[:department_id].present?
    @notes = @notes.where(subject_id: params[:subject_id]) if params[:subject_id].present?
    @notes = @notes.where(semester: params[:semester]) if params[:semester].present?
    @notes = @notes.page(params[:page]).per(10)
  end

  def new
    @note = Note.new
  end

  def show
    @note = Note.find(params[:id])
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to notes_path, notice: 'Note created successfully.'
    else
      render :new
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if note_params[:files].present?
      @note.files.purge # Remove all existing files
    end
    if @note.update(note_params)
      redirect_to note_path(@note), notice: 'Note updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @note.files.each(&:purge) # Remove all attached files
    @note.destroy
    redirect_to notes_path, notice: "Note was successfully deleted."
  end

  def delete_file
    file = ActiveStorage::Attachment.find(params[:file_id])
    file.purge
    redirect_to notes_path, notice: 'File deleted.'
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :description, :semester, :department_id, :subject_id, files: [])
  end
end
