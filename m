Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FE12E3092
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 10:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgL0J1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 04:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0J1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 04:27:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:27:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id j22so10653749eja.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sjCmWH+ArMFZY5tgXqABEhN1g/czabW3J/ZGUaEq8og=;
        b=ABCOjJ4ML92q8rFj3YNaAtL8UJmOOilxo8Nkks3eAdae6IKpSlDgDgEEAUTj1YCeAb
         fM9xltSqsB/swN4n8azkCfSZ2lKFe1yQAjb57k3PJLE9tSkic3TH7bj8VCXyWEg5h43e
         CBLp2YOH742+ubnyN9UYN1EoqlxL/zllSbGm9d4e/Kb8HvV9cfipijmZf/4OlMMu5KWO
         Rb8lQjwkZBFiYyGvEnAsAcC5kCqxWq5snUGowWECCF9kQhxQ3rwVIg+KvJAj4F99Op9d
         EEwsGjGKzAvWNb5HJ9aHTPkIZbcwjoqjvT/m+PlS97cZs4YCHaISafE1c/l67Wo1koCq
         e0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=sjCmWH+ArMFZY5tgXqABEhN1g/czabW3J/ZGUaEq8og=;
        b=i42WtmwZM9pU/WLCTcagjD49XjgoKQsJKAa7uSwf8NRLAh58bDATxNgY1uawrzjz+o
         lfgukqU47DW5IS0pQWv1iyCNp+lDmNJ5/6CRRNsILhan6BaI2TQ9hbktz39DnfPWZJnA
         8drWG5GccJ9Zq6wSifBAXLV1ZKB9Gk8TnRfDEjwZFCU5eoc00N6vmI8KBPvpkfsfJJ1a
         RYdpFWXUgor138OgAqM/JLk+zfMkax3OvOzV66bqhRK/5I1PkLW8KhcFCgV3XduVy90w
         mRyEEAjxHyfb4sv7g/vxXBWsOnn7eOXaw/H9/T5AR/d3mjUba7+zddUk79bGbN2E3t/R
         qr4g==
X-Gm-Message-State: AOAM531G49Y5NvlFmu/PiF/9iqtBYt6VZo39JdYqIwjJNAo1Exe8ETGO
        N0pMzDIX4AtJcuWAx1bQdfREs0CbMxY=
X-Google-Smtp-Source: ABdhPJy6KfEKLmhnQxXAqnIKWyUKmf0HY8FepkIFw6A8S41wi25a2ycN4xJ5X/uLLTMiuuRqm/DtFg==
X-Received: by 2002:a17:906:6448:: with SMTP id l8mr11588014ejn.357.1609061221819;
        Sun, 27 Dec 2020 01:27:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k16sm15847053ejd.78.2020.12.27.01.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:27:00 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Dec 2020 10:26:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fixes
Message-ID: <20201227092658.GA1742349@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-12-27

   # HEAD: f6f5cd840ae782680c5e94048c72420e4e6857f9 timekeeping: Fix spelling mistake in Kconfig "fullfill" -> "fulfill"

Update/fix two CPU sanity checks in the hotplug and the boot code,
and fix a typo in the Kconfig help text.

( Context: the first two commits are the result of an ongoing 
  annotation+review work of (intentional) tick_do_timer_cpu() data 
  races reported by KCSAN, but the annotations aren't fully cooked 
  yet. )

 Thanks,

	Ingo

------------------>
Colin Ian King (1):
      timekeeping: Fix spelling mistake in Kconfig "fullfill" -> "fulfill"

Thomas Gleixner (2):
      tick: Remove pointless cpu valid check in hotplug code
      tick/sched: Remove bogus boot "safety" check


 kernel/time/Kconfig       |  2 +-
 kernel/time/tick-common.c | 10 +++-------
 kernel/time/tick-sched.c  |  7 -------
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a09b1d61df6a..64051f47475c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -141,7 +141,7 @@ config CONTEXT_TRACKING_FORCE
 	  dynticks working.
 
 	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
+	  context tracking backend but doesn't yet fulfill all the
 	  requirements to make the full dynticks feature working.
 	  Without the full dynticks, there is no way to test the support
 	  for context tracking and the subsystems that rely on it: RCU
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a03764df5366..9d3a22510bab 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
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
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a9e68936822d..5fbc748f0058 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -991,13 +991,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		 */
 		if (tick_do_timer_cpu == cpu)
 			return false;
-		/*
-		 * Boot safety: make sure the timekeeping duty has been
-		 * assigned before entering dyntick-idle mode,
-		 * tick_do_timer_cpu is TICK_DO_TIMER_BOOT
-		 */
-		if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_BOOT))
-			return false;
 
 		/* Should not happen for nohz-full */
 		if (WARN_ON_ONCE(tick_do_timer_cpu == TICK_DO_TIMER_NONE))
