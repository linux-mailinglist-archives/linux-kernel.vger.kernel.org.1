Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2114A304FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhA0D3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbhAZVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA36C061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I+JRQsi4Xux2HicConwOi9mx/ayuTfBO/eMwHqXJVQ=;
        b=amn0FXfY9QTGlxkv7NzHvO8G+rVbz2t5Wkd8m3Bk/2Rq8T/wOjIyrEU3AKzyr0CslV6u0Z
        5iiZ2Sv6tsvjO1kvTv8I27iTjxfVYWDTZWGMjivqxB7hkBoC8i+lxXXs3CoEhjtnyD8+35
        NCbEjxP3SWPv1iM9lEcIlbm7S/8pjj1hf/vSch0cZsNt8scFD58S+iXh6A/JFPPXL0y2uv
        1cWK67GFq2qxGdlxx1gSlWst39SSTnbSIEXle/D6idO5Ij82PfynjAYt56gsyIrCUycaf0
        hUxdZBhMQpKYsLnlqCRQ1v9oF2W9syFuUHO4wOt8qwFswirhcTpq7Op7rXIhKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4I+JRQsi4Xux2HicConwOi9mx/ayuTfBO/eMwHqXJVQ=;
        b=bXbIS8xeGkGJ9RHXGB+DyfNXLoCo2AersZvO0/MMEjoG9LnE33gO5MC6wDOhhR6dSa3P/W
        n+KMrZI7IZCO3jCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 02/12] printk: refactor kmsg_dump_get_buffer()
Date:   Tue, 26 Jan 2021 22:21:41 +0106
Message-Id: <20210126211551.26536-3-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_get_buffer() requires nearly the same logic as
syslog_print_all(), but uses different variable names and
does not make use of the ringbuffer loop macros. Modify
kmsg_dump_get_buffer() so that the implementation is as similar
to syslog_print_all() as possible.

A follow-up commit will move this common logic into a
separate helper function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/kmsg_dump.h |  2 +-
 kernel/printk/printk.c    | 57 ++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index da98846098b5..76cc4122d08e 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -62,7 +62,7 @@ bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
 			char *line, size_t size, size_t *len);
 
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
-			  char *buf, size_t size, size_t *len);
+			  char *buf, size_t size, size_t *len_out);
 
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c55cd1820689..1929aa372e7f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3407,7 +3407,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * read.
  */
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
-			  char *buf, size_t size, size_t *len)
+			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
 	unsigned int line_count;
@@ -3415,12 +3415,10 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	unsigned long flags;
 	u64 seq;
 	u64 next_seq;
-	size_t l = 0;
+	size_t len = 0;
 	bool ret = false;
 	bool time = printk_time;
 
-	prb_rec_init_rd(&r, &info, buf, size);
-
 	if (!dumper->active || !buf || !size)
 		goto out;
 
@@ -3436,48 +3434,51 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 	}
 
-	/* calculate length of entire buffer */
-	seq = dumper->cur_seq;
-	while (prb_read_valid_info(prb, seq, &info, &line_count)) {
-		if (r.info->seq >= dumper->next_seq)
+	/*
+	 * Find first record that fits, including all following records,
+	 * into the user-provided buffer for this dump.
+	 */
+
+	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
+		if (info.seq >= dumper->next_seq)
 			break;
-		l += get_record_print_text_size(&info, line_count, syslog, time);
-		seq = r.info->seq + 1;
+		len += get_record_print_text_size(&info, line_count, syslog, time);
 	}
 
-	/* move first record forward until length fits into the buffer */
-	seq = dumper->cur_seq;
-	while (l >= size && prb_read_valid_info(prb, seq,
-						&info, &line_count)) {
-		if (r.info->seq >= dumper->next_seq)
+	/*
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is the best effort
+	 * that prevents an infinite loop.
+	 */
+	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
+		if (len < size || info.seq >= dumper->next_seq)
 			break;
-		l -= get_record_print_text_size(&info, line_count, syslog, time);
-		seq = r.info->seq + 1;
+		len -= get_record_print_text_size(&info, line_count, syslog, time);
 	}
 
-	/* last message in next interation */
+	/* Keep track of the last message for the next iteration. */
 	next_seq = seq;
 
-	/* actually read text into the buffer now */
-	l = 0;
-	while (prb_read_valid(prb, seq, &r)) {
+	prb_rec_init_rd(&r, &info, buf, size);
+
+	len = 0;
+	prb_for_each_record(seq, prb, seq, &r) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
 
-		l += record_print_text(&r, syslog, time);
-
-		/* adjust record to store to remaining buffer space */
-		prb_rec_init_rd(&r, &info, buf + l, size - l);
+		len += record_print_text(&r, syslog, time);
 
-		seq = r.info->seq + 1;
+		/* Adjust record to store to remaining buffer space. */
+		prb_rec_init_rd(&r, &info, buf + len, size - len);
 	}
 
 	dumper->next_seq = next_seq;
 	ret = true;
 	logbuf_unlock_irqrestore(flags);
 out:
-	if (len)
-		*len = l;
+	if (len_out)
+		*len_out = len;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
-- 
2.20.1

