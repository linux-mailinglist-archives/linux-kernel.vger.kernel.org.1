Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9826924FB98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgHXKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHXKfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA5CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:35:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598265341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xr2BRdoawTl4w5dFYbUaenmePmf0VtSg3PloqhjxBFI=;
        b=Cg67DwcSCdHgU/RAN47A6w73ocQcSRfsNzZgSarrp3pg/jQqeOYVZyObhGTEw0NX6GYMwE
        KuHE/eByvB3H0mzy8HOsdFN8H/vRN7EAPqPxEXBl7tvMPaOwOPtzf1M6L18J3O5ZW8TSAN
        WtsowXlLLwRrsm2m/E47323SPNm+xVX2B7ObfI+CeZ7GGwCIKmOvom/TgN3LmAG14gujrM
        GPUNSSSlBvpCAVNy9a2bwdSGMM1m8V3ES+vGCh7p32TnteGD2cJMf7J1aORLJvOGozFUic
        KlG1bIcogaxPiWTesG7phtalD8/zwfDZtEuYnsBunhAZou8EO3Dpycxk8k1B8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598265341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xr2BRdoawTl4w5dFYbUaenmePmf0VtSg3PloqhjxBFI=;
        b=X1GDLG1KOyA1IPuXfpRDQ6qpCmEu1JmJ1/V3LagUqhPR1y8FuPYvCPp8rrIm1CusyQTaLG
        1I0ksym4rGXqJXCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7][next] printk: ringbuffer: relocate get_data()
Date:   Mon, 24 Aug 2020 12:41:34 +0206
Message-Id: <20200824103538.31446-4-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the internal get_data() function as-is above prb_reserve() so
that a later change can make use of the static function.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 116 +++++++++++++++---------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d339ff7647da..86af38c2cf77 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1038,6 +1038,64 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 		DATA_SIZE(data_ring) - DATA_INDEX(data_ring, blk_lpos->begin));
 }
 
+/*
+ * Given @blk_lpos, return a pointer to the writer data from the data block
+ * and calculate the size of the data part. A NULL pointer is returned if
+ * @blk_lpos specifies values that could never be legal.
+ *
+ * This function (used by readers) performs strict validation on the lpos
+ * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
+ * triggered if an internal error is detected.
+ */
+static const char *get_data(struct prb_data_ring *data_ring,
+			    struct prb_data_blk_lpos *blk_lpos,
+			    unsigned int *data_size)
+{
+	struct prb_data_block *db;
+
+	/* Data-less data block description. */
+	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+			*data_size = 0;
+			return "";
+		}
+		return NULL;
+	}
+
+	/* Regular data block: @begin less than @next and in same wrap. */
+	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
+	    blk_lpos->begin < blk_lpos->next) {
+		db = to_block(data_ring, blk_lpos->begin);
+		*data_size = blk_lpos->next - blk_lpos->begin;
+
+	/* Wrapping data block: @begin is one wrap behind @next. */
+	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
+		   DATA_WRAPS(data_ring, blk_lpos->next)) {
+		db = to_block(data_ring, 0);
+		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
+
+	/* Illegal block description. */
+	} else {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	/* A valid data block will always be aligned to the ID size. */
+	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
+	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
+		return NULL;
+	}
+
+	/* A valid data block will always have at least an ID. */
+	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
+		return NULL;
+
+	/* Subtract block ID space from size to reflect data size. */
+	*data_size -= sizeof(db->id);
+
+	return &db->data[0];
+}
+
 /**
  * prb_reserve() - Reserve space in the ringbuffer.
  *
@@ -1192,64 +1250,6 @@ void prb_commit(struct prb_reserved_entry *e)
 	local_irq_restore(e->irqflags);
 }
 
-/*
- * Given @blk_lpos, return a pointer to the writer data from the data block
- * and calculate the size of the data part. A NULL pointer is returned if
- * @blk_lpos specifies values that could never be legal.
- *
- * This function (used by readers) performs strict validation on the lpos
- * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
- * triggered if an internal error is detected.
- */
-static const char *get_data(struct prb_data_ring *data_ring,
-			    struct prb_data_blk_lpos *blk_lpos,
-			    unsigned int *data_size)
-{
-	struct prb_data_block *db;
-
-	/* Data-less data block description. */
-	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
-			*data_size = 0;
-			return "";
-		}
-		return NULL;
-	}
-
-	/* Regular data block: @begin less than @next and in same wrap. */
-	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next) &&
-	    blk_lpos->begin < blk_lpos->next) {
-		db = to_block(data_ring, blk_lpos->begin);
-		*data_size = blk_lpos->next - blk_lpos->begin;
-
-	/* Wrapping data block: @begin is one wrap behind @next. */
-	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
-		   DATA_WRAPS(data_ring, blk_lpos->next)) {
-		db = to_block(data_ring, 0);
-		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
-
-	/* Illegal block description. */
-	} else {
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-
-	/* A valid data block will always be aligned to the ID size. */
-	if (WARN_ON_ONCE(blk_lpos->begin != ALIGN(blk_lpos->begin, sizeof(db->id))) ||
-	    WARN_ON_ONCE(blk_lpos->next != ALIGN(blk_lpos->next, sizeof(db->id)))) {
-		return NULL;
-	}
-
-	/* A valid data block will always have at least an ID. */
-	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
-		return NULL;
-
-	/* Subtract block ID space from size to reflect data size. */
-	*data_size -= sizeof(db->id);
-
-	return &db->data[0];
-}
-
 /*
  * Count the number of lines in provided text. All text has at least 1 line
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
-- 
2.20.1

