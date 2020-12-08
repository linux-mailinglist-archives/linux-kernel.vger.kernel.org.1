Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D982D2866
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgLHKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:05:54 -0500
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:53153
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbgLHKFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:05:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSDKjimqoTHBlwyFjL/V9/zEbX3YUIB+lc50fmawBgdPVFLv3MyjEfFV6m3R8BbaN6JuY+f7zzcrLyVQSf4S5zCwN9ZekU53bt/RVdUwr0h83HAsp4D0FQA+UgV48NbKIuu1NkC0iSe4KhxnKWOLF4LBBqoILC5DeGfccuMH4+cor3LX/iZBJMGNAeD/YW/Cj09186ltmxMXZtgC4JUng5h03bLpwZ5tfcwkRcvB3fMdpbRre8vAMZTJviGze5nhV5U5Ailie+vKGFarAR6BXdvK8IHEe5d1Jg9cHV6I6sgRUmwd6J90EWYNYiHMR259MBbeRUmDeFs2d9v+2k3Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mBpYIXtH6S1PXCUB2ipAvRufTEGjaRvyzs2dybWsVw=;
 b=NAOW0SU82xtbHfzFiHzV5PhNp9PuBLOWBniBvTzurCAG0RW06lQRX7zesWNsjDESI2/w1PvTyD7evRCRrKa3lj+PRka5eGc2fO9PmOoyNld5Gc4wGISUVnWC1NmjCJVu1vtX8BnZoFcAYA+D5a/5lBdGwC2xJHHfWZ/joLIsEGfQrIP4R/sGnGWy7mBlDb1FaMjLhqrzM1Mr3sTLQKprZEG6McZfQP6WBWBv701xCuWFdlW5o7UI9GW8IoY6wzz3WBJ1LDCw9x7bjdFITfps0BdPvjoYJzC8ABtSUX1o/oWZ9DjK4++JT4KfdUx27wKxFau/lGvELq/zQqzIHsJMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mBpYIXtH6S1PXCUB2ipAvRufTEGjaRvyzs2dybWsVw=;
 b=mr4zRh/3zfNIY8YyI5TyBvCwnWr7Ue1XHRt9GUi6Mfs4OzwNOwYuVSYtW+GuJzsfBG49Cf3zjVpUrxUmYyrMcn5ff0Lm1fyS3VP+Rh2XtJ17cVphK4QcpdLgbEboiXYXQFoTVrJmkq/jn6d8qrDFj6QvsZtsZGlw5SoG5dz7L4I=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR0401MB2318.eurprd04.prod.outlook.com (2603:10a6:800:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 10:04:57 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 10:04:57 +0000
Message-ID: <971966552900653b0d1714eb7d0ba17682b83780.camel@nxp.com>
Subject: Re: [PATCH 4/4] phy: freescale: phy-fsl-imx8-mipi-dphy: Add
 i.MX8qxp LVDS PHY mode support
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Date:   Tue, 08 Dec 2020 18:03:05 +0800
In-Reply-To: <20201208092440.GD20575@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
         <1607067224-15616-5-git-send-email-victor.liu@nxp.com>
         <20201208092440.GD20575@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:3:1::32) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:3:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21 via Frontend Transport; Tue, 8 Dec 2020 10:04:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05f278ad-6e75-4611-5156-08d89b60b779
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2318:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2318C4F69CBBC70B55A2806298CD0@VI1PR0401MB2318.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzJsKe1nImeqqF9RG5y94Fy14ULzVYYX+Tr6xerjuSnFzriolQQzveeN/fd8TU9iq4jUCEh51sHRuw8ndM644ACfPHx75j6gjHHgpGSAON9HN/fE4k3GPZwsrCroCvBBxzuT59cvrc7p+zJdWyW4ZPB8+PyH79IVRPglFZHfjW8/lDDAfc+R3bOJQcGLw/Rc5Nx9mJ0hyvDgM+GSuVEbmdWrIEASiJAJEgQmaYxfoqdNESO2ibh3V16ThJUYzbHk7PoAAgVXAmwFDAQpYAm4idq4ioEaXwzhD6sSxi5hesSUlH5fkQbebudggfqahT9AGKZOg4WFGi/K9M2bpgflhrAndXhFckdg0IpXaPgBPqFtBlekb7gVZr05+1xrblEy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(30864003)(52116002)(2616005)(6486002)(956004)(7416002)(66476007)(66946007)(66556008)(5660300002)(83380400001)(2906002)(186003)(8936002)(16526019)(36756003)(8676002)(6506007)(26005)(66574015)(6916009)(6512007)(4326008)(86362001)(6666004)(34490700003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0txQ0Z1ckNva2hWZzBkdjMraW1SNmxrYVJLcmtldUs2c2FWbjY0MWtiS3l2?=
 =?utf-8?B?dGx3cXJuWXF3cWprWWFKUmVHL0lET00zaVg1cWpYQ0YyTXR5bFBRWWtRM2RS?=
 =?utf-8?B?SGtPVTJHeUpaRG5mTTNrOFkrS0lUL1BIanZENVhTajZaMXFldFd5SHB4dDZD?=
 =?utf-8?B?RklwTkI2UFZqeXBYYXMrMDlCY3ZjeW1YZmJDNE5iOU1LRjFSTkRLRXBiWklh?=
 =?utf-8?B?VnZmS2xFTlEyeGpSeHg2S3U3WkUwUEtzM1Q2SWtORlBWSzVITC9GSjMxN0xY?=
 =?utf-8?B?ZDJuWjVidUNhSXZKOG9NU2FkL2o1dUJRSWZIbDBjSWxPSmFsc1VoOWtHeXA1?=
 =?utf-8?B?S1loZ0srMDIvRDlqWXRDMlNQV05RcmZvY3o5cDdTd2krL3NTdzNKdUdkTWo2?=
 =?utf-8?B?MlpaWHJtUlVBSU9SR0ZDR3NzUUwwc2Z5Z2dzbUZkaDRmcExVT2NwbE5mSWhS?=
 =?utf-8?B?RjlQTS9ScUJGK280OGFLdXh3S3NJdG4rMy9uTDFDdngyVDVqTXM2Q1VJa0Ew?=
 =?utf-8?B?cDF2L0toWXdzeUtta3dSZ3VJejdTVlVtcGxoVUNnNkM5Z3ppbDh4UlJob3Ji?=
 =?utf-8?B?WE1rdzFLRTI2MHZhVm9nYTU5MmpCaFI2YmpETSttNjBuV2pSb3JJcll5VWlK?=
 =?utf-8?B?L25kUjBFS3dsYUI3TGxac2cxbVFneHVMSnhBRHdITmIyK2dCYnl0M3d2MWFz?=
 =?utf-8?B?YzBWOUhwajVVMWN2ektmVERxKzJxUFlKckZQNDhvV0tyU3JpRVVkZFZXQmN1?=
 =?utf-8?B?YjJpWDRvcDFZb1gxczhpUVdsZk5QR2xPZkdnaUk2U2o3RFlmQjdPSCs0UFZu?=
 =?utf-8?B?L0E4bHhCKzdMcmRjWkNIRGtSSkNWTll1d09xU0RYeEIrWThxb3MrNjkrbi96?=
 =?utf-8?B?QmpjeWU2bUNJTDFleVlBR2x5dzFiS3EzKy94NEZVVGduRXhOTlF5VWxma0dS?=
 =?utf-8?B?QitDWkVGVFNLeEJZUTVkV2lrUGNBTnlVRUtVMXlEZlFteGxNV3Q3Q000a3Rl?=
 =?utf-8?B?MHNmZ2NYaEpyYUczZVR5bUFoYkxVZFZZR1VMT0JCM3hOWTVtZWsveWRtbE13?=
 =?utf-8?B?SnJqakRBamFvSlkzSzEwT21qT25MSnJwODRUVUdPakNiazJmeUE3cHdCYUNS?=
 =?utf-8?B?KzB1V3VuVmZuYlo1S3p0dFNlVDduUDIySG1ySmJwY0Z3V1ZCNlJiUmt1aTZ6?=
 =?utf-8?B?bnAydzlFdXdZQzI3SWQyMlA3VmlIYVNwZlMyblRESlBmL2xNZHJzU0U0eTJw?=
 =?utf-8?B?V2ZYSUE0ZEZ2Y2g0Mzc3NU9HMkswWE1mQlZWSVQrYmJsK0U4ejNvWVRwUFJj?=
 =?utf-8?Q?fSgp93CBbFPhfZ7vSbdOdMH8ElLKnVqjGZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f278ad-6e75-4611-5156-08d89b60b779
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 10:04:57.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RYayAAU8v83xn5sOARoGTv4zY+QM5OZtlyBaP5Q9OLpcEv4gfNOfxA16Np5UI0/ZrRTLvNGd7lTxv1Ow0Hvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-08 at 10:24 +0100, Guido Günther wrote:
> Hi Liu,
> some minor comments inline:
> 
> On Fri, Dec 04, 2020 at 03:33:44PM +0800, Liu Ying wrote:
> > i.MX8qxp SoC embeds a Mixel MIPI DPHY + LVDS PHY combo which supports
> > either a MIPI DSI display or a LVDS display.  The PHY mode is controlled
> > by SCU firmware and the driver would call a SCU firmware function to
> > configure the PHY mode.  The single LVDS PHY has 4 data lanes to support
> > a LVDS display.  Also, with a master LVDS PHY and a slave LVDS PHY, they
> > may work together to support a LVDS display with 8 data lanes(usually, dual
> > LVDS link display).  Note that this patch supports the LVDS PHY mode only
> > for the i.MX8qxp Mixel combo PHY, i.e., the MIPI DPHY mode is yet to be
> > supported, so for now error would be returned from ->set_mode() if MIPI
> > DPHY mode is passed over to it for the combo PHY.
> > 
> > Cc: Guido Günther <agx@sigxcpu.org>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 266 ++++++++++++++++++++++++-
> >  1 file changed, 255 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > index a95572b..37084a9 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > @@ -4,17 +4,31 @@
> >   * Copyright 2019 Purism SPC
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/delay.h>
> > +#include <linux/firmware/imx/ipc.h>
> > +#include <linux/firmware/imx/svc/misc.h>
> >  #include <linux/io.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <dt-bindings/firmware/imx/rsrc.h>
> > +
> > +/* Control and Status Registers(CSR) */
> > +#define PHY_CTRL			0x00
> > +#define  CCM_MASK			GENMASK(7, 5)
> > +#define  CCM(n)				FIELD_PREP(CCM_MASK, (n))
> > +#define  CA_MASK			GENMASK(4, 2)
> > +#define  CA(n)				FIELD_PREP(CA_MASK, (n))
> > +#define  RFB				BIT(1)
> > +#define  LVDS_EN			BIT(0)
> >  
> >  /* DPHY registers */
> >  #define DPHY_PD_DPHY			0x00
> > @@ -55,8 +69,15 @@
> >  #define PWR_ON	0
> >  #define PWR_OFF	1
> >  
> > +#define MIN_VCO_FREQ 640000000
> > +#define MAX_VCO_FREQ 1500000000
> > +
> > +#define MIN_LVDS_REFCLK_FREQ 24000000
> > +#define MAX_LVDS_REFCLK_FREQ 150000000
> > +
> >  enum mixel_dphy_devtype {
> >  	MIXEL_IMX8MQ,
> > +	MIXEL_IMX8QXP,
> >  };
> >  
> >  struct mixel_dphy_devdata {
> > @@ -65,6 +86,7 @@ struct mixel_dphy_devdata {
> >  	u8 reg_rxlprp;
> >  	u8 reg_rxcdrp;
> >  	u8 reg_rxhs_settle;
> > +	bool is_combo;	/* MIPI DPHY and LVDS PHY combo */
> >  };
> >  
> >  static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> > @@ -74,6 +96,10 @@ static const struct mixel_dphy_devdata mixel_dphy_devdata[] = {
> >  		.reg_rxlprp = 0x40,
> >  		.reg_rxcdrp = 0x44,
> >  		.reg_rxhs_settle = 0x48,
> > +		.is_combo = false,
> > +	},
> > +	[MIXEL_IMX8QXP] = {
> > +		.is_combo = true,
> >  	},
> >  };
> >  
> > @@ -95,8 +121,12 @@ struct mixel_dphy_cfg {
> >  struct mixel_dphy_priv {
> >  	struct mixel_dphy_cfg cfg;
> >  	struct regmap *regmap;
> > +	struct regmap *lvds_regmap;
> >  	struct clk *phy_ref_clk;
> >  	const struct mixel_dphy_devdata *devdata;
> > +	struct imx_sc_ipc *ipc_handle;
> > +	bool is_slave;
> > +	int id;
> >  };
> >  
> >  static const struct regmap_config mixel_dphy_regmap_config = {
> > @@ -317,7 +347,8 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
> >  	return 0;
> >  }
> >  
> > -static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > +static int
> > +mixel_dphy_configure_mipi_dphy(struct phy *phy, union phy_configure_opts *opts)
> >  {
> >  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> >  	struct mixel_dphy_cfg cfg = { 0 };
> > @@ -345,15 +376,118 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> >  	return 0;
> >  }
> >  
> > +static int
> > +mixel_dphy_configure_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	struct phy_configure_opts_lvds *lvds_opts = &opts->lvds;
> > +	unsigned long data_rate;
> > +	unsigned long fvco;
> > +	u32 rsc;
> > +	u32 co;
> > +	int ret;
> > +
> > +	priv->is_slave = lvds_opts->is_slave;
> > +
> > +	/* LVDS interface pins */
> > +	regmap_write(priv->lvds_regmap, PHY_CTRL, CCM(0x5) | CA(0x4) | RFB);
> > +
> > +	/* enable MODE8 only for slave LVDS PHY */
> > +	rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> > +	ret = imx_sc_misc_set_control(priv->ipc_handle, rsc, IMX_SC_C_DUAL_MODE,
> > +				      lvds_opts->is_slave);
> > +	if (ret) {
> > +		dev_err(&phy->dev, "Failed to configure MODE8: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Choose an appropriate divider ratio to meet the requirement of
> > +	 * PLL VCO frequency range.
> > +	 *
> > +	 *  -----  640MHz ~ 1500MHz   ------------      ---------------
> > +	 * | VCO | ----------------> | CO divider | -> | LVDS data rate|
> > +	 *  -----       FVCO          ------------      ---------------
> > +	 *                            1/2/4/8 div     7 * differential_clk_rate
> > +	 */
> > +	data_rate = 7 * lvds_opts->differential_clk_rate;
> > +	for (co = 1; co <= 8; co *= 2) {
> > +		fvco = data_rate * co;
> > +
> > +		if (fvco >= MIN_VCO_FREQ)
> > +			break;
> > +	}
> > +
> > +	if (fvco < MIN_VCO_FREQ || fvco > MAX_VCO_FREQ) {
> > +		dev_err(&phy->dev, "VCO frequency %lu is out of range\n", fvco);
> > +		return -ERANGE;
> > +	}
> > +
> > +	/*
> > +	 * CO is configurable, while CN and CM are not,
> > +	 * as fixed ratios 1 and 7 are applied respectively.
> > +	 */
> > +	phy_write(phy, __ffs(co), DPHY_CO);
> > +
> > +	/* set reference clock rate */
> > +	clk_set_rate(priv->phy_ref_clk, lvds_opts->differential_clk_rate);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> > +{
> > +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY)
> > +		return mixel_dphy_configure_mipi_dphy(phy, opts);
> > +	else if (phy->attrs.mode == PHY_MODE_LVDS)
> > +		return mixel_dphy_configure_lvds_phy(phy, opts);
> > +
> > +	dev_err(&phy->dev, "Failed to configure PHY with invalid PHY mode\n");
> > +	return -EINVAL;
> > +}
> > +
> > +static int
> > +mixel_dphy_validate_lvds_phy(struct phy *phy, union phy_configure_opts *opts)
> > +{
> > +	struct phy_configure_opts_lvds *lvds_cfg = &opts->lvds;
> > +
> > +	if (lvds_cfg->bits_per_lane_and_dclk_cycle != 7) {
> > +		dev_err(&phy->dev, "Invalid bits per LVDS data lane: %u\n",
> > +					lvds_cfg->bits_per_lane_and_dclk_cycle);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (lvds_cfg->lanes != 4) {
> > +		dev_err(&phy->dev, "Invalid LVDS data lanes: %u\n",
> > +						lvds_cfg->lanes);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (lvds_cfg->differential_clk_rate < MIN_LVDS_REFCLK_FREQ ||
> > +	    lvds_cfg->differential_clk_rate > MAX_LVDS_REFCLK_FREQ) {
> > +		dev_err(&phy->dev,
> > +			"Invalid LVDS differential clock rate: %lu\n",
> > +					lvds_cfg->differential_clk_rate);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
> >  			       union phy_configure_opts *opts)
> >  {
> > -	struct mixel_dphy_cfg cfg = { 0 };
> > +	if (mode == PHY_MODE_MIPI_DPHY) {
> > +		struct mixel_dphy_cfg mipi_dphy_cfg = { 0 };
> >  
> > -	if (mode != PHY_MODE_MIPI_DPHY)
> > -		return -EINVAL;
> > +		return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy,
> > +							&mipi_dphy_cfg);
> > +	} else if (mode == PHY_MODE_LVDS) {
> > +		return mixel_dphy_validate_lvds_phy(phy, opts);
> > +	}
> >  
> > -	return mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
> > +	dev_err(&phy->dev, "Failed to validate PHY with invalid PHY mode\n");
> 
> Can you print the `mode` here so it becomes obvious from the error what
> incorrect mode got passed in?

Will do in the next version.

> 
> > +	return -EINVAL;
> >  }
> >  
> >  static int mixel_dphy_init(struct phy *phy)
> > @@ -373,27 +507,74 @@ static int mixel_dphy_exit(struct phy *phy)
> >  	return 0;
> >  }
> >  
> > -static int mixel_dphy_power_on(struct phy *phy)
> > +static int mixel_dphy_power_on_mipi_dphy(struct phy *phy)
> >  {
> >  	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> >  	u32 locked;
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(priv->phy_ref_clk);
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> >  	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> >  				       locked, PLL_LOCK_SLEEP,
> >  				       PLL_LOCK_TIMEOUT);
> >  	if (ret < 0) {
> >  		dev_err(&phy->dev, "Could not get DPHY lock (%d)!\n", ret);
> > -		goto clock_disable;
> > +		return ret;
> >  	}
> >  	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> >  
> >  	return 0;
> > +}
> > +
> > +static int mixel_dphy_power_on_lvds_phy(struct phy *phy)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	u32 locked;
> > +	int ret;
> > +
> > +	regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, LVDS_EN);
> > +
> > +	phy_write(phy, PWR_ON, DPHY_PD_DPHY);
> > +	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> > +
> > +	/* do not wait for slave LVDS PHY being locked */
> > +	if (priv->is_slave)
> > +		return 0;
> > +
> > +	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> > +				       locked, PLL_LOCK_SLEEP,
> > +				       PLL_LOCK_TIMEOUT);
> > +	if (ret < 0) {
> > +		dev_err(&phy->dev, "Could not get LVDS PHY lock (%d)!\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mixel_dphy_power_on(struct phy *phy)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(priv->phy_ref_clk);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (phy->attrs.mode == PHY_MODE_MIPI_DPHY) {
> > +		ret = mixel_dphy_power_on_mipi_dphy(phy);
> > +	} else if (phy->attrs.mode == PHY_MODE_LVDS) {
> > +		ret = mixel_dphy_power_on_lvds_phy(phy);
> > +	} else {
> > +		dev_err(&phy->dev,
> > +			"Failed to power on PHY with invalid PHY mode\n");
> 
> Can you print the `mode` here so it becomes obvious from the error what
> incorrect mode got passed in?

Will do in the next version.

> 
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	if (ret)
> > +		goto clock_disable;
> > +
> > +	return 0;
> >  clock_disable:
> >  	clk_disable_unprepare(priv->phy_ref_clk);
> >  	return ret;
> > @@ -406,16 +587,52 @@ static int mixel_dphy_power_off(struct phy *phy)
> >  	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> >  	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> >  
> > +	if (phy->attrs.mode == PHY_MODE_LVDS)
> > +		regmap_update_bits(priv->lvds_regmap, PHY_CTRL, LVDS_EN, 0);
> > +
> >  	clk_disable_unprepare(priv->phy_ref_clk);
> >  
> >  	return 0;
> >  }
> >  
> > +static int mixel_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > +{
> > +	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
> > +	int ret;
> > +
> 
> I'd reject all modes except PHY_MODE_MIPI_DPHY and PHY_MODE_MIPI_LVDS upfront...

It seems that this overall rejection would cause _double_ check
together with the snippet right below, which should be avoided.

> 
> > +	/* Currently, MIPI DPHY mode only, if it's not a combo PHY. */
> > +	if (!priv->devdata->is_combo && mode != PHY_MODE_MIPI_DPHY) {
> > +		dev_err(&phy->dev, "Failed to set PHY mode to MIPI DPHY\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (priv->devdata->is_combo && mode != PHY_MODE_LVDS) {
> > +		dev_err(&phy->dev, "Failed to set PHY mode for combo PHY\n");
> > +		return -EINVAL;
> > +	}
> 
> ...and then just reject on whetehr `is_combo` is set or not. This makes
> it easier to add more later.

The above snippet is rejecting on whether 'is_combo' is set or not.
So, in short, the current implementation looks ok to me.
Or, things still can be improved here?

Thanks,
Liu Ying

> 
> > +	if (priv->devdata->is_combo) {
> > +		u32 rsc = priv->id ? IMX_SC_R_MIPI_1 : IMX_SC_R_MIPI_0;
> > +
> > +		ret = imx_sc_misc_set_control(priv->ipc_handle,
> > +					      rsc, IMX_SC_C_MODE,
> > +					      mode == PHY_MODE_LVDS);
> > +		if (ret) {
> > +			dev_err(&phy->dev,
> > +				"Failed to set PHY mode via SCU ipc: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct phy_ops mixel_dphy_phy_ops = {
> >  	.init = mixel_dphy_init,
> >  	.exit = mixel_dphy_exit,
> >  	.power_on = mixel_dphy_power_on,
> >  	.power_off = mixel_dphy_power_off,
> > +	.set_mode = mixel_dphy_set_mode,
> >  	.configure = mixel_dphy_configure,
> >  	.validate = mixel_dphy_validate,
> >  	.owner = THIS_MODULE,
> > @@ -424,6 +641,8 @@ static const struct phy_ops mixel_dphy_phy_ops = {
> >  static const struct of_device_id mixel_dphy_of_match[] = {
> >  	{ .compatible = "fsl,imx8mq-mipi-dphy",
> >  	  .data = &mixel_dphy_devdata[MIXEL_IMX8MQ] },
> > +	{ .compatible = "fsl,imx8qxp-mipi-dphy",
> > +	  .data = &mixel_dphy_devdata[MIXEL_IMX8QXP] },
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, mixel_dphy_of_match);
> > @@ -436,6 +655,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  	struct mixel_dphy_priv *priv;
> >  	struct phy *phy;
> >  	void __iomem *base;
> > +	int ret;
> >  
> >  	if (!np)
> >  		return -ENODEV;
> > @@ -467,6 +687,30 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  	dev_dbg(dev, "phy_ref clock rate: %lu\n",
> >  		clk_get_rate(priv->phy_ref_clk));
> >  
> > +	if (priv->devdata->is_combo) {
> > +		priv->lvds_regmap =
> > +			syscon_regmap_lookup_by_phandle(np, "fsl,syscon");
> > +		if (IS_ERR(priv->lvds_regmap)) {
> > +			ret = PTR_ERR(priv->lvds_regmap);
> > +			dev_err_probe(dev, ret, "Failed to get LVDS regmap\n");
> > +			return ret;
> > +		}
> > +
> > +		priv->id = of_alias_get_id(np, "mipi_dphy");
> > +		if (priv->id < 0) {
> > +			dev_err(dev, "Failed to get phy node alias id: %d\n",
> > +								 priv->id);
> > +			return priv->id;
> > +		}
> > +
> > +		ret = imx_scu_get_handle(&priv->ipc_handle);
> > +		if (ret) {
> > +			dev_err_probe(dev, ret,
> > +				      "Failed to get SCU ipc handle\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	dev_set_drvdata(dev, priv);
> >  
> >  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
> > -- 
> > 2.7.4
> > 
> 
> Cheers,
>  -- Guido

