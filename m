Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09F529745E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbgJWQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708BA246BF;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=P3zSnx6ZmCHD9ZxQPeInvyPT0YcZ2FHK7jjvNzMmT6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTr4ch3uSrJlqbVMmuBIw8tSiXNayjHiMO00MDFZV7cvE4y4R5i7SNzaHeYntn78l
         WN/Zby46AIOK/CG+UCZgU9oJ1pEqPI04QS5367trz/i6yeBowmssqhKIsfho6xHpW6
         nrVKBWNrsO3WuzeAUTTLH+r4gKFVW/cwFxQP/oFs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002AxL-FJ; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 44/56] genirq: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:31 +0200
Message-Id: <fb11ce8a55ecd41e118e5332318d8d6b92e56e26.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
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
@@ -61,7 +61,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_type - set the irq trigger type for an irq
+ *	irq_set_irq_type - set the irq trigger type for an irq
  *	@irq:	irq number
  *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a070a99..a23ac2bbf433 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -269,7 +269,7 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 }
 
 /**
- * __irq_alloc_domain_generic_chip - Allocate generic chips for an irq domain
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
  * @d:			irq domain for which to allocate chips
  * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
  * @num_ct:		Number of irq_chip_type instances associated with this
-- 
2.26.2

