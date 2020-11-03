Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE292A45CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgKCM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:59:17 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:38090 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgKCM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:59:17 -0500
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3CsflM013404
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 07:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=gXiXEbn51dmWApabI5YJtghO8VjiHbPBfHDnqtSPYug=;
 b=Du6+RNFQm7y6sBg9rTCWKAytw59tv6joyKSNOUT8usHfQqyL5dlxpGMCELkZdEn7i+dt
 Jmt1t1B4lL+JmsGfixR8DJMymYPBqEciVsLd9yyr7GxZIbcwSpbSTAt8VGUOUpZISAHm
 jsCkCNdgXTY8YLKdrVCGiXNnQC6nfoJZSVfgaoBJFnOkLuiHLU4eL4jT/C2EEhD7s3gE
 E2G5hhHMtNsSG4DkPFP9rYcB4kpxLJa5RI5whoSShWiqTHFhK335TLEpHm0VKnepA24c
 5A75UMapeimzA2cZuD+gm1QHBBSOPl9FWMVbLEMWeOOm50fIFz3NfZgQjBG6zQMQ/Xi3 0A== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 34h33ca50x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:59:16 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3CwQsW025909
        for <linux-kernel@vger.kernel.org>; Tue, 3 Nov 2020 07:59:15 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 34k7jc82wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:59:15 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.77,448,1596517200"; 
   d="scan'208";a="559511945"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perry_yuan <Perry.Yuan@dell.com>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Subject: [PATCH] ASoC: rt715:add Mic Mute LED control support
Date:   Tue,  3 Nov 2020 04:58:59 -0800
Message-Id: <20201103125859.8759-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=763 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030087
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=899
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: perry_yuan <perry_yuan@dell.com>

Some new Dell system is going to support audio internal micphone
privacy setting from hardware level with micmute led state changing

This patch allow to change micmute led state through this micphone
led control interface like hda_generic provided.

Signed-off-by: Perry Yuan  <perry_yuan@dell.com>
Signed-off-by: Limonciello Mario <mario_limonciello@dell.com>
---
 sound/soc/codecs/rt715.c | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt715.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 099c8bd20006..2df2895d0092 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/leds.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -213,6 +214,45 @@ static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
 
+static const char *rt715_micmute_led_mode[] = {
+  "Off", "On"
+};
+
+static const struct soc_enum rt715_micmute_led_mode_enum =
+  SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rt715_micmute_led_mode),
+              rt715_micmute_led_mode);
+
+static int rt715_mic_mute_led_mode_get(struct snd_kcontrol *kcontrol,
+      struct snd_ctl_elem_value *ucontrol)
+{
+    struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+    struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
+    int led_mode = rt715->micmute_led;
+
+    ucontrol->value.integer.value[0] = led_mode;
+#if IS_ENABLED(CONFIG_LEDS_TRIGGER_AUDIO)
+    ledtrig_audio_set(LED_AUDIO_MICMUTE,
+            rt715->micmute_led ? LED_ON : LED_OFF);
+#endif
+    return 0;
+}
+
+static int rt715_micmute_led_mode_put(struct snd_kcontrol *kcontrol,
+      struct snd_ctl_elem_value *ucontrol)
+{
+    struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+    struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
+    int led_mode = ucontrol->value.integer.value[0];
+
+    rt715->micmute_led = led_mode;
+#if IS_ENABLED(CONFIG_LEDS_TRIGGER_AUDIO)
+    ledtrig_audio_set(LED_AUDIO_MICMUTE,
+               rt715->micmute_led ? LED_ON : LED_OFF);
+#endif
+  return 0;
+}
+
+
 static const struct snd_kcontrol_new rt715_snd_controls[] = {
 	/* Capture switch */
 	SOC_DOUBLE_R_EXT("ADC 07 Capture Switch", RT715_SET_GAIN_MIC_ADC_H,
@@ -277,6 +317,9 @@ static const struct snd_kcontrol_new rt715_snd_controls[] = {
 			RT715_SET_GAIN_LINE2_L, RT715_DIR_IN_SFT, 3, 0,
 			rt715_set_amp_gain_get, rt715_set_amp_gain_put,
 			mic_vol_tlv),
+    /*Micmute Led Control*/
+    SOC_ENUM_EXT("Micmute Led Mode", rt715_micmute_led_mode_enum,
+            rt715_mic_mute_led_mode_get, rt715_micmute_led_mode_put),
 };
 
 static int rt715_mux_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index df0f24f9bc0c..32917b7846b4 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -22,6 +22,7 @@ struct rt715_priv {
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
+    int micmute_led;
 };
 
 struct sdw_stream_data {
-- 
2.25.1

