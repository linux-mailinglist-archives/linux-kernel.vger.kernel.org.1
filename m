Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82E7271736
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgITSpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:45:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36767 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgITSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:45:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 734665800A9;
        Sun, 20 Sep 2020 14:39:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 20 Sep 2020 14:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=q
        9LjqQuD0m3VNCG1Acv1s+EmnUPB8l6B4L2HRjljxOk=; b=puY2r3WyE0AASRWz1
        7Z8O4T944qKgLSqFYshvCFEcZMOt9yVQ74nR0wnuc+bij63vaaxknNskJplHezWR
        XlDDeH3M6S+6LFxnNvzdsrZgSYj9lbXFyjZGbpSLBaoFRIQXiHJ+d0bFYtj5EDoL
        eUf90xRO5u9I554o2jlILBOmGTZ1v2HpSqHEjlGH2KMyOOPJEVWcgnNgyQY6uUub
        G5Lfbd4hKrBJ1npCYhvthfanZcq/8Z6LuCj7o3J1/qcvgacByNsuHfnv9PvCH1+w
        u80jMKlbnYAJLyPICVCCyvphok7NJQb3EpYoO1qA4n+TM5V4GV/cScK9x1OmFTep
        hgIKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=q9LjqQuD0m3VNCG1Acv1s+EmnUPB8l6B4L2HRjljx
        Ok=; b=Wcl1lesvyzOoS0zLnn8esyo55xDwPg20NoWI5R4QXylmACuXc9FqLAQIu
        1FVauA2BvZVDQjA4Vb4k+TzP6KR/agSCp/EjDkqopOalACTTLKwXBIv24bK+n+BE
        zR7H/hqBIx3X3YZPqL0AB32moNYz72SutL1uauXKgSQ5HMVM7P1/PygGMIV/3CpJ
        EW1VPN4tlk+hy1GF8yQWHp/HQ2Ut5HQEA1gg7akmSb8BkA/cIEIY+NU9rbowPmcb
        2yplKIg+DOUDKbzakZhi9OVLCOXS+GL9ohCCYm3Y0NPktp2xN2D9wAGmtiIhHliO
        s18AXWwykRC1ElRtKlTJdK3m012Kg==
X-ME-Sender: <xms:1KFnX5xlvtfb9t0EZ3nWFPbecXCytMzgRK-s4fW9m57b6lsa7gGp6Q>
    <xme:1KFnX5SHIScDEEBj1VGrmVHLHSyKB-7Z4vnRYyZcl2CT-dzmZY1jdzBBv1yfr1uYO
    cK_R2U0JyUCrPfK7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:1KFnXzUK5hQhVCg1flQtNGOikpDVSMzoHtnodlskrZYcmJ2YXdDWzA>
    <xmx:1KFnX7hi3TZbwX9H5dRVEtBAYoTMctT5ST3q60rJ2KFJzyxGqnHyXQ>
    <xmx:1KFnX7Ac2BBwOytnFIfWWOuhDEldc82MqN5fu8DQD78FmUvhH5JqzQ>
    <xmx:1qFnX_7YQ6N9NBehLf8FBnXKKViUqGaz-UqS-80l2uahwWoZ9ZC6wA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04BA4328005D;
        Sun, 20 Sep 2020 14:39:15 -0400 (EDT)
Subject: Re: [PATCH v3 01/19] ASoC: sun4i-i2s: Add support for H6 I2S
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200920180758.592217-1-peron.clem@gmail.com>
 <20200920180758.592217-2-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e0eb7e94-e736-4ec0-b838-884a4857bb97@sholland.org>
Date:   Sun, 20 Sep 2020 13:39:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200920180758.592217-2-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/20 1:07 PM, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 I2S is very similar to that in H3, except it supports up to 16
> channels.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 218 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 218 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index f23ff29e7c1d..348057464bed 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
...
> @@ -699,6 +770,102 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
>  	return 0;
>  }
>  
> +static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> +				     unsigned int fmt)
> +{
> +	u32 mode, val;
> +	u8 offset;
> +
> +	/* DAI clock polarity */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_IB_IF:
> +		/* Invert both clocks */
> +		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
> +		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		/* Invert bit clock */
> +		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		/* Invert frame clock */
> +		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
> +		break;
> +	case SND_SOC_DAIFMT_NB_NF:
> +		val = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Maxime's testing that showed LRCK inversion was necessary was done on the H6. So
in addition to dropping the patch that removed the LRCK inversion for other
sun8i variants, you need to re-add it to this patch for the H6 variant.

Cheers,
Samuel

> +
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> +			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
> +			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
> +			   val);
> +
> +	/* DAI Mode */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_DSP_A:
> +		mode = SUN8I_I2S_CTRL_MODE_PCM;
> +		offset = 1;
> +		break;
> +
> +	case SND_SOC_DAIFMT_DSP_B:
> +		mode = SUN8I_I2S_CTRL_MODE_PCM;
> +		offset = 0;
> +		break;
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		mode = SUN8I_I2S_CTRL_MODE_LEFT;
> +		offset = 1;
> +		break;
> +
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		mode = SUN8I_I2S_CTRL_MODE_LEFT;
> +		offset = 0;
> +		break;
> +
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
> +		offset = 0;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN8I_I2S_CTRL_MODE_MASK, mode);
> +	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
> +	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> +			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
> +
> +	/* DAI clock master masks */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		/* BCLK and LRCLK master */
> +		val = SUN8I_I2S_CTRL_BCLK_OUT |	SUN8I_I2S_CTRL_LRCK_OUT;
> +		break;
> +
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		/* BCLK and LRCLK slave */
> +		val = 0;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
> +			   val);
> +
> +	return 0;
> +}
> +
>  static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  {
>  	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
...
