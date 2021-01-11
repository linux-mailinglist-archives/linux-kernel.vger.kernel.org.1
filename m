Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E22F1BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbhAKRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:12:25 -0500
Received: from foss.arm.com ([217.140.110.172]:33228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389352AbhAKRMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:12:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A7613A1;
        Mon, 11 Jan 2021 09:11:37 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47FED3F73C;
        Mon, 11 Jan 2021 09:11:36 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 4/4] cpu/hotplug: Fix CPU down rollback
Date:   Mon, 11 Jan 2021 17:10:47 +0000
Message-Id: <1610385047-92151-5-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

After the AP brought itself down to CPUHP_TEARDOWN_CPU, the BP will finish
the job. The steps left are as followed:

   +--------------------+
   | CPUHP_TEARDOWN_CPU |  -> If fails state is CPUHP_TEARDOWN_CPU
   +--------------------+
   |   ATOMIC STATES    |  -> Cannot Fail
   +--------------------+
   |  CPUHP_BRINGUP_CPU |  -> Cannot fail
   +--------------------+
   |        ...         |
   |        ...         |  -> Can fail and rollback
   |   CPUHP_OFFLINE    |
   +--------------------+

There are, in case of failure two possibilities:

  1. Failure in CPUHP_TEARDOWN_CPU, then st->state will still be
     CPUHP_TEARDOWN_CPU

  2. Failure between CPUHP_OFFLINE and CPUHP_BRINGUP_CPU.

For 2. The rollback will always run in the CPUHP_BRINGUP_CPU bringup
callback (bringup_cpu()) which kicks the AP back on. The latter will then
end-up setting st->state to CPUHP_AP_ONLINE_IDLE.

Checking for CPUHP_AP_ONLINE_IDLE allows then to rollback in all cases.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
---
 kernel/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aebec3a..8b3f84e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1078,7 +1078,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+	if (ret && (st->state == CPUHP_AP_ONLINE_IDLE ||
+		    st->state == CPUHP_TEARDOWN_CPU) &&
+	    st->state < prev_state) {
+		/*
+		 * After an error the state can be either:
+		 *  - CPUHP_TEARDOWN_CPU if this step failed.
+		 *  - CPUHP_AP_ONLINE_IDLE if any other failed.
+		 */
 		cpuhp_reset_state(st, prev_state);
 		__cpuhp_kick_ap(st);
 	}
-- 
2.7.4

