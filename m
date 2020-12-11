Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FCC2D786E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406485AbgLKPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406452AbgLKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:38 -0500
Date:   Fri, 11 Dec 2020 14:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty2KfmflhP6deAOt8T+nEBbjAHglT69aSb4HcMmiZuI=;
        b=DXIphL56lKpf6wupKqwILL74dg1AweFBAg708Jm9IXrD3SuV3zsaVslr+1muniddRXq6t9
        PtYGoaBc6ruP1csqAs4sb12CoJsyo/muSfgzKFQWerz+iQDkKgPX3hNo4sICgbRgB2fPqB
        vIGYX9CWw/6gjghaMvh7DW5hamar8Y7po7qILSw590R4IrLVTePwJ3M9kLFFsrwHh67wIm
        TZbDcJSjgnLE6sIBF+VGW9rECF/wq25Wq6blMA2J6TiH3vv3dGWCxbgXukxOwPe7em/faJ
        vjmm0G//A9DwKB3ZDkOLj4HO2LKmS+G+YJwWg9lYLR5Gu75rHMTm7EfVsmuPbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ty2KfmflhP6deAOt8T+nEBbjAHglT69aSb4HcMmiZuI=;
        b=eg4N78hHGrtJVeUmPibtcxq3aqUa/+TH853pS4ViCAu4O3b5rciBVy7AhVkxbib6FxPv7N
        R7cY56w9d/m/0pAg==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-htpic: Fix build warnings
Cc:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1607159744-995-1-git-send-email-chenhuacai@kernel.org>
References: <1607159744-995-1-git-send-email-chenhuacai@kernel.org>
MIME-Version: 1.0
Message-ID: <160769872615.3364.10476294185448528137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3ee36352e26935c7e8145eb4e7ed38b536ca01fc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3ee36352e26935c7e8145eb4e7ed38b536ca01fc
Author:        Huacai Chen <chenhuacai@kernel.org>
AuthorDate:    Sat, 05 Dec 2020 17:15:44 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:40:17 

irqchip/loongson-htpic: Fix build warnings

Fix build warnings as below:

   drivers/irqchip/irq-loongson-htpic.c: In function 'htpic_reg_init':
>> drivers/irqchip/irq-loongson-htpic.c:62:12: warning: variable 'val' set but not used [-Wunused-but-set-variable]
      62 |   uint32_t val;
         |            ^~~
   drivers/irqchip/irq-loongson-htpic.c: At top level:
>> drivers/irqchip/irq-loongson-htpic.c:84:12: warning: no previous prototype for 'htpic_of_init' [-Wmissing-prototypes]
      84 | int __init htpic_of_init(struct device_node *node, struct device_node *parent)
         |            ^~~~~~~~~~~~~

Fixes: a93f1d903fa34fc2c5d9fa450bd ("irqchip: Add driver for Loongson-3 HyperTransport PIC controller")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1607159744-995-1-git-send-email-chenhuacai@kernel.org
---
 drivers/irqchip/irq-loongson-htpic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-htpic.c b/drivers/irqchip/irq-loongson-htpic.c
index 63f7280..1b801c4 100644
--- a/drivers/irqchip/irq-loongson-htpic.c
+++ b/drivers/irqchip/irq-loongson-htpic.c
@@ -59,11 +59,10 @@ static void htpic_reg_init(void)
 	int i;
 
 	for (i = 0; i < HTINT_NUM_VECTORS; i++) {
-		uint32_t val;
-
 		/* Disable all HT Vectors */
 		writel(0x0, htpic->base + HTINT_EN_OFF + i * 0x4);
-		val = readl(htpic->base + i * 0x4);
+		/* Read back to force write */
+		(void) readl(htpic->base + i * 0x4);
 		/* Ack all possible pending IRQs */
 		writel(GENMASK(31, 0), htpic->base + i * 0x4);
 	}
@@ -81,7 +80,7 @@ struct syscore_ops htpic_syscore_ops = {
 	.resume		= htpic_resume,
 };
 
-int __init htpic_of_init(struct device_node *node, struct device_node *parent)
+static int __init htpic_of_init(struct device_node *node, struct device_node *parent)
 {
 	unsigned int parent_irq[4];
 	int i, err;
