Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6B28D9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgJNGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:19:48 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:52869 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728320AbgJNGTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:19:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 74E9AD15;
        Wed, 14 Oct 2020 02:19:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Pp9wIcEvE+x99
        KLgjxwBXGZSGHDy/NDCU8B3PT8B1fk=; b=RWUvwPDKiSIayOBdArHupyy8qKbH/
        Uwh8KxC/PDgohSbO8/2QsyRl5iNBtbA0QA0XeYdTJBVcfuImoNm4yW6S3OQMOklU
        1T2JSyP3KlgGz9CJgy9OviuSSovHe+qQAhwvZ8SNYJJj3Ijb8GcC+6v9ShxKQs5Z
        4xC6Wrdopx2u9ynv7TIzuEkTmkzQ6PmYLZgxc9V6WWLR7ECuu1yXh8UJdj3oI6xp
        EfDsi73qY+SLcfKvHyRHfKxTSVh6+W3+rUEOCb6H/nHntXqO9UIGOP/7KNts3Yek
        ZeLH/J7dA9BelLpSmU9mFDZ9rJWd7G+qjCAM8A4BghRnavNVN9XIJboqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Pp9wIcEvE+x99KLgjxwBXGZSGHDy/NDCU8B3PT8B1fk=; b=oxKehbA3
        lhaN0Ueb8qAWh7mABc+WWKgr8bMOMe1nfrmcqJh2uPwSz1iymmtYJ5AWBOVUGEaL
        9QnBvEIFnO/Mjwuz4XNLjxsoz1fTAUKm11yEWSVSQZ/Z1ZVEZwcifaFKBs/z8Z+6
        HOGQd15H6dT/40++NqJboXZUJDHvl/6KnXOv9wGzvjwlktaDYd5XQTEk9+KChQ3d
        AS4oWORiPmGkoJ4m5Mh8kfP8quErFmXaQP5aNZdfDQZglUAAAUwV2idjIjMy/cqP
        YMmnUVpPyepfWhYPcDF9y1QPSYkRK4MvwkcQEKBDJAq7GAFT02sAAeym2F37pfAS
        r0grUY/FaON00Q==
X-ME-Sender: <xms:fpiGX4-vDGH2HOTQWlHI0Kh6nScgmGnkjtvZfb1HiW6uNzbcRHxyIQ>
    <xme:fpiGXwtW69lJ4G2qt4rGU-peucXLQfMFT7XsOPAO_0jITua-FgKDIZv5XO51McmFX
    GtZokJXvai3ng0_7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:fpiGX-DcBQyc_BVjh7N5pN_PJmBmL8y2oiEZ3AThEwPT60Yip6__Qg>
    <xmx:fpiGX4e3U4bpdeRzSxIQJFBGGa1weJFtxsihcQ4BsOKsVOSHxqaYCg>
    <xmx:fpiGX9MyQOf3yn4cxI9GmDY_r0LBCSHyVaXYiJDP5L9qVNIEmmMPwA>
    <xmx:f5iGX2i9ZWbTwq3b8Z44m_1-e_IgLYJHH5o1Leythwr3RXJuCLsCpLhsYCo>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 54CC03280064;
        Wed, 14 Oct 2020 02:19:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 01/17] ASoC: sun8i-codec: Prepare to extend the DAI driver
Date:   Wed, 14 Oct 2020 01:19:25 -0500
Message-Id: <20201014061941.4306-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014061941.4306-1-samuel@sholland.org>
References: <20201014061941.4306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding additional DAIs to this component, convert the
DAI driver definition to an array. Since this changes all of the lines
in the definition anyway, let's move it closer to the ops function
definitions, instead of on the far side of the DAPM arrays. And while
moving the DAI driver ops, rename the set_fmt hook to match the usual
naming scheme.

Give the existing DAI an explicit ID and more meaningful stream names,
so it will remain unique as more DAIs are added. The AIF widget streams
must be updated to match.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 76 +++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 7590c4b04d14..6413873a0584 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -90,16 +90,21 @@
 #define SUN8I_SYSCLK_CTL_AIF2CLK_SRC_MASK	GENMASK(5, 4)
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 
+enum {
+	SUN8I_CODEC_AIF1,
+	SUN8I_CODEC_NAIFS
+};
+
 struct sun8i_codec_quirks {
 	bool legacy_widgets	: 1;
 	bool lrck_inversion	: 1;
 };
 
 struct sun8i_codec {
 	struct regmap			*regmap;
 	struct clk			*clk_module;
@@ -160,17 +165,17 @@ static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
 		return 0x9;
 	case 192000:
 		return 0xa;
 	default:
 		return -EINVAL;
 	}
 }
 
-static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	u32 value;
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
 		value = 0x1;
@@ -331,16 +336,46 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
 			   SUN8I_SYS_SR_CTRL_AIF1_FS_MASK,
 			   sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
 
 	return 0;
 }
 
