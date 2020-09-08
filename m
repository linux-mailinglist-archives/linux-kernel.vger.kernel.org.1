Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D550260FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIHKcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgIHK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:29:10 -0400
Received: from mail.kernel.org (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48B9521D7B;
        Tue,  8 Sep 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560940;
        bh=MBCzXyqmVaFHuycK3C+dXugnd1nA0lv2+VD53A/ZP5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtXbc+5Agb/ol2lTiifbOTcsomOsEXK864/0YgtbKQwe54/bf7CVsI4XpHl0Ie/oX
         5JM09d+rrZisoglG16TRMelkF71IrCKe9F3kZPRuRqvNxEOilz3OKkFaX+Ygqe5li/
         AUchz0ZYwFmifY3gT42yRXoj9b+d467vZYexb2HQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFary-00B3yL-6b; Tue, 08 Sep 2020 12:28:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] phy: hisilicon: phy-hi3670-usb3: change some DT properties
Date:   Tue,  8 Sep 2020 12:28:39 +0200
Message-Id: <89926bfe0da570f1cd03ff675aa5146ea84b33d6.1599559318.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599559318.git.mchehab+huawei@kernel.org>
References: <cover.1599559318.git.mchehab+huawei@kernel.org>
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

