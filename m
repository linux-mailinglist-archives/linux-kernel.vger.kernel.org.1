Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9591B434C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDVLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726503AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D1C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0qa2+QIIiLbgBpsEjd4lNHJHXzCb6gCiam0xs4K3iIo=; b=e/JD0850HzBF4kjIX6kEHlcN3o
        SQSTvLUXzdNEB0X5p5Y1jnlKh1lTWc2Sz48YgbEttEVlHy7cqjM5GN93hswpKzaVG8STH4c54tPCY
        d/2YWycCzBBkXvN9Jn1qzjRZNJ627H6pQmf9m9Ja94/ibqinCh4IACKitOYLxfhUXlCtxRR+fqRQS
        yEJCnU4fL68uUlOBtyCRMs5zvGHzUcWHnOkjfU6ES3t8fL03Qss3KZumG/rWgnPHRktG+dD1N7KzI
        VNaL4J2/ufG3EGKEqD5Gj8IWsWCA7hEkqgOleB8NNABKBiHDo3HOhgXplaK6fsXgNH0qsgS6e1vbA
        utEXAkzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0003bR-L5; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 582B1307980;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EE8E22B99F06; Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Message-Id: <20200422112832.343851342@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, paulmck@kernel.org
Subject: [PATCH 19/23] sched,rcuperf: Convert to sched_set_fifo_low()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rcu/rcuperf.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -353,7 +353,6 @@ rcu_perf_writer(void *arg)
 	int i_max;
 	long me = (long)arg;
 	struct rcu_head *rhp = NULL;
-	struct sched_param sp;
 	bool started = false, done = false, alldone = false;
 	u64 t;
 	u64 *wdp;
@@ -362,8 +361,7 @@ rcu_perf_writer(void *arg)
 	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
 	WARN_ON(!wdpp);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	sp.sched_priority = 1;
-	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
+	sched_set_fifo_low(current);
 
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
@@ -419,9 +417,7 @@ rcu_perf_writer(void *arg)
 			started = true;
 		if (!done && i >= MIN_MEAS) {
 			done = true;
-			sp.sched_priority = 0;
-			sched_setscheduler_nocheck(current,
-						   SCHED_NORMAL, &sp);
+			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
 				 perf_type, PERF_FLAG, me, MIN_MEAS);
 			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=


