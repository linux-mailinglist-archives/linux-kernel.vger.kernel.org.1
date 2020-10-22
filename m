Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E778295D93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897452AbgJVLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897445AbgJVLmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603366971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPz2y+YO6piDwEgz5Ay0n/hoYFYkbUrzL6JCfnlbRMo=;
        b=gQIe/tQNmLR3WPX2UV1lMpjQMK9vbceEoiQCXbq4uuTloT2oQQWFgu2j1ZNut/3aVH9+QH
        9NFcTI23J/00s5kE5Tl6s+4JoWUAHQtA1Y5bggXlvWCOU9BKg0Nh90GlmdfZ9jgiX+LPmD
        BZCTqbqs9J13fKBGiwcSEU7Z3DGti4M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74464AEC1;
        Thu, 22 Oct 2020 11:42:51 +0000 (UTC)
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
Subject: [RFC 1/2] printk: Add kernel parameter: mute_console
Date:   Thu, 22 Oct 2020 13:42:27 +0200
Message-Id: <20201022114228.9098-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022114228.9098-1-pmladek@suse.com>
References: <20201022114228.9098-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users use various undocumented ways how to completely disable
console output. It is usually done by passing an invalid console
name, for example, console="", console=null.

It mostly works but just by chance. The console name is added to the list
of preferred consoles and the variable "preferred_console" is set.
As a result, any register_console() fails because the driver name
does not match the invalid name. And the console is not used as
a fallback because "preferred_console" is set.

It stops working, when another console is defined on the command line
or another way, for example, by SPCR or a device tree.

More importantly, the above approach might break the system. /dev/console
is used as stdin, stdout, and stderr for the init process [0]

Why yet another command line option?

console_loglevel is not reliable. It is manipulated also by user space
when it configures log daemons.

People might also want to just disable the kernel messages but still
use the console for login.

[0] https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++++
 kernel/printk/printk.c                        | 21 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 02d4adbf98d2..52b9e7f5468d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2974,6 +2974,12 @@
 			Used for mtrr cleanup. It is spare mtrr entries number.
 			Set to 2 or more if your graphical card needs more.
 
+	mute_console	[KNL]
+			Completely disable printing of kernel messages to
+			the console. It can still be used as stdin, stdout,
+			and stderr for the init process. Also it can be used
+			for login.
+
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
 	netdev=		[NET] Network devices parameters
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49344bf..63fb96630767 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1207,6 +1207,19 @@ void __init setup_log_buf(int early)
 	memblock_free(__pa(new_log_buf), new_log_buf_len);
 }
 
+static bool mute_console;
+
+static int __init mute_console_setup(char *str)
+{
+	mute_console = true;
+	pr_info("All consoles muted.\n");
+
+	return 0;
+}
+
+early_param("mute_console", mute_console_setup);
+module_param(mute_console, bool, 0644);
+
 static bool __read_mostly ignore_loglevel;
 
 static int __init ignore_loglevel_setup(char *str)
@@ -1224,7 +1237,13 @@ MODULE_PARM_DESC(ignore_loglevel,
 
 static bool suppress_message_printing(int level)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	if (unlikely(mute_console))
+		return true;
+
+	if (unlikely(ignore_loglevel))
+		return false;
+
+	return (level >= console_loglevel);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
-- 
2.26.2

