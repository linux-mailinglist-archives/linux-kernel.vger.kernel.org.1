Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA81326B360
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgIOXCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:02:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42518 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgIOXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:02:07 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80130FD8;
        Wed, 16 Sep 2020 01:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600210924;
        bh=XL0LdDZFk6PVitZQq0bSlTOU6KHA2rzYD841J7aWOgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vatsIyONG2G/6qUZzaDbg18NCXiULjn93+aOibQiFzpr2DIpQqZBK3CaT65z7Cm3p
         0yhdIOODXc4FSL/b2r4xHLkVcZOlK74sx1AhEeu0JXHQ2vcCMsWbSoEebB5ViREMK6
         TtzzSnptoKScPjvDaGi/WNHRn62xAnko6PwECq/c=
Date:   Wed, 16 Sep 2020 02:01:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, mparab@cadence.com, yamonkar@cadence.com,
        nsekhar@ti.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v6 2/2] phy: cadence-torrent: Set Torrent PHY attributes
Message-ID: <20200915230135.GC14954@pendragon.ideasonboard.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <1599805114-22063-3-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599805114-22063-3-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

Thank you for the patch.

On Fri, Sep 11, 2020 at 08:18:34AM +0200, Swapnil Jakhade wrote:
> Set Torrent PHY attributes bus_width, max_link_rate and mode
> for DisplayPort.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
> index 7116127358ee..116aca36f7dd 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -1852,6 +1852,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
>  				 cdns_phy->phys[node].num_lanes,
>  				 cdns_phy->max_bit_rate / 1000,
>  				 cdns_phy->max_bit_rate % 1000);
> +
> +			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
> +			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
> +			gphy->attrs.mode = PHY_MODE_DP;
>  		} else {
>  			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
>  			ret = -ENOTSUPP;

-- 
Regards,

Laurent Pinchart
