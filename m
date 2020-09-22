Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF19273D76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIVIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgIVIjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:39:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB0013D5;
        Tue, 22 Sep 2020 01:39:51 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37B3E3F718;
        Tue, 22 Sep 2020 01:39:49 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/cpupri: Remove pri_to_cpu[1]
Date:   Tue, 22 Sep 2020 10:39:34 +0200
Message-Id: <20200922083934.19275-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922083934.19275-1-dietmar.eggemann@arm.com>
References: <20200922083934.19275-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pri_to_cpu[1] isn't used since cpupri_set(..., newpri) is
never called with newpri = 99.

The valid RT priorities RT1..RT99 (p->rt_priority = [1..99]) map into
cpupri (idx of pri_to_cpu[]) = [2..100]

Current mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        2
           ...
            49        50       50       50
            50        49       49       51
           ...
            99         0        0      100

So cpupri = 1 isn't used.

Reduce the size of pri_to_cpu[] by 1 and adapt the cpupri
implementation accordingly. This will save a useless for loop with an
atomic_read in cpupri_find_fitness() calling __cpupri_find().

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpupri.c | 6 +++---
 kernel/sched/cpupri.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a5d14ed485f4..8d9952a51664 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -19,12 +19,12 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(100, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 101 based cpupri */
+/* Convert between a 140 based task->prio, and our 100 based cpupri */
 static int convert_prio(int prio)
 {
 	int cpupri;
@@ -34,7 +34,7 @@ static int convert_prio(int prio)
 	else if (prio >= MAX_RT_PRIO)
 		cpupri = CPUPRI_NORMAL;
 	else
-		cpupri = MAX_RT_PRIO - prio;
+		cpupri = MAX_RT_PRIO - prio - 1;
 
 	return cpupri;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 1a162369b8d4..e28e1ed12e3d 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 1)
+#define CPUPRI_NR_PRIORITIES	MAX_RT_PRIO
 
 #define CPUPRI_INVALID		-1
 #define CPUPRI_NORMAL		 0
-/* values 2-100 are RT priorities 0-99 */
+/* values 1-99 are for RT1-RT99 priorities */
 
 struct cpupri_vec {
 	atomic_t		count;
-- 
2.17.1

