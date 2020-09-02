Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4DB25B328
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIBRq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 13:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgIBRqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:46:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B21520BED;
        Wed,  2 Sep 2020 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599068784;
        bh=DyGf/rGGsiiACYr2SknVP15hud74tFnWOvfbNkupwN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFjeTZ86n0JHKv5188/0vh3xJRpfEhH0vi6q0oIMBMlFuuP983e0zVd8RkNlmXDNI
         0SwP1Iqv1HEqW4JpmCNM2iC62CdnZGlwnIvj80hyne8F67fGb0LQJkXzTiCJUzWHl0
         E29pFYURSi36hfbUINj/YTj/Gt57bjNQXHu9+4R4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] irqchip/ti-sci-inta: Fix kerneldoc
Date:   Wed,  2 Sep 2020 19:46:15 +0200
Message-Id: <20200902174615.24695-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902174615.24695-1-krzk@kernel.org>
References: <20200902174615.24695-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kerneldoc W=1 warnings:

  drivers/irqchip/irq-ti-sci-inta.c:144: warning: Function parameter or member 'vint_id' not described in 'ti_sci_inta_xlate_irq'
  drivers/irqchip/irq-ti-sci-inta.c:144: warning: Excess function parameter 'irq' description in 'ti_sci_inta_xlate_irq'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/irqchip/irq-ti-sci-inta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index bc863ef7998d..84929f3e2003 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -134,7 +134,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 /**
  * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
  * @inta:	IRQ domain corresponding to Interrupt Aggregator
- * @irq:	Hardware irq corresponding to the above irq domain
+ * @vint_id:	TISCI vint ID
  *
  * Return parent irq number if translation is available else -ENOENT.
  */
-- 
2.17.1

