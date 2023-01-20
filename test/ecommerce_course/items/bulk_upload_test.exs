defmodule EcommerceCourse.Items.BulkUploadTest do
  use ExUnit.Case
  use Mimic

  alias EcommerceCourse.Items.BulkUpload

  describe "bulk_upload/1" do
    test "bulk_upload with fake result" do
      BulkUpload
      |> stub(:bulk_upload, fn _file_path -> :stub end)
      |> expect(:bulk_upload, fn _file_path -> {:ok, "File processed"} end)

      assert BulkUpload.bulk_upload("Valid path")
    end
  end
end
