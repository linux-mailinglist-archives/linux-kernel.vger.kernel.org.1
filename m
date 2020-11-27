Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D32C67A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgK0OPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:15:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44472 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729169AbgK0OPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:15:51 -0500
X-UUID: 5cceb1ee8fed4dd48b869f1a3a764a26-20201127
X-UUID: 5cceb1ee8fed4dd48b869f1a3a764a26-20201127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1388375523; Fri, 27 Nov 2020 22:15:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Nov 2020 22:15:32 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 22:15:33 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH v1 3/3] arm64: disable irq on cpu shutdown flow
Date:   Fri, 27 Nov 2020 22:15:31 +0800
Message-ID: <1606486531-25719-4-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable irq on cpu shutdown flow to ensure interrupts
did not bother this cpu after status as offline.

To avoid suspicious RCU usage
(0)[0:swapper/0]RCU used illegally from offline CPU! ...
(0)[0:swapper/0]lockdep: [name:lockdep&]cpu_id = 0, cpu_is_offline = 1

Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
---
 arch/arm64/kernel/smp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc2c903..27a6553fa86f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -308,6 +308,12 @@ int __cpu_disable(void)
 	remove_cpu_topology(cpu);
 	numa_remove_cpu(cpu);
 
+	/*
+	 * we disable irq here to ensure interrupts
+	 * did not bother this cpu after status as offline.
+	 */
+	local_irq_disable();
+
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
 	 * and we must not schedule until we're ready to give up the cpu.
@@ -842,9 +848,10 @@ void arch_irq_work_raise(void)
 
 static void local_cpu_stop(void)
 {
+	local_daif_mask();
+
 	set_cpu_online(smp_processor_id(), false);
 
-	local_daif_mask();
 	sdei_mask_local_cpu();
 	cpu_park_loop();
 }
-- 
2.18.0

