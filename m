Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797E32ADEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgKJS4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgKJS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:56:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:56:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605034582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Fs+hjsBc7Jwnmz1UBfxUAkpy4yQiVvI/+W8vU/Acgw=;
        b=K6gTXqJF1s68l8lf4dXCdU7SeYmb0/zzGTfoa+lGjgMnV7BqIp3yw84TTSKQgdd26CYN+U
        E/eo2kllTkJDdVqbrUgG0ZNjnkXPIf4kJ8mDhwP6egDEofzlR46B2lSgRKHmjKEbgXttHj
        OK1wwI/e6nf1I4CeJORSLbK/hiUOO/kD3C9Om/zCjLLflnD5/IPpb+SbkJop1Fbdjv8WL3
        b5/AhLrnL2pBCn6tC5KPY5TnYEHsp7XLlsxTfNb8+la+Yp3dC/MeBiu17g7kbjyRDPB2Eu
        4s34rOOQHTx9t2GSq5xgKaeQzWmXZeH7Tz/myLl+Gwpl0AndypoyURMEXA5z1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605034582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Fs+hjsBc7Jwnmz1UBfxUAkpy4yQiVvI/+W8vU/Acgw=;
        b=z6d0qerviQ3c1zB0rPxU9TzfUbWGsUMVC4UKkkjqPy0nVQlqa6PJdKjfvCZhllh2ryvXs4
        9U7UjlaQnCio3rAA==
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <877dqtgkzb.fsf@nanos.tec.linutronix.de>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org> <877dqtgkzb.fsf@nanos.tec.linutronix.de>
Date:   Tue, 10 Nov 2020 19:56:17 +0100
Message-ID: <874klxghwu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 18:50, Thomas Gleixner wrote:
> On Tue, Nov 10 2020 at 16:33, David Woodhouse wrote:
>> If I could get post-5.5 kernels to boot at all with the AMD IOMMU
>> enabled, I'd have a go at throwing that together now...
>
> It can share the dmar domain code. Let me frob something.

Not much to share there and I can't access my AMD machine at the
moment. Something like the untested below should work.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -523,7 +523,7 @@ struct msi_msg;
 struct irq_cfg;
 
 extern void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
-				  bool dmar);
+				  bool iommu);
 
 extern void ioapic_zap_locks(void);
 
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -63,4 +63,6 @@ static inline void x86_create_pci_msi_do
 #define x86_pci_msi_default_domain	NULL
 #endif
 
+struct irq_domain *x86_create_iommu_msi_domain(void);
+
 #endif
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2498,7 +2498,7 @@ int hard_smp_processor_id(void)
 }
 
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
-			   bool dmar)
+			   bool iommu)
 {
 	memset(msg, 0, sizeof(*msg));
 
@@ -2519,7 +2519,7 @@ void __irq_msi_compose_msg(struct irq_cf
 	 * some hypervisors allow the extended destination ID field in bits
 	 * 5-11 to be used, giving support for 15 bits of APIC IDs in total.
 	 */
-	if (dmar)
+	if (iommu)
 		msg->arch_addr_hi.destid_8_31 = cfg->dest_apicid >> 8;
 	else if (virt_ext_dest_id && cfg->dest_apicid < 0x8000)
 		msg->arch_addr_lo.virt_destid_8_14 = cfg->dest_apicid >> 8;
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -184,7 +184,8 @@ static struct msi_domain_info pci_msi_do
 	.handler_name	= "edge",
 };
 
-struct irq_domain * __init native_create_pci_msi_domain(void)
+static struct irq_domain *__init
+__create_pci_msi_domain(struct msi_domain_info *info, const char *name)
 {
 	struct fwnode_handle *fn;
 	struct irq_domain *d;
@@ -192,21 +193,25 @@ struct irq_domain * __init native_create
 	if (disable_apic)
 		return NULL;
 
-	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
+	fn = irq_domain_alloc_named_fwnode(name);
 	if (!fn)
 		return NULL;
 
-	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-				      x86_vector_domain);
+	d = pci_msi_create_irq_domain(fn, info, x86_vector_domain);
 	if (!d) {
 		irq_domain_free_fwnode(fn);
-		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
+		pr_warn("Failed to initialize %s irqdomain.\n", name);
 	} else {
 		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
 	return d;
 }
 
+struct irq_domain * __init native_create_pci_msi_domain(void)
+{
+	return __create_pci_msi_domain(&pci_msi_domain_info, "PCI-MSI");
+}
+
 void __init x86_create_pci_msi_domain(void)
 {
 	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
@@ -247,6 +252,43 @@ struct irq_domain *arch_create_remap_msi
 }
 #endif
 
+static void __maybe_unused iommu_msi_compose_msg(struct irq_data *data,
+						 struct msi_msg *msg)
+{
+	__irq_msi_compose_msg(irqd_cfg(data), msg, true);
+}
+
+#ifdef CONFIG_AMD_IOMMU
+/*
+ * Similar to the Intel IOMMU abuse below. The resulting irq domain is
+ * associated to the IOMMU pci device, so that pci_enable_msi() works.
+ */
+static struct irq_chip iommu_msi_controller = {
+	.name			= "IOMMU-MSI",
+	.irq_unmask		= pci_msi_unmask_irq,
+	.irq_mask		= pci_msi_mask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= msi_set_affinity,
+	.irq_compose_msi_msg	= iommu_msi_compose_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct msi_domain_info iommu_msi_domain_info = {
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+			  MSI_FLAG_PCI_MSIX,
+	.ops		= &pci_msi_domain_ops,
+	.chip		= &iommu_msi_controller,
+	.handler	= handle_edge_irq,
+	.handler_name	= "edge",
+};
+
+struct irq_domain __init *x86_create_iommu_msi_domain(void)
+{
+	return __create_pci_msi_domain(&iommu_msi_domain_info, "IOMMU-MSI");
+}
+#endif
+
 #ifdef CONFIG_DMAR_TABLE
 /*
  * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
@@ -254,11 +296,6 @@ struct irq_domain *arch_create_remap_msi
  * case for MSIs as it would be targeting real memory above 4GiB not the
  * APIC.
  */
-static void dmar_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	__irq_msi_compose_msg(irqd_cfg(data), msg, true);
-}
-
 static void dmar_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	dmar_msi_write(data->irq, msg);
@@ -271,7 +308,7 @@ static struct irq_chip dmar_msi_controll
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= dmar_msi_compose_msg,
+	.irq_compose_msi_msg	= iommu_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1759,6 +1759,7 @@ static const struct attribute_group *amd
 
 static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
+	static struct irq_domain *msidom;
 	int cap_ptr = iommu->cap_ptr;
 	int ret;
 
@@ -1767,6 +1768,13 @@ static int __init iommu_init_pci(struct
 	if (!iommu->dev)
 		return -ENODEV;
 
+	if (!msidom) {
+		msidom = x86_create_iommu_msi_domain();
+		if (!msidom)
+			return -ENODEV;
+	}
+	dev_set_msi_domain(&iommu->dev->dev, msidom);
+
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
