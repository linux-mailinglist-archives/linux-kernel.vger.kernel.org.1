Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4281527960D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgIZBz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:55:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgIZBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:55:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601085327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMH1iCSI0bSlnkbseT2XAxzCdW+t7gDKousNENbwy4Y=;
        b=nXTlhh98a24xdma/cVImTBTQNQA1GLEoMkSUXCx57/JM1m3p0m7l8vPswV8kcB6LjhDGCi
        TkTVvQjsciNVhkD/lKdmmX6OiEO0fs3QwROwqa5agZKNOnQ4/4v1VSw3wH+0iRmlsH+p4n
        dbaPqKS7K+P6iZw+kwlgtoOVMpwvbu2SkXe0Gww12afXnhgbZ8533bX5YxNlJ3U5LZSjVA
        1nRjv6hsTMYKS95Wq8frdYNDTrlvuq/SZLB9yC5Xld8F1/poXZYUAzfB7NtQ+0dGidoJ98
        M8jHZHl9E0D/RUXxtRPWf3GylOoVZKhZdvd2doUYElpglBrmE3no+pSukmWdag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601085327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMH1iCSI0bSlnkbseT2XAxzCdW+t7gDKousNENbwy4Y=;
        b=9DowO4+kxIUtnVW6gDRIXsPce8Hxc7A08nEb9sCA0gGuDNAK2gA1Wm7IbmfYTo4YBdNUGe
        L7G/ZA7ybVfbjWCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 1/2] printk: avoid and/or handle record truncation
Date:   Sat, 26 Sep 2020 04:01:25 +0206
Message-Id: <20200926015526.8921-2-john.ogness@linutronix.de>
In-Reply-To: <20200926015526.8921-1-john.ogness@linutronix.de>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a reader provides a buffer that is smaller than the message text,
the @text_len field of @info will have a value larger than the buffer
size. If readers blindly read @text_len bytes of data without
checking the size, they will read beyond their buffer.

Add this check to record_print_text() to properly recognize when such
truncation needs to occur.

Add a maximum size argument to the ringbuffer function to extend
records so that records can not be created that are larger than the
buffer size of readers.

When extending records (LOG_CONT), do not extend records beyond
LOG_LINE_MAX since that is the maximum size available in the buffers
used by consoles and syslog.

Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/printk/printk.c            |  7 ++++++-
 kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
 kernel/printk/printk_ringbuffer.h |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 78f68b4830dc..270f19b60e6f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1357,6 +1357,11 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 	size_t len = 0;
 	char *next;
 
+	if (text_len > buf_size) {
+		text_len = buf_size;
+		truncated = true;
+	}
+
 	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
 
 	/*
@@ -1911,7 +1916,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
 		struct printk_record r;
 
 		prb_rec_init_wr(&r, text_len);
-		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
+		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
 			memcpy(&r.text_buf[r.info->text_len], text, text_len);
 			r.info->text_len += text_len;
 			if (lflags & LOG_NEWLINE) {
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 13b94b92342e..2493348a1631 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -202,7 +202,8 @@
  *	// specify additional 5 bytes text space to extend
  *	prb_rec_init_wr(&r, 5);
  *
- *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id())) {
+ *	// try to extend, but only if it does not exceed 32 bytes
+ *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id()), 32) {
  *		snprintf(&r.text_buf[r.info->text_len],
  *			 r.text_buf_size - r.info->text_len, "hello");
  *
@@ -1309,6 +1310,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  * @rb:        The ringbuffer to re-reserve and extend data in.
  * @r:         The record structure to allocate buffers for.
  * @caller_id: The caller ID of the caller (reserving writer).
+ * @max_size:  Fail if the extended size would be greater than this.
  *
  * This is the public function available to writers to re-reserve and extend
  * data.
@@ -1343,7 +1345,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *            @r->info->text_len after concatenating.
  */
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-			 struct printk_record *r, u32 caller_id)
+			 struct printk_record *r, u32 caller_id, unsigned int max_size)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	struct printk_info *info;
@@ -1389,6 +1391,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 			goto fail;
 
+		if (r->text_buf_size > max_size)
+			goto fail;
+
 		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
 					 &d->text_blk_lpos, id);
 	} else {
@@ -1410,6 +1415,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 			goto fail;
 
+		if (r->text_buf_size > max_size)
+			goto fail;
+
 		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
 					   &d->text_blk_lpos, id);
 	}
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 0adaa685d1ca..5dc9d022db07 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -303,7 +303,7 @@ static inline void prb_rec_init_wr(struct printk_record *r,
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r);
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-			 struct printk_record *r, u32 caller_id);
+			 struct printk_record *r, u32 caller_id, unsigned int max_size);
 void prb_commit(struct prb_reserved_entry *e);
 void prb_final_commit(struct prb_reserved_entry *e);
 
-- 
2.20.1

