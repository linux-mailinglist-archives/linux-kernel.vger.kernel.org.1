Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94932F0279
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhAISEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 13:04:51 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:45457 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbhAISEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 13:04:50 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0FFDD1F5C4;
        Sat,  9 Jan 2021 19:04:08 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nks@flawful.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v2 03/15] soc: qcom: spm: Add compatible for MSM8998 SAWv4.1 L2
Date:   Sat,  9 Jan 2021 19:03:47 +0100
Message-Id: <20210109180359.236098-4-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180359.236098-1-angelogioacchino.delregno@somainline.org>
References: <20210109180359.236098-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SAWv4.1 parameters for MSM8998's Gold and Silver clusters.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/soc/qcom/spm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 843732d12c54..2e6312663293 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -54,6 +54,18 @@ static const struct spm_reg_data spm_reg_660_silver_l2  = {
 	.avs_limit = 0x4580458,
 };
 
+static const struct spm_reg_data spm_reg_8998_gold_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x1010031,
+	.avs_limit = 0x4700470,
+};
+
+static const struct spm_reg_data spm_reg_8998_silver_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x1010031,
+	.avs_limit = 0x4200420,
+};
+
 static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
@@ -149,6 +161,10 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_660_gold_l2 },
 	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
 	  .data = &spm_reg_660_silver_l2 },
+	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
+	  .data = &spm_reg_8998_gold_l2 },
+	{ .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
+	  .data = &spm_reg_8998_silver_l2 },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
-- 
2.29.2

