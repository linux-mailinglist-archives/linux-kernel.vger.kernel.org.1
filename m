Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB02AF2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgKKNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgKKNzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605102918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFanDl0y6sEvElxijkr60KEYf24wtkhinNRYdxqYbho=;
        b=EWl4/9KrgVo+0OdVJRWCXB7fmVUDyTE4qM3YxnU9ztG/1QszxZzs4MxJ1XhO5uo09zMo1p
        vZC17MO1CtKmbzLe0VqBbBJX4TYF5a33uaTHmMqWO/O55YxMvw/V4uioIDD5W0twAa5a2r
        nJrhwObd7cV3byKSmRMoYs/wqOPxR3U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CA15AC9A;
        Wed, 11 Nov 2020 13:55:18 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] init/console: Use ttynull as a fallback when there is no console
Date:   Wed, 11 Nov 2020 14:54:49 +0100
Message-Id: <20201111135450.11214-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111135450.11214-1-pmladek@suse.com>
References: <20201111135450.11214-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stdin, stdout, and stderr standard I/O stream are created for the init
process. They are not available when there is no console registered
for /dev/console. It might lead to a crash when the init process
tries to use them, see the commit 48021f98130880dd742 ("printk: handle
blank console arguments passed in.").

Normally, ttySX and ttyX consoles are used as a fallback when no consoles
are defined via the command line, device tree, or SPCR. But there
will be no console registered when an invalid console name is configured
or when the configured consoles do not exist on the system.

Users even try to avoid the console intentionally, for example,
by using console="" or console=null. It is used on production
systems where the serial port or terminal are not visible to
users. Pushing messages to these consoles would just unnecessary
slowdown the system.

Make sure that stdin, stdout, stderr, and /dev/console are always
available by a fallback to the existing ttynull driver. It has
been implemented for exactly this purpose but it was used only
when explicitly configured.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/Kconfig     | 14 --------------
 drivers/tty/Makefile    |  3 +--
 drivers/tty/ttynull.c   | 18 ++++++++++++++++++
 include/linux/console.h |  3 +++
 init/main.c             | 10 ++++++++--
 5 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 93fd984eb2f5..ca359bbd62f5 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -428,20 +428,6 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
 	help
 	  FDC channel number to use for KGDB.
 
-config NULL_TTY
-	tristate "NULL TTY driver"
-	help
-	  Say Y here if you want a NULL TTY which simply discards messages.
-
-	  This is useful to allow userspace applications which expect a console
-	  device to work without modifications even when no console is
-	  available or desired.
-
-	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
-
-	  If unsure, say N.
-
 config TRACE_ROUTER
 	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
 	depends on TRACE_SINK
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 020b1cd9294f..f6b6bee0422d 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
 				   tty_buffer.o tty_port.o tty_mutex.o \
 				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
-				   n_null.o
+				   n_null.o ttynull.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-$(CONFIG_AUDIT)		+= tty_audit.o
@@ -25,7 +25,6 @@ obj-$(CONFIG_ISI)		+= isicom.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
 obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
 obj-$(CONFIG_NOZOMI)		+= nozomi.o
-obj-$(CONFIG_NULL_TTY)	        += ttynull.o
 obj-$(CONFIG_ROCKETPORT)	+= rocket.o
 obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
 obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 17f05b7eb6d3..eced70ec54e1 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -2,6 +2,13 @@
 /*
  * Copyright (C) 2019 Axis Communications AB
  *
+ * The console is useful for userspace applications which expect a console
+ * device to work without modifications even when no console is available
+ * or desired.
+ *
+ * In order to use this driver, you should redirect the console to this
+ * TTY, or boot the kernel with console=ttynull.
+ *
  * Based on ttyprintk.c:
  *  Copyright (C) 2010 Samo Pogacnik
  */
@@ -59,6 +66,17 @@ static struct console ttynull_console = {
 	.device = ttynull_device,
 };
 
+void __init register_ttynull_console(void)
+{
+	if (!ttynull_driver)
+		return;
+
+	if (add_preferred_console(ttynull_console.name, 0, NULL))
+		return;
+
+	register_console(&ttynull_console);
+}
+
 static int __init ttynull_init(void)
 {
 	struct tty_driver *driver;
diff --git a/include/linux/console.h b/include/linux/console.h
index 4b1e26c4cb42..9c662e41cde5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -187,9 +187,12 @@ extern int braille_register_console(struct console *, int index,
 extern int braille_unregister_console(struct console *);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
+extern void register_ttynull_console(void);
 #else
 static inline void console_sysfs_notify(void)
 { }
+static inline void register_ttynull_console(void)
+{ }
 #endif
 extern bool console_suspend_enabled;
 
diff --git a/init/main.c b/init/main.c
index 130376ec10ba..24413c055a85 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
 	if (IS_ERR(file)) {
-		pr_err("Warning: unable to open an initial console.\n");
-		return;
+		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
+		register_ttynull_console();
+
+		file = filp_open("/dev/console", O_RDWR, 0);
+		if (IS_ERR(file)) {
+			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
+			return;
+		}
 	}
 	init_dup(file);
 	init_dup(file);
-- 
2.26.2

