Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBA2C4EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKZGoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:44:04 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37772 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKZGoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:44:03 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C07C41A0A7A;
        Thu, 26 Nov 2020 07:44:01 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B06021A0A76;
        Thu, 26 Nov 2020 07:43:56 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 74756402EB;
        Thu, 26 Nov 2020 07:43:50 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, cychiang@chromium.org,
        kuninori.morimoto.gx@renesas.com, tzungbi@google.com,
        shengjiu.wang@nxp.com, grandmaster@al2klimov.de,
        jbrunet@baylibre.com, pankaj.laxminarayan.bharadiya@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: Add RX support
Date:   Thu, 26 Nov 2020 14:36:48 +0800
Message-Id: <1606372608-2329-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI interface can also be used as receiver, this patch is to
add such support. The most difference compare with TX is that RX
don't need to get edid information.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/hdmi-codec.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e8410b2433de..d5fcc4db8284 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -282,6 +282,7 @@ struct hdmi_codec_priv {
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("TX"),
+	SND_SOC_DAPM_OUTPUT("RX"),
 };
 
 enum {
@@ -389,6 +390,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int ret = 0;
 
 	mutex_lock(&hcp->lock);
@@ -404,7 +406,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			goto err;
 	}
 
-	if (hcp->hcd.ops->get_eld) {
+	if (tx && hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		if (ret)
@@ -660,14 +662,20 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct snd_soc_dapm_context *dapm;
 	struct hdmi_codec_daifmt *daifmt;
-	struct snd_soc_dapm_route route = {
-		.sink = "TX",
-		.source = dai->driver->playback.stream_name,
+	struct snd_soc_dapm_route route[] = {
+		{
+			.sink = "TX",
+			.source = dai->driver->playback.stream_name,
+		},
+		{
+			.sink = dai->driver->capture.stream_name,
+			.source = "RX",
+		},
 	};
 	int ret;
 
 	dapm = snd_soc_component_get_dapm(dai->component);
-	ret = snd_soc_dapm_add_routes(dapm, &route, 1);
+	ret = snd_soc_dapm_add_routes(dapm, route, 2);
 	if (ret)
 		return ret;
 
@@ -757,6 +765,14 @@ static const struct snd_soc_dai_driver hdmi_i2s_dai = {
 		.formats = I2S_FORMATS,
 		.sig_bits = 24,
 	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = HDMI_RATES,
+		.formats = I2S_FORMATS,
+		.sig_bits = 24,
+	},
 	.ops = &hdmi_codec_i2s_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
@@ -773,6 +789,13 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 		.rates = HDMI_RATES,
 		.formats = SPDIF_FORMATS,
 	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = HDMI_RATES,
+		.formats = SPDIF_FORMATS,
+	},
 	.ops = &hdmi_codec_spdif_dai_ops,
 	.pcm_new = hdmi_codec_pcm_new,
 };
-- 
2.27.0

