Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4612E3AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391432AbgL1Njj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:39:39 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:20726 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391394AbgL1Nj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:39:26 -0500
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSDbcDO024327
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=tQR4jRZ/qW4QaiXsR3B6X0bnpzWvfDAF7DkqMpvHFTE=;
 b=dmL7psTX4D24omgfTn6mVJa+DRX0zWRF2aBrold8uiYoHY4ZHiQf9DQYXsVjkjRCCEeH
 4fsRs37I8izNPMjYcKmxlZbFqLGu0PK7b0JX1QRRPwbcjolAAr3uCoW66q/AFp5A1eY6
 UBCrwcBlMDA7Sd+jmzxBAThoxHn5zmL/5hp58t5CPS0Gu4n2TQ4yBt7LmSSDInR/BmdE
 RQHUI3Yr8PmqkXR0XqTZbAC8fflhMFZiC8AMz+VmtI2jMDeu2ol/+hVKOAMuVt1ssA+Y
 PywbJNyW1+WUmAXqwJVx+djhL0eHVjBU0ecI1VGTTWZ4K+0jIVvy9Ndb9fEbtf1JJfCD YA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 35p1cpcdus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:45 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSDalx8144978
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:45 -0500
Received: from ausxippc106.us.dell.com ([143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 35pkmqmdyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:38:44 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="639372522"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Perry Yuan <Perry.Yuan@dell.com>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Subject: [PATCH v2 2/2] ASoC: rt715:add Mic Mute LED control support
Date:   Mon, 28 Dec 2020 21:38:31 +0800
Message-Id: <20201228133831.17464-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_11:2020-12-24,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=955 bulkscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280085
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Some new Dell system is going to support audio internal micphone
privacy setting from hardware level with micmute led state changing
When micmute hotkey pressed by user, soft mute will need to be enabled
firstly in case of pop noise, and codec driver need to react to mic
mute event to EC notifying that SW mute is completed. Then EC will do the
HW mute physically.

This patch allow codec rt715 driver to ack EC when micmute key pressed
through this micphone led control interface like hda_generic provided.

Signed-off-by: Perry Yuan <perry_yuan@dell.com>
Signed-off-by: Limonciello Mario <mario_limonciello@dell.com>
---
 sound/soc/codecs/rt715-sdca.c | 19 ++++++++++++++++++-
 sound/soc/codecs/rt715-sdca.h |  1 +
 sound/soc/codecs/rt715.c      | 19 ++++++++++++++++++-
 sound/soc/codecs/rt715.h      |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index b43ac8559e45..e168ef6efcf5 100644
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
@@ -268,6 +269,7 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int reg2 = mc->rreg;
 	unsigned int reg = mc->reg;
 	unsigned int max = mc->max;
+	unsigned int val0, val1;
 	int err;
 
 	val = ucontrol->value.integer.value[0];
@@ -286,7 +288,22 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
 		if (err < 0)
 			return err;
 	}
-
+#if IS_ENABLED(CONFIG_DELL_PRIVACY)
+	/* Privacy LED Trigger State Changed by muted/unmute switch */
+	if (mc->invert) {
+		val0 = ucontrol->value.integer.value[0];
+		val1 = ucontrol->value.integer.value[1];
+		if (val0 == 1 && val1 == 1) {
+			rt715->micmute_led = LED_OFF;
+			ledtrig_audio_set(LED_AUDIO_MICMUTE,
+					rt715->micmute_led ? LED_ON : LED_OFF);
+		} else if (val0 == 0 && val1 == 0) {
+			rt715->micmute_led = LED_ON;
+			ledtrig_audio_set(LED_AUDIO_MICMUTE,
+					rt715->micmute_led ? LED_ON : LED_OFF);
+		}
+	}
+#endif
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt715-sdca.h b/sound/soc/codecs/rt715-sdca.h
index 840c237895dd..2ab8724ae50b 100644
--- a/sound/soc/codecs/rt715-sdca.h
+++ b/sound/soc/codecs/rt715-sdca.h
@@ -31,6 +31,7 @@ struct rt715_sdca_priv {
 	int l_is_unmute;
 	int r_is_unmute;
 	int hw_sdw_ver;
+	int micmute_led;
 };
 
 struct rt715_sdw_stream_data {
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index cdcba70146da..faa4dee6b39a 100644
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
@@ -88,13 +89,29 @@ static int rt715_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 		RT715_SET_GAIN_MIX_ADC2_L};
 	unsigned int addr_h, addr_l, val_h, val_ll, val_lr;
 	unsigned int read_ll, read_rl, i, j, loop_cnt;
+	unsigned int val0, val1;
 
 	if (strstr(ucontrol->id.name, "Main Capture Switch") ||
 		strstr(ucontrol->id.name, "Main Capture Volume"))
 		loop_cnt = 4;
 	else
 		loop_cnt = 1;
-
+#if IS_ENABLED(CONFIG_DELL_PRIVACY)
+	/*  Privacy micmute led trigger for  muted/unmute switch */
+	if (mc->invert) {
+		val0 = ucontrol->value.integer.value[0];
+		val1 = ucontrol->value.integer.value[1];
+		if (val0 == 1 && val1 == 1) {
+			rt715->micmute_led = LED_OFF;
+			ledtrig_audio_set(LED_AUDIO_MICMUTE,
+					rt715->micmute_led ? LED_ON : LED_OFF);
+		} else if (val0 == 0 && val1 == 0) {
+			rt715->micmute_led = LED_ON;
+			ledtrig_audio_set(LED_AUDIO_MICMUTE,
+					rt715->micmute_led ? LED_ON : LED_OFF);
+		}
+	}
+#endif
 	for (j = 0; j < loop_cnt; j++) {
 		/* Can't use update bit function, so read the original value first */
 		if (loop_cnt == 1) {
diff --git a/sound/soc/codecs/rt715.h b/sound/soc/codecs/rt715.h
index 009a8266f606..2d3b5b299514 100644
--- a/sound/soc/codecs/rt715.h
+++ b/sound/soc/codecs/rt715.h
@@ -22,6 +22,7 @@ struct rt715_priv {
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
+	int micmute_led;
 };
 
 struct sdw_stream_data {
-- 
2.25.1

