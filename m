Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4232B674F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgKQOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgKQOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:19 -0500
Message-Id: <20201117132006.565663056@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OhH7Vyhi+v7C8KGlTztCBlPjjTHSdhrCmDbeFrQSHVQ=;
        b=TdaeSuxP4PqQ20iAK9ZyVehhDkOFWcdOeiIUXrCoqFkR6gjyuv1j0DlT6iFj8fyQMPjNGh
        rAF+mOA5Mf5VpmM6MU34n3EHkeT4A0W+6PY4F6UmjHtj/9IHuMhzhEoLzcV8gPfs4uUu6t
        4CP2aFWt1+bLNEOcfmBvQ2qypvKxY5V+2KstvjRRNMm4g1s/eQsb0YuTCi9bhg0J7JAqgO
        XUSG6FxkkrlwKT61PwSnBca9xZqbWFRJBkuK0xvps+M3SOQBqfnfAw53HBoVI5a4dze6qf
        T2AdlFXsg1nJ2R7F6b/MKF/IsYV75QOUMJnw05o3qrFZcr3yzTSbe/XSXNnLow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=OhH7Vyhi+v7C8KGlTztCBlPjjTHSdhrCmDbeFrQSHVQ=;
        b=nduu4VMIw9XKPh9YRZ+mXoPfrrGaQFxWyeaGyW419NjsqKKbfmguSx3k9/KX53uWTbJ2hk
        d6CCgRqCoEhrd9Cg==
Date:   Tue, 17 Nov 2020 14:19:47 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 5/7] tick/sched: Optimize tick_do_update_jiffies64() further
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's clear that there is always one tick to account, simplify the
calculations some more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -55,7 +55,7 @@ static ktime_t last_jiffies_update;
  */
 static void tick_do_update_jiffies64(ktime_t now)
 {
-	unsigned long ticks = 0;
+	unsigned long ticks = 1;
 	ktime_t delta;
 
 	/*
@@ -93,20 +93,21 @@ static void tick_do_update_jiffies64(kti
 
 	write_seqcount_begin(&jiffies_seq);
 
-	last_jiffies_update = ktime_add(last_jiffies_update, tick_period);
-
 	delta = ktime_sub(now, tick_next_period);
 	if (unlikely(delta >= tick_period)) {
 		/* Slow path for long idle sleep times */
 		s64 incr = ktime_to_ns(tick_period);
 
-		ticks = ktime_divns(delta, incr);
+		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
+	} else {
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 	}
 
-	do_timer(++ticks);
+	do_timer(ticks);
 
 	/*
 	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()

