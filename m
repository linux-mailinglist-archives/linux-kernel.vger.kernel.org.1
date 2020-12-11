Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589372D786D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406492AbgLKPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406451AbgLKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:38 -0500
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hn35IJ7qfEnzrjq5Ynner1pzwSEPn+cmitzn+HnpFEY=;
        b=4r87xE1Cc7emsEJdTWWKQZG83cqNSk8yjpb8R6HV6GpwejvJENDCpyIvYnKmgxyOwqoapi
        XZz7X7dMIB3bmFqqdoRf01EIbQM5Wup2m5hp5HqPuj9NFRw0hApof3WYjzQCv5/Q120QkQ
        txLla8IiJkZEsERf3vYKtJ1W/sxmsJI/63JLiQ0j9OVmS7WNDdVpRCoQUfHiq+evCWVEun
        6SU/K/XIHYiNPVTY9H0Mv7043mmwouxKPnDMdwXvqqsg7HgAj7wpHk04VPL+lohqiwybBs
        VRM/LdIW3pNIIkQ4x+36hM8W7Iq/Vhd4TCUZ4Y3994yEIz7sWwjArA+vIwj1wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hn35IJ7qfEnzrjq5Ynner1pzwSEPn+cmitzn+HnpFEY=;
        b=khHB8mbWFhU8B3cj85LQ8OeDIwZdWycDmc9+PM/0QM8L+UwDO9sQfe98PSb5AYO2B5xQZN
        MjsHm1oMlVYZqoAg==
From:   "irqchip-bot for Hou Zhiqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ls-extirq: Add LS1043A, LS1088A
 external interrupt support
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201130101515.27431-1-biwen.li@oss.nxp.com>
References: <20201130101515.27431-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <160769872598.3364.907526307601900970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b16a1caf4686895427c810219d4b2f796e676160
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b16a1caf4686895427c810219d4b2f796e676160
Author:        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
AuthorDate:    Mon, 30 Nov 2020 18:15:05 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:43:16 

irqchip/ls-extirq: Add LS1043A, LS1088A external interrupt support

Add an new IRQ chip declaration for LS1043A and LS1088A, and cleanup
the use of the "bit_reverse" property, now gated on the Soc type.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201130101515.27431-1-biwen.li@oss.nxp.com
---
 drivers/irqchip/irq-ls-extirq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179f..f94f974 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -18,7 +18,7 @@
 struct ls_extirq_data {
 	struct regmap		*syscon;
 	u32			intpcr;
-	bool			bit_reverse;
+	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
@@ -30,7 +30,7 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	irq_hw_number_t hwirq = data->hwirq;
 	u32 value, mask;
 
-	if (priv->bit_reverse)
+	if (priv->is_ls1021a_or_ls1043a)
 		mask = 1U << (31 - hwirq);
 	else
 		mask = 1U << hwirq;
@@ -174,14 +174,8 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	if (ret)
 		goto out;
 
-	if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
-		u32 revcr;
-
-		ret = regmap_read(priv->syscon, LS1021A_SCFGREVCR, &revcr);
-		if (ret)
-			goto out;
-		priv->bit_reverse = (revcr != 0);
-	}
+	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
+				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
@@ -195,3 +189,5 @@ out:
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