+static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
+	.set_fmt	= sun8i_codec_set_fmt,
+	.hw_params	= sun8i_codec_hw_params,
+};
+
+static struct snd_soc_dai_driver sun8i_codec_dais[] = {
+	{
+		.name	= "sun8i-codec-aif1",
+		.id	= SUN8I_CODEC_AIF1,
+		.ops	= &sun8i_codec_dai_ops,
+		/* capture capabilities */
+		.capture = {
+			.stream_name	= "AIF1 Capture",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= SNDRV_PCM_RATE_8000_192000,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+			.sig_bits	= 24,
+		},
+		/* playback capabilities */
+		.playback = {
+			.stream_name	= "AIF1 Playback",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= SNDRV_PCM_RATE_8000_192000,
+			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	},
+};
+
 static const char *const sun8i_aif_stereo_mux_enum_values[] = {
 	"Stereo", "Reverse Stereo", "Sum Mono", "Mix Mono"
 };
 
 static SOC_ENUM_DOUBLE_DECL(sun8i_aif1_ad0_stereo_mux_enum,
 			    SUN8I_AIF1_ADCDAT_CTRL,
 			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_SRC,
 			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_SRC,
@@ -433,20 +468,20 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("ADC",
 			    SUN8I_ADC_DIG_CTRL,
 			    SUN8I_ADC_DIG_CTRL_ENAD, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DAC",
 			    SUN8I_DAC_DIG_CTRL,
 			    SUN8I_DAC_DIG_CTRL_ENDA, 0, NULL, 0),
 
 	/* AIF "ADC" Outputs */
-	SND_SOC_DAPM_AIF_OUT("AIF1 AD0L", "Capture", 0,
+	SND_SOC_DAPM_AIF_OUT("AIF1 AD0L", "AIF1 Capture", 0,
 			     SUN8I_AIF1_ADCDAT_CTRL,
 			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA, 0),
-	SND_SOC_DAPM_AIF_OUT("AIF1 AD0R", "Capture", 1,
+	SND_SOC_DAPM_AIF_OUT("AIF1 AD0R", "AIF1 Capture", 1,
 			     SUN8I_AIF1_ADCDAT_CTRL,
 			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA, 0),
 
 	/* AIF "ADC" Mono/Stereo Muxes */
 	SND_SOC_DAPM_MUX("AIF1 AD0L Stereo Mux", SND_SOC_NOPM, 0, 0,
 			 &sun8i_aif1_ad0_stereo_mux_control),
 	SND_SOC_DAPM_MUX("AIF1 AD0R Stereo Mux", SND_SOC_NOPM, 0, 0,
 			 &sun8i_aif1_ad0_stereo_mux_control),
@@ -459,20 +494,20 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 
 	/* AIF "DAC" Mono/Stereo Muxes */
 	SND_SOC_DAPM_MUX("AIF1 DA0L Stereo Mux", SND_SOC_NOPM, 0, 0,
 			 &sun8i_aif1_da0_stereo_mux_control),
 	SND_SOC_DAPM_MUX("AIF1 DA0R Stereo Mux", SND_SOC_NOPM, 0, 0,
 			 &sun8i_aif1_da0_stereo_mux_control),
 
 	/* AIF "DAC" Inputs */
-	SND_SOC_DAPM_AIF_IN("AIF1 DA0L", "Playback", 0,
+	SND_SOC_DAPM_AIF_IN("AIF1 DA0L", "AIF1 Playback", 0,
 			    SUN8I_AIF1_DACDAT_CTRL,
 			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
-	SND_SOC_DAPM_AIF_IN("AIF1 DA0R", "Playback", 1,
+	SND_SOC_DAPM_AIF_IN("AIF1 DA0R", "AIF1 Playback", 1,
 			    SUN8I_AIF1_DACDAT_CTRL,
 			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* ADC Inputs (connected to analog codec DAPM context) */
 	SND_SOC_DAPM_ADC("ADCL", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* DAC Outputs (connected to analog codec DAPM context) */
@@ -619,44 +654,16 @@ static int sun8i_codec_component_probe(struct snd_soc_component *component)
 	/* Use AIF1CLK as the SYSCLK parent since AIF1 is used most often. */
 	regmap_update_bits(scodec->regmap, SUN8I_SYSCLK_CTL,
 			   BIT(SUN8I_SYSCLK_CTL_SYSCLK_SRC),
 			   SUN8I_SYSCLK_CTL_SYSCLK_SRC_AIF1CLK);
 
 	return 0;
 }
 
-static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-	.hw_params = sun8i_codec_hw_params,
-	.set_fmt = sun8i_set_fmt,
-};
-
-static struct snd_soc_dai_driver sun8i_codec_dai = {
-	.name = "sun8i",
-	/* playback capabilities */
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-	/* capture capabilities */
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-		.sig_bits = 24,
-	},
-	/* pcm operations */
-	.ops = &sun8i_codec_dai_ops,
-};
-
 static const struct snd_soc_component_driver sun8i_soc_component = {
 	.dapm_widgets		= sun8i_codec_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
 	.dapm_routes		= sun8i_codec_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
 	.probe			= sun8i_codec_component_probe,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
@@ -709,17 +716,18 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun8i_codec_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &sun8i_soc_component,
-				     &sun8i_codec_dai, 1);
+					      sun8i_codec_dais,
+					      ARRAY_SIZE(sun8i_codec_dais));
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register codec\n");
 		goto err_suspend;
 	}
 
 	return ret;
 
 err_suspend:
-- 
2.26.2

