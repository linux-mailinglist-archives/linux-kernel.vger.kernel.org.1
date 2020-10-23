Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69B3296CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462023AbgJWKSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461902AbgJWKSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:18:18 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 708DE20936;
        Fri, 23 Oct 2020 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603448297;
        bh=BV1tH2U1Lsosw+Ugkhs7glTIjtqVDoAJop9TuiKHT44=;
        h=From:To:Cc:Subject:Date:From;
        b=FXVNjYYNeEGZSvIhl4SuHitDKUsn6hlGW8Wg42BMzw7N0bBGFCQQcXhfA83VUXfh9
         PWbmy5NXe2PNDWiHSzBy2/Ktf60A1UV7UDxoKHO6LjuY2r1O41pscRE2LB20gp4Wkb
         MSAAeYE9mUg2sG/WR0ot+g2CIOxzKRiblzgHdqDM=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        atish.patra@wdc.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, wesley@sifive.com, yash.shah@sifive.com, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/3] irqchip/irq-sifive-plic: Fixup wrong size of xxx_PER_HART and reg base
Date:   Fri, 23 Oct 2020 10:17:23 +0000
Message-Id: <1603448245-79429-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

ENABLE and CONTEXT registers contain M & S status for per-hart, so
ref to the specification the correct definition is double to the
current value.

The value of hart_base and enable_base should be calculated by real
physical hartid not software id. Sometimes the CPU node's <reg>
from dts is not equal to the sequence index.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 drivers/irqchip/irq-sifive-plic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index eaa3e9f..2e56576 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -44,16 +44,16 @@
  * Each hart context has a vector of interrupt enable bits associated with it.
  * There's one bit for each interrupt source.
  */
-#define ENABLE_BASE			0x2000
-#define     ENABLE_PER_HART		0x80
+#define ENABLE_BASE			0x2080
+#define     ENABLE_PER_HART		0x100
 
 /*
  * Each hart context has a set of control registers associated with it.  Right
  * now there's only two: a source priority threshold over which the hart will
  * take an interrupt, and a register to claim interrupts.
  */
-#define CONTEXT_BASE			0x200000
-#define     CONTEXT_PER_HART		0x1000
+#define CONTEXT_BASE			0x201000
+#define     CONTEXT_PER_HART		0x2000
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
@@ -358,10 +358,10 @@ static int __init plic_init(struct device_node *node,
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base =
-			priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+			priv->regs + CONTEXT_BASE + hartid * CONTEXT_PER_HART;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base =
-			priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+			priv->regs + ENABLE_BASE + hartid * ENABLE_PER_HART;
 		handler->priv = priv;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-- 
2.7.4

