Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8192DA92F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgLOIbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:31:34 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:57538 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgLOIbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:31:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D41F5FB03;
        Tue, 15 Dec 2020 09:30:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N7tRuB2LkNIs; Tue, 15 Dec 2020 09:30:19 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5ECA443FDC; Tue, 15 Dec 2020 09:30:19 +0100 (CET)
Date:   Tue, 15 Dec 2020 09:30:19 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: Re: [PATCH 1/4] drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_enable()
Message-ID: <20201215083019.GA11854@bogon.m.sigxcpu.org>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
 <1607067224-15616-2-git-send-email-victor.liu@nxp.com>
 <20201208090457.GB20575@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208090457.GB20575@bogon.m.sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Dec 08, 2020 at 10:04:57AM +0100, Guido Günther wrote:
> Hi,
> On Fri, Dec 04, 2020 at 03:33:41PM +0800, Liu Ying wrote:
> > The Northwest Logic MIPI DSI host controller embedded in i.MX8qxp
> > works with a Mixel MIPI DPHY + LVDS PHY combo to support either
> > a MIPI DSI display or a LVDS display.  So, this patch calls
> > phy_set_mode() from nwl_dsi_enable() to set PHY mode to MIPI DPHY
> > explicitly.

Should i pull this patch in via drm-misc-next or is the whole series
supposed to go via the phy tree?
Cheers,
 -- Guido


> > 
> > Cc: Guido Günther <agx@sigxcpu.org>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> > index 66b6740..be6bfc5 100644
> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -678,6 +678,12 @@ static int nwl_dsi_enable(struct nwl_dsi *dsi)
> >  		return ret;
> >  	}
> >  
> > +	ret = phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
> > +	if (ret < 0) {
> > +		DRM_DEV_ERROR(dev, "Failed to set DSI phy mode: %d\n", ret);
> > +		goto uninit_phy;
> > +	}
> > +
> >  	ret = phy_configure(dsi->phy, phy_cfg);
> >  	if (ret < 0) {
> >  		DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n", ret);
> 
> Reviewed-by: Guido Günther <agx@sigxcpu.org> 
>  -- Guido
> 
> > -- 
> > 2.7.4
> > 
> 
> 
