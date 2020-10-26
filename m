Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E840129936A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787351AbgJZRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:09:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43559 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787104AbgJZRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:09:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id g12so13519627wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRUE6uAh5erOgzhAmZUD/lWQAfes5L6DiZUe9zh/gxQ=;
        b=nn6ZgeQnM2dzxDtWcEo3cD3muN1MPnW7xxAgw0MdQaQ5/cCvc3a8nfijUqX+YnUr1l
         /Sz+rYIfZGwBIZQxd7nhyZPVCLTILbnWEqEL1b+0bqSZ6/e0rtjFkHQMBLocDOKYnjnT
         vBEgTJm8EqdqQ4RPWtC3u97p6DvQRlnLZ1D+OukGLkRW4gkXMvjKi2Jbn66grN4gbnqa
         W46jAEoGTC+yGHNp9/MXhO8UywTEu1bW2Hnx97gTjopDW/KPnOAyZPwYCQw8gHbpdtCm
         l1rONw/he+Ms+9HAu1HwS/oanKRJtBYFcAqGhRlyoEb5jmfDb9AdhRPw0EXU9AKpztef
         LgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRUE6uAh5erOgzhAmZUD/lWQAfes5L6DiZUe9zh/gxQ=;
        b=Xm2rI8WC383A9UBy2C7eo6z4GdfECQd7cdCzkaBOBxwCTmufQKIpQPlfSYRTdrq2F4
         jetu+XC8qagc/5dNeyfIZSS45FEQKzcg4J3aQnXQ2zmII0Rpc1cuJnzJyF+aWfbwCje7
         pfcNNT34nqZ9Oi9QOQi1z6iAxwZKHue3s0ImfefPSfj1ssk0E092lpZS+wgupUqLRvFv
         Z9UgdBrFsf9durmqM4X82G7wW0l6xpC19fD184WqDceohUwDnapjzjXS/K9TpFZ0gIP+
         Lm4wDXgW62DzOn/xGx4Qk8Mq+1y+Tiz0Byipqr2o8C0B4RJBqvGnWDLTAPI2OFgsuC0O
         kuHA==
X-Gm-Message-State: AOAM531yeXhyT3CP3zXN36B+jt3prYBt7ovdco2QVH50lsClDoshF86k
        XuBX7lQIAbMd2fXKM2uaGtFpeA==
X-Google-Smtp-Source: ABdhPJxkVIFyw1Jgvnui9n/a9KCedJXKM1Ndg/etoojRDrAAR/EDPJ2ts0Rn9ou4VJwfXWvll+WVzQ==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr19135023wru.356.1603732194103;
        Mon, 26 Oct 2020 10:09:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u133sm23136174wmb.6.2020.10.26.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:09:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 2/2] ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
Date:   Mon, 26 Oct 2020 17:09:47 +0000
Message-Id: <20201026170947.10567-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Qualcomm Robotics RB5 Development Kit based on
QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers
with onboard DMIC connected to internal LPASS codec via WSA
and VA macros respectively.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig  |  11 ++
 sound/soc/qcom/Makefile |   2 +
 sound/soc/qcom/sm8250.c | 228 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 sound/soc/qcom/sm8250.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 2696ffcba880..484cad31da25 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -127,4 +127,15 @@ config SND_SOC_SDM845
 	  SDM845 SoC-based systems.
 	  Say Y if you want to use audio device on this SoCs.
 
+config SND_SOC_SM8250
+	tristate "SoC Machine driver for SM8250 boards"
+	depends on QCOM_APR && SOUNDWIRE
+	depends on COMMON_CLK
+	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
+	help
+	  To add support for audio on Qualcomm Technologies Inc.
+	  SM8250 SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs.
+
 endif #SND_SOC_QCOM
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index 0bd90d74e3db..effa4b3f58fa 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -19,12 +19,14 @@ snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 snd-soc-apq8096-objs := apq8096.o
 snd-soc-sdm845-objs := sdm845.o
+snd-soc-sm8250-objs := sm8250.o
 snd-soc-qcom-common-objs := common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
