Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF527E59E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgI3Jtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Jtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:49:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8LoHph8lkDnXWfFfdp99kRDRbyoNOUyB+Z+LgrwL2ys=; b=qUSpAPN2XFfP1gprFvIBvx2Sl2
        QK8jGrKsD6fDZ1ckdHUJz0F23AoznBn1lehsIE/NxLeBkn26QWp/VPkplZCANgKnw5niFJf8Kkowu
        lS4xs7D7GVoZiswgIA0cJAG7JyjDTQgQQaHZNMM+oQ1r2KVHtDGAHCbCz40kpHAXTNfSxCvK4Ju82
        8p9hKi25juQVENi0Km+GehxXYFv5fUeFds6ZQFH5YQq3LDHAY4ff5Z/saBRTSlMp58xinNj6plVQf
        nusxpn0G3wmJvFoVc1eAR1bJU2f+TE6NKlaBHzsh1khiVn4nwQ1Qso3mBk6VWXg/4OmM2sH+sltYv
        asOsryYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNYk1-0007tv-Jh; Wed, 30 Sep 2020 09:49:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFF443062BA;
        Wed, 30 Sep 2020 11:49:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA6BA202A40A0; Wed, 30 Sep 2020 11:49:37 +0200 (CEST)
Date:   Wed, 30 Sep 2020 11:49:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>,
        g@hirez.programming.kicks-ass.net
Cc:     Qian Cai <cai@redhat.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930091610.GV2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:16:11AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 30, 2020 at 07:08:23AM +0800, Boqun Feng wrote:
> > I think there are two problems here:
> > 
> > 1) the "(null)" means we don't have the "usage_str" for a usage bit,
> > which I think is the LOCK_USED_READ bit introduced by Peter at
> > 23870f122768 ('locking/lockdep: Fix "USED" <- "IN-NMI" inversions').
> > 
> > 2) the next null-ptr-deref, and I think this is also caused by
> > LOCK_USED_READ bit, because in the loop inside
> > print_lock_class_header(), we iterate from 0 to LOCK_USAGE_STATES (which
> > is 4*2 + 3), however the class->usage_traces[] only has
> > XXX_LOCK_USAGE_STATES (which is 4*2 + 1) elements, so if we have
> > LOCK_USED_READ bit set in ->usage_mask, we will try to access an element
> > out of the ->usage_traces[] array.
> > 
> > Probably the following helps? And another possible fix is to enlarge the
> > ->usage_trace[] array and record the call trace of LOCK_READ_USED.
> 
> Urgh.. yeah, I wanted to avoid saving that trace; it's pretty useless :/
> The existing USED trace is already mostly pointless, the consistent
> thing would be to remove both but that might be too radical.
> 
> But you're right in that I made a right mess of it. Not sure what's
> best here.
> 
> Let me have a play.

How's something like this? It's bigger than I'd like, but I feel the
result is more consistent/readable.

---
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index bb35b449f533..a55b1d314ae8 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -35,8 +35,12 @@ enum lockdep_wait_type {
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
+ *
+ * XXX_LOCK_USAGE_STATES is the number of lines in lockdep_states.h, for each
+ * of those we generates 4 states, Additionally we (for now) report on USED.
  */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
+#define XXX_LOCK_USAGE_STATES		2
+#define LOCK_TRACE_STATES		(XXX_LOCK_USAGE_STATES*4 + 1)
 
 /*
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
@@ -106,7 +110,7 @@ struct lock_class {
 	 * IRQ/softirq usage tracking bits:
 	 */
 	unsigned long			usage_mask;
-	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
+	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
 
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 454355c033d2..4f98ac8b4575 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -600,6 +600,8 @@ static const char *usage_str[] =
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
+	[LOCK_USED_READ] = "INITIAL READ USE",
+	/* abused as string storage for verify_lock_unused() */
 	[LOCK_USAGE_STATES] = "IN-NMI",
 };
 #endif
@@ -2231,7 +2233,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 #endif
 	printk(KERN_CONT " {\n");
 
-	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
+	for (bit = 0; bit < LOCK_TRACE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
@@ -4354,27 +4356,24 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	old_mask = hlock_class(this)->usage_mask;
 	hlock_class(this)->usage_mask |= new_mask;
 
-	/*
-	 * Save one usage_traces[] entry and map both LOCK_USED and
-	 * LOCK_USED_READ onto the same entry.
-	 */
-	if (new_bit == LOCK_USED || new_bit == LOCK_USED_READ) {
-		if (old_mask & (LOCKF_USED | LOCKF_USED_READ))
-			goto unlock;
-		new_bit = LOCK_USED;
+	if (new_bit < LOCK_TRACE_STATES) {
+		if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
+			return 0;
 	}
 
-	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
-		return 0;
-
 	switch (new_bit) {
+	case 0 ... LOCK_USED-1:
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
+			return 0;
+		break;
+
 	case LOCK_USED:
 		debug_atomic_dec(nr_unused_locks);
 		break;
+
 	default:
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
+		break;
 	}
 
 unlock:
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index b0be1560ed17..67dc46e46552 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -20,9 +20,12 @@ enum lock_usage_bit {
 #undef LOCKDEP_STATE
 	LOCK_USED,
 	LOCK_USED_READ,
-	LOCK_USAGE_STATES
+	LOCK_USAGE_STATES,
 };
 
+/* states after LOCK_USED are not traced and printed */
+static_assert(LOCK_TRACE_STATES == LOCK_USED_READ);
+
 #define LOCK_USAGE_READ_MASK 1
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
@@ -121,7 +124,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 extern struct list_head all_lock_classes;
 extern struct lock_chain lock_chains[];
 
-#define LOCK_USAGE_CHARS (1+LOCK_USAGE_STATES/2)
+#define LOCK_USAGE_CHARS (2*XXX_LOCK_USAGE_STATES + 1)
 
 extern void get_usage_chars(struct lock_class *class,
 			    char usage[LOCK_USAGE_CHARS]);
