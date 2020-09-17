Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4292326DCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgIQNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgIQNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:17:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:17:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600348607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utTPfA79j4jISQzVpQxulx2pzdWCF8N4doSgGrO837Q=;
        b=I+0OXOJCYnvTFrMdHD74TWyO1OrG7FPKVu1K72SJODKmN/qenpCvKSUQBSptQ46QU+wpbT
        Hdtct4ZOXZiBFZzuO+fRKucVA3exYX09Yyx7m1drMSsmEk0zST9kB5Cv+TnTNeFeTgLFz/
        RMQiXtEjnXbtA12tQzVhKZopf5Ml7BFFmKnIAi+2M1E1UXRhEsLRscPDPKMWsvrST6orXz
        fi+A26JQ/LeM01M0DTAmLy3+UC/14BVAkqVumbjgjbweUyvw2dN7jOONEoQbwoWfj/FMBz
        Hx98QwGrZVYVLt4HBtuzsQRAjm+7t+TUsuI8aTukZCHKW7yyjDKZWi5WUNIPSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600348607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utTPfA79j4jISQzVpQxulx2pzdWCF8N4doSgGrO837Q=;
        b=jZSdA11XMzgmBZCgwP0nrXf/zYKi7huZtNvlOlCUwXyQiq6nh2PuihUvOEQz5txPKrIm3H
        oOOTAnvJdv+PSRBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH printk 3/3] printk: remove dict ring
Date:   Thu, 17 Sep 2020 15:22:44 +0206
Message-Id: <20200917131644.25838-4-john.ogness@linutronix.de>
In-Reply-To: <20200917131644.25838-1-john.ogness@linutronix.de>
References: <20200917131644.25838-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no code that will ever store anything into the dict
ring, remove it. If any future dictionary properties are to be
added, these should be added to the struct printk_info.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            |  45 +++------
 kernel/printk/printk_ringbuffer.c | 155 +++++++-----------------------
 kernel/printk/printk_ringbuffer.h |  63 +++---------
 3 files changed, 63 insertions(+), 200 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b2e2bdd37028..107c09744026 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -427,7 +427,6 @@ static u32 log_buf_len = __LOG_BUF_LEN;
  * Define the average message size. This only affects the number of
  * descriptors that will be available. Underestimating is better than
  * overestimating (too many available descriptors is better than not enough).
- * The dictionary buffer will be the same size as the text buffer.
  */
 #define PRB_AVGBITS 5	/* 32 character average length */
 
@@ -435,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #error CONFIG_LOG_BUF_SHIFT value too small.
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
-		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
+		 PRB_AVGBITS, &__log_buf[0]);
 
 static struct printk_ringbuffer printk_rb_dynamic;
 
@@ -502,12 +501,12 @@ static int log_store(u32 caller_id, int facility, int level,
 	struct printk_record r;
 	u16 trunc_msg_len = 0;
 
-	prb_rec_init_wr(&r, text_len, 0);
+	prb_rec_init_wr(&r, text_len);
 
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
 		truncate_msg(&text_len, &trunc_msg_len);
-		prb_rec_init_wr(&r, text_len + trunc_msg_len, 0);
+		prb_rec_init_wr(&r, text_len + trunc_msg_len);
 		/* survive when the log buffer is too small for trunc_msg */
 		if (!prb_reserve(&e, prb, &r))
 			return 0;
@@ -897,8 +896,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	mutex_init(&user->lock);
 
 	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf),
-			NULL, 0);
+			&user->text_buf[0], sizeof(user->text_buf));
 
 	logbuf_lock_irq();
 	user->seq = prb_first_valid_seq(prb);
@@ -954,7 +952,6 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_STRUCT_SIZE(printk_ringbuffer);
 	VMCOREINFO_OFFSET(printk_ringbuffer, desc_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, text_data_ring);
-	VMCOREINFO_OFFSET(printk_ringbuffer, dict_data_ring);
 	VMCOREINFO_OFFSET(printk_ringbuffer, fail);
 
 	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
