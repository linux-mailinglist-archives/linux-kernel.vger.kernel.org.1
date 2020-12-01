Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30D2CADD6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgLAUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387749AbgLAUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:54:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:53:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606856023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq95sUO9fKYASLRl2y1kd2fJ7DXU9bSXwie9b2JJ7YM=;
        b=1yJV/8P/XsPFH/nK015x6fNmimWs5j4CmDPMjRqSd/oIKa18/WYejFHEfnRQbfNq45eksj
        RTR9TypS7wmMuFBg2c4dgr+pAdSTNYD2/63UrkDdsX42GPpbB5Xeu7wOkCVqByQ5O/MIA5
        nRnLBegOItJwyXhHFIXQCzmeruQcun4JqDvkDSUSxwORr05Lp3w6q2URpj62Usbyr/y2h3
        puo9kgrlkzscH9ZiSpr3LjCiyXvjBHoNGP4yJFlM09rwBYyZUU4KGE25zd4uSJpRxhs6M0
        PfwchPt0QrcJtAIQoqNzzwXtkaPoPjkXDOz1XBSlk6+WsAQ724NwMA6Mss33dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606856023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq95sUO9fKYASLRl2y1kd2fJ7DXU9bSXwie9b2JJ7YM=;
        b=xj9j9Mv7mJyFO2PdoH8SfiufDcbzQ2Rt+oWs3A02Q8clyFWamN7onhTBDviGCpOSJ9nEiQ
        hAh4RUKCjLv0hMDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Date:   Tue,  1 Dec 2020 21:59:40 +0106
Message-Id: <20201201205341.3871-3-john.ogness@linutronix.de>
In-Reply-To: <20201201205341.3871-1-john.ogness@linutronix.de>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently @clear_seq access is protected by @logbuf_lock. Once
@logbuf_lock is removed some other form of synchronization will be
required. Change the type of @clear_seq to atomic64_t to provide the
synchronization.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc5e3a7d6d89..e9018c4e1b66 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -403,7 +403,7 @@ static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
 
 /* the next printk record to read after the last 'clear' command */
-static u64 clear_seq;
+static atomic64_t clear_seq = ATOMIC64_INIT(0);
 
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
@@ -797,7 +797,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->seq = clear_seq;
+		user->seq = atomic64_read(&clear_seq);
 		break;
 	case SEEK_END:
 		/* after the last record */
@@ -914,6 +914,9 @@ void log_buf_vmcoreinfo_setup(void)
 	 * parse it and detect any changes to structure down the line.
 	 */
 
+	VMCOREINFO_SIZE(atomic64_t);
+	VMCOREINFO_TYPE_OFFSET(atomic64_t, counter);
+
 	VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
 	VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
@@ -1476,6 +1479,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	u64 clr_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1487,15 +1491,17 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 	time = printk_time;
 	logbuf_lock_irq();
+	clr_seq = atomic64_read(&clear_seq);
+
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
+	prb_for_each_info(clr_seq, prb, seq, &info, &line_count)
 		len += get_record_print_text_size(&info, line_count, true, time);
 
 	/* move first record forward until length fits into the buffer */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
+	prb_for_each_info(clr_seq, prb, seq, &info, &line_count) {
 		if (len <= size)
 			break;
 		len -= get_record_print_text_size(&info, line_count, true, time);
@@ -1526,7 +1532,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	}
 
 	if (clear)
-		clear_seq = seq;
+		atomic64_set(&clear_seq, seq);
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1536,7 +1542,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
-	clear_seq = prb_next_seq(prb);
+	atomic64_set(&clear_seq, prb_next_seq(prb));
 	logbuf_unlock_irq();
 }
 
@@ -3205,7 +3211,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		dumper->active = true;
 
 		logbuf_lock_irqsave(flags);
-		dumper->cur_seq = clear_seq;
+		dumper->cur_seq = atomic64_read(&clear_seq);
 		dumper->next_seq = prb_next_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 
@@ -3412,7 +3418,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = clear_seq;
+	dumper->cur_seq = atomic64_read(&clear_seq);
 	dumper->next_seq = prb_next_seq(prb);
 }
 
-- 
2.20.1

