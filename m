Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34311273D73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIVIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:39:50 -0400
Received: from foss.arm.com ([217.140.110.172]:56986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgIVIjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:39:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE2441396;
        Tue, 22 Sep 2020 01:39:48 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 943813F718;
        Tue, 22 Sep 2020 01:39:46 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
Date:   Tue, 22 Sep 2020 10:39:33 +0200
Message-Id: <20200922083934.19275-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922083934.19275-1-dietmar.eggemann@arm.com>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pri_to_cpu[CPUPRI_IDLE=0] isn't used since cpupri_set(..., newpri) is
never called with newpri = MAX_PRIO (140).

Current mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              140        0 (CPUPRI_IDLE)

                              100        1 (CPUPRI_NORMAL)

             1        98       98        3
           ...
            49        50       50       51
            50        49       49       52
           ...
            99         0        0      101

Even when cpupri was introduced with commit 6e0534f27819 ("sched: use a
2-d bitmap for searching lowest-pri CPU") in v2.6.27, only

   (1) CPUPRI_INVALID (-1),
   (2) MAX_RT_PRIO (100),
   (3) an RT prio (RT1..RT99)

were used as newprio in cpupri_set(..., newpri) -> convert_prio(newpri).

MAX_RT_PRIO is used only in dec_rt_tasks() -> dec_rt_prio() ->
dec_rt_prio_smp() -> cpupri_set() in case of !rt_rq->rt_nr_running.
I.e. it stands for a non-rt task, including the IDLE task.

Commit 57785df5ac53 ("sched: Fix task priority bug") removed code in
v2.6.33 which did set the priority of the IDLE task to MAX_PRIO.
Although this happened after the introduction of cpupri, it didn't have
an effect on the values used for cpupri_set(..., newpri).

Remove CPUPRI_IDLE and adapt the cpupri implementation accordingly.
This will save a useless for loop with an atomic_read in
cpupri_find_fitness() calling __cpupri_find().

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        2
           ...
            49        50       50       50
            50        49       49       51
           ...
            99         0        0      100

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpupri.c | 10 ++++------
 kernel/sched/cpupri.h |  7 +++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 0033731a0797..a5d14ed485f4 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -11,7 +11,7 @@
  *  This code tracks the priority of each CPU so that global migration
  *  decisions are easy to calculate.  Each CPU can be in a state as follows:
  *
- *                 (INVALID), IDLE, NORMAL, RT1, ... RT99
+ *                 (INVALID), NORMAL, RT1, ... RT99
  *
  *  going from the lowest priority to the highest.  CPUs in the INVALID state
  *  are not eligible for routing.  The system maintains this state with
@@ -19,24 +19,22 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(102, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 102 based cpupri */
+/* Convert between a 140 based task->prio, and our 101 based cpupri */
 static int convert_prio(int prio)
 {
 	int cpupri;
 
 	if (prio == CPUPRI_INVALID)
 		cpupri = CPUPRI_INVALID;
-	else if (prio == MAX_PRIO)
-		cpupri = CPUPRI_IDLE;
 	else if (prio >= MAX_RT_PRIO)
 		cpupri = CPUPRI_NORMAL;
 	else
-		cpupri = MAX_RT_PRIO - prio + 1;
+		cpupri = MAX_RT_PRIO - prio;
 
 	return cpupri;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index efbb492bb94c..1a162369b8d4 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,11 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 2)
+#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 1)
 
 #define CPUPRI_INVALID		-1
-#define CPUPRI_IDLE		 0
-#define CPUPRI_NORMAL		 1
-/* values 2-101 are RT priorities 0-99 */
+#define CPUPRI_NORMAL		 0
+/* values 2-100 are RT priorities 0-99 */
 
 struct cpupri_vec {
 	atomic_t		count;
-- 
2.17.1

