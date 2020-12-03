Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4722CD8A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436578AbgLCOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:23 -0500
Received: from outbound-smtp62.blacknight.com ([46.22.136.251]:35125 "EHLO
        outbound-smtp62.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728640AbgLCOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:18 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 87FDBFA916
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:11:26 +0000 (GMT)
Received: (qmail 22909 invoked from network); 3 Dec 2020 14:11:26 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 3 Dec 2020 14:11:26 -0000
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
Subject: [PATCH 08/10] sched/fair: Reintroduce SIS_AVG_CPU but in the context of SIS_PROP to reduce search depth
Date:   Thu,  3 Dec 2020 14:11:22 +0000
Message-Id: <20201203141124.7391-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201203141124.7391-1-mgorman@techsingularity.net>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says it all but no supporting data at this time. This might help
the hackbench case in isolation or throw other workloads under the bus.
Final version will have proper data.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 185fc6e28f8e..33ce65b67381 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6024,6 +6024,14 @@ static int sis_search_depth(struct sched_domain *sd, struct sched_domain *this_s
 			nr = div_u64(span_avg, avg_cost);
 		else
 			nr = 4;
+
+		/*
+		 * Throttle the depth search futher if average idle time is
+		 * below the average cost. This is primarily to deal with
+		 * the saturated case where searches are likely to fail.
+		 */
+		if (avg_idle < avg_cost)
+			nr >>= 1;
 	}
 
 	return nr;
-- 
2.26.2

