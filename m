Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E52D2B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgLHMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:39:40 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53122 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLHMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:39:39 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5126CDD;
        Tue,  8 Dec 2020 13:38:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1607431136;
        bh=v/1gJ9S8/WL7ZCOyvN/j+6KzE11E1+D7ZujUrs8lthI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUnh33RpWU/mAZ93S3wX/T6Ghd/YrHXmOCK2uw0qO9dPPMw5iy66Dl4YQpH2ILLpa
         qa3jBE3z39ofvUW7eeXdffHMk6o6HevMQT1dKUtF54nRU6rwXxxTMDmKTaqvJs2FIY
         rSmDAGO6Qir86/d0PhCEhA/iFhiw3kTPVlw/j1kA=
Date:   Tue, 8 Dec 2020 14:38:53 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@siol.net,
        airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agx@sigxcpu.org, robert.chiras@nxp.com,
        martin.kepplinger@puri.sm
Subject: Re: [PATCH 2/4] phy: Add LVDS configuration options
Message-ID: <X89z3czlY1yxgsX3@pendragon.ideasonboard.com>
References: <1607067224-15616-1-git-send-email-victor.liu@nxp.com>
 <1607067224-15616-3-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1607067224-15616-3-git-send-email-victor.liu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

Thank you for the patch.

On Fri, Dec 04, 2020 at 03:33:42PM +0800, Liu Ying wrote:
> This patch allows LVDS PHYs to be configured through
> the generic functions and through a custom structure
> added to the generic union.
> 
> The parameters added here are based on common LVDS PHY
> implementation practices.  The set of parameters
> should cover all potential users.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  include/linux/phy/phy-lvds.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy.h      |  4 ++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 include/linux/phy/phy-lvds.h
> 
> diff --git a/include/linux/phy/phy-lvds.h b/include/linux/phy/phy-lvds.h
> new file mode 100644
> index 00000000..1b5b9d6
> --- /dev/null
> +++ b/include/linux/phy/phy-lvds.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2020 NXP
> + */
> +
> +#ifndef __PHY_LVDS_H_
> +#define __PHY_LVDS_H_
> +
> +/**
> + * struct phy_configure_opts_lvds - LVDS configuration set
> + *
> + * This structure is used to represent the configuration state of a
> + * LVDS phy.
> + */
> +struct phy_configure_opts_lvds {
> +	/**
> +	 * @bits_per_lane_and_dclk_cycle:
> +	 *
> +	 * Number of bits per data lane and differential clock cycle.
> +	 */
> +	unsigned int bits_per_lane_and_dclk_cycle;

I see in patch 4/4 that you only support 7, can the value be any
different ?

> +
> +	/**
> +	 * @differential_clk_rate:
> +	 *
> +	 * Clock rate, in Hertz, of the LVDS differential clock.
> +	 */
> +	unsigned long differential_clk_rate;
> +
> +	/**
> +	 * @lanes:
> +	 *
> +	 * Number of active, consecutive, data lanes, starting from
> +	 * lane 0, used for the transmissions.
> +	 */
> +	unsigned int lanes;
> +
> +	/**
> +	 * @is_slave:
> +	 *
> +	 * Boolean, true if the phy is a slave which works together
> +	 * with a master phy to support dual link transmission,
> +	 * otherwise a regular phy or a master phy.
> +	 */
> +	bool is_slave;
> +};
> +
> +#endif /* __PHY_LVDS_H_ */
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e435bdb..d450b44 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include <linux/phy/phy-dp.h>
> +#include <linux/phy/phy-lvds.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>  
>  struct phy;
> @@ -51,10 +52,13 @@ enum phy_mode {
>   *		the MIPI_DPHY phy mode.
>   * @dp:		Configuration set applicable for phys supporting
>   *		the DisplayPort protocol.
> + * @lvds:	Configuration set applicable for phys supporting
> + *		the LVDS phy mode.
>   */
>  union phy_configure_opts {
>  	struct phy_configure_opts_mipi_dphy	mipi_dphy;
>  	struct phy_configure_opts_dp		dp;
> +	struct phy_configure_opts_lvds		lvds;
>  };
>  
>  /**

-- 
Regards,

Laurent Pinchart
