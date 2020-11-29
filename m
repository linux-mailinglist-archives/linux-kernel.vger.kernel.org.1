Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE42C7976
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgK2NxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgK2NxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:53:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D737B2085B;
        Sun, 29 Nov 2020 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606657946;
        bh=AWUsaV/O0BnYvYBo6v8gTmwrIs4O7Jev5ha0ZPDOqqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aj9VaoBtzufGjyFO1//vE8gRHqLmDfWkxeXucMIYElbTEqBBb28P/6G5eOUV0cdTy
         dHDKc5x5tz15IX3c6G9cJtC71zjiu7MdxETp30P3egyEqg/9hAbGX2bund4H8BGBC+
         WPj72DnZ0eApw2zDZH7+TmVlvggzV7hK62wsnMGo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjN7o-00ETZs-6M; Sun, 29 Nov 2020 13:52:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, john.garry@huawei.com
Subject: [PATCH 3/3] irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI bridge
Date:   Sun, 29 Nov 2020 13:52:08 +0000
Message-Id: <20201129135208.680293-4-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201129135208.680293-1-maz@kernel.org>
References: <20201129135208.680293-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An aliasing PCI bridge is another case where we should flag the
corresponding allocation as "proxied", as MSIs are coming with
the bridge's RID, and not the originating device's.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 87711e0f8014..ad2810c017ed 100644
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
-- 
2.28.0

