Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46405276804
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIXEzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:55:12 -0400
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168]:51380 "EHLO
        mgwkm01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXEzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:55:11 -0400
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 00:55:11 EDT
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm01.jp.fujitsu.com with smtp
         id 6f2d_0806_3f5c20b7_63a3_4f28_b816_5bd9df69c61f;
        Thu, 24 Sep 2020 13:43:44 +0900
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 01A76AC008D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:43:44 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id 5C1B31C014; Thu, 24 Sep 2020 13:42:45 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Thu, 24 Sep 2020 13:42:35 +0900
Message-Id: <20200924044236.1245808-2-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 262bc7377abd..2eda18d1df59 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -477,6 +477,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return -EINVAL;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_NMI_PRI);
+		return 0;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
+		return;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -1708,6 +1718,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1719,8 +1730,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.25.1

