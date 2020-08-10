Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6870240371
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgHJIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 04:30:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:30:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B891FB;
        Mon, 10 Aug 2020 01:30:32 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9CB63F7BB;
        Mon, 10 Aug 2020 01:30:28 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org, mgorman@suse.de,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        lukasz.luba@arm.com
Cc:     juri.lelli@redhat.com, patrick.bellasi@matbug.com,
        tglx@linutronix.de, rostedt@goodmis.org
Subject: [PATCH] sched/fair: Fix wrong negative conversion in find_energy_efficient_cpu()
Date:   Mon, 10 Aug 2020 09:30:04 +0100
Message-Id: <20200810083004.26420-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In find_energy_efficient_cpu() 'cpu_cap' could be less that 'util'.
It might be because of RT, DL (so higher sched class than CFS), irq or
thermal pressure signal, which reduce the capacity value.
In such situation the result of 'cpu_cap - util' might be negative but
stored in the unsigned long. Then it might be compared with other unsigned
long when uclamp_rq_util_with() reduced the 'util' such that is passes the
fits_capacity() check.

Prevent this situation and make the arithmetic more safe.

Fixes: 1d42509e475cd ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..51408ebd76c2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6594,7 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			spare_cap = cpu_cap - util;
+			spare_cap = cpu_cap;
+			lsub_positive(&spare_cap, util);
 
 			/*
 			 * Skip CPUs that cannot satisfy the capacity request.
-- 
2.17.1

