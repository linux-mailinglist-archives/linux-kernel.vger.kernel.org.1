Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1C28451A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgJFEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:51:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43527 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbgJFEvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:51:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 293A97EC;
        Tue,  6 Oct 2020 00:51:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Oct 2020 00:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=g
        sBJnWfwSU0Xfg4NcHu+3go3rMQ82ojMact0v3CsQF0=; b=jWjAX2EJCfIgo7JL+
        Yxb6FbbQRPUsdY1yez85cgdGa2xH9Lobs9926fjfNhhuJug//e2eQUX5mUKu29mI
        Z+8iePQquaZz2XPWO5COJ9yQxnhet46RPwElzdZJjN8nC+Ybz1a41+cyyrRiSUC8
        MDhttJ8LRERokqABpzWQ/pV153tdrPSvpyyZMXyshQg1GaXghknnMP7o+QsiM54Q
        lBIAcYdN3SPsiUjjXqwojVguN2i2vkWhHsG1go9UK17RDPmKHDmM56QtN9obbmYu
        cynT9ozkFRuUULkmLwImoCw4EH+dRZBRpOjNQ+yPzhB3AVjob+3CzZeASmti239+
        dkkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=gsBJnWfwSU0Xfg4NcHu+3go3rMQ82ojMact0v3CsQ
        F0=; b=q3SOVQz1zWe8sKUH/McjpL792uTVOlgAVnX5RK4LY1BBx4tZZVqjZU2Io
        6o2iRk2SRfbzRTp9dUcPJfCIyyyKPmURBdZRJBms6jYkuxW/ykamq6Pj6g/ne3v8
        IVFhdZbhzGlks10BP8ecBWtlXy/ZGa+w34mhwT8W5oQGczhCGZ64oXxrfXkiqnF3
        drJARsosq47zSuNfcfxC8vosWJUiTfZ4wcfHdkeB45y9aLlgCFsoU4yjG1BVRKXn
        dS03USErj70/qWQbRGXqlE5rSTbiyLeS+iNCXjHDLt+61ISIxYcpFTgqJ1ZDjVza
        44qay9MDS98V5NPARrspKd8vEKYIg==
X-ME-Sender: <xms:vfd7XwW4qYjrUSGtLLbJsob8wRv2w43kxTESpaPd63aWVLWzfL8cwA>
    <xme:vfd7X0n0Ke63dQa2phnRVM11VQd_F0LYiAdFzD5Hb1R2UQDGE8-4PISV2BO28TWgM
    0e4dddTCdZ551NY3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeehnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeettdekiedvgeetfeelueduhefftdfhkeehueejvefhtddvffejleeu
    hfeuhfevkeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:vfd7X0bxApKkamUpJeEJxvBDJnfyXJfy_4e2J3rr8dHvtihkjPZt5w>
    <xmx:vfd7X_UKcTXmcaJkFoPWLS7T-JYfeFJU5LvKx0TTCzNW1w0z5S6O8w>
    <xmx:vfd7X6mMGR3bnAYlOTFdehy40eFQH_vHx811hh3MCMJp3WeCFutZFw>
    <xmx:v_d7X8UiDdDE2PvM2ikevCJW60UqGe-gljx2aziwmtqZnHBbbvq4wQ>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFD0B306467E;
        Tue,  6 Oct 2020 00:51:08 -0400 (EDT)
Subject: Re: [PATCH 23/25] ASoC: sun8i-codec: Generalize AIF clock control
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-24-samuel@sholland.org>
 <20201005120459.5w5ligbconuwnzdv@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <583f297c-86f9-2e0a-c525-1d7f951e2cd2@sholland.org>
