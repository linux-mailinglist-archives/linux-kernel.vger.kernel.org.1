Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204702708F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 00:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 18:34:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgIRWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 18:34:28 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600468462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxwdSINgH/ybNrm9Es0mY/X6x7ilUXD5kQLkarCuzY8=;
        b=kIDhSa1cnUeH2NUVi4l6SbnrpMdfJI3Cli1qpvaNaurBhcioY9ON1lalKIPLsnbOL5v4lg
        hyqZ6XE4FGpkoetuhv8K/WIzcErb8pkNVXwEFVhel+Up5y+Q79f09ucDwPpn+RMRrluumw
        lKMwuxbGyerb4gt6EyruoJs2+Ro/IuC3B44NlyDUxAB15Q+VP1cRZNCGrJuRwhQuK6jn/I
        lZDQgvCfMA2Bkj6OfFRe8X5OmE6tDBAiUYIdf9lKH0oplxCXuPgzeA4rZQ7yehCntwMbTg
        4lwDKBNCjLHVC+eJwZX7xvOvX9ILQ5Mu1w/4ev+AyaPE+7UYuw1KbfPbhRZvxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600468462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxwdSINgH/ybNrm9Es0mY/X6x7ilUXD5kQLkarCuzY8=;
        b=YEGabDtRAqvhYywg1pld04p1bFheh7tdFMERe7YfZjsun1r2ZRV+pYyDhG7NEdt8IyL8RJ
        9My5AwXoR7oLzgAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 1/3] printk: move printk_info into separate array
Date:   Sat, 19 Sep 2020 00:40:19 +0206
Message-Id: <20200918223421.21621-2-john.ogness@linutronix.de>
In-Reply-To: <20200918223421.21621-1-john.ogness@linutronix.de>
References: <20200918223421.21621-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the size of a descriptor is taken up by meta data,
which is often not of interest to the ringbuffer (for example,
when performing state checks). Since descriptors are often
temporarily stored on the stack, keeping their size minimal will
help reduce stack pressure.

Rather than embedding the printk_info into the descriptor, create
a separate printk_info array. The index of a descriptor in the
descriptor array corresponds to the printk_info with the same
index in the printk_info array. The rules for validity of a
printk_info match the existing rules for the data blocks: the
descriptor must be in a consistent state.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            |  30 +++++--
 kernel/printk/printk_ringbuffer.c | 145 +++++++++++++++++++-----------
 kernel/printk/printk_ringbuffer.h |  29 +++---
 3 files changed, 133 insertions(+), 71 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a2e23191576..25cfe4fe48af 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -959,11 +959,11 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_STRUCT_SIZE(prb_desc_ring);
 	VMCOREINFO_OFFSET(prb_desc_ring, count_bits);
 	VMCOREINFO_OFFSET(prb_desc_ring, descs);
+	VMCOREINFO_OFFSET(prb_desc_ring, infos);
 	VMCOREINFO_OFFSET(prb_desc_ring, head_id);
 	VMCOREINFO_OFFSET(prb_desc_ring, tail_id);
 
 	VMCOREINFO_STRUCT_SIZE(prb_desc);
-	VMCOREINFO_OFFSET(prb_desc, info);
 	VMCOREINFO_OFFSET(prb_desc, state_var);
 	VMCOREINFO_OFFSET(prb_desc, text_blk_lpos);
 	VMCOREINFO_OFFSET(prb_desc, dict_blk_lpos);
