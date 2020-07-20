Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1162C2265C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgGTP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbgGTP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:56:55 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GofmFicM0Ot7KWATWSSEdP5X+bhnBzrS2jXewofFGIY=;
        b=16nlfSb7azsXMWMEMvEtSOSVubLJdJQdEV656N9+CvaVTIxwUdRyzS9+B1/8IqqdCKW9UQ
        +wLJR2HrTS20MBkwdkPL8ssO0h5fW5GVNZ3nJDG7XsscLGyDPQm3BQ8JS5HjExPuNBxtXf
        Ijq9PmQ2loNWNXdjz9cAA8/52/ujI0odGquxPBYxnQO4WBJkOqBHEMfc8Yx3f2XSb5+2t9
        /bojX8Ogj44Nd5qJGlMZqCHU4q03gmkZfao3sY7a1pewRgh4IZppSoZuHRj5x3I8JV+Rof
        8pH4hHkN95Yqv64JUHKzP3wTJvRkb3PR1IUpFJvmPmTpWhPaR+dcBnbCqsrUTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GofmFicM0Ot7KWATWSSEdP5X+bhnBzrS2jXewofFGIY=;
        b=Dyx0bOiSvQkyLB5IVcXI9gRlyAiNdB50fPit3CGyVnZYSmeG8KskOwWf/hszSqR9vUNXyr
        6NkwneErroU1LmDA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v4 17/24] timekeeping: Use sequence counter with associated raw spinlock
Date:   Mon, 20 Jul 2020 17:55:23 +0200
Message-Id: <20200720155530.1173732-18-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_raw_spinlock_t data type, which allows to associate
a raw spinlock with the sequence counter. This enables lockdep to verify
that the raw spinlock used for writer serialization is held when the
write side critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/timekeeping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489841c8..05ecfd8a3314 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -39,18 +39,19 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
+static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
 static struct {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 } tk_core ____cacheline_aligned = {
-	.seq = SEQCNT_ZERO(tk_core.seq),
+	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
@@ -63,7 +64,7 @@ static struct timekeeper shadow_timekeeper;
  * See @update_fast_timekeeper() below.
  */
 struct tk_fast {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct tk_read_base	base[2];
 };
 
@@ -80,11 +81,13 @@ static struct clocksource dummy_clock = {
 };
 
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
@@ -157,7 +160,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * tk_clock_read - atomic clocksource read() helper
  *
  * This helper is necessary to use in the read paths because, while the
- * seqlock ensures we don't return a bad value while structures are updated,
+ * seqcount ensures we don't return a bad value while structures are updated,
  * it doesn't protect from potential crashes. There is the possibility that
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
@@ -222,10 +225,10 @@ static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 	unsigned int seq;
 
 	/*
-	 * Since we're called holding a seqlock, the data may shift
+	 * Since we're called holding a seqcount, the data may shift
 	 * under us while we're doing the calculation. This can cause
 	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqlock here to atomically
+	 * results away. So nest another seqcount here to atomically
 	 * grab the points we are checking with.
 	 */
 	do {
@@ -486,7 +489,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *
  * To keep it NMI safe since we're accessing from tracing, we're not using a
  * separate timekeeper with updates to monotonic clock and boot offset
- * protected with seqlocks. This has the following minor side effects:
+ * protected with seqcounts. This has the following minor side effects:
  *
  * (1) Its possible that a timestamp be taken after the boot offset is updated
  * but before the timekeeper is updated. If this happens, the new boot offset
-- 
2.20.1

