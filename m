Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1C2758A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIWN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:26:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42400 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:26:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQX2q079582;
        Wed, 23 Sep 2020 08:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600867593;
        bh=wgvDwMPsP55ywAoaHV74OL6ILlRcs/yPg/x9ic3T9kw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xzGDQbEYZUyurQ8EFkXvdh/l9AbtaaJLtIWWXY112oMt2CRrOFzI4W5DaxHtVsgiL
         zy1dSBr3ubR2vdZPmu4F1k9JRU9pGa3U8VmHwyRP442XxylXSSgwBkjEoTtX+ePmpl
         mmT34hb194UNtBJ3AWTmh5QNhKSGUAogTFBl5mZQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQWSM054060;
        Wed, 23 Sep 2020 08:26:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQW7u007810;
        Wed, 23 Sep 2020 08:26:32 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 6/6] ASoC: tas2770: Remove unused variables
Date:   Wed, 23 Sep 2020 08:26:00 -0500
Message-ID: <20200923132600.10652-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923132600.10652-1-dmurphy@ti.com>
References: <20200923132600.10652-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables in the private struct and the code as these
variables are initially set and then there is no additional code
utilizing these variables.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 11 -----------
 sound/soc/codecs/tas2770.h |  8 ++------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c7a6f7e8200c..a91a0a31e74d 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -249,8 +249,6 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 	if (ret < 0)
 		return ret;
 
-	tas2770->channel_size = bitwidth;
-
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG5,
 					    TAS2770_TDM_CFG_REG5_VSNS_MASK |
 					    TAS2770_TDM_CFG_REG5_50_MASK,
@@ -312,7 +310,6 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 	if (ret < 0)
 		return ret;
 
-	tas2770->sampling_rate = samplerate;
 	return 0;
 }
 
@@ -400,8 +397,6 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
-	struct tas2770_priv *tas2770 =
-			snd_soc_component_get_drvdata(component);
 	int left_slot, right_slot;
 	int ret;
 
@@ -466,7 +461,6 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
-	tas2770->slot_width = slot_width;
 	return 0;
 }
 
@@ -688,8 +682,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, tas2770);
 	dev_set_drvdata(&client->dev, tas2770);
 
-	tas2770->power_state = TAS2770_POWER_SHUTDOWN;
-
 	tas2770->regmap = devm_regmap_init_i2c(client, &tas2770_i2c_regmap);
 	if (IS_ERR(tas2770->regmap)) {
 		result = PTR_ERR(tas2770->regmap);
@@ -716,9 +708,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	tas2770->channel_size = 0;
-	tas2770->slot_width = 0;
-
 	result = tas2770_register_codec(tas2770);
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index 856a7c5cff5a..d156666bcc55 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -128,15 +128,11 @@
 #define ERROR_CLASSD_PWR    BIT(5)
 
 struct tas2770_priv {
-	struct device *dev;
-	struct regmap *regmap;
 	struct snd_soc_component *component;
-	int power_state;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
-	int sampling_rate;
-	int channel_size;
-	int slot_width;
+	struct regmap *regmap;
+	struct device *dev;
 	int v_sense_slot;
 	int i_sense_slot;
 };
-- 
2.28.0

