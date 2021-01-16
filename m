Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F72F8D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbhAPLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbhAPLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D189AC061796
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cB2DcSH+VZOQ9+f6IUVr1n4noxQrM6fH8RmueC6W3PI=; b=nsbYgjyA+kNIdmPczWH/M7SVag
        XyWhcZGw2d7EOTCcvo78zVJn87w0aO2VHA6Ll+t/u3XIdwnFshC6XwNT3JdTyPay8dt5uGXBzgdje
        XNlya7cwegtn7TeaJJ10N4inhv1ns1u5M9t0t/j+Da6RbomtI1X+0A2IH3LCc0of8M30xeo67U/ke
        BrHfw0zL/9stZiP2srF2xj1MRGO39Mcu9SJ0qhZe842mmbc9aGhFFEYdsnrk9qNQApqOmI0Exz5L6
        EULp6C1mWmDK5xzJRemd7HxUqIJL54x7Y1sdV6hXe9pScyqA0MmNmEnw/ijYvIsKR0m/gUBBs6yco
        DBIa6omQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyT-00ADOB-M8; Sat, 16 Jan 2021 11:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72A263059DE;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 221BB2028A2C9; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113919.760767084@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 3/8] sched: Dont run cpu-online with balance_push() enabled
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to push away tasks when we come online, mark the push
complete right before the CPU dies.

XXX hotplug state machine has trouble with rollback here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7320,10 +7320,12 @@ static void balance_push_set(int cpu, bo
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
-	if (on)
+	if (on) {
+		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
-	else
+	} else if (rq->balance_callback == &balance_push_callback) {
 		rq->balance_callback = NULL;
+	}
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7441,6 +7443,10 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	/*
+	 * Make sure that when the hotplug state machine does a roll-back
+	 * we clear balance_push. Ideally that would happen earlier...
+	 */
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
@@ -7608,6 +7614,12 @@ int sched_cpu_dying(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
+	/*
+	 * Should really be after we clear cpu_online(), but we're in
+	 * stop_machine(), so it all works.
+	 */
+	balance_push_set(cpu, false);
+
 	calc_load_migrate(rq);
 	update_max_interval();
 	nohz_balance_exit_idle(rq);