@@ -1097,11 +1097,13 @@ static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
 
 void __init setup_log_buf(int early)
 {
+	struct printk_info *new_infos;
 	unsigned int new_descs_count;
 	struct prb_desc *new_descs;
 	struct printk_info info;
 	struct printk_record r;
 	size_t new_descs_size;
+	size_t new_infos_size;
 	unsigned long flags;
 	char *new_dict_buf;
 	char *new_log_buf;
@@ -1142,8 +1144,7 @@ void __init setup_log_buf(int early)
 	if (unlikely(!new_dict_buf)) {
 		pr_err("log_buf_len: %lu dict bytes not available\n",
 		       new_log_buf_len);
-		memblock_free(__pa(new_log_buf), new_log_buf_len);
-		return;
+		goto err_free_log_buf;
 	}
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
@@ -1151,9 +1152,15 @@ void __init setup_log_buf(int early)
 	if (unlikely(!new_descs)) {
 		pr_err("log_buf_len: %zu desc bytes not available\n",
 		       new_descs_size);
-		memblock_free(__pa(new_dict_buf), new_log_buf_len);
-		memblock_free(__pa(new_log_buf), new_log_buf_len);
-		return;
+		goto err_free_dict_buf;
+	}
+
+	new_infos_size = new_descs_count * sizeof(struct printk_info);
+	new_infos = memblock_alloc(new_infos_size, LOG_ALIGN);
+	if (unlikely(!new_infos)) {
+		pr_err("log_buf_len: %zu info bytes not available\n",
+		       new_infos_size);
+		goto err_free_descs;
 	}
 
 	prb_rec_init_rd(&r, &info,
@@ -1163,7 +1170,8 @@ void __init setup_log_buf(int early)
 	prb_init(&printk_rb_dynamic,
 		 new_log_buf, ilog2(new_log_buf_len),
 		 new_dict_buf, ilog2(new_log_buf_len),
-		 new_descs, ilog2(new_descs_count));
+		 new_descs, ilog2(new_descs_count),
+		 new_infos);
 
 	logbuf_lock_irqsave(flags);
 
@@ -1192,6 +1200,14 @@ void __init setup_log_buf(int early)
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
 	pr_info("early log buf free: %u(%u%%)\n",
 		free, (free * 100) / __LOG_BUF_LEN);
+	return;
+
+err_free_descs:
+	memblock_free(__pa(new_descs), new_descs_size);
+err_free_dict_buf:
+	memblock_free(__pa(new_dict_buf), new_log_buf_len);
+err_free_log_buf:
+	memblock_free(__pa(new_log_buf), new_log_buf_len);
 }
 
 static bool __read_mostly ignore_loglevel;
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index f4e2e9890e0f..de4b10a98623 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -15,10 +15,10 @@
  * The printk_ringbuffer is made up of 3 internal ringbuffers:
  *
  *   desc_ring
- *     A ring of descriptors. A descriptor contains all record meta data
- *     (sequence number, timestamp, loglevel, etc.) as well as internal state
- *     information about the record and logical positions specifying where in
- *     the other ringbuffers the text and dictionary strings are located.
+ *     A ring of descriptors and their meta data (such as sequence number,
+ *     timestamp, loglevel, etc.) as well as internal state information about
+ *     the record and logical positions specifying where in the other
+ *     ringbuffers the text and dictionary strings are located.
  *
  *   text_data_ring
  *     A ring of data blocks. A data block consists of an unsigned long
@@ -38,13 +38,14 @@
  *
  * Descriptor Ring
  * ~~~~~~~~~~~~~~~
- * The descriptor ring is an array of descriptors. A descriptor contains all
- * the meta data of a printk record as well as blk_lpos structs pointing to
- * associated text and dictionary data blocks (see "Data Rings" below). Each
- * descriptor is assigned an ID that maps directly to index values of the
- * descriptor array and has a state. The ID and the state are bitwise combined
- * into a single descriptor field named @state_var, allowing ID and state to
- * be synchronously and atomically updated.
+ * The descriptor ring is an array of descriptors. A descriptor contains
+ * essential meta data to track the data of a printk record using
+ * blk_lpos structs pointing to associated text and dictionary data blocks
+ * (see "Data Rings" below). Each descriptor is assigned an ID that maps
+ * directly to index values of the descriptor array and has a state. The ID
+ * and the state are bitwise combined into a single descriptor field named
+ * @state_var, allowing ID and state to be synchronously and atomically
+ * updated.
  *
  * Descriptors have four states:
  *
@@ -150,6 +151,14 @@
  * descriptor. If a data block is not valid, the @tail_lpos cannot be
  * advanced beyond it.
  *
+ * Info Array
+ * ~~~~~~~~~~
+ * The general meta data of printk records are stored in printk_info structs,
+ * stored in an array with the same number of elements as the descriptor ring.
+ * Each info corresponds to the descriptor of the same index in the
+ * descriptor ring. Info validity is confirmed by evaluating the corresponding
+ * descriptor before and after loading the info.
+ *
  * Usage
  * -----
  * Here are some simple examples demonstrating writers and readers. For the
