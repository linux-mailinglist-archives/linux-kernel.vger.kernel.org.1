Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73B72DFDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgLUQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:23:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbgLUQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:23:44 -0500
X-UUID: dbd7d28a87d148a5a822be1cf055f76b-20201222
X-UUID: dbd7d28a87d148a5a822be1cf055f76b-20201222
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2111170807; Tue, 22 Dec 2020 00:22:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 00:22:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 00:22:49 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lecopzer.chen@mediatek.com>, <alexandru.elisei@arm.com>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <oliver.sang@intel.com>, <sumit.garg@linaro.org>,
        <will@kernel.org>, <yj.chiang@mediatek.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <catalin.marinas@arm.com>
Subject: [PATCH v2] arm64: perf: Fix access percpu variables in preemptible context
Date:   Tue, 22 Dec 2020 00:22:49 +0800
Message-ID: <20201221162249.3119-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
reinitilizes lockup detector after arm64 PMU is initialized and open
a window for accessing smp_processor_id() in preemptible context.
Since hardlockup_detector_perf_init() always called in init stage
with a single cpu, but we initialize lockup detector after the init task
is migratable.

Fix this by utilizing lockup detector reconfiguration which calls
softlockup_start_all() on each cpu and calls watatchdog_nmi_enable() later.
Because softlockup_start_all() use IPI call function to make sure
watatchdog_nmi_enable() will bind on each cpu and fix this issue.

    BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
    caller is debug_smp_processor_id+0x20/0x2c
    CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.0+ #276
    Hardware name: linux,dummy-virt (DT)
    Call trace:
      dump_backtrace+0x0/0x3c0
      show_stack+0x20/0x6c
      dump_stack+0x2f0/0x42c
      check_preemption_disabled+0x1cc/0x1dc
      debug_smp_processor_id+0x20/0x2c
      hardlockup_detector_event_create+0x34/0x18c
      hardlockup_detector_perf_init+0x2c/0x134
      watchdog_nmi_probe+0x18/0x24
      lockup_detector_init+0x44/0xa8
      armv8_pmu_driver_init+0x54/0x78
      do_one_initcall+0x184/0x43c
      kernel_init_freeable+0x368/0x380
      kernel_init+0x1c/0x1cc
      ret_from_fork+0x10/0x30


Fixes: 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
---

Changelog v1 -> v2:
* https://lore.kernel.org/lkml/20201217130617.32202-1-lecopzer.chen@mediatek.com/
* Move solution from kernel/watchdog_hld.c to arm64 perf_event
    * avoid preemptive kmalloc in preempt_disable().



 arch/arm64/kernel/perf_event.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 38bb07eff872..c03e21210bbb 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1345,4 +1345,20 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 
 	return (u64)max_cpu_freq * watchdog_thresh;
 }
+
+/*
+ * hardlockup_detector_perf_init() always call in init stage with a single
+ * cpu. In arm64 case, we re-initialize lockup detector after pmu driver
+ * initialized. Lockup detector initial function use lots of percpu variables
+ * and this makes CONFIG_DEBUG_PREEMPT unhappy because we are now in
+ * preemptive context.
+ * Return 0 if the nmi is ready and register nmi hardlockup detector by
+ * lockup detector reconfiguration.
+ */
+int __init watchdog_nmi_probe(void)
+{
+	if (arm_pmu_irq_is_nmi())
+		return 0;
+	return -ENODEV;
+}
 #endif
-- 
2.25.1

