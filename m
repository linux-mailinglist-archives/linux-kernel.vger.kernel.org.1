Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3E2B40E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgKPKTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgKPKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:30 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79809238E6;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=bYE3K8qf8FuwlLitXjd9/yN9A+lYb43nUXRVfV4LFV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBa/yVr9oXRB0QRipjpbDQqoGTOaedRbnNeZr3nROwiTeGoSla+DzctYNfH1ik1xP
         BEcM1O0frppI5UpSDFktm9aawOid0Dh9+ozqAYTiyFxIQpG1G2gCbgBHRf6Z7yZvC1
         V3GppEBTX2/uh5u39bJCUNZilARElSUYRfX0fYOM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEY-Gq; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/27] genirq: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:15 +0100
Message-Id: <13a44f4f0c3135e14b16ae8fcce4af1eab27cb5f.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/irq/chip.c         | 2 +-
 kernel/irq/generic-chip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b9b9618e1aca..df75c3573dcb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -44,41 +44,41 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
 
 	if (!desc)
 		return -EINVAL;
 
 	if (!chip)
 		chip = &no_irq_chip;
 
 	desc->irq_data.chip = chip;
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
 	 * allocated_irqs.
 	 */
 	irq_mark_irq(irq);
 	return 0;
 }
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_type - set the irq trigger type for an irq
+ *	irq_set_irq_type - set the irq trigger type for an irq
  *	@irq:	irq number
  *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
 int irq_set_irq_type(unsigned int irq, unsigned int type)
 {
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
 	int ret = 0;
 
 	if (!desc)
 		return -EINVAL;
 
 	ret = __irq_set_trigger(desc, type);
 	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
 EXPORT_SYMBOL(irq_set_irq_type);
 
 /**
  *	irq_set_handler_data - set irq handler data for an irq
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a070a99..a23ac2bbf433 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -252,41 +252,41 @@ EXPORT_SYMBOL_GPL(irq_alloc_generic_chip);
 
 static void
 irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 {
 	struct irq_chip_type *ct = gc->chip_types;
 	u32 *mskptr = &gc->mask_cache, mskreg = ct->regs.mask;
 	int i;
 
 	for (i = 0; i < gc->num_ct; i++) {
 		if (flags & IRQ_GC_MASK_CACHE_PER_TYPE) {
 			mskptr = &ct[i].mask_cache_priv;
 			mskreg = ct[i].regs.mask;
 		}
 		ct[i].mask_cache = mskptr;
 		if (flags & IRQ_GC_INIT_MASK_CACHE)
 			*mskptr = irq_reg_readl(gc, mskreg);
 	}
 }
 
 /**
- * __irq_alloc_domain_generic_chip - Allocate generic chips for an irq domain
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
  * @d:			irq domain for which to allocate chips
  * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
  * @num_ct:		Number of irq_chip_type instances associated with this
  * @name:		Name of the irq chip
  * @handler:		Default flow handler associated with these chips
  * @clr:		IRQ_* bits to clear in the mapping function
  * @set:		IRQ_* bits to set in the mapping function
  * @gcflags:		Generic chip specific setup flags
  */
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,
 				     irq_flow_handler_t handler,
 				     unsigned int clr, unsigned int set,
 				     enum irq_gc_flags gcflags)
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
 	int numchips, sz, i;
 	unsigned long flags;
 	void *tmp;
-- 
2.28.0

