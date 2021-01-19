Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB82FB855
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392600AbhASMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:17:23 -0500
Received: from foss.arm.com ([217.140.110.172]:53906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389776AbhASMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:08:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E96113E;
        Tue, 19 Jan 2021 04:08:13 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 148A13F719;
        Tue, 19 Jan 2021 04:08:11 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched/eas: Don't update misfit status if the task is pinned
Date:   Tue, 19 Jan 2021 12:07:55 +0000
Message-Id: <20210119120755.2425264-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the task is pinned to a cpu, setting the misfit status means that
we'll unnecessarily continuously attempt to migrate the task but fail.

This continuous failure will cause the balance_interval to increase to
a high value, and eventually cause unnecessary significant delays in
balancing the system when real imbalance happens.

Caught while testing uclamp where rt-app calibration loop was pinned to
cpu 0, shortly after which we spawn another task with high util_clamp
value. The task was failing to migrate after over 40ms of runtime due to
balance_interval unnecessary expanded to a very high value from the
calibration loop.

Not done here, but it could be useful to extend the check for pinning to
verify that the affinity of the task has a cpu that fits. We could end
up in a similar situation otherwise.

Fixes: 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 197a51473e0c..9379a481dd8c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4060,7 +4060,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 	if (!static_branch_unlikely(&sched_asym_cpucapacity))
 		return;
 
-	if (!p) {
+	if (!p || p->nr_cpus_allowed == 1) {
 		rq->misfit_task_load = 0;
 		return;
 	}
-- 
2.25.1

