Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA022DD1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgLQNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:07:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52180 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728103AbgLQNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:07:22 -0500
X-UUID: f6d17a4188d240178986101ccd917f1b-20201217
X-UUID: f6d17a4188d240178986101ccd917f1b-20201217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1322829987; Thu, 17 Dec 2020 21:06:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Dec 2020 21:06:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 21:06:33 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <matthias.bgg@gmail.com>, <will@kernel.org>,
        <alexandru.elisei@arm.com>, <sumit.garg@linaro.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] kernel/watchdog_hld.c: Fix access percpu in preemptible context
Date:   Thu, 17 Dec 2020 21:06:17 +0800
Message-ID: <20201217130617.32202-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
reinitilizes lockup detector after arm64 PMU is initialized and provide
another chance for access smp_processor_id() in preemptible context.
Since hardlockup_detector_event_create() use many percpu relative variable,
just try to fix this by get/put_cpu()

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
Cc: Sumit Garg <sumit.garg@linaro.org>

---
 kernel/watchdog_hld.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..c591a1ea8eb3 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -165,7 +165,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 static int hardlockup_detector_event_create(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu = get_cpu();
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
@@ -176,11 +176,13 @@ static int hardlockup_detector_event_create(void)
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
 	if (IS_ERR(evt)) {
+		put_cpu();
 		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
 			 PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
 	this_cpu_write(watchdog_ev, evt);
+	put_cpu();
 	return 0;
 }
 
-- 
2.25.1

