Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4F28E790
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgJNTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B5EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VfjO7DvAZs1k/McYztsBElm8C1Dir2otnj7gSQiFt40=; b=L2YlCN65XAsEEUCz2r2Cds+Mt8
        j+qG6xgcN1/UJbCgpVEx1PjyzcumP9C+3h732ZA14ReXBc5H2WUFcgTR7AStCOPKzM9Yglwc5vBC9
        0G7SwTJXSp8pRxQ32+NRbLfg4G8+qV81KuPKpjkjbrATNHH1azN8B2f6JsF3HN/iu46OA+Iy4ZuCu
        giFJYsc49BkNP6IGqf2vqbtHyhP56Ad5N7Jbry7lRI7OD4hfh8poZG4Gr7awMFeBJkkqngnFrc5y1
        8ZGWTpNt0oE6UA96bsC2gBgHe4JTnqm3jLD//t3oWJmeOAwfLULeUSVOf2Q44JSjAgsF1FAbS8Hkk
        V38KRRYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSmr7-0002SC-LU; Wed, 14 Oct 2020 19:54:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D915980F54; Wed, 14 Oct 2020 21:54:37 +0200 (CEST)
Date:   Wed, 14 Oct 2020 21:54:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/2] sched/cpupri: Add CPUPRI_HIGHER
Message-ID: <20201014195437.GD2974@worktop.programming.kicks-ass.net>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922083934.19275-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add CPUPRI_HIGHER above the RT99 priority to denote the CPU is in use
by higher priority tasks (specifically deadline).

XXX: we should probably drive PUSH-PULL from cpupri, that would
automagically result in an RT-PUSH when DL sets cpupri to CPUPRI_HIGHER.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cpupri.c   |   10 ++++++++--
 kernel/sched/cpupri.h   |    3 ++-
 kernel/sched/deadline.c |    3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)

--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -11,7 +11,7 @@
  *  This code tracks the priority of each CPU so that global migration
  *  decisions are easy to calculate.  Each CPU can be in a state as follows:
  *
- *                 (INVALID), NORMAL, RT1, ... RT99
+ *                 (INVALID), NORMAL, RT1, ... RT99, HIGHER
  *
  *  going from the lowest priority to the highest.  CPUs in the INVALID state
  *  are not eligible for routing.  The system maintains this state with
@@ -19,7 +19,7 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(100, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
@@ -37,6 +37,8 @@
  *	       50        49       49       50
  *	      ...
  *	       99         0        0       99
+ *
+ *				 100	  100 (CPUPRI_HIGHER)
  */
 static int convert_prio(int prio)
 {
@@ -54,6 +56,10 @@ static int convert_prio(int prio)
 	case MAX_RT_PRIO-1:
 		cpupri = CPUPRI_NORMAL;		/*  0 */
 		break;
+
+	case MAX_RT_PRIO:
+		cpupri = CPUPRI_HIGHER;		/* 100 */
+		break;
 	}

 	return cpupri;
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */

-#define CPUPRI_NR_PRIORITIES	MAX_RT_PRIO
+#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO+1)

 #define CPUPRI_INVALID		-1
 #define CPUPRI_NORMAL		 0
 /* values 1-99 are for RT1-RT99 priorities */
+#define CPUPRI_HIGHER		100

 struct cpupri_vec {
 	atomic_t		count;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1364,6 +1364,8 @@ static void inc_dl_deadline(struct dl_rq

 	if (dl_rq->earliest_dl.curr == 0 ||
 	    dl_time_before(deadline, dl_rq->earliest_dl.curr)) {
+		if (dl_rq->earliest_dl.curr == 0)
+			cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_HIGHER);
 		dl_rq->earliest_dl.curr = deadline;
 		cpudl_set(&rq->rd->cpudl, rq->cpu, deadline);
 	}
@@ -1381,6 +1383,7 @@ static void dec_dl_deadline(struct dl_rq
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
 		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
 		struct sched_dl_entity *entry;