@@ -967,7 +964,6 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_STRUCT_SIZE(prb_desc);
 	VMCOREINFO_OFFSET(prb_desc, state_var);
 	VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
-	VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
 
 	VMCOREINFO_STRUCT_SIZE(prb_data_blk_lpos);
 	VMCOREINFO_OFFSET(prb_data_blk_lpos, begin);
@@ -977,7 +973,6 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_info, seq);
 	VMCOREINFO_OFFSET(printk_info, ts_nsec);
 	VMCOREINFO_OFFSET(printk_info, text_len);
-	VMCOREINFO_OFFSET(printk_info, dict_len);
 	VMCOREINFO_OFFSET(printk_info, caller_id);
 	VMCOREINFO_OFFSET(printk_info, dev_info);
 
@@ -1076,7 +1071,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	struct prb_reserved_entry e;
 	struct printk_record dest_r;
 
-	prb_rec_init_wr(&dest_r, r->info->text_len, 0);
+	prb_rec_init_wr(&dest_r, r->info->text_len);
 
 	if (!prb_reserve(&e, rb, &dest_r))
 		return 0;
@@ -1106,7 +1101,6 @@ void __init setup_log_buf(int early)
 	struct printk_record r;
 	size_t new_descs_size;
 	unsigned long flags;
-	char *new_dict_buf;
 	char *new_log_buf;
 	unsigned int free;
 	u64 seq;
@@ -1141,20 +1135,11 @@ void __init setup_log_buf(int early)
 		return;
 	}
 
-	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
-	if (unlikely(!new_dict_buf)) {
-		pr_err("log_buf_len: %lu dict bytes not available\n",
-		       new_log_buf_len);
-		memblock_free(__pa(new_log_buf), new_log_buf_len);
-		return;
-	}
-
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
 	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
 	if (unlikely(!new_descs)) {
 		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
-		memblock_free(__pa(new_dict_buf), new_log_buf_len);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
@@ -1165,18 +1150,14 @@ void __init setup_log_buf(int early)
 		pr_err("log_buf_len: %zu info bytes not available\n",
 		       new_descs_size);
 		memblock_free(__pa(new_descs), new_log_buf_len);
-		memblock_free(__pa(new_dict_buf), new_log_buf_len);
 		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info,
-			&setup_text_buf[0], sizeof(setup_text_buf),
-			NULL, 0);
+	prb_rec_init_rd(&r, &info, &setup_text_buf[0], sizeof(setup_text_buf));
 
 	prb_init(&printk_rb_dynamic,
 		 new_log_buf, ilog2(new_log_buf_len),
-		 new_dict_buf, ilog2(new_log_buf_len),
 		 new_descs, ilog2(new_descs_count),
 		 new_infos);
 
@@ -1455,7 +1436,7 @@ static int syslog_print(char __user *buf, int size)
 	if (!text)
 		return -ENOMEM;
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
 
 	while (size > 0) {
 		size_t n;
@@ -1542,7 +1523,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
 
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX, NULL, 0);
+	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
@@ -1912,7 +1893,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
 		struct prb_reserved_entry e;
 		struct printk_record r;
 
-		prb_rec_init_wr(&r, text_len, 0);
+		prb_rec_init_wr(&r, text_len);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
 			memcpy(&r.text_buf[r.info->text_len], text, text_len);
 			r.info->text_len += text_len;
@@ -2400,7 +2381,7 @@ void console_unlock(void)
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text), NULL, 0);
+	prb_rec_init_rd(&r, &info, text, sizeof(text));
 
 	/*
 	 * Console drivers are called with interrupts disabled, so
@@ -3258,7 +3239,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 	size_t l = 0;
 	bool ret = false;
 
-	prb_rec_init_rd(&r, &info, line, size, NULL, 0);
+	prb_rec_init_rd(&r, &info, line, size);
 
 	if (!dumper->active)
 		goto out;
@@ -3349,7 +3330,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	prb_rec_init_rd(&r, &info, buf, size, NULL, 0);
+	prb_rec_init_rd(&r, &info, buf, size);
 
 	if (!dumper->active || !buf || !size)
 		goto out;
@@ -3397,7 +3378,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		l += record_print_text(&r, syslog, time);
 
 		/* adjust record to store to remaining buffer space */
