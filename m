Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E22F36E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392791AbhALRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:19:07 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:2798 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391734AbhALRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:19:07 -0500
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CHHUZ0001479;
        Tue, 12 Jan 2021 12:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=en0SHBQNYzb3EbnemJYrirxBLqwj0SMrc1Fn+QdTzss=;
 b=QFxuR0Fu/0PvGWNGvyMp8ZPL8tMcQxEf1CFVLijEiuhpKsn5VOCVEe8ws3xLOSiIYAye
 NPTyTmuv0ZxncaTyMPoSar9lXGfab8+Og0ebwfgj6rRR6hS3gb/ZTDL7n1P2mN7eWV68
 nmaYPqe9ZzclT3q2wXfGJhXbGS1paepFD3Ekrrkc5y564c9zwZNwAsE+p6M5w/bBKxlL
 SfShVoJ0sf7g82MEauyNsgaReycvI4Vm1rLWq9RP4mnerD7hsc0ZY1SqBEomCCktxw56
 XHiLVwVgdHavPpht2Dd5+bi20bHedz/6QynMS+b3Sk5JIpyunfysM16jVJd/L7/xrn5g 8g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 361fyb80t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 12:18:26 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CHBdAE099119;
        Tue, 12 Jan 2021 12:18:25 -0500
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 361fqe0qba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 12:18:25 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.79,341,1602565200"; 
   d="scan'208";a="1653628701"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
Date:   Wed, 13 Jan 2021 01:18:14 +0800
Message-Id: <20210112171814.5404-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101120100
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Some new Dell system is going to support audio internal micphone
privacy setting from hardware level with micmute led state changing
When micmute hotkey pressed by user, soft mute will need to be enabled
firstly in case of pop noise, and codec driver need to react to mic
mute event to EC(embedded controller) notifying that SW mute is completed
Then EC will do the hardware mute physically within the timeout reached

This patch allow codec rt715 driver to ack EC when micmute key pressed
through this micphone led control interface like hda_generic provided
ACPI method defined in dell-privacy micmute led trigger will be called
for notifying the EC that software mute has been completed

Signed-off-by: Perry Yuan <perry_yuan@dell.com>

--------
v2 -> v3
* simplify the patch to reuse some val value
* add more detail to the commit info

v1 -> v2:
* fix some format issue
--------
---
 sound/soc/codecs/rt715-sdca.c | 16 ++++++++++++++++
 sound/soc/codecs/rt715-sdca.h |  1 +
 sound/soc/codecs/rt715.c      | 14 ++++++++++++++
 sound/soc/codecs/rt715.h      |  1 +
 4 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index b43ac8559e45..861a0d2a8957 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -12,6 +12,7 @@
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/soundwire/sdw.h>
@@ -244,6 +245,7 @@ static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int max = mc->max;
 	int val;
 
+	pr_err("++++++rt715_sdca_get_volsw++\n");
 	val = snd_soc_component_read(component, mc->reg);
 	if (val < 0)
 		return -EINVAL;
@@ -261,6 +263,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt715_sdca_priv *rt715 = snd_soc_component_get_drvdata(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int val, val2, loop_cnt = 2, i;
@@ -268,6 +271,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = mc->rreg;
 	unsigned int reg = mc->reg;
 	unsigned int max = mc->max;
+	unsigned int val0, val1;
 	int err;
 
 	val = ucontrol->value.integer.value[0];
@@ -287,6 +291,18 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 			return err;
 	}
 
+#if IS_ENABLED(CONFIG_DELL_PRIVACY)
+	/* dell privacy LED trigger state changed by muted/unmute switch */
+	if (mc->invert) {
+		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
+			rt715->micmute_led = LED_OFF;
+		} else {
+			rt715->micmute_led = LED_ON;
+		}
+		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
+	}
+#endif
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt715-sdca.h b/sound/soc/codecs/rt715-sdca.h
index 840c237895dd..f8988ab88f80 100644
--- a/sound/soc/codecs/rt715-sdca.h
+++ b/sound/soc/codecs/rt715-sdca.h
@@ -31,6 +31,7 @@ struct rt715_sdca_priv {
 	int l_is_unmute;
 	int r_is_unmute;
 	int hw_sdw_ver;
+	bool micmute_led;
 };
 
 struct rt715_sdw_stream_data {
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index cdcba70146da..b4e480744c94 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 #include <linux/soundwire/sdw.h>
@@ -88,6 +89,7 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 		RT715_SET_GAIN_MIX_ADC2_L};
 	unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
 	unsigned int read_ll, read_rl, i, j, loop_cnt;
+	unsigned int val0, val1;
 
 	if (strstr(ucontrol->id.name, "Main Capture Switch") ||
 		strstr(ucontrol->id.name, "Main Capture Volume"))
@@ -95,6 +97,18 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	else
 		loop_cnt = 1;
 
+#if IS_ENABLED(CONFIG_DELL_PRIVACY)
+	/* Micmute LED state changed by muted/unmute switch */
+	if (mc->invert) {
+		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
+			rt715->micmute_led = LED_OFF;
+		} else {
+			rt715->micmute_led = LED_ON;
+		}
+		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
+	}
+#endif
+
 	for (j = 0; j < loop_cnt; j++) {
 		/* Can't use update bit function, so read the original value first */
 		if (loop_cnt == 1) {
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index 009a8266f606..57c9af041181 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -22,6 +22,7 @@ struct rt715_priv {
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
+	bool micmute_led;
 };
 
 struct sdw_stream_data {
-- 
2.25.1

