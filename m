Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174A2AB292
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgKIIjp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 03:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:39:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5ADC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:39:44 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc2i6-0001PF-L5; Mon, 09 Nov 2020 09:39:34 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc2i5-0008NM-B6; Mon, 09 Nov 2020 09:39:33 +0100
Message-ID: <6a9ef496c8360c5d4299aec3621306f1ed246dbb.camel@pengutronix.de>
Subject: Re: [PATCH 6/9] phy: cadence: sierra: Don't configure if any plls
 are already locked
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 09 Nov 2020 09:39:33 +0100
In-Reply-To: <20201103035556.21260-7-kishon@ti.com>
References: <20201103035556.21260-1-kishon@ti.com>
         <20201103035556.21260-7-kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-03 at 09:25 +0530, Kishon Vijay Abraham I wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> Serdes lanes might be shared between multiple cores in some usecases
> and its not possible to lock PLLs for both the lanes independently
> by the two cores. This requires a bootloader to configure both the
> lanes at early boot time.
> 
> To handle this case, skip all configuration if any of the plls are
> already locked. This is done by adding an already_configured flag
> and using it to gate every register access as well as any phy_ops.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 127 ++++++++++++++---------
>  1 file changed, 78 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index e08548417bce..145e42837b7b 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -364,6 +364,10 @@ static const struct phy_ops ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static const struct phy_ops noop_ops = {
> +	.owner		= THIS_MODULE,
> +};
> +
>  static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
>  				    struct device_node *child)
>  {
> @@ -477,6 +481,49 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
>  	return 0;
>  }
>  
> +static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
> +				      struct device *dev)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	sp->clk = devm_clk_get_optional(dev, "phy_clk");
> +	if (IS_ERR(sp->clk)) {
> +		dev_err(dev, "failed to get clock phy_clk\n");
> +		return PTR_ERR(sp->clk);
> +	}
> +
> +	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");

While you're at it, please use devm_reset_control_get_exclusive() here
and ...

> +	if (IS_ERR(sp->phy_rst)) {
> +		dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(sp->phy_rst);
> +	}
> +
> +	sp->apb_rst = devm_reset_control_get_optional(dev, "sierra_apb");

... devm_reset_control_get_optional_exclusive() here.

regards
Philipp
