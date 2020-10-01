Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3345B27FF44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbgJAMfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:35:16 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com ([40.107.15.120]:62366
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732026AbgJAMfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2DfCL/fIRoXMQeoUm6q8tKqjjWK+K9FQcDUDYxCKfIWG7303Wuv83Oq6QWdQU8U5RPVpci1vdPnrcF9ugikjTvYQnM4H1trY1IGENDWMrhHfWjKw4vARL4YIq/F5VjeI/Ayb2UV9/jwIm/2tvY2sG/VIf+GTjf/+bSL5+fRVHXLsTXATcK53H1eUcqE3cYlmPjsmcv9ZH3ZvqsRvdscnAVWpjzSKco9LegM4FieSLFYLtaxXvKk6lHHIs20d8cQ1aVxStBxtmPXWK/1CDFzeD0W9YzkfYeSAhSorkS+pGDs1hsEeULvkg/VSpJvcnWg62oGprvSGgG4WNRYBL4QzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+y5ChoAOR2C4HfBoMc5WIJOfWlVfHUYy34gOsImJU4=;
 b=j0qWxocZrS6vKQ8R6VoezUbDR0RAShzNVe9N5oYAhwAkoEw4L66o8xiHf3Swm3vd+NNPhqcHu1ZTm5+mt7VPRH6175SSZbB72CXogtTI/rjwggWPqJZxgt1wwl23tRyydhJVSTUS99CoAoWZOeyz0edoPvVKlf43jw2eNnUv2hzBzUUG9lv+cdrOdFAxF/Fz59I8tRPBXf7ys6gFhaCr31PP8zDHzuBqxZtrUFrxIu/nvtyNB4+G5Z42K2oeoQTphBgU/yW/rgSoK6Q9BslXLAIrnRLohoEQMQj4r6m7QWo9arDv/0AtmAj4uT6jesHlA3bENu8cYYleZRvMGZ3nBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+y5ChoAOR2C4HfBoMc5WIJOfWlVfHUYy34gOsImJU4=;
 b=n7knwmD7U+sUYOiNA5vKtth8QYASOvyx5J9ugDtyOBJfmfTc9TBUBTMVXif8uJFjPZOURROaNDc2m3ilD1uCDiWsqx88VGPdpVAk2dkqzdccJMCk51jVlPSKHVLhWpFbkQw3uF7GguiN5NZY+ZZvwDEa9yF+8/WpVQATZpRC3QY=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 12:35:13 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 12:35:13 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: pca9450: Add SD_VSEL GPIO for LDO5
Date:   Thu,  1 Oct 2020 14:34:31 +0200
Message-Id: <20201001123447.1610-1-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5P194CA0018.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::28) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM5P194CA0018.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 12:35:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f4b365-3c22-48d0-c9cb-08d86606713d
X-MS-TrafficTypeDiagnostic: AM0PR10MB3252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB3252B2283F47A4DC63E8ED02E9300@AM0PR10MB3252.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqKOQH8kIiCdNNzUVR2wORUCF8ekArVKc2TFRkdJ3Ievx2BWnZluj8icwBn37rJozT2nLuV/MA4qY8lzAIhRwEvH1ySptq4eOdQTrbtXJ5NK5QdNk9GatFs7nqHVZItAFFRgsZnKHmUoB6zpmpTLfk+CAMJOMNHc1hKHUtN72q2T2lIenXKLyfwD+3GU8K4Ce5hsF0SbgVVmD6Uh6YJKuLLcu6Crqti1b9otu8PFFb2liY9UvSxHHZRoUX2O8wvBt/B+O6XhdcHLMYKFWEgJXjway+oW+V5TWVKiphSCkwzynjIgC46dG1D140Nwy10HQPMbi+XYTYQV2AvD5N9zew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(66476007)(66556008)(6512007)(8676002)(186003)(110136005)(16526019)(478600001)(52116002)(1076003)(4326008)(86362001)(316002)(2906002)(8936002)(36756003)(956004)(6506007)(2616005)(7416002)(6666004)(5660300002)(6486002)(26005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QPK2FMe8+GoQsZ/UAl9owNF/vrxmHWujmE/wdKPs6XIZolhDnsyxx58m5f1q/HUOtjwKztovs4nLRcb4GEdRieOePI9usm84VndHQNVRgXDXsIvCKt1NautDlocchRKJPsu0E8HtZyZeXAzF5CtqaIL7Xwzq/W7jxspayrp/eEfvAjpaFY983DGJ/VXt4a2VsuL7a/wo13dcWVJhF93Pf/kWPd1NtC+Z1wE+cet7j8tL91L/lhUP2t64TmrjSPMbkIFJW1hZ+Vtg7Iu6mVCxZL8aC4g3wmJlnRuYs7JhwzS9Cvfxk6tGM1K2Nz/1yfbScFPKStYGJSiAXF8bPzMU+8ITKre+hjau07UdJWT1jfhAlr+pEIf2TFUZF5bz7Gw82UJCTqau6sWQb+KD3ZC2YA3K49RVDHwlHXC4Qz73vOhb/4qz5Q0YisSzljDM0Q4cnRB8jCK1jDMtS91UvEM3/TFaIsn0PColoZf7yiVN2LIsu0Id/gRK574IErl+aZ0nKY+rEGirSjQ8W+xvlsIBMW+i1u+1Rv+jN9PGI+mHmWXFmz0ljn5cLoEQ+930GXsYm4swTAYoIcJG5lawe3yQZE0pEKm8moKfUVCm5aJnUexHc5QsNE8o25pj8cKlQa/X01atiE8iU3uKV3uljtuQSQ==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f4b365-3c22-48d0-c9cb-08d86606713d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 12:35:13.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKBj/jaQD++fL0Yi90+yu6BHEXNAEj6N0zsxiO/ogoxZ/7LNXy9cUdayZGAgF5rO/hX62IWWuEV4ablJUTmIFetWk19Ayf+KRmniN/N0BvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

LDO5 has two separate control registers. LDO5CTRL_L is used if the
input signal SD_VSEL is low and LDO5CTRL_H if it is high.
The current driver implementation only uses LDO5CTRL_H. To make this
work on boards that have SD_VSEL connected to a GPIO, we add support
for specifying an optional GPIO and setting it to high at probe time.

In the future we might also want to add support for boards that have
SD_VSEL set to a fixed low level. In this case we need to change the
driver to be able to use the LDO5CTRL_L register.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/pca9450-regulator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index eb5822bf53e0..fec7acc606f4 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -32,6 +33,7 @@ struct pca9450_regulator_desc {
 struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -795,6 +797,18 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/*
+	 * The driver uses the LDO5CTRL_H register to control the LDO5 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pca9450->sd_vsel_gpio)) {
+		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
+		return ret;
+	}
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
-- 
2.17.1

