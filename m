Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864DE295D94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897461AbgJVLm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897445AbgJVLmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:42:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603366973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQRmKyKYT7uKEBtlml2OfUE8osE2xynkOxu/XpVBZcw=;
        b=VD/CPHBOykstgJqYoQR/QeB4t5cV3T94fkyawb4D4HeWrtQ3+2Ec8EP4Qz+NPuRNmRuUCP
        MlkfYkaGrWvf9RG5BRSDvfpLBJVAzOoM1sAHTupGsLzZHE3foSALODqcdQyynwp9k2Wzz1
        /PL+4szUz0Blg2lOhTDELD0tIVs752c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 437FBB80F;
        Thu, 22 Oct 2020 11:42:53 +0000 (UTC)
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
Subject: RFC 2/2] printk: Restore and document obsolete ways to disable console output
Date:   Thu, 22 Oct 2020 13:42:28 +0200
Message-Id: <20201022114228.9098-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022114228.9098-1-pmladek@suse.com>
References: <20201022114228.9098-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 48021f98130880dd7 ("printk: handle blank console arguments
passed in.") prevented crash caused by empty console= parameter value.

Unfortunately, this value is widely used on Chromebooks to disable
the console output. The above commit caused performance regression
because the messages were pushed on slow console even though nobody
was watching it.

"mute_console" kernel parameter has been introduced as a proper and
official was to disable console output. It avoids the performance
problem by suppressing all kernel messages. Also avoids the crash
by registering the default console.

Make console="" behave the same as "mute_console" to avoid
the performance regression on existing Chromebooks.

Do the same also for console=null which seem to be another widely
suggested and non-official way to disable the console output.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 kernel/printk/printk.c                          | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 52b9e7f5468d..14472f674a89 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -670,11 +670,16 @@
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
 
+		null
+		""	Obsolete way to disable console output. Please,
+			use "mute_console" instead.
+
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
 			console=brl,ttyS0
 		For now, only VisioBraille is supported.
 
+
 	console_msg_format=
 			[KNL] Change console messages format
 		default
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 63fb96630767..08c50d8ba110 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2208,8 +2208,15 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
-	if (str[0] == 0)
+	/*
+	 * console="" or console=null have been suggested as a way to
+	 * disable console output. It worked just by chance and was not
+	 * reliable. It has been obsoleted by "mute_console" parameter.
+	 */
+	if (str[0] == 0 || strcmp(str, "null") == 0) {
+		mute_console = true;
 		return 1;
+	}
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
-- 
2.26.2

