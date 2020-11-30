Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F25C2C86FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgK3OlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:41:14 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:50920 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgK3OlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:41:13 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id D152BCB011
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:40:21 +0000 (GMT)
Received: (qmail 28275 invoked from network); 30 Nov 2020 14:40:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2020 14:40:21 -0000
Date:   Mon, 30 Nov 2020 14:40:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] sched/fair: Clear SMT siblings after determining the core is
 not idle
Message-ID: <20201130144020.GS3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clearing of SMT siblings from the SIS mask before checking for an idle
core is a small but unnecessary cost. Defer the clearing of the siblings
until the scan moves to the next potential target. The cost of this was
not measured as it is borderline noise but it should be self-evident.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0d54d69ba1a5..d9acd55d309b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6087,10 +6087,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
 	/*
