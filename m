Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB702AF3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgKKOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgKKOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:43:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544B1C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pihy8w0cdJgix7gJtuDkn8UjH+2HJwBYv3JzpeGtOT8=; b=btPbFu7XbcUqrmYHeUhLJuSYa9
        5n/AQxWQJSMqVoKHOW4jY5JHyT/Pd6+WTN324KqOwXVA6Kqxrf1/AD438Vcb5T40LX7F4i8+GUljX
        9pKNQ4fYg070PqhhwQ3xoGXkIb3nhXpbvTdct6RM6tLDuoLS3EQcSr5qJaLKbaPRQdd+PU4Cd8ua2
        sbIqZK3XKCNmQBAwPZYKuv+zMKeX5EPy2aFKwuan1jyfL6FKHzlg9lNQ4I/mU+IfoI6kX2s9RQNeY
        /P5/amQ8Ujr5fqv6qcQlKC7pEiNMYmlTNeu/vv/ckWMqySn1uOOs8NNB/tPA5gOAWiKMa1w+W02IG
        58F9uH5A==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcrLH-0002j2-8f; Wed, 11 Nov 2020 14:43:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kcrLG-006xqV-JF; Wed, 11 Nov 2020 14:43:22 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] iommu/amd: Fix IOMMU interrupt generation in X2APIC mode
Date:   Wed, 11 Nov 2020 14:43:22 +0000
Message-Id: <20201111144322.1659970-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111144322.1659970-1-dwmw2@infradead.org>
References: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
 <20201111144322.1659970-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

The AMD IOMMU has two modes for generating its own interrupts.

The first is very much based on PCI MSI, and can be configured by Linux
precisely that way. But like legacy unmapped PCI MSI it's limited to
8 bits of APIC ID.

The second method does not use PCI MSI at all in hardawre, and instead
configures the INTCAPXT registers in the IOMMU directly with the APIC ID
and vector.

In the latter case, the IOMMU driver would still use pci_enable_msi(),
read back (through MMIO) the MSI message that Linux wrote to the PCI MSI
table, then swizzle those bits into the appropriate register.

Historically, this worked because__irq_compose_msi_msg() would silently
generate an invalid MSI message with the high bits of the APIC ID in the
high bits of the MSI address. That hack was intended only for the Intel
IOMMU, and I recently enforced that, introducing a warning in
__irq_msi_compose_msg() if it was invoked with an APIC ID above 255.

Fix the AMD IOMMU not to depend on that hack any more, by having its own
irqdomain and directly putting the bits from the irq_cfg into the right
place in its ->activate() method.

Fixes: 47bea873cf80 "x86/msi: Only use high bits of MSI address for DMAR unit")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/hw_irq.h |   1 +
 drivers/iommu/amd/init.c      | 190 +++++++++++++++++++++++-----------
 2 files changed, 132 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 458f5a676402..d465ece58151 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -39,6 +39,7 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSI,
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
+	X86_IRQ_ALLOC_TYPE_AMDVI,
 	X86_IRQ_ALLOC_TYPE_UV,
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a94b96f1e13a..a57400a73abb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -16,6 +16,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
+#include <linux/irq.h>
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
@@ -1557,14 +1558,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			break;
 		}
 
-		/*
-		 * Note: Since iommu_update_intcapxt() leverages
-		 * the IOMMU MMIO access to MSI capability block registers
-		 * for MSI address lo/hi/data, we need to check both
-		 * EFR[XtSup] and EFR[MsiCapMmioSup] for x2APIC support.
-		 */
-		if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
-		    (h->efr_reg & BIT(IOMMU_EFR_MSICAPMMIOSUP_SHIFT)))
+		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		break;
 	default:
@@ -1981,27 +1975,32 @@ union intcapxt {
 } __attribute__ ((packed));
 
 /*
- * Setup the IntCapXT registers with interrupt routing information
- * based on the PCI MSI capability block registers, accessed via
- * MMIO MSI address low/hi and MSI data registers.
+ * There isn't really any need to mask/unmask at the irqchip level because
+ * the 64-bit INTCAPXT registers can be updated atomically without tearing
+ * when the affinity is being updated.
  */
-static void iommu_update_intcapxt(struct amd_iommu *iommu)
+static void intcapxt_unmask_irq(struct irq_data *data)
 {
-	struct msi_msg msg;
-	union intcapxt xt;
-	u32 destid;
+}
 
-	msg.address_lo = readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
-	msg.address_hi = readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
-	msg.data = readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
+static void intcapxt_mask_irq(struct irq_data *data)
+{
+}
 
-	destid = x86_msi_msg_get_destid(&msg, x2apic_enabled());
+static struct irq_chip intcapxt_controller;
+
+static int intcapxt_irqdomain_activate(struct irq_domain *domain,
+				       struct irq_data *irqd, bool reserve)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+	struct irq_cfg *cfg = irqd_cfg(irqd);
+	union intcapxt xt;
 
 	xt.capxt = 0ULL;
