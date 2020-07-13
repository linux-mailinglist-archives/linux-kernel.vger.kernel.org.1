Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4D2184B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGHKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 06:13:21 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23948 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgGHKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594203199; x=1625739199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yPe6Sn1dNDUkqKd9G6KaUfJ53MUjs+1QIkwAIOtG6vI=;
  b=oFesnYJnOlY4TymBAYJ9NBLQ8wKdRrPkUJE3AxpqylNLf26t/EsQkLKA
   VMKSd12LF1V/Nht32KFDcWMPGB/40mUf3LA0xuvk3ltsnoqKym6JRR0aQ
   J7PdYJwGPTIA/Og4WoVSdpybx05cjCH25/sf68uavgLmGnNv/wooGWAci
   ENzNBKCXztLGxyF0ZsBEJt8NYgwVghcCqPQO0E8V9W6RFnx5kdWT6+lCw
   5RIDAt5UOmr4k5I8s3yek/PByPrAgRQpmdHVALii2wnpmDLp1f0S13j2x
   Vo7H6NVE/R7ipqngukjP+N7hso6zfpQB4Uc5UeJ0VMXj8dOefOPCjwF3J
   w==;
IronPort-SDR: O70QMcwbPhgHa/l5X3lhrnCVDwzvVCy6k7kEfsG1u7E4zwaX9C1D4hvNMQfq/p4apCsnesfh3f
 aQayOMQ2rptcfOYDerYqIhQh2RWasj/oIzp2usvblYfCdVo0VRCVqoZr3LRexF1AHXSWA6zCG9
 XBWRrpIHWZcRjUl0j++OHD0OHTETMt7dG8n+AywQZefic6nLaXDOC/Xg09hmW2+3JVJECuCM+S
 eXbDg6it1N5bR+AY8Wdiq9qAr54HO4WRG63uoCUXMoLsQf1OvZwx9RdMSPUeoPJtdvr0HRtEFZ
 IFc=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="81063248"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 03:13:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 03:12:49 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 8 Jul 2020 03:13:00 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3] ASoC: atmel-classd: remove codec component
Date:   Wed, 8 Jul 2020 13:12:49 +0300
Message-ID: <20200708101249.2626560-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU and the codec both are represented now as components, so for
CLASS-D we are registering two componenets with the same name. Since
there is no actual codec, we will merge the codec component into the
CPU one and use a dummy codec instead, for the DAI link.
As a bonus, debugfs will no longer report an error when will try to
create entries for both componenets with the same name.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v3:
 - fixed some newlines modified by no reason;

Changes in v2:
 - removed no longer used ATMEL_CLASSD_CODEC_DAI_NAME macro;

 sound/soc/atmel/atmel-classd.c | 132 ++++++++++++---------------------
 1 file changed, 47 insertions(+), 85 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index e98601eccfa3..2d35b08f0565 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -120,39 +120,21 @@ static int atmel_classd_cpu_dai_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
+	int err;
 
 	regmap_write(dd->regmap, CLASSD_THR, 0x0);
 
-	return clk_prepare_enable(dd->pclk);
-}
-
-static void atmel_classd_cpu_dai_shutdown(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *cpu_dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
-
-	clk_disable_unprepare(dd->pclk);
+	err = clk_prepare_enable(dd->pclk);
+	if (err)
+		return err;
+	err = clk_prepare_enable(dd->gclk);
+	if (err) {
+		clk_disable_unprepare(dd->pclk);
+		return err;
+	}
+	return 0;
 }
 
-static const struct snd_soc_dai_ops atmel_classd_cpu_dai_ops = {
-	.startup	= atmel_classd_cpu_dai_startup,
-	.shutdown	= atmel_classd_cpu_dai_shutdown,
-};
-
-static struct snd_soc_dai_driver atmel_classd_cpu_dai = {
-	.playback = {
-		.channels_min	= 1,
-		.channels_max	= 2,
-		.rates		= ATMEL_CLASSD_RATES,
-		.formats	= SNDRV_PCM_FMTBIT_S16_LE,},
-	.ops = &atmel_classd_cpu_dai_ops,
-};
-
-static const struct snd_soc_component_driver atmel_classd_cpu_dai_component = {
-	.name = "atmel-classd",
-};
-
 /* platform */
 static int
 atmel_classd_platform_configure_dma(struct snd_pcm_substream *substream,
@@ -306,31 +288,10 @@ static int atmel_classd_component_resume(struct snd_soc_component *component)
 	return regcache_sync(dd->regmap);
 }
 
