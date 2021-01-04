Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94652E96DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbhADOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:10:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48453 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhADOKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:10:05 -0500
Received: from 36-229-96-78.dynamic-ip.hinet.net ([36.229.96.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kwQXk-0006pa-Mg; Mon, 04 Jan 2021 14:09:09 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Amery Song <chao.song@intel.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] ASoC: SOF: Intel: hda: Modify existing helper to disable WAKEEN
Date:   Mon,  4 Jan 2021 22:08:51 +0800
Message-Id: <20210104140853.228448-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104140853.228448-1-kai.heng.feng@canonical.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify hda_codec_jack_wake_enable() to also support disable WAKEEN.
In addition, this patch also moves the WAKEEN disablement call out of
hda_codec_jack_check() into hda_codec_jack_wake_enable().

This is a preparation for next patch.

No functional change intended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 Mention it moves the disabling part into another function.

 sound/soc/sof/intel/hda-codec.c | 16 +++++++---------
 sound/soc/sof/intel/hda-dsp.c   |  6 ++++--
 sound/soc/sof/intel/hda.h       |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index df59c79cfdfc..b7e9931ead57 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -63,16 +63,18 @@ static int hda_codec_load_module(struct hda_codec *codec)
 }
 
 /* enable controller wake up event for all codecs with jack connectors */
-void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable)
 {
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct hda_codec *codec;
 	unsigned int mask = 0;
 
-	list_for_each_codec(codec, hbus)
-		if (codec->jacktbl.used)
-			mask |= BIT(codec->core.addr);
+	if (enable) {
+		list_for_each_codec(codec, hbus)
+			if (codec->jacktbl.used)
+				mask |= BIT(codec->core.addr);
+	}
 
 	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, mask);
 }
@@ -81,12 +83,8 @@ void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
 void hda_codec_jack_check(struct snd_sof_dev *sdev)
 {
 	struct hda_bus *hbus = sof_to_hbus(sdev);
-	struct hdac_bus *bus = sof_to_bus(sdev);
 	struct hda_codec *codec;
 
-	/* disable controller Wake Up event*/
-	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
-
 	list_for_each_codec(codec, hbus)
 		/*
 		 * Wake up all jack-detecting codecs regardless whether an event
@@ -96,7 +94,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
 			pm_request_resume(&codec->core.dev);
 }
 #else
-void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable) {}
 void hda_codec_jack_check(struct snd_sof_dev *sdev) {}
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 EXPORT_SYMBOL_NS(hda_codec_jack_wake_enable, SND_SOC_SOF_HDA_AUDIO_CODEC);
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 2b001151fe37..7d00107cf3b2 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -617,7 +617,7 @@ static int hda_suspend(struct snd_sof_dev *sdev, bool runtime_suspend)
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	if (runtime_suspend)
-		hda_codec_jack_wake_enable(sdev);
+		hda_codec_jack_wake_enable(sdev, true);
 
 	/* power down all hda link */
 	snd_hdac_ext_bus_link_power_down_all(bus);
@@ -683,8 +683,10 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	/* check jack status */
-	if (runtime_resume)
+	if (runtime_resume) {
+		hda_codec_jack_wake_enable(sdev, false);
 		hda_codec_jack_check(sdev);
+	}
 
 	/* turn off the links that were off before suspend */
 	list_for_each_entry(hlink, &bus->hlink_list, list) {
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 9ec8ae0fd649..a3b6f3e9121c 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -650,7 +650,7 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev);
  */
 void hda_codec_probe_bus(struct snd_sof_dev *sdev,
 			 bool hda_codec_use_common_hdmi);
-void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev);
+void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_codec_jack_check(struct snd_sof_dev *sdev);
 
 #endif /* CONFIG_SND_SOC_SOF_HDA */
-- 
2.29.2

