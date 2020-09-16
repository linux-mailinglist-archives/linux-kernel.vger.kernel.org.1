Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06B26C97B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIPTKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgIPRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:43:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A2DC02C2AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so7432677wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvLpIi+7meUnlK1+vtXiFiibYQd8qHIihBysDb2CEOI=;
        b=phjXwZxjSF985V8NctZC3S01geF6oSlbFp0KQIK9XIro3P4aafdYhA3MPyE4uSYwqU
         5W9QliowsOkOTeluqflrXFlaEf2yuBnG/uZT93TCMxR++ILSGZWngGUV93rALz24Klrq
         A+AZOLUXCLYQcsiGSGV0+AiYab8QhUCw2C0GL3sRUBuCcUGvvnIvo7fk7kkSGDSIHGaB
         qyqn9g+iFA2z+g9oVoiuD1Qjh2fEH3WcK/FJuU2swGmRg4ZKsgl5bnan1/r829mx5uKc
         IkCmcVf5vZnpoeJgk1/kVxjTkFFRMPuruDA5YaynKiwtlADUfd0aFJJhohvOoNdqAs3X
         g+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvLpIi+7meUnlK1+vtXiFiibYQd8qHIihBysDb2CEOI=;
        b=e8IbCFx7um8C9h5/u6FQLdfFen5MW0uLN6GFZKDpM+AiBZSBnCT4cj/4Bhg8s7mCUF
         WMdlcrJe5GXZ1nUWTbcjnYp3J1yn1gNzwV6apkqCPVJqm8Vp9gg1hHHVCIQZjRpwp1IP
         +aEyxjDpakk9+N4N5ZTz+bMmoEr5dttDz4Q72ZG/eKgGoeB5l1wqG+7HGxa+oDdjHl9B
         Aw6+0ItxQ6R5kSBUjoXT1eG1rctHhzGfAarbjcBOIXrXMtsLtWnNUGx+QqXzrXuYoOIc
         OOcK6jmEk+SwfX5adYO/ztuIxzQGY3fFWLB9XCDMrkBKSbhmDKY/Z5z4lLHGWkewsBsb
         Lqiw==
X-Gm-Message-State: AOAM5331GKw4U2gsOZDfgVEoEdhh470udDq/X2yFayDLeOLXPWxX2XzL
        dLzEUDC2ay2zk4/lyY1yT3nWS7JAq96SvA==
X-Google-Smtp-Source: ABdhPJy1a7uy0r37DEzgvgQ+aghbxG7NQxGXDCoJlcb4on0bvc5n0bt1eMftRJ6VHaFlhZWUtLLPpQ==
X-Received: by 2002:adf:f585:: with SMTP id f5mr28618511wro.64.1600270870245;
        Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:41:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/3] soundwire: qcom: add support to block packing mode
Date:   Wed, 16 Sep 2020 16:41:00 +0100
Message-Id: <20200916154101.2254-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
References: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
index 0036d3248fb4..5a61d82310fd 100644
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

