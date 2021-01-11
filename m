Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6982F1BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbhAKRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:12:22 -0500
Received: from foss.arm.com ([217.140.110.172]:33212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389238AbhAKRMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:12:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A3A011FB;
        Mon, 11 Jan 2021 09:11:35 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 444B33F70D;
        Mon, 11 Jan 2021 09:11:34 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 2/4] cpu/hotplug: CPUHP_BRINGUP_CPU exception in fail injection
Date:   Mon, 11 Jan 2021 17:10:45 +0000
Message-Id: <1610385047-92151-3-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
triggered by the CPUHP_BRINGUP_CPU step. If the latter doesn't run, none
of the atomic can. Hence, rollback is not possible after a hotunplug
CPUHP_BRINGUP_CPU step failure and the "fail" interface shouldn't allow
it. Moreover, the current CPUHP_BRINGUP_CPU teardown callback
(finish_cpu()) cannot fail anyway.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
---
 kernel/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9121edf..bcd7b2a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2216,9 +2216,14 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 		return -EINVAL;
 
 	/*
-	 * Cannot fail STARTING/DYING callbacks.
+	 * Cannot fail STARTING/DYING callbacks. Also, those callbacks are
+	 * triggered by BRINGUP_CPU bringup callback. Therefore, the latter
+	 * can't fail during hotunplug, as it would mean we have no way of
+	 * rolling back the atomic states that have been previously teared
+	 * down.
 	 */
-	if (cpuhp_is_atomic_state(fail))
+	if (cpuhp_is_atomic_state(fail) ||
+	    (fail == CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU))
 		return -EINVAL;
 
 	/*
-- 
2.7.4

