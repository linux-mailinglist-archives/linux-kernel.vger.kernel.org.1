Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41EF285B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgJGIwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgJGIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:52:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F226C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:52:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x16so970122pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9SaoQENls+K3R0JYzMVIqtfhUysjvHP+eNcqf+t0Vhc=;
        b=N+fzOCZ3Wrf6Ebqd8WSu9deX3xxCX18mFzmyvjRkPYgsYWnipa8N33FyE+bKwpGSfH
         sk9yT7cUPCauYKpHezvT+sPHOnbK2RFusDQ5TgaE2LSI1Fc0jPO7hKcAQNQSKkmNj6MZ
         6iXxkrBIy/Z3EkSiaOvB1KFIUW+iT0+NjNj5V8C2V5GcbbM30Ojb6mDbsdx3dInrz9wL
         lYXbohlSmTjzIT0BhOnVxZFowsOEBGI/zezfB5rW7vZso2fkiyW0WbPb6CJsthQKyyf1
         FtCPT1Ssn9QErJGRmzbf5C38571KRDNrQy50efWLH3YLYtdH74t1Cb3pkyf8V20iSgD5
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9SaoQENls+K3R0JYzMVIqtfhUysjvHP+eNcqf+t0Vhc=;
        b=X8dKTt5LxwzD3L8+EZqNQbY5E9kiLzh3hBI5WDqpEtsPPwsT/1cG5bqSfOomel74sq
         59+yGb806Hy9Vd1ykU8+hnI1leXhCnPOFu1JOYq8lE8+aSWparTIwaP9pmMNbEBEsBlk
         hjjsJIowLDQ1yinpBXfsO+n1vO9ZEWrLwf77hAUV4lqK4Bzra/PqnruLXDgDuw/xHJqA
         dsuE+JLh2HzkErgSW6h6QyFv9T1w5+fOrkPNIhATIdigy73P93qqSCIlqfliCMYyT/I3
         2S0rYf9mmW+WsURzFgp9X5xD41ay0l404+e5NGhIstSOGMSHpqFD6BQWOjU2BskmRrtd
         6ELQ==
X-Gm-Message-State: AOAM531BT7s4/LizkeuvZlvpWMljdICo11OElQky9/rSAnhU0BFyaxIV
        xtjifHVh2OHv3gCyOGQHzb1p8z4j8H2YJTqX
X-Google-Smtp-Source: ABdhPJwh3jxScYJrthFY6AALREbHLZOq5Jcka1L3HDtj6cj04BJDDOKtzjbnA2+D/SXITLpdiyeHqQ==
X-Received: by 2002:a63:2e42:: with SMTP id u63mr2154539pgu.292.1602060730878;
        Wed, 07 Oct 2020 01:52:10 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id q8sm2120657pff.18.2020.10.07.01.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 01:52:10 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, alexandru.elisei@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        swboyd@chromium.org, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4] arm64: Enable perf events based hard lockup detector
Date:   Wed,  7 Oct 2020 14:21:43 +0530
Message-Id: <1602060704-10921-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent feature added to enable perf events to use pseudo NMIs
as interrupts on platforms which support GICv3 or later, its now been
possible to enable hard lockup detector (or NMI watchdog) on arm64
platforms. So enable corresponding support.

One thing to note here is that normally lockup detector is initialized
just after the early initcalls but PMU on arm64 comes up much later as
device_initcall(). So we need to re-initialize lockup detection once
PMU has been initialized.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Rebased to latest pmu v7 NMI patch-set [1] and in turn use "has_nmi"
  hook to know if PMU IRQ has been requested as an NMI.
- Add check for return value prior to initializing hard-lockup detector.

[1] https://lkml.org/lkml/2020/9/24/458

Changes in v3:
- Rebased to latest pmu NMI patch-set [1].
- Addressed misc. comments from Stephen.

[1] https://lkml.org/lkml/2020/8/19/671

Changes since RFC:
- Rebased on top of Alex's WIP-pmu-nmi branch.
- Add comment for safe max. CPU frequency.
- Misc. cleanup.

 arch/arm64/Kconfig             |  2 ++
 arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/perf/arm_pmu.c         |  5 +++++
 include/linux/perf/arm_pmu.h   |  2 ++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d23283..b5c2594 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -167,6 +167,8 @@ config ARM64
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index ef206fb..6ad5120 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -23,6 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
+#include <linux/nmi.h>
+#include <linux/cpufreq.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
@@ -1224,10 +1226,21 @@ static struct platform_driver armv8_pmu_driver = {
 
 static int __init armv8_pmu_driver_init(void)
 {
+	int ret;
+
 	if (acpi_disabled)
-		return platform_driver_register(&armv8_pmu_driver);
+		ret = platform_driver_register(&armv8_pmu_driver);
 	else
-		return arm_pmu_acpi_probe(armv8_pmuv3_init);
+		ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
+
+	/*
+	 * Try to re-initialize lockup detector after PMU init in
+	 * case PMU events are triggered via NMIs.
+	 */
+	if (ret == 0 && arm_pmu_irq_is_nmi())
+		lockup_detector_init();
+
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
@@ -1285,3 +1298,27 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 1;
 	userpg->cap_user_time_short = 1;
 }
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
+#endif
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index cb2f55f..794a37d 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -726,6 +726,11 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
+bool arm_pmu_irq_is_nmi(void)
+{
+	return has_nmi;
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 5b616dd..5765069 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -160,6 +160,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.7.4

