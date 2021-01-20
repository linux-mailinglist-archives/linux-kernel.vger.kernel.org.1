Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A62FD21E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbhATN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:56:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:43091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389863AbhATN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149255;
        bh=e735jdFF/EQxbrqotnq5F3C+RhmC9hde1v6KePhoop8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BIiMCr9g0tE4RatQ9OVgxFyZjF2v4CShiQGzn5hf1/O7hHApktgTma+FsDfI8mHyE
         /III9aoLOim/Nlw0DAPiXUTl9lNROQvOoE59pQqnlu7GSW8BLQA5NMFnwFE31ACWvQ
         z25Sv0MFw6+o0S+hLRUurdFabJ76AU/2HURFaU+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mlf0K-1lkrg42yJe-00iiCT; Wed, 20 Jan 2021 14:27:35 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
Date:   Wed, 20 Jan 2021 14:27:14 +0100
Message-Id: <20210120132717.395873-5-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dAt+3Oju6AyOpYCx1KbF9d6xREgN4bW/RaqtDY8KJWHcp+dlB1I
 ajevjfRxVfKyNuBUU9w8vBbRJKqa6zQAQvm05s/3T5b3YMiioxFh3XuOGqfVys/Fbyts17X
 i2h39hUteozN29mqxglUSd8fvm45OEPvYc3ihvYP0KM8oItea9wd1Rt9emhzEYVKd+ev2j8
 +Z4mM3UE5CCot15Ief3Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FjygVFYyas=:4G9dSXtr669HxTIUSxu8QL
 6GYhxk5tDxK9pGbdhFa7Qdr4Txb/FeBkHwBvWNYWmnyGGAIoYJ3wJkalmjIjjHhQVV9+piqel
 kOyEdLx8G9a7nYMw2VdHm6fsWTybxgg3TYdLBBaXkPOLzx8hgZ3e+1V4ZPwSqenOpbL9LdyR/
 3hfl3o88v09QbqQCyrmsSvyrp6+BGemex8HH5+lpayp+iBBz3vtZjPit+nybrEDdUr8AUOPnt
 AMrxwffUMeiHH7Q/wEtWonbpKqlORCucG3synf/oTUsMgFaFbFM1KPDUbkjPA7lSJtvykvbIf
 M7ZoRZgk2AhZlCSUmajEqXm10Ws/QiHO7gsBvUtEhReYr/e6aN9n0HiaEKpEsjT/9C/M7kAIO
 hl8IvsofZdJSB/EWrj8OT7X69/ibhT1HSSroZdbdPXutVjtsYCRSrHTMgBoQbKqQd4Gj6ixZk
 5oJpHhRgO2ntpuXXiK8TBqzkrpDXrWbLW9vOXIePz0KbtHWwP0yToEW/EDUZlYIuQ9+sEg1OX
 8PByJ2smup/plK2OWt4gq35DKbz4WPGrAJmTmAI2U0uA1cgFwacMeppD5Y95GjbB1TXuEQd+r
 Kk7Zx6OscT7J2GZN+6zpAiW2RUPeOFXSR3abV1A6vX2atfvOhPNboHWybG3pqjnLu3h6OAZFj
 nOBwxF3fMSEwZDsWMdGzvCpuNqz2r63qU/WxzYMo8vFPOHRG1ZY1mIAS2zMymQ/cH2HTN40B3
 rP3atbxSv4QSbLNDcgKE0TGKRxnAtEWzB/muQQceLBRZXq+VDt5WyShJzAWGtoOSP7yh1gYgD
 NaSZ+WZiUwjNZh43TT34yWEIVSHE8Uz+1QDP9v9iJyy/IpXu3pWHRlYCBsbC+8FQkEDZco+dI
 ZDTYyDN1bwGL3m6/TH4G6awopB4VjJmjZk6bKlhSY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

Apple SoCs use the Apple AIC interrupt controller.
The Arm architectural timers is wired over FIQ on that hardware.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 .../interrupt-controller/apple,aic.yaml       |  49 ++++
 MAINTAINERS                                   |   6 +
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-apple-aic.c               | 211 ++++++++++++++++++
 5 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller=
/apple,aic.yaml
 create mode 100644 drivers/irqchip/irq-apple-aic.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,=
aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,ai=
c.yaml
new file mode 100644
index 000000000000..e615eaaca869
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yam=
l
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apple,aic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Advanced Interrupt Controller (AIC)
+
+description:
+  Interrupt controller present on Apple processors. AIC
+  is used by Apple on their AArch64 SoCs since the Apple A7.
+
+maintainers:
+  - Stan Skowronek <stan@corellium.com>
+
+properties:
+  compatible:
+    items:
+      - const: apple,aic
+
+  reg:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 3
+
+  interrupt-controller: true
+
+  fast-ipi:
+    description:
+      Fast IPI support.
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+        aic: interrupt-controller@23b100000 {
+             compatible =3D "apple,aic";
+             #interrupt-cells =3D <3>;
+             interrupt-controller;
+             reg =3D <0x2 0x3b100000 0x0 0x8000>;
+             fast-ipi;
+         };
diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..e609ede99dd4 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1218,6 +1218,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/jj/linux-apparmor
 F:	Documentation/admin-guide/LSM/apparmor.rst
 F:	security/apparmor/

