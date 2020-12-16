Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6A2DC661
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgLPSZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:53 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:45208 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730503AbgLPSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id CE92FFB03;
        Wed, 16 Dec 2020 19:25:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cqkJ8AbYKf6s; Wed, 16 Dec 2020 19:25:06 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id F0ED143FDC; Wed, 16 Dec 2020 19:25:05 +0100 (CET)
Date:   Wed, 16 Dec 2020 19:25:05 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Message-ID: <20201216182505.GA51879@bogon.m.sigxcpu.org>
References: <cover.1608118008.git.agx@sigxcpu.org>
 <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
 <ee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,
On Wed, Dec 16, 2020 at 01:05:36PM +0100, Lucas Stach wrote:
> Hi Guido,
> 
> this time hopefully with less broken quoting. My mailer is driving me
> mad right now...
> 
> Am Mittwoch, dem 16.12.2020 um 12:27 +0100 schrieb Guido Günther:
> > This allows us to shut down the mipi power domain on the imx8. The
> > alternative would be to drop the dphy from the mipi power domain in the
> > SOCs device tree and only have the DSI host controller visible there but
> > since the PD is mostly about the PHY that would defeat it's purpose.
> 
> Adding RPM support is exactly the right course of action.

Thanks for confirming!

> 
> > This allows to shut off the power domain hen blanking the LCD panel:
> > 
> > pm_genpd_summary before:
> > 
> > domain                          status          slaves
> >     /device                                             runtime status
> > ----------------------------------------------------------------------
> > mipi                            on
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > after:
> > 
> > mipi                            off-0
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > index a95572b397ca..34e2d801e520 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  
> >  /* DPHY registers */
> > @@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
> >  };
> >  
> >  struct mixel_dphy_priv {
> > +	struct device *dev;
> >  	struct mixel_dphy_cfg cfg;
> >  	struct regmap *regmap;
> >  	struct clk *phy_ref_clk;
> > @@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
> >  	ret = clk_prepare_enable(priv->phy_ref_clk);
> >  	if (ret < 0)
> >  		return ret;
> > +	pm_runtime_get_sync(priv->dev);
> >  
> 
> This call can fail and will leave you with an elevated rpm refcount.
> Better use the new pm_runtime_resume_and_get to avoid this issue?

pm_runtime_resume_and_get is a nice API addition indeed.

I added the error handling but opted to stay with `pm_runtime_get_sync`
in this case since the error path already has a pm_runtime_put() hence
avoiding another goto target.

> 
> Nitpick: I would add a blank line before the call.

Done.

Thanks for having a look!
 -- Guido

> 
> Regards,
> Lucas
> 
