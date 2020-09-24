Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBA276F58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgIXLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbgIXLG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33F0D1570;
        Thu, 24 Sep 2020 04:06:27 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672C73F73B;
        Thu, 24 Sep 2020 04:06:25 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v7 7/7] arm_pmu: arm64: Use NMIs for PMU
Date:   Thu, 24 Sep 2020 12:07:06 +0100
Message-Id: <20200924110706.254996-8-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Add required PMU interrupt operations for NMIs. Request interrupt lines as
NMIs when possible, otherwise fall back to normal interrupts.

NMIs are only supported on the arm64 architecture with a GICv3 irqchip.

Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
[Alexandru E.: Added that NMIs only work on arm64 + GICv3, print message
	when PMU is using NMIs]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/perf/arm_pmu.c | 71 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index a770726e98d4..cb2f55f450e4 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -45,6 +45,17 @@ static const struct pmu_irq_ops pmuirq_ops = {
 	.free_pmuirq = armpmu_free_pmuirq
 };
 
+static void armpmu_free_pmunmi(unsigned int irq, int cpu, void __percpu *devid)
+{
+	free_nmi(irq, per_cpu_ptr(devid, cpu));
+}
+
+static const struct pmu_irq_ops pmunmi_ops = {
+	.enable_pmuirq = enable_nmi,
+	.disable_pmuirq = disable_nmi_nosync,
+	.free_pmuirq = armpmu_free_pmunmi
+};
+
 static void armpmu_enable_percpu_pmuirq(unsigned int irq)
 {
 	enable_percpu_irq(irq, IRQ_TYPE_NONE);
@@ -63,10 +74,37 @@ static const struct pmu_irq_ops percpu_pmuirq_ops = {
 	.free_pmuirq = armpmu_free_percpu_pmuirq
 };
 
+static void armpmu_enable_percpu_pmunmi(unsigned int irq)
+{
+	if (!prepare_percpu_nmi(irq))
+		enable_percpu_nmi(irq, IRQ_TYPE_NONE);
+}
+
+static void armpmu_disable_percpu_pmunmi(unsigned int irq)
+{
+	disable_percpu_nmi(irq);
+	teardown_percpu_nmi(irq);
+}
+
+static void armpmu_free_percpu_pmunmi(unsigned int irq, int cpu,
+				      void __percpu *devid)
+{
+	if (armpmu_count_irq_users(irq) == 1)
+		free_percpu_nmi(irq, devid);
+}
+
+static const struct pmu_irq_ops percpu_pmunmi_ops = {
+	.enable_pmuirq = armpmu_enable_percpu_pmunmi,
+	.disable_pmuirq = armpmu_disable_percpu_pmunmi,
+	.free_pmuirq = armpmu_free_percpu_pmunmi
+};
+
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
+static bool has_nmi;
+
 static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
 	if (event->hw.flags & ARMPMU_EVT_64BIT)
@@ -637,15 +675,31 @@ int armpmu_request_irq(int irq, int cpu)
 			    IRQF_NO_THREAD;
 
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-		err = request_irq(irq, handler, irq_flags, "arm-pmu",
+
+		err = request_nmi(irq, handler, irq_flags, "arm-pmu",
 				  per_cpu_ptr(&cpu_armpmu, cpu));
 
-		irq_ops = &pmuirq_ops;
+		/* If cannot get an NMI, get a normal interrupt */
+		if (err) {
+			err = request_irq(irq, handler, irq_flags, "arm-pmu",
+					  per_cpu_ptr(&cpu_armpmu, cpu));
+			irq_ops = &pmuirq_ops;
+		} else {
+			has_nmi = true;
+			irq_ops = &pmunmi_ops;
+		}
 	} else if (armpmu_count_irq_users(irq) == 0) {
-		err = request_percpu_irq(irq, handler, "arm-pmu",
-					 &cpu_armpmu);
-
-		irq_ops = &percpu_pmuirq_ops;
+		err = request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
+
+		/* If cannot get an NMI, get a normal interrupt */
+		if (err) {
+			err = request_percpu_irq(irq, handler, "arm-pmu",
+						 &cpu_armpmu);
+			irq_ops = &percpu_pmuirq_ops;
+		} else {
+			has_nmi= true;
+			irq_ops = &percpu_pmunmi_ops;
+		}
 	} else {
 		/* Per cpudevid irq was already requested by another CPU */
 		irq_ops = armpmu_find_irq_ops(irq);
@@ -928,8 +982,9 @@ int armpmu_register(struct arm_pmu *pmu)
 	if (!__oprofile_cpu_pmu)
 		__oprofile_cpu_pmu = pmu;
 
-	pr_info("enabled with %s PMU driver, %d counters available\n",
-		pmu->name, pmu->num_events);
+	pr_info("enabled with %s PMU driver, %d counters available%s\n",
+		pmu->name, pmu->num_events,
+		has_nmi ? ", using NMIs" : "");
 
 	return 0;
 
-- 
2.28.0

