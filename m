Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E32AE39B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbgKJWsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:48:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:48:12 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605048489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGDOcaUuccXX4HJHlpwgmk95YzzPlwTmVqFSpCljX28=;
        b=rB+TkqVCsOvjutZGJnjP66ThUL/jCgKi39wAnpriYKBRbXSkcQVb602p9p7rKMhH3MEe92
        gU0gclpZH/ohiaaObuXWg+DM1MtnvlwaUewUVxNhHqVASS8VvV2q8J0MEWNFVrTeTQ3NgF
        YQd5GgyZYa96EAb4FdJ1myrL6nkXCAynf6zRHSm2moYJMOHj5dHTfp4ll19aXB/gsiKhoZ
        bEBtHBYqJDad1P4ic7v4jB4CyRuisGZipnFhSp+7605S/BsbMT+3Nb96tAwl3LB9MmXBHk
        Xd7pkDbilZJYCmIHs+4Gz4RSiWBiQ99IXRM8ty16+WQLH/hql/IePTx0WR/Esw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605048489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGDOcaUuccXX4HJHlpwgmk95YzzPlwTmVqFSpCljX28=;
        b=MT/t6jQtgQLLcJs6gD6ugCxz9OTgBoQ1o0sqd39RRGNpgoWHdXEmIemSZuc0/xFv/hfQE6
        mCGdnfNoCQLWZ9Bg==
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
In-Reply-To: <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org> <877dqtgkzb.fsf@nanos.tec.linutronix.de> <874klxghwu.fsf@nanos.tec.linutronix.de> <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org> <87y2j9exk2.fsf@nanos.tec.linutronix.de> <8C2E184C-D069-4C60-96B5-0758FBC6E402@infradead.org> <d4115cc7-3876-e012-b6ec-c525d608834f@amd.com>
Date:   Tue, 10 Nov 2020 23:48:04 +0100
Message-ID: <87tutwg76j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10 2020 at 16:00, Tom Lendacky wrote:
> On 11/10/20 3:30 PM, David Woodhouse wrote:
> [   15.581115] WARNING: CPU: 6 PID: 1 at arch/x86/kernel/apic/apic.c:2527 __irq_msi_compose_msg+0x9f/0xb0
> [   15.581115] Call Trace:
> [   15.581115]  irq_msi_update_msg+0x4d/0x80
> [   15.581115]  msi_set_affinity+0x160/0x190

Duh. Yes, that want's some love as well. Delta patch below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -24,10 +24,11 @@ struct irq_domain *x86_pci_msi_default_d
 
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
+	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
 	struct msi_msg msg[2] = { [1] = { }, };
 
-	__irq_msi_compose_msg(cfg, msg, false);
-	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
+	__irq_msi_compose_msg(cfg, msg, chip->flags & IRQCHIP_MSI_EXTID);
+	chip->irq_write_msi_msg(irqd, msg);
 }
 
 static int
@@ -271,7 +272,7 @@ static struct irq_chip iommu_msi_control
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= msi_set_affinity,
 	.irq_compose_msi_msg	= iommu_msi_compose_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MSI_EXTID,
 };
 
 static struct msi_domain_info iommu_msi_domain_info = {
@@ -310,7 +311,7 @@ static struct irq_chip dmar_msi_controll
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= iommu_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MSI_EXTID,
 };
 
 static int dmar_msi_init(struct irq_domain *domain,
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -567,6 +567,8 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
+ * IRQCHIP_MSI_EXTID		      The MSI message created for this chip can
+ *				      have an otherwise forbidden extended ID
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -579,6 +581,7 @@ enum {
 	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
+	IRQCHIP_MSI_EXTID			= (1 << 10),
 };
 
 #include <linux/irqdesc.h>
