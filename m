Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E524A59B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHSSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:06:16 -0400
Received: from crapouillou.net ([89.234.176.41]:33286 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgHSSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597860368; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=kFohp8eC88p8KWDMpxZDQiAv/OkMPw3loVV19jqtTvA=;
        b=al84feFAmhSNPEhXIv6AwIHQH41l3AOsy6cO/wJSIKsNR3q0ohDmvwY0I5cswWMd5Aqi6L
        ThsE8WlKmx8MWN4qo+9lL6w3FXtbJmnHLItfI15BhNj1s6zoDqPeWzLRJgUscysQYnt6ZZ
        N2ALTiIKQAk/xe/13pOSn/d1akKjHe4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] irqchip: ingenic: Leave parent IRQ unmasked on suspend
Date:   Wed, 19 Aug 2020 20:06:02 +0200
Message-Id: <20200819180602.136969-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the wakeup sources we possibly want will go through the interrupt
controller, so the parent IRQ must not be masked during suspend, or
there won't be any way to wake up the system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 9f3da4260ca6..b61a8901ef72 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -125,7 +125,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
-	if (request_irq(parent_irq, intc_cascade, 0,
+	if (request_irq(parent_irq, intc_cascade, IRQF_NO_SUSPEND,
 			"SoC intc cascade interrupt", NULL))
 		pr_err("Failed to register SoC intc cascade interrupt\n");
 	return 0;
-- 
2.28.0

