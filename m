Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322C726C93A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgIPTF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgIPRqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:46:20 -0400
Received: from localhost (unknown [122.172.186.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD05221EB;
        Wed, 16 Sep 2020 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600261557;
        bh=PImqcFtzvvSk4TPQwCNpCjFClWEk9Y7NrcjrlDub7Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMygxyah/1wVclzSw+uMchV9nGXWDuGh46jBjSbIxCmUbvbuQyntyvrrpn9OS+tjv
         locWYncScFSvdN5gH3LoESwjadrMnSpSdu1vWwHFSe+R1y6jGl4g1EXmkrLR1Y55cF
         dkFF9vlZQqdamTY6SMqFLLjRtZpATBXdSWrXcZZQ=
Date:   Wed, 16 Sep 2020 18:35:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 1/8] phy: hisilicon: add USB physical layer for
 Kirin 3670
Message-ID: <20200916130553.GO2968@vkoul-mobl>
References: <cover.1599826421.git.mchehab+huawei@kernel.org>
 <2bcc14afcbd1cc8972ab8f1a561a13aae04b881a.1599826421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcc14afcbd1cc8972ab8f1a561a13aae04b881a.1599826421.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-20, 14:16, Mauro Carvalho Chehab wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> Add the Hisilicon Kirin 3670 USB phy driver just after the
> hi3660, using the same namespace.
> 
> This driver was imported from Linaro's official Hikey 970
> tree, from the original patch, removing the addition of
> the dwg3-specific parts.
> 
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/phy-hi3670-usb3.txt          |  25 +
>  drivers/phy/hisilicon/Kconfig                 |  10 +
>  drivers/phy/hisilicon/Makefile                |   1 +
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 682 ++++++++++++++++++
>  4 files changed, 718 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> new file mode 100644
> index 000000000000..4cb02612ff23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt

Not yaml bindings?

> +#define CTRL0_USB3_VBUSVLD		BIT(7)
> +#define CTRL0_USB3_VBUSVLD_SEL		BIT(6)
> +
> +#define CTRL3_USB2_VBUSVLDEXT0		BIT(6)
> +#define CTRL3_USB2_VBUSVLDEXTSEL0	BIT(5)
> +
> +#define CTRL5_USB2_SIDDQ		BIT(0)
> +
> +#define CTRL7_USB2_REFCLKSEL_MASK	(3 << 3)
> +#define CTRL7_USB2_REFCLKSEL_ABB	(3 << 3)
> +#define CTRL7_USB2_REFCLKSEL_PAD	(2 << 3)

GENMASK() for these please?

> +
> +#define CFG50_USB3_PHY_TEST_POWERDOWN	BIT(23)
> +
> +#define CFG54_USB31PHY_CR_ADDR_MASK	(0xFFFF)

Here and other places as well

> +#define CFG54_USB31PHY_CR_ADDR_SHIFT	(16)

Okay we should get rid of all shift define. See <linux/bitfield.h> it
has FIELD_PREP, xxx_encode_bits() you can use these to program teh bit
fields

> +static int kirin970_phy_cr_clk(struct regmap *usb31misc)
> +{
> +	int ret;
> +
> +	/* Clock up */
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +			CFG54_USB31PHY_CR_CLK, CFG54_USB31PHY_CR_CLK);
> +	if (ret)
> +		return ret;
> +
> +	/* Clock down */
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +			CFG54_USB31PHY_CR_CLK, 0);
> +
> +	return ret;

        return regmap_update_bits()

> +static int kirin970_phy_cr_start(struct regmap *usb31misc, int direction)
> +{
> +	int ret;
> +
> +	if (direction)
> +		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +			CFG54_USB31PHY_CR_WR_EN, CFG54_USB31PHY_CR_WR_EN);
> +	else
> +		ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +			CFG54_USB31PHY_CR_RD_EN, CFG54_USB31PHY_CR_RD_EN);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = kirin970_phy_cr_clk(usb31misc);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +			CFG54_USB31PHY_CR_RD_EN | CFG54_USB31PHY_CR_WR_EN, 0);
> +
> +	return ret;

here as well

> +static int kirin970_phy_cr_wait_ack(struct regmap *usb31misc)
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
> +		ret = kirin970_phy_cr_clk(usb31misc);
> +		if (ret)
> +			return ret;

no delay here while checking?

