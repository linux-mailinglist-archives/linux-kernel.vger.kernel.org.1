Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2CF2D786C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406499AbgLKPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406442AbgLKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:38 -0500
Date:   Fri, 11 Dec 2020 14:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6IoD4Z7pt5xQHYFTBTb9gwO0p5nbB8Ry33Aud2UnSc=;
        b=dV2E14RX3KEp1lwcXjFCFHvLIJ7KnIlkDRHzQhcl5umdsivdaao1CEcAyTkPZh4/b2yAmP
        fLiKWKP/1pYkxuRFq0DRRnY5cQJq3O8Mob75atdSsViY+iUIr0clgR7Xs/Eymx4nb5JAwo
        9HeB+HlPDk2COPoUTF9qO8vFDZ2Cb86JbRayMAhP8toBKKjZOpa+xdt4RIkeysVNm+tA6d
        6zXcLZNTDdVHb9N92HswOKNEqJzU+76trMkzzFYk3Ox/9dxMZm9NcrNnG/di8puRumRbMm
        0alz43TEtq1HyQNWPUOs2HA6UpU1XO4MPkSa9VY3+kJlDnv+WtEVUfImBiYfgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6IoD4Z7pt5xQHYFTBTb9gwO0p5nbB8Ry33Aud2UnSc=;
        b=V+0qodCTACkcN5JxhHVxxlU7qfGd2UqcMW+mSqDFuAVKd4w2LgxSLF0wc4v8YldCh1bnyo
        Y8ShxWTFjdeaiLAw==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ocelot: Add support for Serval platforms
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-6-gregory.clement@bootlin.com>
References: <20201125103206.136498-6-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872456.3364.1708320596924363860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7efdfbd15a21788de8c0743590e777f151a3031b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7efdfbd15a21788de8c0743590e777f151a3031b
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

irqchip/ocelot: Add support for Serval platforms

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Serval.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201125103206.136498-6-gregory.clement@bootlin.com
---
 drivers/irqchip/irq-mscc-ocelot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 496f955..da5a0ad 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -41,6 +41,17 @@ static struct chip_props ocelot_props = {
 	.n_irq			= 24,
 };
 
+static struct chip_props serval_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0xc,
+	.reg_off_ena		= 0x14,
+	.reg_off_ena_clr	= 0x18,
+	.reg_off_ena_set	= 0x1c,
+	.reg_off_ident		= 0x20,
+	.reg_off_trigger	= 0x4,
+	.n_irq			= 24,
+};
+
 static struct chip_props luton_props = {
 	.flags			= FLAGS_NEED_INIT_ENABLE,
 	.reg_off_sticky		= 0,
@@ -171,6 +182,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 
 IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
 
+static int __init serval_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &serval_props);
+}
+
+IRQCHIP_DECLARE(serval_icpu, "mscc,serval-icpu-intr", serval_irq_init);
+
 static int __init luton_irq_init(struct device_node *node,
 				 struct device_node *parent)
 {
