Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0026C8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgIPS4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbgIPR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:57:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C909C02C2B0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so7375621wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7U04XxCq+61JwDLpYnpauOtw8AQMg5GwCJMJAegysE=;
        b=zcjWfK5jdTcoSX69FvF8etBcZ0/k01BHqXFlUvcOL8WjJUhxJVPyXschbpxMX0NvPg
         aIc/MyPaqkNDZyxHFYf0nxmEwArRKcgyiy11a+MzDC+XdXZxcHgiTFjVnj+PcyxNw3+X
         +C7HuA623CZFdi/P3/thUpCJJkLVf59MPfhDD5lv2qcSheCCE73i8U6vowq6aqSzlNNZ
         4a47k+BTEr1H+q0KnHBSNPCf4yEgC89gw5CLjYXNcEbq708A3wA2iWGcuXW+HRTtU/VF
         hS1WdKT1hnTF+GyglvkYEumVjggZYx+mNOwKrzgOo1UMFlJ5MkC+nlb2f4dF+IXz/ahe
         ITUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7U04XxCq+61JwDLpYnpauOtw8AQMg5GwCJMJAegysE=;
        b=Bez2GiijwtE0fWi46RYPjSxKU4R/0ZejRX9is0kmEtAXzL8rMtZHyv76mrORPajlat
         akZgi4kpp3EaM25pmcZSGrmxd64R/xU4FFfBY67Z/A35kait7iCuHEHdFeTJZUc2IKAv
         n+UckUrYSJ1VJcZLDRWc50nEkzYy/EXKC51d4ecnvjmVSKD7wbv8V2WOWv6JgeiCe8aY
         uRoapwV0p7SYqlFQPJxiYaHat8qA0Sl2tteN6TB9ZIe4n316Wd8Qs+82Rp4M5RRTbehw
         wjQv8u38T5PEgSXRdtG7E8p5iQ8/jk/OSk+lgSYEeurIhRHiYx+vwhfi3Fr5PTL7NZFU
         Aa1Q==
X-Gm-Message-State: AOAM531Kc+GEszsdZtl9gq5gx02rpX4YOMdavhy/plyBwiuB+XXD0qI0
        Ja0BYBoUG00XiKpKRCZJzNc0kLx/XOeazQ==
X-Google-Smtp-Source: ABdhPJxxkkIzx3lElJ4LtY9VVWlYPU45BQqngRTlRJSr1UcBdag1LOfRXz1qqaLisniM93cpf/LuTQ==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr29222629wrt.166.1600270871654;
        Wed, 16 Sep 2020 08:41:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t22sm7223901wmt.1.2020.09.16.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:41:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/3] soundwire: qcom: get max rows and cols info from compatible
Date:   Wed, 16 Sep 2020 16:41:01 +0100
Message-Id: <20200916154101.2254-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
References: <20200916154101.2254-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/qcom.c | 46 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 5a61d82310fd..88ea31265941 100644
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
@@ -299,8 +311,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32 val;
 
 	/* Clear Rows and Cols */
-	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, SWRM_MAX_ROW_VAL);
-	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, SWRM_MIN_COL_VAL);
+	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
+	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
@@ -374,8 +386,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
 
 	ctrl->reg_read(ctrl, reg, &val);
 
-	val = u32_replace_bits(val, SWRM_MAX_COL_VAL, SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK);
-	val = u32_replace_bits(val, SWRM_MAX_ROW_VAL, SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK);
+	val = u32_replace_bits(val, ctrl->cols_index, SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK);
+	val = u32_replace_bits(val, ctrl->rows_index, SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK);
 
 	return ctrl->reg_write(ctrl, reg, val);
 }
@@ -776,6 +788,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params *params;
 	struct qcom_swrm_ctrl *ctrl;
+	const struct qcom_swrm_data *data;
 	int ret;
 	u32 val;
 
@@ -783,6 +796,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+	data = of_device_get_match_data(dev);
+	ctrl->rows_index = sdw_find_row_index(data->default_rows);
+	ctrl->cols_index = sdw_find_col_index(data->default_cols);
 #if IS_ENABLED(CONFIG_SLIMBUS)
 	if (dev->parent->bus == &slimbus_bus) {
 #else
@@ -832,8 +848,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
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
@@ -843,8 +859,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	prop->num_clk_gears = 0;
 	prop->num_clk_freq = MAX_FREQ_NUM;
 	prop->clk_freq = &qcom_swrm_freq_tbl[0];
-	prop->default_col = SWRM_DEFAULT_COL;
-	prop->default_row = SWRM_DEFAULT_ROWS;
+	prop->default_col = data->default_cols;
+	prop->default_row = data->default_rows;
 
 	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
 
@@ -895,8 +911,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
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

