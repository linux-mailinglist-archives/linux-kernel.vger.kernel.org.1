Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0D2DA5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgLOBpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 20:45:23 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:59412 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgLOBpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 20:45:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id E750C20138CB;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 863XrYKeHdKL; Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id CEC8320138C7;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id D24F6C01FAD;
        Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id C67602000CF; Tue, 15 Dec 2020 09:44:14 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/2] phy: rockchip: emmc, add vendor prefix to dts properties
Date:   Tue, 15 Dec 2020 09:44:08 +0800
Message-Id: <20201215014409.905-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
References: <20201215014409.905-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the implementation add "rockchip," vendor prefix for the
optional dts properties. Prefix referred from vendor-prefixes.yaml.
Follow up with
commit 8b5c2b45b8f0a ("phy: rockchip: set pulldown for strobe line in dts")
commit a8cef928276bb ("phy: rockchip-emmc: output tap delay dt property")

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 1e424f263e7a..860b2fbbb092 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -380,10 +380,10 @@ static int rockchip_emmc_phy_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
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

