Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4F25E425
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 01:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgIDX0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 19:26:36 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34886 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgIDX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:26:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 050452ACD7; Fri,  4 Sep 2020 19:26:27 -0400 (EDT)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <c281611544768e758bd58fe812cf702a5bd2d042.1599260540.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1599260540.git.fthain@telegraphics.com.au>
References: <cover.1599260540.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/5] powerpc/tau: Check processor type before enabling TAU
 interrupt
Date:   Sat, 05 Sep 2020 09:02:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Freescale's documentation, MPC74XX processors have an
erratum that prevents the TAU interrupt from working, so don't try to
use it when running on those processors.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/powerpc/kernel/tau_6xx.c  | 33 ++++++++++++++-------------------
 arch/powerpc/platforms/Kconfig |  5 ++---
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index b8d7e7d498e0a..614b5b272d9c6 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -40,6 +40,8 @@ static struct tau_temp
 	unsigned char grew;
 } tau[NR_CPUS];
 
+static bool tau_int_enable;
+
 #undef DEBUG
 
 /* TODO: put these in a /proc interface, with some sanity checks, and maybe
@@ -54,22 +56,13 @@ static struct tau_temp
 
 static void set_thresholds(unsigned long cpu)
 {
-#ifdef CONFIG_TAU_INT
-	/*
-	 * setup THRM1,
-	 * threshold, valid bit, enable interrupts, interrupt when below threshold
-	 */
-	mtspr(SPRN_THRM1, THRM1_THRES(tau[cpu].low) | THRM1_V | THRM1_TIE | THRM1_TID);
+	u32 maybe_tie = tau_int_enable ? THRM1_TIE : 0;
 
-	/* setup THRM2,
-	 * threshold, valid bit, enable interrupts, interrupt when above threshold
-	 */
-	mtspr (SPRN_THRM2, THRM1_THRES(tau[cpu].high) | THRM1_V | THRM1_TIE);
-#else
-	/* same thing but don't enable interrupts */
-	mtspr(SPRN_THRM1, THRM1_THRES(tau[cpu].low) | THRM1_V | THRM1_TID);
-	mtspr(SPRN_THRM2, THRM1_THRES(tau[cpu].high) | THRM1_V);
-#endif
+	/* setup THRM1, threshold, valid bit, interrupt when below threshold */
+	mtspr(SPRN_THRM1, THRM1_THRES(tau[cpu].low) | THRM1_V | maybe_tie | THRM1_TID);
+
+	/* setup THRM2, threshold, valid bit, interrupt when above threshold */
+	mtspr(SPRN_THRM2, THRM1_THRES(tau[cpu].high) | THRM1_V | maybe_tie);
 }
 
 static void TAUupdate(int cpu)
@@ -142,9 +135,8 @@ static void tau_timeout(void * info)
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 
-#ifndef CONFIG_TAU_INT
-	TAUupdate(cpu);
-#endif
+	if (!tau_int_enable)
+		TAUupdate(cpu);
 
 	size = tau[cpu].high - tau[cpu].low;
 	if (size > min_window && ! tau[cpu].grew) {
@@ -225,6 +217,9 @@ static int __init TAU_init(void)
 		return 1;
 	}
 
+	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
+			 !strcmp(cur_cpu_spec->platform, "ppc750");
+
 	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
 	if (!tau_workq)
 		return -ENOMEM;
@@ -234,7 +229,7 @@ static int __init TAU_init(void)
 	queue_work(tau_workq, &tau_work);
 
 	pr_info("Thermal assist unit using %s, shrink_timer: %d ms\n",
-		IS_ENABLED(CONFIG_TAU_INT) ? "interrupts" : "workqueue", shrink_timer);
+		tau_int_enable ? "interrupts" : "workqueue", shrink_timer);
 	tau_initialized = 1;
 
 	return 0;
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fb7515b4fa9c6..9fe36f0b54c1a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -223,9 +223,8 @@ config TAU
 	  temperature within 2-4 degrees Celsius. This option shows the current
 	  on-die temperature in /proc/cpuinfo if the cpu supports it.
 
-	  Unfortunately, on some chip revisions, this sensor is very inaccurate
-	  and in many cases, does not work at all, so don't assume the cpu
-	  temp is actually what /proc/cpuinfo says it is.
+	  Unfortunately, this sensor is very inaccurate when uncalibrated, so
+	  don't assume the cpu temp is actually what /proc/cpuinfo says it is.
 
 config TAU_INT
 	bool "Interrupt driven TAU driver (DANGEROUS)"
-- 
2.26.2

