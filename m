Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EEA219DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGIK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIK2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:28:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82899C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:28:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so914266pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sIbETW3uJnbzMUlyea9DImVmPFKh7zywB3W58k34fc=;
        b=e+hQgyGWzv34cxToa3rNYDn1MJaWIkJvIZS6kKpZRu7K2+GCZW3Y3l9wRLDQ9mJRyO
         3n2AA0TTJX17zt+Q7hDSMr7t+do6N5D1cDWO1aqz+gWFRGo+b02fFcDuIxIOGr38bTgd
         mArjpN6TZbwHuweba+qdIytGWqP/+hvcKDkIVXi7hXPKm9SGtBVyoe6aDIgU55pcZKCb
         SaapVqS34QsLUzGzmAZOpInXskeaBxxEOjGOscw33aRq4oFDn/HDtcHUkdlAzK2jKb7m
         Qld+9MlufiFn0GTdVkNMAPUppNOiy8kmBCj0+fibsbgPYQDbb8It+JjqoRZFs054kYzi
         kB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sIbETW3uJnbzMUlyea9DImVmPFKh7zywB3W58k34fc=;
        b=CCqepFrCl20EnZZq5CqS6tItt+2ehLFqSmI8tRgIeCpgACS/HPB+NbHqFsg3K5J+mG
         VfGHhrDMycQY1LncQV2iUGSBBtojIZf4iHPI3UQgOtXAweMkN/rRoFLhF3tebditEIKZ
         lIBueRtjL+exqk48cthZyP3c4Zfl9OpaUDiGxUe/2Z1Aj5TydSfJMS7VW3ESSCrZSJvg
         0GYSY1DmpM/lfsSwlWY1OEytccavQO9CJx9MMod8cfpg1aYq3DnZnsHaF/pWsE53LQDm
         GglWRpiGlNRkfx1qPTtEmQ3fUex5xVlCW4zAferW1tISKsS5CagAUThGwEr5tMMV7LHm
         TXZA==
X-Gm-Message-State: AOAM531zpO7i67NeU+cEVtYjdKzDn6CxviT39pUZqunL5lc7z78PcTYD
        JG35k/wy97htqtNvXQPx4mA=
X-Google-Smtp-Source: ABdhPJzhG+Pl9Q9GCF92OOHthDcS3VhET6Qilx0hb0VRCkoWmuuYaF8JtUZnAkHw1YF+04gM9teytg==
X-Received: by 2002:a17:90a:324c:: with SMTP id k70mr14963645pjb.18.1594290490957;
        Thu, 09 Jul 2020 03:28:10 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:28:10 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 4/7] staging: greybus: audio: Resolve compilation error in topology parser
Date:   Thu,  9 Jul 2020 15:57:20 +0530
Message-Id: <2542330352ae1d01469a616ea45edb461615e072.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594290158.git.vaibhav.sr@gmail.com>
References: <cover.1594290158.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation errors for GB Audio topology parser code with recent
kernel versions.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/greybus/audio_topology.c | 123 +++++++++++------------
 1 file changed, 57 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 4ac30accf226..ad88d3127a60 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -5,8 +5,8 @@
  * Copyright 2015-2016 Linaro Ltd.
  */
 
+#include <linux/greybus.h>
 #include "audio_codec.h"
-#include "greybus_protocols.h"
 
 #define GBAUDIO_INVALID_ID	0xFF
 
@@ -165,15 +165,15 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_info *info;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gbcodec = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gbcodec = snd_soc_component_get_drvdata(comp);
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	data = (struct gbaudio_ctl_pvt *)kcontrol->private_value;
 	info = (struct gb_audio_ctl_elem_info *)data->info;
 
 	if (!info) {
-		dev_err(codec->dev, "NULL info for %s\n", uinfo->id.name);
+		dev_err(comp->dev, "NULL info for %s\n", uinfo->id.name);
 		return -EINVAL;
 	}
 
@@ -201,7 +201,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 		strlcpy(uinfo->value.enumerated.name, name, NAME_SIZE);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		break;
 	}
@@ -216,11 +216,11 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -239,7 +239,7 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -262,7 +262,7 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 				le32_to_cpu(gbvalue.value.enumerated_item[1]);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		ret = -EINVAL;
 		break;
@@ -278,11 +278,11 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -309,7 +309,7 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 				cpu_to_le32(ucontrol->value.enumerated.item[1]);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		ret = -EINVAL;
 		break;
@@ -328,7 +328,7 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 	}
 
@@ -352,11 +352,7 @@ static int gbcodec_mixer_dapm_ctl_info(struct snd_kcontrol *kcontrol,
 	int platform_max, platform_min;
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_info *info;
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	data = (struct gbaudio_ctl_pvt *)kcontrol->private_value;
 	info = (struct gb_audio_ctl_elem_info *)data->info;
 
@@ -387,11 +383,11 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	struct gbaudio_module_info *module;
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -415,7 +411,7 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -437,11 +433,11 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	struct gbaudio_module_info *module;
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -464,11 +460,8 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	if (gbvalue.value.integer_value[0] != val) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
 			widget = wlist->widgets[wi];
-
-			widget->value = val;
-			widget->dapm->update = NULL;
-			snd_soc_dapm_mixer_update_power(widget, kcontrol,
-							connect);
+			snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol,
+							connect, NULL);
 		}
 		gbvalue.value.integer_value[0] =
 			cpu_to_le32(ucontrol->value.integer.value[0]);
