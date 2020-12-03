Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBD2CD8AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbgLCOMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:36 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:58567 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727984AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id 0DDA7FA901
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:26 +0000 (GMT)
Received: (qmail 22842 invoked from network); 3 Dec 2020 14:11:25 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:25 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask of CPUs searched
Date:   Thu,  3 Dec 2020 14:11:20 +0000
Message-Id: <20201203141124.7391-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target CPU is definitely not idle in both select_idle_core and
select_idle_cpu. For select_idle_core(), the SMT is potentially
checked unnecessarily as the core is definitely not idle if the
target is busy. For select_idle_cpu(), the first CPU checked is
simply a waste.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 68dd9cd62fbd..1d8f5c4b4936 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6077,6 +6077,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		return -1;
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	__cpumask_clear_cpu(target, cpus);
 
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
@@ -6181,6 +6182,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	time = cpu_clock(this);
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	__cpumask_clear_cpu(target, cpus);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		schedstat_inc(this_rq()->sis_scanned);
-- 
2.26.2

