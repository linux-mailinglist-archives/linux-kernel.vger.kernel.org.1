Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF002F7830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbhAOMCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbhAOMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:02:52 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:02:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so5350621pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vXdisx8OAH7gMWMzyAsECYXynohbi+7y0YBTv0zBkaE=;
        b=msLlb356eSmdzJxJQC3YCwf3OL0Urb2poVeYI32hMcHdo8y1dlpNBZr/UEgR/siejX
         NnPrXcGoFUlHdU0tFgM+PWNzib5BtuHQn2rL2Q/T+GN5+kT3t0WMgF2c7CNSdRiqXVlg
         K133/vDgaQI2gtT4xMS/PkMurkA2bNWV+OzzoK6EKIYfofzvAssaGQXgrEDgKvsr/9qt
         AgpuByNPJMIW/Obn3m7+stW/aeG7BLqotsB0w6h5pRTGT6t87tNvlqdKFCJuzgC2J2iQ
         LlOOYLCOv2yix7x5rGcEKAA4/NgyK/krLo5k4V3R/7ZhQ7tkIH/myHuudqZ78wtcBAD9
         f07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vXdisx8OAH7gMWMzyAsECYXynohbi+7y0YBTv0zBkaE=;
        b=hU3nXbwRlXRTr0i3sKV+ZmYfDZBSjz1zmufp0yixFzymF3Qr6wRtKXkU/IqJffybxa
         41ZXnd43WyAQsvo97Gl7KbCZJPyic/wzaqvf1U/mX9a5rIAhrdB5Kpsji+1WN5DY2Ymz
         d+vgey/j9MXc2RWw2pNl4e5mI5171VG/OMqqFxEeW2QmEgK2NfHJLgEyFII+S+JOb5pi
         1aSxAqSTzGcRq8YShAkMg3sao+tQyUmk08mqYwCqzAtYPLAuG3WsniV86QzVTSuh4nKU
         A1m9c38OyIK9rddD+9tclLNqW5a/DWgoDqU63oNQbUYxqGSrHBmhnfIcTPa4yH2NuQpw
         PT2Q==
X-Gm-Message-State: AOAM533c/VDaglAFPVZ7pcuINkZ268ihVkroFxsUwpcKtelLBJAlvh2g
        31IbiwhoTKlW+QNShsL6EsdLeA==
X-Google-Smtp-Source: ABdhPJxuiSyUTAZHncCy6gFM/d+XxL6RnvPOI1V7NJCRTXuOvWwa/edF5hqqihlAtBudYXv9bwrLXQ==
X-Received: by 2002:a62:b50f:0:b029:19e:2974:b7a4 with SMTP id y15-20020a62b50f0000b029019e2974b7a4mr12287146pfe.61.1610712131538;
        Fri, 15 Jan 2021 04:02:11 -0800 (PST)
Received: from localhost.localdomain ([122.181.106.9])
        by smtp.gmail.com with ESMTPSA id d19sm7623386pjw.37.2021.01.15.04.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 04:02:10 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, mark.rutland@arm.com, lecopzer.chen@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        alexandru.elisei@arm.com, swboyd@chromium.org,
        dianders@chromium.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5] arm64: Enable perf events based hard lockup detector
Date:   Fri, 15 Jan 2021 17:31:41 +0530
Message-Id: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org>
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

Changes in v5:
- Fix lockup_detector_init() invocation to be rather invoked from CPU
  binded context as it makes heavy use of per-cpu variables and shouldn't
  be invoked from preemptible context.

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
 arch/arm64/kernel/perf_event.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 drivers/perf/arm_pmu.c         |  5 +++++
 include/linux/perf/arm_pmu.h   |  2 ++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f39568b..05e1735 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -174,6 +174,8 @@ config ARM64
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI && HW_PERF_EVENTS
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3605f77a..bafb7c8 100644
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
@@ -1246,12 +1248,30 @@ static struct platform_driver armv8_pmu_driver = {
 	.probe		= armv8_pmu_device_probe,
 };
 
+static int __init lockup_detector_init_fn(void *data)
+{
+	lockup_detector_init();
+	return 0;
+}
+
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
+		smp_call_on_cpu(raw_smp_processor_id(), lockup_detector_init_fn,
+				NULL, false);
+
+	return ret;
 }
 device_initcall(armv8_pmu_driver_init)
 
@@ -1309,3 +1329,27 @@ void arch_perf_update_userpage(struct perf_event *event,
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
index 5054802..bf79667 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -163,6 +163,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
 static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
+bool arm_pmu_irq_is_nmi(void);
+
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 struct arm_pmu *armpmu_alloc_atomic(void);
-- 
2.7.4

