<%@ Page Title="Admin Page" Language="C#" MasterPageFile="/Site.Master" AutoEventWireup="true" 
    CodeBehind="DataManagement.aspx.cs" Inherits="AdminSide.DataManagement" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="row">
        <div class="panel panel-custom">
            <div class="panel-heading cate-panel-heading-custom">
                <div class="row">
                    <div class="col-sm-11">
                        <h3 class="panel-title panel-title-custom">
                            Category Management
                        </h3>
                    </div>
                    <div class="col-sm-1">
                        <a class="panel-title panel-title-custom panel-icon-style-03" id="CateTableShow">
                            <i class='fa fa-arrow-circle-down fa-lg'></i> 
                        </a>
                        <a class="panel-title panel-title-custom panel-icon-style-03" id="CateTableHide">
                            <i class='fa fa-arrow-circle-up fa-lg'></i> 
                        </a>
                    </div>
                </div>   
            </div>
            <div class="panel-body" id="ManaCateTable">
                <asp:GridView ID="CateGridView" runat="server" AutoGenerateColumns="false" CellPadding="4" 
                    DataKeyNames="CateId" ForeColor="#333333" GridLines="none" Width="100%"
                    AllowPaging="true" PageSize="5"
                    HeaderStyle-CssClass="header-table" RowStyle-CssClass="cate-row-table" 
                    OnRowDeleting="CateDeleting" OnRowEditing="CateEditing" 
                    OnRowUpdating="CateUpdating" OnPageIndexChanging="CateIndexChanging"
                    OnRowCancelingEdit="CateCancelingEdit">

                    <Columns>
                        <asp:BoundField DataField="CateId" HeaderText="Id"
                        ReadOnly="True" SortExpression="CateId" />

                        <asp:TemplateField HeaderText="Name" SortExpression="CateName">
                            <ItemTemplate>
                                <asp:Label ID="lblCateName" runat="server" CssClass="col-md-10 col-md-offset-1" Text='<%# Eval("CateName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateCateName" runat="server" CssClass="col-md-11 col-md-offset-1"
                                    Text='<%# Eval("CateName") %>'></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateCateNameRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateCateName"
                                    ErrorMessage="*Required"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message col-md-11 col-md-offset-1">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Description" SortExpression="CateDes">
                            <ItemTemplate>
                                <asp:Label ID="lblCateDes" runat="server" Text='<%# Eval("CateDes") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateCateDes" TextMode="MultiLine" runat="server" CssClass="col-md-10 col-md-offset-1"
                                    Text='<%# Eval("CateDes") %>'></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateCateDesRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateCateDes"
                                    ErrorMessage="*Required"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message col-md-10 col-md-offset-1">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Image Url" SortExpression="CateImageUrl">
                            <ItemTemplate>
                                <asp:Label ID="lblCateImageUrl" runat="server" CssClass="col-md-10"
                                    Text='<%# Eval("CateImageUrl") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateCateImageUrl" runat="server" CssClass="col-md-11"
                                    Text='<%# Eval("CateImageUrl") %>'></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateCateImageUrlRequireValidator" runat="server" 
                                    ControlToValidate="txtUpdateCateImageUrl"
                                    ErrorMessage="*Required"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message col-md-11">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="UpdateCateImageUrlSyntaxValidator" runat="server" 
                                    ControlToValidate="txtUpdateCateImageUrl"
                                    ValidationExpression="^(\/Images\/+\w+\.(?>=gif|png|jpg|jpeg))"
                                    ValidationGroup="ProdValidationControls"
                                    ErrorMessage="URL syntax: /Images/imageName.imageExtension"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message col-md-11">
                                </asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Edit">                                
                            <ItemTemplate>
                                <asp:LinkButton ID="btnCateEdit" runat="server" 
                                    Text="<i class='fa fa-pencil-square-o fa-2x'></i>" 
                                    CommandName="Edit" CssClass="btn edit-btn" ToolTip="Edit"
                                    CausesValidation="false" OnClick="DisableAllInsertValidation"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnCateUpdate" runat="server" Text="<i class='fa fa-check'></i>" 
                                    CommandName="Update"  CssClass="btn save-btn save-btn-custom" ToolTip="Save"
                                    CausesValidation="false" OnClick="DisableAllInsertValidation" Width="28"/>
                                <asp:LinkButton ID="btnCateCancel" runat="server" Text="<i class='fa fa-remove'></i>" 
                                    CommandName="Cancel"  CssClass="btn cancel-btn cancel-btn-custom" ToolTip="Cancel"
                                    CausesValidation="False" OnClick="DisableAllInsertValidation" Width="28"/>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Delete">                                
                            <ItemTemplate>
                                <asp:LinkButton ID="btnCateDelete" runat="server" Text="<i class='fa fa-trash fa-2x'></i>" 
                                    CommandName="Delete" CssClass="btn delete-btn" ToolTip="Delete"
                                    CausesValidation="False"/>
                            </ItemTemplate>
                            <EditItemTemplate></EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EditRowStyle BackColor="#EDECD0"/>
                    <AlternatingRowStyle BackColor="#F2F6FC" />
                    <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" HorizontalAlign="Center" />
                    <PagerStyle BackColor="White" HorizontalAlign="Center" CssClass="gridview-pager-custom"/>
                    <RowStyle BackColor="White" ForeColor="#333333" HorizontalAlign="Center"/>
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </div>            
    </div>
    <div class="row">
        <div class="panel panel-custom">
            <div class="panel-heading prod-panel-heading-custom">
                <div class="row">
                    <div class="col-sm-11">
                        <h3 class="panel-title panel-title-custom">
                            Product Management
                        </h3>
                         <asp:Label ID="lblProdCate" runat="server" Text="All Products" CssClass="product-type"></asp:Label>
                    </div>
                    <div class="col-sm-1">
                        <a class="panel-title panel-title-custom panel-icon-style-04" id="ProdTableShow">
                            <i class='fa fa-arrow-circle-down fa-lg'></i> 
                        </a>
                        <a class="panel-title panel-title-custom panel-icon-style-04" id="ProdTableHide">
                            <i class='fa fa-arrow-circle-up fa-lg'></i> 
                        </a>
                    </div>
                </div>               
            </div>
            <div class="panel-body" id="ManaProdTable">
                <div class="row">
                    <div class="col-sm-3">
                        <p>Choose a category:</p>
                        <asp:DropDownList ID="CateDropDownList" runat="server" CssClass="dropdown" Height="30"></asp:DropDownList>
                        <asp:LinkButton ID="ProdDisplayActivater" runat="server" Text="Select"
                            OnClick="ShowProd" CausesValidation="False"
                            CssClass="btn btn-primary select-btn"/>
                    </div>
                </div>
                    
                <asp:GridView ID="ProdGridView" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="ProdId" AllowPaging="true" PageSize="5"
                    ForeColor="#333333" Width="100%" GridLines="None"
                    HeaderStyle-CssClass="header-table" RowStyle-CssClass="prod-row-table" CssClass="prod-gridview-custom"
                    OnRowDeleting="ProdDeleting" OnRowEditing="ProdEditing" 
                    OnRowUpdating="ProdUpdating" OnPageIndexChanging="ProdIndexChanging"
                    OnRowCancelingEdit="ProdCancelingEdit">
                    <Columns>
                        <asp:BoundField DataField="ProdId" HeaderText="Id" 
                            ReadOnly="True" SortExpression="ProdId"/>

                        <asp:TemplateField HeaderText="Name" SortExpression="ProdName">
                            <ItemTemplate>
                                <asp:Label ID="lblProdName" runat="server" Text='<%# Eval("ProdName") %>'
                                    CssClass="col-sm-10 col-sm-offset-1"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdName" runat="server" 
                                    Text='<%# Eval("ProdName") %>' CssClass="col-sm-10 col-sm-offset-1"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdNameRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdName"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Type" SortExpression="CateId">
                            <ItemTemplate>
                                <asp:Label ID="lblProdCateId" runat="server" Text='<%# Eval("CateId") %>'
                                    CssClass="col-sm-12"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdCateId" runat="server" 
                                    Text='<%# Eval("CateId") %>' Width="80"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdCateIdRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdCateId"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    
                        <asp:TemplateField HeaderText="Price" SortExpression="ProdPrice">
                            <ItemTemplate>
                                <asp:Label ID="lblProdPrice" runat="server" Text='<%# Eval("ProdPrice") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdPrice" runat="server" 
                                    Text='<%# Eval("ProdPrice") %>' Width="80"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdPriceRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdPrice"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="UpdateProdPriceSyntaxValidator" runat="server" 
                                    ValidationExpression="([0-9]*)+\.([0-9]{2})"
                                    ControlToValidate="txtUpdateProdPrice"
                                    ErrorMessage="Enter a double with 2 decimal digits."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Size 36 Quan" SortExpression="ProdSize36Quan">
                            <ItemTemplate>
                                <asp:Label ID="lblProdSize36Quan" runat="server" Text='<%# Eval("ProdSize36Quan") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdSize36Quan" runat="server" 
                                    Text='<%# Eval("ProdSize36Quan") %>' Width="50"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdSize36QuanRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdSize36Quan"
                                    ValidationGroup="ProdValidationControls"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="UpdateProdSize36QuanCompareValidator" runat="server" 
                                    ControlToValidate="txtUpdateProdSize36Quan"
                                    Operator="GreaterThanEqual" 
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ErrorMessage="The value must be at least 0."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Size 37 Quan" SortExpression="ProdSize37Quan">
                            <ItemTemplate>
                                <asp:Label ID="lblProdSize37Quan" runat="server" Text='<%# Eval("ProdSize37Quan") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdSize37Quan" runat="server" 
                                    Text='<%# Eval("ProdSize37Quan") %>' Width="50"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdSize37QuanRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdSize37Quan"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="UpdateProdSize37QuanCompareValidator" runat="server" 
                                    ControlToValidate="txtUpdateProdSize37Quan"
                                    ValidationGroup="ProdValidationControls"
                                    Operator="GreaterThanEqual" 
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ErrorMessage="The value must be at least 0"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Size 38 Quan" SortExpression="ProdSize38Quan">
                            <ItemTemplate>
                                <asp:Label ID="lblProdSize38Quan" runat="server" Text='<%# Eval("ProdSize38Quan") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdSize38Quan" runat="server" 
                                    Text='<%# Eval("ProdSize38Quan") %>' Width="50"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdSize38QuanRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdSize38Quan"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="UpdateProdSize38QuanCompareValidator" runat="server" 
                                    ControlToValidate="txtUpdateProdSize38Quan"
                                    Operator="GreaterThanEqual" 
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ErrorMessage="The value must be at least 0."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Size 39 Quan" SortExpression="ProdSize39Quan">
                            <ItemTemplate>
                                <asp:Label ID="lblProdSize39Quan" runat="server" 
                                    Text='<%# Eval("ProdSize39Quan") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdSize39Quan" runat="server" 
                                    Text='<%# Eval("ProdSize39Quan") %>' Width="50"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdSize39QuanRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdSize39Quan"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="UpdateProdSize39QuanValidator" runat="server" 
                                    ControlToValidate="txtUpdateProdSize39Quan"
                                    ValidationGroup="ProdValidationControls"
                                    Operator="GreaterThanEqual" 
                                    ValueToCompare="0"
                                    Type="Integer"
                                    ErrorMessage="The value must be at least 0."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Image Url" SortExpression="ProdImageUrl">
                            <ItemTemplate>
                                <asp:Label ID="lblProdImageUrl" runat="server" 
                                    Text='<%# Eval("ProdImageUrl") %>' CssClass="col-sm-12"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUpdateProdImageUrl" runat="server" 
                                    Text='<%# Eval("ProdImageUrl") %>' ></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="UpdateProdImageUrlRequireValidator" runat="server"
                                    ControlToValidate="txtUpdateProdImageUrl"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="UpdateProdImageUrlSyntaxValidator" runat="server" 
                                    ControlToValidate="txtUpdateProdImageUrl"
                                    ValidationExpression="^(\/Images\/+\w+\.(?>=gif|png|jpg|jpeg))"
                                    ValidationGroup="ProdValidationControls"
                                    ErrorMessage="URL syntax: /Images/imageName.imageExtension"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnProdEdit" runat="server" Text="<i class='fa fa-pencil-square-o fa-2x'></i>" 
                                    CommandName="Edit" CssClass="btn edit-btn" ToolTip="Edit"
                                    CausesValidation="False" OnClick="DisableAllInsertValidation"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="btnProdUpdate" runat="server" Text="<i class='fa fa-check'></i>" 
                                    CommandName="Update"  CssClass="btn save-btn" ToolTip="Save"
                                    CausesValidation="False" OnClick="DisableAllInsertValidation" Width="30"/>
                                <asp:LinkButton ID="btnProdCancel" runat="server" Text="<i class='fa fa-remove'></i>" 
                                    CommandName="Cancel"  CssClass="btn cancel-btn" ToolTip="Cancel"
                                    CausesValidation="False" OnClick="DisableAllInsertValidation" Width="30"/>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnProdDelete" runat="server" Text="<i class='fa fa-trash fa-2x'></i>" 
                                    CommandName="Delete" CssClass="btn delete-btn" ToolTip="Delete"
                                    CausesValidation="False"/>
                            </ItemTemplate>
                            <EditItemTemplate></EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EditRowStyle BackColor="#EDECD0" />
                    <AlternatingRowStyle BackColor="#F2F6FC" />
                    <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" HorizontalAlign="Center" />
                    <PagerStyle BackColor="White" HorizontalAlign="Center" CssClass="gridview-pager-custom" Height="50"/>
                    <RowStyle BackColor="White" ForeColor="#333333" HorizontalAlign="Center" Height="60"/>
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-custom">
                <div class="panel-heading cate-panel-heading-custom">
                    <div class="row">
                        <div class="col-sm-10">
                        <h3 class="panel-title panel-title-custom">
                            Create New Category
                        </h3>
                    </div>
                        <div class="col-sm-1">
                            <a class="panel-title panel-title-custom panel-icon-style-01" id="CateFormShow">
                                <i class='fa fa-arrow-circle-down fa-lg'></i> 
                            </a>
                        </div>
                        <div class="col-sm-1">
                            <a class="panel-title panel-title-custom panel-icon-style-01" id="CateFormHide">
                                <i class='fa fa-arrow-circle-up fa-lg'></i> 
                            </a>
                        </div>
                    </div>
                </div>
                <div class="panel-body" id="CreateCateForm">
                    <div class="form-horizontal">
                        <div class="row form-group"> 
                            <div class="col-sm-6">
                                <label class="control-label">ID</label><br />
                                <asp:TextBox ID="txtInsertCateId" runat="server" Width="100%"/><br />
                                <asp:RequiredFieldValidator ID="InsertCateIdRequireValidator" runat="server"
                                    ControlToValidate="txtInsertCateId"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="InsertCateIdSyntaxValidator" runat="server" 
                                    ControlToValidate="txtInsertCateId"
                                    ValidationExpression="^CATE[0-9]{2,}"
                                    ErrorMessage="ID syntax inludes CATE and at least 2 digits"
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RegularExpressionValidator>
                            </div>                          
                            <div class="col-sm-6">
                                <label class="control-label">Name</label><br />
                                <asp:TextBox ID="txtInsertCateName" runat="server" Width="100%"/><br />
                                <asp:RequiredFieldValidator ID="InsertCateNameRequireValidator" runat="server"
                                    ControlToValidate="txtInsertCateName"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-12">
                                <label class="control-label">Description</label><br />
                                <asp:TextBox ID="txtInsertCateDes" TextMode="MultiLine" runat="server" Width="100%"/><br />
                                <asp:RequiredFieldValidator ID="InsertCateDesRequireVaidator" runat="server"
                                    ControlToValidate="txtInsertCateDes"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>                            
                        </div>
                        <div class="row form-group">                      
                            <div class="col-sm-12">
                                <label class="control-label">Image Url</label><br />
                                <asp:TextBox ID="txtInsertCateImageUrl" runat="server" Width="100%"/><br />
                                <asp:RequiredFieldValidator ID="InsertCateImageUrlRequireVaidator" runat="server"
                                    ControlToValidate="txtInsertCateImageUrl"
                                    ErrorMessage="*This field is required."
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="InsertCateImageUrlSyntaxValidator" runat="server" 
                                    ControlToValidate="txtInsertCateImageUrl"
                                    ValidationExpression="^(\/Images\/+\w+\.(?>=gif|png|jpg|jpeg))"
                                    ValidationGroup="ProdValidationControls"
                                    ErrorMessage="URL syntax: /Images/imageName.imageExtension"
                                    ForeColor="Firebrick"
                                    Display="Dynamic"
                                    CssClass="error-message">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-3 col-sm-offset-8">
                                <asp:LinkButton ID="insertCateBtn" runat="server" 
                                    OnClick="InsertCate" CausesValidation="false"
                                    Text="Create" CssClass="btn btn-primary cate-create-btn"/>
                            </div>
                        </div>                       
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="panel panel-custom">
                <div class="panel-heading prod-panel-heading-custom">
                    <div class="row">
                        <div class="col-sm-10">
                        <h3 class="panel-title panel-title-custom">
                            Create New Product
                        </h3>
                    </div>
                        <div class="col-sm-2 text-right">
                            <a class="panel-title panel-title-custom panel-icon-style-02" id="ProdFormShow">
                                <i class='fa fa-arrow-circle-down fa-lg'></i> 
                            </a>
                            <a class="panel-title panel-title-custom panel-icon-style-02" id="ProdFormHide">
                                <i class='fa fa-arrow-circle-up fa-lg'></i> 
                            </a>
                        </div>
                    </div>
                </div>
                <div class="panel-body" id="CreateProdForm">
                    <div class="row form-group">
                        <div class="col-sm-4">
                            <label class="control-label">ID</label><br/>
                            <asp:TextBox ID="txtInsertProdId" runat="server" Width="100%"/><br />
                                <asp:RequiredFieldValidator ID="InsertProdIdRequireValidator" runat="server"
                                    ControlToValidate="txtInsertProdId"
                                    ErrorMessage="*Required."
                                    ForeColor="Firebrick"
                                    CssClass="error-message"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="InsertProdNameSyntaxValidator" runat="server" 
                                ControlToValidate="txtInsertProdId"
                                ValidationExpression="^[a-zA-Z]{2,}[0-9]{2,}"
                                ErrorMessage="ID syntax inludes at least 2 letters and 2 digits."
                                ForeColor="Firebrick"
                                CssClass="error-message"
                                Display="Dynamic">
                            </asp:RegularExpressionValidator>
                                    
                        </div>
                        <div class="col-sm-8">
                            <label class="control-label">Name</label><br />
                            <asp:TextBox ID="txtInsertProdName" runat="server" Width="100%"/><br />
                            <asp:RequiredFieldValidator ID="InsertProdNameRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdName"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                CssClass="error-message"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>    
                    <div class="row form-group">
                        <div class="col-sm-4">
                            <label class="control-label">Type</label>
                            <asp:TextBox ID="txtInsertProdCateId" runat="server" Width="100%"/><br />
                            <asp:RequiredFieldValidator ID="InsertProdCateIdRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdCateId"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="col-sm-4">
                            <label class="control-label">Price</label><br />
                            <asp:TextBox ID="txtInsertProdPrice" runat="server" Width="100%"/><br />
                            <asp:RequiredFieldValidator ID="InsertProdPriceRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdPrice"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="InsertProdPriceSyntaxValidator" runat="server" 
                                ValidationExpression="([0-9]*)+\.([0-9]{2})"
                                ControlToValidate="txtInsertProdPrice"
                                ErrorMessage="Enter a double with 2 decimal digits."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-sm-4">
                            <label class="control-label">Image Url</label><br />
                            <asp:TextBox ID="txtInsertProdImageUrl" runat="server" Width="100%"/><br />
                            <asp:RequiredFieldValidator ID="InsertProdImageUrlRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdImageUrl"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="InsertProdImageUrlSyntaxValidator" runat="server" 
                                ValidationExpression="^(\/Images\/+\w+\.(?>=gif|png|jpg|jpeg))"
                                ControlToValidate="txtInsertProdImageUrl"
                                ErrorMessage="Url syntax: /Images/imageName.fileExtension"
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RegularExpressionValidator>
                        </div>
                    </div>    
                    <div class="row form-group">
                        <div class="col-sm-3">
                            <label class="control-label">Size 36 Quantity</label><br />
                            <asp:TextBox ID="txtInsertProdSize36Quan" runat="server" Width="100%"/><br />            
                            <asp:RequiredFieldValidator ID="InsertProd36QuanRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdSize36Quan"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="InsertProd36SizeQuanCompareValidator" runat="server" 
                                ControlToValidate="txtInsertProdSize36Quan"
                                Operator="GreaterThanEqual" 
                                ValueToCompare="0"
                                Type="Integer"
                                ErrorMessage="The value must be at least 0."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:CompareValidator>
                        </div>
                        <div class="col-sm-3">
                            <label class="control-label">Size 37 Quantity</label><br />
                            <asp:TextBox ID="txtInsertProdSize37Quan" runat="server" Width="100%"/><br />            
                            <asp:RequiredFieldValidator ID="InsertProd37QuanRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdSize37Quan"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="InsertProd37SizeQuanCompareValidator" runat="server" 
                                ControlToValidate="txtInsertProdSize37Quan"
                                Operator="GreaterThanEqual" 
                                ValueToCompare="0"
                                Type="Integer"
                                ErrorMessage="The value must be at least 0."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:CompareValidator>
                        </div>
                        <div class="col-sm-3">
                            <label class="control-label">Size 38 Quantity</label><br />
                            <asp:TextBox ID="txtInsertProdSize38Quan" runat="server" Width="100%"/><br />            
                            <asp:RequiredFieldValidator ID="InsertProd38QuanRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdSize38Quan"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="InsertProd38SizeQuanCompareValidator" runat="server" 
                                ControlToValidate="txtInsertProdSize38Quan"
                                Operator="GreaterThanEqual" 
                                ValueToCompare="0"
                                Type="Integer"
                                ErrorMessage="The value must be at least 0."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:CompareValidator>
                        </div>
                        <div class="col-sm-3">
                            <label class="control-label">Size 39 Quantity</label><br />
                            <asp:TextBox ID="txtInsertProdSize39Quan" runat="server" Width="100%"/><br />            
                            <asp:RequiredFieldValidator ID="InsertProd39QuanRequireValidator" runat="server"
                                ControlToValidate="txtInsertProdSize39Quan"
                                ErrorMessage="*Required."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="InsertProd39SizeQuanCompareValidator" runat="server" 
                                ControlToValidate="txtInsertProdSize39Quan"
                                Operator="GreaterThanEqual" 
                                ValueToCompare="0"
                                Type="Integer"
                                ErrorMessage="The value must be at least 0."
                                ForeColor="Firebrick"
                                Display="Dynamic"
                                CssClass="error-message">
                            </asp:CompareValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-sm-2 col-sm-offset-10">
                            <br />
                            <asp:LinkButton ID="insertProdBtn" runat="server" 
                                OnClick="InsertProd" CausesValidation="False"     
                                Text="Create" CssClass="btn btn-primary prod-create-btn"/>
                        </div>
                    </div>                                                       
                </div>    
            </div>   
        </div>
    </div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>
        if (sessionStorage.length != 4) {
            sessionStorage.setItem('CateFormToggleState', '');
            sessionStorage.setItem('ProdFormToggleState', '');
            sessionStorage.setItem('CateTableToggleState', '');
            sessionStorage.setItem('ProdTableToggleState', '');
        }
        if (sessionStorage.getItem('CateFormToggleState') == 'show')
            $("#CreateCateForm").show();
        else
            $("#CreateCateForm").hide();

        if (sessionStorage.getItem('ProdFormToggleState') == 'show')
            $("#CreateProdForm").show();
        else
            $("#CreateProdForm").hide();

        if (sessionStorage.getItem('CateTableToggleState') == 'show' || sessionStorage.getItem('CateTableToggleState') == '')
            $("#ManaCateTable").show();
        else
            $("#ManaCateTable").hide();

        if (sessionStorage.getItem('ProdTableToggleState') == 'show' || sessionStorage.getItem('ProdTableToggleState') == '')
            $("#ManaProdTable").show();
        else
            $("#ManaProdTable").hide();
        
        $(document).ready(function () {
            $("#CateFormShow").click(function () {
                $("#CreateCateForm").slideDown();
                sessionStorage.setItem('CateFormToggleState', 'show');
            });
            $("#CateFormHide").click(function () {
                $("#CreateCateForm").slideUp();
                sessionStorage.setItem('CateFormToggleState', 'hide');
            });
            $("#ProdFormShow").click(function () {
                $("#CreateProdForm").slideDown();
                sessionStorage.setItem('ProdFormToggleState', 'show');
            });
            $("#ProdFormHide").click(function () {
                $("#CreateProdForm").slideUp();
                sessionStorage.setItem('ProdFormToggleState', 'hide');
            });
            $("#CateTableShow").click(function () {
                $("#ManaCateTable").slideDown();
                sessionStorage.setItem('CateTableToggleState', 'show');
            });
            $("#CateTableHide").click(function () {
                $("#ManaCateTable").slideUp();
                sessionStorage.setItem('CateTableToggleState', 'hide');
            });
            $("#ProdTableShow").click(function () {
                $("#ManaProdTable").slideDown();
                sessionStorage.setItem('ProdTableToggleState', 'show');
            });
            $("#ProdTableHide").click(function () {
                $("#ManaProdTable").slideUp();
                sessionStorage.setItem('ProdTableToggleState', 'hide');
            });
        })
    </script>
</asp:Content>