-static struct snd_soc_component_driver soc_component_dev_classd = {
-	.probe			= atmel_classd_component_probe,
-	.resume			= atmel_classd_component_resume,
-	.controls		= atmel_classd_snd_controls,
-	.num_controls		= ARRAY_SIZE(atmel_classd_snd_controls),
-	.idle_bias_on		= 1,
-	.use_pmdown_time	= 1,
-	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
-};
-
-/* codec dai component */
-static int atmel_classd_codec_dai_startup(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *codec_dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
-
-	return clk_prepare_enable(dd->gclk);
-}
-
-static int atmel_classd_codec_dai_digital_mute(struct snd_soc_dai *codec_dai,
-	int mute)
+static int atmel_classd_cpu_dai_digital_mute(struct snd_soc_dai *cpu_dai,
+					     int mute)
 {
-	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_component *component = cpu_dai->component;
 	u32 mask, val;
 
 	mask = CLASSD_MR_LMUTE_MASK | CLASSD_MR_RMUTE_MASK;
@@ -373,13 +334,13 @@ static struct {
 };
 
 static int
-atmel_classd_codec_dai_hw_params(struct snd_pcm_substream *substream,
-			    struct snd_pcm_hw_params *params,
-			    struct snd_soc_dai *codec_dai)
+atmel_classd_cpu_dai_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_component *component = cpu_dai->component;
 	int fs;
 	int i, best, best_val, cur_val, ret;
 	u32 mask, val;
@@ -417,8 +378,8 @@ atmel_classd_codec_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static void
-atmel_classd_codec_dai_shutdown(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *codec_dai)
+atmel_classd_cpu_dai_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct atmel_classd *dd = snd_soc_card_get_drvdata(rtd->card);
@@ -426,10 +387,10 @@ atmel_classd_codec_dai_shutdown(struct snd_pcm_substream *substream,
 	clk_disable_unprepare(dd->gclk);
 }
 
-static int atmel_classd_codec_dai_prepare(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *codec_dai)
+static int atmel_classd_cpu_dai_prepare(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_component *component = cpu_dai->component;
 
 	snd_soc_component_update_bits(component, CLASSD_MR,
 				CLASSD_MR_LEN_MASK | CLASSD_MR_REN_MASK,
@@ -439,10 +400,10 @@ static int atmel_classd_codec_dai_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int atmel_classd_codec_dai_trigger(struct snd_pcm_substream *substream,
-					int cmd, struct snd_soc_dai *codec_dai)
+static int atmel_classd_cpu_dai_trigger(struct snd_pcm_substream *substream,
+					int cmd, struct snd_soc_dai *cpu_dai)
 {
-	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_component *component = cpu_dai->component;
 	u32 mask, val;
 
 	mask = CLASSD_MR_LEN_MASK | CLASSD_MR_REN_MASK;
@@ -468,19 +429,16 @@ static int atmel_classd_codec_dai_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops atmel_classd_codec_dai_ops = {
-	.digital_mute	= atmel_classd_codec_dai_digital_mute,
-	.startup	= atmel_classd_codec_dai_startup,
-	.shutdown	= atmel_classd_codec_dai_shutdown,
-	.hw_params	= atmel_classd_codec_dai_hw_params,
-	.prepare	= atmel_classd_codec_dai_prepare,
-	.trigger	= atmel_classd_codec_dai_trigger,
+static const struct snd_soc_dai_ops atmel_classd_cpu_dai_ops = {
+	.startup        = atmel_classd_cpu_dai_startup,
+	.shutdown       = atmel_classd_cpu_dai_shutdown,
+	.digital_mute	= atmel_classd_cpu_dai_digital_mute,
+	.hw_params	= atmel_classd_cpu_dai_hw_params,
+	.prepare	= atmel_classd_cpu_dai_prepare,
+	.trigger	= atmel_classd_cpu_dai_trigger,
 };
 
-#define ATMEL_CLASSD_CODEC_DAI_NAME  "atmel-classd-hifi"
-
-static struct snd_soc_dai_driver atmel_classd_codec_dai = {
-	.name = ATMEL_CLASSD_CODEC_DAI_NAME,
+static struct snd_soc_dai_driver atmel_classd_cpu_dai = {
 	.playback = {
 		.stream_name	= "Playback",
 		.channels_min	= 1,
@@ -488,7 +446,18 @@ static struct snd_soc_dai_driver atmel_classd_codec_dai = {
 		.rates		= ATMEL_CLASSD_RATES,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &atmel_classd_codec_dai_ops,
+	.ops = &atmel_classd_cpu_dai_ops,
+};
+
+static const struct snd_soc_component_driver atmel_classd_cpu_dai_component = {
+	.name			= "atmel-classd",
+	.probe			= atmel_classd_component_probe,
+	.resume			= atmel_classd_component_resume,
+	.controls		= atmel_classd_snd_controls,
+	.num_controls		= ARRAY_SIZE(atmel_classd_snd_controls),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
 };
 
 /* ASoC sound card */
@@ -517,9 +486,9 @@ static int atmel_classd_asoc_card_init(struct device *dev,
 
 	dai_link->name			= "CLASSD";
 	dai_link->stream_name		= "CLASSD PCM";
-	dai_link->codecs->dai_name	= ATMEL_CLASSD_CODEC_DAI_NAME;
+	dai_link->codecs->dai_name	= "snd-soc-dummy-dai";
 	dai_link->cpus->dai_name	= dev_name(dev);
-	dai_link->codecs->name		= dev_name(dev);
+	dai_link->codecs->name		= "snd-soc-dummy";
 	dai_link->platforms->name	= dev_name(dev);
 
 	card->dai_link	= dai_link;
@@ -620,13 +589,6 @@ static int atmel_classd_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_component(dev, &soc_component_dev_classd,
-					&atmel_classd_codec_dai, 1);
-	if (ret) {
-		dev_err(dev, "could not register component: %d\n", ret);
-		return ret;
-	}
-
 	/* register sound card */
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card) {
-- 
2.25.1

