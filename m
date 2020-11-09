Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0279B2AB399
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgKIJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:30:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53181 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726176AbgKIJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:30:33 -0500
X-UUID: 328e4573f5054579b326a9784961fbeb-20201109
X-UUID: 328e4573f5054579b326a9784961fbeb-20201109
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1885611427; Mon, 09 Nov 2020 17:30:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 17:30:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 17:30:28 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH v2 1/2] ASoC: Fix vaud18 power leakage of mt6359
Date:   Mon, 9 Nov 2020 17:30:08 +0800
Message-ID: <1604914209-9174-2-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
References: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

vaud18 is power of mt6359 audio path. It
should only enable when audio is used,
instead of in boot up stage.
Once mt6359 audio path is enabled or disabled,
vaud18 is controlled by regulator supply widget
"LDO_VAUD18". Due to vaud18 is controlled by
regulator dapm macro instead of regmap, the macro
MT6359_LDO_VAUD18_CON0 and variable avdd_reg
is no used and removed from mt6359.h.

Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
---
 sound/soc/codecs/mt6359.c |   25 +------------------------
 sound/soc/codecs/mt6359.h |    8 --------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index d20c59a..ecdfd57 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -1943,9 +1943,7 @@ static int mt_ncp_event(struct snd_soc_dapm_widget *w,
 	SND_SOC_DAPM_SUPPLY_S("CLK_BUF", SUPPLY_SEQ_CLK_BUF,
 			      MT6359_DCXO_CW12,
 			      RG_XO_AUDIO_EN_M_SFT, 0, NULL, 0),
-	SND_SOC_DAPM_SUPPLY_S("LDO_VAUD18", SUPPLY_SEQ_LDO_VAUD18,
-			      MT6359_LDO_VAUD18_CON0,
-			      RG_LDO_VAUD18_EN_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("LDO_VAUD18", 0, 0),
 	SND_SOC_DAPM_SUPPLY_S("AUDGLB", SUPPLY_SEQ_AUD_GLB,
 			      MT6359_AUDDEC_ANA_CON13,
 			      RG_AUDGLB_PWRDN_VA32_SFT, 1, NULL, 0),
@@ -2807,20 +2805,6 @@ static int mt6359_platform_driver_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	priv->dev = &pdev->dev;
 
-	priv->avdd_reg = devm_regulator_get(&pdev->dev, "vaud18");
-	if (IS_ERR(priv->avdd_reg)) {
-		dev_err(&pdev->dev, "%s(), have no vaud18 supply: %ld",
-			__func__, PTR_ERR(priv->avdd_reg));
-		return PTR_ERR(priv->avdd_reg);
-	}
-
-	ret = regulator_enable(priv->avdd_reg);
-	if (ret) {
-		dev_err(&pdev->dev, "%s(), failed to enable regulator!\n",
-			__func__);
-		return ret;
-	}
-
 	ret = mt6359_parse_dt(priv);
 	if (ret) {
 		dev_warn(&pdev->dev, "%s() failed to parse dts\n", __func__);
@@ -2841,13 +2825,6 @@ static int mt6359_platform_driver_remove(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "%s(), dev name %s\n",
 		__func__, dev_name(&pdev->dev));
 
-	ret = regulator_disable(priv->avdd_reg);
-	if (ret) {
-		dev_err(&pdev->dev, "%s(), failed to disable regulator!\n",
-			__func__);
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/sound/soc/codecs/mt6359.h b/sound/soc/codecs/mt6359.h
index af6f07f..35f806b 100644
--- a/sound/soc/codecs/mt6359.h
+++ b/sound/soc/codecs/mt6359.h
@@ -135,11 +135,6 @@
 /* MT6359_DCXO_CW12 */
 #define RG_XO_AUDIO_EN_M_SFT				13
 
-/* LDO_VAUD18_CON0 */
-#define RG_LDO_VAUD18_EN_SFT				0
-#define RG_LDO_VAUD18_EN_MASK				0x1
-#define RG_LDO_VAUD18_EN_MASK_SFT			(0x1 << 0)
-
 /* AUD_TOP_CKPDN_CON0 */
 #define RG_VOW13M_CK_PDN_SFT				13
 #define RG_VOW13M_CK_PDN_MASK				0x1
@@ -2132,7 +2127,6 @@
 
 #define MT6359_DCXO_CW11				0x7a6
 #define MT6359_DCXO_CW12				0x7a8
-#define MT6359_LDO_VAUD18_CON0				0x1c98
 
 #define MT6359_GPIO_MODE0				0xcc
 #define MT6359_GPIO_MODE0_SET				0xce
@@ -2469,7 +2463,6 @@ enum {
 enum {
 	/* common */
 	SUPPLY_SEQ_CLK_BUF,
-	SUPPLY_SEQ_LDO_VAUD18,
 	SUPPLY_SEQ_AUD_GLB,
 	SUPPLY_SEQ_HP_PULL_DOWN,
 	SUPPLY_SEQ_CLKSQ,
@@ -2629,7 +2622,6 @@ struct mt6359_priv {
 	int hp_gain_ctl;
 	int hp_hifi_mode;
 	int mtkaif_protocol;
-	struct regulator *avdd_reg;
 };
 
 #define CODEC_MT6359_NAME "mtk-codec-mt6359"
-- 
1.7.9.5

