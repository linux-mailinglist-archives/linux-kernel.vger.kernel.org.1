Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58D2A64D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgKDNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKDNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:06:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C33C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 05:06:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604495184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lwj0653ZhCm+c4hnkg6amH84SkNmVkCQ+UR7aaQi1ZA=;
        b=H+SecVXJyafk7xsA9akrMTUT2E16TyiYsRurpYB9ZHXIxWeAvMmwYE6TTsX2P7HQhKahWE
        8r4Phwk87vXgy+2BXC6OWZtJqfa86LiCyM3IN75zoDXAlfXlD5weNcd4lNDc1JiBAjsoC7
        /W2/RD+jPhPMlrkmTavrtOE2tKCGGs6k+ASIVSo/TXFI6dsJpFlAkN8O5lAr1PnRmzWWSg
        4TvjIqq8kPlZG8pl1p5yBrzmRB14e08kqu4MBcSVB54CIpw+ix8bteXC0N0qjMQHE2N4dK
        nKP09OIV7zd4h/Qxg68qsM6SAcCMX3wCOaQviwEwaQm7xJ14H2FAm2KSim8pHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604495184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lwj0653ZhCm+c4hnkg6amH84SkNmVkCQ+UR7aaQi1ZA=;
        b=oglq8hlR7p4wTwmsS+A0FBgGB9yFbJnbHJe04EM3ueS97Ud0nGq2ac5OV8vofuXdeTho4x
        UkVTCS+te1CLiNBw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: entry: Fix the incorrect ordering of lockdep and RCU check
Date:   Wed, 04 Nov 2020 14:06:23 +0100
Message-ID: <87y2jhl19s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an exception/interrupt hits kernel space and the kernel is not
currently in the idle task then RCU must be watching.

irqentry_enter() validates this via rcu_irq_enter_check_tick(), which in
turn invokes lockdep when taking a lock. But at that point lockdep does not
yet know about the fact that interrupts have been disabled by the CPU,
which triggers a lockdep splat complaining about inconsistent state.

Invoking trace_hardirqs_off() before rcu_irq_enter_check_tick() defeats the
point of rcu_irq_enter_check_tick() because trace_hardirqs_off() uses RCU.

So use the same sequence as for the idle case and tell lockdep about the
irq state change first, invoke the RCU check and then do the lockdep and
tracer update.

Fixes: a5497bab5f72 ("entry: Provide generic interrupt entry/exit code")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/entry/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -337,10 +337,10 @@ noinstr irqentry_state_t irqentry_enter(
 	 * already contains a warning when RCU is not watching, so no point
 	 * in having another one here.
 	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	instrumentation_begin();
 	rcu_irq_enter_check_tick();
-	/* Use the combo lockdep/tracing function */
-	trace_hardirqs_off();
+	trace_hardirqs_off_finish();
 	instrumentation_end();
 
 	return ret;
