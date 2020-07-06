Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC92150E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 03:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGFB0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 21:26:53 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48960 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728509AbgGFB0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:26:52 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2oefAJfl2VQAA--.1722S16;
        Mon, 06 Jul 2020 09:19:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 14/14] irqchip/xilinx-intc: Fix potential resource leak
Date:   Mon,  6 Jul 2020 09:19:25 +0800
Message-Id: <1593998365-25910-15-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn2oefAJfl2VQAA--.1722S16
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1ruFy7XF17WrW5tF1UKFg_yoW8CFy3pF
        4Uu3yqgr4fGrWUurs3Cr10vas0yw1xKF9Fk3yxCasaqFn0yrZ8ZF1Iya4kWF15uayrZa1x
        ZFs5Xa4UG3WUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w4l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU53l1JUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function xilinx_intc_of_init(), system resource "irqc->root_domain"
was not released in an error case. Thus add a jump target to call the
function "irq_domain_remove" for the completion of the desired exception
handling.

Fixes: 9689c99e4950 ("irqchip/xilinx: Add support for parent intc")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/irqchip/irq-xilinx-intc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 1d3d273..41d9412 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -192,7 +192,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &irqc->nr_irq);
 	if (ret < 0) {
 		pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n");
-		goto error;
+		goto err_iounmap;
 	}
 
 	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr_mask);
@@ -229,7 +229,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
 		ret = -EINVAL;
-		goto error;
+		goto err_iounmap;
 	}
 
 	if (parent) {
@@ -241,7 +241,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		} else {
 			pr_err("irq-xilinx: interrupts property not in DT\n");
 			ret = -EINVAL;
-			goto error;
+			goto err_domain_remove;
 		}
 	} else {
 		primary_intc = irqc;
@@ -250,11 +250,12 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 
 	return 0;
 
-error:
+err_domain_remove:
+	irq_domain_remove(irqc->root_domain);
+err_iounmap:
 	iounmap(irqc->base);
 	kfree(irqc);
 	return ret;
-
 }
 
 IRQCHIP_DECLARE(xilinx_intc_xps, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
-- 
2.1.0

