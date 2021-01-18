Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0C2F9854
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbhARDiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:38:15 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56307 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbhARDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:38:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8A4D85806B2;
        Sun, 17 Jan 2021 22:37:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 17 Jan 2021 22:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=E
        cx99SPjrWKyu8afk7WpXbbqCEB/A8hAajBsWrrh+fA=; b=ClWtvtN6OLMi0OFmU
        bMvCLyCAqn58YRlvVKSCtgFeB86QIj7sGTu77WJdapK9t6gzaas9DXTNEfZcG3xK
        vdpmsuAk3yXmCx7H1HMMdh0rBn4YKpIoc2Efxm/xtt0aQChFvince4rG2fN/czBL
        Ee1fFSAkwejkU4GeZAjcrr4AV1wmgQHVze6Xe3rcea1m9T4TL0LVlMNJOFUL1eYq
        T/Ii4n7SBi8cysoituKdT8kkpvQgnfKe5EeqnrM0TU+7yvWqnLqSe/rIB+iujZ8l
        kJ96q+gAisMsbpQKePog+EOSkytbpD33HqYuXkvL3ZdejX/6I1NRHrdZ+vW6SfXM
        67kMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Ecx99SPjrWKyu8afk7WpXbbqCEB/A8hAajBsWrrh+
        fA=; b=p/qRgieZfRYsRRRdh4MgPY7N5V/xdEKtAIN7He8JcHArmZ7/ZCQz4pZEx
        7lMp5W+eeFEAMf7Pp8xA7GnWxeMsFiQOhIUXbnXwMri/S593XcGwmyWzsLPwRvbn
        KgtkxEeJio0UXPDduqtkq4lB81dy9J2RxPNLbVBM1mO/Kw0c0W/le0JJw/nBEWLJ
        i6zL5b/aNgHP89cYv5fcK13VoI4fOB2ybaDGDjyQvqIMqpeLB6B+fS9JeWrFHWWn
        Vu2zSo9fLQGunoOd+Q1eDJjQzjfbGTQ/nPu4jYzzDgTlOTQQPFBwZDs6sELzcqS0
        nzCtXvXdLOKqU0Ia/f68gCA6tW+og==
X-ME-Sender: <xms:cwIFYFN2jO-fWqgu_FPdALC7FcVzVcKZ-JQPkQc5zqlmxiskK-HEiw>
    <xme:cwIFYH8Pl4dZ-HpqlcyKRZx6kWMuraZMYE3YIUIz1jqbn4g5I1HSu7eFFB-QNLn2R
    uH_q-mpKNvUmDl5uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtjeeiuddugfffveetkeffgeffgedutdfgfeekudevudekffeh
    tdefveeuvdenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:cwIFYEQLstVIKb36_T1ynrEc0jIYADEAFQMImsKd-VU0J7oO8R5e9g>
    <xmx:cwIFYBtQgZITZ8qUIQ4QGu3esxaSIdrwRiLBQevHVJZRvERLjcBrRA>
    <xmx:cwIFYNchLw53D-6zR4QTh_gzKrwOsepQxc0y0BNh4wnQ01tEtp0Vag>
    <xmx:dQIFYN2ydu3uMZgUzbNs2pMGe0FUrg_GR4fgaE_xrTS6m7Iq6FSSpQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 309691080057;
        Sun, 17 Jan 2021 22:37:23 -0500 (EST)
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Lee Jones <lee.jones@linaro.org>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-10-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 09/21] mfd: axp20x: Allow AXP chips without interrupt
 lines
Message-ID: <b3d1cc46-3311-ba1a-f71a-37096ed1bfa8@sholland.org>
Date:   Sun, 17 Jan 2021 21:37:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210118020848.11721-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/21 8:08 PM, Andre Przywara wrote:
> Currently the AXP chip requires to have its IRQ line connected to some
> interrupt controller, and will fail probing when this is not the case.
> 
> On a new Allwinner SoC (H616) there is no NMI pin anymore, so the
> interrupt functionality of the AXP chip is simply not available.
> 
> Check whether the DT describes the AXP chip as an interrupt controller
> before trying to register the irqchip, to avoid probe failures on
> setups without an interrupt.

The AXP305 has an IRQ pin. It is still an interrupt controller, even if
its output is not connected anywhere. And even though the NMI pin on the
H616 is gone, the PMIC IRQ line could be connected to a GPIO. So it is
not appropriate to remove "interrupt-controller".

Per the binding, both "interrupts" and "interrupt-controller" are
required properties. It would make more sense to make "interrupts"
optional. Either way, you need to update the binding.

Though I'm concerned about how this may affect drivers for regmap cells
which use interrupts (such as axp20x-pek). If the irqchip is not
registered, requesting those interrupts will fail. While I don't
currently know of any boards that have the AXP305 power key wired up, it
prevents us from modelling the hardware correctly and supporting that
configuration.

Cheers,
Samuel

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index aa59496e4376..a52595c49d40 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -959,12 +959,17 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>  				     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
>  	}
>  
> -	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> -			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
> -			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
> -	if (ret) {
> -		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
> -		return ret;
> +	if (!axp20x->dev->of_node ||
> +	    of_property_read_bool(axp20x->dev->of_node, "interrupt-controller")) {
> +		ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
> +				IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
> +				-1, axp20x->regmap_irq_chip,
> +				&axp20x->regmap_irqc);
> +		if (ret) {
> +			dev_err(axp20x->dev, "failed to add irq chip: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> 

