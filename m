Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F192D7868
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406464AbgLKPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405385AbgLKO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:27 -0500
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8ncxYu+LcgOgQlBTC2mTy2zun3cadnzshLvN5xtE/A=;
        b=mHBr6qINZse/W5rKy+nZPgiX/GMhPDYTujgRND2IXhjp5j5YAp3M0sH/os8Qhikxg1wqhR
        p57uXkAqlBx5cvxLGvjZCYR4hR+D6/7TmwBEkH6tlMnBFsVjcnatGcoYVt7Jq1J7QZsOQ2
        qXwnaaGjfKKczpho+VvCGlFmAOJ4YiT0oDRgTiIsvDbA75qDam+cdfO0LmzNBPdBkXc/zB
        YdvfldEVjX2wuyMaGKWWqRS+UN2uZTUYk0UCqjthnZvccKetqgl/yppVBk3wGTXrZHpxqg
        lw/87+agKdXHrWtY44Xfml5kAEQ88tBkxgrEP2SfizhjFk/hFWCu6Qdfae6naQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8ncxYu+LcgOgQlBTC2mTy2zun3cadnzshLvN5xtE/A=;
        b=JB4geLCYVBpdBao76KQHcYCzXCadGLJjDHLWVMkkUyMDQgXLNs2z/FISPT7jekDRERKxfd
        rnqWTO46CQtwvhAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Flag device
 allocation as proxied if behind a PCI bridge
Cc:     Marc Zyngier <maz@kernel.org>, John Garry <john.garry@huawei.com>,
        tglx@linutronix.de
In-Reply-To: <20201129135208.680293-4-maz@kernel.org>
References: <20201129135208.680293-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160769872245.3364.12465233915684170533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     34dd263fce3114147f21698f8e55e05b9e8185bd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/34dd263fce3114147f21698f8e55e05b9e8185bd
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 29 Nov 2020 13:52:08 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI bridge

An aliasing PCI bridge is another case where we should flag the
corresponding allocation as "proxied", as MSIs are coming with
the bridge's RID, and not the originating device's.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/20201129135208.680293-4-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 87711e0..ad2810c 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -67,11 +67,16 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	/*
 	 * If pdev is downstream of any aliasing bridges, take an upper
 	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
 	 */
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev != pdev && alias_dev->subordinate)
-		pci_walk_bus(alias_dev->subordinate, its_pci_msi_vec_count,
-			     &alias_count);
+	if (alias_dev != pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