@@ -367,6 +376,15 @@ static struct prb_desc *to_desc(struct prb_desc_ring *desc_ring, u64 n)
 	return &desc_ring->descs[DESC_INDEX(desc_ring, n)];
 }
 
+/*
+ * Return the printk_info associated with @n. @n can be either a
+ * descriptor ID or a sequence number.
+ */
+static struct printk_info *to_info(struct prb_desc_ring *desc_ring, u64 n)
+{
+	return &desc_ring->infos[DESC_INDEX(desc_ring, n)];
+}
+
 static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
 				       unsigned long begin_lpos)
 {
@@ -425,10 +443,16 @@ static enum desc_state get_desc_state(unsigned long id,
  * Get a copy of a specified descriptor and return its queried state. If the
  * descriptor is in an inconsistent state (miss or reserved), the caller can
  * only expect the descriptor's @state_var field to be valid.
+ *
+ * The sequence number and caller_id can be optionally retrieved. Like all
+ * non-state_var data, they are only valid if the descriptor is in a
+ * consistent state.
  */
 static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
-				 unsigned long id, struct prb_desc *desc_out)
+				 unsigned long id, struct prb_desc *desc_out,
+				 u64 *seq_out, u32 *caller_id_out)
 {
+	struct printk_info *info = to_info(desc_ring, id);
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
 	enum desc_state d_state;
@@ -469,11 +493,14 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 * state has been re-checked. A memcpy() for all of @desc
 	 * cannot be used because of the atomic_t @state_var field.
 	 */
-	memcpy(&desc_out->info, &desc->info, sizeof(desc_out->info)); /* LMM(desc_read:C) */
 	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
-	       sizeof(desc_out->text_blk_lpos)); /* also part of desc_read:C */
+	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
 	memcpy(&desc_out->dict_blk_lpos, &desc->dict_blk_lpos,
 	       sizeof(desc_out->dict_blk_lpos)); /* also part of desc_read:C */
+	if (seq_out)
+		*seq_out = info->seq; /* also part of desc_read:C */
+	if (caller_id_out)
+		*caller_id_out = info->caller_id; /* also part of desc_read:C */
 
 	/*
 	 * 1. Guarantee the descriptor content is loaded before re-checking
@@ -588,7 +615,8 @@ static bool data_make_reusable(struct printk_ringbuffer *rb,
 		 */
 		id = blk->id; /* LMM(data_make_reusable:A) */
 
