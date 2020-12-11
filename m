Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF32D7888
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437292AbgLKPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406206AbgLKO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53351C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:44 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8vexeLzZ9kwzO3Dkv3CQ3ERMRnwCF3VU/RRbRJRE2w=;
        b=uHUPSn7FEIY4DIJK/QKgt010CzL25clr1vj3QoOwnRqLAgQpyqIDa7T5Oop4jJcI/q6XyW
        2tOpC4fW/J8hqPEu5/s/BIgyZb4yH8SiPLqgo5BKJZMeeskvKVx9vrCoFl3s3908JZ4XsE
        yDV13hvt8RaR7UDEgoTI+9YvxG9vrbRYYBGbX2S/LZGgZzxOAuDPV7vLmZI2vSSs2zR0vw
        HHyKnqmQ0oEUoEnGmXKVL1sNo4x+CsEFI8CKNwLjtaRpfGhOtqeGfWrF/jXfxdO24vSuo3
        SR9lGMBeg6Q6/AKaupZk/YETO0HsH1LDP5bOSUUOlRGjGl5oHfpLU+pRehdcRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8vexeLzZ9kwzO3Dkv3CQ3ERMRnwCF3VU/RRbRJRE2w=;
        b=V9dmjhy/0m8XlaVpUh9sWYLRvdrD8M3m59S5RadnneCjf0UwNiWKqDmwnGWtVKl3XXtVr4
        Jxgs410AKsk4IVBw==
From:   "irqchip-bot for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] driver core: platform: Add
 devm_platform_get_irqs_affinity()
Cc:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1606905417-183214-5-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <160769872184.3364.16177033620349431031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e15f2fa959f2cce8a05e8e3a596e75d068cd42c5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e15f2fa959f2cce8a05e8e3a596e75d068cd42c5
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 02 Dec 2020 18:36:56 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:51 

driver core: platform: Add devm_platform_get_irqs_affinity()

Drivers for multi-queue platform devices may also want managed interrupts
for handling HW queue completion interrupts, so add support.

The function accepts an affinity descriptor pointer, which covers all IRQs
expected for the device.

The function is devm class as the only current in-tree user will also use
devm method for requesting the interrupts; as such, the function is made
as devm as it can ensure ordering of freeing the irq and disposing of the
mapping.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1606905417-183214-5-git-send-email-john.garry@huawei.com
---
 drivers/base/platform.c         | 121 +++++++++++++++++++++++++++++++-
 include/linux/platform_device.h |   6 ++-
 2 files changed, 127 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93..ea8add1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/dma-mapping.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
@@ -289,6 +291,125 @@ int platform_irq_count(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(platform_irq_count);
 
+struct irq_affinity_devres {
+	unsigned int count;
+	unsigned int irq[];
+};
+
+static void platform_disable_acpi_irq(struct platform_device *pdev, int index)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, index);
+	if (r)
+		irqresource_disabled(r, 0);
+}
+
+static void devm_platform_get_irqs_affinity_release(struct device *dev,
+						    void *res)
+{
+	struct irq_affinity_devres *ptr = res;
+	int i;
+
+	for (i = 0; i < ptr->count; i++) {
+		irq_dispose_mapping(ptr->irq[i]);
+
+		if (has_acpi_companion(dev))
+			platform_disable_acpi_irq(to_platform_device(dev), i);
+	}
+}
+
+/**
+ * devm_platform_get_irqs_affinity - devm method to get a set of IRQs for a
+ *				device using an interrupt affinity descriptor
+ * @dev: platform device pointer
+ * @affd: affinity descriptor
+ * @minvec: minimum count of interrupt vectors
+ * @maxvec: maximum count of interrupt vectors
+ * @irqs: pointer holder for IRQ numbers
+ *
+ * Gets a set of IRQs for a platform device, and updates IRQ afffinty according
+ * to the passed affinity descriptor
+ *
+ * Return: Number of vectors on success, negative error number on failure.
+ */
+int devm_platform_get_irqs_affinity(struct platform_device *dev,
+				    struct irq_affinity *affd,
+				    unsigned int minvec,
+				    unsigned int maxvec,
+				    int **irqs)
+{
+	struct irq_affinity_devres *ptr;
+	struct irq_affinity_desc *desc;
+	size_t size;
+	int i, ret, nvec;
+
+	if (!affd)
+		return -EPERM;
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	nvec = platform_irq_count(dev);
+
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	if (nvec > maxvec)
+		nvec = maxvec;
+
+	size = sizeof(*ptr) + sizeof(unsigned int) * nvec;
+	ptr = devres_alloc(devm_platform_get_irqs_affinity_release, size,
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ptr->count = nvec;
+
+	for (i = 0; i < nvec; i++) {
+		int irq = platform_get_irq(dev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto err_free_devres;
+		}
+		ptr->irq[i] = irq;
+	}
+
+	desc = irq_create_affinity_masks(nvec, affd);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_free_devres;
+	}
+
+	for (i = 0; i < nvec; i++) {
+		ret = irq_update_affinity_desc(ptr->irq[i], &desc[i]);
+		if (ret) {
+			dev_err(&dev->dev, "failed to update irq%d affinity descriptor (%d)\n",
+				ptr->irq[i], ret);
+			goto err_free_desc;
+		}
+	}
+
+	devres_add(&dev->dev, ptr);
+
+	kfree(desc);
+
+	*irqs = ptr->irq;
+
+	return nvec;
+
+err_free_desc:
+	kfree(desc);
+err_free_devres:
+	devres_free(ptr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_irqs_affinity);
+
 /**
  * platform_get_resource_byname - get a resource for a device by name
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aad..4d75633 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -15,6 +15,7 @@
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-2)
 
+struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
@@ -70,6 +71,11 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
+extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
+					   struct irq_affinity *affd,
+					   unsigned int minvec,
+					   unsigned int maxvec,
+					   int **irqs);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
