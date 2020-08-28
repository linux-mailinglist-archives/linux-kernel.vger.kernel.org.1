Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64DF2561EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 22:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgH1UUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 16:20:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37380 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgH1UUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:20:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07SKK7fS026600;
        Fri, 28 Aug 2020 15:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598646007;
        bh=M57k5GNdOhuFYfIUg8vfITWLthlh55K2f8tW0oPt63g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TIsf2v01OIoH7tqn20ud4cjGnDHgEI/WZxoCKCtN8Lz2JEj56S6TCYvaY/CsasCTx
         /iofyE4dS3h+Ykv23LKLAynq1ityIA6GZT7ZNN5J/7zB6YnhphZYb0kctS2RVe4QKK
         s9BYdnUfwjYHYycPsynbKNQ6A3YhCQUkm8jq4zNs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SKK7QF078641;
        Fri, 28 Aug 2020 15:20:07 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 15:20:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 15:20:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SKK5o5035312;
        Fri, 28 Aug 2020 15:20:06 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/3] phy: ti: gmii-sel: use features mask during init
Date:   Fri, 28 Aug 2020 23:19:42 +0300
Message-ID: <20200828201943.29155-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828201943.29155-1-grygorii.strashko@ti.com>
References: <20200828201943.29155-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use features mask during PHYs initialization to simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index d4b02ad023b2..a6b7f22e85c4 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -147,13 +147,9 @@ static const
 struct reg_field phy_gmii_sel_fields_dra7[][PHY_GMII_SEL_LAST] = {
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 0, 1),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 4, 5),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 };
 
@@ -174,8 +170,6 @@ static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] = {
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4040, 0, 1),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 };
 
@@ -266,7 +260,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	if_phy->fields[PHY_GMII_SEL_PORT_MODE] = regfield;
 
 	field = *fields++;
-	if (field.reg != (~0)) {
+	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
 						   field);
@@ -278,7 +272,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	}
 
 	field = *fields;
-	if (field.reg != (~0)) {
+	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
 						   field);
-- 
2.17.1

