Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CF2D788A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437163AbgLKPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436792AbgLKPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35BCC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:47 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ndYLJJzVjZu6CKG3/xfI/W3cQCqNRSM1koT1gd+Rh0=;
        b=Jda1FseEJOlNHoM9mTYvcJUlKTvltchUFCuJabfMBw9KqFcV2kQRhcxQKgeZZRGsnON1fL
        jfK3hgmXZ/P1SKyfD+Jn64VpgnXGLR3+rBItGGrsAiL4iDQ99oxvbNTtbVLrsSwB4FJdy9
        HpCzO1zaM19Syp0q9OtaSkaNFZZlGOIbufZ0uGzfXb8rCHfRlH6w78tlEEGX1DpTjSEoFa
        79yX8OVx3vCWz+WnS5g+gZRXqMbEdD1tw+7k0/bz3Llf8KlHdp93tI49/WrLiXEXn2lwuS
        CLdUD1jQqC41Y5MB59XuOGaG0+tOir0UmhwuJtqlIaGa5zrXY3IzHCdt8QNaLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ndYLJJzVjZu6CKG3/xfI/W3cQCqNRSM1koT1gd+Rh0=;
        b=hwf4ftcKFexun7P0UZfOojahNgGXz+j6rtanBjXCtr9Onpp07MAqmuXKYv2arF9EzK+FxT
        SDP7VSDNG3XATxBw==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ocelot: Add support for Jaguar2 platforms
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-7-gregory.clement@bootlin.com>
References: <20201125103206.136498-7-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872433.3364.16419123144254419421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     550c1424acf0123ba0c17e22dfcac92d152b2f0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/550c1424acf0123ba0c17e22dfcac92d152b2f0e
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

irqchip/ocelot: Add support for Jaguar2 platforms

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Jaguar2.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201125103206.136498-7-gregory.clement@bootlin.com
---
 drivers/irqchip/irq-mscc-ocelot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index da5a0ad..8235d98 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -63,6 +63,17 @@ static struct chip_props luton_props = {
 	.n_irq			= 28,
 };
 
+static struct chip_props jaguar2_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.n_irq			= 29,
+};
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
@@ -197,3 +208,11 @@ static int __init luton_irq_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
+
+static int __init jaguar2_irq_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &jaguar2_props);
+}
+
+IRQCHIP_DECLARE(jaguar2_icpu, "mscc,jaguar2-icpu-intr", jaguar2_irq_init);
