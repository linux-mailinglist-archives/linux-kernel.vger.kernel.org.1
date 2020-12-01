Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241472C959B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgLADLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:11:09 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51584 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLADLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:11:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id DF2B7200D28A;
        Tue,  1 Dec 2020 11:10:21 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yRNd_2PMXOKD; Tue,  1 Dec 2020 11:10:21 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C5B26200D287;
        Tue,  1 Dec 2020 11:10:21 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id B5F1AC019E2;
        Tue,  1 Dec 2020 11:10:21 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 888CE200756; Tue,  1 Dec 2020 11:10:21 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: rockchip-emmc: emmc_phy_init() always return 0
Date:   Tue,  1 Dec 2020 11:10:14 +0800
Message-Id: <20201201031015.23314-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rockchip_emmc_phy_init() return variable is not set with the error value
if clk_get() failed. The debug message print 0 on error and the function
always return 0.
Fix it using PTR_ERR().

Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 48e2d75b1004..75faee5c0d27 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -253,6 +253,7 @@ static int rockchip_emmc_phy_init(struct phy *phy)
 	 */
 	rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
 	if (IS_ERR(rk_phy->emmcclk)) {
+		ret = PTR_ERR(rk_phy->emmcclk);
 		dev_dbg(&phy->dev, "Error getting emmcclk: %d\n", ret);
 		rk_phy->emmcclk = NULL;
 	}
-- 
2.20.1

