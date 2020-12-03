Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231E2CD8A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgLCOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:59197 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbgLCOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:17 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 6E4A715C5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:25 +0000 (GMT)
Received: (qmail 22720 invoked from network); 3 Dec 2020 14:11:25 -0000
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
Subject: [PATCH 03/10] sched/fair: Remove SIS_AVG_CPU
Date:   Thu,  3 Dec 2020 14:11:17 +0000
Message-Id: <20201203141124.7391-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIS_AVG_CPU was introduced as a means of avoiding a search when the
average search cost indicated that the search would likely fail. It
was a blunt instrument and disabled by 4c77b18cf8b7 ("sched/fair: Make
select_idle_cpu() more aggressive") and later replaced with a proportional
search depth by 1ad3aaf3fcd2 ("sched/core: Implement new approach to
scale select_idle_cpu()").

While there are corner cases where SIS_AVG_CPU is better, it has now been
disabled for almost three years. As the intent of SIS_PROP is to reduce
the time complexity of select_idle_cpu(), lets drop SIS_AVG_CPU and focus
on SIS_PROP as a throttling mechanism.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c     | 3 ---
 kernel/sched/features.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9acd55d309b..fc48cc99b03d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6163,9 +6163,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	avg_idle = this_rq()->avg_idle / 512;
 	avg_cost = this_sd->avg_scan_cost + 1;
 
-	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
-		return -1;
-
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
 		if (span_avg > 4*avg_cost)
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 68d369cba9e4..e875eabb6600 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -54,7 +54,6 @@ SCHED_FEAT(TTWU_QUEUE, true)
 /*
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
-SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
 
 /*
-- 
2.26.2

