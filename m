Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220D12A5F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKDISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:18:13 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48]:61746 "EHLO
        esa2.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727883AbgKDISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:18:10 -0500
IronPort-SDR: 6tZ2EBqaTGPcQzuDlC2bKIvCEc3vflVNvQH7tQsm7ceS490mZSyYM8031XvDdIFBo4y4JR/kxO
 AHvbbpIHY7SmbuQE4oytCYS5RZ6YauGx1AKv9uZI00+9ALdG7fGSp2lLHqcJJ+FziOgptKfAik
 TKfPj1qI2iDUnVNdOl8jgzTzBuZYbuxNWAelsHJVl4srwTpMpLcJk47nHD34r/BwG8LTd0xkS0
 RHY0GEsIMcRJG5aox0W7I44DL7n7ins3BXXGLXHN0VnNL0SryXlCCGXCepFGygE/X1ozzuKqdd
 uWs=
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="2259510"
X-IronPort-AV: E=Sophos;i="5.77,450,1596466800"; 
   d="scan'208";a="2259510"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2020 17:10:41 +0900
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.87.38])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A1216A86FF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:40 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9EF4EAC00C7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:39 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id 30A24B99B; Wed,  4 Nov 2020 17:08:01 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Wed,  4 Nov 2020 17:05:37 +0900
Message-Id: <20201104080539.3205889-2-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
References: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: From: Sumit Garg <sumit.garg@linaro.org>

Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0..7010ae2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -461,6 +461,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (!gic_supports_nmi())
 		return -EINVAL;
@@ -478,16 +479,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Setting up PPI as NMI, only switch handler for first NMI */
 		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
 			refcount_set(&ppi_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_nmi;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
@@ -498,6 +505,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 static void gic_irq_nmi_teardown(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (WARN_ON(!gic_supports_nmi()))
 		return;
@@ -515,14 +523,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Tearing down NMI, only switch handler for last NMI */
 		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_irq;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
@@ -1708,6 +1722,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1719,8 +1734,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
1.8.3.1

