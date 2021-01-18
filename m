Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF292F97CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbhARCQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:16:15 -0500
Received: from foss.arm.com ([217.140.110.172]:48734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731180AbhARCLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:11:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 497011477;
        Sun, 17 Jan 2021 18:10:05 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DB373F719;
        Sun, 17 Jan 2021 18:10:03 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 16/21] phy: sun4i-usb: Add support for the H616 USB PHY
Date:   Mon, 18 Jan 2021 02:08:43 +0000
Message-Id: <20210118020848.11721-17-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210118020848.11721-1-andre.przywara@arm.com>
References: <20210118020848.11721-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY used in the Allwinner H616 SoC inherits some traits from its
various predecessors: it has four full PHYs like the H3, needs some
extra bits to be set like the H6, and clears a different bit in the
PMU_UNK1 register like the A100.

Name all those properties in a new config struct and assign a new
compatible name to it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 539209fe3468..e71d6b8ccf16 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -964,6 +964,16 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.missing_phys = BIT(1) | BIT(2),
 };
 
+static const struct sun4i_usb_phy_cfg sun50i_h616_cfg = {
+	.num_phys = 4,
+	.type = sun50i_h6_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.phy0_dual_route = true,
+	.hci_phy_ctl_siddq = BIT(3),
+};
+
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
@@ -978,6 +988,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
+	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.17.5

