Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D002A8F65
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKFGTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:19:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33730 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgKFGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:19:44 -0500
X-UUID: 737f5f261f4d49c8aeffe1954e138da0-20201106
X-UUID: 737f5f261f4d49c8aeffe1954e138da0-20201106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 724153232; Fri, 06 Nov 2020 14:19:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 14:19:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 14:19:33 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH] ASoC: Fix vaud18 power leakage of mt6359
Date:   Fri, 6 Nov 2020 14:18:37 +0800
Message-ID: <1604643517-3527-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB50972989C26800FA4953F469746C73711B7D89010A16A1E136A054A6640E852000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

vaud18 is power of mt6359 audio path. It
should only enable when audio is used,
instead of in boot up stage.
Once mt6359 audio path is enabled or disabled,
vaud18 is controlled by using regulator in
supply widget "LDO_VAUD18". Due to vaud18 is
controlled by regulator instead of regmap,
the macro MT6359_LDO_VAUD18_CON0 is no used and
remove from mt6359.h.

Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
---
 sound/soc/codecs/mt6359.c | 38 +++++++++++++++++++++++++++++---------
 sound/soc/codecs/mt6359.h |  6 ------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index d20c59a..52dabdc 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -724,6 +724,32 @@ static SOC_VALUE_ENUM_SINGLE_DECL(pga_3_mux_map_enum,
 static const struct snd_kcontrol_new pga_3_mux_control =
 	SOC_DAPM_ENUM("PGA 3 Select", pga_3_mux_map_enum);
 
+static int mt_vaud18_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol,
+			   int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mt6359_priv *priv = snd_soc_component_get_drvdata(cmpnt);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = regulator_enable(priv->avdd_reg);
+		if (ret)
+			dev_err(priv->dev, "regulator_enable err: %d\n", ret);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = regulator_disable(priv->avdd_reg);
+		if (ret)
+			dev_err(priv->dev, "regulator_disable err: %d\n", ret);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static int mt_sgen_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol,
 			 int event)
@@ -1944,8 +1970,9 @@ static int mt_ncp_event(struct snd_soc_dapm_widget *w,
 			      MT6359_DCXO_CW12,
 			      RG_XO_AUDIO_EN_M_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO_VAUD18", SUPPLY_SEQ_LDO_VAUD18,
-			      MT6359_LDO_VAUD18_CON0,
-			      RG_LDO_VAUD18_EN_SFT, 0, NULL, 0),
+			      SND_SOC_NOPM, 0, 0,
+			      mt_vaud18_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY_S("AUDGLB", SUPPLY_SEQ_AUD_GLB,
 			      MT6359_AUDDEC_ANA_CON13,
 			      RG_AUDGLB_PWRDN_VA32_SFT, 1, NULL, 0),
@@ -2814,13 +2841,6 @@ static int mt6359_platform_driver_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->avdd_reg);
 	}
 
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
diff --git a/sound/soc/codecs/mt6359.h b/sound/soc/codecs/mt6359.h
index af6f07f..1dfb29a 100644
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
-- 
1.9.1

