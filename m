Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFCF254258
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgH0J32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 05:29:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55342 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgH0J31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:29:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598520565; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Y9g7BsuczJaS0Zrqh58274WFmacIsTipk2BNleAp2MQ=; b=DyeMS8Yie1JLTW5QcWHJ9rLUXgOWq7tvN6oERaNyfUJt64HpX/wJ+T+Sv820E01NdfbPqvsJ
 DWeBflYeOBFdw5mhwHaazNvk0r+OEmJADt84E8dQfolUmSDIzGSEQlYabDICAfWQIiNWm7bL
 2bonFnOKj6D2MQage3zPbE+T1BI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f477cd51d69e438cb0d2567 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 09:28:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA56DC43452; Thu, 27 Aug 2020 09:28:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F022BC433B1;
        Thu, 27 Aug 2020 09:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F022BC433B1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao <srivasam@codeaurora.org>
Subject: [PATCH v2 4/5] ASoC: qcom: Add support for audio over DP
Date:   Thu, 27 Aug 2020 14:58:14 +0530
Message-Id: <1598520495-21741-4-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598520495-21741-1-git-send-email-srivasam@codeaurora.org>
References: <1598520495-21741-1-git-send-email-srivasam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Add support for audio playback over DP in lpass sc7180 platform driver.
Add lpass_variant structure for hdmi data configuaration.

Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
---
 sound/soc/qcom/lpass-sc7180.c | 121 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 167bf2c..cea7ae7 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -62,6 +62,24 @@ static struct snd_soc_dai_driver sc7180_lpass_cpu_dai_driver[] = {
 	},
 };
 
+static struct snd_soc_dai_driver sc7180_lpass_cpu_hdmi_dai_driver[] = {
+	[0] = {
+		.id = HDMI,
+		.name = "Hdmi",
+		.playback = {
+			.stream_name = "Hdmi Playback",
+			.formats	= SNDRV_PCM_FMTBIT_S24_3LE |
+							SNDRV_PCM_FMTBIT_S24_LE,
+			.rates = SNDRV_PCM_RATE_48000,
+			.rate_min	= 48000,
+			.rate_max	= 48000,
+			.channels_min	= 2,
+			.channels_max	= 2,
+		},
+		.ops    = &asoc_qcom_lpass_hdmi_dai_ops,
+	},
+};
+
 static int sc7180_lpass_alloc_dma_channel(struct lpass_data *drvdata,
 					   int direction)
 {
@@ -88,13 +106,37 @@ static int sc7180_lpass_alloc_dma_channel(struct lpass_data *drvdata,
 
 	return chan;
 }
+static int sc7180_lpass_alloc_hdmi_dma_channel(struct lpass_data *drvdata,
+					   int direction)
+{
+	struct lpass_variant *v = drvdata->variant;
+	int chan = 0;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
+					v->rdma_channels);
+
+		if (chan >= v->rdma_channels)
+			return -EBUSY;
+	}
+	set_bit(chan, &drvdata->dma_ch_bit_map);
+
+	return chan;
 
+}
 static int sc7180_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 {
 	clear_bit(chan, &drvdata->dma_ch_bit_map);
 
 	return 0;
 }
+static int sc7180_lpass_free_hdmi_dma_channel(struct lpass_data *drvdata, int chan)
+{
+	clear_bit(chan, &drvdata->dma_ch_bit_map);
+
+	return 0;
+}
+
 
 static int sc7180_lpass_init(struct platform_device *pdev)
 {
@@ -190,15 +232,92 @@ static struct lpass_variant sc7180_data = {
 				   "mi2s-bit-clk0",
 				   "mi2s-bit-clk1",
 				},
+	.id				= I2S_INTERFACE,
 	.init			= sc7180_lpass_init,
 	.exit			= sc7180_lpass_exit,
 	.alloc_dma_channel	= sc7180_lpass_alloc_dma_channel,
 	.free_dma_channel	= sc7180_lpass_free_dma_channel,
 };
 
