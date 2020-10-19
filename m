Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7579A292AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgJSP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgJSP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:58:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:58:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n9so199171pgf.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q7z1LcVywNMggWsH7eVhMIYFe6Y+hoETXj1+bXFU4cs=;
        b=Vn2mzx5wgW4k7xYxgLpPxpUbihovg2YiTljVNqYA7sA6bsej3t8zoYaXE1jiJ318iF
         Sm24Zw8FRnWJsxFHAgVidDXVawAmzBtcTwy4kdajaGSi/C9pDuV2pP0BME8oDjd2l9LG
         YgKPduiEp5k0QWi0zIOom0xlCzTY/Gi0BH0mYZ66iktbj3wK2jKmpMxMlRkMUFdY4z96
         UlKShGsTMK01tm8zwsfh3tIrvdGPJ72gHnR3piVACvy0dHEnp51qh0ojAUvoFqaUOLLr
         maM/w0lofhQkxtw6lBsrceEzvzlkhmCu+C8K9Cn3Fz/tOLdzz3BrdT64G0aFlcqNNvBh
         eDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q7z1LcVywNMggWsH7eVhMIYFe6Y+hoETXj1+bXFU4cs=;
        b=gsKuor6PvZZJ+0ycmpodt/cb0tv0JnNn1CZgom3kAQIQABLbTaBw+nFriB30jmx9qx
         xviKucX+mZb/CreMxAIFkrdSOCpd+jKvo678cq5yTNpNS/mtr3XwOZlkdWNepvzzw3Oc
         p6Ub0TWgoXx1zabAZebPgiI05+cyYfPsEFYlsUj37L/YC63/HzF7QtVH4i2pJYcJ4jy4
         PVnPZMBVWHKb/XlMGFhEV8Dab4IbMAPysluxcsAR2outC0U8WHDLxMtUrUjeZkMu4vw2
         SabHaSzfYZ5xp0GkKacVaEPjYUE0ZnUaD8Qbqk2CpThZ+0zByOUyhlm21rcwcZEIddG2
         1nbA==
X-Gm-Message-State: AOAM530FSa1+8r16Pj5HbzKrQG+V/rzocDlQ7g5eBAvGJrTVnC+Uqwq7
        kyP1JLTe4fnBtgZeuHvwG8Y=
X-Google-Smtp-Source: ABdhPJycNQuCHPC7F9U+ScOX2Ow8SYOz7r39MsqS5Y9OJiCBjE8aJ5s/L8+HsF9nm9ih2f5vlTdz1w==
X-Received: by 2002:a62:f201:0:b029:152:7980:368d with SMTP id m1-20020a62f2010000b02901527980368dmr632513pfh.45.1603123136921;
        Mon, 19 Oct 2020 08:58:56 -0700 (PDT)
Received: from localhost.localdomain (36-225-26-199.dynamic-ip.hinet.net. [36.225.26.199])
        by smtp.gmail.com with ESMTPSA id j11sm258385pfh.143.2020.10.19.08.58.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:58:55 -0700 (PDT)
From:   Keith Tzneg <matsufan@gmail.com>
X-Google-Original-From: Keith Tzneg <keith.tzeng@quantatw.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: boards: Add CML_RT1015 m/c driver
Date:   Mon, 19 Oct 2020 23:58:46 +0800
Message-Id: <1603123126-8739-1-git-send-email-keith.tzeng@quantatw.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>

Machine driver to enable RT5682 on SSP0, DMIC, HDMI and RT1015 AMP on
SSP1: Enabled 4 CH TDM playback with 24 bit data.

