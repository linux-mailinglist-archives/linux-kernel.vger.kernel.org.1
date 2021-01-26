Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C0304FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhA0DcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbhAZVR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:17:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC2C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:55 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7bsurizoHLBXVTo0OP/oBa1AR0dtEv/F7YnAM8l54k=;
        b=QQwRz40AI6Ca8gT8rdPMAmkYeyuAzfz6HvinFYo2R8pqR8wOvcd/nomyW65k9IJIycVlik
        zkFey+741EMAqQ7mwlNGJxhlS+vvHIgfSl5xBSx13f2uyb8z2gqDE+dJA5+lQuJ+ltyyVv
        UQ8Pr3UNXKlrY2Pcvr/vx4RTuNzgrhiMiS0mtWj8N6Bs+ayoGADRB1ow6nBjGeNZ+WTuwf
        Kxt09s+fYzhB5tEe4yvmSS5Qvl8O7cz3Ny+4Tai2rt5XTpfvUurOxu+PnR4EwjWi6Z4nwT
        h/mNjqGZHHFkF+jTCnZvDroLA03hnboATD6bNm5XP8aN6G3XQbJycOdRZiIyWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7bsurizoHLBXVTo0OP/oBa1AR0dtEv/F7YnAM8l54k=;
        b=797RkQ14gEr1MuJVRN0PTcDIb3D6AGLhWlpqGqb06Nxkvcv7ajpg94aHQtUIviRPW2nSFO
        12teKJmTQA2+qNDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 04/12] printk: define CONSOLE_LOG_MAX in printk.h
Date:   Tue, 26 Jan 2021 22:21:43 +0106
Message-Id: <20210126211551.26536-5-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONSOLE_EXT_LOG_MAX for extended console messages is already defined
in printk.h. Define CONSOLE_LOG_MAX there as well so that future
changes can make use of the constant for non-extended console
messages.

Use CONSOLE_LOG_MAX instead of LOG_LINE_MAX + PREFIX_MAX.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |  1 +
 kernel/printk/printk.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..6d8f844bfdff 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -45,6 +45,7 @@ static inline const char *printk_skip_headers(const char *buffer)
 }
 
 #define CONSOLE_EXT_LOG_MAX	8192
+#define CONSOLE_LOG_MAX		1024
 
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ec2174882b8e..5faf9c0db171 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -410,7 +410,7 @@ static u64 clear_seq;
 #else
 #define PREFIX_MAX		32
 #endif
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
@@ -1463,11 +1463,11 @@ static int syslog_print(char __user *buf, int size)
 	char *text;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	while (size > 0) {
 		size_t n;
@@ -1533,7 +1533,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1545,7 +1545,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 */
 	seq = find_first_fitting_seq(clear_seq, -1, size, &info, true, time);
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -2173,8 +2173,6 @@ EXPORT_SYMBOL(printk);
 
 #else /* CONFIG_PRINTK */
 
-#define LOG_LINE_MAX		0
-#define PREFIX_MAX		0
 #define printk_time		false
 
 #define prb_read_valid(rb, seq, r)	false
@@ -2485,7 +2483,7 @@ static inline int can_use_console(void)
 void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char text[CONSOLE_LOG_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
-- 
2.20.1

