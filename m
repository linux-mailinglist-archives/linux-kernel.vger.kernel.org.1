Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17026BEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIPIAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:00:05 -0400
Received: from smtp1.axis.com ([195.60.68.17]:44530 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIPH75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2719; q=dns/txt; s=axis-central1;
  t=1600243197; x=1631779197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Bee2oDYV5ypb/Wdn/uiK1X779bbbI4wm+9E+eFG2P4=;
  b=XQF7lgxI9TZSKhzBooFkQVtnbzReFFK+suC24sUxID740fqtANbYlxeN
   zuYJYBiDIoFAyGar/YsvuNwXAZY4Oc66DfIxFG0zYKvw/5PG27mU/Yh1q
   7gGcBZS6vTTACnMHN19xasO9YQTj49cysqS51bQmUyhcw/tVj7Wz9YtMI
   KEiqOVnjEgIgRHXFvS+WbSgn4WkSEnEBnX/cVQJ0It7n6yBCjDDLIaQNP
   yI+4Gcd4w8UXzvwDpAu0Uz12YZPng0SiIR4I0Y4rkruYtx6dqy3IuKbcF
   5yQ3REmWyOyHFznm2QYDotsiNx+/QzpgnuLYiKg0Gp0jFGmeZyv7qHRNH
   g==;
IronPort-SDR: G4MZK7x65pmT/cNZCF+JKxe8wY0W522UpF9odulQr4TM0Y70oo98Jc/eVjPJS9NiG0buT9juFx
 kkYGXIvYdGmxyPdw9G7dHxCVA97/PQTZzvzDnzSeofNxNmz8BWDHdNyIVSJVuKkHiNlaTBvFuY
 wbamjoRakn2lJuIE1vutaI3DBdtChFLIEqhtR9FeqF73F7nuiSPycrrwHCLGOsGOlZvhLw9Dih
 grVSYZBTqn62PuplOE/E+jiJqdPx3p7DJ6UXXnb4MLJjHkRyRz6Mct6Ncp6GPKMNJUvYSoBgFj
 Vg4=
X-IronPort-AV: E=Sophos;i="5.76,432,1592863200"; 
   d="scan'208";a="12999945"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH v3 2/2] ASoC: tlv320adcx140: Add support for configuring GPIO pin
Date:   Wed, 16 Sep 2020 09:59:49 +0200
Message-ID: <20200916075949.28479-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916075949.28479-1-camel.guo@axis.com>
References: <20200916075949.28479-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add support to configure the GPIO pin to the specific configuration.
The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
drive can be configured with various configuration.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 v3:
  - Add ADCX140_NUM_GPIO_CFGS avoiding using magic number
  - Remove unneeded check on ret in adcx140_configure_gpio

 sound/soc/codecs/tlv320adcx140.c | 40 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  5 ++++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index f33ee604ee78..fe6fc6df66cc 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -837,6 +837,42 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 
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
@@ -934,6 +970,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
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
index eedbc1d7221f..9d04dec374d1 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -145,4 +145,9 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+#define ADCX140_NUM_GPIO_CFGS		2
+#define ADCX140_GPIO_SHIFT		4
+#define ADCX140_GPIO_CFG_MAX		15
+#define ADCX140_GPIO_DRV_MAX		5
+
 #endif /* _TLV320ADCX140_ */
-- 
2.20.1