Signed-off-by: Keith Tzeng <keith.tzeng@quanta.corp-partner.google.com>
---
 sound/soc/intel/boards/Kconfig                    |  17 +
 sound/soc/intel/boards/Makefile                   |   2 +
 sound/soc/intel/boards/cml_rt1015_rt5682.c        | 570 ++++++++++++++++++++++
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c |   7 +
 4 files changed, 596 insertions(+)
 create mode 100644 sound/soc/intel/boards/cml_rt1015_rt5682.c

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index c10c378..9331d0a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -496,6 +496,23 @@ config SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_INTEL_SOF_RT5682_MACH
+        tristate "SOF with rt5682 codec in I2S Mode"
+        depends on I2C && ACPI && GPIOLIB
+        depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
+                    (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
+                   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
+        select SND_SOC_MAX98373_I2C
+        select SND_SOC_RT1015
+        select SND_SOC_RT5682_I2C
+        select SND_SOC_DMIC
+        select SND_SOC_HDAC_HDMI
+        help
+           This adds support for ASoC machine driver for SOF platforms
+           with rt5682 codec.
+           Say Y if you have such a device.
+           If unsure select "N".
+
 endif ## SND_SOC_SOF_COMETLAKE && SND_SOC_SOF_HDA_LINK
 
 if SND_SOC_SOF_JASPERLAKE
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index a58e4d2..73131cc 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -20,6 +20,7 @@ snd-soc-sst-byt-cht-es8316-objs := bytcht_es8316.o
 snd-soc-sst-byt-cht-nocodec-objs := bytcht_nocodec.o
 snd-soc-sof_rt5682-objs := sof_rt5682.o hda_dsp_common.o sof_maxim_common.o
 snd-soc-cml_rt1011_rt5682-objs := cml_rt1011_rt5682.o hda_dsp_common.o
+snd-soc-cml_rt1015_rt5682-objs := cml_rt1015_rt5682.o
 snd-soc-kbl_da7219_max98357a-objs := kbl_da7219_max98357a.o
 snd-soc-kbl_da7219_max98927-objs := kbl_da7219_max98927.o
 snd-soc-kbl_rt5663_max98927-objs := kbl_rt5663_max98927.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH) += snd-soc-sst-byt-cht-da7213.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH) += snd-soc-sst-byt-cht-es8316.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH) += snd-soc-sst-byt-cht-nocodec.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH) += snd-soc-cml_rt1011_rt5682.o
+obj-$(CONFIG_SND_SOC_INTEL_SOF_CML_RT1015_RT5682_MACH) += cml_rt1015_rt5682.o
 obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH) += snd-soc-kbl_da7219_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH) += snd-soc-kbl_da7219_max98927.o
 obj-$(CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH) += snd-soc-kbl_rt5663_max98927.o
