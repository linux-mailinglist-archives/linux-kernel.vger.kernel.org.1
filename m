Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3E2A3347
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKBSsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:48:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgKBSsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:48:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5743F143B;
        Mon,  2 Nov 2020 10:48:09 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 227BB3F719;
        Mon,  2 Nov 2020 10:48:08 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v4 3/3] sched/fair: Dissociate wakeup decisions from SD flag value
Date:   Mon,  2 Nov 2020 18:45:14 +0000
Message-Id: <20201102184514.2733-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102184514.2733-1-valentin.schneider@arm.com>
References: <20201102184514.2733-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c02f7af0a925..4f9ff5d85ab2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6684,7 +6684,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
 		if (sched_energy_enabled()) {
@@ -6721,9 +6721,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
2.27.0

