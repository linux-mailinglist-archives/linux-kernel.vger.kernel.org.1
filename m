Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC77296CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462029AbgJWKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461926AbgJWKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:18:28 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5255E20936;
        Fri, 23 Oct 2020 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603448308;
        bh=Q2r2MpV4mhDq9ZPXIsBSWpTyiKSzFfZDPrP/d+7Waxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o32LBurpluUVsOnJUTvVZM9MNs2/Yn9MJ9dd9LoErCOY4LYhqGMrav90SdRA1ftoo
         3hvBWuzZ7SC0FiGceMW1gP/J/A6nPIV9ajR5ywAJf/rS/VH+j/caR0kVJ4M2lEBW3g
         ocpv9JC6gAt7ChMeauwUpsf81qXeKTp53BrBYpOw=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        atish.patra@wdc.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, wesley@sifive.com, yash.shah@sifive.com, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/3] irqchip/irq-sifive-plic: Fixup couldn't broadcast to multi CPUs
Date:   Fri, 23 Oct 2020 10:17:24 +0000
Message-Id: <1603448245-79429-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603448245-79429-1-git-send-email-guoren@kernel.org>
References: <1603448245-79429-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If "echo 3 > /proc/irq/1/smp_affinity", we want irq 1 could be
broadcast to CPU0 & CPU1 and one of them would pick up the irq
handler.

But current implementation couldn't let multi CPUs process the
same IRQ concurrent.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 drivers/irqchip/irq-sifive-plic.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2e56576..0003322 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -114,15 +114,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 static void plic_irq_unmask(struct irq_data *d)
 {
 	struct cpumask amask;
-	unsigned int cpu;
 	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
 	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
-	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   &amask);
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
-		return;
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
+
+	plic_irq_toggle(&amask, d, 1);
 }
 
 static void plic_irq_mask(struct irq_data *d)
@@ -136,24 +133,16 @@ static void plic_irq_mask(struct irq_data *d)
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
-	unsigned int cpu;
 	struct cpumask amask;
 	struct plic_priv *priv = irq_get_chip_data(d->irq);
 
 	cpumask_and(&amask, &priv->lmask, mask_val);
+	cpumask_and(&amask, &amask, cpu_online_mask);
 
-	if (force)
-		cpu = cpumask_first(&amask);
-	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+	irq_data_update_effective_affinity(d, &amask);
 
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
-
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	plic_irq_toggle(&amask, d, 1);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
-- 
2.7.4

