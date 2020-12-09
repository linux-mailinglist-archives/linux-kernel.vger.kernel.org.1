Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC42D3B86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgLIGfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:35:00 -0500
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:39734
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728177AbgLIGe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:34:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyTK2JgN9YDx9ELPzDZArh5rYxvzg3h6vM2mq8q6UNihY8fNMJawLy9UesT3Ex23zbyV801qiYvBRQ+9Vm6A488F2P4/3nOlDT8+RxTN/kxL/H9PFy/pn791MJ657djvBBX2tXKdqSFEj5NwB51hRTDxaJMYiEzds6iMl9tgFHu1oS5r1gDystMRp7H1eq5T5d8H4fck/uPvQFyIIXEGjd70s5RHoVk7p7GLC3mmthvEmka5PQ11q2S3tkg2lDSEQDxnmbZZXFTx5wTBT3Q1F4plF1BvSwOYvcp+b3TQcLQ9O7/9iFCUo4ljSrseA/aAuNtDIlPTPuGWO2yKE4jV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=069niK7Af9dM4jz4/pu6lxXowc5x5ckLr2AYz1Ks/Ww=;
 b=NMwDe3rVBU4V66vdSbFf36YzRI0rNmx41QxNBQQb2x9xDO9q+Y1u6cOM5a+J1TGXMfMnf0jHzf+mdh4KgtlR9ME0CGRsAiuwfRw1yDJukb5H5ZbxuS/UUkdaRmenGADSFKnufD31RL8fFC6gtY0oEzmnAUsJNGWTgxzvAITHdQK1bOHPouj1cPGBFL4DPSmSVuRBGgTSdJCbYgSLK5O1JZcb7SJxErQdKStCAL2UConyURYlP3NvpIHF5zD15WtdldCyU2r7H2dmG2nbs9qEqfjjqISc2SsWcGAae5F+wFlJ69fzhbUqug5l7Bykj9jSR+dKDjOtm1wmMfgGbuS4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=069niK7Af9dM4jz4/pu6lxXowc5x5ckLr2AYz1Ks/Ww=;
 b=hyMVkFjojRfN+yNKuv5ntR/MdMr823H8P79jgHUApFaNf7AFg1RkySXlbYcdRsM+/RjJAE0WPHhaLYCl+CwDXkVimpRJODhoUDrHLj/jRTZmTuIfzvhjRn0Fi57967uS1iygyxbFsVyph4qo4swD+1ziunJcTQmfJBECB/0f0yk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB6144.eurprd04.prod.outlook.com (2603:10a6:803:fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 06:33:27 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 06:33:27 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: [PATCH v2 5/5] phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode support
Date:   Wed,  9 Dec 2020 14:24:28 +0800
Message-Id: <1607495069-10946-6-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
References: <1607495069-10946-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0148.apcprd06.prod.outlook.com
 (2603:1096:1:1f::26) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0148.apcprd06.prod.outlook.com (2603:1096:1:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 06:33:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dab6835-4c1b-412e-0c2e-08d89c0c5610
X-MS-TrafficTypeDiagnostic: VI1PR04MB6144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6144F50937CB2FC34517FB4998CC0@VI1PR04MB6144.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj2dPBXw0Zj2ZwNORJT6YbwwF29vc/o1zmXFOeVOe3ZdikZPlRi5G7MgQAqg46AbK81oEf8hDCu95JES1DlDo4h7RtKgJQQ/TcdBxieZv1sQFBsUKpA6GN1SPPGsPjUM9OWn+K/MNuTt8ySnq1MPfi+mtPPWjJh+QD/Y/2XHiWXLo308wZZHTiW5TmzDby3kNidbCqSDyd0+2y99zeUhfG/0QyHSxcqv2Vgh14uyN++sDjgKsNZVdhsy2AV2iZ4VCcDVaZoJBXwKdJtItppDbz6MaPqbUpLnKva9LbSA+Ey3UdK/jSJVTwHgbbP/JWWmTOXgWRmHd+7tr5x8SplNtXRcGgoHag5Ur5DGwXqNgP0lsxL4BlF5qiCClfaWbKyI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(2616005)(26005)(52116002)(5660300002)(186003)(16526019)(34490700003)(8936002)(8676002)(6486002)(66574015)(66476007)(2906002)(7416002)(956004)(36756003)(6512007)(508600001)(66946007)(83380400001)(4326008)(6506007)(86362001)(66556008)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azZGd3hJUitsU1EwbHJ5dEVTOU5ySy95bTJUSTd5clJOdFh0ZnFKWkVrNktJ?=
 =?utf-8?B?M05PRSs3blBRdERVcEU3dXkwbjg0aTc1dUcxRVFYczNsNEZ2aDR2NGtyQkJE?=
 =?utf-8?B?NksrZGg1SllGTHJuaDJJVTFMUVVzS1dUVENuT3BVRzlwNFQ3a0loYlg3d1VG?=
 =?utf-8?B?NWFKRWx4MHpoWVJXY2t3cHdCa0tIUDVJSi8vR1hHMDJYd24rakYxZ3JNb3NN?=
 =?utf-8?B?RXd4VnNTL3FHQmRwN3kvYXNUeHlmOWRVK25jL2pDSkNEdjJocHdWWVowUThD?=
 =?utf-8?B?MU5ZSnU0WnFzM1dsK0pDczlYdFh3bllsdmxSQUtZNjM2ZlNPcGlSYWpVZ3lL?=
 =?utf-8?B?K1V0dWgxNUN4dCsrYXJBU3F4OUd6Q2QvQll2UXdDRzkyQUZWS2xCWnoyQldw?=
 =?utf-8?B?NE9CNW11WTJzKzNndG84R3lBLzQ4cTFMYUxKUnBWcVlNZHFBdENWSnNKOEUz?=
 =?utf-8?B?Q1luWFNnMldJZXFmMy82Mk01MU5NVDhKU1FDZG5ZMTZPWEdNUG1TWEt3VDdH?=
 =?utf-8?B?WmYyM2tyYXI2aXgwVFVwdnR0YlNVMW9RQ1JTcGpxSnJaSEk2MFVnNHZMS1Yr?=
 =?utf-8?B?cElMOFIxQ2c0WmY3Sk9zNEdBcnJPRTcvSmxTd1FvSy8xcHZNUjl1SG5rMVFK?=
 =?utf-8?B?V3p4K0xiTy9KZDFvN2JjbnZrMWpFd1E2TjNvUWZncENaV1BnaTdYNEVzaTA0?=
 =?utf-8?B?NnJDdnROVlFjakJubllQWTcyYmg5aHpXaWxOYUQ2MlNjL3F3Tk9EWVREYUs1?=
 =?utf-8?B?d1JJSHhuWGc4MkxLanI3UFU1QXpvZVFaRmRoaC9BaHBYak1SNXVqc1NDMUo2?=
 =?utf-8?B?MHhCdnI3WlMvS0pqd291NDNSYjVUclJHNjRxSlBiTmtMMXhneFRPNzNwcmRt?=
 =?utf-8?B?WGs2K1grcmhRUGl1Z21sVUlCdnF0MHVxaE5PVlEydkJheHNuSW0xK0VpQytv?=
 =?utf-8?B?dlF0c05wQnlPYS80eVJQS0MyTSs1VlJwTmxsZm1WUy9pVWd0Q0xZeGRRSmNN?=
 =?utf-8?B?L0h0VnN6YlptV1ZOdUpmS2hUamdldkE1RWYwSWJ2bW83eVdKU0hTQnQvR0hF?=
 =?utf-8?B?L0Z5R1UyMlgyQVh3Y2FMMTY4Ry9VRjR3NW5aSE1LbzMzUjFUU29RRU8wY0s3?=
 =?utf-8?B?aElMLzhqNnNLVEFvOFlKMDJkeEdVRjE3b2FzR0FwV3hWWTdHSktCQWdGVUY5?=
 =?utf-8?B?WXFIZU1WblF1a0JvN1JQb0dPVnEwOFBuK3hWVktVU00vN2JwN1Ayd1QxTjcz?=
 =?utf-8?B?R1FhN0htZ0RTNEk5Szg2TktRR0FQZmNOekJGMWhSS2tFWWgvVlg4SkVDeWpL?=
 =?utf-8?Q?BrpQ5ZrqVF1O3SzhIpNIRtn6SAHx9NQ/Qg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 06:33:26.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dab6835-4c1b-412e-0c2e-08d89c0c5610
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0h6sMTd3Zk0wCaOES2NJ2KSautYcBLhD8KlWCQYSVKJMZCH1ApE85XsoWZrXRrKzpZB6pVfgmehnIKcQ7xziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8qxp SoC embeds a Mixel MIPI DPHY + LVDS PHY combo which supports
either a MIPI DSI display or a LVDS display.  The PHY mode is controlled
by SCU firmware and the driver would call a SCU firmware function to
configure the PHY mode.  The single LVDS PHY has 4 data lanes to support
a LVDS display.  Also, with a master LVDS PHY and a slave LVDS PHY, they
may work together to support a LVDS display with 8 data lanes(usually, dual
LVDS link display).  Note that this patch supports the LVDS PHY mode only
for the i.MX8qxp Mixel combo PHY, i.e., the MIPI DPHY mode is yet to be
supported, so for now error would be returned from ->set_mode() if MIPI
DPHY mode is passed over to it for the combo PHY.

Cc: Guido Günther <agx@sigxcpu.org>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Guido, I also print invalid PHY mode from mixel_dphy_configure().

v1->v2:
* Print invalid PHY mode in dmesg. (Guido)

 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 270 ++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b..25c97ad 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -4,17 +4,31 @@
  * Copyright 2019 Purism SPC
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/svc/misc.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+/* Control and Status Registers(CSR) */
+#define PHY_CTRL			0x00
+#define  CCM_MASK			GENMASK(7, 5)
+#define  CCM(n)				FIELD_PREP(CCM_MASK, (n))
+#define  CA_MASK			GENMASK(4, 2)
+#define  CA(n)				FIELD_PREP(CA_MASK, (n))
+#define  RFB				BIT(1)
+#define  LVDS_EN			BIT(0)
 
 /* DPHY registers */
 #define DPHY_PD_DPHY			0x00
@@ -55,8 +69,15 @@
 #define PWR_ON	0
 #define PWR_OFF	1
 
+#define MIN_VCO_FREQ 640000000
+#define MAX_VCO_FREQ 1500000000
+
+#define MIN_LVDS_REFCLK_FREQ 24000000
+#define MAX_LVDS_REFCLK_FREQ 150000000
+
 enum mixel_dphy_devtype {
 	MIXEL_IMX8MQ,
+	MIXEL_IMX8QXP,
 };
 
 struct mixel_dphy_devdata {
@@ -65,6 +86,7 @@ struct mixel_dphy_devdata {
 	u8 reg_rxlprp;
 	u8 reg_rxcdrp;
 	u8 reg_rxhs_settle;
+	bool is_combo;	/* MIPI DPHY and LVDS PHY combo */
 };
 
 static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
@@ -74,6 +96,10 @@ static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
 		.reg_rxlprp = 0x40,
 		.reg_rxcdrp = 0x44,
 		.reg_rxhs_settle = 0x48,
+		.is_combo = false,
+	},
+	[MIXEL_IMX8QXP] = {
+		.is_combo = true,
 	},
 };
 
@@ -95,8 +121,12 @@ struct mixel_dphy_cfg {
 struct mixel_dphy_priv {
 	struct mixel_dphy_cfg cfg;
 	struct regmap *regmap;
+	struct regmap *lvds_regmap;
 	struct clk *phy_ref_clk;
 	const struct mixel_dphy_devdata *devdata;
+	struct imx_sc_ipc *ipc_handle;
+	bool is_slave;
+	int id;
 };
 
 static const struct regmap_config mixel_dphy_regmap_config = {
@@ -317,7 +347,8 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
 	return 0;
 }
 
-static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+static int
+mixel_dphy_configure_mipi_dphy(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
 	struct mixel_dphy_cfg cfg = { 0 };
@@ -345,15 +376,121 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int
+mixel_dphy_configure_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	struct phy_configure_opts_lvds *lvds_opts = &opts->lvds;
+	unsigned long data_rate;
+	unsigned long fvco;
+	u32 rsc;
+	u32 co;
+	int ret;
+
+	priv->is_slave = lvds_opts->is_slave;
+
+	/* LVDS interface pins */
+	regmap_write(priv->lvds_regmap, PHY_CTRL, CCM(0x5) | CA(0x4) | RFB);
+
+	/* enable MODE8 only for slave LVDS PHY */
+	rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
+	ret = imx_sc_misc_set_control(priv->ipc_handle, rsc, IMX_SC_C_DUAL_MODE,
+				      lvds_opts->is_slave);
+	if (ret) {
+		dev_err(&phy->dev, "Failed to configure MODE8: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Choose an appropriate divider ratio to meet the requirement of
+	 * PLL VCO frequency range.
+	 *
+	 *  -----  640MHz ~ 1500MHz   ------------      ---------------
+	 * | VCO | ----------------> | CO divider | -> | LVDS data rate|
+	 *  -----       FVCO          ------------      ---------------
+	 *                            1/2/4/8 div     7 * differential_clk_rate
+	 */
+	data_rate = 7 * lvds_opts->differential_clk_rate;
+	for (co = 1; co <= 8; co *= 2) {
+		fvco = data_rate * co;
+
+		if (fvco >= MIN_VCO_FREQ)
+			break;
+	}
+
+	if (fvco < MIN_VCO_FREQ || fvco > MAX_VCO_FREQ) {
+		dev_err(&phy->dev, "VCO frequency %lu is out of range\n", fvco);
+		return -ERANGE;
+	}
+
+	/*
+	 * CO is configurable, while CN and CM are not,
+	 * as fixed ratios 1 and 7 are applied respectively.
+	 */
+	phy_write(phy, __ffs(co), DPHY_CO);
+
+	/* set reference clock rate */
+	clk_set_rate(priv->phy_ref_clk, lvds_opts->differential_clk_rate);
+
+	return ret;
+}
+
+static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY)
+		return mixel_dphy_configure_mipi_dphy(phy, opts);
+	else if (phy->attrs.mode == PHY_MODE_LVDS)
+		return mixel_dphy_configure_lvds_phy(phy, opts);
+
+	dev_err(&phy->dev,
+		"Failed to configure PHY with invalid PHY mode: %d\n",
+							phy->attrs.mode);
+	return -EINVAL;
+}
+
+static int
+mixel_dphy_validate_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct phy_configure_opts_lvds *lvds_cfg = &opts->lvds;
+
+	if (lvds_cfg->bits_per_lane_and_dclk_cycle != 7) {
+		dev_err(&phy->dev, "Invalid bits per LVDS data lane: %u\n",
+					lvds_cfg->bits_per_lane_and_dclk_cycle);
+		return -EINVAL;
+	}
+
+	if (lvds_cfg->lanes != 4) {
+		dev_err(&phy->dev, "Invalid LVDS data lanes: %u\n",
+						lvds_cfg->lanes);
+		return -EINVAL;
+	}
+
+	if (lvds_cfg->differential_clk_rate < MIN_LVDS_REFCLK_FREQ ||
+	    lvds_cfg->differential_clk_rate > MAX_LVDS_REFCLK_FREQ) {
+		dev_err(&phy->dev,
+			"Invalid LVDS differential clock rate: %lu\n",
+					lvds_cfg->differential_clk_rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			       union phy_configure_opts *opts)
 {
-	struct mixel_dphy_cfg cfg = { 0 };
+	if (mode == PHY_MODE_MIPI_DPHY) {
+		struct mixel_dphy_cfg mipi_dphy_cfg = { 0 };
 
-	if (mode != PHY_MODE_MIPI_DPHY)
-		return -EINVAL;
+		return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy,
+							&mipi_dphy_cfg);
+	} else if (mode == PHY_MODE_LVDS) {
+		return mixel_dphy_validate_lvds_phy(phy, opts);
+	}
 
-	return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
+	dev_err(&phy->dev,
+		"Failed to validate PHY with invalid PHY mode: %d\n", mode);
+	return -EINVAL;
 }
 
 static int mixel_dphy_init(struct phy *phy)
@@ -373,27 +510,75 @@ static int mixel_dphy_exit(struct phy *phy)
 	return 0;
 }
 
-static int mixel_dphy_power_on(struct phy *phy)
+static int mixel_dphy_power_on_mipi_dphy(struct phy *phy)
 {
 	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
 	u32 locked;
 	int ret;
 
-	ret = clk_prepare_enable(priv->phy_ref_clk);
-	if (ret < 0)
-		return ret;
-
 	phy_write(phy, PWR_ON, DPHY_PD_PLL);
 	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
 				       locked, PLL_LOCK_SLEEP,
 				       PLL_LOCK_TIMEOUT);
 	if (ret < 0) {
 		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
-		goto clock_disable;
+		return ret;
 	}
 	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
 
 	return 0;
+}
+
+static int mixel_dphy_power_on_lvds_phy(struct phy *phy)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	u32 locked;
+	int ret;
+
+	regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, LVDS_EN);
+
+	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
+	phy_write(phy, PWR_ON, DPHY_PD_PLL);
+
+	/* do not wait for slave LVDS PHY being locked */
+	if (priv->is_slave)
+		return 0;
+
+	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
+				       locked, PLL_LOCK_SLEEP,
+				       PLL_LOCK_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&phy->dev, "Could not get LVDS PHY lock (%d)!\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mixel_dphy_power_on(struct phy *phy)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(priv->phy_ref_clk);
+	if (ret < 0)
+		return ret;
+
+	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY) {
+		ret = mixel_dphy_power_on_mipi_dphy(phy);
+	} else if (phy->attrs.mode == PHY_MODE_LVDS) {
+		ret = mixel_dphy_power_on_lvds_phy(phy);
+	} else {
+		dev_err(&phy->dev,
+			"Failed to power on PHY with invalid PHY mode: %d\n",
+							phy->attrs.mode);
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto clock_disable;
+
+	return 0;
 clock_disable:
 	clk_disable_unprepare(priv->phy_ref_clk);
 	return ret;
@@ -406,16 +591,52 @@ static int mixel_dphy_power_off(struct phy *phy)
 	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
 	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
 
+	if (phy->attrs.mode == PHY_MODE_LVDS)
+		regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, 0);
+
 	clk_disable_unprepare(priv->phy_ref_clk);
 
 	return 0;
 }
 