-	xt.dest_mode_logical = msg.arch_data.dest_mode_logical;
-	xt.vector = msg.arch_data.vector;
-	xt.destid_0_23 = destid & GENMASK(23, 0);
-	xt.destid_24_31 = destid >> 24;
+	xt.dest_mode_logical = apic->dest_mode_logical;
+	xt.vector = cfg->vector;
+	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
+	xt.destid_24_31 = cfg->dest_apicid >> 24;
 
 	/**
 	 * Current IOMMU implemtation uses the same IRQ for all
@@ -2010,64 +2009,141 @@ static void iommu_update_intcapxt(struct amd_iommu *iommu)
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	return 0;
 }
 
-static void _irq_notifier_notify(struct irq_affinity_notify *notify,
-				 const cpumask_t *mask)
+static void intcapxt_irqdomain_deactivate(struct irq_domain *domain,
+					  struct irq_data *irqd)
 {
-	struct amd_iommu *iommu;
+	intcapxt_mask_irq(irqd);
+}
 
-	for_each_iommu(iommu) {
-		if (iommu->dev->irq == notify->irq) {
-			iommu_update_intcapxt(iommu);
-			break;
-		}
+
+static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs, void *arg)
+{
+	struct irq_alloc_info *info = arg;
+	int i, ret;
+
+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_AMDVI)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	for (i = virq; i < virq + nr_irqs; i++) {
+		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
+
+		irqd->chip = &intcapxt_controller;
+		irqd->chip_data = info->data;
 	}
+
+	return ret;
 }
 
-static void _irq_notifier_release(struct kref *ref)
+static void intcapxt_irqdomain_free(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
 {
+	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
-static int iommu_init_intcapxt(struct amd_iommu *iommu)
+static int intcapxt_set_affinity(struct irq_data *irqd,
+				 const struct cpumask *mask, bool force)
 {
+	struct irq_data *parent = irqd->parent_data;
 	int ret;
-	struct irq_affinity_notify *notify = &iommu->intcapxt_notify;
 
-	/**
-	 * IntCapXT requires XTSup=1 and MsiCapMmioSup=1,
-	 * which can be inferred from amd_iommu_xt_mode.
-	 */
-	if (amd_iommu_xt_mode != IRQ_REMAP_X2APIC_MODE)
-		return 0;
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
 
-	/**
-	 * Also, we need to setup notifier to update the IntCapXT registers
-	 * whenever the irq affinity is changed from user-space.
-	 */
-	notify->irq = iommu->dev->irq;
-	notify->notify = _irq_notifier_notify,
-	notify->release = _irq_notifier_release,
-	ret = irq_set_affinity_notifier(iommu->dev->irq, notify);
+	return intcapxt_irqdomain_activate(irqd->domain, irqd, false);
+}
+
+static struct irq_chip intcapxt_controller = {
+	.name			= "IOMMU-MSI",
+	.irq_unmask		= intcapxt_unmask_irq,
+	.irq_mask		= intcapxt_mask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity       = intcapxt_set_affinity,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static const struct irq_domain_ops intcapxt_domain_ops = {
+	.alloc			= intcapxt_irqdomain_alloc,
+	.free			= intcapxt_irqdomain_free,
+	.activate		= intcapxt_irqdomain_activate,
+	.deactivate		= intcapxt_irqdomain_deactivate,
+};
+
+
+static struct irq_domain *iommu_irqdomain;
+
+static struct irq_domain *iommu_get_irqdomain(void)
+{
+	struct fwnode_handle *fn;
+
+	/* No need for locking here (yet) as the init is single-threaded */
+	if (iommu_irqdomain)
+		return iommu_irqdomain;
+
+	fn = irq_domain_alloc_named_fwnode("AMD-Vi-MSI");
+	if (!fn)
+		return NULL;
+
+	iommu_irqdomain = irq_domain_create_hierarchy(x86_vector_domain, 0, 0,
+						      fn, &intcapxt_domain_ops,
+						      NULL);
+	if (!iommu_irqdomain)
+		irq_domain_free_fwnode(fn);
+
+	return iommu_irqdomain;
+}
+
+static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+{
+	struct irq_domain *domain;
+	struct irq_alloc_info info;
+	int irq, ret;
+
+	domain = iommu_get_irqdomain();
+	if (!domain)
+		return -ENXIO;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
+	info.data = iommu;
+
+	irq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+	if (irq < 0) {
+		irq_domain_remove(domain);
+		return irq;
+	}
+
+	ret = request_threaded_irq(irq, amd_iommu_int_handler,
+				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
 	if (ret) {
-		pr_err("Failed to register irq affinity notifier (devid=%#x, irq %d)\n",
-		       iommu->devid, iommu->dev->irq);
+		irq_domain_free_irqs(irq, 1);
+		irq_domain_remove(domain);
 		return ret;
 	}
 
-	iommu_update_intcapxt(iommu);
 	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
-	return ret;
+	return 0;
 }
 
-static int iommu_init_msi(struct amd_iommu *iommu)
+static int iommu_init_irq(struct amd_iommu *iommu)
 {
 	int ret;
 
 	if (iommu->int_enabled)
 		goto enable_faults;
 
-	if (iommu->dev->msi_cap)
+	if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+		ret = iommu_setup_intcapxt(iommu);
+	else if (iommu->dev->msi_cap)
 		ret = iommu_setup_msi(iommu);
 	else
 		ret = -ENODEV;
@@ -2076,10 +2152,6 @@ static int iommu_init_msi(struct amd_iommu *iommu)
 		return ret;
 
 enable_faults:
-	ret = iommu_init_intcapxt(iommu);
-	if (ret)
-		return ret;
-
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
 
 	if (iommu->ppr_log != NULL)
@@ -2702,7 +2774,7 @@ static int amd_iommu_enable_interrupts(void)
 	int ret = 0;
 
 	for_each_iommu(iommu) {
-		ret = iommu_init_msi(iommu);
+		ret = iommu_init_irq(iommu);
 		if (ret)
 			goto out;
 	}
-- 
2.26.2

