Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765C2CF7E5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgLEARU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:17:20 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49085 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgLEART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:17:19 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1C725FF804;
        Sat,  5 Dec 2020 00:16:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] ASoC: add simple-mux
Date:   Sat,  5 Dec 2020 01:15:08 +0100
Message-Id: <20201205001508.346439-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for simple mux driven by gpios. It currently only supports one
gpio, muxing one of two inputs to a single output.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 sound/soc/codecs/Kconfig      |   5 ++
 sound/soc/codecs/Makefile     |   4 ++
 sound/soc/codecs/simple-mux.c | 124 ++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 sound/soc/codecs/simple-mux.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..3847e490f795 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -181,6 +181,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_SGTL5000
 	imply SND_SOC_SI476X
 	imply SND_SOC_SIMPLE_AMPLIFIER
+	imply SND_SOC_SIMPLE_MUX
 	imply SND_SOC_SIRF_AUDIO_CODEC
 	imply SND_SOC_SPDIF
 	imply SND_SOC_SSM2305
@@ -1240,6 +1241,10 @@ config SND_SOC_SIMPLE_AMPLIFIER
 	tristate "Simple Audio Amplifier"
 	select GPIOLIB
 
+config SND_SOC_SIMPLE_MUX
+	tristate "Simple Audio Mux"
+	select GPIOLIB
+
 config SND_SOC_SIRF_AUDIO_CODEC
 	tristate "SiRF SoC internal audio codec"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 11ce98c25d6c..90f1a2b7ade0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -305,6 +305,8 @@ snd-soc-tpa6130a2-objs := tpa6130a2.o
 snd-soc-tas2552-objs := tas2552.o
 snd-soc-tas2562-objs := tas2562.o
 snd-soc-tas2764-objs := tas2764.o
+# Mux
+snd-soc-simple-mux-objs := simple-mux.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
 obj-$(CONFIG_SND_SOC_AB8500_CODEC)	+= snd-soc-ab8500-codec.o
@@ -613,3 +615,5 @@ obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
 obj-$(CONFIG_SND_SOC_SIMPLE_AMPLIFIER)	+= snd-soc-simple-amplifier.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+# Mux
+obj-$(CONFIG_SND_SOC_SIMPLE_MUX)	+= snd-soc-simple-mux.o
diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
new file mode 100644
index 000000000000..e0a09dadfa7c
--- /dev/null
+++ b/sound/soc/codecs/simple-mux.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Bootlin SA
+ * Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <sound/soc.h>
+
+struct simple_mux {
+	struct gpio_desc *gpiod_mux;
+	unsigned int mux;
+};
+
+static const char * const simple_mux_texts[] = {
+	"Input 1", "Input 2"
+};
+
+static SOC_ENUM_SINGLE_EXT_DECL(simple_mux_enum, simple_mux_texts);
+
+static int simple_mux_control_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
+
+	ucontrol->value.enumerated.item[0] = priv->mux;
+
+	return 0;
+}
+
+static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
+	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
+
+	if (ucontrol->value.enumerated.item[0] > e->items)
+		return -EINVAL;
+
+	if (priv->mux == ucontrol->value.enumerated.item[0])
+		return 0;
+
+	priv->mux = ucontrol->value.enumerated.item[0];
+
+	gpiod_set_value_cansleep(priv->gpiod_mux, priv->mux);
+
+	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
+					     ucontrol->value.enumerated.item[0],
+					     e, NULL);
+}
+
+static const struct snd_kcontrol_new simple_mux_mux =
+	SOC_DAPM_ENUM_EXT("Muxer", simple_mux_enum, simple_mux_control_get, simple_mux_control_put);
+
+static const struct snd_soc_dapm_widget simple_mux_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("IN1"),
+	SND_SOC_DAPM_INPUT("IN2"),
+	SND_SOC_DAPM_MUX("MUX", SND_SOC_NOPM, 0, 0, &simple_mux_mux),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+};
+
+static const struct snd_soc_dapm_route simple_mux_dapm_routes[] = {
+	{ "OUT", NULL, "MUX" },
+	{ "MUX", "Input 1", "IN1" },
+	{ "MUX", "Input 2", "IN2" },
+};
+
+static const struct snd_soc_component_driver simple_mux_component_driver = {
+	.dapm_widgets		= simple_mux_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(simple_mux_dapm_widgets),
+	.dapm_routes		= simple_mux_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(simple_mux_dapm_routes),
+};
+
+static int simple_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct simple_mux *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	priv->gpiod_mux = devm_gpiod_get(dev, "mux", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpiod_mux)) {
+		err = PTR_ERR(priv->gpiod_mux);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'mux' gpio: %d", err);
+		return err;
+	}
+
+	return devm_snd_soc_register_component(dev, &simple_mux_component_driver, NULL, 0);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id simple_mux_ids[] = {
+	{ .compatible = "simple-audio-mux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, simple_mux_ids);
+#endif
+
+static struct platform_driver simple_mux_driver = {
+	.driver = {
+		.name = "simple-mux",
+		.of_match_table = of_match_ptr(simple_mux_ids),
+	},
+	.probe = simple_mux_probe,
+};
+
+module_platform_driver(simple_mux_driver);
+
+MODULE_DESCRIPTION("ASoC Simple Audio Mux driver");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
+MODULE_LICENSE("GPL");
-- 
2.28.0

