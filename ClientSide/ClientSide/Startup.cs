using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ClientSide.Startup))]
namespace ClientSide
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
