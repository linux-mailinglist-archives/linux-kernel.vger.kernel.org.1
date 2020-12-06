Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737D2D0510
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgLFNOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:14:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:14:00 -0500
Date:   Sun, 06 Dec 2020 13:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607260399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5EgvOalQWfX/rTvBtRlH7X++qYd9C2r3b2oOneNjIfE=;
        b=lYuIp14m/ExsV46hM3zx+KDrot8IIPYEwiVrSfBNcERYBfxQ9BSo35r72G9pjVxPq9+E46
        0Fttur02pk1Mg7XHsR5maGxwj10Qlk2sdMM1JXaNiJBsYIPaEnzrvpv3Y8ETHoerDErwN8
        3l9omMBez468RjJ7KJ2sZaJQ4DWftJ6M4TS3OGEqVNWDI8Th0G5HyDz57SNIcv4kv05ndc
        aczQ4QSameQ+1+uDoXEa2v59FG2V7Y+QDkVWLL3PLFp0lRKMOgNkfIKM/5DXOsC8ZNsnSV
        HQuxO9uyI/UrHYfhEFR5F3AicpITDQOhLvYWoHw180bZUP5mj61PINf07uT0Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607260399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5EgvOalQWfX/rTvBtRlH7X++qYd9C2r3b2oOneNjIfE=;
        b=MJh4RBCCG8Y7J7g/WihBbIYOPCsIn1e2V1UvHJnl2HQy9SNolUhtb7K4BBb6ld4vFjGOT8
        JJLxmuao5keIiZBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.10-rc7
References: <160726029814.10836.11636935433736940390.tglx@nanos>
Message-ID: <160726029935.10836.17254923642337108244.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-06

up to:  4d916140bf28: intel_idle: Build fix


A tiny build fix for a recent change in the intel_idle driver which missed
a CONFIG dependency and broke the build for certain configurations.


Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      intel_idle: Build fix


 drivers/idle/intel_idle.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7ee7ffe22ae3..d79335506ecd 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1140,6 +1140,20 @@ static bool __init intel_idle_max_cstate_reached(int cstate)
 	return false;
 }
 
+static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
+{
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	if (boot_cpu_has(X86_FEATURE_ARAT))
+		return false;
+
+	/*
+	 * Switch over to one-shot tick broadcast if the target C-state
+	 * is deeper than C1.
+	 */
+	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
+}
+
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 #include <acpi/processor.h>
 
@@ -1210,20 +1224,6 @@ static bool __init intel_idle_acpi_cst_extract(void)
 	return false;
 }
 
-static bool __init intel_idle_state_needs_timer_stop(struct cpuidle_state *state)
-{
-	unsigned long eax = flg2MWAIT(state->flags);
-
-	if (boot_cpu_has(X86_FEATURE_ARAT))
-		return false;
-
-	/*
-	 * Switch over to one-shot tick broadcast if the target C-state
-	 * is deeper than C1.
-	 */
-	return !!((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK);
-}
-
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);

