Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85645304FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhA0Dd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbhAZVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B3C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6CCHMd6pH+lKLjuwdRHKENVocihmCcVdCmHZzsApXA=;
        b=3dhKipwhO9L4aceV8QlVV7MU77dqWSW33zeRfqq8qIXi608fa8sn1HVtozoMr8z4j7Yah8
        Wgkq0obFtGhTDi7Wa3iDH15T07HLw4pk57zaJ9LqMlhp8C2LU/AZOl1cGDXPg5b2mBOjNU
        /upn43tOG9Lq8frZCGw9VFJistppA2Qb4Yxyd4yg26z+lWqJxazbnhwDAwKV7IvLOMRQQw
        uPatUVFOkV2u7gEuKY0fAruVe+TSxxJ+SNSp0eFlW0W00JjXN5CGe2ecDaH0aSTmRRDdZh
        8C2ewQiDOf87xUlAEwmNELY4Xf2/9XGlfa30+g5xm/+YwaKN2p9QKny/OH+mGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6CCHMd6pH+lKLjuwdRHKENVocihmCcVdCmHZzsApXA=;
        b=EEGPEXwq+69lXQPzmdh5XkEuiWXtIoeTLmhaD7yTtMsEplK0GidEtkWpxY/bFvqt3uysNi
        Zlp8C2P+HBcBL4Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 12/12] printk: kmsg_dump: remove _nolock() variants
Date:   Tue, 26 Jan 2021 22:21:51 +0106
Message-Id: <20210126211551.26536-13-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_rewind() and kmsg_dump_get_line() are lockless, so there is
no need for _nolock() variants. Remove these functions and switch all
callers of the _nolock() variants.

The functions without _nolock() were chosen because they are already
exported to kernel modules.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/xmon/xmon.c    |  4 +--
 include/linux/kmsg_dump.h   | 18 +------------
 kernel/debug/kdb/kdb_main.c |  8 +++---
 kernel/printk/printk.c      | 52 +++++--------------------------------
 4 files changed, 13 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 43162b885259..4cac114ba32d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3015,9 +3015,9 @@ dump_log_buf(void)
 	catch_memory_errors = 1;
 	sync();
 
-	kmsg_dump_rewind_nolock(&iter);
+	kmsg_dump_rewind(&iter);
 	xmon_start_pagination();
-	while (kmsg_dump_get_line_nolock(&iter, false, buf, sizeof(buf), &len)) {
+	while (kmsg_dump_get_line(&iter, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index ecc98f549d93..8a39d898a1a5 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -60,18 +60,13 @@ struct kmsg_dumper {
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len);
-
 bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
 bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter);
-
-void kmsg_dump_rewind(struct kmsg_dumper_iter *dumper_iter);
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
@@ -83,13 +78,6 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter,
-					     bool syslog, const char *line,
-					     size_t size, size_t *len)
-{
-	return false;
-}
-
 static inline bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
@@ -102,10 +90,6 @@ static inline bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool sysl
 	return false;
 }
 
-static inline void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
-{
-}
-
 static inline void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 }
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7ae9da245e4b..dbf1d126ac5e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2126,8 +2126,8 @@ static int kdb_dmesg(int argc, const char **argv)
 		kdb_set(2, setargs);
 	}
 
-	kmsg_dump_rewind_nolock(&iter);
-	while (kmsg_dump_get_line_nolock(&iter, 1, NULL, 0, NULL))
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, NULL, 0, NULL))
 		n++;
 
 	if (lines < 0) {
@@ -2159,8 +2159,8 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (skip >= n || skip < 0)
 		return 0;
 
-	kmsg_dump_rewind_nolock(&iter);
-	while (kmsg_dump_get_line_nolock(&iter, 1, buf, sizeof(buf), &len)) {
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, sizeof(buf), &len)) {
 		if (skip) {
 			skip--;
 			continue;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b57dba7f077d..a2d4ba00bf77 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3333,7 +3333,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 
 		/* initialize iterator with data about the stored records */
 		iter.active = true;
-		kmsg_dump_rewind_nolock(&iter);
+		kmsg_dump_rewind(&iter);
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason, &iter);
@@ -3342,7 +3342,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 }
 
 /**
- * kmsg_dump_get_line_nolock - retrieve one kmsg log line (unlocked version)
+ * kmsg_dump_get_line - retrieve one kmsg log line
  * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
@@ -3357,11 +3357,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  *
  * A return value of FALSE indicates that there are no more records to
  * read.
- *
- * The function is similar to kmsg_dump_get_line(), but grabs no locks.
  */
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
-			       char *line, size_t size, size_t *len)
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
+			char *line, size_t size, size_t *len)
 {
 	struct printk_info info;
 	unsigned int line_count;
@@ -3399,29 +3397,6 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 		*len = l;
 	return ret;
 }
-
-/**
- * kmsg_dump_get_line - retrieve one kmsg log line
- * @iter: kmsg dumper iterator
- * @syslog: include the "<4>" prefixes
- * @line: buffer to copy the line to
- * @size: maximum size of the buffer
- * @len: length of line placed into buffer
- *
- * Start at the beginning of the kmsg buffer, with the oldest kmsg
- * record, and copy one record into the provided buffer.
- *
- * Consecutive calls will return the next available record moving
- * towards the end of the buffer with the youngest messages.
- *
- * A return value of FALSE indicates that there are no more records to
- * read.
- */
-bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
-			char *line, size_t size, size_t *len)
-{
-	return kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
-}
 EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
 /**
@@ -3506,16 +3481,14 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
 /**
- * kmsg_dump_rewind_nolock - reset the iterator (unlocked version)
+ * kmsg_dump_rewind - reset the iterator
  * @iter: kmsg dumper iterator
  *
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
- *
- * The function is similar to kmsg_dump_rewind(), but grabs no locks.
  */
-void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 	unsigned long flags;
 
@@ -3524,19 +3497,6 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
 	iter->next_seq = prb_next_seq(prb);
 	printk_safe_exit_irqrestore(flags);
 }
-
-/**
- * kmsg_dump_rewind - reset the iterator
- * @iter: kmsg dumper iterator
- *
- * Reset the dumper's iterator so that kmsg_dump_get_line() and
- * kmsg_dump_get_buffer() can be called again and used multiple
- * times within the same dumper.dump() callback.
- */
-void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
-{
-	kmsg_dump_rewind_nolock(iter);
-}
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 #endif
-- 
2.20.1

