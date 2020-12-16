Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AEA2DC000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLPMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPMG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:06:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD0C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 04:05:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kpVYo-0003Zf-1I; Wed, 16 Dec 2020 13:05:38 +0100
Message-ID: <ee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 16 Dec 2020 13:05:36 +0100
In-Reply-To: <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
References: <cover.1608118008.git.agx@sigxcpu.org>
         <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

this time hopefully with less broken quoting. My mailer is driving me
mad right now...

Am Mittwoch, dem 16.12.2020 um 12:27 +0100 schrieb Guido Günther:
> This allows us to shut down the mipi power domain on the imx8. The
> alternative would be to drop the dphy from the mipi power domain in the
> SOCs device tree and only have the DSI host controller visible there but
> since the PD is mostly about the PHY that would defeat it's purpose.

Adding RPM support is exactly the right course of action.

> This allows to shut off the power domain hen blanking the LCD panel:
> 
> pm_genpd_summary before:
> 
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> mipi                            on
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> after:
> 
> mipi                            off-0
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index a95572b397ca..34e2d801e520 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  /* DPHY registers */
> @@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
>  };
>  
>  struct mixel_dphy_priv {
> +	struct device *dev;
>  	struct mixel_dphy_cfg cfg;
>  	struct regmap *regmap;
>  	struct clk *phy_ref_clk;
> @@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
>  	ret = clk_prepare_enable(priv->phy_ref_clk);
>  	if (ret < 0)
>  		return ret;
> +	pm_runtime_get_sync(priv->dev);
>  

This call can fail and will leave you with an elevated rpm refcount.
Better use the new pm_runtime_resume_and_get to avoid this issue? 

Nitpick: I would add a blank line before the call.

Regards,
Lucas

