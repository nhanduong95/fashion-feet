using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdminSide
{
    public partial class DataManagement : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProdGridView.PageIndex = Convert.ToInt32(Session["prodTablePageNum"]);
                CateGridView.PageIndex = Convert.ToInt32(Session["cateTablePageNum"]);
                this.PopulateCateData();
                this.PopulateCateDropDownList();
                this.PopulateProdData();
            }
                
        }
        protected void DisableAllInsertValidation(object sender, EventArgs e)
        {
            InsertCateIdRequireValidator.Enabled = false;
            InsertCateNameRequireValidator.Enabled = false;
            InsertCateIdSyntaxValidator.Enabled = false;
            InsertCateDesRequireVaidator.Enabled = false;
            InsertCateImageUrlRequireVaidator.Enabled = false;
            InsertCateImageUrlSyntaxValidator.Enabled = false;
            InsertProdIdRequireValidator.Enabled = false;
            InsertProdNameRequireValidator.Enabled = false;
            InsertProdNameSyntaxValidator.Enabled = false;
            InsertProdCateIdRequireValidator.Enabled = false;
            InsertProdPriceRequireValidator.Enabled = false;
            InsertProdPriceSyntaxValidator.Enabled = false;
            InsertProd36QuanRequireValidator.Enabled = false;
            InsertProd36SizeQuanCompareValidator.Enabled = false;
            InsertProd37QuanRequireValidator.Enabled = false;
            InsertProd37SizeQuanCompareValidator.Enabled = false;
            InsertProd38QuanRequireValidator.Enabled = false;
            InsertProd38SizeQuanCompareValidator.Enabled = false;
            InsertProd39QuanRequireValidator.Enabled = false;
            InsertProd39SizeQuanCompareValidator.Enabled = false;
            InsertProdImageUrlRequireValidator.Enabled = false;
            InsertProdImageUrlSyntaxValidator.Enabled = false;
        }
        protected void DisableProdInsertValidation()
        {
            InsertProdIdRequireValidator.Enabled = false;
            InsertProdNameRequireValidator.Enabled = false;
            InsertProdNameSyntaxValidator.Enabled = false;
            InsertProdCateIdRequireValidator.Enabled = false;
            InsertProdPriceRequireValidator.Enabled = false;
            InsertProdPriceSyntaxValidator.Enabled = false;
            InsertProd36QuanRequireValidator.Enabled = false;
            InsertProd36SizeQuanCompareValidator.Enabled = false;
            InsertProd37QuanRequireValidator.Enabled = false;
            InsertProd37SizeQuanCompareValidator.Enabled = false;
            InsertProd38QuanRequireValidator.Enabled = false;
            InsertProd38SizeQuanCompareValidator.Enabled = false;
            InsertProd39QuanRequireValidator.Enabled = false;
            InsertProd39SizeQuanCompareValidator.Enabled = false;
            InsertProdImageUrlRequireValidator.Enabled = false;
            InsertProdImageUrlSyntaxValidator.Enabled = false;
        }
        protected void DisableCateInsertValidation()
        {
            InsertCateIdRequireValidator.Enabled = false;
            InsertCateIdSyntaxValidator.Enabled = false;
            InsertCateNameRequireValidator.Enabled = false;
            InsertCateDesRequireVaidator.Enabled = false;
            InsertCateImageUrlRequireVaidator.Enabled = false;
            InsertCateImageUrlSyntaxValidator.Enabled = false;
        }

        private void PopulateCateData()
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
            SqlCommand cateCommand = new SqlCommand("SelectAllCates", connection);
            cateCommand.CommandType = CommandType.StoredProcedure;
            connection.Open();
            cateCommand.ExecuteNonQuery();
            SqlDataAdapter cateAdapter = new SqlDataAdapter(cateCommand);
            DataTable cateTable = new DataTable();
            cateAdapter.Fill(cateTable);
            CateGridView.DataSource = cateTable;
            CateGridView.DataBind();
            connection.Close();
        }
        protected void PopulateProdData()
        {
            string cateName = lblProdCate.Text;
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
            connection.Open();
            SqlCommand selectProdCommand = new SqlCommand();
            if (cateName.Equals("All Products"))
            {
                selectProdCommand.CommandText = "SelectAllProds";
                selectProdCommand.Connection = connection;
                selectProdCommand.CommandType = CommandType.StoredProcedure;
                //Response.Write("<script>alert('All Product.'); window.location.href = '/DataManagement'</script>");
            }
            else
            {
                SqlCommand selectCateIdCommand = new SqlCommand("SelectCateIdByCateName", connection);
                selectCateIdCommand.CommandType = CommandType.StoredProcedure;
                selectCateIdCommand.Parameters.AddWithValue("@CateName", cateName);
                SqlDataReader reader = selectCateIdCommand.ExecuteReader();
                while (reader.Read())
                {
                    string cateId = reader["CateId"].ToString();
                    selectProdCommand.CommandText = "SelectAllCateProds";
                    selectProdCommand.Connection = connection;
                    selectProdCommand.CommandType = CommandType.StoredProcedure;
                    selectProdCommand.Parameters.AddWithValue("@CateId", cateId);
                }
                reader.Close();
                //Response.Write("<script>alert('Not All Product.'); window.location.href = '/DataManagement'</script>");
            }
            selectProdCommand.ExecuteNonQuery();
            SqlDataAdapter prodAdapter = new SqlDataAdapter(selectProdCommand);
            DataTable prodTable = new DataTable();
            prodAdapter.Fill(prodTable);
            ProdGridView.DataSource = prodTable;
            ProdGridView.DataBind();
            connection.Close();
        }
        private void PopulateCateDropDownList()
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
            SqlCommand cateCommand = new SqlCommand("SelectAllCateNames", connection);
            cateCommand.CommandType = CommandType.StoredProcedure;
            connection.Open();
            CateDropDownList.DataSource = cateCommand.ExecuteReader();
            CateDropDownList.DataTextField = "CateName";
            CateDropDownList.DataValueField = "CateName";
            CateDropDownList.DataBind();
            connection.Close();
            CateDropDownList.Items.Insert(0, new ListItem("All Products", "All"));
        }        
        protected void ShowProd(object sender, EventArgs e)
        {
            lblProdCate.Text = CateDropDownList.SelectedItem.Text;
            this.PopulateProdData();
        }

        protected void InsertCate(object sender, EventArgs e)
        {
            this.DisableProdInsertValidation();
            Page.Validate();
            if(Page.IsValid == false)
                Response.Write("<script>alert('Please check the input again.')</script>");
            else
            {
                string cateId = txtInsertCateId.Text;
                string cateName = txtInsertCateName.Text;
                string cateDes = txtInsertCateDes.Text;
                string cateImageUrl = txtInsertCateImageUrl.Text;
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
                connection.Open();
                SqlCommand selectCateIdCommand = new SqlCommand("SelectAllCateIds", connection);
                SqlDataReader reader = selectCateIdCommand.ExecuteReader();
                int validIdTag = 1;

                while (reader.Read() && (validIdTag == 1))
                {
                    if (reader["CateId"].Equals(cateId))
                    {
                        validIdTag = 0;
                        Response.Write("<script>alert('Duplicate ID. Please enter again.')</script>");
                    }
                }
                reader.Close();
                if (validIdTag == 1)
                {
                    SqlCommand insertCateCommand = new SqlCommand("InsertCate", connection);
                    insertCateCommand.CommandType = CommandType.StoredProcedure;
                    insertCateCommand.Parameters.AddWithValue("@CateId", cateId);
                    insertCateCommand.Parameters.AddWithValue("@CateName", cateName);
                    insertCateCommand.Parameters.AddWithValue("@CateDes", cateDes);
                    insertCateCommand.Parameters.AddWithValue("@CateImageUrl", cateImageUrl);
                    insertCateCommand.ExecuteNonQuery();
                    connection.Close();
                    CateGridView.PageIndex = Convert.ToInt32(Session["cateTablePageNum"]);
                    this.PopulateCateData();
                    this.PopulateCateDropDownList();
                }
            }
            
        }
        protected void InsertProd(object sender, EventArgs e)
        {
            DisableCateInsertValidation();
            Page.Validate();
            if(Page.IsValid == false)
                Response.Write("<script>alert('Please check the input again.')</script>");
            else
            {
                string prodId = txtInsertProdId.Text;
                string prodName = txtInsertProdName.Text;
                string prodCateId = txtInsertProdCateId.Text;
                decimal prodPrice = Convert.ToDecimal(txtInsertProdPrice.Text);
                int prodSize36Quan = Convert.ToInt16(txtInsertProdSize36Quan.Text);
                int prodSize37Quan = Convert.ToInt16(txtInsertProdSize37Quan.Text);
                int prodSize38Quan = Convert.ToInt16(txtInsertProdSize38Quan.Text);
                int prodSize39Quan = Convert.ToInt16(txtInsertProdSize39Quan.Text);
                string prodImageUrl = txtInsertProdImageUrl.Text;

                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                    ["DBFileConnection"].ConnectionString);
                connection.Open();
                SqlCommand selectProdIdCommand = new SqlCommand("SelectAllProdIds", connection);
                SqlCommand selectCateIdCommand = new SqlCommand("SelectAllCateIds", connection);
                SqlDataReader prodIdReader = selectProdIdCommand.ExecuteReader();
                int validProdIdTag = 1;
                while (prodIdReader.Read() && validProdIdTag == 1)
                {
                    if (prodIdReader["ProdId"].Equals(prodId))
                    {
                        validProdIdTag = 0;
                        Response.Write("<script>alert('Duplicate ID. Please enter again.')</script>");
                    }
                }
                prodIdReader.Close();
                SqlDataReader cateIdReader = selectCateIdCommand.ExecuteReader();
                int validCateIdTag = 0;
                while (cateIdReader.Read() && validCateIdTag == 0)
                {
                    if (cateIdReader["CateId"].Equals(prodCateId))
                        validCateIdTag = 1;
                }
                cateIdReader.Close();
                if (validProdIdTag == 1 && validCateIdTag == 1)
                {
                    SqlCommand insertProdCommand = new SqlCommand("InsertProd", connection);
                    insertProdCommand.CommandType = CommandType.StoredProcedure;
                    insertProdCommand.Parameters.AddWithValue("@ProdId", prodId);
                    insertProdCommand.Parameters.AddWithValue("@ProdName", prodName);
                    insertProdCommand.Parameters.AddWithValue("@CateId", prodCateId);
                    insertProdCommand.Parameters.AddWithValue("@ProdPrice", prodPrice);
                    insertProdCommand.Parameters.AddWithValue("@ProdSize36Quan", prodSize36Quan);
                    insertProdCommand.Parameters.AddWithValue("@ProdSize37Quan", prodSize37Quan);
                    insertProdCommand.Parameters.AddWithValue("@ProdSize38Quan", prodSize38Quan);
                    insertProdCommand.Parameters.AddWithValue("@ProdSize39Quan", prodSize39Quan);
                    insertProdCommand.Parameters.AddWithValue("@ProdImageUrl", prodImageUrl);
                    insertProdCommand.ExecuteNonQuery();
                    connection.Close();
                    ProdGridView.PageIndex = Convert.ToInt32(Session["prodTablePageNum"]);
                    this.PopulateProdData();
                }
                if (validCateIdTag == 0)
                    Response.Write("<script>alert('Product Category is not found. Please check again.')</script>");
            }
        }

        protected void CateDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string cateId = (CateGridView.DataKeys[e.RowIndex].Values[0]).ToString();
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
               ["DBFileConnection"].ConnectionString);
            SqlCommand command = new SqlCommand("DeleteCate", connection);
            command.Parameters.AddWithValue("@CateId", cateId);
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            CateGridView.PageIndex = Convert.ToInt32(Session["cateTablePageNum"]);
            PopulateCateData();
            PopulateProdData();
            PopulateCateDropDownList();
        }
        protected void ProdDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string prodId = (ProdGridView.DataKeys[e.RowIndex].Values[0].ToString());
            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
            SqlCommand command = new SqlCommand("DeleteProd", connection);
            command.Parameters.AddWithValue("@ProdId", prodId);
            command.CommandType = CommandType.StoredProcedure;
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            ProdGridView.PageIndex = Convert.ToInt32(Session["prodTablePageNum"]);
            this.PopulateProdData();
        }

        protected void CateEditing(object sender, GridViewEditEventArgs e)
        {
            CateGridView.EditIndex = e.NewEditIndex;
            this.PopulateCateData();
        }
        protected void ProdEditing(object sender, GridViewEditEventArgs e)
        {
            ProdGridView.EditIndex = e.NewEditIndex;
            this.PopulateProdData();
        }
        protected void CateCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            CateGridView.EditIndex = -1;
            this.PopulateCateData();
        }
        protected void ProdCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            ProdGridView.EditIndex = -1;
            this.PopulateProdData();
        }

        protected void CateUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate();
            if (Page.IsValid == false)
                Response.Write("<script>alert('Please enter Category Name.')</script>");
            else
            {
                string cateId = CateGridView.DataKeys[e.RowIndex].Values[0].ToString();
                string cateName = (CateGridView.Rows[e.RowIndex].FindControl("txtUpdateCateName") as TextBox).Text;
                string cateDes = (CateGridView.Rows[e.RowIndex].FindControl("txtUpdateCateDes") as TextBox).Text;
                string cateImageUrl = (CateGridView.Rows[e.RowIndex].FindControl("txtUpdateCateImageUrl") as TextBox).Text;
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                ["DBFileConnection"].ConnectionString);
                SqlCommand command = new SqlCommand("UpdateCate", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@CateId", cateId);
                command.Parameters.AddWithValue("@CateName", cateName);
                command.Parameters.AddWithValue("@CateDes", cateDes);
                command.Parameters.AddWithValue("@CateImageUrl", cateImageUrl);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                CateGridView.PageIndex = Convert.ToInt32(Session["cateTablePageNum"]);
                this.PopulateCateData();
                this.PopulateCateDropDownList();
                Response.Redirect("/DataManagement");
            }
        }
        protected void ProdUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate();
            if (Page.IsValid == false)
                Response.Write("<script>alert('Please check the input again.')</script>");
            else
            {
                string prodId = ProdGridView.DataKeys[e.RowIndex].Values[0].ToString();
                string prodName = (ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdName") as TextBox).Text;
                string prodCateId = (ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdCateId") as TextBox).Text;
                decimal prodPrice = Convert.ToDecimal((ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdPrice") as TextBox).Text);
                int prodSize36Quan = Convert.ToInt16((ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdSize36Quan") as TextBox).Text);
                int prodSize37Quan = Convert.ToInt16((ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdSize37Quan") as TextBox).Text);
                int prodSize38Quan = Convert.ToInt16((ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdSize38Quan") as TextBox).Text);
                int prodSize39Quan = Convert.ToInt16((ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdSize39Quan") as TextBox).Text);
                string prodImageUrl = (ProdGridView.Rows[e.RowIndex].FindControl("txtUpdateProdImageUrl") as TextBox).Text;
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings
                    ["DBFileConnection"].ConnectionString);
                connection.Open();
                SqlCommand selectCateIdCommand = new SqlCommand("SelectAllCateIds", connection);
                selectCateIdCommand.CommandType = CommandType.StoredProcedure;
                SqlDataReader reader = selectCateIdCommand.ExecuteReader();
                int validCateIdTag = 0;
                while (reader.Read())
                {
                    if (reader["CateId"].Equals(prodCateId))
                        validCateIdTag = 1;
                }
                reader.Close();
                if (validCateIdTag == 1)
                {
                    SqlCommand updateProdCommand = new SqlCommand("UpdateProd", connection);
                    updateProdCommand.CommandType = CommandType.StoredProcedure;
                    updateProdCommand.Parameters.AddWithValue("@ProdId", prodId);
                    updateProdCommand.Parameters.AddWithValue("@ProdName", prodName);
                    updateProdCommand.Parameters.AddWithValue("@CateId", prodCateId);
                    updateProdCommand.Parameters.AddWithValue("@ProdPrice", prodPrice);
                    updateProdCommand.Parameters.AddWithValue("@ProdSize36Quan", prodSize36Quan);
                    updateProdCommand.Parameters.AddWithValue("@ProdSize37Quan", prodSize37Quan);
                    updateProdCommand.Parameters.AddWithValue("@ProdSize38Quan", prodSize38Quan);
                    updateProdCommand.Parameters.AddWithValue("@ProdSize39Quan", prodSize39Quan);
                    updateProdCommand.Parameters.AddWithValue("@ProdImageUrl", prodImageUrl);
                    updateProdCommand.ExecuteNonQuery();
                }
                if (validCateIdTag == 0)
                    Response.Write("<script>alert('Product Category is not found. Please check again.')</script>");
                connection.Close();
                ProdGridView.PageIndex = Convert.ToInt32(Session["prodTablePageNum"]);
                PopulateProdData();
                Response.Redirect("/DataManagement");
            }
        }
        protected void CateIndexChanging(object sender, GridViewPageEventArgs e)
        {
            CateGridView.PageIndex = e.NewPageIndex;
            Session["cateTablePageNum"] = CateGridView.PageIndex;
            this.PopulateCateData();
        } 
        protected void ProdIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ProdGridView.PageIndex = e.NewPageIndex;
            Session["prodTablePageNum"] = ProdGridView.PageIndex;
            this.PopulateProdData();
        }
    }
}