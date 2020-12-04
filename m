Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04722CF2CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgLDRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgLDRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E457AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:09:52 -0800 (PST)
Message-Id: <20201204170805.004816169@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crX5s+U2nEnqCEqRoSwTJhDLZSlSeKxjFKms03b7lwk=;
        b=owT7KaiENlob8TnuSyRKAmLJJ44mWlcGRatUnjaXFe5QUj6KMLEKXs06MU8Hb2LXmf4Q2K
        tFU2b8yWKbVyqpj8BO75qlcKaUcBJxhERc33rgP9jUvUMygIGhJmIqlUtVqQMEOFOV4Lcy
        SyIOaf84DnDk0gK7uwxCBso+OZg2vdG+AAys9FUM5DsurOB3oK5P3svUZesx13hmYrmndZ
        yLV0nvnoZQgS3Z+pdjfBNqGxkPeqp1Y0bcnRyGE+wyzrwEm7zog6GV0wV49Fv7iIdReIHA
        g3M92DWJeNwQUdc2viWXKpWVcoUJ0UN2hnmTUiXoEBEJI/USfHqyDT08ZSnHpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=crX5s+U2nEnqCEqRoSwTJhDLZSlSeKxjFKms03b7lwk=;
        b=GfEtisVgxlz601Bh4lwqrq3tzgoGBZB866ujkXJzVlOZV5snUzAMo9uTndWeseUac+SD0z
        rqB2zyFNkkQebXCg==
Date:   Fri, 04 Dec 2020 18:01:54 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 3/9] softirq: Move various protections into inline helpers
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow reuse of the bulk of softirq processing code for RT and to avoid
#ifdeffery all over the place, split protections for various code sections
out into inline helpers so the RT variant can just replace them in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Adapt to Frederics rework
---
 kernel/softirq.c |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -204,6 +204,32 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -316,7 +342,7 @@ asmlinkage __visible void __softirq_entr
 
 	pending = local_softirq_pending();
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -367,8 +393,7 @@ asmlinkage __visible void __softirq_entr
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -463,7 +488,7 @@ inline void raise_softirq_irqoff(unsigne
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
@@ -641,18 +666,18 @@ static int ksoftirqd_should_run(unsigned
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

