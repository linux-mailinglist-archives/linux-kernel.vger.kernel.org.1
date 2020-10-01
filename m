Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14DB27F7D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbgJACNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:13:17 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:32849 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730198AbgJACL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:11:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67021580284;
        Wed, 30 Sep 2020 22:11:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Sm5u7CMOgbrIx
        C1iyJeUaxfEc37bLjTcg3iQXcDbUIE=; b=CCC8KhxYP31G9lXee7yhZgqNndMbE
        uZnxL98Im/S4OauEv+IT+YK6CnLvWyeQYaQ8ASfMnRoOWhbpjjiMpSZltGm+wmG5
        wuQ7+fu8Zx0SNlSrsVGAyHlGCR0AWOygyeNIHxjjH3U2zEycwTVG1/QtAcQAfkYa
        D6UV6F+H7/UT4rbTJgDPuqbPLLT2m7a2g7zNJDId5TAjwBa8EG13jyYpBoMRiHZu
        1YBYN8MIkY4wXOHVPMqzTLc29q2u5aPFZerY1ZRj7H5Cy9ClCntV8+xXGoFuqUL4
        vnaiCLl+BQljdDEs4QCnPeS6Polm9GKnITGWjPJgBFRSoUpdH8hb2xDsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Sm5u7CMOgbrIxC1iyJeUaxfEc37bLjTcg3iQXcDbUIE=; b=MS/NrYrr
        i9ILnigednY9YVqzkZs7/KK//3nSSe+4sWlEd3AdNTIdYbdS5Kp+aOP1vUnpzGau
        Zyt9KlFpomKphi4Il+8E4NZP1W018qLiK7MYSauOKTebYDsyLzeFMajUBqh+U997
        FwNAv0r8iE9EP/PeA4HwtoHjjb1ZfHegVpGIcq91GDF600gXIEQ3CFGh816Vypr1
        tlBmRuBVLKKcuX2DGK4GzSGbEQJ4g55fLRZZ0Iy2Iz1BihupYTa2OQw2SifPa5Pa
        br8XQR2qSkvEFT4s+iBq3WlU5DECHfIYz+yCIURV5LAESPGjmKC8nVEUtj8jpSjn
        xUtgY2A05fKlrA==
X-ME-Sender: <xms:6Dp1X33jNWQDDtH62y8leBIguHGSjoUBZu4QSYIKr8q36Eq_tKMi7A>
    <xme:6Dp1X2FGhnr3FSjveDXsRrT-7Q6BvOLaWwJfeU7EeNFMn7y51XJad1FP2fVeMQPas
    i0YJJra1zmc6ss5bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:6Dp1X351M8VTP2Qtj7TEVH0NIXseHS0qK32tD7eXqwxnVMK9X0nI_g>
    <xmx:6Dp1X82mgwu6SyC40P8Z6zqFZBlrIdqZYtee4SAjcZSV2bQcfZEZeA>
    <xmx:6Dp1X6H3KfblxsyA9B-IinOn1bJDStUnURca8nW4V0x0ToSTEU7fkw>
    <xmx:6Dp1X4a5wi09f-jQi6Irk1YpWkGYAr0RR8LzqlC9JeMFaHgqqroO0g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABE1A3064680;
        Wed, 30 Sep 2020 22:11:51 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 05/25] ASoC: sun8i-codec: Correct DAPM widget types
Date:   Wed, 30 Sep 2020 21:11:28 -0500
Message-Id: <20201001021148.15852-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whie the aif_in and aif_out widget types are handled exactly the same in
the core DAPM code, a future widget event hook will need the correct
widget type to derive the associated substream. Clean up the widget type
for that reason, and so these widgets will match newly-added widgets for
the other AIFs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 30fe27648254..d0028883950c 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -405,22 +405,22 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("ADC",
 			    SUN8I_ADC_DIG_CTRL,
 			    SUN8I_ADC_DIG_CTRL_ENAD, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("DAC",
 			    SUN8I_DAC_DIG_CTRL,
 			    SUN8I_DAC_DIG_CTRL_ENDA, 0, NULL, 0),
 
 	/* AIF "ADC" Outputs */
-	SND_SOC_DAPM_AIF_IN("AIF1 AD0L", "Capture", 0,
-			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA, 0),
-	SND_SOC_DAPM_AIF_IN("AIF1 AD0R", "Capture", 0,
-			    SUN8I_AIF1_ADCDAT_CTRL,
-			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1 AD0L", "Capture", 0,
+			     SUN8I_AIF1_ADCDAT_CTRL,
+			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF1 AD0R", "Capture", 0,
+			     SUN8I_AIF1_ADCDAT_CTRL,
+			     SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA, 0),
 
 	/* AIF "ADC" Mixers */
 	SOC_MIXER_ARRAY("AIF1 AD0L Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_aif1_ad0_mixer_controls),
 	SOC_MIXER_ARRAY("AIF1 AD0R Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_aif1_ad0_mixer_controls),
 
 	/* AIF "DAC" Inputs */
-- 
2.26.2

