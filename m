Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CD72FE7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbhAUKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbhAUKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE332C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UiXCveY8FllI33PDBv88YNCQJuO5x5OTM8ytIHxZ25U=; b=R4hg6Y1duVcJbkTmrMPBfLz4FN
        j0px9ntkuVXhmR2qc/KOi/bMIslkI3s5Erv2gs1jpbl3kJX7Q/9RYo+D6JE0zpacRlx4FWgLZwLNw
        3Z4ph6R5voC5wEI5MZds5pmPzl8L/fFjHqIBni9Di91bt/OyPd6nFUvkdON0Uyzl23c8+0/WeS9GP
        Ac3xY2MIGzUjPzIbpQSocXfEe7peVf9peMBBptu7KHxAtjKlqdcQ3QUSIoQlLHx/nqTaDNAt9FLBA
        QIvcuPt4Iywzgv5jeQPm9jyFZrYQL6xPPrO0MNDOO8dUU3dI0zdWOARyLUU+FxT5KrSkap7F7oVXn
        YPqU+YhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2XKM-0007OB-8o; Thu, 21 Jan 2021 10:36:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08E86306E0C;
        Thu, 21 Jan 2021 11:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7316720C86815; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103506.966069627@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 7/9] sched: Prepare to use balance_push in ttwu()
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of using the balance_push state in ttwu() we need it to
provide a reliable and consistent state.

The immediate problem is that rq->balance_callback gets cleared every
schedule() and then re-set in the balance_push_callback() itself. This
is not a reliable signal, so add a variable that stays set during the
entire time.

Also move setting it before the synchronize_rcu() in
sched_cpu_deactivate(), such that we get guaranteed visibility to
ttwu(), which is a preempt-disable region.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   18 +++++++++++++-----
 kernel/sched/sched.h |    1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7320,6 +7327,7 @@ static void balance_push_set(int cpu, bo
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
+	rq->balance_push = on;
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
@@ -7489,17 +7497,17 @@ int sched_cpu_deactivate(unsigned int cp
 	int ret;
 
 	set_cpu_active(cpu, false);
+	balance_push_set(cpu, true);
+
 	/*
-	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
-	 * users of this state to go away such that all new such users will
-	 * observe it.
+	 * We've cleared cpu_active_mask / set balance_push, wait for all
+	 * preempt-disabled and RCU users of this state to go away such that
+	 * all new such users will observe it.
 	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
 	synchronize_rcu();
 
-	balance_push_set(cpu, true);
-
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		update_rq_clock(rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -975,6 +975,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_push;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;