@@ -484,7 +477,7 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gb_pm_runtime_put_autosuspend(bundle);
 
 		if (ret) {
-			dev_err_ratelimited(codec->dev,
+			dev_err_ratelimited(codec_dev,
 					    "%d:Error in %s for %s\n", ret,
 					    __func__, kcontrol->id.name);
 			return ret;
@@ -553,11 +546,11 @@ static int gbcodec_enum_ctl_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	int ret, ctl_id;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
 	struct gb_bundle *bundle;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -580,7 +573,7 @@ static int gbcodec_enum_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -598,11 +591,11 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	int ret, ctl_id;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
 	struct gb_bundle *bundle;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -613,13 +606,13 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 	if (ctl_id < 0)
 		return -EINVAL;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] > e->items - 1)
 		return -EINVAL;
 	gbvalue.value.enumerated_item[0] =
 		cpu_to_le32(ucontrol->value.enumerated.item[0]);
 
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] > e->items - 1)
 			return -EINVAL;
 		gbvalue.value.enumerated_item[1] =
 			cpu_to_le32(ucontrol->value.enumerated.item[1]);
@@ -637,8 +630,8 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
-				    __func__, kcontrol->id.name);
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n",
+				    ret, __func__, kcontrol->id.name);
 	}
 
 	return ret;
@@ -659,13 +652,13 @@ static int gbaudio_tplg_create_enum_kctl(struct gbaudio_module_info *gb,
 	gb_enum = &ctl->info.value.enumerated;
 
 	/* since count=1, and reg is dummy */
-	gbe->max = le32_to_cpu(gb_enum->items);
+	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
 
 	/* debug enum info */
-	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->max,
+	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
 		le16_to_cpu(gb_enum->names_length));
-	for (i = 0; i < gbe->max; i++)
+	for (i = 0; i < gbe->items; i++)
 		dev_dbg(gb->dev, "src[%d]: %s\n", i, gbe->texts[i]);
 
 	*kctl = (struct snd_kcontrol_new)
@@ -720,8 +713,8 @@ static int gbcodec_enum_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct gbaudio_module_info *module;
 	struct gb_audio_ctl_elem_value gbvalue;
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_bundle *bundle;
 
@@ -745,7 +738,7 @@ static int gbcodec_enum_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -768,12 +761,12 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_bundle *bundle;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] > e->items - 1)
 		return -EINVAL;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -797,7 +790,7 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -814,7 +807,7 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	}
 
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] > e->items - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
@@ -837,16 +830,14 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gb_pm_runtime_put_autosuspend(bundle);
 
 		if (ret) {
-			dev_err_ratelimited(codec->dev,
+			dev_err_ratelimited(codec_dev,
 					    "%d:Error in %s for %s\n", ret,
 					    __func__, kcontrol->id.name);
 		}
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
 			widget = wlist->widgets[wi];
-
-			widget->value = val;
-			widget->dapm->update = NULL;
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			snd_soc_dapm_mux_update_power(widget->dapm, kcontrol,
+						      val, e, NULL);
 		}
 	}
 
@@ -868,13 +859,13 @@ static int gbaudio_tplg_create_enum_ctl(struct gbaudio_module_info *gb,
 	gb_enum = &ctl->info.value.enumerated;
 
 	/* since count=1, and reg is dummy */
-	gbe->max = le32_to_cpu(gb_enum->items);
+	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
 
 	/* debug enum info */
-	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->max,
+	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
 		le16_to_cpu(gb_enum->names_length));
-	for (i = 0; i < gbe->max; i++)
+	for (i = 0; i < gbe->items; i++)
 		dev_dbg(gb->dev, "src[%d]: %s\n", i, gbe->texts[i]);
 
 	*kctl = (struct snd_kcontrol_new)
@@ -935,12 +926,12 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 {
 	int wid;
 	int ret;
-	struct snd_soc_codec *codec = w->codec;
-	struct gbaudio_codec_info *gbcodec = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = w->dapm->dev;
+	struct gbaudio_codec_info *gbcodec = dev_get_drvdata(codec_dev);
 	struct gbaudio_module_info *module;
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "%s %s %d\n", __func__, w->name, event);
+	dev_dbg(codec_dev, "%s %s %d\n", __func__, w->name, event);
 
 	/* Find relevant module */
 	module = find_gb_module(gbcodec, w->name);
@@ -950,7 +941,7 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 	/* map name to widget id */
 	wid = gbaudio_map_widgetname(module, w->name);
 	if (wid < 0) {
-		dev_err(codec->dev, "Invalid widget name:%s\n", w->name);
+		dev_err(codec_dev, "Invalid widget name:%s\n", w->name);
 		return -EINVAL;
 	}
 
@@ -973,7 +964,7 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 		break;
 	}
 	if (ret)
-		dev_err_ratelimited(codec->dev,
+		dev_err_ratelimited(codec_dev,
 				    "%d: widget, event:%d failed:%d\n", wid,
 				    event, ret);
 
-- 
2.27.0