-		prb_rec_init_rd(&r, &info, buf + l, size - l, NULL, 0);
+		prb_rec_init_rd(&r, &info, buf + l, size - l);
 
 		seq = r.info->seq + 1;
 	}
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index de4b10a98623..13b94b92342e 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -18,18 +18,13 @@
  *     A ring of descriptors and their meta data (such as sequence number,
  *     timestamp, loglevel, etc.) as well as internal state information about
  *     the record and logical positions specifying where in the other
- *     ringbuffers the text and dictionary strings are located.
+ *     ringbuffer the text strings are located.
  *
  *   text_data_ring
  *     A ring of data blocks. A data block consists of an unsigned long
  *     integer (ID) that maps to a desc_ring index followed by the text
  *     string of the record.
  *
- *   dict_data_ring
- *     A ring of data blocks. A data block consists of an unsigned long
- *     integer (ID) that maps to a desc_ring index followed by the dictionary
- *     string of the record.
- *
  * The internal state information of a descriptor is the key element to allow
  * readers and writers to locklessly synchronize access to the data.
  *
@@ -40,8 +35,8 @@
  * ~~~~~~~~~~~~~~~
  * The descriptor ring is an array of descriptors. A descriptor contains
  * essential meta data to track the data of a printk record using
- * blk_lpos structs pointing to associated text and dictionary data blocks
- * (see "Data Rings" below). Each descriptor is assigned an ID that maps
+ * blk_lpos structs pointing to associated text data blocks (see
+ * "Data Rings" below). Each descriptor is assigned an ID that maps
  * directly to index values of the descriptor array and has a state. The ID
  * and the state are bitwise combined into a single descriptor field named
  * @state_var, allowing ID and state to be synchronously and atomically
@@ -62,8 +57,8 @@
  *     writer cannot reopen the descriptor.
  *
  *   reusable
- *     The record exists, but its text and/or dictionary data may no longer
- *     be available.
+ *     The record exists, but its text and/or meta data may no longer be
+ *     available.
  *
  * Querying the @state_var of a record requires providing the ID of the
  * descriptor to query. This can yield a possible fifth (pseudo) state:
@@ -77,7 +72,7 @@
  * When a new descriptor should be created (and the ring is full), the tail
  * descriptor is invalidated by first transitioning to the reusable state and
  * then invalidating all tail data blocks up to and including the data blocks
- * associated with the tail descriptor (for text and dictionary rings). Then
+ * associated with the tail descriptor (for the text ring). Then
  * @tail_id is advanced, followed by advancing @head_id. And finally the
  * @state_var of the new descriptor is initialized to the new ID and reserved
  * state.
@@ -108,13 +103,9 @@
  *   3) When a record is committed via prb_commit() and a newer record
  *      already exists, the record being committed is automatically finalized.
  *
- * Data Rings
- * ~~~~~~~~~~
- * The two data rings (text and dictionary) function identically. They exist
- * separately so that their buffer sizes can be individually set and they do
- * not affect one another.
- *
- * Data rings are byte arrays composed of data blocks. Data blocks are
+ * Data Ring
+ * ~~~~~~~~~
+ * The text data ring is a byte array composed of data blocks. Data blocks are
  * referenced by blk_lpos structs that point to the logical position of the
  * beginning of a data block and the beginning of the next adjacent data
  * block. Logical positions are mapped directly to index values of the byte
@@ -165,34 +156,28 @@
  * examples a global ringbuffer (test_rb) is available (which is not the
  * actual ringbuffer used by printk)::
  *
