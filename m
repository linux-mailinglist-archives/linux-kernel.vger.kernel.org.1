Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21F52B8D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgKSIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:30:31 -0500
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:51660 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgKSIaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:30:30 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id 92542BF020
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:30:28 +0000 (GMT)
Received: (qmail 4668 invoked from network); 19 Nov 2020 08:30:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Nov 2020 08:30:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched: Avoid unnecessary calculation of load imbalance at clone time
Date:   Thu, 19 Nov 2020 08:30:25 +0000
Message-Id: <20201119083027.31335-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201119083027.31335-1-mgorman@techsingularity.net>
References: <20201119083027.31335-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_idlest_group(), the load imbalance is only relevant when the group
is either overloaded or fully busy but it is calculated unconditionally.
This patch moves the imbalance calculation to the context it is required.
Technically, it is a micro-optimisation but really the benefit is avoiding
confusing one type of imbalance with another depending on the group_type
in the next patch.

No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5fbed29e4001..9aded12aaa90 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8777,9 +8777,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			.group_type = group_overloaded,
 	};
 
-	imbalance = scale_load_down(NICE_0_LOAD) *
-				(sd->imbalance_pct-100) / 100;
-
 	do {
 		int local_group;
 
@@ -8833,6 +8830,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	switch (local_sgs.group_type) {
 	case group_overloaded:
 	case group_fully_busy:
+
+		/* Calculate allowed imbalance based on load */
+		imbalance = scale_load_down(NICE_0_LOAD) *
+				(sd->imbalance_pct-100) / 100;
+
 		/*
 		 * When comparing groups across NUMA domains, it's possible for
 		 * the local domain to be very lightly loaded relative to the
-- 
2.26.2