> +static int kirin970_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
> +{
> +	u32 reg;
> +	int ret;
> +
> +	ret = regmap_read(usb31misc, USB_MISC_CFG54, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg &= ~(CFG54_USB31PHY_CR_ADDR_MASK << CFG54_USB31PHY_CR_ADDR_SHIFT);
> +	reg |= ((addr & CFG54_USB31PHY_CR_ADDR_MASK) <<
> +			CFG54_USB31PHY_CR_ADDR_SHIFT);

u32_replace_bits() looks apt here

> +static int kirin970_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
> +{
> +	int reg;
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < 100; i++) {
> +		ret = kirin970_phy_cr_clk(usb31misc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = kirin970_phy_cr_set_sel(usb31misc);
> +	if (ret)
> +		return ret;
> +
> +	ret = kirin970_phy_cr_set_addr(usb31misc, addr);
> +	if (ret)
> +		return ret;
> +
> +	ret = kirin970_phy_cr_start(usb31misc, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = kirin970_phy_cr_wait_ack(usb31misc);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(usb31misc, USB_MISC_CFG58, &reg);
> +	if (ret)
> +		return ret;

Do you really care about each step error check? if not, we can have:
        ret |= step_1;
        ret |= step_n;

        if (ret)
                ...

> +static int kirin970_phy_init(struct phy *phy)
> +{
> +	struct kirin970_priv *priv = phy_get_drvdata(phy);
> +	u32 val;
> +	int ret;
> +
> +	kirin970_phy_exit(phy);
> +	dev_info(priv->dev, "%s in\n", __func__);

Lower to debug level?

> +	/* assert controller */
> +	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret = kirin970_config_phy_clock(priv);
> +	if (ret)
> +		goto out;
> +
> +	/* Exit from IDDQ mode */
> +	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL5,
> +			CTRL5_USB2_SIDDQ, 0);
> +	if (ret)
> +		goto out;
> +
> +	/* Release USB31 PHY out of TestPowerDown mode */
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG50,
> +			CFG50_USB3_PHY_TEST_POWERDOWN, 0);
> +	if (ret)
> +		goto out;
> +
> +	/* Tell the PHY power is stable */
> +	val = CFG54_USB3_PHY0_ANA_PWR_EN | CFG54_PHY0_PCS_PWR_STABLE |
> +		CFG54_PHY0_PMA_PWR_STABLE;
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG54,
> +			val, val);
> +	if (ret)
> +		goto out;
> +
> +	ret = kirin970_config_tca(priv);
> +	if (ret)
> +		goto out;
> +
> +	/* Enable SSC */
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFG5C,
> +			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN,
> +			CFG5C_USB3_PHY0_SS_MPLLA_SSC_EN);
> +	if (ret)
> +		goto out;
> +
> +	/* Deassert phy */
> +	val = CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
> +	if (ret)
> +		goto out;
> +
> +	udelay(100);
> +
> +	/* Deassert controller */
> +	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
> +	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
> +	if (ret)
> +		goto out;
> +
> +	udelay(100);
> +
> +	/* Set fake vbus valid signal */
> +	val = CTRL0_USB3_VBUSVLD | CTRL0_USB3_VBUSVLD_SEL;
> +	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL0, val, val);
> +	if (ret)
> +		goto out;
> +
> +	val = CTRL3_USB2_VBUSVLDEXT0 | CTRL3_USB2_VBUSVLDEXTSEL0;
> +	ret = regmap_update_bits(priv->usb31misc, USB3OTG_CTRL3, val, val);
> +	if (ret)
> +		goto out;
> +
> +	udelay(100);
> +
> +	ret = kirin970_phy_set_params(priv);
> +	if (ret)
> +		goto out;
> +
> +	{
> +		ret = regmap_read(priv->peri_crg, 0x4c,
> +				&val);
> +		if (!ret)
> +			dev_info(priv->dev, "peri_crg 0x4c %x\n", val);
> +		ret = regmap_read(priv->peri_crg, 0x404,
> +				&val);
> +		if (!ret)
> +			dev_info(priv->dev, "peri_crg 0x404 %x\n", val);
> +		ret = regmap_read(priv->peri_crg, 0xc,
> +				&val);
> +		if (!ret)
> +			dev_info(priv->dev, "peri_crg 0xc %x\n", val);
> +		ret = regmap_read(priv->peri_crg, 0xac,
> +				&val);
> +		if (!ret)
> +			dev_info(priv->dev, "peri_crg 0xac %x\n", val);
> +		ret = regmap_read(priv->pctrl, 0x10,
> +				&val);
> +		if (!ret)
> +			dev_info(priv->dev, "pctrl 0x10 %x\n", val);
> +	}

Whats with the funny braces and one more level on indentation here ?

-- 
~Vinod
