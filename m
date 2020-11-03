Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9639E2A4FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgKCTJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:09:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44122 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:09:41 -0500
Date:   Tue, 3 Nov 2020 20:09:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604430579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4J2Ki7wxdqW2uIe5cozOirDfYxIm6YWmlpCr6285YJc=;
        b=n28vLhlucvkeeh1vwyQe0Mc/DMOWLh/veJCIkps9ig6nRXl1AD0aoI8ZKcX7Iv41n7OsdX
        F+wOLMB/ihOTIzC5yNE1N2YnrGXdySMAGkzmvppxEaGk2XzRDvPJmjkkf3DW2pD///UyNp
        zBJ5UC0F5vRocFVdWy7mwWDGT1HXV0Y3HtBqwAoOh1h7BVU4Act2XR1sBSyfF84YOkHHIf
        AZ5c8CV2716Nm+EphEuzDoTx/8siRCs7tHX9LgxXO+/+CYkVeUnBIN2AECTD6bXrSV5w9k
        YtDxXMOqZvasTlXLWX/JpwjmEpqWhuPNX03VzBjrtrJaZ3/0vtWoS2XY5Cy3xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604430579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4J2Ki7wxdqW2uIe5cozOirDfYxIm6YWmlpCr6285YJc=;
        b=wOmI2xmKrBP/oeqhMrfQP/AwFvO2wq0zeesWiY6WeL9eLavv3ECyrNVna3mY9Gs3W0lZD/
        tVfe899ChWnjWaCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Mike Galbraith <efault@gmx.de>
Subject: [PATCH] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE
Message-ID: <20201103190937.hga67rqhvknki3tp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a deadlock.

This blocking can not be done for workqueue's IRQ_SAFE timer which will
be canceled in an IRQ-off region. It has to happen to in IRQ-off region
because changing the PENDING bit and clearing the timer must not be
interrupted to avoid a busy-loop.

The callback invocation of IRQSAFE timer is not preempted on PREEMPT_RT
so there is no need to synchronize on timer_base::expiry_lock.

Don't acquire the timer_base::expiry_lock for TIMER_IRQSAFE flagged
timer.
Add a lockdep annotation to ensure that this function is always invoked
in preemptible context on PREEMPT_RT.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7edc9fba34bbd..1e2403126ccfe 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1288,7 +1288,7 @@ static void del_timer_wait_running(struct timer_list *timer)
 	u32 tf;
 
 	tf = READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base = get_timer_base(tf);
 
 		/*
@@ -1372,6 +1372,13 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
 
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+
 	do {
 		ret = try_to_del_timer_sync(timer);
 
-- 
2.29.1

