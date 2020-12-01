Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB122C9717
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 06:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgLAFmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 00:42:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39394 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbgLAFmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 00:42:21 -0500
X-UUID: 5c5fc9a97f2540a7a8f26727118c9e3e-20201201
X-UUID: 5c5fc9a97f2540a7a8f26727118c9e3e-20201201
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1813315656; Tue, 01 Dec 2020 13:41:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Dec 2020 13:41:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Dec 2020 13:41:36 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <alsa-devel@alsa-project.org>,
        <jiaxin.yu@mediatek.com>, <chipeng.chang@mediatek.com>,
        <jeter.chen@mediatek.com>, <tzungbi@google.com>,
        <fan.chen@mediatek.com>, <Hsin-Hsiung.Wang@mediatek.com>,
        <shane.chien@mediatek.com>
Subject: [RFC] ASoC: Add compatible for mt6359-sound device
Date:   Tue, 1 Dec 2020 13:41:33 +0800
Message-ID: <1606801293-19472-1-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FAA7B66D6D0401E92CE626986C1CCA0E54FCFE8F1A01E9D6E0B728FA417EE9DC2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

In the change "[v2,1/2] Add mediatek codec mt6359 driver",
The compatible of mt6359-sound device is removed
due to it is regarded as a part of parent device,
which is only reflecting Linux model instead of hardware.
However, if the device is not given a comaptible,
of_node of struct device is null. I cannot use
devm_iio_channel_get such iio interface to get
auxadc value from iio channel. Because during
using devm_iio_channel_get, of_node of mt6359-sound is a
input parameter of of_iio_channel_get_by_name.
If the of_node is null, devm_iio_channel_get will
eventually return ENODEV error.
static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
						      const char *name)
{
	struct iio_channel *chan = NULL;

	/* Walk up the tree of devices looking for a matching iio channel */
	while (np) {  // np is null and will not enter the while loop
	....
	}
	return chan; // directly return null
}
I add the compatible back to mt6359.c and it
can successfully use devm_iio_channel_get without error.
Is there any suggestions if I need to use this kind of
native interface or can I add the compatible directly?
And I wonder what kind of device can add compatible
under mfd device?

Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
---
 sound/soc/codecs/mt6359.c |   58 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mt6359.h |    7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 6de0d74..1fb47f4 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/iio/consumer.h>
 #include <linux/sched.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
@@ -2741,6 +2742,37 @@ static void mt6359_codec_remove(struct snd_soc_component *cmpnt)
 	.num_dapm_routes = ARRAY_SIZE(mt6359_dapm_routes),
 };
 
+/* dc trim */
+static int mt6359_get_audio_auxadc(struct mt6359_priv *priv, int auxadc_ch)
+{
+	int value = 0;
+	int ret;
+	struct iio_channel *auxadc;
+
+	switch (auxadc_ch) {
+	case AUXADC_HP_OFFSET_CAL:
+		auxadc = priv->hpofs_cal_auxadc;
+		break;
+	case AUXADC_ACCDET:
+		auxadc = priv->accdet_auxadc;
+		break;
+	default:
+		pr_notice("%s() not support\n");
+		break;
+	}
+
+	if (!IS_ERR(auxadc)) {
+		ret = iio_read_channel_processed(auxadc, &value);
+		if (ret < 0) {
+			pr_err("Error: %s read fail (%d)\n", __func__, ret);
+			return ret;
+		}
+	}
+	pr_info("%s() value %d\n", __func__, value);
+
+	return value;
+}
+
 static int mt6359_parse_dt(struct mt6359_priv *priv)
 {
 	int ret;
@@ -2783,6 +2815,25 @@ static int mt6359_parse_dt(struct mt6359_priv *priv)
 		priv->mux_select[MUX_MIC_TYPE_2] = MIC_TYPE_MUX_IDLE;
 	}
 
+	/* get auxadc channel */
+	priv->hpofs_cal_auxadc = devm_iio_channel_get(dev,
+						      "pmic_hpofs_cal");
+	ret = PTR_ERR_OR_ZERO(priv->hpofs_cal_auxadc);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"%s() Get pmic_hpofs_cal iio ch failed (%d)\n",
+				__func__, ret);
+	}
+	priv->accdet_auxadc = devm_iio_channel_get(dev, "pmic_accdet");
+	ret = PTR_ERR_OR_ZERO(priv->accdet_auxadc);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"%s() Get pmic_accdet iio ch failed (%d)\n",
+				__func__, ret);
+	}
+
 	return 0;
 }
 
@@ -2818,9 +2869,16 @@ static int mt6359_platform_driver_probe(struct platform_device *pdev)
 					       ARRAY_SIZE(mt6359_dai_driver));
 }
 
+static const struct of_device_id mt6359_of_match[] = {
+	{.compatible = "mediatek,mt6359-sound",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6359_of_match);
+
 static struct platform_driver mt6359_platform_driver = {
 	.driver = {
 		.name = "mt6359-sound",
+		.of_match_table = mt6359_of_match,
 	},
 	.probe = mt6359_platform_driver_probe,
 };
diff --git a/sound/soc/codecs/mt6359.h b/sound/soc/codecs/mt6359.h
index 35f806b..52d2398 100644
--- a/sound/soc/codecs/mt6359.h
+++ b/sound/soc/codecs/mt6359.h
@@ -2610,6 +2610,11 @@ enum {
 	PGA_3_MUX_AIN2,
 };
 
+enum {
+	AUXADC_HP_OFFSET_CAL = 0,
+	AUXADC_ACCDET,
+};
+
 struct mt6359_priv {
 	struct device *dev;
 	struct regmap *regmap;
@@ -2622,6 +2627,8 @@ struct mt6359_priv {
 	int hp_gain_ctl;
 	int hp_hifi_mode;
 	int mtkaif_protocol;
+	struct iio_channel *hpofs_cal_auxadc;
+	struct iio_channel *accdet_auxadc;
 };
 
 #define CODEC_MT6359_NAME "mtk-codec-mt6359"
-- 
1.7.9.5