-		d_state = desc_read(desc_ring, id, &desc); /* LMM(data_make_reusable:B) */
+		d_state = desc_read(desc_ring, id, &desc,
+				    NULL, NULL); /* LMM(data_make_reusable:B) */
 
 		switch (d_state) {
 		case desc_miss:
@@ -771,7 +799,7 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
 	enum desc_state d_state;
 	struct prb_desc desc;
 
-	d_state = desc_read(desc_ring, tail_id, &desc);
+	d_state = desc_read(desc_ring, tail_id, &desc, NULL, NULL);
 
 	switch (d_state) {
 	case desc_miss:
@@ -823,7 +851,8 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
 	 * equal to @head_id so there is no risk of pushing the tail past the
 	 * head.
 	 */
-	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1), &desc); /* LMM(desc_push_tail:A) */
+	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1), &desc,
+			    NULL, NULL); /* LMM(desc_push_tail:A) */
 
 	if (d_state == desc_finalized || d_state == desc_reusable) {
 		/*
@@ -1264,6 +1293,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
 	struct prb_desc desc;
 	struct prb_desc *d;
 	unsigned long id;
+	u32 cid;
 
 	id = atomic_long_read(&desc_ring->head_id);
 
@@ -1271,8 +1301,8 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
 	 * To reduce unnecessarily reopening, first check if the descriptor
 	 * state and caller ID are correct.
 	 */
-	d_state = desc_read(desc_ring, id, &desc);
-	if (d_state != desc_committed || desc.info.caller_id != caller_id)
+	d_state = desc_read(desc_ring, id, &desc, NULL, &cid);
+	if (d_state != desc_committed || cid != caller_id)
 		return NULL;
 
 	d = to_desc(desc_ring, id);
@@ -1353,6 +1383,8 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 			 struct printk_record *r, u32 caller_id)
 {
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct printk_info *info;
 	unsigned int data_size;
 	struct prb_desc *d;
 	unsigned long id;
@@ -1360,7 +1392,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	local_irq_save(e->irqflags);
 
 	/* Transition the newest descriptor back to the reserved state. */
-	d = desc_reopen_last(&rb->desc_ring, caller_id, &id);
+	d = desc_reopen_last(desc_ring, caller_id, &id);
 	if (!d) {
 		local_irq_restore(e->irqflags);
 		goto fail_reopen;
@@ -1368,6 +1400,8 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 
 	/* Now the writer has exclusive access: LMM(prb_reserve_in_last:A) */
 
+	info = to_info(desc_ring, id);
+
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
 	 * anything fails from now on.
@@ -1380,14 +1414,14 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	 * exclusive access at that point. The descriptor may have
 	 * changed since then.
 	 */
-	if (caller_id != d->info.caller_id)
+	if (caller_id != info->caller_id)
 		goto fail;
 
 	if (BLK_DATALESS(&d->text_blk_lpos)) {
-		if (WARN_ON_ONCE(d->info.text_len != 0)) {
+		if (WARN_ON_ONCE(info->text_len != 0)) {
 			pr_warn_once("wrong text_len value (%hu, expecting 0)\n",
-				     d->info.text_len);
-			d->info.text_len = 0;
+				     info->text_len);
+			info->text_len = 0;
 		}
 
 		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
@@ -1404,12 +1438,12 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 		 * the meta data (@text_len) is not sane, use the full data
 		 * block size.
 		 */
-		if (WARN_ON_ONCE(d->info.text_len > data_size)) {
+		if (WARN_ON_ONCE(info->text_len > data_size)) {
 			pr_warn_once("wrong text_len value (%hu, expecting <=%u)\n",
-				     d->info.text_len, data_size);
-			d->info.text_len = data_size;
+				     info->text_len, data_size);
+			info->text_len = data_size;
 		}
-		r->text_buf_size += d->info.text_len;
+		r->text_buf_size += info->text_len;
 
 		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
 			goto fail;
@@ -1424,7 +1458,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	r->dict_buf = NULL;
 	r->dict_buf_size = 0;
 
-	r->info = &d->info;
+	r->info = info;
 
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
 
@@ -1486,6 +1520,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct printk_info *info;
 	struct prb_desc *d;
 	unsigned long id;
 	u64 seq;
@@ -1512,14 +1547,15 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	}
 
 	d = to_desc(desc_ring, id);
+	info = to_info(desc_ring, id);
 
 	/*
 	 * All @info fields (except @seq) are cleared and must be filled in
 	 * by the writer. Save @seq before clearing because it is used to
 	 * determine the new sequence number.
 	 */
-	seq = d->info.seq;
-	memset(&d->info, 0, sizeof(d->info));
+	seq = info->seq;
+	memset(info, 0, sizeof(*info));
 
 	/*
 	 * Set the @e fields here so that prb_commit() can be used if
@@ -1533,16 +1569,16 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	 * Otherwise just increment it by a full wrap.
 	 *
 	 * @seq is considered "never been set" if it has a value of 0,
-	 * _except_ for @descs[0], which was specially setup by the ringbuffer
+	 * _except_ for @infos[0], which was specially setup by the ringbuffer
 	 * initializer and therefore is always considered as set.
 	 *
 	 * See the "Bootstrap" comment block in printk_ringbuffer.h for
 	 * details about how the initializer bootstraps the descriptors.
 	 */
 	if (seq == 0 && DESC_INDEX(desc_ring, id) != 0)
-		d->info.seq = DESC_INDEX(desc_ring, id);
+		info->seq = DESC_INDEX(desc_ring, id);
 	else
-		d->info.seq = seq + DESCS_COUNT(desc_ring);
+		info->seq = seq + DESCS_COUNT(desc_ring);
 
 	/*
 	 * New data is about to be reserved. Once that happens, previous
@@ -1550,7 +1586,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	 * previous descriptor now so that it can be made available to
 	 * readers. (For seq==0 there is no previous descriptor.)
 	 */
-	if (d->info.seq > 0)
+	if (info->seq > 0)
 		desc_make_final(desc_ring, DESC_ID(id - 1));
 
 	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
@@ -1571,7 +1607,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (r->dict_buf_size && !r->dict_buf)
 		r->dict_buf_size = 0;
 
-	r->info = &d->info;
+	r->info = info;
 
 	/* Record full text space used by record. */
 	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
@@ -1726,12 +1762,12 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	/*
 	 * Actual cannot be less than expected. It can be more than expected
 	 * because of the trailing alignment padding.
+	 *
+	 * Note that invalid @len values can occur because the caller loads
+	 * the value during an allowed data race.
 	 */
-	if (WARN_ON_ONCE(data_size < (unsigned int)len)) {
-		pr_warn_once("wrong data size (%u, expecting >=%hu) for data: %.*s\n",
-			     data_size, len, data_size, data);
+	if (data_size < (unsigned int)len)
 		return false;
-	}
 
 	/* Caller interested in the line count? */
 	if (line_count)
@@ -1764,8 +1800,9 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
 {
 	struct prb_data_blk_lpos *blk_lpos = &desc_out->text_blk_lpos;
 	enum desc_state d_state;
+	u64 s;
 
-	d_state = desc_read(desc_ring, id, desc_out);
+	d_state = desc_read(desc_ring, id, desc_out, &s, NULL);
 
 	/*
 	 * An unexpected @id (desc_miss) or @seq mismatch means the record
@@ -1775,7 +1812,7 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
 	if (d_state == desc_miss ||
 	    d_state == desc_reserved ||
 	    d_state == desc_committed ||
-	    desc_out->info.seq != seq) {
+	    s != seq) {
 		return -EINVAL;
 	}
 
@@ -1802,6 +1839,7 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r, unsigned int *line_count)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct printk_info *info = to_info(desc_ring, seq);
 	struct prb_desc *rdesc = to_desc(desc_ring, seq);
 	atomic_long_t *state_var = &rdesc->state_var;
 	struct prb_desc desc;
@@ -1823,10 +1861,10 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 
 	/* If requested, copy meta data. */
 	if (r->info)
-		memcpy(r->info, &desc.info, sizeof(*(r->info)));
+		memcpy(r->info, info, sizeof(*(r->info)));
 
 	/* Copy text data. If it fails, this is a data-less record. */
-	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
+	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, info->text_len,
 		       r->text_buf, r->text_buf_size, line_count)) {
 		return -ENOENT;
 	}
@@ -1836,7 +1874,7 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
 	 * important. So if it fails, modify the copied meta data to report
 	 * that there is no dict data, thus silently dropping the dict data.
 	 */
-	if (!copy_data(&rb->dict_data_ring, &desc.dict_blk_lpos, desc.info.dict_len,
+	if (!copy_data(&rb->dict_data_ring, &desc.dict_blk_lpos, info->dict_len,
 		       r->dict_buf, r->dict_buf_size, NULL)) {
 		if (r->info)
 			r->info->dict_len = 0;
@@ -1853,11 +1891,12 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 	enum desc_state d_state;
 	struct prb_desc desc;
 	unsigned long id;
+	u64 seq;
 
 	for (;;) {
 		id = atomic_long_read(&rb->desc_ring.tail_id); /* LMM(prb_first_seq:A) */
 
-		d_state = desc_read(desc_ring, id, &desc); /* LMM(prb_first_seq:B) */
+		d_state = desc_read(desc_ring, id, &desc, &seq, NULL); /* LMM(prb_first_seq:B) */
 
 		/*
 		 * This loop will not be infinite because the tail is
@@ -1886,7 +1925,7 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 		smp_rmb(); /* LMM(prb_first_seq:C) */
 	}
 
-	return desc.info.seq;
+	return seq;
 }
 
 /*
@@ -2049,6 +2088,7 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
  * @dictbits: The size of @dict_buf as a power-of-2 value.
  * @descs:    The descriptor buffer for ringbuffer records.
  * @descbits: The count of @descs items as a power-of-2 value.
+ * @infos:    The printk_info buffer for ringbuffer records.
  *
  * This is the public function available to writers to setup a ringbuffer
  * during runtime using provided buffers.
@@ -2060,12 +2100,15 @@ u64 prb_next_seq(struct printk_ringbuffer *rb)
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int textbits,
 	      char *dict_buf, unsigned int dictbits,
-	      struct prb_desc *descs, unsigned int descbits)
+	      struct prb_desc *descs, unsigned int descbits,
+	      struct printk_info *infos)
 {
 	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
+	memset(infos, 0, _DESCS_COUNT(descbits) * sizeof(infos[0]));
 
 	rb->desc_ring.count_bits = descbits;
 	rb->desc_ring.descs = descs;
+	rb->desc_ring.infos = infos;
 	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
 	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
 
@@ -2081,14 +2124,14 @@ void prb_init(struct printk_ringbuffer *rb,
 
 	atomic_long_set(&rb->fail, 0);
 
-	descs[0].info.seq = -(u64)_DESCS_COUNT(descbits);
-
-	descs[_DESCS_COUNT(descbits) - 1].info.seq = 0;
 	atomic_long_set(&(descs[_DESCS_COUNT(descbits) - 1].state_var), DESC0_SV(descbits));
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.begin = FAILED_LPOS;
 	descs[_DESCS_COUNT(descbits) - 1].text_blk_lpos.next = FAILED_LPOS;
 	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.begin = FAILED_LPOS;
 	descs[_DESCS_COUNT(descbits) - 1].dict_blk_lpos.next = FAILED_LPOS;
+
+	infos[0].seq = -(u64)_DESCS_COUNT(descbits);
+	infos[_DESCS_COUNT(descbits) - 1].seq = 0;
 }
 
 /**
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 853ea62dc5f2..97c8561e74e0 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -58,7 +58,6 @@ struct prb_data_blk_lpos {
  * @state_var: A bitwise combination of descriptor ID and descriptor state.
  */
 struct prb_desc {
-	struct printk_info		info;
 	atomic_long_t			state_var;
 	struct prb_data_blk_lpos	text_blk_lpos;
 	struct prb_data_blk_lpos	dict_blk_lpos;
@@ -76,6 +75,7 @@ struct prb_data_ring {
 struct prb_desc_ring {
 	unsigned int		count_bits;
 	struct prb_desc		*descs;
+	struct printk_info	*infos;
 	atomic_long_t		head_id;
 	atomic_long_t		tail_id;
 };
@@ -237,19 +237,8 @@ enum desc_state {
 static char _##name##_dict[1U << ((avgdictbits) + (descbits))]					\
 			__aligned(__alignof__(unsigned long));					\
 static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
-	/* this will be the first record reserved by a writer */				\
-	[0] = {											\
-		.info = {									\
-			/* will be incremented to 0 on the first reservation */			\
-			.seq = -(u64)_DESCS_COUNT(descbits),					\
-		},										\
-	},											\
 	/* the initial head and tail */								\
 	[_DESCS_COUNT(descbits) - 1] = {							\
-		.info = {									\
-			/* reports the first seq value during the bootstrap phase */		\
-			.seq = 0,								\
-		},										\
 		/* reusable */									\
 		.state_var	= ATOMIC_INIT(DESC0_SV(descbits)),				\
 		/* no associated data block */							\
@@ -257,10 +246,23 @@ static struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {				\
 		.dict_blk_lpos	= FAILED_BLK_LPOS,						\
 	},											\
 };												\
+static struct printk_info _##name##_infos[_DESCS_COUNT(descbits)] = {				\
+	/* this will be the first record reserved by a writer */				\
+	[0] = {											\
+		/* will be incremented to 0 on the first reservation */				\
+		.seq = -(u64)_DESCS_COUNT(descbits),						\
+	},											\
+	/* the initial head and tail */								\
+	[_DESCS_COUNT(descbits) - 1] = {							\
+		/* reports the first seq value during the bootstrap phase */			\
+		.seq = 0,									\
+	},											\
+};												\
 static struct printk_ringbuffer name = {							\
 	.desc_ring = {										\
 		.count_bits	= descbits,							\
 		.descs		= &_##name##_descs[0],						\
+		.infos		= &_##name##_infos[0],						\
 		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 	},											\
@@ -336,7 +338,8 @@ void prb_final_commit(struct prb_reserved_entry *e);
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
 	      char *dict_buf, unsigned int dict_buf_size,
-	      struct prb_desc *descs, unsigned int descs_count_bits);
+	      struct prb_desc *descs, unsigned int descs_count_bits,
+	      struct printk_info *infos);
 unsigned int prb_record_text_space(struct prb_reserved_entry *e);
 
 /* Reader Interface */
-- 
2.20.1

