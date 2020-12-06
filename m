Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C232D074B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgLFVVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:21:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLFVVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:21:52 -0500
Message-Id: <20201206212002.582579516@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607289670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7uPPJRC0zT+/X3ZhoKFyc0cPV876f8SJt5Y3T/6tcvU=;
        b=a0xqJ+XKxB0MShfWSI+yGNXLVnY+IeFUdqiUiO7Xn/BnUaBJrp1Lqy5CKqAHG3OR3qvSHP
        2DdO8dpKDjBiNn0K3aFKliJmll0Jq4YSk5VPyrY3IMMzbNr+9lUfiRKOiFsLxKiH1MFOuR
        1PTE+Y8JAUmE6eKxHTJwdYhYjPajVY6xvMig6HblZhm3zmbCtFy0L3IpmwWlLuOCU6nomk
        1HKxWHA9VvQEHFAITOSbEEANxC+FJAMtk8kj/vT/Dywr/2fdRbe9HPdC3TwzZf9qORriDg
        y5B7CRfAmTPWB2t0YuSdzgzjRQl1s1EIfPiLQfYYl3HY75nQ0RYEIRteO8VTdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607289670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7uPPJRC0zT+/X3ZhoKFyc0cPV876f8SJt5Y3T/6tcvU=;
        b=ofGJi84ZUQjM8oE6/OF4/1XP3QmgPOdyPw+FxFxePrwrEA6KinzZ/ye5xXyhJM3KYB1DCx
        iP6qECgt9raezqCQ==
Date:   Sun, 06 Dec 2020 22:12:54 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [patch 1/3] tick: Remove pointless cpu valid check in hotplug code
References: <20201206211253.919834182@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_handover_do_timer() which is invoked when a CPU is unplugged has a
check for cpumask_first(cpu_online_mask) when it tries to hand over the
tick update duty.

Checking the result of cpumask_first() there is pointless because if the
online mask is empty at this point, then this would be the last CPU in the
system going offline, which is impossible. There is always at least one CPU
remaining. If online mask would be really empty then the timer duty would
be the least of the resulting problems.

Remove the well meant check simply because it is pointless and confusing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-common.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot
 /*
  * Transfer the do_timer job away from a dying cpu.
  *
- * Called with interrupts disabled. Not locking required. If
+ * Called with interrupts disabled. No locking required. If
  * tick_do_timer_cpu is owned by this cpu, nothing can change it.
  */
 void tick_handover_do_timer(void)
 {
-	if (tick_do_timer_cpu == smp_processor_id()) {
-		int cpu = cpumask_first(cpu_online_mask);
-
-		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
-			TICK_DO_TIMER_NONE;
-	}
+	if (tick_do_timer_cpu == smp_processor_id())
+		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 }
 
 /*

