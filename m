Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE142D91D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 03:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438014AbgLNCtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 21:49:24 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:53840 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgLNCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:48:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 13DFC20138CB;
        Mon, 14 Dec 2020 10:47:43 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8nXg4Wu3YEwY; Mon, 14 Dec 2020 10:47:42 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id EF58C20138C6;
        Mon, 14 Dec 2020 10:47:42 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id F40DCC01FAD;
        Mon, 14 Dec 2020 10:47:42 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id B5C1C2000CF; Mon, 14 Dec 2020 10:47:42 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/3] phy: rockchip: emmc, add vendor prefix to optional dts properties
Date:   Mon, 14 Dec 2020 10:47:17 +0800
Message-Id: <20201214024720.24656-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
References: <20201214024720.24656-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the implementation add "rockchip," vendor prefix for the
optional dts properties. Prefix referred from vendor-prefixes.yaml

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 1e424f263e7a..2fdbc8495798 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -377,13 +377,13 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_DISABLE;
 	rk_phy->output_tapdelay_select = PHYCTRL_OTAPDLYSEL_DEFAULT;
 
-	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
+	if (!of_property_read_u32(dev->of_node, "rockchip,drive-impedance-ohm", &val))
 		rk_phy->drive_impedance = convert_drive_impedance_ohm(pdev, val);
 
-	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
+	if (of_property_read_bool(dev->of_node, "rockchip,enable-strobe-pulldown"))
 		rk_phy->enable_strobe_pulldown = PHYCTRL_REN_STRB_ENABLE;
 
-	if (!of_property_read_u32(dev->of_node, "output-tapdelay-select", &val)) {
+	if (!of_property_read_u32(dev->of_node, "rockchip,output-tapdelay-select", &val)) {
 		if (val <= PHYCTRL_OTAPDLYSEL_MAXVALUE)
 			rk_phy->output_tapdelay_select = val;
 		else
-- 
2.20.1

