Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B422D9D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440332AbgLNRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502106AbgLNRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:08:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF645C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pXtkFszJK1QV+qU3zUbs6UGEYq16Cgt2qqx2b/baTOQ=; b=pNIV2uHlxP2XOJhvOjWXggRiNk
        /uhNS5OYrM94BzxsF+k+pg52LTqZ+gncolPPU7k5qXdCwN2wmNwP+F7iAJ+pKo2jNaeBWhnILdpDi
        uXkkF435tw0wvKiIoLu39ASL8r/Qi6kZffLJtUI9M+E0dfpNRvasJ2SvnZNyWsYw+dXFa1Q9DaBQU
        3sE3pCaVNCg8BWgukRBqg+gvKpOmva24m2arV7DxvnFjavzYptEEAWuQznZBWpmSdLbJMqFoVAuzw
        sy8iRLYZJBmtJN/Bgch0zGbORkYSvaGWAkp8yyVin+stKZ1bQK/n04/D4lLkNgVO6AnP5VnU23jyZ
        3izJBLzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korJS-0000i7-Cu; Mon, 14 Dec 2020 17:07:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98C233059DD;
        Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E81B2364D0D5; Mon, 14 Dec 2020 18:07:04 +0100 (CET)
Message-ID: <20201214170017.999784864@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Dec 2020 17:48:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mgorman@techsingularity.net, vincent.guittot@linaro.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: [RFC][PATCH 3/5] sched/fair: Remove select_idle_smt()
References: <20201214164822.402812729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the next patch more readable, and to quantify the
actual effectiveness of this pass, start by removing it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6103,27 +6103,6 @@ static int select_idle_core(struct task_
 	return -1;
 }
 
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			return cpu;
-	}
-
-	return -1;
-}
-
 #else /* CONFIG_SCHED_SMT */
 
 #define sched_smt_weight	1
@@ -6133,11 +6112,6 @@ static inline int select_idle_core(struc
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
 #endif /* CONFIG_SCHED_SMT */
 
 #define sis_min_cores		2
@@ -6334,10 +6308,6 @@ static int select_idle_sibling(struct ta
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	return target;
 }
 


