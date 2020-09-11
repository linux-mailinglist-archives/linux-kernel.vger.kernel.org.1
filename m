Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5727D265F65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgIKMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 08:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgIKMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:16:50 -0400
Received: from mail.kernel.org (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A5722208;
        Fri, 11 Sep 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826608;
        bh=MBCzXyqmVaFHuycK3C+dXugnd1nA0lv2+VD53A/ZP5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qw1oQI3hRS0LGQNtIvnkUahs/rMCFylB6gi12LiVjvAJE4eDUoLzvd2admYxqZoiJ
         iOkRmUyx6MMRIl0berLaFfGpOo4tM3crl1fUvzQdZ5sZygux2D0UJC1vOBUFdYBwdl
         fUaReSOp8R0NgBFfeh86mGLafj2tE9teLx3iVhjY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGhyw-0006WL-1d; Fri, 11 Sep 2020 14:16:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "John Stultz" <john.stultz@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND 6/8] phy: hisilicon: phy-hi3670-usb3: change some DT properties
Date:   Fri, 11 Sep 2020 14:16:42 +0200
Message-Id: <c81a181e0fa800c4cac94d1c9d789b63b5966667.1599826421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599826421.git.mchehab+huawei@kernel.org>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some changes at the DT properties in order to make it
follow the phy-hi3660-usb3 example and to simplify
usb3-phy-tx-vboost-lvl name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/phy/hisilicon/phy-hi3670-usb3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index cb0bfcbbfbfa..42dbc20a0b9a 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -627,18 +627,18 @@ static int hi3670_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->sctrl);
 	}
 
-	priv->usb31misc = syscon_regmap_lookup_by_phandle(dev->of_node,
-							  "hisilicon,usb31-misc-syscon");
+	/* node of hi3670 phy is a sub-node of usb3_otg_bc */
+	priv->usb31misc = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(priv->usb31misc)) {
-		dev_err(dev, "no hisilicon,usb31-misc-syscon\n");
+		dev_err(dev, "no hisilicon,usb3-otg-bc-syscon\n");
 		return PTR_ERR(priv->usb31misc);
 	}
 
-	if (of_property_read_u32(dev->of_node, "eye-diagram-param",
+	if (of_property_read_u32(dev->of_node, "hisilicon,eye-diagram-param",
 				 &priv->eye_diagram_param))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_PARAM;
 
-	if (of_property_read_u32(dev->of_node, "usb3-phy-tx-vboost-lvl",
+	if (of_property_read_u32(dev->of_node, "hisilicon,tx-vboost-lvl",
 				 &priv->tx_vboost_lvl))
 		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
-- 
2.26.2

