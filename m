Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3488E2D050F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLFNOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:14:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EACC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 05:13:20 -0800 (PST)
Date:   Sun, 06 Dec 2020 13:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607260398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aB+eK15Hiy9x/n8aU60X2ERiiqgMNHsnMFEg4aS78SA=;
        b=WBVQq5HeL7yeOmcXEySDKSL8JDBmd7pIu6pMd+7eZV4zBRK+aG2Z2ctdZe4cb0Q4etYTpy
        PRoklC0JcgW2Mhs8PQC1iIYK9jauU1Ri6F8yn+8Hy2JYEDvF/luuZMvVShysNULQ8dVGP3
        DM/J6e84UZyPNa/RNjFINTqeNr+9H3IgLS9aS1wOvBBXkaoK23saBtNbmNKmf6a1SAh7Wz
        mBvfXtb4ybXiH00Y6zWknt7gs5DHw0J0ayRNqFhAj4ydxTarkiSKBCfQu13I1WC9USDjA+
        Jm1driSdZ76Xu/pARnctXOEneBc81q+MUVp6UnffTeaXwpuRyVNgZbEEmgxL/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607260398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aB+eK15Hiy9x/n8aU60X2ERiiqgMNHsnMFEg4aS78SA=;
        b=vXoe/k/TGkk4UVs79EbgOkbrTTCQpqWwC+InnBmzs4M6TyIOAxFCrzuYBtmSNp7l+oK5QQ
        avXmBhIH13sPFUAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.10-rc7
Message-ID: <160726029814.10836.11636935433736940390.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-12-06

up to:  9ea69a55b3b9: powerpc/pseries: Pass MSI affinity to irq_create_mapping()


A set of updates for the interrupt subsystem:

  - Make multiqueue devices which use the managed interrupt affinity
    infrastructure work on PowerPC/Pseries. PowerPC does not use the
    generic infrastructure for setting up PCI/MSI interrupts and the
    multiqueue changes failed to update the legacy PCI/MSI infrastructure.
    Make this work by passing the affinity setup information down to the
    mapping and allocation functions.

  - Move Jason Cooper from MAINTAINERS to CREDITS as his mail is bouncing
    and he's not reachable. We hope all is well with him and say thanks
    for his work over the years.

Thanks,

	tglx

------------------>
Laurent Vivier (2):
      genirq/irqdomain: Add an irq_create_mapping_affinity() function
      powerpc/pseries: Pass MSI affinity to irq_create_mapping()

Marc Zyngier (1):
      MAINTAINERS: Move Jason Cooper to CREDITS


 CREDITS                              |  5 +++++
 MAINTAINERS                          |  4 ----
 arch/powerpc/platforms/pseries/msi.c |  3 ++-
 include/linux/irqdomain.h            | 12 ++++++++++--
 kernel/irq/irqdomain.c               | 13 ++++++++-----
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/CREDITS b/CREDITS
index 748301954ab7..e88d1a783a80 100644
--- a/CREDITS
+++ b/CREDITS
@@ -740,6 +740,11 @@ S: (ask for current address)
 S: Portland, Oregon
 S: USA
 
+N: Jason Cooper
+D: ARM/Marvell SOC co-maintainer
+D: irqchip co-maintainer
+D: MVEBU PCI DRIVER co-maintainer
+
 N: Robin Cornelius
 E: robincornelius@users.sourceforge.net
 D: Ralink rt2x00 WLAN driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..4f27f43b2e0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2014,7 +2014,6 @@ M:	Philipp Zabel <philipp.zabel@gmail.com>
 S:	Maintained
 
 ARM/Marvell Dove/MV78xx0/Orion SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 M:	Gregory Clement <gregory.clement@bootlin.com>
@@ -2031,7 +2030,6 @@ F:	arch/arm/plat-orion/
 F:	drivers/soc/dove/
 
 ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Gregory Clement <gregory.clement@bootlin.com>
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
@@ -9248,7 +9246,6 @@ F:	kernel/irq/
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Jason Cooper <jason@lakedaemon.net>
 M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -13394,7 +13391,6 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
-M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 133f6adcb39c..b3ac2455faad 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 			return hwirq;
 		}
 
-		virq = irq_create_mapping(NULL, hwirq);
+		virq = irq_create_mapping_affinity(NULL, hwirq,
+						   entry->affinity);
 
 		if (!virq) {
 			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e87109f..ea5a337e0f8b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -384,11 +384,19 @@ extern void irq_domain_associate_many(struct irq_domain *domain,
 extern void irq_domain_disassociate(struct irq_domain *domain,
 				    unsigned int irq);
 
-extern unsigned int irq_create_mapping(struct irq_domain *host,
-				       irq_hw_number_t hwirq);
+extern unsigned int irq_create_mapping_affinity(struct irq_domain *host,
+				      irq_hw_number_t hwirq,
+				      const struct irq_affinity_desc *affinity);
 extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
 
+static inline unsigned int irq_create_mapping(struct irq_domain *host,
+					      irq_hw_number_t hwirq)
+{
+	return irq_create_mapping_affinity(host, hwirq, NULL);
+}
+
+
 /**
  * irq_linear_revmap() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..e4ca69608f3b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -624,17 +624,19 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 
 /**
- * irq_create_mapping() - Map a hardware interrupt into linux irq space
+ * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
  * @domain: domain owning this hardware interrupt or NULL for default domain
  * @hwirq: hardware irq number in that domain space
+ * @affinity: irq affinity
  *
  * Only one mapping per hardware interrupt is permitted. Returns a linux
  * irq number.
  * If the sense/trigger is to be specified, set_irq_type() should be called
  * on the number returned from that call.
  */
-unsigned int irq_create_mapping(struct irq_domain *domain,
-				irq_hw_number_t hwirq)
+unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       const struct irq_affinity_desc *affinity)
 {
 	struct device_node *of_node;
 	int virq;
@@ -660,7 +662,8 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	}
 
 	/* Allocate a virtual interrupt number */
-	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL);
+	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node),
+				      affinity);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -676,7 +679,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 
 	return virq;
 }
-EXPORT_SYMBOL_GPL(irq_create_mapping);
+EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
 
 /**
  * irq_create_strict_mappings() - Map a range of hw irqs to fixed linux irqs

