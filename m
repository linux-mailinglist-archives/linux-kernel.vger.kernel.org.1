Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F1E2F93E6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbhAQQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 11:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729202AbhAQQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 11:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610899593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9D+0tUKPjQQAlSir0FGZryFkNZfTi+NRVIcyILGDxg=;
        b=IUEQ//GqsxPVGCTqBQCEapwDYLVTkwfC+ZahHwBe1mKp0W6oOfLKkWzqeT1qelTOZ2dEcS
        SDK/2P8o7So1WR+ptxOgtxsmC1BYVEwFhy7tdigOFwIBKpy3OVKNiShYT+ndahNqYyuTXh
        wKtznfZWCjGSXnzs3pWW9I8Wo49B9WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-PJtzOG64PUCafzRqFfQkGg-1; Sun, 17 Jan 2021 11:06:29 -0500
X-MC-Unique: PJtzOG64PUCafzRqFfQkGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90AD15723;
        Sun, 17 Jan 2021 16:06:27 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-7.ams2.redhat.com [10.36.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 850595C233;
        Sun, 17 Jan 2021 16:06:25 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v2 09/12] ASoC: arizona-jack: Use snd_soc_jack to report jack events
Date:   Sun, 17 Jan 2021 17:05:52 +0100
Message-Id: <20210117160555.78376-10-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-1-hdegoede@redhat.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the snd_soc_jack code to report jack events, instead of using extcon
for reporting the cable-type + an input_dev for reporting the button
presses.

The snd_soc_jack code will report the cable-type through both input_dev
events and through ALSA controls and the button-presses through input_dev
events.

Note that this means that when the codec drivers are moved over to use
the new arizona-jack.c library code instead of having a separate MFD
extcon cell with the extcon-arizona.c driver, we will no longer report
extcon events to userspace for cable-type changes. This should not be
a problem since "standard" Linux distro userspace does not (and has
never) used the extcon class interface for this. Android does have
support for the extcon class interface, but that was introduced in
the same release as support for input_dev cable-type events, so this
should not be a problem for Android either.

Note this also reduces ARIZONA_MAX_MICD_RANGE from 8 to 6, this is
ok to do since this info is always provided through pdata (or defaults)
and cannot be overridden from devicetree. All in kernel users of the
pdata (and the fallback defaults) define 6 or less buttons/ranges.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/arizona-jack.c | 149 +++++++++-----------------------
 sound/soc/codecs/arizona.h      |   7 +-
 2 files changed, 47 insertions(+), 109 deletions(-)

diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
index eb46087f3ab7..515914d2d661 100644
--- a/sound/soc/codecs/arizona-jack.c
+++ b/sound/soc/codecs/arizona-jack.c
@@ -16,8 +16,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/extcon-provider.h>
 
+#include <sound/jack.h>
 #include <sound/soc.h>
 
 #include <linux/mfd/arizona/core.h>
@@ -29,6 +29,12 @@
 
 #define ARIZONA_MAX_MICD_RANGE 8
 
+/*
+ * The hardware supports 8 ranges / buttons, but the snd-jack interface
+ * only supports 6 buttons (button 0-5).
+ */
+#define ARIZONA_MAX_MICD_BUTTONS 6
+
 #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
 #define ARIZONA_MICD_CLAMP_MODE_JDH      0x5
 #define ARIZONA_MICD_CLAMP_MODE_JDL_GP5H 0x9
@@ -86,14 +92,6 @@ static const int arizona_micd_levels[] = {
 	1257, 30000,
 };
 
-static const unsigned int arizona_cable[] = {
-	EXTCON_MECHANICAL,
-	EXTCON_JACK_MICROPHONE,
-	EXTCON_JACK_HEADPHONE,
-	EXTCON_JACK_LINE_OUT,
-	EXTCON_NONE,
-};
-
 static void arizona_start_hpdet_acc_id(struct arizona_priv *info);
 
 static void arizona_extcon_hp_clamp(struct arizona_priv *info,
@@ -559,8 +557,7 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	struct arizona_priv *info = data;
 	struct arizona *arizona = info->arizona;
 	int id_gpio = arizona->pdata.hpdet_id_gpio;
-	unsigned int report = EXTCON_JACK_HEADPHONE;
-	int ret, reading, state;
+	int ret, reading, state, report;
 	bool mic = false;
 
 	mutex_lock(&info->lock);
@@ -573,11 +570,8 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	}
 
 	/* If the cable was removed while measuring ignore the result */
