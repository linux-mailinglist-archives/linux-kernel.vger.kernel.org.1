Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81C2E32D1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgL0VOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgL0VOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609103597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vh/KkzsTKpkkyc1hK+SFAImLEHZ8ZJqj8ya7YteCNo=;
        b=Imn/SzCXtd7BZq0QafFAm+YLkiHNCeEsBCc/TfcP68HictvXr0KLtYnob6sQTQmxTXwb+I
        IgSxOUcuHADNSxGZGn+8Bex3WmoL6vb+IRXP2dVcEJva4zXEYk/0eOhvaRe9YsSUNlMvZR
        fwmSmgEfiF+tx5Bp5Az8TJH57ooQbHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-0G39lbq8OpGDDFYAz4Hm_A-1; Sun, 27 Dec 2020 16:13:14 -0500
X-MC-Unique: 0G39lbq8OpGDDFYAz4Hm_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20A39107ACE3;
        Sun, 27 Dec 2020 21:13:12 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-25.ams2.redhat.com [10.36.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8EB21ACB9;
        Sun, 27 Dec 2020 21:13:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 14/14] ASoC: Intel: bytcr_wm5102: Add jack detect support
Date:   Sun, 27 Dec 2020 22:12:32 +0100
Message-Id: <20201227211232.117801-15-hdegoede@redhat.com>
In-Reply-To: <20201227211232.117801-1-hdegoede@redhat.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Arizona/WM5102 driver uses the MFD framework to create several
sub-devices for the WM5102 codec and then uses a driver per function.

The jack-detect support for the WM5102 codec is handled by the
extcon-arizona driver. This driver exports info about the jack state
to userspace through the standard extcon sysfs class interface.

But standard Linux userspace does not monitor/use the extcon sysfs
interface for jack-detection.

The extcon-arizona driver can also report jack-detect state through
the standard ASoC jack interface. For this we need to create a
snd_soc_jack and pass this to the extcon-arizona driver through the
shared arizona data struct.

The extcon-arizona code already depends on (waits for with -EPROBE_DEFER)
the snd_card being registered by the machine driver, so this does not
cause any ordering issues.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_wm5102.c | 36 ++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
index 7de09cb5c50e..25c7a6cacaad 100644
--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -13,11 +13,13 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -31,6 +33,8 @@
 #define WM5102_MAX_SYSCLK_11025	45158400 /* max sysclk for 11.025K family */
 
 struct byt_wm5102_private {
+	struct snd_soc_jack jack;
+	struct arizona *arizona;
 	struct clk *mclk;
 	struct gpio_desc *spkvdd_en_gpio;
 };
@@ -184,11 +188,22 @@ static const struct snd_kcontrol_new byt_wm5102_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static struct snd_soc_jack_pin byt_wm5102_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct byt_wm5102_private *priv = snd_soc_card_get_drvdata(card);
-	int ret;
+	int ret, jack_type;
 
 	card->dapm.idle_bias_off = true;
 
@@ -217,6 +232,22 @@ static int byt_wm5102_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	jack_type = SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		    SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	ret = snd_soc_card_jack_new(card, "Headset", jack_type,
+				    &priv->jack, byt_wm5102_pins,
+				    ARRAY_SIZE(byt_wm5102_pins));
+	if (ret) {
+		dev_err(card->dev, "Error creating jack: %d\n", ret);
+		return ret;
+	}
+	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	priv->arizona->jack = &priv->jack;
+
 	return 0;
 }
 
@@ -409,6 +440,8 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
 
 	/* Note no devm_ here since we call gpiod_get on codec_dev rather then dev */
 	priv->spkvdd_en_gpio = gpiod_get(codec_dev, "wlf,spkvdd-ena", GPIOD_OUT_LOW);
+
+	priv->arizona = dev_get_drvdata(codec_dev);
 	put_device(codec_dev);
 
 	if (IS_ERR(priv->spkvdd_en_gpio))
@@ -452,6 +485,7 @@ static int snd_byt_wm5102_mc_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct byt_wm5102_private *priv = snd_soc_card_get_drvdata(card);
 
+	priv->arizona->jack = NULL;
 	gpiod_put(priv->spkvdd_en_gpio);
 	return 0;
 }
-- 
2.28.0

