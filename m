Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158292FE99D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbhAUMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:07:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11846 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbhAULEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:04:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DLzxG2g2Bz7YPx;
        Thu, 21 Jan 2021 19:02:10 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.88.171) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 21 Jan 2021 19:03:07 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <maz@kernel.org>, <eric.auger@redhat.com>, <tglx@linutronix.de>,
        <linuxarm@openeuler.org>, <prime.zeng@hisilicon.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH] genirq/msi: Make sure early activation of all PCI MSIs
Date:   Thu, 21 Jan 2021 11:02:47 +0000
Message-ID: <20210121110247.20320-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.88.171]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently do early activation of MSI irqs for PCI/MSI based on
the MSI_FLAG_ACTIVATE_EARLY flag. Though this activates all the
allocated MSIs in the case of MSI-X, it only does so for the
base irq in the case of MSI. This is because, for MSI, there
is only one msi_desc entry for all the 32 irqs it can support
and the current implementation iterates over the msi entries and
ends up activating the base irq only.

The above creates an issue on platforms where the msi controller
supports direct injection of vLPIs(eg: ARM GICv4 ITS). On these
platforms, upon irq activation, ITS driver maps the event to an
ITT entry. And for Guest pass-through to work, early mapping of
all the dev MSI vectors is required. Otherwise, the vfio irq
bypass manager registration will fail. eg, On a HiSilicon D06
platform with GICv4 enabled, Guest boot with zip dev pass-through
reports,

"vfio-pci 0000:75:00.1: irq bypass producer (token 0000000006e5176a)
registration fails: 66311"

and Guest boot fails.

This is traced to,
   kvm_arch_irq_bypass_add_producer
     kvm_vgic_v4_set_forwarding
       vgic_its_resolve_lpi --> returns E_ITS_INT_UNMAPPED_INTERRUPT

Hence make sure we activate all the irqs for both MSI and MSI-x cases.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
It is unclear to me whether not performing the early activation of all
MSI irqs was deliberate and has consequences on any other platforms.
Please let me know.

Thanks,
Shameer 
---
 kernel/irq/msi.c | 114 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 24 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2c0c4d6d0f83..eec187fc32a9 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -395,6 +395,78 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
 }
 
+static void msi_domain_deactivate_irq(struct irq_domain *domain, int irq)
+{
+	struct irq_data *irqd;
+
+	irqd = irq_domain_get_irq_data(domain, irq);
+	if (irqd_is_activated(irqd))
+		irq_domain_deactivate_irq(irqd);
+}
+
+static int msi_domain_activate_irq(struct irq_domain *domain,
+				   int irq, bool can_reserve)
+{
+	struct irq_data *irqd;
+
+	irqd = irq_domain_get_irq_data(domain, irq);
+	if (!can_reserve) {
+		irqd_clr_can_reserve(irqd);
+		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+			irqd_set_msi_nomask_quirk(irqd);
+	}
+	return irq_domain_activate_irq(irqd, can_reserve);
+}
+
+static int msi_domain_activate_msix_irqs(struct irq_domain *domain,
+					 struct device *dev, bool can_reserve)
+{
+	struct msi_desc *desc;
+	int ret, irq;
+
+	for_each_msi_entry(desc, dev) {
+		irq = desc->irq;
+		ret = msi_domain_activate_irq(domain, irq, can_reserve);
+		if (ret)
+			goto out;
+	}
+	return 0;
+
+out:
+	for_each_msi_entry(desc, dev) {
+		if (irq == desc->irq)
+			break;
+		msi_domain_deactivate_irq(domain, desc->irq);
+	}
+	return ret;
+}
+
+static int msi_domain_activate_msi_irqs(struct irq_domain *domain,
+					struct device *dev, bool can_reserve)
+{
+	struct msi_desc *desc;
+	int i, ret, base, irq;
+
+	desc = first_msi_entry(dev);
+	base = desc->irq;
+
+	for (i = 0; i < desc->nvec_used; i++) {
+		irq = base + i;
+		ret = msi_domain_activate_irq(domain, irq, can_reserve);
+		if (ret)
+			goto out;
+	}
+	return 0;
+
+out:
+	for (i = 0; i < desc->nvec_used; i++) {
+		if (irq == base + i)
+			break;
+		msi_domain_deactivate_irq(domain, base + i);
+	}
+	return ret;
+}
+
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec)
 {
@@ -443,21 +515,25 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		else
 			dev_dbg(dev, "irq [%d-%d] for MSI\n",
 				virq, virq + desc->nvec_used - 1);
-		/*
-		 * This flag is set by the PCI layer as we need to activate
-		 * the MSI entries before the PCI layer enables MSI in the
-		 * card. Otherwise the card latches a random msi message.
-		 */
-		if (!(info->flags & MSI_FLAG_ACTIVATE_EARLY))
-			continue;
+	}
 
-		irq_data = irq_domain_get_irq_data(domain, desc->irq);
-		if (!can_reserve) {
-			irqd_clr_can_reserve(irq_data);
-			if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
-				irqd_set_msi_nomask_quirk(irq_data);
-		}
-		ret = irq_domain_activate_irq(irq_data, can_reserve);
+	/*
+	 * This flag is set by the PCI layer as we need to activate
+	 * the MSI entries before the PCI layer enables MSI in the
+	 * card. Otherwise the card latches a random msi message.
+	 * Early activation is also required when the msi controller
+	 * supports direct injection of virtual LPIs(eg. ARM GICv4 ITS).
+	 * Otherwise, the DevID/EventID -> LPI translation for pass-through
+	 * devices will fail. Make sure we do activate all the allocated
+	 * irqs for MSI and MSI-X cases.
+	 */
+	if ((info->flags & MSI_FLAG_ACTIVATE_EARLY)) {
+		desc = first_msi_entry(dev);
+
+		if (desc->msi_attrib.is_msix)
+			ret = msi_domain_activate_msix_irqs(domain, dev, can_reserve);
+		else
+			ret = msi_domain_activate_msi_irqs(domain, dev, can_reserve);
 		if (ret)
 			goto cleanup;
 	}
@@ -475,16 +551,6 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 
 cleanup:
-	for_each_msi_entry(desc, dev) {
-		struct irq_data *irqd;
-
-		if (desc->irq == virq)
-			break;
-
-		irqd = irq_domain_get_irq_data(domain, desc->irq);
-		if (irqd_is_activated(irqd))
-			irq_domain_deactivate_irq(irqd);
-	}
 	msi_domain_free_irqs(domain, dev);
 	return ret;
 }
-- 
2.17.1

