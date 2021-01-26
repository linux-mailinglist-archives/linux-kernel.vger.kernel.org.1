Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD39304FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhA0D35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbhAZVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:55 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hBkQ0C3P7tr9Cj9KWnDwYS8rMIqHH5Gn1dqur54NPU=;
        b=4MeOT7VmQ5SQOEn+MN+xv/NL3ERSCFZXjpBQm24lQmgGkqcWuC8+WUk0KEiv59I9calIuX
        9ZeqXPqZjUAxaMQvXvAIWSI20qd7cSGzIMAItEQ3n+6/FBr5i4NEJTnXLOI9gjyseA3RH+
        BPIuoQoBFJHc7koD8maZD+w7iOv1GM/DZ+JKqwtMuRuy3DrCN0ofyb1chtSyQMeNImNUqB
        Ey2Si3jtl1TNwBq7oSEKrl5QcX7yYj5IyLEiQqGc0TuVk2x1DNJKpGkYBbaMM3Oo8x3K0s
        lWiEygYCoZxm4X5/hEtJ+me/wKfj3hR8JoSK6vPI8JpClKQ5o0SlC/kEAgINhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hBkQ0C3P7tr9Cj9KWnDwYS8rMIqHH5Gn1dqur54NPU=;
        b=gEtVV26VIXMETE0fIEKQalGFk/vlIlKvomWyMK8KyY6K99ETvJuyJnghFTShtPhtgmmkfp
        TPzNLOK6el+c7lDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 03/12] printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
Date:   Tue, 26 Jan 2021 22:21:42 +0106
Message-Id: <20210126211551.26536-4-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for finding records to fit into a buffer is the same for
kmsg_dump_get_buffer() and syslog_print_all(). Introduce a helper
function find_first_fitting_seq() to handle this logic.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 71 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1929aa372e7f..ec2174882b8e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1421,6 +1421,41 @@ static size_t get_record_print_text_size(struct printk_info *info,
 	return ((prefix_len * line_count) + info->text_len + 1);
 }
 
+/*
+ * Beginning with @start_seq, find the first record where it and all following
+ * records up to (but not including) @max_seq fit into @size.
+ */
+static u64 find_first_fitting_seq(u64 start_seq, u64 max_seq, size_t size,
+				  struct printk_info *info, bool syslog, bool time)
+{
+	unsigned int line_count;
+	size_t len = 0;
+	u64 seq;
+
+	/* Determine the size of the records up to @max_seq. */
+	prb_for_each_info(start_seq, prb, seq, info, &line_count) {
+		if (info->seq >= max_seq)
+			break;
+		len += get_record_print_text_size(info, line_count, syslog, time);
+	}
+
+	/*
+	 * Move first record forward until length fits into the buffer. Ignore
+	 * newest messages that were not counted in the above cycle. Messages
+	 * might appear and get lost in the meantime. This is a best effort
+	 * that prevents an infinite loop that could occur with a retry.
+	 */
+	if (seq < max_seq)
+		max_seq = seq;
+	prb_for_each_info(start_seq, prb, seq, info, &line_count) {
+		if (len <= size || info->seq >= max_seq)
+			break;
+		len -= get_record_print_text_size(info, line_count, syslog, time);
+	}
+
+	return seq;
+}
+
 static int syslog_print(char __user *buf, int size)
 {
 	struct printk_info info;
@@ -1492,7 +1527,6 @@ static int syslog_print(char __user *buf, int size)
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
 	char *text;
 	int len = 0;
@@ -1509,15 +1543,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
-		len += get_record_print_text_size(&info, line_count, true, time);
-
-	/* move first record forward until length fits into the buffer */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
-		if (len <= size)
-			break;
-		len -= get_record_print_text_size(&info, line_count, true, time);
-	}
+	seq = find_first_fitting_seq(clear_seq, -1, size, &info, true, time);
 
 	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
 
@@ -3410,7 +3436,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
-	unsigned int line_count;
 	struct printk_record r;
 	unsigned long flags;
 	u64 seq;
@@ -3436,26 +3461,12 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	/*
 	 * Find first record that fits, including all following records,
-	 * into the user-provided buffer for this dump.
+	 * into the user-provided buffer for this dump. Pass in size-1
+	 * because this function (by way of record_print_text()) will
+	 * not write more than size-1 bytes of text into @buf.
 	 */
-
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (info.seq >= dumper->next_seq)
-			break;
-		len += get_record_print_text_size(&info, line_count, syslog, time);
-	}
-
-	/*
-	 * Move first record forward until length fits into the buffer. Ignore
-	 * newest messages that were not counted in the above cycle. Messages
-	 * might appear and get lost in the meantime. This is the best effort
-	 * that prevents an infinite loop.
-	 */
-	prb_for_each_info(dumper->cur_seq, prb, seq, &info, &line_count) {
-		if (len < size || info.seq >= dumper->next_seq)
-			break;
-		len -= get_record_print_text_size(&info, line_count, syslog, time);
-	}
+	seq = find_first_fitting_seq(dumper->cur_seq, dumper->next_seq,
+				     size - 1, &info, syslog, time);
 
 	/* Keep track of the last message for the next iteration. */
 	next_seq = seq;
-- 
2.20.1

