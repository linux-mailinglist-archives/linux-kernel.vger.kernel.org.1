Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC62C1104
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbgKWQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:46:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbgKWQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:46:02 -0500
Date:   Mon, 23 Nov 2020 16:45:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606149960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOX8YwaSLawXSjvsYuYoFNcv/GPcarqIZsqpXK67kKo=;
        b=yfrPcHYK/XdVp4TvIA7g1Bh3LuvLn1eomSOBMmjuAni6H+51uowxlzS1Zs6S5kDgOmHKqE
        fuUG0kRg53rtmZ5WrAovyVQeHki/qqvU3f1LMq6OTWkCfJbqct2LAFoDnSvUK4nJ8JINEC
        5PHUOAqmJUV2yL2bGIZPMmgLT0t/cL7OsTqOPnytmfyFTQYywEexgeXcA1VlTrMPb+lCx9
        /59VS+yCU3jvMUysE+0lMP02bHYi7mBPk/NiwQ/woagl+YsOJXII+rLpaVMbp2qaEJd3es
        lAQ+lRKTlr3SIbIx5pH0L94M9i/7G61H4wO7NRSqeCFUDPPzcnvSWAEQTGJZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606149960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOX8YwaSLawXSjvsYuYoFNcv/GPcarqIZsqpXK67kKo=;
        b=TGrmbijsw0ax3qGyaiWoLzwUlK5h9eaF2WEJoXkhvC/Jy/Tkk/z0hOIKtdz4mfbqU0UkPq
        051ac+J6yYuVDjAQ==
From:   "irqchip-bot for Xu Qiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Unconditionally
 save/restore the ITS state on suspend
Cc:     Xu Qiang <xuqiang36@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201107104226.14282-1-xuqiang36@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Message-ID: <160614995821.11115.16304362379538101182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     74cde1a53368aed4f2b4b54bf7030437f64a534b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/74cde1a53368aed4f2b4b54bf7030437f64a534b
Author:        Xu Qiang <xuqiang36@huawei.com>
AuthorDate:    Sat, 07 Nov 2020 10:42:26 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Nov 2020 12:58:35 

irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend

On systems without HW-based collections (i.e. anything except GIC-500),
we rely on firmware to perform the ITS save/restore. This doesn't
really work, as although FW can properly save everything, it cannot
fully restore the state of the command queue (the read-side is reset
to the head of the queue). This results in the ITS consuming previously
processed commands, potentially corrupting the state.

Instead, let's always save the ITS state on suspend, disabling it in the
process, and restore the full state on resume. This saves us from broken
FW as long as it doesn't enable the ITS by itself (for which we can't do
anything).

This amounts to simply dropping the ITS_FLAGS_SAVE_SUSPEND_STATE.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
[maz: added warning on resume, rewrote commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201107104226.14282-1-xuqiang36@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0418071..0598c5c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,7 +42,6 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
-#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
@@ -4741,9 +4740,6 @@ static int its_save_disable(void)
 	list_for_each_entry(its, &its_nodes, entry) {
 		void __iomem *base;
 
-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-			continue;
-
 		base = its->base;
 		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
 		err = its_force_quiescent(base);
@@ -4762,9 +4758,6 @@ err:
 		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
 			void __iomem *base;
 
-			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-				continue;
-
 			base = its->base;
 			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
 		}
@@ -4784,9 +4777,6 @@ static void its_restore_enable(void)
 		void __iomem *base;
 		int i;
 
-		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
-			continue;
-
 		base = its->base;
 
 		/*
@@ -4794,7 +4784,10 @@ static void its_restore_enable(void)
 		 * don't restore it since writing to CBASER or BASER<n>
 		 * registers is undefined according to the GIC v3 ITS
 		 * Specification.
+		 *
+		 * Firmware resuming with the ITS enabled is terminally broken.
 		 */
+		WARN_ON(readl_relaxed(base + GITS_CTLR) & GITS_CTLR_ENABLE);
 		ret = its_force_quiescent(base);
 		if (ret) {
 			pr_err("ITS@%pa: failed to quiesce on resume: %d\n",
@@ -5074,9 +5067,6 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
-	if (GITS_TYPER_HCC(typer))
-		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
-
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