- *	DEFINE_PRINTKRB(test_rb, 15, 5, 3);
+ *	DEFINE_PRINTKRB(test_rb, 15, 5);
  *
  * This ringbuffer allows up to 32768 records (2 ^ 15) and has a size of
- * 1 MiB (2 ^ (15 + 5)) for text data and 256 KiB (2 ^ (15 + 3)) for
- * dictionary data.
+ * 1 MiB (2 ^ (15 + 5)) for text data.
  *
  * Sample writer code::
  *
- *	const char *dictstr = "dictionary text";
  *	const char *textstr = "message text";
  *	struct prb_reserved_entry e;
  *	struct printk_record r;
  *
  *	// specify how much to allocate
- *	prb_rec_init_wr(&r, strlen(textstr) + 1, strlen(dictstr) + 1);
+ *	prb_rec_init_wr(&r, strlen(textstr) + 1);
  *
  *	if (prb_reserve(&e, &test_rb, &r)) {
  *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
- *		r.info->text_len = strlen(textstr);
- *
- *		// dictionary allocation may have failed
- *		if (r.dict_buf) {
- *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
- *			r.info->dict_len = strlen(dictstr);
- *		}
  *
+ *		r.info->text_len = strlen(textstr);
  *		r.info->ts_nsec = local_clock();
+ *		r.info->caller_id = printk_caller_id();
  *
+ *		// commit and finalize the record
  *		prb_final_commit(&e);
  *	}
  *
@@ -203,8 +188,9 @@
  * Sample writer code (record extending)::
  *
  *		// alternate rest of previous example
- *		r.info->ts_nsec = local_clock();
+ *
  *		r.info->text_len = strlen(textstr);
+ *		r.info->ts_nsec = local_clock();
  *		r.info->caller_id = printk_caller_id();
  *
  *		// commit the record (but do not finalize yet)
@@ -214,7 +200,7 @@
  *	...
  *
  *	// specify additional 5 bytes text space to extend
- *	prb_rec_init_wr(&r, 5, 0);
+ *	prb_rec_init_wr(&r, 5);
  *
  *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id())) {
  *		snprintf(&r.text_buf[r.info->text_len],
@@ -222,6 +208,7 @@
  *
  *		r.info->text_len += 5;
  *
+ *		// commit and finalize the record
  *		prb_final_commit(&e);
  *	}
  *
@@ -230,11 +217,9 @@
  *	struct printk_info info;
  *	struct printk_record r;
  *	char text_buf[32];
- *	char dict_buf[32];
  *	u64 seq;
  *
- *	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf),
- *			&dict_buf[0], sizeof(dict_buf));
+ *	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf));
  *
  *	prb_for_each_record(0, &test_rb, &seq, &r) {
  *		if (info.seq != seq)
@@ -245,13 +230,8 @@
  *			text_buf[r.text_buf_size - 1] = 0;
  *		}
  *
- *		if (info.dict_len > r.dict_buf_size) {
- *			pr_warn("record %llu dict truncated\n", info.seq);
- *			dict_buf[r.dict_buf_size - 1] = 0;
- *		}
- *
- *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
- *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
+ *		pr_info("%llu: %llu: %s\n", info.seq, info.ts_nsec,
+ *			&text_buf[0]);
  *	}
  *
  * Note that additional less convenient reader functions are available to
@@ -495,8 +475,6 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 */
 	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
 	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
-	memcpy(&desc_out->dict_blk_lpos, &desc->dict_blk_lpos,
-	       sizeof(desc_out->dict_blk_lpos)); /* also part of desc_read:C */
 	if (seq_out)
 		*seq_out = info->seq; /* also part of desc_read:C */
 	if (caller_id_out)
