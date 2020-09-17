Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BC26DB00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIQME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIQMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:01:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB6C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so1695381wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iwZGdduEoUVJL5Tf4KLAciY4bqMm860VrWpXCu2r4E=;
        b=xU4zN8P2F59pjs8RdbPNT/TcnB/35/piQlYZdTiG6d5UXWOB6LJrK1o60HLM3rsubB
         dJSfeQ90VeL8eOtPtavUKV9JQosYYviWXECjdiw8YBo6Aa4dEf5NiHKlU77o3wXigc37
         ZRylCbGeW1XnY8LQTvwzEPDuzqXX0UnLDfpyaVDmpkGaGx6Rudy565cmnfADUqzfTZ3x
         q7WZcrfDkLdp+4q+PTji/hZt6yoOV9nZ49HQbtC+bULb1ggm6fmU4aOFnWDEE8oeN1Fl
         jW57eCH1bMVZp2nE9t1xOC5RoHwppfVCEWE9fV9I+t+CCOP+CGuAKctc5j7z5C3V+KD/
         pazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iwZGdduEoUVJL5Tf4KLAciY4bqMm860VrWpXCu2r4E=;
        b=Wj+Go9f0gUcQ6vrXgHqTgG5MLZx7VKsBDj4derUfCChLZLyGSHPKQkupLn2RMo2qES
         vA72Mb1N4IyoLAA8S+8crgOjkuujWvVQ0SKresSj/Q1jZzp59CtHX4wn0IHjrCrNV7ee
         7s2YHTxMZu+hCEQujqvb8IxpiQRYo+lZkpwrYbJ9ajkkXrUKuGp0spyFgiK0+Ao3PzS/
         dgRx1G1ur9pod16FOQnII1Wj91SUj+kM1gR01MtpQZ4IMXd6STK8WlYrSYIajqA6CGFv
         7vix2sYqoVJTRCjIKsZVAZLS9JXSWNfAXd3szCllEOMoMVwhduvW5kizRb789LpyxKcX
         7xuQ==
X-Gm-Message-State: AOAM530+g72xZFCggxpbSHA2wGmN3ohY8M43ZiK3NzbUGIvNDAcIqc48
        zc2kaFzaVjLITkmCKRhMM7FWkC2m4WfENQ==
X-Google-Smtp-Source: ABdhPJwivrNzb2ahqNl+ZF501A7mvEyC4J2zzwhMk+aWQOQC17ZYMcyDCYoVrKns+4aOnIu5NfLo0g==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr10077373wmb.5.1600344104861;
        Thu, 17 Sep 2020 05:01:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q18sm37584860wre.78.2020.09.17.05.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 05:01:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 2/3] soundwire: qcom: add support to block packing mode
Date:   Thu, 17 Sep 2020 13:01:37 +0100
Message-Id: <20200917120138.11313-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
References: <20200917120138.11313-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to block pack mode, which is required
on Qcom soundwire controllers v1.5.x on few ports!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index c1bb35884182..16023b5bcbd5 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -54,6 +54,7 @@
 #define SWRM_MCP_SLV_STATUS					0x1090
 #define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
 #define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
+#define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
 #define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
@@ -82,6 +83,7 @@ struct qcom_swrm_port_config {
 	u8 si;
 	u8 off1;
 	u8 off2;
+	u8 bp_mode;
 };
 
 struct qcom_swrm_ctrl {
@@ -392,14 +394,22 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
 {
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
 	u32 value;
+	int reg = SWRM_DP_PORT_CTRL_BANK((params->port_num), bank);
+	int ret;
 
 	value = params->offset1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
 	value |= params->offset2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
 	value |= params->sample_interval - 1;
 
-	return ctrl->reg_write(ctrl,
-			       SWRM_DP_PORT_CTRL_BANK((params->port_num), bank),
-			       value);
+	ret = ctrl->reg_write(ctrl, reg, value);
+
+	if (!ret && params->blk_pkg_mode) {
+		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
+
+		ret = ctrl->reg_write(ctrl, reg, 1);
+	}
+
+	return ret;
 }
 
 static int qcom_swrm_port_enable(struct sdw_bus *bus,
@@ -447,6 +457,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 			p_rt->transport_params.sample_interval = pcfg->si + 1;
 			p_rt->transport_params.offset1 = pcfg->off1;
 			p_rt->transport_params.offset2 = pcfg->off2;
+			p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 		}
 
 		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
@@ -457,6 +468,7 @@ static int qcom_swrm_compute_params(struct sdw_bus *bus)
 					pcfg->si + 1;
 				p_rt->transport_params.offset1 = pcfg->off1;
 				p_rt->transport_params.offset2 = pcfg->off2;
+				p_rt->transport_params.blk_pkg_mode = pcfg->bp_mode;
 				i++;
 			}
 		}
@@ -703,6 +715,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	u8 off1[QCOM_SDW_MAX_PORTS];
 	u8 off2[QCOM_SDW_MAX_PORTS];
 	u8 si[QCOM_SDW_MAX_PORTS];
+	u8 bp_mode[QCOM_SDW_MAX_PORTS] = { 0, };
 	int i, ret, nports, val;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
@@ -745,10 +758,13 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	if (ret)
 		return ret;
 
+	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
+					bp_mode, nports);
 	for (i = 0; i < nports; i++) {
 		ctrl->pconfig[i].si = si[i];
 		ctrl->pconfig[i].off1 = off1[i];
 		ctrl->pconfig[i].off2 = off2[i];
+		ctrl->pconfig[i].bp_mode = bp_mode[i];
 	}
 
 	return 0;
-- 
2.21.0

