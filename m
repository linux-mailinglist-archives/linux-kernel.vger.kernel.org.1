Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228382844D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgJFE35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:29:57 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51071 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgJFE35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:29:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 96EB4B71;
        Tue,  6 Oct 2020 00:29:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Oct 2020 00:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=O
        gunnOPU5TZgY+LR2TgnjixNIBSougDwiN6w4vb8NMw=; b=KlkflhTKxulHvL4Am
        i8i9u2jZqtRxQUxJ/VCot7MdSltfVjKsPw1pKFJct81nUFI8mE8cZvmF7NHZQbMR
        iqPSLUcQeCAF5kvrzm3TGZdV/jpAGjqVDqXcPIguc7lb5d4+XYOXKL9G4WEJOjTo
        GNRDPc69XvZ6OBTbPvYrtcXYWOsKRye64CMBOrOSYVuRLOJl6MLbsqbtVpDEHOjC
        ti1+wOlh9LlYOvKA/zrCsB3kQ8LpMFFDbjpmXKzT7vV+zAz7fGH3B+V02nicOySt
        wGT80x5/KsTpWiyaXf69WIGNQJSTJNA3p2xEi6HMS0fDgik/n7kAkkNUpKXauOXE
        tNZyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=OgunnOPU5TZgY+LR2TgnjixNIBSougDwiN6w4vb8N
        Mw=; b=onqZ37wwH9j85j/YPARMW1TlYusNfqMt/cx5Qv5OF0iwd1A7FvIoo5iZ4
        8V9mU4yiHS0+4zw2cLShOC2nwthK+HxeUF8Z4DGc0I0lV4CDid6v3U4NY7Nqt/YU
        xmVff/ZWQFNSyt8r0D/hWHuUkRbopneNsfUv9OGaQMy/Iir3GRPOXnWq7U09KFr1
        c9SiumO1/n0dahptqJ+ScOYgm9u3TUXGkcM2adQGh5nd0E2xicGQ04MlLssTYObB
        9YSScaYwpoEFRRyMq1fwWwwejpKVQ8pnD7ZmrsOZJu6vkpA57AEoB2DcNw4votWF
        PKHme4ckDZNjilLQGXqc/+OgYjHZg==
X-ME-Sender: <xms:wPJ7X3q5JJcEm_FPikBWOmhDU2gZyCx0gQJ_RteXNPt5vdlcVF3JQw>
    <xme:wPJ7XxqxtGkDOePSKhWrxO71zIwY9rAbLz5a9cS74mmP4vBMzMbdd_c45t8p-SBPo
    adu5ffTeBHnMxn3Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeefgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeehnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeettdekiedvgeetfeelueduhefftdfhkeehueejvefhtddvffejleeu
    hfeuhfevkeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:wPJ7X0McZSBebvxKFUQxqSb6PQFtuPHXvmygitdIt_wi8jd_t2SHNQ>
    <xmx:wPJ7X66mGA8LBqLzQHLOsxW50lnf0AbfZ0j-eXui0sqjqf72j-FAZQ>
    <xmx:wPJ7X24Q61s-qMCaqc39TtS4NfE0H-JWctUuNLdSrJmvbrq7KBW9iw>
    <xmx:w_J7X9a1dDJHYU4k4XrI4-BGARgRJEf0U1N6_0B9shqSW_Fvz_3MFw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 209A5306467E;
        Tue,  6 Oct 2020 00:29:52 -0400 (EDT)
Subject: Re: [PATCH 11/25] ASoC: sun8i-codec: Enable all supported clock
 inversions
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-12-samuel@sholland.org>
 <20201005113015.acp2gascxkytl7z4@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7b8206b6-ccd8-6d70-6210-fb7d79a330a3@sholland.org>
