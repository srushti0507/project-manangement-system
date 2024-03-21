<script src="js/vanilla-toast.js" type="text/javascript"></script>
<%
    if (session.getAttribute("error") != null) {
%>
    <script>
        vt.error('<%= session.getAttribute("error")%>', {
            title: "Error",
            position: "top-right",
            callback: function () {
                vt.error()
            }
        });
    </script>
    <%
        session.removeAttribute("error");
    }
%>    
<%
    if (session.getAttribute("msg") != null) {
%>    
    <script>
        vt.success('<%= session.getAttribute("msg")%>', {
            title: "Success",
            position: "top-right",
            callback: function () {
                vt.success()
            }
        });
    </script>
    <%
        session.removeAttribute("msg");
    }
%>