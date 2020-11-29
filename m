Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D02C796F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgK2NjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:39:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2NjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:39:06 -0500
Date:   Sun, 29 Nov 2020 13:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606657103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4M/usYIBH/1K7GIp/mAlVHgdWbH0i60lH29P4fz+KGg=;
        b=hV6sn1SycCEKXXaHU+lcd9vx4E8asD1ZZJf3taL1iSwuDN8A0yOmguwcXVE/0MuIvvmMrp
        LePqasUPgpSJwWFuTaShDEY0pXvONhB5MJ/qbialplh16hkusvC/0qPYIbsL/IuswoZBCJ
        Y3k9h4IkmKcvyeheGDV4w/r8QdiPrM/aPWJaSDejbUt75C/vX8u3iVYH+oqv0ZlhMRt4e+
        +R+vT1oZyA05GEfwT08G64g+T4BrJKD66ip9NpxOpv7f0NUesZWZ6cAtQ2C9MEry7S6Eb7
        FrslWoqdMJ/l4rJJlv8AOY2/NiIf9FdmgkUGtDl26cYXcgzJhuzze8n9IWS08Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606657103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4M/usYIBH/1K7GIp/mAlVHgdWbH0i60lH29P4fz+KGg=;
        b=E0x27bGNVSDMzsdlh50BtWpkFLqijP58w8G81ILJQTZR8wXS8aLD22WSbT2Do1b3LxMIMv
        mgCocEzX4GXe6IDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.10-rc6
Message-ID: <160665707945.2808.5384034634184489471.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-29

up to:  7032908cd584: Merge tag 'irqchip-fixes-5.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


Two fixes for irqchip drivers:

  - Save and restore the GICV3 ITS state unconditionally on suspend/resume
    to handle firmware which fails to do so.

  - Use the correct index into the fwspec parameters to read the irq
    trigger type in the EXIU chip driver.

Thanks,

	tglx

------------------>
Chen Baozi (1):
      irqchip/exiu: Fix the index of fwspec for IRQ type

Xu Qiang (1):
      irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend


 drivers/irqchip/irq-gic-v3-its.c | 16 +++-------------
 drivers/irqchip/irq-sni-exiu.c   |  2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fec31931e11..4069c215328b 100644
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
@@ -4762,9 +4758,6 @@ static int its_save_disable(void)
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
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1d027623c776..abd011fcecf4 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -136,7 +136,7 @@ static int exiu_domain_translate(struct irq_domain *domain,
 		if (fwspec->param_count != 2)
 			return -EINVAL;
 		*hwirq = fwspec->param[0];
-		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	}
 	return 0;
 }

