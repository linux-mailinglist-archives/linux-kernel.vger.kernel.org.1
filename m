Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10E2FDB30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhATNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:55:36 -0500
Received: from mout.gmx.net ([212.227.15.15]:59849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389895AbhATN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149257;
        bh=SHyn+p6d9tSU0bcfld9T3QsMG6Kshj0bouj+YRflQxg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P331zmNtpup6C0kXjNW5FmI+oBCXedb91RdEpZqfhdBzOoUYF03n0snxnScZ6JMY/
         2MQY7me5Oq27GpOtqvyY+/sYQzH7V5i14H+UqdJHRtc5OfCVwcJFWSj90ADaQMMtWJ
         yl/Ty4eH7hrz8y7+EU3FyUr08FReijV+1qlJYgN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MAwbz-1l931F3S7V-00BIC6; Wed, 20 Jan 2021 14:27:37 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple AIC driver.
Date:   Wed, 20 Jan 2021 14:27:17 +0100
Message-Id: <20210120132717.395873-8-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UzbF93QD7ewtU45SWccubUGzjxleBAEd8cENkEmwy10LMjhlCnd
 DQGo+V/owwH1jTprv0HzwwC3JeJOHcSnQBIxmfgUQ39kzXLLPeruGif+m1AEZfvdNb2zEIh
 nxuipyANKmNwsP4C+wyEBfjE+aJbBpaULJXKnuNjRJLcb2Y7feUNZiojJboECOxdIMtMDqD
 g4Cp71tGcP6AZdOnkKZyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GiAGZBgh9e8=:ApCMlQctfbLVb/ERxyRHEW
 pTnRSo/156O+OQdCC5H2l6dRseBIppf4vBBHFrbSUKkr7CC6VCW4tjhoWKoDKD3kfoqQsJ8iV
 WvTcxv7R/x7RXFTMqtp3dgQ75lC1XLXGdC0ryLFww9u1AwEJjpFPL0PANlPVkynqlzeMIBzJ1
 paOIcMU4c54fOq12uMm7k/CKxTGtYz3Lq+58hFyOgQd4dKZzFgJQOlsZ+V626DG+wpp0VTpIh
 b3gW0xxqAD6stxlOPj6sbTrpmLX6Fl7lm7Z2eTvGQB+0fDemuyRai58Kn1i42fHfrTOsWrA2W
 TzHeaZ/medH9kpubdFUK8UsqU8d84FYj9FvMIAkmneGcMVqA+9l8V4I2qe32Db0bQRgk75z+5
 Q3oiUlaTdjkYXUWNiJzLqtMRHMJYjDwSE8bSppolE7XSjUm6UUsR41FQi7gvOrSuI96/zN1J8
 MM/ZFoBTv0Rmeh6aW6iqda9YCPoes3IjTM+Q8E5OgmpVYR5Ih8Tddb1mOJ2Vcnp8/KD7x3o6q
 RcYa48ddJMuGbtt7Fu8WC5uAHq5suBKilza/h4AB08jdRm28ERY9LniFRz7ZSFnaT3SeHv6th
 ZtCx/d7huArqF0NxsosjM5bDu0VPr38nmLivYRmquZRkQrGSKH4hMJUbyu4kPiS8o69DpBUEq
 kf2+8nNkzgBGGvOXh9eX2KDeMgnx9xJ+SragVDQr5TBHYjIbi5PvcOPxgDi9QuvNivIdo/5Hm
 CLedIj8ZdhYMzwQRwrUEvELgiE/7ogy9MaCdA2k/zCx7TXAMg6YhcDMG4SPkzafF8kRkWiG3Z
 VxYO9l0WwsGnzRu+CcGyv++lOSn7h842+UhVOUAe3ra0f74uFtHGdrdJSutLNSpYYG0Tnnj0V
 H0iLmlghyYmeNM7XUD1FKGGWlUjX/IWuKqNcY7X2Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

This includes IPI support and a workaround for non-working WFI on
Apple processors.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 drivers/irqchip/irq-apple-aic.c | 177 +++++++++++++++++++++++++++++---
 1 file changed, 165 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-a=
ic.c
index c601bc4b501a..ce4e39d56fcf 100644
=2D-- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -17,6 +17,7 @@

 #include <asm/exception.h>
 #include <asm/irq.h>
+#include <asm/smp.h>

 #define REG_ID_REVISION 0x0000
 #define REG_ID_CONFIG 0x0004
@@ -53,12 +54,17 @@
 #define REG_PERCPU(r, c)                                                 =
      \
 	((r) + REG_CPU_REGION - REG_CPU_LOCAL + ((c) << REG_CPU_SHIFT))

+#define NUM_IPI 8
+
 static struct aic_chip_data {
 	void __iomem *base;
 	struct irq_domain *domain;
 	unsigned int num_irqs;
+	bool fast_ipi;
 } aic;

+static DEFINE_PER_CPU(atomic_t, aic_ipi_mask);
+
 static void apple_aic_irq_mask(struct irq_data *d)
 {
 	writel(REG_IRQ_xABLE_MASK(d->hwirq),
@@ -78,18 +84,71 @@ static struct irq_chip apple_aic_irq_chip =3D {
 	.irq_unmask =3D apple_aic_irq_unmask,
 };

-static void apple_aic_fiq_mask(struct irq_data *d)
+static void apple_aic_fiq_ipi_mask(struct irq_data *d)
 {
 }

-static void apple_aic_fiq_unmask(struct irq_data *d)
+static void apple_aic_fiq_ipi_unmask(struct irq_data *d)
 {
 }

 static struct irq_chip apple_aic_irq_chip_fiq =3D {
 	.name =3D "apple_aic_fiq",
-	.irq_mask =3D apple_aic_fiq_mask,
-	.irq_unmask =3D apple_aic_fiq_unmask,
+	.irq_mask =3D apple_aic_fiq_ipi_mask,
+	.irq_unmask =3D apple_aic_fiq_ipi_unmask,
+};
+
+#define SR_APPLE_IPI_LOCAL s3_5_c15_c0_0
+#define SR_APPLE_IPI_REMOTE s3_5_c15_c0_1
+#define SR_APPLE_IPI_STAT s3_5_c15_c1_1
+
+#ifdef CONFIG_SMP
+static void apple_aic_ipi_send_mask(struct irq_data *d,
+				    const struct cpumask *mask)
+{
+	int cpu, lcpu;
+	int irqnr =3D d->hwirq - (aic.num_irqs + 2);
+
+	if (WARN_ON(irqnr < 0 || irqnr >=3D NUM_IPI))
+		return;
+
+	/*
+     * Ensure that stores to Normal memory are visible to the
+     * other CPUs before issuing the IPI.
+     */
+	wmb();
+
+	for_each_cpu (cpu, mask) {
+		smp_mb__before_atomic();
+		atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, cpu));
+		smp_mb__after_atomic();
+		lcpu =3D get_cpu();
+		if (aic.fast_ipi) {
+			if ((lcpu >> 2) =3D=3D (cpu >> 2))
+				write_sysreg(cpu & 3, SR_APPLE_IPI_LOCAL);
+			else
+				write_sysreg((cpu & 3) | ((cpu >> 2) << 16),
+					     SR_APPLE_IPI_REMOTE);
+		} else
+			writel(lcpu =3D=3D cpu ? REG_IPI_FLAG_SELF :
+						   (REG_IPI_FLAG_OTHER << cpu),
+			       aic.base + REG_IPI_SET);
+		put_cpu();
+	}
+
+	/* Force the above writes to be executed */
+	if (aic.fast_ipi)
+		isb();
+}
+#else
+#define apple_aic_ipi_send_mask NULL
+#endif
+
+static struct irq_chip apple_aic_irq_chip_ipi =3D {
+	.name =3D "apple_aic_ipi",
+	.irq_mask =3D apple_aic_fiq_ipi_mask,
+	.irq_unmask =3D apple_aic_fiq_ipi_unmask,
+	.ipi_send_mask =3D apple_aic_ipi_send_mask,
 };

 static int apple_aic_irq_domain_xlate(struct irq_domain *d,
@@ -98,16 +157,27 @@ static int apple_aic_irq_domain_xlate(struct irq_doma=
in *d,
 				      unsigned long *out_hwirq,
 				      unsigned int *out_type)
 {
-	if (intspec[0]) { /* FIQ */
+	switch (intspec[0]) {
+	case 0: /* IRQ */
+		if (intspec[1] >=3D aic.num_irqs)
+			return -EINVAL;
+		if (out_hwirq)
+			*out_hwirq =3D intspec[1];
+		break;
+	case 1: /* FIQ */
 		if (intspec[1] >=3D 2)
 			return -EINVAL;
 		if (out_hwirq)
 			*out_hwirq =3D aic.num_irqs + intspec[1];
-	} else {
-		if (intspec[1] >=3D aic.num_irqs)
+		break;
+	case 2: /* IPI */
+		if (intspec[1] >=3D NUM_IPI)
 			return -EINVAL;
 		if (out_hwirq)
-			*out_hwirq =3D intspec[1];
+			*out_hwirq =3D aic.num_irqs + 2 + intspec[1];
+		break;
+	default:
+		return -EINVAL;
 	}

 	if (out_type)
@@ -118,7 +188,13 @@ static int apple_aic_irq_domain_xlate(struct irq_doma=
in *d,
 static int apple_aic_irq_domain_map(struct irq_domain *d, unsigned int vi=
rq,
 				    irq_hw_number_t hw)
 {
-	if (hw >=3D aic.num_irqs) {
+	if (hw >=3D aic.num_irqs + 2) {
+		irq_set_percpu_devid(virq);
+		irq_domain_set_info(d, virq, hw, &apple_aic_irq_chip_ipi,
+				    d->host_data, handle_percpu_devid_irq, NULL,
+				    NULL);
+		irq_set_status_flags(virq, IRQ_NOAUTOEN);
+	} else if (hw >=3D aic.num_irqs) {
 		irq_set_percpu_devid(virq);
 		irq_domain_set_info(d, virq, hw, &apple_aic_irq_chip_fiq,
 				    d->host_data, handle_percpu_devid_irq, NULL,
@@ -141,8 +217,10 @@ static const struct irq_domain_ops apple_aic_irq_doma=
in_ops =3D {

 static void __exception_irq_entry apple_aic_handle_irq(struct pt_regs *re=
gs)
 {
+	atomic_t *maskptr;
 	uint32_t ack;
-	unsigned done =3D 0;
+	unsigned done =3D 0, irqnr;
+	unsigned long mask;

 	while (1) {
 		ack =3D readl(aic.base + REG_IRQ_ACK);
@@ -154,6 +232,36 @@ static void __exception_irq_entry apple_aic_handle_ir=
q(struct pt_regs *regs)
 			handle_domain_irq(aic.domain,
 					  ack & REG_IRQ_ACK_NUM_MASK, regs);
 			break;
+		case REG_IRQ_ACK_TYPE_IPI:
+#ifdef CONFIG_SMP
+			if (ack =3D=3D REG_IRQ_ACK_IPI_SELF)
+				writel(REG_IPI_FLAG_SELF,
+				       aic.base + REG_IPI_CLEAR);
+			else
+				writel(REG_IPI_FLAG_OTHER,
+				       aic.base + REG_IPI_CLEAR);
+			maskptr =3D get_cpu_ptr(&aic_ipi_mask);
+			smp_mb__before_atomic();
+			mask =3D atomic_xchg(maskptr, 0);
+			smp_mb__after_atomic();
+			put_cpu_ptr(&aic_ipi_mask);
+			for_each_set_bit (irqnr, &mask, NUM_IPI) {
+				handle_domain_irq(aic.domain,
+						  aic.num_irqs + 2 + irqnr,
+						  regs);
+			}
+			if (ack =3D=3D REG_IRQ_ACK_IPI_SELF)
+				writel(REG_IPI_FLAG_SELF,
+				       aic.base +
+					       REG_PERCPU(REG_IPI_ENABLE,
+							  __smp_processor_id()));
+			else
+				writel(REG_IPI_FLAG_OTHER,
+				       aic.base +
+					       REG_PERCPU(REG_IPI_ENABLE,
+							  __smp_processor_id()));
+#endif
+			break;
 		}
 		if (done)
 			break;
@@ -162,6 +270,27 @@ static void __exception_irq_entry apple_aic_handle_ir=
q(struct pt_regs *regs)

 static void __exception_irq_entry apple_aic_handle_fiq(struct pt_regs *re=
gs)
 {
+#ifdef CONFIG_SMP
+	atomic_t *maskptr;
+	unsigned long mask;
+	unsigned irqnr;
+
+	if (aic.fast_ipi) {
+		if (read_sysreg(SR_APPLE_IPI_STAT)) {
+			write_sysreg(1, SR_APPLE_IPI_STAT);
+
+			maskptr =3D get_cpu_ptr(&aic_ipi_mask);
+			smp_mb__before_atomic();
+			mask =3D atomic_xchg(maskptr, 0);
+			smp_mb__after_atomic();
+			put_cpu_ptr(&aic_ipi_mask);
+			for_each_set_bit (irqnr, &mask, NUM_IPI)
+				handle_domain_irq(aic.domain,
+						  aic.num_irqs + 2 + irqnr,
+						  regs);
+		}
+	}
+#endif
 	handle_domain_irq(aic.domain, aic.num_irqs, regs);
 }

@@ -169,6 +298,13 @@ void apple_aic_cpu_prepare(unsigned int cpu)
 {
 	unsigned i;

+	if (aic.fast_ipi)
+		writel(REG_IPI_FLAG_SELF | REG_IPI_FLAG_OTHER,
+		       aic.base + REG_PERCPU(REG_IPI_DISABLE, cpu));
+	else
+		writel(REG_IPI_FLAG_SELF | REG_IPI_FLAG_OTHER,
+		       aic.base + REG_PERCPU(REG_IPI_ENABLE, cpu));
+
 	for (i =3D 0; i < aic.num_irqs; i++)
 		writel(readl(aic.base + REG_IRQ_AFFINITY(i)) | (1u << cpu),
 		       aic.base + REG_IRQ_AFFINITY(i));
@@ -178,6 +314,9 @@ static int __init apple_aic_init(struct device_node *n=
ode,
 				 struct device_node *interrupt_parent)
 {
 	unsigned i;
+#ifdef CONFIG_SMP
+	int base_ipi, ret;
+#endif

 	if (!node)
 		return -ENODEV;
@@ -186,8 +325,11 @@ static int __init apple_aic_init(struct device_node *=
node,
 	if (WARN(!aic.base, "unable to map aic registers\n"))
 		return -EINVAL;

+	aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
+
 	aic.num_irqs =3D readl(aic.base + REG_ID_CONFIG) & 0xFFFF;
-	pr_info("Apple AIC: %d IRQs + 1 FIQ + 1 dummy\n", aic.num_irqs);
+	pr_info("Apple AIC: %d IRQs + 1 FIQ + 1 dummy + %d IPIs%s\n",
+		aic.num_irqs, NUM_IPI, aic.fast_ipi ? " (fast)" : "");

 	for (i =3D 0; i < aic.num_irqs; i++)
 		writel(1, aic.base + REG_IRQ_AFFINITY(i));
@@ -201,10 +343,21 @@ static int __init apple_aic_init(struct device_node =
*node,

 	apple_aic_cpu_prepare(0);

-	aic.domain =3D irq_domain_add_linear(node, aic.num_irqs + 2,
+	aic.domain =3D irq_domain_add_linear(node, aic.num_irqs + 2 + NUM_IPI,
 					   &apple_aic_irq_domain_ops,
 					   &apple_aic_irq_chip);
 	irq_set_default_host(aic.domain);
+
+#ifdef CONFIG_SMP
+	base_ipi =3D aic.num_irqs + 2;
+	ret =3D irq_create_strict_mappings(aic.domain, base_ipi, aic.num_irqs + =
2,
+					 NUM_IPI);
+	if (ret < 0)
+		pr_err("%s: irq_create_strict_mappings failed with %d\n",
+		       __func__, ret);
+	set_smp_ipi_range(base_ipi, NUM_IPI);
+#endif
+
 	return 0;
 }

=2D-
2.29.2

