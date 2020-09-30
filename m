Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7127E471
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgI3JBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgI3JBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:01:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:01:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601456495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unPTVmhcjkDbWwTpj45IJ9JzGvjJBEp3rAzxVp6hODU=;
        b=IQVX1vP4va3Bd5qAQPLJa3WcQLkKx3BZal4yyG+MBsKuLWcXFLsrsC+UlDzNIDOOhBWgUU
        S2M+Ygq4b25qn24+PRF7eGbg4aTWHFOcZeYBbprenqWorveNfR18TnPdp2/Hcgk/lhMdRO
        gC2eRE7nnMjaTwXaLIPeIGKdXF4CSrhnjsVW/FsEtm1j7iJTMwALOinCPcwZmyK5S7f37z
        PadahpVWSWM4Z9/vZuVzijEJfbReSvMK5SPUu3Hys2+EyeoD2gBid6EDAPVlI+EdO+n9Me
        4tTnUQw8B4qp7cQNqF84bVoQZJsRKKd6QXz6E79Ch+1oeO04pC4+L6X95wbfvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601456495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unPTVmhcjkDbWwTpj45IJ9JzGvjJBEp3rAzxVp6hODU=;
        b=urs2/dB2vWZoNkneQz34aEY+sXOpIwJNM2OCsDboQIpQJSqCMoRA2xpyLNNSPhqmh5J1lf
        /HJoPGKfQZiFSYBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Date:   Wed, 30 Sep 2020 11:07:33 +0206
Message-Id: <20200930090134.8723-2-john.ogness@linutronix.de>
In-Reply-To: <20200930090134.8723-1-john.ogness@linutronix.de>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
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
truncation has occurred.

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
 kernel/printk/printk.c            |  9 ++++++++-
 kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
 kernel/printk/printk_ringbuffer.h |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 78f68b4830dc..04cf1e00478f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1357,6 +1357,13 @@ static size_t record_print_text(struct printk_record *r, bool syslog,
 	size_t len = 0;
 	char *next;
 
+	/*
+	 * If the message was truncated because the buffer was not large
+	 * enough, treat the available text as if it were the full text.
+	 */
+	if (text_len > buf_size)
+		text_len = buf_size;
+
 	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
 
 	/*
@@ -1911,7 +1918,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
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