Date:   Mon, 5 Oct 2020 23:51:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005120459.5w5ligbconuwnzdv@gilmour.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 7:04 AM, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Sep 30, 2020 at 09:11:46PM -0500, Samuel Holland wrote:
>> The AIF clock control register has the same layout for all three AIFs.
>> The only difference between them is that AIF3 is missing some fields. We
>> can reuse the same register field definitions for all three registers,
>> and use the DAI ID to select the correct register address.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  sound/soc/sunxi/sun8i-codec.c | 64 +++++++++++++++++++----------------
>>  1 file changed, 34 insertions(+), 30 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
>> index 032a3f714dbb..1c34502ac47a 100644
>> --- a/sound/soc/sunxi/sun8i-codec.c
>> +++ b/sound/soc/sunxi/sun8i-codec.c
>> @@ -37,23 +37,23 @@
>>  #define SUN8I_MOD_CLK_ENA_DAC				2
>>  #define SUN8I_MOD_RST_CTL				0x014
>>  #define SUN8I_MOD_RST_CTL_AIF1				15
>>  #define SUN8I_MOD_RST_CTL_ADC				3
>>  #define SUN8I_MOD_RST_CTL_DAC				2
>>  #define SUN8I_SYS_SR_CTRL				0x018
>>  #define SUN8I_SYS_SR_CTRL_AIF1_FS			12
>>  #define SUN8I_SYS_SR_CTRL_AIF2_FS			8
>> -#define SUN8I_AIF1CLK_CTRL				0x040
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD		15
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV			13
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
>> +#define SUN8I_AIF_CLK_CTRL(n)				(0x040 * (1 + (n)))
>> +#define SUN8I_AIF_CLK_CTRL_MSTR_MOD			15
>> +#define SUN8I_AIF_CLK_CTRL_CLK_INV			13
>> +#define SUN8I_AIF_CLK_CTRL_BCLK_DIV			9
>> +#define SUN8I_AIF_CLK_CTRL_LRCK_DIV			6
>> +#define SUN8I_AIF_CLK_CTRL_WORD_SIZ			4
>> +#define SUN8I_AIF_CLK_CTRL_DATA_FMT			2
>>  #define SUN8I_AIF1_ADCDAT_CTRL				0x044
>>  #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA		15
>>  #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA		14
>>  #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_SRC		10
>>  #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_SRC		8
>>  #define SUN8I_AIF1_DACDAT_CTRL				0x048
>>  #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA		15
>>  #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
>> @@ -83,21 +83,21 @@
>>  #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
>>  #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
>>  #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
>>  
>>  #define SUN8I_SYSCLK_CTL_AIF1CLK_SRC_MASK	GENMASK(9, 8)
>>  #define SUN8I_SYSCLK_CTL_AIF2CLK_SRC_MASK	GENMASK(5, 4)
>>  #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
>>  #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK	GENMASK(14, 13)
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
>> -#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
>> +#define SUN8I_AIF_CLK_CTRL_CLK_INV_MASK		GENMASK(14, 13)
>> +#define SUN8I_AIF_CLK_CTRL_BCLK_DIV_MASK	GENMASK(12, 9)
>> +#define SUN8I_AIF_CLK_CTRL_LRCK_DIV_MASK	GENMASK(8, 6)
>> +#define SUN8I_AIF_CLK_CTRL_WORD_SIZ_MASK	GENMASK(5, 4)
>> +#define SUN8I_AIF_CLK_CTRL_DATA_FMT_MASK	GENMASK(3, 2)
>>  
>>  #define SUN8I_CODEC_PASSTHROUGH_SAMPLE_RATE 48000
>>  
>>  #define SUN8I_CODEC_PCM_FORMATS	(SNDRV_PCM_FMTBIT_S8     |\
>>  				 SNDRV_PCM_FMTBIT_S16_LE |\
>>  				 SNDRV_PCM_FMTBIT_S20_LE |\
>>  				 SNDRV_PCM_FMTBIT_S24_LE |\
>>  				 SNDRV_PCM_FMTBIT_S20_3LE|\
>> @@ -223,32 +223,34 @@ static int sun8i_codec_update_sample_rate(struct sun8i_codec *scodec)
>>  			   hw_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
>>  
>>  	return 0;
>>  }
>>  
>>  static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>  {
>>  	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
>> +	u32 reg = SUN8I_AIF_CLK_CTRL(dai->id);
>>  	u32 format, invert, value;
>>  
>>  	/* clock masters */
>>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>  	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
>>  		value = 0x1;
>>  		break;
>>  	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
>>  		value = 0x0;
>>  		break;
>>  	default:
>>  		return -EINVAL;
>>  	}
>> -	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>> -			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD),
>> -			   value << SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD);
>> +
>> +	regmap_update_bits(scodec->regmap, reg,
>> +			   BIT(SUN8I_AIF_CLK_CTRL_MSTR_MOD),
>> +			   value << SUN8I_AIF_CLK_CTRL_MSTR_MOD);
> 
> I guess it would be more readable without the intermediate variable to
> store the register.

You mean you want me to call `SUN8I_AIF_CLK_CTRL(dai->id)` in each
regmap_update_bits call? I don't know that the compiler could optimize
that due to the pointer read. And how would you suggest handling patch
25, where sometimes AIF3 needs to write to AIF2's clock register?

Cheers,
Samuel

> With that fixed,
> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> Maxime
> 