+static int mixel_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	/* Currently, MIPI DPHY mode only, if it's not a combo PHY. */
+	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
+		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
+		return -EINVAL;
+	}
+
+	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
+		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
+		return -EINVAL;
+	}
+
+	if (priv->devdata->is_combo) {
+		u32 rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
+
+		ret = imx_sc_misc_set_control(priv->ipc_handle,
+					      rsc, IMX_SC_C_MODE,
+					      mode == PHY_MODE_LVDS);
+		if (ret) {
+			dev_err(&phy->dev,
+				"Failed to set PHY mode via SCU ipc: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct phy_ops mixel_dphy_phy_ops = {
 	.init = mixel_dphy_init,
 	.exit = mixel_dphy_exit,
 	.power_on = mixel_dphy_power_on,
 	.power_off = mixel_dphy_power_off,
+	.set_mode = mixel_dphy_set_mode,
 	.configure = mixel_dphy_configure,
 	.validate = mixel_dphy_validate,
 	.owner = THIS_MODULE,
@@ -424,6 +645,8 @@ static const struct phy_ops mixel_dphy_phy_ops = {
 static const struct of_device_id mixel_dphy_of_match[] = {
 	{ .compatible = "fsl,imx8mq-mipi-dphy",
 	  .data = &mixel_dphy_devdata[MIXEL_IMX8MQ] },
+	{ .compatible = "fsl,imx8qxp-mipi-dphy",
+	  .data = &mixel_dphy_devdata[MIXEL_IMX8QXP] },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
@@ -436,6 +659,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	struct mixel_dphy_priv *priv;
 	struct phy *phy;
 	void __iomem *base;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -467,6 +691,30 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 	dev_dbg(dev, "phy_ref clock rate: %lu\n",
 		clk_get_rate(priv->phy_ref_clk));
 
+	if (priv->devdata->is_combo) {
+		priv->lvds_regmap =
+			syscon_regmap_lookup_by_phandle(np, "fsl,syscon");
+		if (IS_ERR(priv->lvds_regmap)) {
+			ret = PTR_ERR(priv->lvds_regmap);
+			dev_err_probe(dev, ret, "Failed to get LVDS regmap\n");
+			return ret;
+		}
+
+		priv->id = of_alias_get_id(np, "mipi_dphy");
+		if (priv->id < 0) {
+			dev_err(dev, "Failed to get phy node alias id: %d\n",
+								 priv->id);
+			return priv->id;
+		}
+
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret) {
+			dev_err_probe(dev, ret,
+				      "Failed to get SCU ipc handle\n");
+			return ret;
+		}
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
-- 
2.7.4

