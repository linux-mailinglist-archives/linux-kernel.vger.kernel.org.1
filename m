Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81A22ED4A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAGQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:45:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:35528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbhAGQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:45:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610037862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hZ6qAENGydD+Ns7UzQkxnIP9UMKhSomQXjKzMAEncc=;
        b=LrzKGWLPgbxfzNSVrxdk07KGyOSZXyugf8Tw4zh/maa2BqeObApnzGzKie/QtoWFwdPtha
        AxC4ZvgXvh8jIHmKdYmJzrpN6J+ZFW6scvmaufcloc4gezgsMQLTn6u43BfxcVZu3JpSkj
        XgU3d2y617oXi4c/ADUiczLHNWdmOL4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DC88B762;
        Thu,  7 Jan 2021 16:44:22 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/1] Revert "init/console: Use ttynull as a fallback when there is no console"
Date:   Thu,  7 Jan 2021 17:44:00 +0100
Message-Id: <20210107164400.17904-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210107164400.17904-1-pmladek@suse.com>
References: <20210107164400.17904-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 757055ae8dedf5333af17b3b5b4b70ba9bc9da4e.

The commit caused that ttynull was used as the default console
on many systems. It happened when there was no console configured
on the command line and ttynull_init() was the first initcall
calling register_console().

The commit fixed a historical problem that have been there for ages.
The primary motivation was the commit 3cffa06aeef7ece30f6
("printk/console: Allow to disable console output by using console=""
or console=null"). It provided a clean solution
for a workaround that was widely used and worked only by chance.

This revert causes that the console="" or console=null command line
options will again work only by chance. These options will cause that
a particular console will be preferred and the default (tty) ones
will not get enabled. There will be no console registered at
all. As a result there won't be stdin, stdout, and stderr for
the init process. But it worked exactly this way even before.

The proper solution has to fulfill many conditions:

  + Register ttynull only when explicitly required or as
    the ultimate fallback.

  + ttynull must get associated with /dev/console but it must
    not become preferred console when used as a fallback.
    Especially, it must still be possible to replace it
    by a better console later.

Such a change requires clean up of the register_console() code.
Otherwise, it would be even harder to follow. Especially, the use
of has_preferred_console and CON_CONSDEV flag is tricky. The clean
up is risky. The ordering of consoles is not well defined. And
any changes tend to break existing user settings.

Do the revert at the least risky solution for now.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/Kconfig     | 14 ++++++++++++++
 drivers/tty/Makefile    |  3 ++-
 drivers/tty/ttynull.c   | 18 ------------------
 include/linux/console.h |  3 ---
 init/main.c             | 10 ++--------
 5 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 47a6e42f0d04..e15cd6b5bb99 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -401,6 +401,20 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
 	help
 	  FDC channel number to use for KGDB.
 
+config NULL_TTY
+	tristate "NULL TTY driver"
+	help
+	  Say Y here if you want a NULL TTY which simply discards messages.
+
+	  This is useful to allow userspace applications which expect a console
+	  device to work without modifications even when no console is
+	  available or desired.
+
+	  In order to use this driver, you should redirect the console to this
+	  TTY, or boot the kernel with console=ttynull.
+
+	  If unsure, say N.
+
 config TRACE_ROUTER
 	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
 	depends on TRACE_SINK
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 3c1c5a9240a7..b3ccae932660 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
 				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
-				   n_null.o ttynull.o
+				   n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
@@ -25,6 +25,7 @@ obj-$(CONFIG_ISI)		+= isicom.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
+obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index eced70ec54e1..17f05b7eb6d3 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -2,13 +2,6 @@
 /*
  * Copyright (C) 2019 Axis Communications AB
  *
- * The console is useful for userspace applications which expect a console
- * device to work without modifications even when no console is available
- * or desired.
- *
- * In order to use this driver, you should redirect the console to this
- * TTY, or boot the kernel with console=ttynull.
- *
  * Based on ttyprintk.c:
  *  Copyright (C) 2010 Samo Pogacnik
  */
@@ -66,17 +59,6 @@ static struct console ttynull_console = {
 	.device = ttynull_device,
 };
 
-void __init register_ttynull_console(void)
-{
-	if (!ttynull_driver)
-		return;
-
-	if (add_preferred_console(ttynull_console.name, 0, NULL))
-		return;
-
-	register_console(&ttynull_console);
-}
-
 static int __init ttynull_init(void)
 {
 	struct tty_driver *driver;
diff --git a/include/linux/console.h b/include/linux/console.h
index dbe78e8e2602..20874db50bc8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -186,12 +186,9 @@ extern int braille_register_console(struct console *, int index,
 extern int braille_unregister_console(struct console *);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
-extern void register_ttynull_console(void);
 #else
 static inline void console_sysfs_notify(void)
 { }
-static inline void register_ttynull_console(void)
-{ }
 #endif
 extern bool console_suspend_enabled;
 
diff --git a/init/main.c b/init/main.c
index 421640fca375..c68d784376ca 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1480,14 +1480,8 @@ void __init console_on_rootfs(void)
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
 	if (IS_ERR(file)) {
-		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
-		register_ttynull_console();
-
-		file = filp_open("/dev/console", O_RDWR, 0);
-		if (IS_ERR(file)) {
-			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
-			return;
-		}
+		pr_err("Warning: unable to open an initial console.\n");
+		return;
 	}
 	init_dup(file);
 	init_dup(file);
-- 
2.26.2

