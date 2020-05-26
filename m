Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F41AB315
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442256AbgDOVGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:06:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442237AbgDOVFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C3B13A1;
        Wed, 15 Apr 2020 14:05:33 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C1D93F6C4;
        Wed, 15 Apr 2020 14:05:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v3 7/9] sched/fair: Dissociate wakeup decisions from SD flag value
Date:   Wed, 15 Apr 2020 22:05:10 +0100
Message-Id: <20200415210512.805-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415210512.805-1-valentin.schneider@arm.com>
References: <20200415210512.805-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFS wakeup code will only ever go through EAS / its fast path on
"regular" wakeups (i.e. not on forks or execs). These are currently gated
by a check against 'sd_flag', which would be SD_BALANCE_WAKE at wakeup.

However, we now have a flag that explicitly tells us whether a wakeup is a
"regular" one, so hinge those conditions on that flag instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0bf98e6798b..f20e5cd6515c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6642,7 +6642,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		sd_flag = SD_BALANCE_EXEC;
 	}
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
 		if (sched_energy_enabled()) {
@@ -6679,9 +6679,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
-- 
2.24.0

