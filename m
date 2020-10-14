Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDFD28E117
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgJNNRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgJNNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:17:07 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B0C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:17:07 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id fpH42300F4C55Sk06pH4Al; Wed, 14 Oct 2020 15:17:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgeO-0007y9-83; Wed, 14 Oct 2020 15:17:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSgeO-0004ke-6Q; Wed, 14 Oct 2020 15:17:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
Date:   Wed, 14 Oct 2020 15:17:03 +0200
Message-Id: <20201014131703.18021-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MStar interrupt controller is only found on MStar, SigmaStar, and
Mediatek SoCs.  Hence add dependencies on ARCH_MEDIATEK and
ARCH_MSTARV7, to prevent asking the user about the MStar interrupt
controller driver when configuring a kernel without support for MStar,
SigmaStar, and Mediatek SoCs.

Fixes: ad4c938c92af9130 ("irqchip/irq-mst: Add MStar interrupt controller support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c6098eee0c7cf217..500b16648e5183c4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -591,6 +591,7 @@ config LOONGSON_PCH_MSI
 
 config MST_IRQ
 	bool "MStar Interrupt Controller"
+	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
 	default ARCH_MEDIATEK
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-- 
2.17.1