+obj-$(CONFIG_SND_SOC_SM8250) += snd-soc-sm8250.o
 obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
 
 #DSP lib
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
new file mode 100644
index 000000000000..7d43de6d909f
--- /dev/null
+++ b/sound/soc/qcom/sm8250.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <linux/soundwire/sdw.h>
+#include "qdsp6/q6afe.h"
+#include "common.h"
+
+#define DRIVER_NAME		"sm8250"
+#define MI2S_BCLK_RATE		1536000
+#define MAX_SDW_STREAMS		16
+
+struct sm8250_snd_data {
+	bool stream_prepared[MAX_SDW_STREAMS];
+	struct snd_soc_card *card;
+	struct sdw_stream_runtime *sruntime[MAX_SDW_STREAMS];
+};
+
+static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
+static int sm8250_snd_startup(struct snd_pcm_substream *substream)
+{
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case TERTIARY_MI2S_RX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
+		snd_soc_dai_set_sysclk(cpu_dai,
+			Q6AFE_LPASS_CLK_ID_TER_MI2S_IBIT,
+			MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int sm8250_snd_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sm8250_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
+	struct sdw_stream_runtime *sruntime;
+	int i;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+		for_each_rtd_codec_dais(rtd, i, codec_dai) {
+			sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
+						      substream->stream);
+			if (sruntime != ERR_PTR(-ENOTSUPP))
+				pdata->sruntime[cpu_dai->id] = sruntime;
+		}
+		break;
+	}
+
+	return 0;
+
+}
+
+static int sm8250_snd_wsa_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	int ret;
+
+	if (!sruntime)
+		return 0;
+
+	if (data->stream_prepared[cpu_dai->id]) {
+		sdw_disable_stream(sruntime);
+		sdw_deprepare_stream(sruntime);
+		data->stream_prepared[cpu_dai->id] = false;
+	}
+
+	ret = sdw_prepare_stream(sruntime);
+	if (ret)
+		return ret;
+
+	/**
+	 * NOTE: there is a strict hw requirement about the ordering of port
+	 * enables and actual WSA881x PA enable. PA enable should only happen
+	 * after soundwire ports are enabled if not DC on the line is
+	 * accumulated resulting in Click/Pop Noise
+	 * PA enable/mute are handled as part of codec DAPM and digital mute.
+	 */
+
+	ret = sdw_enable_stream(sruntime);
+	if (ret) {
+		sdw_deprepare_stream(sruntime);
+		return ret;
+	}
+	data->stream_prepared[cpu_dai->id]  = true;
+
+	return ret;
+}
+
+static int sm8250_snd_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		return sm8250_snd_wsa_dma_prepare(substream);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		if (sruntime && data->stream_prepared[cpu_dai->id]) {
+			sdw_disable_stream(sruntime);
+			sdw_deprepare_stream(sruntime);
+			data->stream_prepared[cpu_dai->id] = false;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops sm8250_be_ops = {
+	.startup = sm8250_snd_startup,
+	.hw_params = sm8250_snd_hw_params,
+	.hw_free = sm8250_snd_hw_free,
+	.prepare = sm8250_snd_prepare,
+};
+
+static void sm8250_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link;
+	int i;
+
+	for_each_card_prelinks(card, i, link) {
+		if (link->no_pcm == 1) {
+			link->be_hw_params_fixup = sm8250_be_hw_params_fixup;
+			link->ops = &sm8250_be_ops;
+		}
+	}
+}
+
+static int sm8250_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct sm8250_snd_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	/* Allocate the private data */
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	card->dev = dev;
+	dev_set_drvdata(dev, card);
+	snd_soc_card_set_drvdata(card, data);
+	ret = qcom_snd_parse_of(card);
+	if (ret)
+		return ret;
+
+	card->driver_name = DRIVER_NAME;
+	sm8250_add_be_ops(card);
+	return devm_snd_soc_register_card(dev, card);
+}
+
+static const struct of_device_id snd_sm8250_dt_match[] = {
+	{.compatible = "qcom,sdm8250"},
+	{.compatible = "qcom,qrb5165-rb5"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, snd_sm8250_dt_match);
+
+static struct platform_driver snd_sm8250_driver = {
+	.probe  = sm8250_platform_probe,
+	.driver = {
+		.name = "snd-sm8250",
+		.of_match_table = snd_sm8250_dt_match,
+	},
+};
+module_platform_driver(snd_sm8250_driver);
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("SM8250 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

