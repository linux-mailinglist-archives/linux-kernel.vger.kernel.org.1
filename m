Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5126B328
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgIOXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:01:13 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42504 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIOXA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:00:59 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5E83FD8;
        Wed, 16 Sep 2020 01:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1600210852;
        bh=R2YPgFaI54/XyuJxozYLFqOHh3iMAzSHqn5Bq5WoLt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOdgP9nfKYcs63UINbFv/M+atakst3oC6zev0iCddBB183gSN4m0W5wssZALUhMWh
         8qrl5G0DRu1cD6Spinwd4arURY9idCLn05QhGQHW44SIWRRJyW3lz50A6u3volGD7v
         unW1BC2HAjcF83nbendjFE/mGugnIpVW6TbNkrmc=
Date:   Wed, 16 Sep 2020 02:00:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, mparab@cadence.com, yamonkar@cadence.com,
        nsekhar@ti.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v6 1/2] phy: Add new PHY attribute max_link_rate
Message-ID: <20200915230022.GB14954@pendragon.ideasonboard.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <1599805114-22063-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599805114-22063-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

Thank you for the patch.

On Fri, Sep 11, 2020 at 08:18:33AM +0200, Swapnil Jakhade wrote:
> Add new PHY attribute max_link_rate to struct phy_attrs. This indicates
> maximum link rate supported by PHY (in Mbps).
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/phy/phy.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..e435bdb0bab3 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -115,10 +115,12 @@ struct phy_ops {
>  /**
>   * struct phy_attrs - represents phy attributes
>   * @bus_width: Data path width implemented by PHY
> + * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
>   * @mode: PHY mode
>   */
>  struct phy_attrs {
>  	u32			bus_width;
> +	u32			max_link_rate;
>  	enum phy_mode		mode;
>  };
>  

-- 
Regards,

Laurent Pinchart