@@ -571,7 +549,7 @@ static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 }
 
 /*
- * Given a data ring (text or dict), put the associated descriptor of each
+ * Given the text data ring, put the associated descriptor of each
  * data block from @lpos_begin until @lpos_end into the reusable state.
  *
  * If there is any problem making the associated descriptor reusable, either
@@ -586,21 +564,12 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 			       unsigned long *lpos_out)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
-	struct prb_data_blk_lpos *blk_lpos;
 	struct prb_data_block *blk;
 	enum desc_state d_state;
 	struct prb_desc desc;
+	struct prb_data_blk_lpos *blk_lpos = &desc.text_blk_lpos;
 	unsigned long id;
 
-	/*
-	 * Using the provided @data_ring, point @blk_lpos to the correct
-	 * blk_lpos within the local copy of the descriptor.
-	 */
-	if (data_ring == &rb->text_data_ring)
-		blk_lpos = &desc.text_blk_lpos;
-	else
-		blk_lpos = &desc.dict_blk_lpos;
-
 	/* Loop until @lpos_begin has advanced to or beyond @lpos_end. */
 	while ((lpos_end - lpos_begin) - 1 < DATA_SIZE(data_ring)) {
 		blk = to_block(data_ring, lpos_begin);
@@ -839,8 +808,6 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
 
 	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
 		return false;
-	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
-		return false;
 
 	/*
 	 * Check the next descriptor after @tail_id before pushing the tail
@@ -1347,9 +1314,8 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  * data.
  *
  * The writer specifies the text size to extend (not the new total size) by
- * setting the @text_buf_size field of @r. Extending dictionaries is not
- * supported, so @dict_buf_size of @r should be set to 0. To ensure proper
- * initialization of @r, prb_rec_init_wr() should be used.
+ * setting the @text_buf_size field of @r. To ensure proper initialization
+ * of @r, prb_rec_init_wr() should be used.
  *
  * This function will fail if @caller_id does not match the caller ID of the
  * newest record. In that case the caller must reserve new data using
@@ -1364,9 +1330,6 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *
  *   - @r->text_buf_size is set to the new total size of the buffer.
  *
- *   - @r->dict_buf and @r->dict_buf_size are cleared because extending
- *     the dict buffer is not supported.
- *
  *   - @r->info is not touched so that @r->info->text_len could be used
  *     to append the text.
  *
@@ -1375,8 +1338,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *
  * Important: All @r->info fields will already be set with the current values
  *            for the record. I.e. @r->info->text_len will be less than
- *            @text_buf_size and @r->info->dict_len may be set, even though
- *            @dict_buf_size is 0. Writers can use @r->info->text_len to know
+ *            @text_buf_size. Writers can use @r->info->text_len to know
  *            where concatenation begins and writers should update
  *            @r->info->text_len after concatenating.
  */
@@ -1454,10 +1416,6 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	if (r->text_buf_size && !r->text_buf)
 		goto fail;
 
-	/* Although dictionary data may be in use, it cannot be extended. */
-	r->dict_buf = NULL;
-	r->dict_buf_size = 0;
-
 	r->info = info;
 
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
@@ -1494,27 +1452,21 @@ static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
  *
  * This is the public function available to writers to reserve data.
  *
- * The writer specifies the text and dict sizes to reserve by setting the
- * @text_buf_size and @dict_buf_size fields of @r, respectively. Dictionaries
- * are optional, so @dict_buf_size is allowed to be 0. To ensure proper
- * initialization of @r, prb_rec_init_wr() should be used.
+ * The writer specifies the text size to reserve by setting the
+ * @text_buf_size field of @r. To ensure proper initialization of @r,
+ * prb_rec_init_wr() should be used.
  *
  * Context: Any context. Disables local interrupts on success.
  * Return: true if at least text data could be allocated, otherwise false.
  *
- * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
- * this function and should be filled in by the writer before committing. Also
+ * On success, the fields @info and @text_buf of @r will be set by this
+ * function and should be filled in by the writer before committing. Also
  * on success, prb_record_text_space() can be used on @e to query the actual
  * space used for the text data block.
  *
- * If the function fails to reserve dictionary space (but all else succeeded),
- * it will still report success. In that case @dict_buf is set to NULL and
- * @dict_buf_size is set to 0. Writers must check this before writing to
- * dictionary space.
- *
- * Important: @info->text_len and @info->dict_len need to be set correctly by
- *            the writer in order for data to be readable and/or extended.
- *            Their values are initialized to 0.
+ * Important: @info->text_len needs to be set correctly by the writer in
+ *            order for data to be readable and/or extended. Its value
+ *            is initialized to 0.
  */
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r)
@@ -1528,9 +1480,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 		goto fail;
 