+APPLE ADVANCED INTERRUPT CONTROLLER DRIVER
+M:	Stan Skowronek <stan@corellium.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/irqchip/irq-apple-aic.c
+
 APPLE BCM5974 MULTITOUCH DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 94920a51c628..3aa9e711324b 100644
=2D-- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -56,6 +56,12 @@ config ARM_GIC_V3_ITS_FSL_MC
 	depends on FSL_MC_BUS
 	default ARM_GIC_V3_ITS

+config APPLE_AIC
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..2f5a9a0cf40f 100644
=2D-- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-m=
bi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-platfo=
rm-msi.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+=3D irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
+obj-$(CONFIG_APPLE_AIC)			+=3D irq-apple-aic.o
 obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+=3D irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+=3D irq-nvic.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-a=
ic.c
new file mode 100644
index 000000000000..c601bc4b501a
=2D-- /dev/null
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple chip interrupt controller
+ *
+ * Copyright (C) 2020 Corellium LLC
+ * Copyright (C) 1992, 1998 Linus Torvalds, Ingo Molnar
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/exception.h>
+#include <asm/irq.h>
+
+#define REG_ID_REVISION 0x0000
+#define REG_ID_CONFIG 0x0004
+#define REG_GLOBAL_CFG 0x0010
+#define REG_TIME_LO 0x0020
+#define REG_TIME_HI 0x0028
+#define REG_ID_CPUID 0x2000
+#define REG_IRQ_ACK 0x2004
+#define REG_IRQ_ACK_TYPE_MASK (15 << 16)
+#define REG_IRQ_ACK_TYPE_NONE (0 << 16)
+#define REG_IRQ_ACK_TYPE_IRQ (1 << 16)
+#define REG_IRQ_ACK_TYPE_IPI (4 << 16)
+#define REG_IRQ_ACK_IPI_OTHER 0x40001
+#define REG_IRQ_ACK_IPI_SELF 0x40002
+#define REG_IRQ_ACK_NUM_MASK (4095)
+#define REG_IPI_SET 0x2008
+#define REG_IPI_FLAG_SELF (1 << 31)
+#define REG_IPI_FLAG_OTHER (1 << 0)
+#define REG_IPI_CLEAR 0x200C
+#define REG_IPI_DISABLE 0x2024
+#define REG_IPI_ENABLE 0x2028
+#define REG_IPI_DEFER_SET 0x202C
+#define REG_IPI_DEFER_CLEAR 0x2030
+#define REG_TSTAMP_CTRL 0x2040
+#define REG_TSTAMP_LO 0x2048
+#define REG_TSTAMP_HI 0x204C
+#define REG_IRQ_AFFINITY(i) (0x3000 + ((i) << 2))
+#define REG_IRQ_DISABLE(i) (0x4100 + (((i) >> 5) << 2))
+#define REG_IRQ_xABLE_MASK(i) (1 << ((i)&31))
+#define REG_IRQ_ENABLE(i) (0x4180 + (((i) >> 5) << 2))
+#define REG_CPU_REGION 0x5000
+#define REG_CPU_LOCAL 0x2000
+#define REG_CPU_SHIFT 7
+#define REG_PERCPU(r, c)                                                 =
      \
