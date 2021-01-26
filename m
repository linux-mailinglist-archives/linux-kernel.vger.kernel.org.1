Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9D303BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405302AbhAZLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:41:19 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56880 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404476AbhAZKwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFE251A0678;
        Tue, 26 Jan 2021 11:51:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0CEB1A0392;
        Tue, 26 Jan 2021 11:51:51 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 36509402A2;
        Tue, 26 Jan 2021 11:51:46 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, jiafei.pan@nxp.com,
        linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to remove call trace
Date:   Tue, 26 Jan 2021 19:00:27 +0800
Message-Id: <20210126110027.39689-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add flag IRQCHIP_SKIP_SET_WAKE to remove call trace as follow,
[   45.605239] Unbalanced IRQ 120 wake disable
[   45.609445] WARNING: CPU: 0 PID: 1124 at kernel/irq/manage.c:800 irq_set_irq_wake+0x154/0x1a0
[   45.617965] Modules linked in: fsl_jr_uio caam_jr caamkeyblob_desc crypto_engine rng_core dpaa2_caam caamhash_desc caamalg_desc crct10dif_ce libdes caam error lm90 ina2xx
[   45.633222] CPU: 0 PID: 1124 Comm: sh Not tainted 5.10.9 #1
[   45.638789] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[   45.645141] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[   45.651144] pc : irq_set_irq_wake+0x154/0x1a0
[   45.655497] lr : irq_set_irq_wake+0x154/0x1a0
[   45.659847] sp : ffff800012a83b00
[   45.663156] x29: ffff800012a83b00 x28: 0000000000000000
[   45.668469] x27: 0000000000000008 x26: ffffa74bd9d22cf0
[   45.673781] x25: 0000000a5a1768a7 x24: ffffa74bda672e6c
[   45.679092] x23: 0000000000000000 x22: ffff62f7f2a08000
[   45.684404] x21: 00000000ffffffea x20: 0000000000000078
[   45.689715] x19: ffff62f7f00b3e00 x18: 0000000000000030
[   45.695026] x17: 0000000000000000 x16: 0000000000000001
[   45.700337] x15: ffff62f7f2a08460 x14: ffffffffffffffff
[   45.705648] x13: ffffa74bda6733f8 x12: 000000000000080d
[   45.710959] x11: 00000000000002af x10: ffffa74bda6cb3f8
[   45.716270] x9 : 00000000fffff000 x8 : ffffa74bda6733f8
[   45.721581] x7 : ffffa74bda6cb3f8 x6 : 0000000000000000
[   45.726892] x5 : 0000000000000000 x4 : 0000000000000000
[   45.732203] x3 : 00000000ffffffff x2 : ffffa74bda673378
[   45.737514] x1 : f27fea81bfee7700 x0 : 0000000000000000
[   45.742825] Call trace:
[   45.745268]  irq_set_irq_wake+0x154/0x1a0
[   45.749278]  ds3232_resume+0x38/0x50
[   45.752853]  dpm_run_callback.constprop.0+0x3c/0xe4
[   45.757727]  device_resume+0x88/0x180
[   45.761385]  dpm_resume+0xe8/0x220
[   45.764782]  dpm_resume_end+0x18/0x30
[   45.768447]  suspend_devices_and_enter+0x1a4/0x5a0
[   45.773235]  pm_suspend+0x2e0/0x34c
[   45.776720]  state_store+0x8c/0x110
[   45.780205]  kobj_attr_store+0x1c/0x30
[   45.783955]  sysfs_kf_write+0x48/0x60
[   45.787613]  kernfs_fop_write+0xfc/0x220
[   45.791539]  vfs_write+0xf0/0x2a4
[   45.794849]  ksys_write+0x6c/0x100
[   45.798248]  __arm64_sys_write+0x20/0x30
[   45.802173]  el0_svc_common.constprop.0+0x78/0x1a0
[   45.806960]  do_el0_svc+0x24/0x90
[   45.810271]  el0_svc+0x14/0x20
[   45.813320]  el0_sync_handler+0x1a4/0x1b0
[   45.817326]  el0_sync+0x174/0x180
[   45.820635] ---[ end trace ae76f63f1f1791a1 ]---

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/irqchip/irq-ls-extirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 564e6de0bd8e..3c6ed7b4744d 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -65,7 +65,7 @@ static struct irq_chip ls_extirq_chip = {
 	.irq_set_type		= ls_extirq_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int
-- 
2.17.1

