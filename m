Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A563426F728
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIRHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:39:49 -0400
Received: from smtp1.axis.com ([195.60.68.17]:47428 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRHjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:39:49 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 03:39:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2795; q=dns/txt; s=axis-central1;
  t=1600414788; x=1631950788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oe/kyqOSS+vfTj2Z8DmOJ/QTD4lls0VVIA5KQlOYFoA=;
  b=Dn6QaBy53de54tZbNz9gNScZixBBlCSlEwaBN5BjjF2/XHkqzlbkkmIK
   aocy6ZiFxSr8ka2WzZmDWufHHGta1JrJHBQCwnqwSITBqwujusw8goDye
   9ovaU0/uek6cAQdMWG90MXMzX5UuLWgmUWymwBA6DualZ6mVyTBwzwuwa
   3V+XxjzDqrEa1NmF/Q5dn4mKCw92BMXb62rC4R8L8eCza2nhSQThCdoIf
   j4Ytw5T5r8rXoIyJYPgqoabNwmkNNu2qjGLfuohzYqC3vOREjP1nHsOhY
   sKL8G/fQ9JrFqqD4zr1xU4kkg9K/mpJwi8E2OOlVYP2rRB4KQBQuvSMBe
   g==;
IronPort-SDR: g9KO4QFRGuI7AzF3iVWt7fmncB6/fVBHINfXbzLhJHMQ2Vc+92pfEtd82Xjr+oKxls3MbeS0oe
 iS+jHKAiYGTJ2YqtyP1ea04tDpg1uZl6vMNSp37r/FfIO0tv4bzDbLWFA+muiaR3TVB+ZCv/rY
 5qoFneBOQ+bezyd/2sXjYp5WkK4fUkgOiZlsoQKn3CZC4Jv73zkIlav10bWFCeaskWjz/HF8oX
 ggCePMMNi3d2CiIUbT7ir7YQfbv5SiiqbLBt+t+wPVk/ezjEljJGnz8WzP7hpJPtcxzSgLdjXC
 CCY=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13094802"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH v4] ASoC: tlv320adcx140: Add support for configuring GPIO pin
Date:   Fri, 18 Sep 2020 09:32:29 +0200
Message-ID: <20200918073229.27348-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add support to configure the GPIO pin to the specific configuration.
The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
drive can be configured with various configuration.

Signed-off-by: Camel Guo <camelg@axis.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 v4:
  - Rebase and fix merge conflict
  - Add Acked-by from Dan 
 v3: 
  - Add ADCX140_NUM_GPIO_CFGS avoiding using magic number
  - Remove unneeded check on ret in adcx140_configure_gpio

 sound/soc/codecs/tlv320adcx140.c | 40 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  5 ++++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 28dbd7d5e149..53a80246aee1 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -861,6 +861,42 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 
 }
 
+static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
+{
+	int gpio_count = 0;
+	u32 gpio_outputs[ADCX140_NUM_GPIO_CFGS];
+	u32 gpio_output_val = 0;
+	int ret;
+
+	gpio_count = device_property_count_u32(adcx140->dev,
+			"ti,gpio-config");
+	if (gpio_count == 0)
+		return 0;
+
+	if (gpio_count != ADCX140_NUM_GPIO_CFGS)
+		return -EINVAL;
+
+	ret = device_property_read_u32_array(adcx140->dev, "ti,gpio-config",
+			gpio_outputs, gpio_count);
+	if (ret)
+		return ret;
+
+	if (gpio_outputs[0] > ADCX140_GPIO_CFG_MAX) {
+		dev_err(adcx140->dev, "GPIO config out of range\n");
+		return -EINVAL;
+	}
+
+	if (gpio_outputs[1] > ADCX140_GPIO_DRV_MAX) {
+		dev_err(adcx140->dev, "GPIO drive out of range\n");
+		return -EINVAL;
+	}
+
+	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
+		| gpio_outputs[1];
+
+	return regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
+}
+
 static int adcx140_codec_probe(struct snd_soc_component *component)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
@@ -958,6 +994,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = adcx140_configure_gpio(adcx140);
+	if (ret)
+		return ret;
+
 	ret = adcx140_configure_gpo(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 107bd7927d9c..d7d4e3a88b5c 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -148,4 +148,9 @@
 
 #define ADCX140_TX_FILL    BIT(0)
 
+#define ADCX140_NUM_GPIO_CFGS		2
+#define ADCX140_GPIO_SHIFT		4
+#define ADCX140_GPIO_CFG_MAX		15
+#define ADCX140_GPIO_DRV_MAX		5
+
 #endif /* _TLV320ADCX140_ */
-- 
2.20.1

