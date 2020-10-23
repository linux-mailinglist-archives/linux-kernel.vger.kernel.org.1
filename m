Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA413296CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462037AbgJWKSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461215AbgJWKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:18:35 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0C824182;
        Fri, 23 Oct 2020 10:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603448314;
        bh=VQkOQqXVAMZZl0wG36+SPXHmfOpuP3DhOAi57iQd4xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtVp2hNnwKo2BHrStyM/agggm9GlwzSD0M0qp+eKjILGY/n6PR4CNYDEygQ2rcHL+
         CtTu9EEFV7ziMODxvLTFw/3dG0Fs2WI3lHtpm8pc5OKbhvbdOLtzHgZSdEo27ovDBO
         tW/E3nHFIJGYlEwYcrVXK1B1FXD8e8HSv6pr/iRY=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        atish.patra@wdc.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, wesley@sifive.com, yash.shah@sifive.com, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/3] irqchip/irq-sifive-plic: Fixup set_affinity enable irq unexpected
Date:   Fri, 23 Oct 2020 10:17:25 +0000
Message-Id: <1603448245-79429-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603448245-79429-1-git-send-email-guoren@kernel.org>
References: <1603448245-79429-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

For PLIC, we only have enable registers to control per hart's irq
affinity and irq_set_affinity would call plic_irq_toggle to enable
the IRQ's routing. So we can't enable irq in irq_domain_map before
request_irq, it'll let uninitialized devices' irq exception.

The solution is to check the irq has been enabled, just like what
irq-gic-v3 has done in gic_set_affinity.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 drivers/irqchip/irq-sifive-plic.c | 45 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 0003322..1a63859 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -130,6 +130,36 @@ static void plic_irq_mask(struct irq_data *d)
 }
 
 #ifdef CONFIG_SMP
+static inline bool plic_toggle_is_enabled(struct plic_handler *handler,
+						int hwirq)
+{
+	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
+	u32 hwirq_mask = 1 << (hwirq % 32);
+
+	if (readl(reg) & hwirq_mask)
+		return true;
+	else
+		return false;
+}
+
+static inline bool plic_irq_is_enabled(const struct cpumask *mask,
+				   struct irq_data *d)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+
+		if (!handler->present)
+			continue;
+
+		if (plic_toggle_is_enabled(handler, d->hwirq))
+			return true;
+	}
+
+	return false;
+}
+
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
@@ -141,8 +171,10 @@ static int plic_set_affinity(struct irq_data *d,
 
 	irq_data_update_effective_affinity(d, &amask);
 
-	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(&amask, d, 1);
+	if (plic_irq_is_enabled(&priv->lmask, d)) {
+		plic_irq_toggle(&priv->lmask, d, 0);
+		plic_irq_toggle(&amask, d, 1);
+	}
 
 	return IRQ_SET_MASK_OK_DONE;
 }
@@ -168,12 +200,19 @@ static struct irq_chip plic_chip = {
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
+	unsigned int cpu;
 	struct plic_priv *priv = d->host_data;
 
 	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
-	irq_set_affinity(irq, &priv->lmask);
+
+	cpu = cpumask_any_and(&priv->lmask, cpu_online_mask);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return -EINVAL;
+
+	irq_set_affinity(irq, cpumask_of(cpu));
+
 	return 0;
 }
 
-- 
2.7.4

