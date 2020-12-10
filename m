Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B009A2D55F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgLJI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:59:59 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:19833
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731914AbgLJI7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:59:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj8Wun6zzz8o7DpbzyBcfwPUWlk7Lam4DXrL+5wyNM+K7X2cB3T52VB0TQSi9MVBmamPCQ8+Mvv7ZAhSsuec9Axya428nJ00J7KSnN/8PPfEH0w2+oBjecFDiIqC26uri0Yl+z3/9bY4EeEowkSbpe7A8t1eW1kAAC7fnW2XXpfkuWL2SA1KLsnUOpVhXZZM7qcr/N/MMCuRCzwf9R+nF7tH9MBO2a1IdganS0yitaVh64K37Ak/lcO8WMQIlEWR5bBZmEjVjKUQxojsiQYOsgal/fi62j/5WYuOylfPTXYDVWkTBgksLtgSO4WRIELv2wS0poOi2uxZnbijn9bRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVuQWmGUV0cSDhGg48HMjx3epfSW9KRbfbpBXooC59Q=;
 b=CQVtkE9hNvJbRbNqFhSfNsdSyaPGt6CxQwNFKfvEA4Uvcr0jbpwTDcsvAIY5lE/CHOz/VsR3yGJvlmpsX8UeHPsQL3lGtpns4X/CEHede0z/TXKmyFEFmON3Vy20NmazMQbu1N52OtiEQ/xXgAx3hGc53pVXFG0R+4LpQT2tjJZi/GJc64MDWb4hollibgzvdBhWc/5q5e0zlWv5VeyReOYjJ44WY4NR3Ods1q6wByAX0fls1D2oSc5COiqraXS8dZ0mkv24sDq1tEef56Qe6F1g82MbPXUGHzcJudgjP7/cOxicjm45FeSLRYYbwYJzANor3bYAOJz7oGS72A7rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVuQWmGUV0cSDhGg48HMjx3epfSW9KRbfbpBXooC59Q=;
 b=Dm0Q5FbWZ6qmr1gdNSxPme74Ap2K/DbjtoF/bvf3EFyoTep51+LYZBLFlDXFRbXxzcW3lwf88hK+HCb6pOQApu7I4yVTib0HKyat3yY4x2Rf5DQKNq1QdU32AKuZdPclvAJmqS+CIqT4d7NLINilKggtdhi/mHjObrl633vvOhE=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB6112.eurprd04.prod.outlook.com (2603:10a6:803:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 08:58:54 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 08:58:54 +0000
Message-ID: <4f532ceb8ebc83db497199b901cd521e5e654a25.camel@nxp.com>
Subject: Re: [PATCH 4/4] phy: freescale: phy-fsl-imx8-mipi-dphy: Add
 i.MX8qxp LVDS PHY mode support
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Date:   Thu, 10 Dec 2020 16:56:57 +0800
In-Reply-To: <20201210071458.GA4978@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
         <1607067224-15616-5-git-send-email-victor.liu@nxp.com>
         <20201208092440.GD20575@bogon.m.sigxcpu.org>
         <971966552900653b0d1714eb7d0ba17682b83780.camel@nxp.com>
         <20201210071458.GA4978@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR04CA0144.apcprd04.prod.outlook.com
 (2603:1096:3:16::28) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR04CA0144.apcprd04.prod.outlook.com (2603:1096:3:16::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:58:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46ee65bd-2734-4ac1-af14-08d89ce9d29a
X-MS-TrafficTypeDiagnostic: VI1PR04MB6112:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB61129802816C3F85F263DB4798CB0@VI1PR04MB6112.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6HQ67+GIyxVi0a3ssXqzSbVCKQ2xUhDT50bZKFD0B6T3UfeEfTsqhBDZIA21e1fssCyf1nt+Oe3C7MIOcAgjGPOLOBqrzkzcP0jRvRTQirp6LZOtVP88VNw8zD49+dy+7DntqWmClP2oNvVvWzZ7psGPUGxzH3iEry1yIOJHU/48s57+Vjc43N4FBeYun8HzyW+6Av/NfWF6vE99N5xotI73QpquRItnflfvnF1JtcjZZbIeoy+s+UXA6zLUqnUXMO1K6/DK5oGr9NM97AF6OLTRI9K0JDpZ7IKnIpPGg9LyMngxQDPVu3HHcH5FkDx2AvK/STfEewa3BJDUxDXxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6512007)(478600001)(7416002)(8676002)(6916009)(26005)(2616005)(66574015)(6506007)(956004)(4326008)(30864003)(16526019)(316002)(86362001)(6666004)(66946007)(2906002)(6486002)(36756003)(66476007)(186003)(52116002)(66556008)(5660300002)(8936002)(83380400001)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZThuSU5BZHY4TStmRHE4UEJEWGFBQkZveEJhZXVLNWtGZ28yaWxuSytxaEd0?=
 =?utf-8?B?L0tMWENNNXJ3anhDL1pUZHpiT28wZWdaRStpTS95QjY1d1pVVlBIL1pydy9E?=
 =?utf-8?B?UXl6elRBR0ZpNW56bW5DcE9EVjJha2NJaWVVVldnZGM4SGd6MlBHZ3pmbHQz?=
 =?utf-8?B?M3VjTkU3c1hPWDZVUVZudE52eldKRktsc2FMWFdhWnVZbHZkeTVSeG0zTms4?=
 =?utf-8?B?NysvczhWRGk2ZmMxUk1SdVh1Q0ZWdWNBclNXaUJ1U1lBME15aTNtZVVXdmFG?=
 =?utf-8?B?SENmSXRYMjNld3pjRFRFalJDSFBiVHltS2NyRnh0dTZNZmJkcVFYN2F2cXYr?=
 =?utf-8?B?UjcvVTJtWXp4WTV1b0lkcFlNaWJ2bjV6V2hhbFdBUUErSzlSVVFvQ1BEUFBZ?=
 =?utf-8?B?eW15T2ErV2htaGVhb1dqUTlkbE9aRnVTREVNSkhVNm9DaVVhYTFoL0J3bzcr?=
 =?utf-8?B?dlFTeTR5MEh3MjJLYUtUc1hjU1M1TUVJNUJicXgzYWdFcHQ1cGR1bllwM3Rk?=
 =?utf-8?B?Nmx1Um5JL3lPWUN0LzFOOGZEOVo4UUVNUitzeE9zVFhoa1R4KzgxYkxoRURG?=
 =?utf-8?B?dC83VlNRQm1qUDRmUjRmUFdOK1JJMEpaQW8wdm11R2U1S0M2OEtOVkdRNXRX?=
 =?utf-8?B?MU82ZzBQUldkRkRoSHgrQmZETVV3NUJyenQ3NndUbHc5cDNmUlhJLzhndzdr?=
 =?utf-8?B?MVNsMHZlUHBXeW9aMU1xVEdOSXR5eFJEalNxTkJPb1o3NDluUFp4Ui96MzZP?=
 =?utf-8?B?aHJYNHk3bzlnWlMxYnNFQzZBeGRTRzBDNzkzdjBkOFJReVk4NW5FaWlFUkc0?=
 =?utf-8?B?YWlKWUVGcHBKVTVHUXlKcHpjVGZJaFg4T285N3dBZkZaaVI3VXk1VUI0Z012?=
 =?utf-8?B?ZlJWV2Y2MGI3VFFIQmkweFpOM0VPYzFqU3N5WExPUmQvbXEzODRYdm9EZ1JD?=
 =?utf-8?B?aC8rbzh2OXJnbXZvZUlXTm0vTjBXQXpUVHgxRkdkcHl1MU1oY3hTUVBNMUpy?=
 =?utf-8?B?NE0yVkdJYjlqMW9zUXNjL3lHVU5XSW5haTlXK0wrMzJLVXhQSEhsZFdXbHR0?=
 =?utf-8?B?YWlCbUI0L2hhdThKYmZhRnZKY1A2S1pNZXZwNlJOYTFPeHQ0VWkzdGFmaHJv?=
 =?utf-8?B?bjNWbU9jQ2V0VmROMzdzaWhOcXZCb3UzSUJUWUo2QTRpa01mdEhESncyblpY?=
 =?utf-8?B?aWhFMk9vNy85eEdOVm54R3dJdW9zUVd6bXFDWUlOWkJ1SERBV1hjWjcwQm45?=
 =?utf-8?B?QnhoV2VmNlpxQ2Z6V1dMYXQ3blR3MGtvS0pNSlZxTks1WkhkVGZYeDMzTmg2?=
 =?utf-8?Q?5c+MU+0q2go+bQ9C6pSSvL7iihrfFK/IT8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:58:54.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee65bd-2734-4ac1-af14-08d89ce9d29a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrVg9RZNmONeqaY8ZEjQaQRB1h3N6orWc8v997fd8mu0fGlow434Bysk9mQxCrBXhE1/kINp0VK94NETbYQr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Thu, 2020-12-10 at 08:14 +0100, Guido Günther wrote:
> Hi,
> On Tue, Dec 08, 2020 at 06:03:05PM +0800, Liu Ying wrote:
> > On Tue, 2020-12-08 at 10:24 +0100, Guido Günther wrote:
> > > Hi Liu,
> > > some minor comments inline:
> > > 
> > > On Fri, Dec 04, 2020 at 03:33:44PM +0800, Liu Ying wrote:
> > > > i.MX8qxp SoC embeds a Mixel MIPI DPHY + LVDS PHY combo which supports
> > > > either a MIPI DSI display or a LVDS display.  The PHY mode is controlled
> > > > by SCU firmware and the driver would call a SCU firmware function to
> > > > configure the PHY mode.  The single LVDS PHY has 4 data lanes to support
> > > > a LVDS display.  Also, with a master LVDS PHY and a slave LVDS PHY, they
> > > > may work together to support a LVDS display with 8 data lanes(usually, dual
> > > > LVDS link display).  Note that this patch supports the LVDS PHY mode only
> > > > for the i.MX8qxp Mixel combo PHY, i.e., the MIPI DPHY mode is yet to be
> > > > supported, so for now error would be returned from ->set_mode() if MIPI
> > > > DPHY mode is passed over to it for the combo PHY.
> > > > 
> > > > Cc: Guido Günther <agx@sigxcpu.org>
> > > > Cc: Robert Chiras <robert.chiras@nxp.com>
> > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <festevam@gmail.com>
> > > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > ---
> > > >  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 266 ++++++++++++++++++++++++-
> > > >  1 file changed, 255 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > > > index a95572b..37084a9 100644
> > > > --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > > > +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > > > @@ -4,17 +4,31 @@
> > > >   * Copyright 2019 Purism SPC
> > > >   */
> > > >  
> > > > +#include <linux/bitfield.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/clk-provider.h>
> > > >  #include <linux/delay.h>
> > > > +#include <linux/firmware/imx/ipc.h>
> > > > +#include <linux/firmware/imx/svc/misc.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/mfd/syscon.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/phy/phy.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/regmap.h>
> > > > +#include <dt-bindings/firmware/imx/rsrc.h>
> > > > +
> > > > +/* Control and Status Registers(CSR) */
> > > > +#define PHY_CTRL			0x00
> > > > +#define  CCM_MASK			GENMASK(7, 5)
> > > > +#define  CCM(n)				FIELD_PREP(CCM_MASK, (n))
> > > > +#define  CA_MASK			GENMASK(4, 2)
> > > > +#define  CA(n)				FIELD_PREP(CA_MASK, (n))
> > > > +#define  RFB				BIT(1)
> > > > +#define  LVDS_EN			BIT(0)
> > > >  
> > > >  /* DPHY registers */
> > > >  #define DPHY_PD_DPHY			0x00
> > > > @@ -55,8 +69,15 @@
> > > >  #define PWR_ON	0
> > > >  #define PWR_OFF	1
> > > >  
> > > > +#define MIN_VCO_FREQ 640000000
> > > > +#define MAX_VCO_FREQ 1500000000
> > > > +
> > > > +#define MIN_LVDS_REFCLK_FREQ 24000000
> > > > +#define MAX_LVDS_REFCLK_FREQ 150000000
> > > > +
> > > >  enum mixel_dphy_devtype {
> > > >  	MIXEL_IMX8MQ,
> > > > +	MIXEL_IMX8QXP,
> > > >  };
> > > >  
> > > >  struct mixel_dphy_devdata {
> > > > @@ -65,6 +86,7 @@ struct mixel_dphy_devdata {
> > > >  	u8 reg_rxlprp;
> > > >  	u8 reg_rxcdrp;
> > > >  	u8 reg_rxhs_settle;
> > > > +	bool is_combo;	/* MIPI DPHY and LVDS PHY combo */
> > > >  };
> > > >  
> > > >  static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> > > > @@ -74,6 +96,10 @@ static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> > > >  		.reg_rxlprp = 0x40,
> > > >  		.reg_rxcdrp = 0x44,
> > > >  		.reg_rxhs_settle = 0x48,
> > > > +		.is_combo = false,
> > > > +	},
> > > > +	[MIXEL_IMX8QXP] = {
> > > > +		.is_combo = true,
> > > >  	},
> > > >  };
> > > >  
> > > > @@ -95,8 +121,12 @@ struct mixel_dphy_cfg {
> > > >  struct mixel_dphy_priv {
> > > >  	struct mixel_dphy_cfg cfg;
> > > >  	struct regmap *regmap;
> > > > +	struct regmap *lvds_regmap;
> > > >  	struct clk *phy_ref_clk;
> > > >  	const struct mixel_dphy_devdata *devdata;
> > > > +	struct imx_sc_ipc *ipc_handle;
> > > > +	bool is_slave;
> > > > +	int id;
> > > >  };
> > > >  
> > > >  static const struct regmap_config mixel_dphy_regmap_config = {
> > > > @@ -317,7 +347,8 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > > > +static int
> > > > +mixel_dphy_configure_mipi_dphy(struct phy *phy, union phy_configure_opts *opts)
> > > >  {
> > > >  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > >  	struct mixel_dphy_cfg cfg = { 0 };
> > > > @@ -345,15 +376,118 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int
> > > > +mixel_dphy_configure_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> > > > +{
> > > > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > > +	struct phy_configure_opts_lvds *lvds_opts = &opts->lvds;
> > > > +	unsigned long data_rate;
> > > > +	unsigned long fvco;
> > > > +	u32 rsc;
> > > > +	u32 co;
> > > > +	int ret;
> > > > +
> > > > +	priv->is_slave = lvds_opts->is_slave;
> > > > +
> > > > +	/* LVDS interface pins */
> > > > +	regmap_write(priv->lvds_regmap, PHY_CTRL, CCM(0x5) | CA(0x4) | RFB);
> > > > +
> > > > +	/* enable MODE8 only for slave LVDS PHY */
> > > > +	rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> > > > +	ret = imx_sc_misc_set_control(priv->ipc_handle, rsc, IMX_SC_C_DUAL_MODE,
> > > > +				      lvds_opts->is_slave);
> > > > +	if (ret) {
> > > > +		dev_err(&phy->dev, "Failed to configure MODE8: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Choose an appropriate divider ratio to meet the requirement of
> > > > +	 * PLL VCO frequency range.
> > > > +	 *
> > > > +	 *  -----  640MHz ~ 1500MHz   ------------      ---------------
> > > > +	 * | VCO | ----------------> | CO divider | -> | LVDS data rate|
> > > > +	 *  -----       FVCO          ------------      ---------------
> > > > +	 *                            1/2/4/8 div     7 * differential_clk_rate
> > > > +	 */
> > > > +	data_rate = 7 * lvds_opts->differential_clk_rate;
> > > > +	for (co = 1; co <= 8; co *= 2) {
> > > > +		fvco = data_rate * co;
> > > > +
> > > > +		if (fvco >= MIN_VCO_FREQ)
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	if (fvco < MIN_VCO_FREQ || fvco > MAX_VCO_FREQ) {
> > > > +		dev_err(&phy->dev, "VCO frequency %lu is out of range\n", fvco);
> > > > +		return -ERANGE;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * CO is configurable, while CN and CM are not,
> > > > +	 * as fixed ratios 1 and 7 are applied respectively.
> > > > +	 */
> > > > +	phy_write(phy, __ffs(co), DPHY_CO);
> > > > +
> > > > +	/* set reference clock rate */
> > > > +	clk_set_rate(priv->phy_ref_clk, lvds_opts->differential_clk_rate);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > > > +{
> > > > +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY)
> > > > +		return mixel_dphy_configure_mipi_dphy(phy, opts);
> > > > +	else if (phy->attrs.mode == PHY_MODE_LVDS)
> > > > +		return mixel_dphy_configure_lvds_phy(phy, opts);
> > > > +
> > > > +	dev_err(&phy->dev, "Failed to configure PHY with invalid PHY mode\n");
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static int
> > > > +mixel_dphy_validate_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> > > > +{
> > > > +	struct phy_configure_opts_lvds *lvds_cfg = &opts->lvds;
> > > > +
> > > > +	if (lvds_cfg->bits_per_lane_and_dclk_cycle != 7) {
> > > > +		dev_err(&phy->dev, "Invalid bits per LVDS data lane: %u\n",
> > > > +					lvds_cfg->bits_per_lane_and_dclk_cycle);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (lvds_cfg->lanes != 4) {
> > > > +		dev_err(&phy->dev, "Invalid LVDS data lanes: %u\n",
> > > > +						lvds_cfg->lanes);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (lvds_cfg->differential_clk_rate < MIN_LVDS_REFCLK_FREQ ||
> > > > +	    lvds_cfg->differential_clk_rate > MAX_LVDS_REFCLK_FREQ) {
> > > > +		dev_err(&phy->dev,
> > > > +			"Invalid LVDS differential clock rate: %lu\n",
> > > > +					lvds_cfg->differential_clk_rate);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
> > > >  			       union phy_configure_opts *opts)
> > > >  {
> > > > -	struct mixel_dphy_cfg cfg = { 0 };
> > > > +	if (mode == PHY_MODE_MIPI_DPHY) {
> > > > +		struct mixel_dphy_cfg mipi_dphy_cfg = { 0 };
> > > >  
> > > > -	if (mode != PHY_MODE_MIPI_DPHY)
> > > > -		return -EINVAL;
> > > > +		return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy,
> > > > +							&mipi_dphy_cfg);
> > > > +	} else if (mode == PHY_MODE_LVDS) {
> > > > +		return mixel_dphy_validate_lvds_phy(phy, opts);
> > > > +	}
> > > >  
> > > > -	return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> > > > +	dev_err(&phy->dev, "Failed to validate PHY with invalid PHY mode\n");
> > > 
> > > Can you print the `mode` here so it becomes obvious from the error what
> > > incorrect mode got passed in?
> > 
> > Will do in the next version.
> > 
> > > > +	return -EINVAL;
> > > >  }
> > > >  
> > > >  static int mixel_dphy_init(struct phy *phy)
> > > > @@ -373,27 +507,74 @@ static int mixel_dphy_exit(struct phy *phy)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static int mixel_dphy_power_on(struct phy *phy)
> > > > +static int mixel_dphy_power_on_mipi_dphy(struct phy *phy)
> > > >  {
> > > >  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > >  	u32 locked;
> > > >  	int ret;
> > > >  
> > > > -	ret = clk_prepare_enable(priv->phy_ref_clk);
> > > > -	if (ret < 0)
> > > > -		return ret;
> > > > -
> > > >  	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> > > >  	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> > > >  				       locked, PLL_LOCK_SLEEP,
> > > >  				       PLL_LOCK_TIMEOUT);
> > > >  	if (ret < 0) {
> > > >  		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
> > > > -		goto clock_disable;
> > > > +		return ret;
> > > >  	}
> > > >  	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> > > >  
> > > >  	return 0;
> > > > +}
> > > > +
> > > > +static int mixel_dphy_power_on_lvds_phy(struct phy *phy)
> > > > +{
> > > > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > > +	u32 locked;
> > > > +	int ret;
> > > > +
> > > > +	regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, LVDS_EN);
> > > > +
> > > > +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> > > > +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> > > > +
> > > > +	/* do not wait for slave LVDS PHY being locked */
> > > > +	if (priv->is_slave)
> > > > +		return 0;
> > > > +
> > > > +	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> > > > +				       locked, PLL_LOCK_SLEEP,
> > > > +				       PLL_LOCK_TIMEOUT);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&phy->dev, "Could not get LVDS PHY lock (%d)!\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int mixel_dphy_power_on(struct phy *phy)
> > > > +{
> > > > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > > +	int ret;
> > > > +
> > > > +	ret = clk_prepare_enable(priv->phy_ref_clk);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY) {
> > > > +		ret = mixel_dphy_power_on_mipi_dphy(phy);
> > > > +	} else if (phy->attrs.mode == PHY_MODE_LVDS) {
> > > > +		ret = mixel_dphy_power_on_lvds_phy(phy);
> > > > +	} else {
> > > > +		dev_err(&phy->dev,
> > > > +			"Failed to power on PHY with invalid PHY mode\n");
> > > 
> > > Can you print the `mode` here so it becomes obvious from the error what
> > > incorrect mode got passed in?
> > 
> > Will do in the next version.
> > 
> > > > +		ret = -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (ret)
> > > > +		goto clock_disable;
> > > > +
> > > > +	return 0;
> > > >  clock_disable:
> > > >  	clk_disable_unprepare(priv->phy_ref_clk);
> > > >  	return ret;
> > > > @@ -406,16 +587,52 @@ static int mixel_dphy_power_off(struct phy *phy)
> > > >  	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> > > >  	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> > > >  
> > > > +	if (phy->attrs.mode == PHY_MODE_LVDS)
> > > > +		regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, 0);
> > > > +
> > > >  	clk_disable_unprepare(priv->phy_ref_clk);
> > > >  
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int mixel_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > > > +{
> > > > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > > > +	int ret;
> > > > +
> > > 
> > > I'd reject all modes except PHY_MODE_MIPI_DPHY and PHY_MODE_MIPI_LVDS upfront...
> > 
> > It seems that this overall rejection would cause _double_ check
> > together with the snippet right below, which should be avoided.
> > 
> > > > +	/* Currently, MIPI DPHY mode only, if it's not a combo PHY. */
> > > > +	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
> > > > +		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
> > > > +		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > ...and then just reject on whetehr `is_combo` is set or not. This makes
> > > it easier to add more later.
> > 
> > The above snippet is rejecting on whether 'is_combo' is set or not.
> > So, in short, the current implementation looks ok to me.
> > Or, things still can be improved here?
> 
> I agree, i think what tripped me up is that the double negative check
> comes first comined with the comment so i'd just drop the comment and
> start with the positive one:
> 
> 	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
> 		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
> 		return -EINVAL;
> 	}
> 
> 	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
> 		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
> 		return -EINVAL;
> 	}

Ok.  I'll use this snippet.

Thanks,
Liu Ying

> 
> Cheers,
>  -- Guido
> 
> > Thanks,
> > Liu Ying
> > 
> > > > +	if (priv->devdata->is_combo) {
> > > > +		u32 rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> > > > +
> > > > +		ret = imx_sc_misc_set_control(priv->ipc_handle,
> > > > +					      rsc, IMX_SC_C_MODE,
> > > > +					      mode == PHY_MODE_LVDS);
> > > > +		if (ret) {
> > > > +			dev_err(&phy->dev,
> > > > +				"Failed to set PHY mode via SCU ipc: %d\n", ret);
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static const struct phy_ops mixel_dphy_phy_ops = {
> > > >  	.init = mixel_dphy_init,
> > > >  	.exit = mixel_dphy_exit,
> > > >  	.power_on = mixel_dphy_power_on,
> > > >  	.power_off = mixel_dphy_power_off,
> > > > +	.set_mode = mixel_dphy_set_mode,
> > > >  	.configure = mixel_dphy_configure,
> > > >  	.validate = mixel_dphy_validate,
> > > >  	.owner = THIS_MODULE,
> > > > @@ -424,6 +641,8 @@ static const struct phy_ops mixel_dphy_phy_ops = {
> > > >  static const struct of_device_id mixel_dphy_of_match[] = {
> > > >  	{ .compatible = "fsl,imx8mq-mipi-dphy",
> > > >  	  .data = &mixel_dphy_devdata[MIXEL_IMX8MQ] },
> > > > +	{ .compatible = "fsl,imx8qxp-mipi-dphy",
> > > > +	  .data = &mixel_dphy_devdata[MIXEL_IMX8QXP] },
> > > >  	{ /* sentinel */ },
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
> > > > @@ -436,6 +655,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> > > >  	struct mixel_dphy_priv *priv;
> > > >  	struct phy *phy;
> > > >  	void __iomem *base;
> > > > +	int ret;
> > > >  
> > > >  	if (!np)
> > > >  		return -ENODEV;
> > > > @@ -467,6 +687,30 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> > > >  	dev_dbg(dev, "phy_ref clock rate: %lu\n",
> > > >  		clk_get_rate(priv->phy_ref_clk));
> > > >  
> > > > +	if (priv->devdata->is_combo) {
> > > > +		priv->lvds_regmap =
> > > > +			syscon_regmap_lookup_by_phandle(np, "fsl,syscon");
> > > > +		if (IS_ERR(priv->lvds_regmap)) {
> > > > +			ret = PTR_ERR(priv->lvds_regmap);
> > > > +			dev_err_probe(dev, ret, "Failed to get LVDS regmap\n");
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		priv->id = of_alias_get_id(np, "mipi_dphy");
> > > > +		if (priv->id < 0) {
> > > > +			dev_err(dev, "Failed to get phy node alias id: %d\n",
> > > > +								 priv->id);
> > > > +			return priv->id;
> > > > +		}
> > > > +
> > > > +		ret = imx_scu_get_handle(&priv->ipc_handle);
> > > > +		if (ret) {
> > > > +			dev_err_probe(dev, ret,
> > > > +				      "Failed to get SCU ipc handle\n");
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > >  	dev_set_drvdata(dev, priv);
> > > >  
> > > >  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > Cheers,
> > >  -- Guido

