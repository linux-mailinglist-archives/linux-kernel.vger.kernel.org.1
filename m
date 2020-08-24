Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC824FB93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHXKgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgHXKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:35:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D36C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:35:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598265341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQZCM5RH3+FQncBvcW/JtbcKOfyCCSpTYj3zGLs1+4s=;
        b=sl2stRPwyIgdC3nsN7sN+H772Iv6rOFRhyti0XCQH+y+/LhVd3MZimydfvc1CYpdUnZ2/M
        J25o287neVaVIevPkD/wof+M+1Q7z+pQ2+RvfNXzbexby+qf6w9T+82hy0l7n0y6ifz5vZ
        W6K7pgt6GX3ShvHC1aSBIf0FwpvH0clhtSP1pdKX1fZEWS60RhXOobw24wRWCU/UHIJ1p9
        CkNf9lnEGB8NzztQQL3N5RqWeb5y90JAxYty3YsTV6roJTH0lFCKGtk3dW2L5QvkZ3D+EU
        TGb8doW081u0YXqUu8oCE58L/GF56yrmhnHs1xyUXR8vWt/2LfuhGJvbr1WMuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598265341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQZCM5RH3+FQncBvcW/JtbcKOfyCCSpTYj3zGLs1+4s=;
        b=c+1we00EOZhLLyJeO8dZtl+60pkWF6MWQOnC6eVB7k9cK/OXo45C0MEagSbqyEkX/hfBJJ
        03L5az63W6gHj2CA==
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
Subject: [PATCH v2 2/7][next] printk: ringbuffer: change representation of reusable
Date:   Mon, 24 Aug 2020 12:41:33 +0206
Message-Id: <20200824103538.31446-3-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reusable queried state is represented by the combined flags:

    DESC_COMMIT_MASK | DESC_REUSE_MASK

There is no reason for the DESC_COMMIT_MASK to be part of that
representation. In particular, this will add confusion when more
state flags are available.

Change the representation of the reusable queried state to just
the DESC_REUSE_MASK flag.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 4 ++--
 kernel/printk/printk_ringbuffer.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 76248c82d557..d339ff7647da 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -463,7 +463,7 @@ static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
 	unsigned long val_committed = id | DESC_COMMIT_MASK;
-	unsigned long val_reusable = val_committed | DESC_REUSE_MASK;
+	unsigned long val_reusable = id | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
 
@@ -899,7 +899,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
 	if (prev_state_val &&
-	    prev_state_val != (id_prev_wrap | DESC_COMMIT_MASK | DESC_REUSE_MASK)) {
+	    get_desc_state(id_prev_wrap, prev_state_val) != desc_reusable) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index dcda5e9b4676..96ef997d7bd6 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -213,7 +213,7 @@ struct prb_reserved_entry {
  */
 #define BLK0_LPOS(sz_bits)	(-(_DATA_SIZE(sz_bits)))
 #define DESC0_ID(ct_bits)	DESC_ID(-(_DESCS_COUNT(ct_bits) + 1))
-#define DESC0_SV(ct_bits)	(DESC_COMMIT_MASK | DESC_REUSE_MASK | DESC0_ID(ct_bits))
+#define DESC0_SV(ct_bits)	(DESC_REUSE_MASK | DESC0_ID(ct_bits))
 
 /*
  * Define a ringbuffer with an external text data buffer. The same as
-- 
2.20.1