Date:   Mon, 5 Oct 2020 23:29:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005113015.acp2gascxkytl7z4@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/20 6:30 AM, Maxime Ripard wrote:
> On Wed, Sep 30, 2020 at 09:11:34PM -0500, Samuel Holland wrote:
>> When using the I2S, LEFT_J, or RIGHT_J format, the hardware supports
>> independent BCLK and LRCK inversion control. When using DSP_A or DSP_B,
>> LRCK inversion is not supported. The register bit is repurposed to
>> select between DSP_A and DSP_B. Extend the driver to support this.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>   sound/soc/sunxi/sun8i-codec.c | 57 +++++++++++++++++++++++------------
>>   1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
>> index 0b713b2a2028..506420fb355c 100644
>> --- a/sound/soc/sunxi/sun8i-codec.c
>> +++ b/sound/soc/sunxi/sun8i-codec.c
>> @@ -39,18 +39,17 @@
>>   #define SUN8I_MOD_RST_CTL_AIF1				15
>>   #define SUN8I_MOD_RST_CTL_ADC				3
>>   #define SUN8I_MOD_RST_CTL_DAC				2
>>   #define SUN8I_SYS_SR_CTRL				0x018
>>   #define SUN8I_SYS_SR_CTRL_AIF1_FS			12
>>   #define SUN8I_SYS_SR_CTRL_AIF2_FS			8
>>   #define SUN8I_AIF1CLK_CTRL				0x040
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD		15
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV		14
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV			13
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
>>   #define SUN8I_AIF1_ADCDAT_CTRL				0x044
>>   #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA		15
>>   #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA		14
>> @@ -85,16 +84,17 @@
>>   #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
>>   #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
>>   #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
>>   
>>   #define SUN8I_SYSCLK_CTL_AIF1CLK_SRC_MASK	GENMASK(9, 8)
>>   #define SUN8I_SYSCLK_CTL_AIF2CLK_SRC_MASK	GENMASK(5, 4)
>>   #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
>>   #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK	GENMASK(14, 13)
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
>>   #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
>>   
>>   enum {
>>   	AIF1,
>>   	NAIFS
>> @@ -168,17 +168,17 @@ static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
>>   	default:
>>   		return -EINVAL;
>>   	}
>>   }
>>   
>>   static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>   {
>>   	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
>> -	u32 format, value;
>> +	u32 format, invert, value;
>>   
>>   	/* clock masters */
>>   	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>   	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
>>   		value = 0x1;
>>   		break;
>>   	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
>>   		value = 0x0;
>> @@ -197,55 +197,72 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>   		break;
>>   	case SND_SOC_DAIFMT_LEFT_J:
>>   		format = 0x1;
>>   		break;
>>   	case SND_SOC_DAIFMT_RIGHT_J:
>>   		format = 0x2;
>>   		break;
>>   	case SND_SOC_DAIFMT_DSP_A:
>> +		format = 0x3;
>> +		invert = 0x0; /* Set LRCK_INV to 0 */
>> +		break;
>>   	case SND_SOC_DAIFMT_DSP_B:
>>   		format = 0x3;
>> +		invert = 0x1; /* Set LRCK_INV to 1 */
>>   		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>>   	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>>   			   SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK,
>>   			   format << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
>>   
>>   	/* clock inversion */
>>   	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>>   	case SND_SOC_DAIFMT_NB_NF: /* Normal */
>>   		value = 0x0;
>>   		break;
>> -	case SND_SOC_DAIFMT_IB_IF: /* Inversion */
>> +	case SND_SOC_DAIFMT_NB_IF: /* Inverted LRCK */
>>   		value = 0x1;
>>   		break;
>> +	case SND_SOC_DAIFMT_IB_NF: /* Inverted BCLK */
>> +		value = 0x2;
>> +		break;
>> +	case SND_SOC_DAIFMT_IB_IF: /* Both inverted */
>> +		value = 0x3;
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> -	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>> -			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV),
>> -			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
>>   
>> -	/*
>> -	 * It appears that the DAI and the codec in the A33 SoC don't
>> -	 * share the same polarity for the LRCK signal when they mean
>> -	 * 'normal' and 'inverted' in the datasheet.
>> -	 *
>> -	 * Since the DAI here is our regular i2s driver that have been
>> -	 * tested with way more codecs than just this one, it means
>> -	 * that the codec probably gets it backward, and we have to
>> -	 * invert the value here.
>> -	 */
>> -	value ^= scodec->quirks->lrck_inversion;
>> +	if (format == 0x3) {
> 
> Could we use a define here? That would be more readable

Yes, I can do that.

>> +		/* Inverted LRCK is not available in DSP mode. */
>> +		if (value & BIT(0))
>> +			return -EINVAL;
> 
> And same thing here, explicitly testing both for DSP_A and DSP_B would
> be more readable.

Here, `value & BIT(0)` means SND_SOC_DAIFMT_NB_IF ||
SND_SOC_DAIFMT_IB_IF, not selecting the DSP format.

> (And I guess value isn't such a great variable name anymore either)

If I rename `invert` to `dsp_format`, and replace `value` here with
`invert`, I think that would be more clear.

> Maxime

Cheers,
Samuel
