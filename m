Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE82FF545
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbhAUT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbhAUTzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:55:16 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5EDC061793;
        Thu, 21 Jan 2021 11:52:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B2E023EEED;
        Thu, 21 Jan 2021 20:52:54 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     viresh.kumar@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v5 6/7] cpufreq: qcom-hw: Allow getting the maximum transition latency for OPPs
Date:   Thu, 21 Jan 2021 20:52:49 +0100
Message-Id: <20210121195250.492500-7-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
References: <20210121195250.492500-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fine-tune the frequency scaling from various governors,
allow to set a maximum transition latency from OPPs, which may be
different depending on the SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9a213a3046bb..d2b913582197 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -1405,6 +1405,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	const char *fdom_resname;
+	unsigned int transition_latency;
 	int cpu_count, index, ret;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -1482,6 +1483,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = transition_latency;
+
 	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	return 0;
-- 
2.30.0

