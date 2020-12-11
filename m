Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66952D7889
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437203AbgLKPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406433AbgLKO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F94C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:44 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ic+vfqlE4580v59PU3PsT3KhDic4omGc8OtQDmN+gNI=;
        b=fuZsFgRb9kLXZzIUXGePfuKRvWDARRS+O5SnRbuFdcv54zLLa9y4QybDarje1d/VSmVbwy
        bzaVO3g6s3IUxWRMBsX2KRpevc62m0F/OPRvyQMnDcX5e9pCUmMTDg2SxbKgwu+aegGFsR
        bKsoZcw4QYci//Mm0+zUrmTE1wO/UyMiFoPjDq8bdjO/JWxPyH/xoNm2DuO0bRJQ7PxRw/
        uxLp99twhbDnGonzaWCxyeGyTN9Mh3H9iNkeTLgTldff68CVdncKWGLMo5NW9LMjfZzlZ9
        9iHqbu0cUESPyIB191hISAJrv2tOsg1GGBT4bQu2Xflkh12smuf92ZMBRJPgiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ic+vfqlE4580v59PU3PsT3KhDic4omGc8OtQDmN+gNI=;
        b=vZhmV35MW7WGL7G16C+DhNN9n11sRGnOQu1caSEDV4JyAjilKG1v3e7V3dH0r9npv7oGKS
        DxMeWUsIDcVNy6DA==
From:   "irqchip-bot for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/affinity: Add irq_update_affinity_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Marc Zyngier <maz@kernel.org>
In-Reply-To: <1606905417-183214-2-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <160769872232.3364.18187314736977838346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1d3aec89286254487df7641c30f1b14ad1d127a5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1d3aec89286254487df7641c30f1b14ad1d127a5
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 02 Dec 2020 18:36:53 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

genirq/affinity: Add irq_update_affinity_desc()

Add a function to allow the affinity of an interrupt be switched to
managed, such that interrupts allocated for platform devices may be
managed.

This new interface has certain limitations, and attempts to use it in the
following circumstances will fail:
- For when the kernel is configured for generic IRQ reservation mode (in
  config GENERIC_IRQ_RESERVATION_MODE). The reason being that it could
  conflict with managed vs. non-managed interrupt accounting.
- The interrupt is already started, which should not be the case during
  init
- The interrupt is already configured as managed, which means double init

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1606905417-183214-2-git-send-email-john.garry@huawei.com
---
 include/linux/interrupt.h |  8 ++++-
 kernel/irq/manage.c       | 70 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299e..870b325 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -352,6 +352,8 @@ extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
 
 extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -387,6 +389,12 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 	return -EINVAL;
 }
 
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e04..c826ba4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -371,6 +371,76 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+/**
+ * irq_update_affinity_desc - Update affinity management for an interrupt
+ * @irq:	The interrupt number to update
+ * @affinity:	Pointer to the affinity descriptor
+ *
+ * This interface can be used to configure the affinity management of
+ * interrupts which have been allocated already.
+ *
+ * There are certain limitations on when it may be used - attempts to use it
+ * for when the kernel is configured for generic IRQ reservation mode (in
+ * config GENERIC_IRQ_RESERVATION_MODE) will fail, as it may conflict with
+ * managed/non-managed interrupt accounting. In addition, attempts to use it on
+ * an interrupt which is already started or which has already been configured
+ * as managed will also fail, as these mean invalid init state or double init.
+ */
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	bool activated;
+	int ret = 0;
+
+	/*
+	 * Supporting this with the reservation scheme used by x86 needs
+	 * some more thought. Fail it for now.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		return -EOPNOTSUPP;
+
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/* Requires the interrupt to be shut down */
+	if (irqd_is_started(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Interrupts which are already managed cannot be modified */
+	if (irqd_affinity_is_managed(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/*
+	 * Deactivate the interrupt. That's required to undo
+	 * anything an earlier activation has established.
+	 */
+	activated = irqd_is_activated(&desc->irq_data);
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+	/* Restore the activation state */
+	if (activated)
+		irq_domain_activate_irq(&desc->irq_data, false);
+
+out_unlock:
+	irq_put_desc_busunlock(desc, flags);
+	return ret;
+}
+
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
