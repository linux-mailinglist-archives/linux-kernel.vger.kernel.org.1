Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A326C060
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIPJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIPJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:21:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CEEC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so6132396wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1hJdOGE6PE2L8q7V2RDIPCnW82wr0NYOq44Om20nBE=;
        b=oYq1xUozS+JbK0qBnLdccJM1mRa1RUrIL39b7g/t6b5fmdsgyr5zv1tSgLU0WdWGAt
         i3EIFY1bmiIqz2ojzJP0tNQzubaP7aBdjLW22D6AJmSgCINKTY9wEQwBoWEBs8KbS84R
         JymAxC1t/d2f10P/1OqOE6AgtxGztV+0TfNRR2DqdeE73wvH/atPirum8UIcApRIF3GW
         t0rHPl1VvLVwQXqEEIueiJJm2xYcGk0JuOK/cfNrZ6hpNMbOJP+nzW0kwNh+/lG40RLF
         zedpxDz5aE3LARYSf4HIY97mqRbvFyH4SUJHGHlYvBmi3E1UVIW8xt6NqN8ojmw3a7Es
         UOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1hJdOGE6PE2L8q7V2RDIPCnW82wr0NYOq44Om20nBE=;
        b=VSc0CnwCCdZHCJJnPbWFKM1PaK9HFjyjZAY9khyYdpRJY83b+v8LxuHDotRDK0964S
         f8mg7Q4NQ2vcjezIqIHS+9D2lvvL+Q9VSVx0KXf/Qc2IlZQIdki8aMd7UYHP7ksbDJpn
         uX5IaXnWrus5n+UsaXbm4myjd8SIyFKSKVPVAPLjm30FLedeBlGtxkBVRNqh/PiPzJ2W
         SEHcYoJFCKDVA3hM2sy8JnsnDb6kpGumk+y36+CuNyKQV5qEAp7gjTPnLvvx7ayHD3O2
         AtRmXK8sOzXNfbli0aZnSt2VbI0LjZt+gbZgGz9dXSlOOxXZAvVs+b1UA0w1Ts0NFIcK
         q2eg==
X-Gm-Message-State: AOAM53210auz47YOrIfs14zKHTeDYEdaX6DjEMVPqBSqjUV0jG2/p9mD
        ODlpWHAuB3+bZFU/guO35eZk+g==
X-Google-Smtp-Source: ABdhPJzzyXLTM6CWuygfNPgQ7ZQZbT8zI3ltZq4+MuAltfjBqs5ZwlWdYNcr9AZzD8MfEcQ5VdJWcQ==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr26232864wro.121.1600248113780;
        Wed, 16 Sep 2020 02:21:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id f6sm32181670wro.5.2020.09.16.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:21:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/3] soundwire: qcom: get max rows and cols info from compatible
Date:   Wed, 16 Sep 2020 10:21:25 +0100
Message-Id: <20200916092125.30898-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently the max rows and cols values are hardcoded. In reality
these values depend on the IP version. So get these based on
device tree compatible strings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 50 ++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 76963a7bdaa3..1dbf33684470 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -66,11 +66,6 @@
 #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
 			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
 
-#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
-#define SWRM_DEFAULT_ROWS	48
-#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
-#define SWRM_DEFAULT_COL	16
-#define SWRM_MAX_COL_VAL	7
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
 #define TIMEOUT_MS		(2 * HZ)
@@ -104,6 +99,8 @@ struct qcom_swrm_ctrl {
 	unsigned int version;
 	int num_din_ports;
 	int num_dout_ports;
+	int cols_index;
+	int rows_index;
 	unsigned long dout_port_mask;
 	unsigned long din_port_mask;
 	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
@@ -113,6 +110,21 @@ struct qcom_swrm_ctrl {
 	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
 };
 
+struct qcom_swrm_data {
+	u32 default_cols;
+	u32 default_rows;
+};
+
+static struct qcom_swrm_data swrm_v1_3_data = {
+	.default_rows = 48,
+	.default_cols = 16,
+};
+
+static struct qcom_swrm_data swrm_v1_5_data = {
+	.default_rows = 50,
+	.default_cols = 16,
+};
+
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
 static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
@@ -299,8 +311,10 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32 val;
 
 	/* Clear Rows and Cols */
-	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MIN_COL_VAL);
+	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK,
+			 ctrl->rows_index);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK,
+			  ctrl->cols_index);
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
@@ -378,8 +392,10 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
 	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
 
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MAX_COL_VAL);
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK,
+			  ctrl->cols_index);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK,
+			  ctrl->rows_index);
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
@@ -780,6 +796,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params *params;
 	struct qcom_swrm_ctrl *ctrl;
+	const struct qcom_swrm_data *data;
 	int ret;
 	u32 val;
 
@@ -787,6 +804,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+	data = of_device_get_match_data(dev);
+	ctrl->rows_index = sdw_find_row_index(data->default_rows);
+	ctrl->cols_index = sdw_find_col_index(data->default_cols);
 #if IS_ENABLED(CONFIG_SLIMBUS)
 	if (dev->parent->bus == &slimbus_bus) {
 #else
@@ -836,8 +856,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	params = &ctrl->bus.params;
 	params->max_dr_freq = DEFAULT_CLK_FREQ;
 	params->curr_dr_freq = DEFAULT_CLK_FREQ;
-	params->col = SWRM_DEFAULT_COL;
-	params->row = SWRM_DEFAULT_ROWS;
+	params->col = data->default_cols;
+	params->row = data->default_rows;
 	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
 	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
 	params->next_bank = !params->curr_bank;
@@ -847,8 +867,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	prop->num_clk_gears = 0;
 	prop->num_clk_freq = MAX_FREQ_NUM;
 	prop->clk_freq = &qcom_swrm_freq_tbl[0];
-	prop->default_col = SWRM_DEFAULT_COL;
-	prop->default_row = SWRM_DEFAULT_ROWS;
+	prop->default_col = data->default_cols;
+	prop->default_row = data->default_rows;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
 
@@ -899,8 +919,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_swrm_of_match[] = {
-	{ .compatible = "qcom,soundwire-v1.3.0", },
-	{ .compatible = "qcom,soundwire-v1.5.1", },
+	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
+	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
 	{/* sentinel */},
 };
 
-- 
2.21.0

