Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C232C8233
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgK3KbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:31:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbgK3KbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:31:20 -0500
Received: from localhost (unknown [122.171.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F253320708;
        Mon, 30 Nov 2020 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606732236;
        bh=+mNAuwEK4cx729Qu4tU7yoERlzupdG5c5Y5WYvAGTC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0A7GnviLclz96J05ChsOdA0314ig1iDpH0YN/t2pYQZzTXe7rkH8g1nAxXipxqWz
         0jiWl5zkry+mjAgEVXHx/2QlK7icSPJCHJO+FTSiyJ2vtnRr7Cpv05/wLllFumUf0a
         4BhrBYDcBRiSWAsOF8Llo7foJOpq7eZx6bJMFCLc=
Date:   Mon, 30 Nov 2020 16:00:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] phy: phy-hi3670-usb3: move driver from staging into
 phy
Message-ID: <20201130103023.GM8403@vkoul-mobl>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
 <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 13:59, Mauro Carvalho Chehab wrote:

> +#define CTRL7_USB2_REFCLKSEL_MASK	(3 << 3)
> +#define CTRL7_USB2_REFCLKSEL_ABB	(3 << 3)
> +#define CTRL7_USB2_REFCLKSEL_PAD	(2 << 3)

This should use GENMASK()
> +
> +#define CFG50_USB3_PHY_TEST_POWERDOWN	BIT(23)
> +
> +#define CFG54_USB31PHY_CR_ADDR_MASK	(0xFFFF)
> +#define CFG54_USB31PHY_CR_ADDR_SHIFT	(16)

We can skip this by using FIELD_GET/FIELD_SET macros and only define
register fields.

> +static int hi3670_phy_cr_start(struct regmap *usb31misc, int direction)
> +{
> +	int ret;
> +
> +	if (direction)
> +		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +					 CFG54_USB31PHY_CR_WR_EN,
> +					 CFG54_USB31PHY_CR_WR_EN);
> +	else
> +		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +					 CFG54_USB31PHY_CR_RD_EN,
> +					 CFG54_USB31PHY_CR_RD_EN);

how about:
        if direction
                reg = CFG54_USB31PHY_CR_WR_EN;
        else
                reg = CFG54_USB31PHY_CR_RD_EN;

        regmap_update_bits(usb31misc, USB_MISC_CFG54, reg, reg);
 
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = hi3670_phy_cr_clk(usb31misc);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +				 CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
> +
> +	return ret;

        return regmap_update_bits()

> +static int hi3670_phy_cr_wait_ack(struct regmap *usb31misc)
> +{
> +	u32 reg;
> +	int retry = 100000;
> +	int ret;
> +
> +	while (retry-- > 0) {
> +		ret = regmap_read(usb31misc, USB_MISC_CFG54, &reg);
> +		if (ret)
> +			return ret;
> +		if ((reg & CFG54_USB31PHY_CR_ACK) == CFG54_USB31PHY_CR_ACK)
> +			return 0;
> +
> +		ret = hi3670_phy_cr_clk(usb31misc);
> +		if (ret)
> +			return ret;

No delay in between reads..? maybe add a small delay and reduce the
retries?

> +static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	ret = regmap_read(usb31misc, USB_MISC_CFG54, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg &= ~(CFG54_USB31PHY_CR_ADDR_MASK << CFG54_USB31PHY_CR_ADDR_SHIFT);
> +	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) << CFG54_USB31PHY_CR_ADDR_SHIFT);
> +	ret = regmap_write(usb31misc, USB_MISC_CFG54, reg);

regmap_update_bits() ?

> +static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
> +{
> +	u32 reg;
> +
> +	if (!priv->sctrl) {
> +		dev_err(priv->dev, "priv->sctrl is null!\n");
> +		return 1;
> +	}
> +
> +	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
> +		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
> +		return 1;

Not a -ve error code?
-- 
~Vinod
