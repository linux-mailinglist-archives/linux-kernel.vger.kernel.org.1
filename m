Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DD1B7F19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgDXThh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:37:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:23297 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgDXTh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:37:28 -0400
IronPort-SDR: /KtyUZr/QSiATZYqG6/2mgtARa5/3yA9aLPJSmNQOz57wtgnN0MiayvrmAZOrHpWWFKT/uhiKB
 ZIZi+kxfpezw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 12:37:26 -0700
IronPort-SDR: ugAU5SoIYpM33jGyrd/BLKC600zBLKCaqbkV6YHfn5xsj3PyzNEqH0SDsiGTTXjIOKWOHX45Sd
 Aj4nICqVWy/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="403425642"
Received: from kmp-skylake-client-platform.sc.intel.com ([172.25.112.108])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 12:37:23 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        gregkh@linuxfoundation.org, ak@linux.intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, kyung.min.park@intel.com
Subject: [PATCH v4 1/3] x86/delay: Preparatory code cleanup
Date:   Fri, 24 Apr 2020 12:37:54 -0700
Message-Id: <1587757076-30337-2-git-send-email-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587757076-30337-1-git-send-email-kyung.min.park@intel.com>
References: <1587757076-30337-1-git-send-email-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The naming conventions in the delay code are confusing at best.

All delay variants use a loops argument and or variable which originates
from the original delay_loop() implementation. But all variants except
delay_loop() are based on TSC cycles.

Rename the argument to cycles and make it type u64 to avoid these weird
expansions to u64 in the functions.

Rename MWAITX_MAX_LOOPS to MWAITX_MAX_WAIT_CYCLES for the same reason
and fixup the comment of delay_mwaitx() as well.

Mark the delay_fn function pointer __ro_after_init and fixup the comment
for it.

No functional change and preparation for the upcoming TPAUSE based delay
variant.

[Kyung Min Park: Added __init to use_tsc_delay()]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 arch/x86/include/asm/delay.h |  3 ++-
 arch/x86/include/asm/mwait.h |  2 +-
 arch/x86/lib/delay.c         | 45 +++++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/delay.h b/arch/x86/include/asm/delay.h
index de9e784..9aa38de 100644
--- a/arch/x86/include/asm/delay.h
+++ b/arch/x86/include/asm/delay.h
@@ -3,8 +3,9 @@
 #define _ASM_X86_DELAY_H
 
 #include <asm-generic/delay.h>
+#include <linux/init.h>
 
-void use_tsc_delay(void);
+void __init use_tsc_delay(void);
 void use_mwaitx_delay(void);
 
 #endif /* _ASM_X86_DELAY_H */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index b809f11..a43b35b 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -20,7 +20,7 @@
 
 #define MWAIT_ECX_INTERRUPT_BREAK	0x1
 #define MWAITX_ECX_TIMER_ENABLE		BIT(1)
-#define MWAITX_MAX_LOOPS		((u32)-1)
+#define MWAITX_MAX_WAIT_CYCLES		UINT_MAX
 #define MWAITX_DISABLE_CSTATES		0xf0
 
 u32 get_umwait_control_msr(void);
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index c126571..887d52d 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -27,9 +27,19 @@
 # include <asm/smp.h>
 #endif
 
+static void delay_loop(u64 __loops);
+
+/*
+ * Calibration and selection of the delay mechanism happens only once
+ * during boot.
+ */
+static void (*delay_fn)(u64) __ro_after_init = delay_loop;
+
 /* simple loop based delay: */
-static void delay_loop(unsigned long loops)
+static void delay_loop(u64 __loops)
 {
+	unsigned long loops = (unsigned long)__loops;
+
 	asm volatile(
 		"	test %0,%0	\n"
 		"	jz 3f		\n"
@@ -49,9 +59,9 @@ static void delay_loop(unsigned long loops)
 }
 
 /* TSC based delay: */
-static void delay_tsc(unsigned long __loops)
+static void delay_tsc(u64 cycles)
 {
-	u64 bclock, now, loops = __loops;
+	u64 bclock, now;
 	int cpu;
 
 	preempt_disable();
@@ -59,7 +69,7 @@ static void delay_tsc(unsigned long __loops)
 	bclock = rdtsc_ordered();
 	for (;;) {
 		now = rdtsc_ordered();
-		if ((now - bclock) >= loops)
+		if ((now - bclock) >= cycles)
 			break;
 
 		/* Allow RT tasks to run */
@@ -77,7 +87,7 @@ static void delay_tsc(unsigned long __loops)
 		 * counter for this CPU.
 		 */
 		if (unlikely(cpu != smp_processor_id())) {
-			loops -= (now - bclock);
+			cycles -= (now - bclock);
 			cpu = smp_processor_id();
 			bclock = rdtsc_ordered();
 		}
@@ -87,24 +97,24 @@ static void delay_tsc(unsigned long __loops)
 
 /*
  * On some AMD platforms, MWAITX has a configurable 32-bit timer, that
- * counts with TSC frequency. The input value is the loop of the
- * counter, it will exit when the timer expires.
+ * counts with TSC frequency. The input value is the number of TSC cycles
+ * to wait. MWAITX will also exit when the timer expires.
  */
-static void delay_mwaitx(unsigned long __loops)
+static void delay_mwaitx(u64 cycles)
 {
-	u64 start, end, delay, loops = __loops;
+	u64 start, end, delay;
 
 	/*
 	 * Timer value of 0 causes MWAITX to wait indefinitely, unless there
 	 * is a store on the memory monitored by MONITORX.
 	 */
-	if (loops == 0)
+	if (!cycles)
 		return;
 
 	start = rdtsc_ordered();
 
 	for (;;) {
-		delay = min_t(u64, MWAITX_MAX_LOOPS, loops);
+		delay = min_t(u64, MWAITX_MAX_WAIT_CYCLES, cycles);
 
 		/*
 		 * Use cpu_tss_rw as a cacheline-aligned, seldomly
@@ -121,22 +131,15 @@ static void delay_mwaitx(unsigned long __loops)
 
 		end = rdtsc_ordered();
 
-		if (loops <= end - start)
+		if (cycles <= end - start)
 			break;
 
-		loops -= end - start;
-
+		cycles -= end - start;
 		start = end;
 	}
 }
 
-/*
- * Since we calibrate only once at boot, this
- * function should be set once at boot and not changed
- */
-static void (*delay_fn)(unsigned long) = delay_loop;
-
-void use_tsc_delay(void)
+void __init use_tsc_delay(void)
 {
 	if (delay_fn == delay_loop)
 		delay_fn = delay_tsc;
-- 
2.7.4