-	state = extcon_get_state(info->edev, EXTCON_MECHANICAL);
-	if (state < 0) {
-		dev_err(arizona->dev, "Failed to check cable state: %d\n", state);
-		goto out;
-	} else if (!state) {
+	state = info->jack->status & SND_JACK_MECHANICAL;
+	if (!state) {
 		dev_dbg(arizona->dev, "Ignoring HPDET for removed cable\n");
 		goto done;
 	}
@@ -603,14 +597,11 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 
 	/* Report high impedence cables as line outputs */
 	if (reading >= 5000)
-		report = EXTCON_JACK_LINE_OUT;
+		report = SND_JACK_LINEOUT;
 	else
-		report = EXTCON_JACK_HEADPHONE;
+		report = SND_JACK_HEADPHONE;
 
-	ret = extcon_set_state_sync(info->edev, report, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report HP/line: %d\n",
-			ret);
+	snd_soc_jack_report(info->jack, report, SND_JACK_LINEOUT | SND_JACK_HEADPHONE);
 
 done:
 	/* Reset back to starting range */
@@ -686,9 +677,8 @@ static void arizona_identify_headphone(struct arizona_priv *info)
 	pm_runtime_put_autosuspend(arizona->dev);
 
 	/* Just report headphone */
-	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report headphone: %d\n", ret);
+	snd_soc_jack_report(info->jack, SND_JACK_HEADPHONE,
+			    SND_JACK_LINEOUT | SND_JACK_HEADPHONE);
 
 	if (info->mic)
 		arizona_start_mic(info);
@@ -740,9 +730,8 @@ static void arizona_start_hpdet_acc_id(struct arizona_priv *info)
 
 err:
 	/* Just report headphone */
-	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
-	if (ret != 0)
-		dev_err(arizona->dev, "Failed to report headphone: %d\n", ret);
+	snd_soc_jack_report(info->jack, SND_JACK_HEADPHONE,
+			    SND_JACK_LINEOUT | SND_JACK_HEADPHONE);
 
 	info->hpdet_active = false;
 }
@@ -863,11 +852,7 @@ static int arizona_micdet_reading(void *priv)
 
 		arizona_identify_headphone(info);
 
-		ret = extcon_set_state_sync(info->edev,
-					      EXTCON_JACK_MICROPHONE, true);
-		if (ret != 0)
-			dev_err(arizona->dev, "Headset report failed: %d\n",
-				ret);
+		snd_soc_jack_report(info->jack, SND_JACK_MICROPHONE, SND_JACK_MICROPHONE);
 
 		/* Don't need to regulate for button detection */
 		ret = regulator_allow_bypass(info->micvdd, true);
@@ -930,7 +915,7 @@ static int arizona_button_reading(void *priv)
 {
 	struct arizona_priv *info = priv;
 	struct arizona *arizona = info->arizona;
-	int val, key, lvl, i;
+	int val, key, lvl;
 
 	val = arizona_micd_read(info);
 	if (val < 0)
@@ -947,14 +932,11 @@ static int arizona_button_reading(void *priv)
 			lvl = val & ARIZONA_MICD_LVL_MASK;
 			lvl >>= ARIZONA_MICD_LVL_SHIFT;
 
-			for (i = 0; i < info->num_micd_ranges; i++)
-				input_report_key(info->input,
-						 info->micd_ranges[i].key, 0);
-
 			if (lvl && ffs(lvl) - 1 < info->num_micd_ranges) {
-				key = info->micd_ranges[ffs(lvl) - 1].key;
-				input_report_key(info->input, key, 1);
-				input_sync(info->input);
+				key = ffs(lvl) - 1;
+				snd_soc_jack_report(info->jack,
+						    SND_JACK_BTN_0 >> key,
+						    info->micd_button_mask);
 			} else {
 				dev_err(arizona->dev, "Button out of range\n");
 			}
@@ -964,10 +946,7 @@ static int arizona_button_reading(void *priv)
 		}
 	} else {
 		dev_dbg(arizona->dev, "Mic button released\n");
-		for (i = 0; i < info->num_micd_ranges; i++)
-			input_report_key(info->input,
-					 info->micd_ranges[i].key, 0);
-		input_sync(info->input);
+		snd_soc_jack_report(info->jack, 0, info->micd_button_mask);
 		arizona_extcon_pulse_micbias(info);
 	}
 