diff --git a/sound/soc/intel/boards/cml_rt1015_rt5682.c b/sound/soc/intel/boards/cml_rt1015_rt5682.c
new file mode 100644
index 0000000..bf18830
--- /dev/null
+++ b/sound/soc/intel/boards/cml_rt1015_rt5682.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2019 Intel Corporation.
+
+/*
+ * Intel Cometlake I2S Machine driver for RT1015 + RT5682 codec
+ */
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <asm/cpu_device_id.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/rt5682.h>
+#include <sound/soc-acpi.h>
+#include "../../codecs/rt1015.h"
+#include "../../codecs/rt5682.h"
+#include "../../codecs/hdac_hdmi.h"
+
+/* The platform clock outputs 24Mhz clock to codec as I2S MCLK */
+#define CML_PLAT_CLK	24000000
+#define CML_RT1015_CODEC_DAI "rt1015-aif"
+#define CML_RT5682_CODEC_DAI "rt5682-aif1"
+#define NAME_SIZE 32
+
+#define SOF_RT1015_SPEAKER_WL		BIT(0)
+#define SOF_RT1015_SPEAKER_WR		BIT(1)
+#define SOF_RT1015_SPEAKER_TL		BIT(2)
+#define SOF_RT1015_SPEAKER_TR		BIT(3)
+#define SPK_CH 4
+
+/* Default: Woofer speakers  */
+static unsigned long sof_rt1015_quirk = SOF_RT1015_SPEAKER_WL |
+					SOF_RT1015_SPEAKER_WR;
+
+static int sof_rt1015_quirk_cb(const struct dmi_system_id *id)
+{
+	sof_rt1015_quirk = (unsigned long)id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id sof_rt1015_quirk_table[] = {
+	{
+		.callback = sof_rt1015_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Helios"),
+	},
+		.driver_data = (void *)(SOF_RT1015_SPEAKER_WL | SOF_RT1015_SPEAKER_WR |
+					SOF_RT1015_SPEAKER_TL | SOF_RT1015_SPEAKER_TR),
+	},
+	{
+	}
+};
+
+static struct snd_soc_jack hdmi_jack[3];
+
+struct hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct card_private {
+	char codec_name[SND_ACPI_I2C_ID_LEN];
+	struct snd_soc_jack headset;
+	struct list_head hdmi_pcm_list;
+};
+
+static const struct snd_kcontrol_new cml_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("WL Ext Spk"),
+	SOC_DAPM_PIN_SWITCH("WR Ext Spk"),
+};
+
+static const struct snd_kcontrol_new cml_rt1015_tt_controls[] = {
+	SOC_DAPM_PIN_SWITCH("TL Ext Spk"),
+	SOC_DAPM_PIN_SWITCH("TR Ext Spk"),
+};
+
+static const struct snd_soc_dapm_widget cml_rt1015_rt5682_widgets[] = {
+	SND_SOC_DAPM_SPK("WL Ext Spk", NULL),
+	SND_SOC_DAPM_SPK("WR Ext Spk", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+};
+
+static const struct snd_soc_dapm_widget cml_rt1015_tt_widgets[] = {
+	SND_SOC_DAPM_SPK("TL Ext Spk", NULL),
+	SND_SOC_DAPM_SPK("TR Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route cml_rt1015_rt5682_map[] = {
+	/*WL/WR speaker*/
+	{"WL Ext Spk", NULL, "WL SPO"},
+	{"WR Ext Spk", NULL, "WR SPO"},
+
+	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+
+	/* other jacks */
+	{ "IN1P", NULL, "Headset Mic" },
+
+	/* DMIC */
+	{ "DMic", NULL, "SoC DMIC" },
+};
+
+static const struct snd_soc_dapm_route cml_rt1015_tt_map[] = {
+	/*TL/TR speaker*/
+	{"TL Ext Spk", NULL, "TL SPO" },
+	{"TR Ext Spk", NULL, "TR SPO" },
+};
+
+static int cml_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = rtd->codec_dai->component;
+	struct snd_soc_jack *jack;
+	int ret;
+
+	/* need to enable ASRC function for 24MHz mclk rate */
+	rt5682_sel_asrc_clk_src(component, RT5682_DA_STEREO1_FILTER |
+				RT5682_AD_STEREO1_FILTER,
+				RT5682_CLK_SEL_I2S1_ASRC);
+
+	/*
+	 * Headset buttons map to the google Reference headset.
+	 * These can be configured by userspace.
+	 */
+	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+				    SND_JACK_BTN_3,
+				    &ctx->headset, NULL, 0);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	jack = &ctx->headset;
+
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	ret = snd_soc_component_set_jack(component, jack, NULL);
+	if (ret)
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+
+	return ret;
+};
+
+static int cml_rt1015_spk_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret = 0;
+	struct snd_soc_card *card = rtd->card;
+
+	if (sof_rt1015_quirk & (SOF_RT1015_SPEAKER_TL |
+				SOF_RT1015_SPEAKER_TR)) {
+
+		ret = snd_soc_add_card_controls(card, cml_rt1015_tt_controls,
+					ARRAY_SIZE(cml_rt1015_tt_controls));
+		if (ret)
+			return ret;
+
+		ret = snd_soc_dapm_new_controls(&card->dapm,
+					cml_rt1015_tt_widgets,
+					ARRAY_SIZE(cml_rt1015_tt_widgets));
+		if (ret)
+			return ret;
+
+		ret = snd_soc_dapm_add_routes(&card->dapm, cml_rt1015_tt_map,
+					ARRAY_SIZE(cml_rt1015_tt_map));
+
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int cml_rt5682_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int clk_id, clk_freq, pll_out, ret;
+
+	clk_id = RT5682_PLL1_S_MCLK;
+	clk_freq = CML_PLAT_CLK;
+
+	pll_out = params_rate(params) * 512;
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, clk_id, clk_freq, pll_out);
+	if (ret < 0)
+		dev_warn(rtd->dev, "snd_soc_dai_set_pll err = %d\n", ret);
+
+	/* Configure sysclk for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
+				     pll_out, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		dev_warn(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+
+	/*
+	 * slot_width should be equal or large than data length, set them
+	 * be the same
+	 */
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x0, 0x0, 2,
+				       params_width(params));
+	if (ret < 0)
+		dev_warn(rtd->dev, "set TDM slot err:%d\n", ret);
+	return ret;
+}
+
+static int cml_rt1015_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_card *card = rtd->card;
+	int srate, i, ret = 0;
+
+	srate = params_rate(params);
+
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
+		/* Set tdm/i2s1 master bclk ratio */
+		ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+		if (ret < 0) {
+			dev_err(card->dev, "failed to set bclk ratio\n");
+			return ret;
+		}
+		/* 64 Fs to drive 24 bit data */
+		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1015_PLL_S_BCLK,
+					  64 * srate, 256 * srate);
+		if (ret < 0) {
+			dev_err(card->dev, "codec_dai clock not set\n");
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+					     RT1015_SCLK_S_PLL,
+					     256 * srate, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "codec_dai clock not set\n");
+			return ret;
+		}
+
+	}
+	return 0;
+}
+
+static struct snd_soc_ops cml_rt5682_ops = {
+	.hw_params = cml_rt5682_hw_params,
+};
+
+static const struct snd_soc_ops cml_rt1015_ops = {
+	.hw_params = cml_rt1015_hw_params,
+};
+
+static int sof_card_late_probe(struct snd_soc_card *card)
+{
+	struct card_private *ctx = snd_soc_card_get_drvdata(card);
+	struct snd_soc_component *component = NULL;
+	char jack_name[NAME_SIZE];
+	struct hdmi_pcm *pcm;
+	int ret, i = 0;
+
+	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		component = pcm->codec_dai->component;
+		snprintf(jack_name, sizeof(jack_name),
+			 "HDMI/DP, pcm=%d Jack", pcm->device);
+		ret = snd_soc_card_jack_new(card, jack_name,
+					    SND_JACK_AVOUT, &hdmi_jack[i],
+					    NULL, 0);
+		if (ret)
+			return ret;
+
+		ret = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+					  &hdmi_jack[i]);
+		if (ret < 0)
+			return ret;
+
+		i++;
+	}
+	if (!component)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(component, &card->dapm);
+}
+
+static int hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct card_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = dai->id;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
+}
+
+/* Cometlake digital audio interface glue - connects codec <--> CPU */
+
+SND_SOC_DAILINK_DEF(ssp0_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("SSP0 Pin")));
+SND_SOC_DAILINK_DEF(ssp0_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00",
+				CML_RT5682_CODEC_DAI)));
+
+SND_SOC_DAILINK_DEF(ssp1_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("SSP1 Pin")));
+SND_SOC_DAILINK_DEF(ssp1_codec,
+	DAILINK_COMP_ARRAY(
+	/* WL */ COMP_CODEC("i2c-10EC1015:00", CML_RT1015_CODEC_DAI),
+	/* WR */ COMP_CODEC("i2c-10EC1015:01", CML_RT1015_CODEC_DAI)));
+
+SND_SOC_DAILINK_DEF(dmic_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
+
+SND_SOC_DAILINK_DEF(dmic16k_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("DMIC16k Pin")));
+
+SND_SOC_DAILINK_DEF(dmic_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
+
+SND_SOC_DAILINK_DEF(idisp1_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp1 Pin")));
+SND_SOC_DAILINK_DEF(idisp1_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi1")));
+
+SND_SOC_DAILINK_DEF(idisp2_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp2 Pin")));
+SND_SOC_DAILINK_DEF(idisp2_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi2")));
+
+SND_SOC_DAILINK_DEF(idisp3_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("iDisp3 Pin")));
+SND_SOC_DAILINK_DEF(idisp3_codec,
+	DAILINK_COMP_ARRAY(COMP_CODEC("ehdaudio0D2", "intel-hdmi-hifi3")));
+
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("0000:00:1f.3")));
+
+static struct snd_soc_dai_link cml_rt1015_rt5682_dailink[] = {
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "SSP0-Codec",
+		.id = 0,
+		.init = cml_rt5682_codec_init,
+		.ignore_pmdown_time = 1,
+		.ops = &cml_rt5682_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
+	},
+	{
+		.name = "dmic01",
+		.id = 1,
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(dmic_pin, dmic_codec, platform),
+	},
+	{
+		.name = "dmic16k",
+		.id = 2,
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(dmic16k_pin, dmic_codec, platform),
+	},
+	{
+		.name = "iDisp1",
+		.id = 3,
+		.init = hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp1_pin, idisp1_codec, platform),
+	},
+	{
+		.name = "iDisp2",
+		.id = 4,
+		.init = hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp2_pin, idisp2_codec, platform),
+	},
+	{
+		.name = "iDisp3",
+		.id = 5,
+		.init = hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(idisp3_pin, idisp3_codec, platform),
+	},
+	{
+		/*
+		 * SSP1 - Codec : added to end of list ensuring
+		 * reuse of common topologies for other end points
+		 * and changing only SSP1's codec
+		 */
+		.name = "SSP1-Codec",
+		.id = 6,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+		.init = cml_rt1015_spk_init,
+		.ops = &cml_rt1015_ops,
+		SND_SOC_DAILINK_REG(ssp1_pin, ssp1_codec, platform),
+	},
+};
+
+static struct snd_soc_codec_conf rt1015_conf[] = {
+	{
+		.dev_name = "i2c-10EC1015:00",
+		.name_prefix = "WL",
+	},
+	{
+		.dev_name = "i2c-10EC1015:01",
+		.name_prefix = "WR",
+	},
+};
+
+/* Cometlake audio machine driver for RT1015 and RT5682 */
+static struct snd_soc_card snd_soc_card_cml = {
+	.name = "cml_rt1015_rt5682",
+	.dai_link = cml_rt1015_rt5682_dailink,
+	.num_links = ARRAY_SIZE(cml_rt1015_rt5682_dailink),
+	.codec_conf = rt1015_conf,
+	.num_configs = ARRAY_SIZE(rt1015_conf),
+	.dapm_widgets = cml_rt1015_rt5682_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cml_rt1015_rt5682_widgets),
+	.dapm_routes = cml_rt1015_rt5682_map,
+	.num_dapm_routes = ARRAY_SIZE(cml_rt1015_rt5682_map),
+	.controls = cml_controls,
+	.num_controls = ARRAY_SIZE(cml_controls),
+	.fully_routed = true,
+	.late_probe = sof_card_late_probe,
+};
+
+static int snd_cml_rt1015_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_link_component *rt1015_dais_components;
+	struct snd_soc_codec_conf *rt1015_dais_confs;
+	struct card_private *ctx;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
+	int ret, i;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+	mach = (&pdev->dev)->platform_data;
+	snd_soc_card_cml.dev = &pdev->dev;
+	platform_name = mach->mach_params.platform;
+
+	dmi_check_system(sof_rt1015_quirk_table);
+
+	dev_info(&pdev->dev, "sof_rt1015_quirk = %lx\n", sof_rt1015_quirk);
+
+	if (sof_rt1015_quirk & (SOF_RT1015_SPEAKER_TL |
+				SOF_RT1015_SPEAKER_TR)) {
+		rt1015_dais_confs = devm_kzalloc(&pdev->dev,
+					sizeof(struct snd_soc_codec_conf) *
+					SPK_CH, GFP_KERNEL);
+
+		if (!rt1015_dais_confs)
+			return -ENOMEM;
+
+		rt1015_dais_components = devm_kzalloc(&pdev->dev,
+					sizeof(struct snd_soc_dai_link_component) *
+					SPK_CH, GFP_KERNEL);
+
+		if (!rt1015_dais_components)
+			return -ENOMEM;
+
+		for (i = 0; i < SPK_CH; i++) {
+			rt1015_dais_confs[i].dev_name = devm_kasprintf(&pdev->dev,
+								GFP_KERNEL,
+								"i2c-10EC1015:0%d",
+								i);
+
+			if (!rt1015_dais_confs[i].dev_name)
+				return -ENOMEM;
+
+			switch (i) {
+			case 0:
+				rt1015_dais_confs[i].name_prefix = "WL";
+				break;
+			case 1:
+				rt1015_dais_confs[i].name_prefix = "WR";
+				break;
+			case 2:
+				rt1015_dais_confs[i].name_prefix = "TL";
+				break;
+			case 3:
+				rt1015_dais_confs[i].name_prefix = "TR";
+				break;
+			default:
+				return -EINVAL;
+			}
+			rt1015_dais_components[i].name = devm_kasprintf(&pdev->dev,
+								GFP_KERNEL,
+								"i2c-10EC1015:0%d",
+								i);
+			if (!rt1015_dais_components[i].name)
+				return -ENOMEM;
+
+			rt1015_dais_components[i].dai_name = CML_RT1015_CODEC_DAI;
+		}
+
+		snd_soc_card_cml.codec_conf = rt1015_dais_confs;
+		snd_soc_card_cml.num_configs = SPK_CH;
+
+		for (i = 0; i < ARRAY_SIZE(cml_rt1015_rt5682_dailink); i++) {
+			if (!strcmp(cml_rt1015_rt5682_dailink[i].codecs->dai_name,
+					CML_RT1015_CODEC_DAI)) {
+				cml_rt1015_rt5682_dailink[i].codecs = rt1015_dais_components;
+				cml_rt1015_rt5682_dailink[i].num_codecs = SPK_CH;
+			}
+		}
+	}
+
+	/* set platform name for each dailink */
+	ret = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cml,
+						    platform_name);
+	if (ret)
+		return ret;
+	snd_soc_card_set_drvdata(&snd_soc_card_cml, ctx);
+
+	return devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cml);
+}
+
+static struct platform_driver snd_cml_rt1015_rt5682_driver = {
+	.probe = snd_cml_rt1015_probe,
+	.driver = {
+		.name = "cml_rt1015_rt5682",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(snd_cml_rt1015_rt5682_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("Cometlake Audio Machine driver - RT1015 and RT5682 in I2S mode");
+MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
+MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
+MODULE_AUTHOR("Shuming Fan <shumingf@realtek.com>");
+MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cml_rt1015_rt5682");
diff --git a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
index b80f032a..4f99da8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cnl-match.c
@@ -23,6 +23,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_machines[] = {
 		.sof_fw_filename = "sof-cnl.ri",
 		.sof_tplg_filename = "sof-cnl-rt274.tplg",
 	},
+	{
+		.id = "10EC1015",
+		.drv_name = "cml_rt1015_rt5682",
+		.quirk_data = &cml_codecs,
+		.sof_fw_filename = "sof-cnl.ri",
+		.sof_tplg_filename = "sof-cml-rt1015-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_cnl_machines);
-- 
2.7.4

