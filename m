Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B922AA473
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKGKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 05:42:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7154 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgKGKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 05:42:56 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSv3V3ZGsz15SKt;
        Sat,  7 Nov 2020 18:42:46 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 7 Nov 2020
 18:42:42 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS executes the residual commands in the queue again when the ITS wakes up from sleep mode.
Date:   Sat, 7 Nov 2020 10:42:26 +0000
Message-ID: <20201107104226.14282-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do nothing
in its suspend and resuse function.On the other hand,firmware stores
GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
and restores these registers in the resume. As a result, the ITS executes
the residual commands in the queue.

Memory corruption may occur in the following scenarios:

The kernel sends three commands in the following sequence:
1.mapd(deviceA, ITT_addr1, valid:1)
2.mapti(deviceA):ITS write ITT_addr1 memory;
3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);
4.mapd(deviceA, ITT_addr2, valid:1);
5.mapti(deviceA):ITS write ITT_addr2 memory;

To solve this problem,dropping the checks for ITS_FLAGS_SAVE_SUSPEND_STATE.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fec31931e11..06f2c1c252b9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,7 +42,6 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
-#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
@@ -4741,9 +4740,6 @@ static int its_save_disable(void)
 	list_for_each_entry(its, &its_nodes, entry) {
 		void __iomem *base;
 
-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-			continue;
-
 		base = its->base;
 		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
 		err = its_force_quiescent(base);
@@ -4762,9 +4758,6 @@ static int its_save_disable(void)
 		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
 			void __iomem *base;
 
-			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-				continue;
-
 			base = its->base;
 			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
 		}
@@ -4784,9 +4777,6 @@ static void its_restore_enable(void)
 		void __iomem *base;
 		int i;
 
-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-			continue;
-
 		base = its->base;
 
 		/*
@@ -5074,9 +5064,6 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
-	if (GITS_TYPER_HCC(typer))
-		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
-
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
-- 
2.25.0