@@ -980,20 +959,13 @@ static void arizona_micd_detect(struct work_struct *work)
 						struct arizona_priv,
 						micd_detect_work.work);
 	struct arizona *arizona = info->arizona;
-	int ret;
 
 	cancel_delayed_work_sync(&info->micd_timeout_work);
 
 	mutex_lock(&info->lock);
 
 	/* If the cable was removed while measuring ignore the result */
-	ret = extcon_get_state(info->edev, EXTCON_MECHANICAL);
-	if (ret < 0) {
-		dev_err(arizona->dev, "Failed to check cable state: %d\n",
-				ret);
-		mutex_unlock(&info->lock);
-		return;
-	} else if (!ret) {
+	if (!(info->jack->status & SND_JACK_MECHANICAL)) {
 		dev_dbg(arizona->dev, "Ignoring MICDET for removed cable\n");
 		mutex_unlock(&info->lock);
 		return;
@@ -1134,12 +1106,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 
 	if (info->last_jackdet == present) {
 		dev_dbg(arizona->dev, "Detected jack\n");
-		ret = extcon_set_state_sync(info->edev,
-					      EXTCON_MECHANICAL, true);
-
-		if (ret != 0)
-			dev_err(arizona->dev, "Mechanical report failed: %d\n",
-				ret);
+		snd_soc_jack_report(info->jack, SND_JACK_MECHANICAL, SND_JACK_MECHANICAL);
 
 		info->detecting = true;
 		info->mic = false;
@@ -1170,18 +1137,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 		info->hpdet_done = false;
 		info->hpdet_retried = false;
 
-		for (i = 0; i < info->num_micd_ranges; i++)
-			input_report_key(info->input,
-					 info->micd_ranges[i].key, 0);
-		input_sync(info->input);
-
-		for (i = 0; i < ARRAY_SIZE(arizona_cable) - 1; i++) {
-			ret = extcon_set_state_sync(info->edev,
-					arizona_cable[i], false);
-			if (ret != 0)
-				dev_err(arizona->dev,
-					"Removal report failed: %d\n", ret);
-		}
+		snd_soc_jack_report(info->jack, 0, ARIZONA_JACK_MASK | info->micd_button_mask);
 
 		/*
 		 * If the jack was removed during a headphone detection we
@@ -1389,29 +1345,6 @@ int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
 		break;
 	}
 
-	info->edev = devm_extcon_dev_allocate(dev, arizona_cable);
-	if (IS_ERR(info->edev)) {
-		dev_err(arizona->dev, "failed to allocate extcon device\n");
-		return -ENOMEM;
-	}
-
-	ret = devm_extcon_dev_register(dev, info->edev);
-	if (ret < 0) {
-		dev_err(arizona->dev, "extcon_dev_register() failed: %d\n",
-			ret);
-		return ret;
-	}
-
-	info->input = devm_input_allocate_device(dev);
-	if (!info->input) {
-		dev_err(arizona->dev, "Can't allocate input dev\n");
-		ret = -ENOMEM;
-		return ret;
-	}
-
-	info->input->name = "Headset";
-	info->input->phys = "arizona/extcon";
-
 	if (!pdata->micd_timeout)
 		pdata->micd_timeout = DEFAULT_MICD_TIMEOUT;
 
@@ -1535,9 +1468,9 @@ static int arizona_jack_enable_jack_detect(struct arizona_priv *info,
 		info->num_micd_ranges = ARRAY_SIZE(micd_default_ranges);
 	}
 
-	if (arizona->pdata.num_micd_ranges > ARIZONA_MAX_MICD_RANGE) {
-		dev_err(arizona->dev, "Too many MICD ranges: %d\n",
-			arizona->pdata.num_micd_ranges);
+	if (arizona->pdata.num_micd_ranges > ARIZONA_MAX_MICD_BUTTONS) {
+		dev_err(arizona->dev, "Too many MICD ranges: %d > %d\n",
+			arizona->pdata.num_micd_ranges, ARIZONA_MAX_MICD_BUTTONS);
 		return -EINVAL;
 	}
 
@@ -1571,8 +1504,11 @@ static int arizona_jack_enable_jack_detect(struct arizona_priv *info,
 			arizona_micd_levels[j], i);
 
 		arizona_micd_set_level(arizona, i, j);
-		input_set_capability(info->input, EV_KEY,
-				     info->micd_ranges[i].key);
+
+		/* SND_JACK_BTN_# masks start with the most significant bit */
+		info->micd_button_mask |= SND_JACK_BTN_0 >> i;
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_0 >> i,
+				 info->micd_ranges[i].key);
 
 		/* Enable reporting of that range */
 		regmap_update_bits(arizona->regmap, ARIZONA_MIC_DETECT_2,
@@ -1620,6 +1556,8 @@ static int arizona_jack_enable_jack_detect(struct arizona_priv *info,
 
 	arizona_extcon_set_mode(info, 0);
 
+	info->jack = jack;
+
 	pm_runtime_get_sync(arizona->dev);
 
 	if (info->micd_clamp) {
@@ -1680,18 +1618,10 @@ static int arizona_jack_enable_jack_detect(struct arizona_priv *info,
 	if (ret != 0)
 		dev_warn(arizona->dev, "Failed to set MICVDD to bypass: %d\n", ret);
 
-	ret = input_register_device(info->input);
-	if (ret) {
-		dev_err(arizona->dev, "Can't register input device: %d\n", ret);
-		goto err_hpdet;
-	}
-
 	pm_runtime_put(arizona->dev);
 
 	return 0;
 
-err_hpdet:
-	arizona_free_irq(arizona, ARIZONA_IRQ_HPDET, info);
 err_micdet:
 	arizona_free_irq(arizona, ARIZONA_IRQ_MICDET, info);
 err_fall_wake:
@@ -1704,6 +1634,7 @@ static int arizona_jack_enable_jack_detect(struct arizona_priv *info,
 	arizona_free_irq(arizona, jack_irq_rise, info);
 err_pm:
 	pm_runtime_put(arizona->dev);
+	info->jack = NULL;
 	return ret;
 }
 
@@ -1714,6 +1645,9 @@ static int arizona_jack_disable_jack_detect(struct arizona_priv *info)
 	bool change;
 	int ret;
 
+	if (!info->jack)
+		return 0;
+
 	if (info->micd_clamp) {
 		jack_irq_rise = ARIZONA_IRQ_MICD_CLAMP_RISE;
 		jack_irq_fall = ARIZONA_IRQ_MICD_CLAMP_FALL;
@@ -1748,6 +1682,7 @@ static int arizona_jack_disable_jack_detect(struct arizona_priv *info)
 	regmap_update_bits(arizona->regmap, ARIZONA_JACK_DETECT_ANALOGUE,
 			   ARIZONA_JD1_ENA, 0);
 	arizona_clk32k_disable(arizona);
+	info->jack = NULL;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index fc515845a3e6..173ebd0bf8c9 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -97,9 +97,8 @@ struct arizona_priv {
 	struct delayed_work hpdet_work;
 	struct delayed_work micd_detect_work;
 	struct delayed_work micd_timeout_work;
+	struct snd_soc_jack *jack;
 	struct regulator *micvdd;
-	struct input_dev *input;
-	struct extcon_dev *edev;
 	struct gpio_desc *micd_pol_gpio;
 
 	u16 last_jackdet;
@@ -108,6 +107,7 @@ struct arizona_priv {
 	const struct arizona_micd_config *micd_modes;
 	int micd_num_modes;
 
+	int micd_button_mask;
 	const struct arizona_micd_range *micd_ranges;
 	int num_micd_ranges;
 
@@ -257,6 +257,9 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 #define ARIZONA_RATE_ENUM_SIZE 4
 #define ARIZONA_SAMPLE_RATE_ENUM_SIZE 14
 
+/* SND_JACK_* mask for supported cable/switch types */
+#define ARIZONA_JACK_MASK  (SND_JACK_HEADSET | SND_JACK_LINEOUT | SND_JACK_MECHANICAL)
+
 extern const char * const arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
 extern const unsigned int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE];
 extern const char * const arizona_sample_rate_text[ARIZONA_SAMPLE_RATE_ENUM_SIZE];
-- 
2.28.0

