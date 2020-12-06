Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891F62D05E8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLFQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgLFQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:22:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E3C0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 08:21:55 -0800 (PST)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607271713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMjQ9gTmGawI6VCkvT5/GnLVQ53sv4G1cWsH37LOfxk=;
        b=YizeyHirC53nbsI1X8A/6mo5L/bz306WE/+VxT+sAsSf1oGN8RSIa5gDsEvVUZglwcwDz1
        LFBj8jnp/kL9zgiFgRbXpMW079x3X24cQpMNudAv2E8YjWPznyLdRFJw6YnBhXDxv79hc1
        etZyXIRyEZeAtSCqOvmjk82guBRA6THiT+QMsJkbPIs7hycszlZfldDPrky9S/Sqf/usKC
        HEzUx2ZVgdMEBe3736bcghbDM1xwkCpL2sNYk7SREbb3Zrph038kqWe9mwOjJ0EdH8NHPJ
        AqxdFZF65Un7dpBdET9FPNDOFkRaKouq/KOn70ujGVFkw2y+A0ZErtJEfyFxYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607271713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMjQ9gTmGawI6VCkvT5/GnLVQ53sv4G1cWsH37LOfxk=;
        b=gpW9pPfs+FluZ5hJG29vSNlgQrC0OHcqr0meEPdCP/GUFHRgE+89/enyckDJk9flmBBIMP
        nPbW5VPOC2rA7JAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH -tip v1 2/3] seqlock: Prefix internal seqcount_t-only macros with a "do_"
Date:   Sun,  6 Dec 2020 17:21:42 +0100
Message-Id: <20201206162143.14387-3-a.darwish@linutronix.de>
In-Reply-To: <20201206162143.14387-1-a.darwish@linutronix.de>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the seqcount_LOCKNAME_t group of data types were introduced, two
classes of seqlock.h sequence counter macros were added:

  - An external public API which can either take a plain seqcount_t or
    any of the seqcount_LOCKNAME_t variants.

  - An internal API which takes only a plain seqcount_t.

To distinguish between the two groups, the "*_seqcount_t_*" pattern was
used for the latter. This confused a number of mm/ call-site developers,
and Linus also commented that it was not a standard practice for marking
seqlock.h internal APIs.

Distinguish the latter group of macros by prefixing a "do_".

Link: https://lkml.kernel.org/r/CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com
Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 66 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d89134c74fba..235cbc65fd71 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -445,12 +445,12 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_t_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
 /**
@@ -462,10 +462,10 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void raw_write_seqcount_t_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -478,13 +478,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(seqprop_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_ptr(s));			\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void raw_write_seqcount_t_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -506,12 +506,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
+	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_t_begin(s);
+	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
@@ -533,12 +533,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(seqprop_ptr(s));				\
+	do_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
-	write_seqcount_t_begin_nested(s, 0);
+	do_write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -549,16 +549,16 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(seqprop_ptr(s));				\
+	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void write_seqcount_t_end(seqcount_t *s)
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_t_end(s);
+	do_raw_write_seqcount_end(s);
 }
 
 /**
@@ -603,9 +603,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(seqprop_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_ptr(s))
 
-static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -623,9 +623,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(seqprop_ptr(s))
+	do_write_seqcount_invalidate(seqprop_ptr(s))
 
-static inline void write_seqcount_t_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -865,9 +865,9 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
- * instead of the generic write_seqcount_begin(). This way, no redundant
- * lockdep_assert_held() checks are added.
+ * For all seqlock_t write side functions, use the the internal
+ * do_write_seqcount_begin() instead of generic write_seqcount_begin().
+ * This way, no redundant lockdep_assert_held() checks are added.
  */
 
 /**
@@ -886,7 +886,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -898,7 +898,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -912,7 +912,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -925,7 +925,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -939,7 +939,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -951,7 +951,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -960,7 +960,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -989,7 +989,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
-- 
2.29.2

