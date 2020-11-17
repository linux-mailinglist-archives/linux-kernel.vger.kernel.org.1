Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D902B674B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgKQOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:24:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:24:15 -0800 (PST)
Message-Id: <20201117132006.061341507@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605623053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b2x8vSKwu7S3ZFX0yllFAZtAudlhsdIqB2TIuVCZxKA=;
        b=MvGClS1UQgF+FnK4IoBv4D4LYn9eZEwbjh4FpnJJQCpjHLQUDe5jTAwSi6enPb8WzWJNNd
        YckMcEuUU0x7pMWRbiRyo/dnl7wq1K4UVQf81G/K2xnWOCkCSFGuwnPfLELrKoffQuZaZq
        du4XqDJU3+CSrqZepePf1YgDZEAA9pyj1tCmQbSNAnaEXTkZuKCgp2lIvS2uVEMP1cuZJv
        L5bbfRJ4vMMncZVExMToSTHxpG4eu/gjQwZ9LQ8/1KV7kCYto+A4CuH8Oh4W+vrrosszey
        A2Fv736JF+qW9guvRUGLFbHqKmjV1LTuk/u+fLKaMu/glYijefPeIh557WsUpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605623053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b2x8vSKwu7S3ZFX0yllFAZtAudlhsdIqB2TIuVCZxKA=;
        b=0uPxri+iQuEd6oUpHmUzjuzCGehjgCaTq8wUQBRIG3b2fPgN6Uamxty1Jm+AffR6BJ3BcN
        s6xXIIypFlPVj4DA==
Date:   Tue, 17 Nov 2020 14:19:43 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [patch 1/7] tick/broadcast: Serialize access to tick_next_period
References: <20201117131942.515430545@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_broadcast_setup_oneshot() accesses tick_next_period twice without any
serialization. This is wrong in two aspects:

  - Reading it twice might make the broadcast data inconsistent if the
    variable is updated concurrently.

  - On 32bit systems the access might see an partial update

Protect it with jiffies_lock. That's safe as none of the callchains leading
up to this function can create a lock ordering violation:

timer interrupt
  run_local_timers()
    hrtimer_run_queues()
      hrtimer_switch_to_hres()
        tick_init_highres()
	  tick_switch_to_oneshot()
	    tick_broadcast_switch_to_oneshot()
or
     tick_check_oneshot_change()
       tick_nohz_switch_to_nohz()
         tick_switch_to_oneshot()
           tick_broadcast_switch_to_oneshot()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-broadcast.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -877,6 +877,22 @@ static void tick_broadcast_init_next_eve
 	}
 }
 
+static inline ktime_t tick_get_next_period(void)
+{
+	ktime_t next;
+
+	/*
+	 * Protect against concurrent updates (store /load tearing on
+	 * 32bit). It does not matter if the time is already in the
+	 * past. The broadcast device which is about to be programmed will
+	 * fire in any case.
+	 */
+	raw_spin_lock(&jiffies_lock);
+	next = tick_next_period;
+	raw_spin_unlock(&jiffies_lock);
+	return next;
+}
+
 /**
  * tick_broadcast_setup_oneshot - setup the broadcast device
  */
@@ -905,10 +921,11 @@ static void tick_broadcast_setup_oneshot
 			   tick_broadcast_oneshot_mask, tmpmask);
 
 		if (was_periodic && !cpumask_empty(tmpmask)) {
+			ktime_t nextevt = tick_get_next_period();
+
 			clockevents_switch_state(bc, CLOCK_EVT_STATE_ONESHOT);
-			tick_broadcast_init_next_event(tmpmask,
-						       tick_next_period);
-			tick_broadcast_set_event(bc, cpu, tick_next_period);
+			tick_broadcast_init_next_event(tmpmask, nextevt);
+			tick_broadcast_set_event(bc, cpu, nextevt);
 		} else
 			bc->next_event = KTIME_MAX;
 	} else {

