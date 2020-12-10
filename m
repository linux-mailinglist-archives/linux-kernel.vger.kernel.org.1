Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF12D551E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgLJIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:05:45 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:38380 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbgLJIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:05:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D08EF2290B46;
        Thu, 10 Dec 2020 16:04:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hmHa6fFH6lqd; Thu, 10 Dec 2020 16:04:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id AF0E82290B45;
        Thu, 10 Dec 2020 16:04:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id A2428C01FB5;
        Thu, 10 Dec 2020 16:04:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 5568D2000CF; Thu, 10 Dec 2020 16:04:57 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-rockchip@lists.infradead.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: [PATCH v3] phy: rockchip-emmc: emmc_phy_init() always return 0
Date:   Thu, 10 Dec 2020 16:04:54 +0800
Message-Id: <20201210080454.17379-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rockchip_emmc_phy_init() return variable is not set with the error value
if clk_get() failed. 'emmcclk' is optional, thus use clk_get_optional()
and if the return value != NULL make error processing and set the
return code accordingly.

Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v3 - IS_ERROR() already return false if rk_phy->emmcclk == NULL
     add Reviewed tag
v2 - use clk_get_optional

 drivers/phy/rockchip/phy-rockchip-emmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 48e2d75b1004..9d8123f7fd07 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -245,15 +245,17 @@ static int rockchip_emmc_phy_init(struct phy *phy)
 	 * - SDHCI driver to get the PHY
 	 * - SDHCI driver to init the PHY
 	 *
-	 * The clock is optional, so upon any error we just set to NULL.
+	 * The clock is optional, using clk_get_optional() to get the clock
+	 * and do error processing if the return value != NULL
 	 *
 	 * NOTE: we don't do anything special for EPROBE_DEFER here.  Given the
 	 * above expected use case, EPROBE_DEFER isn't sensible to expect, so
 	 * it's just like any other error.
 	 */
-	rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
+	rk_phy->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
 	if (IS_ERR(rk_phy->emmcclk)) {
-		dev_dbg(&phy->dev, "Error getting emmcclk: %d\n", ret);
+		ret = PTR_ERR(rk_phy->emmcclk);
+		dev_err(&phy->dev, "Error getting emmcclk: %d\n", ret);
 		rk_phy->emmcclk = NULL;
 	}
 
-- 
2.20.1

