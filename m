Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399AC28E78A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgJNTtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:49:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD10C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fdtT9ejz8uATr5mE3DLZSnRV4n8kNd3NsXzN0xjmomU=; b=QpjFY5EPYICjaYmWa4MPz/4DEE
        Rr0/f+LJ9u5wb3kQcuiho9XvHmohl+UeaU8SowS4nd7tdk/dh2yMERmT+DCELmiC0MmiEmU4rlllN
        l5Un23/1YJ0jSTKMmDFsu3yJvw5724+015KFnOkq2tHRMktNcDpmoYBDv27fVA4YM3Fd0fs9FEQtT
        JbSMxNOj9175HihNTAzOeK/RjTflmY5M8la6/BhCJaWj0h5oa03QL5CNgQ3J76Bb6thuvpsHzP5Qu
        4R05o/4XiKnEME6UPCDC282vAJs8z2/S8w3w8oLom8zX/OQl/SsAcwONFK8b/nARPIRc2i6p18X7y
        nYkqCKIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSmlf-0002Ae-Gz; Wed, 14 Oct 2020 19:49:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C2B8980F54; Wed, 14 Oct 2020 21:48:59 +0200 (CEST)
Date:   Wed, 14 Oct 2020 21:48:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/2] sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1
Message-ID: <20201014194858.GC2974@worktop.programming.kicks-ass.net>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922083934.19275-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This makes the mapping continuous and frees up 100 for other usage.

Prev mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                               99        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cpupri.c |   34 +++++++++++++++++++++++++++-------
 kernel/sched/rt.c     |   16 +++++++++-------
 2 files changed, 36 insertions(+), 14 deletions(-)

--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -24,17 +24,37 @@
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 100 based cpupri */
+/*
+ * p->rt_priority   p->prio   newpri   cpupri
+ *
+ *				  -1       -1 (CPUPRI_INVALID)
+ *
+ *				  99        0 (CPUPRI_NORMAL)
+ *
+ *		1        98       98        1
+ *	      ...
+ *	       49        50       50       49
+ *	       50        49       49       50
+ *	      ...
+ *	       99         0        0       99
+ */
 static int convert_prio(int prio)
 {
 	int cpupri;
 
-	if (prio == CPUPRI_INVALID)
-		cpupri = CPUPRI_INVALID;
-	else if (prio >= MAX_RT_PRIO)
-		cpupri = CPUPRI_NORMAL;
-	else
-		cpupri = MAX_RT_PRIO - prio - 1;
+	switch (prio) {
+	case CPUPRI_INVALID:
+		cpupri = CPUPRI_INVALID;	/* -1 */
+		break;
+
+	case 0...98:
+		cpupri = MAX_RT_PRIO-1 - prio;	/* 1 ... 99 */
+		break;
+
+	case MAX_RT_PRIO-1:
+		cpupri = CPUPRI_NORMAL;		/*  0 */
+		break;
+	}
 
 	return cpupri;
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,8 +89,8 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	__set_bit(MAX_RT_PRIO, array->bitmap);
 
 #if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
-	rt_rq->highest_prio.next = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
@@ -161,7 +161,7 @@ void init_tg_rt_entry(struct task_group
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_boosted = 0;
 	rt_rq->rq = rq;
 	rt_rq->tg = tg;
@@ -393,8 +393,9 @@ static void dequeue_pushable_task(struct
 		p = plist_first_entry(&rq->rt.pushable_tasks,
 				      struct task_struct, pushable_tasks);
 		rq->rt.highest_prio.next = p->prio;
-	} else
-		rq->rt.highest_prio.next = MAX_RT_PRIO;
+	} else {
+		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+	}
 }
 
 #else
@@ -1147,8 +1148,9 @@ dec_rt_prio(struct rt_rq *rt_rq, int pri
 				sched_find_first_bit(array->bitmap);
 		}
 
-	} else
-		rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	} else {
+		rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	}
 
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }

