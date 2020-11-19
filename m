Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0932B8B46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKSGHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgKSGHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:07:33 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2032B24655;
        Thu, 19 Nov 2020 06:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605766052;
        bh=HjLmYtDPTU5OGSkseb0PGaNZhMATkU+AyffVbVJTXUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlO760cZSPUDgPL3DO1U499GCuzdnY9iiAuVKQWSEqvIqBRSGfzMpRhDkIHqfG6J3
         rDD9p0O+lqtJEVlud53g+HmJ1Z6IpXlPI4p4wXvvte1y694BadPVlHKUCzzBwNo5Nr
         1E/pAOD8k9bs8kI0L+NbhsmyVQqDw/rXN9GqNSH8=
Date:   Thu, 19 Nov 2020 11:37:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] phy: Add ethernet serdes configuration option
Message-ID: <20201119060727.GA50232@vkoul-mobl>
References: <20201110144910.558164-1-steen.hegelund@microchip.com>
 <20201110144910.558164-3-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110144910.558164-3-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-20, 15:49, Steen Hegelund wrote:
> Provide a new ethernet phy configuration structure, that
> allow PHYs used for ethernet to be configured with
> speed, media type and clock information.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  include/linux/phy/phy-ethernet-serdes.h | 49 +++++++++++++++++++++++++
>  include/linux/phy/phy.h                 |  4 ++
>  2 files changed, 53 insertions(+)
>  create mode 100644 include/linux/phy/phy-ethernet-serdes.h
> 
> diff --git a/include/linux/phy/phy-ethernet-serdes.h b/include/linux/phy/phy-ethernet-serdes.h
> new file mode 100644
> index 000000000000..04f496855b00
> --- /dev/null
> +++ b/include/linux/phy/phy-ethernet-serdes.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Microchip Sparx5 Ethernet SerDes driver
> + *
> + * Copyright (c) 2020 Microschip Inc
> + */
> +#ifndef __PHY_ETHERNET_SERDES_H_
> +#define __PHY_ETHERNET_SERDES_H_
> +
> +#include <linux/phy.h>
> +
> +enum ethernet_media_type {
> +	ETH_MEDIA_DEFAULT,
> +	ETH_MEDIA_SR,
> +	ETH_MEDIA_DAC,
> +};
> +
> +/**
> + * struct phy_configure_opts_eth_serdes - Ethernet SerDes
> + *
> + * This structure is used to represent the configuration state of a
> + * Ethernet Serdes PHY.
> + */
> +struct phy_configure_opts_eth_serdes {
> +	/**
> +	 * @speed
> +	 *
> +	 * Speed of the serdes interface in Mbps
> +	 */

Can we have this in kernel-doc style pls

> +	u32                        speed;
> +
> +	/**
> +	 * @media_type
> +	 *
> +	 * Specifies which media the serdes will be using
> +	 */
> +	enum ethernet_media_type   media_type;
> +
> +	/**
> +	 * @clk
> +	 *
> +	 * Specifies the serdes clock in MHz
> +	 * Default: 0 will provide the highest supported clock.
> +	 */
> +	u32                        clk;

Why not use std clk interface for this..?

> +};
> +
> +#endif
> +
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e435bdb0bab3..78ecb375cede 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -18,6 +18,7 @@
>  
>  #include <linux/phy/phy-dp.h>
>  #include <linux/phy/phy-mipi-dphy.h>
> +#include <linux/phy/phy-ethernet-serdes.h>
>  
>  struct phy;
>  
> @@ -49,11 +50,14 @@ enum phy_mode {
>   *
>   * @mipi_dphy:	Configuration set applicable for phys supporting
>   *		the MIPI_DPHY phy mode.
> + * @eth_serdes: Configuration set applicable for phys supporting
> + *		the ethernet serdes.
>   * @dp:		Configuration set applicable for phys supporting
>   *		the DisplayPort protocol.
>   */
>  union phy_configure_opts {
>  	struct phy_configure_opts_mipi_dphy	mipi_dphy;
> +	struct phy_configure_opts_eth_serdes	eth_serdes;

Kishon, does this look okay for you..?

>  	struct phy_configure_opts_dp		dp;
>  };
>  
> -- 
> 2.29.2

-- 
~Vinod