+	((r) + REG_CPU_REGION - REG_CPU_LOCAL + ((c) << REG_CPU_SHIFT))
+
+static struct aic_chip_data {
+	void __iomem *base;
+	struct irq_domain *domain;
+	unsigned int num_irqs;
+} aic;
+
+static void apple_aic_irq_mask(struct irq_data *d)
+{
+	writel(REG_IRQ_xABLE_MASK(d->hwirq),
+	       aic.base + REG_IRQ_DISABLE(d->hwirq));
+}
+
+static void apple_aic_irq_unmask(struct irq_data *d)
+{
+	writel(REG_IRQ_xABLE_MASK(d->hwirq),
+	       aic.base + REG_IRQ_ENABLE(d->hwirq));
+}
+
+static struct irq_chip apple_aic_irq_chip =3D {
+	.name =3D "apple_aic",
+	.irq_mask =3D apple_aic_irq_mask,
+	.irq_mask_ack =3D apple_aic_irq_mask,
+	.irq_unmask =3D apple_aic_irq_unmask,
+};
+
+static void apple_aic_fiq_mask(struct irq_data *d)
+{
+}
+
+static void apple_aic_fiq_unmask(struct irq_data *d)
+{
+}
+
+static struct irq_chip apple_aic_irq_chip_fiq =3D {
+	.name =3D "apple_aic_fiq",
+	.irq_mask =3D apple_aic_fiq_mask,
+	.irq_unmask =3D apple_aic_fiq_unmask,
+};
+
+static int apple_aic_irq_domain_xlate(struct irq_domain *d,
+				      struct device_node *ctrlr,
+				      const u32 *intspec, unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{
+	if (intspec[0]) { /* FIQ */
+		if (intspec[1] >=3D 2)
+			return -EINVAL;
+		if (out_hwirq)
+			*out_hwirq =3D aic.num_irqs + intspec[1];
+	} else {
+		if (intspec[1] >=3D aic.num_irqs)
+			return -EINVAL;
+		if (out_hwirq)
+			*out_hwirq =3D intspec[1];
+	}
+
+	if (out_type)
+		*out_type =3D intspec[2] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+
+static int apple_aic_irq_domain_map(struct irq_domain *d, unsigned int vi=
rq,
+				    irq_hw_number_t hw)
+{
+	if (hw >=3D aic.num_irqs) {
+		irq_set_percpu_devid(virq);
+		irq_domain_set_info(d, virq, hw, &apple_aic_irq_chip_fiq,
+				    d->host_data, handle_percpu_devid_irq, NULL,
+				    NULL);
+		irq_set_status_flags(virq, IRQ_NOAUTOEN);
+	} else {
+		irq_domain_set_info(d, virq, hw, &apple_aic_irq_chip,
+				    d->host_data, handle_level_irq, NULL, NULL);
+		irq_set_probe(virq);
+		irqd_set_single_target(
+			irq_desc_get_irq_data(irq_to_desc(virq)));
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops apple_aic_irq_domain_ops =3D {
+	.xlate =3D apple_aic_irq_domain_xlate,
+	.map =3D apple_aic_irq_domain_map,
+};
+
+static void __exception_irq_entry apple_aic_handle_irq(struct pt_regs *re=
gs)
+{
+	uint32_t ack;
+	unsigned done =3D 0;
+
+	while (1) {
+		ack =3D readl(aic.base + REG_IRQ_ACK);
+		switch (ack & REG_IRQ_ACK_TYPE_MASK) {
+		case REG_IRQ_ACK_TYPE_NONE:
+			done =3D 1;
+			break;
+		case REG_IRQ_ACK_TYPE_IRQ:
+			handle_domain_irq(aic.domain,
+					  ack & REG_IRQ_ACK_NUM_MASK, regs);
+			break;
+		}
+		if (done)
+			break;
+	}
+}
+
+static void __exception_irq_entry apple_aic_handle_fiq(struct pt_regs *re=
gs)
+{
+	handle_domain_irq(aic.domain, aic.num_irqs, regs);
+}
+
+void apple_aic_cpu_prepare(unsigned int cpu)
+{
+	unsigned i;
+
+	for (i =3D 0; i < aic.num_irqs; i++)
+		writel(readl(aic.base + REG_IRQ_AFFINITY(i)) | (1u << cpu),
+		       aic.base + REG_IRQ_AFFINITY(i));
+}
+
+static int __init apple_aic_init(struct device_node *node,
+				 struct device_node *interrupt_parent)
+{
+	unsigned i;
+
+	if (!node)
+		return -ENODEV;
+
+	aic.base =3D of_iomap(node, 0);
+	if (WARN(!aic.base, "unable to map aic registers\n"))
+		return -EINVAL;
+
+	aic.num_irqs =3D readl(aic.base + REG_ID_CONFIG) & 0xFFFF;
+	pr_info("Apple AIC: %d IRQs + 1 FIQ + 1 dummy\n", aic.num_irqs);
+
+	for (i =3D 0; i < aic.num_irqs; i++)
+		writel(1, aic.base + REG_IRQ_AFFINITY(i));
+	for (i =3D 0; i < aic.num_irqs; i +=3D 32)
+		writel(-1u, aic.base + REG_IRQ_DISABLE(i));
+	writel((readl(aic.base + REG_GLOBAL_CFG) & ~0xF00000) | 0x700000,
+	       aic.base + REG_GLOBAL_CFG);
+
+	set_handle_irq(apple_aic_handle_irq);
+	set_handle_fiq(apple_aic_handle_fiq);
+
+	apple_aic_cpu_prepare(0);
+
+	aic.domain =3D irq_domain_add_linear(node, aic.num_irqs + 2,
+					   &apple_aic_irq_domain_ops,
+					   &apple_aic_irq_chip);
+	irq_set_default_host(aic.domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(apple_aic_irq_chip, "apple,aic", apple_aic_init);
=2D-
2.29.2