-	if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
-		goto fail;
-
 	/*
 	 * Descriptors in the reserved state act as blockers to all further
 	 * reservations once the desc_ring has fully wrapped. Disable
@@ -1598,15 +1547,6 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		goto fail;
 	}
 
-	r->dict_buf = data_alloc(rb, &rb->dict_data_ring, r->dict_buf_size,
-				 &d->dict_blk_lpos, id);
-	/*
-	 * If dict data allocation fails, the caller can still commit
-	 * text. But dictionary information will not be available.
-	 */
-	if (r->dict_buf_size && !r->dict_buf)
-		r->dict_buf_size = 0;
-
 	r->info = info;
 
 	/* Record full text space used by record. */
@@ -1869,17 +1809,6 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 		return -ENOENT;
 	}
 
-	/*
-	 * Copy dict data. Although this should not fail, dict data is not
-	 * important. So if it fails, modify the copied meta data to report
-	 * that there is no dict data, thus silently dropping the dict data.
-	 */
-	if (!copy_data(&rb->dict_data_ring, &desc.dict_blk_lpos, info->dict_len,
-		       r->dict_buf, r->dict_buf_size, NULL)) {
-		if (r->info)
-			r->info->dict_len = 0;
-	}
-
 	/* Ensure the record is still finalized and has the same @seq. */
 	return desc_read_finalized_seq(desc_ring, id, seq, &desc);
 }
@@ -1974,7 +1903,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  *
  * This is the public function available to readers to read a record.
  *
- * The reader provides the @info, @text_buf, @dict_buf buffers of @r to be
+ * The reader provides the @info and @text_buf buffers of @r to be
  * filled in. Any of the buffer pointers can be set to NULL if the reader
  * is not interested in that data. To ensure proper initialization of @r,
  * prb_rec_init_rd() should be used.
@@ -2022,7 +1951,7 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 {
 	struct printk_record r;
 
-	prb_rec_init_rd(&r, info, NULL, 0, NULL, 0);
+	prb_rec_init_rd(&r, info, NULL, 0);
 
 	return _prb_read_valid(rb, &seq, &r, line_count);
 }
@@ -2084,8 +2013,6 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
  * @rb:       The ringbuffer to initialize.
  * @text_buf: The data buffer for text data.
  * @textbits: The size of @text_buf as a power-of-2 value.
- * @dict_buf: The data buffer for dictionary data.
- * @dictbits: The size of @dict_buf as a power-of-2 value.
  * @descs:    The descriptor buffer for ringbuffer records.
  * @descbits: The count of @descs items as a power-of-2 value.
  * @infos:    The printk_info buffer for ringbuffer records.
