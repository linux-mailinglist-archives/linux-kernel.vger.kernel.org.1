Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22362B3DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKPHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgKPHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:32:44 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9DB2224F;
        Mon, 16 Nov 2020 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605511963;
        bh=gcJcac9u3R1uqW1nIhiT9WQ5y+7r3mBsbuZrSsKJHZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PH6ao4hl3AOvati2msPnVVS3sXLrDHg2Tf5bztiBC1cXOZyub316no/Pq8e5KEJCh
         4dKmuwQPoH3WZIfGcxlQmYKRZsbbqzQ1xpXX/C7gpt9TYo+uK4JP6gjxESQXaQZakJ
         hXdjdzD5k1Ter5p1zqwcc4Or0cSAfltZa0XD8tCw=
Date:   Mon, 16 Nov 2020 13:02:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/9] phy: cadence: Sierra: Fix PHY power_on sequence
Message-ID: <20201116073239.GJ7499@vkoul-mobl>
References: <20201103035556.21260-1-kishon@ti.com>
 <20201103035556.21260-6-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103035556.21260-6-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-20, 09:25, Kishon Vijay Abraham I wrote:
> Commit 44d30d622821d ("phy: cadence: Add driver for Sierra PHY")
> de-asserts PHY_RESET even before the configurations are loaded in
> phy_init(). However PHY_RESET should be de-asserted only after
> all the configurations has been initialized, instead of de-asserting
> in probe. Fix it here.

Move this up in series..? Also I think we should apply this to fixes and
perhaps cc stable..?

> 
> Fixes: 44d30d622821d ("phy: cadence: Add driver for Sierra PHY")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index 4429f41a8f58..e08548417bce 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -319,6 +319,12 @@ static int cdns_sierra_phy_on(struct phy *gphy)
>  	u32 val;
>  	int ret;
>  
> +	ret = reset_control_deassert(sp->phy_rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to take the PHY out of reset\n");
> +		return ret;
> +	}
> +
>  	/* Take the PHY lane group out of reset */
>  	ret = reset_control_deassert(ins->lnk_rst);
>  	if (ret) {
> @@ -621,7 +627,6 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(dev);
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> -	reset_control_deassert(sp->phy_rst);
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  
>  put_child:
> -- 
> 2.17.1

-- 
~Vinod
