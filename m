Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626D26AD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgIOTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:08:48 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49730 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgIOTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:06:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6COP013395;
        Tue, 15 Sep 2020 14:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196772;
        bh=EAXQSylEvOtZPY7n6DOnauI/m1zyOC+7tLJj6RWm6wE=;
        h=From:To:CC:Subject:Date;
        b=DZmw5M9R5+Yt4l3T8wjwVFBtFLlLpA/o/5ILZWGQY9kKgeOtiOOXdOCeaHR7bQdvW
         JujFy96Q0B9SBmpHOTyMH1TpYW6W8fxproNal+NKFkBFpRxg1kGlbKmS/nW+99cZJU
         Fw36sZ23yGRxrghMWgKFDbtoMgBrx4i8xjRoFpuo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FJ6CoV073700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:06:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Bkp085621;
        Tue, 15 Sep 2020 14:06:11 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <camel.guo@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/6] ASoC: tlv320adcx140: Idle the device while writing registers
Date:   Tue, 15 Sep 2020 14:06:01 -0500
Message-ID: <20200915190606.1744-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that if the device was active and register writes were
performed there were some unwanted behaviors particularly when writing
the word length and some filter options. So when writing to the device
the device should be placed in sleep mode and then exit sleep mode once
the register update is complete.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 43 ++++++++++++++++++++++++--------
 sound/soc/codecs/tlv320adcx140.h |  2 ++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 8efe20605f9b..3909c1cf52be 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -30,7 +30,7 @@ struct adcx140_priv {
 	struct regmap *regmap;
 	struct device *dev;
 
-	int micbias_vg;
+	bool micbias_vg;
 
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
@@ -614,11 +614,26 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 	return ret;
 }
 
+static void adcx140_pwr_ctrl(struct adcx140_priv *adcx140, bool power_state)
+{
+	int pwr_ctrl = 0;
+
+	if (power_state)
+		pwr_ctrl = ADCX140_PWR_CFG_ADC_PDZ | ADCX140_PWR_CFG_PLL_PDZ;
+
+	if (adcx140->micbias_vg && power_state)
+		pwr_ctrl |= ADCX140_PWR_CFG_BIAS_PDZ;
+
+	regmap_update_bits(adcx140->regmap, ADCX140_PWR_CFG,
+			   ADCX140_PWR_CTRL_MSK, pwr_ctrl);
+}
+
 static int adcx140_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 data = 0;
 
 	switch (params_width(params)) {
@@ -640,9 +655,13 @@ static int adcx140_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	adcx140_pwr_ctrl(adcx140, false);
+
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG0,
 			    ADCX140_WORD_LEN_MSK, data);
 
+	adcx140_pwr_ctrl(adcx140, true);
+
 	return 0;
 }
 
@@ -709,6 +728,8 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 	adcx140->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
+	adcx140_pwr_ctrl(adcx140, false);
+
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG0,
 				      ADCX140_FSYNCINV_BIT |
 				      ADCX140_BCLKINV_BIT |
@@ -721,6 +742,7 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG1,
 				      ADCX140_TX_OFFSET_MASK, offset);
 
+	adcx140_pwr_ctrl(adcx140, true);
 
 	return 0;
 }
@@ -818,12 +840,11 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	ret = device_property_read_u32(adcx140->dev, "ti,mic-bias-source",
 				      &bias_source);
-	if (ret)
+	if (ret || bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
-
-	if (bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
-		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
-		return -EINVAL;
+		adcx140->micbias_vg = false;
+	} else {
+		adcx140->micbias_vg = true;
 	}
 
 	ret = device_property_read_u32(adcx140->dev, "ti,vref-source",
@@ -906,6 +927,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 				ADCX140_MIC_BIAS_VREF_MSK, bias_cfg);
 	if (ret)
 		dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
+
+	adcx140_pwr_ctrl(adcx140, true);
 out:
 	return ret;
 }
@@ -914,21 +937,19 @@ static int adcx140_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
-	int pwr_cfg = 0;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
-		pwr_cfg = ADCX140_PWR_CFG_BIAS_PDZ | ADCX140_PWR_CFG_PLL_PDZ |
-			  ADCX140_PWR_CFG_ADC_PDZ;
+		adcx140_pwr_ctrl(adcx140, true);
 		break;
 	case SND_SOC_BIAS_OFF:
-		pwr_cfg = 0x0;
+		adcx140_pwr_ctrl(adcx140, false);
 		break;
 	}
 
-	return regmap_write(adcx140->regmap, ADCX140_PWR_CFG, pwr_cfg);
+	return 0;
 }
 
 static const struct snd_soc_component_driver soc_codec_driver_adcx140 = {
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index eedbc1d7221f..94c6d1fd2977 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -123,6 +123,7 @@
 #define ADCX140_MIC_BIAS_VREF_1375V	2
 #define ADCX140_MIC_BIAS_VREF_MSK GENMASK(1, 0)
 
+#define ADCX140_PWR_CTRL_MSK    GENMASK(7, 5)
 #define ADCX140_PWR_CFG_BIAS_PDZ	BIT(7)
 #define ADCX140_PWR_CFG_ADC_PDZ		BIT(6)
 #define ADCX140_PWR_CFG_PLL_PDZ		BIT(5)
@@ -145,4 +146,5 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+
 #endif /* _TLV320ADCX140_ */
-- 
2.28.0