@@ -2099,7 +2026,6 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
  */
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int textbits,
-	      char *dict_buf, unsigned int dictbits,
 	      struct prb_desc *descs, unsigned int descbits,
 	      struct printk_info *infos)
 {
@@ -2117,18 +2043,11 @@ void prb_init(struct printk_ringbuffer *rb,
 	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
 	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
 
-	rb->dict_data_ring.size_bits = dictbits;
-	rb->dict_data_ring.data = dict_buf;
-	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
-	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
-
 	atomic_long_set(&rb->fail, 0);
 
 	atomic_long_set(&(descs[_DESCS_COUNT(descbits) - 1].state_var), DESC0_SV(descbits));
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = FAILED_LPOS;
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = FAILED_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = FAILED_LPOS;
-	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = FAILED_LPOS;
 
 	infos[0].seq = -(u64)_DESCS_COUNT(descbits);
 	infos[_DESCS_COUNT(descbits) - 1].seq = 0;
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 480499ce3c6b..0adaa685d1ca 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -9,15 +9,13 @@
 /*
  * Meta information about each stored message.
  *
- * All fields are set and used by the printk code except for
- * @seq, @text_len, @dict_len, which are set and/or modified
- * by the ringbuffer code.
+ * All fields are set by the printk code except for @seq, which is
+ * set by the ringbuffer code.
  */
 struct printk_info {
 	u64	seq;		/* sequence number */
 	u64	ts_nsec;	/* timestamp in nanoseconds */
 	u16	text_len;	/* length of text message */
-	u16	dict_len;	/* length of dictionary message */
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
@@ -30,23 +28,20 @@ struct printk_info {
  * A structure providing the buffers, used by writers and readers.
  *
  * Writers:
- * Using prb_rec_init_wr(), a writer sets @text_buf_size and @dict_buf_size
- * before calling prb_reserve(). On success, prb_reserve() sets @info,
- * @text_buf, @dict_buf to buffers reserved for that writer.
+ * Using prb_rec_init_wr(), a writer sets @text_buf_size before calling
+ * prb_reserve(). On success, prb_reserve() sets @info and @text_buf to
+ * buffers reserved for that writer.
  *
  * Readers:
  * Using prb_rec_init_rd(), a reader sets all fields before calling
- * prb_read_valid(). Note that the reader provides the @info, @text_buf,
- * @dict_buf buffers. On success, the struct pointed to by @info will be
- * filled and the char arrays pointed to by @text_buf and @dict_buf will
- * be filled with text and dict data.
+ * prb_read_valid(). Note that the reader provides the @info and @text_buf,
+ * buffers. On success, the struct pointed to by @info will be filled and
+ * the char array pointed to by @text_buf will be filled with text data.
  */
 struct printk_record {
 	struct printk_info	*info;
 	char			*text_buf;
-	char			*dict_buf;
 	unsigned int		text_buf_size;
-	unsigned int		dict_buf_size;
 };
 
 /* Specifies the logical position and span of a data block. */
@@ -63,7 +58,6 @@ struct prb_data_blk_lpos {
 struct prb_desc {
 	atomic_long_t			state_var;
 	struct prb_data_blk_lpos	text_blk_lpos;
-	struct prb_data_blk_lpos	dict_blk_lpos;
 };
 
 /* A ringbuffer of "ID + data" elements. */
@@ -92,7 +86,6 @@ struct prb_desc_ring {
 struct printk_ringbuffer {
 	struct prb_desc_ring	desc_ring;
 	struct prb_data_ring	text_data_ring;
-	struct prb_data_ring	dict_data_ring;
 	atomic_long_t		fail;
 };
 
@@ -236,9 +229,7 @@ enum desc_state {
  * Note: The specified external buffer must be of the size:
  *       2 ^ (descbits + avgtextbits)
  */
-#define _DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, text_buf)			\
-static char _##name##_dict[1U << ((avgdictbits) + (descbits))]					\
-			__aligned(__alignof__(unsigned long));					\
+#define _DEFINE_PRINTKRB(name, descbits, avgtextbits, text_buf)			\
 static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 	/* the initial head and tail */								\
 	[_DESCS_COUNT(descbits) - 1] = {							\
@@ -246,7 +237,6 @@ static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 		.state_var	= ATOMIC_INIT(DESC0_SV(descbits)),				\
 		/* no associated data block */							\
 		.text_blk_lpos	= FAILED_BLK_LPOS,						\
-		.dict_blk_lpos	= FAILED_BLK_LPOS,						\
 	},											\
 };												\
 static struct printk_info _##name##_infos[_DESCS_COUNT(descbits)] = {				\
@@ -275,12 +265,6 @@ static struct printk_ringbuffer name = {							\
 		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
 		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
 	},											\
-	.dict_data_ring = {									\
-		.size_bits	= (avgtextbits) + (descbits),					\
-		.data		= &_##name##_dict[0],						\
-		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
-		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS((avgtextbits) + (descbits))),	\
-	},											\
 	.fail			= ATOMIC_LONG_INIT(0),						\
 }
 
@@ -290,17 +274,15 @@ static struct printk_ringbuffer name = {							\
  * @name:        The name of the ringbuffer variable.
  * @descbits:    The number of descriptors as a power-of-2 value.
  * @avgtextbits: The average text data size per record as a power-of-2 value.
- * @avgdictbits: The average dictionary data size per record as a
- *               power-of-2 value.
  *
  * This is a macro for defining a ringbuffer and all internal structures
  * such that it is ready for immediate use. See _DEFINE_PRINTKRB() for a
  * variant where the text data buffer can be specified externally.
  */
-#define DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits)		\
+#define DEFINE_PRINTKRB(name, descbits, avgtextbits)				\
 static char _##name##_text[1U << ((avgtextbits) + (descbits))]			\
 			__aligned(__alignof__(unsigned long));			\
-_DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, &_##name##_text[0])
+_DEFINE_PRINTKRB(name, descbits, avgtextbits, &_##name##_text[0])
 
 /* Writer Interface */
 
@@ -309,26 +291,13 @@ _DEFINE_PRINTKRB(name, descbits, avgtextbits, avgdictbits, &_##name##_text[0])
  *
  * @r:             The record to initialize.
  * @text_buf_size: The needed text buffer size.
- * @dict_buf_size: The needed dictionary buffer size.
- *
- * Initialize all the fields that a writer is interested in. If
- * @dict_buf_size is 0, a dictionary buffer will not be reserved.
- * @text_buf_size must be greater than 0.
- *
- * Note that although @dict_buf_size may be initialized to non-zero,
- * its value must be rechecked after a successful call to prb_reserve()
- * to verify a dictionary buffer was actually reserved. Dictionary buffer
- * reservation is allowed to fail.
  */
 static inline void prb_rec_init_wr(struct printk_record *r,
-				   unsigned int text_buf_size,
-				   unsigned int dict_buf_size)
+				   unsigned int text_buf_size)
 {
 	r->info = NULL;
 	r->text_buf = NULL;
-	r->dict_buf = NULL;
 	r->text_buf_size = text_buf_size;
-	r->dict_buf_size = dict_buf_size;
 }
 
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
@@ -340,7 +309,6 @@ void prb_final_commit(struct prb_reserved_entry *e);
 
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
-	      char *dict_buf, unsigned int dict_buf_size,
 	      struct prb_desc *descs, unsigned int descs_count_bits,
 	      struct printk_info *infos);
 unsigned int prb_record_text_space(struct prb_reserved_entry *e);
@@ -354,8 +322,6 @@ unsigned int prb_record_text_space(struct prb_reserved_entry *e);
  * @info:          A buffer to store record meta-data.
  * @text_buf:      A buffer to store text data.
  * @text_buf_size: The size of @text_buf.
- * @dict_buf:      A buffer to store dictionary data.
- * @dict_buf_size: The size of @dict_buf.
  *
  * Initialize all the fields that a reader is interested in. All arguments
  * (except @r) are optional. Only record data for arguments that are
@@ -363,14 +329,11 @@ unsigned int prb_record_text_space(struct prb_reserved_entry *e);
  */
 static inline void prb_rec_init_rd(struct printk_record *r,
 				   struct printk_info *info,
-				   char *text_buf, unsigned int text_buf_size,
-				   char *dict_buf, unsigned int dict_buf_size)
+				   char *text_buf, unsigned int text_buf_size)
 {
 	r->info = info;
 	r->text_buf = text_buf;
-	r->dict_buf = dict_buf;
 	r->text_buf_size = text_buf_size;
-	r->dict_buf_size = dict_buf_size;
 }
 
 /**
-- 
2.20.1

