Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5925D5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgIDKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbgIDKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:36 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12D9208B3;
        Fri,  4 Sep 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=MBCzXyqmVaFHuycK3C+dXugnd1nA0lv2+VD53A/ZP5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adkuEDCsoETqnM+MQha+LfGXoeEELvmxPuT9gTHURq++BK3jWUAQWS8gXYp4hT2ed
         YtQu1QvBUM9pVKf6Ko2iAwueZYjUD/Rxr7Tdb7qlCdcmQQ1ZQFIRTjdS84L4WkIjC2
         HQxm4ZHX9KkDw/S/MgOb0ZjrkcIUDXB8v3Dwtnm4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005SvG-Qc; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC 05/10] phy: hisilicon: phy-hi3670-usb3: change some DT properties
Date:   Fri,  4 Sep 2020 12:23:27 +0200
Message-Id: <c68689d4e3901c42a045bc8eb82840868dad579b.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
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