+static struct lpass_variant sc7180_hdmi_data = {
+	.hdmi_tx_ctl_addr	= 0x1000,
+	.hdmi_legacy_addr	= 0x1008,
+	.hdmi_vbit_addr		= 0x610c0,
+	.hdmi_ch_lsb_addr	= 0x61048,
+	.hdmi_ch_msb_addr	= 0x6104c,
+	.ch_stride		= 0x8,
+	.hdmi_parity_addr	= 0x61034,
+	.hdmi_dmactl_addr	= 0x61038,
+	.hdmi_dma_stride	= 0x4,
+	.hdmi_DP_addr		= 0x610c8,
+	.hdmi_sstream_addr	= 0x6101c,
+	.irq_reg_base		= 0x63000,
+	.irq_ports		= 1,
+	.rdma_reg_base		= 0x64000,
+	.rdma_reg_stride	= 0x1000,
+	.rdma_channels		= 4,
+
+	.rdma_dyncclk		= REG_FIELD_ID(0x64000, 14, 14, 4, 0x1000),
+	.rdma_bursten		= REG_FIELD_ID(0x64000, 13, 13, 4, 0x1000),
+	.rdma_burst8		= REG_FIELD_ID(0x64000, 15, 15, 4, 0x1000),
+	.rdma_burst16		= REG_FIELD_ID(0x64000, 16, 16, 4, 0x1000),
+	.rdma_dynburst		= REG_FIELD_ID(0x64000, 18, 18, 4, 0x1000),
+	.rdma_wpscnt		= REG_FIELD_ID(0x64000, 10, 12, 4, 0x1000),
+	.rdma_fifowm		= REG_FIELD_ID(0x64000, 1, 5, 4, 0x1000),
+	.rdma_enable		= REG_FIELD_ID(0x64000, 0, 0, 4, 0x1000),
+
+	.sstream_en		= REG_FIELD(0x6101c, 0, 0),
+	.dma_sel			= REG_FIELD(0x6101c, 1, 2),
+	.auto_bbit_en	= REG_FIELD(0x6101c, 3, 3),
+	.layout			= REG_FIELD(0x6101c, 4, 4),
+	.layout_sp		= REG_FIELD(0x6101c, 5, 8),
+	.set_sp_on_en	= REG_FIELD(0x6101c, 10, 10),
+	.dp_audio		= REG_FIELD(0x6101c, 11, 11),
+	.dp_staffing_en	= REG_FIELD(0x6101c, 12, 12),
+	.dp_sp_b_hw_en	= REG_FIELD(0x6101c, 13, 13),
+
+	.mute			= REG_FIELD(0x610c8, 0, 0),
+	.as_sdp_cc		= REG_FIELD(0x610c8, 1, 3),
+	.as_sdp_ct		= REG_FIELD(0x610c8, 4, 7),
+	.aif_db4			= REG_FIELD(0x610c8, 8, 15),
+	.frequency		= REG_FIELD(0x610c8, 16, 21),
+	.mst_index		= REG_FIELD(0x610c8, 28, 29),
+	.dptx_index		= REG_FIELD(0x610c8, 30, 31),
+
+	.soft_reset		= REG_FIELD(0x1000, 31, 31),
+	.force_reset	= REG_FIELD(0x1000, 30, 30),
+
+	.use_hw_chs		= REG_FIELD(0x61038, 0, 0),
+	.use_hw_usr		= REG_FIELD(0x61038, 1, 1),
+	.hw_chs_sel		= REG_FIELD(0x61038, 2, 4),
+	.hw_usr_sel		= REG_FIELD(0x61038, 5, 6),
+
+	.replace_vbit	= REG_FIELD(0x610c0, 0, 0),
+	.vbit_stream	= REG_FIELD(0x610c0, 1, 1),
+
+	.legacy_en		=  REG_FIELD(0x1008, 0, 0),
+	.calc_en		=  REG_FIELD(0x61034, 0, 0),
+	.lsb_bits		=  REG_FIELD(0x61048, 0, 31),
+	.msb_bits		=  REG_FIELD(0x6104c, 0, 31),
+
+	.clk_name		= (const char*[]) {
+					"pcnoc-sway-clk",
+					"audio-core",
+					"pcnoc-mport-clk",
+				},
+	.num_clks		= 3,
+	.id			= HDMI_INTERFACE,
+	.dai_driver		= sc7180_lpass_cpu_hdmi_dai_driver,
+	.num_dai		= ARRAY_SIZE(sc7180_lpass_cpu_hdmi_dai_driver),
+	.init			= sc7180_lpass_init,
+	.exit			= sc7180_lpass_exit,
+	.alloc_dma_channel = sc7180_lpass_alloc_hdmi_dma_channel,
+	.free_dma_channel = sc7180_lpass_free_hdmi_dma_channel,
+
+};
 static const struct of_device_id sc7180_lpass_cpu_device_id[] = {
 	{.compatible = "qcom,sc7180-lpass-cpu", .data = &sc7180_data},
-	{}
+	{.compatible = "qcom,sc7180-lpass-hdmi", .data = &sc7180_hdmi_data}
 };
 
 static struct platform_driver sc7180_lpass_cpu_platform_driver = {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

