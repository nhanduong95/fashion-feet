using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AdminSide.Startup))]
namespace AdminSide
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
