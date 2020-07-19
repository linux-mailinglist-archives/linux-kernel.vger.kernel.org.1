Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82E22529E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgGSPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 11:52:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:44639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSPwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595173881;
        bh=UxIl6mQen7XHyeByrGPPzVo5oIulQzy1cfNBw4mJwKk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SuTsQ1RuKd1Yyt7mauDt3BNF40vASogagV5nvvha5YSYs1cLI1Cf0lsUXEg5yW1GI
         Xp36OFwLS7PIaAV7aGhcOAP7yPCCzVAmt9WBdJ7wzNeZ4OiXgPspLWJpQuEfcPWkcx
         tEGDeKbS56bIAIBtXzlRiHz0xOLcv9DX0ipXICYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N7R1J-1ktnoT46jV-017pPZ; Sun, 19 Jul 2020 17:51:21 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, Jann Horn <jannh@google.com>
Subject: [PATCH v2 1/2] kernel/trace: Prepare to remove function callback casts
Date:   Sun, 19 Jul 2020 17:50:32 +0200
Message-Id: <20200719155033.24201-2-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719155033.24201-1-oscar.carter@gmx.com>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2z12NmO4u8UaSayx3JZjEGOcyrHYJ4xFELYM88klsQhmJlBUw5R
 ZNiIhd83afniCVMUF1UDUfbNAVXAxTD+6MtwUWxSSMssNq3DZtnzZpfuOLzGZPWH5LOHvyj
 92nr89bVIbT9WYJk3uvwdohIL10+ECLUNMQ98SG3NdC87Gp1UGtAs7O3geVLHSPkJhi8Yb3
 4DAG/29QWv/o6Z2sngFNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uMgpbrCNjLY=:QEGMcSDeJXgrI0HoHw1xAh
 LCEzKfBq8KCcJvdSmqkwUJENEdUY1slU+Il1VaseHlMpmP/rBKAyPVQt7kUCl21f42Zec7eRr
 ylFn9uMnJ/KL+/Ldgtlqe9cXofKoqVKMWiWSrAXUlX2SUT5he0U5+c0h78TWGZOJ06uSrOFjO
 GjIB/VSM0rk5KpFbljpiinl7v8f+fuQ9N6z1D9XMkrqjP2hjK6npdF91oy6K5xBo8COM9olBd
 ah8/SpIDNNKoxyHf+kpTAmYcoYGu77eJLvX71WPFqvcV+qNplnepzmYpnYPmeR1lag0qiOK8n
 9Kw9LX1WGB3bXkak6VdLKbXoQgUTMlol1Nw99R8rDLm7ZzM5pgzXGFU72984ILTmKYb58NJfx
 mON0Y9t+L61bsglxxbYBSMRF96PtdTXqqdSE6f9LENIbY7UkqmwEDSP9PeYz3Aeu2Ldhr1xN1
 jxIsxyNeqpNksV5v9KrsPmWtWDlhNdHD1lkFU9lzwmJvDRMx/ENaEp53Ak+tnTv4zBYmQY4js
 X3pkhNYjdaQQW3hMhOssrRy3Vm9GV/JblJx9elyrumAR/qZkAGskOHU5PvemkFYTon8C/5ahz
 QcyE1AQU0JmU+HQ+wSZoQxWf6L0M4mDVpAI4n5aeCZwHcze3oJb3lroQ9WIJ8OmNtxpiwFGWM
 9t/Xf0DPdILb7ceMaZqSKkn2PzXyjozAAoafLGkDNM8Hlky9gu3zFXrIiYyVZY09zU0wbqJCK
 FlnG1gaMhEtThyCB4pfku/f/GotOFwL/ggbOq4UceAVqHI8fGdc9BE1q8owG2gVPowaE0SwNu
 BzAsjA/04wc5RU2ERuIBeBfC1Km3CcOqvebyDrFAumFs3JqNaVXC9VFB6L08/H5lKVqKBO2lF
 86R/aHFMBmqg4H9nAzpRg6krVuFE5vaSj7FzlRbKhefQZ3NSMOJVpv9NcylANRC1D/u6dRhzA
 b5b4vMvAXFeHuZoNlaz+5gWmG+noxr8L+XAZS44yQaf1kvrzHx2bJYkmKSu4OJhXlTybMV3/i
 9vIPPsaJg3ZpClrk7urOvbn6DZ7m1iHmSOydFZwn62R+wTEWYkCpsJpU2IVffOc0BCtYSIeEv
 7/RRAbOwRt3ETEaRTlUoAxbUdDeNSmKQnvJCU4jfDPPuRIvybQ6J5lsDLNM3oeKCjX8m3Y62o
 50hVn9noWAl+GrZIEfcn3grUXWMU/x1950r7pmiF/BmXzjBfibb57+Ubo7f9caFA1IawrI0OK
 AUyMIH+ecdfhkQRNdIKOCy++7Op3OBGrDDpLxbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, there are the need to remove all
the function callback casts.

ftrace_ops_list_func() can no longer be defined as ftrace_ops_no_ops().
The reason for ftrace_ops_no_ops() is to use that when an architecture
calls ftrace_ops_list_func() with only two parameters (called from
assembly). And to make sure there's no C side-effects, those archs call
ftrace_ops_no_ops() which only has two parameters, as the function
ftrace_ops_list_func() has four parameters.

This patch prepares all the infrastructure to remove the casts.

Define a new function pointer to use when the archs don't support ftrace
ops. Also define a union to combine this new function pointer (two
parameters) with the ftrace_func_t function pointer (four parameters).
This way, using this union it's possible to use two different function
prototypes with the same variable.

Also create two static inline helpers to set and compare against the
fields of the new union type. These helpers are duplicated for the archs
that support ftrace ops and for the archs that don't support ftrace ops
as both cases use different function prototypes.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 kernel/trace/ftrace.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6eb..fd8fbb422860 100644
=2D-- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -119,13 +119,45 @@ struct ftrace_ops __rcu *ftrace_ops_list __read_most=
ly =3D &ftrace_list_end;
 ftrace_func_t ftrace_trace_function __read_mostly =3D ftrace_stub;
 struct ftrace_ops global_ops;

+typedef void (*ftrace_func_no_ops_t)(unsigned long ip,
+				     unsigned long parent_ip);
+
+union ftrace_func {
+	ftrace_func_t ops;
+	ftrace_func_no_ops_t no_ops;
+};
+
 #if ARCH_SUPPORTS_FTRACE_OPS
 static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_i=
p,
 				 struct ftrace_ops *op, struct pt_regs *regs);
+
+static inline void ftrace_set_ufunc(union ftrace_func *ufunc,
+				    ftrace_func_t func)
+{
+	ufunc->ops =3D func;
+}
+
+static inline bool ftrace_same_address_ufunc(union ftrace_func *ufunc,
+					     ftrace_func_t func)
+{
+	return (ufunc->ops =3D=3D func);
+}
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
 #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
+
+static inline void ftrace_set_ufunc(union ftrace_func *ufunc,
+				    ftrace_func_no_ops_t func)
+{
+	ufunc->no_ops =3D func;
+}
+
+static inline bool ftrace_same_address_ufunc(union ftrace_func *ufunc,
+					     ftrace_func_no_ops_t func)
+{
+	return (ufunc->no_ops =3D=3D func);
+}
 #endif

 static inline void ftrace_ops_init(struct ftrace_ops *ops)
=2D-
2.20.1

