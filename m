Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA61F45DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgFISVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:21:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51766 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbgFIRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:48:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id DA6612A3BF5
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Philippe CORNU <philippe.cornu@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        Adrian Pop <pop.adrian61@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v9 09/11] drm: bridge: dw-mipi-dsi: split low power cfg register into fields
Date:   Tue,  9 Jun 2020 20:49:57 +0300
Message-Id: <20200609174959.955926-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174959.955926-1-adrian.ratiu@collabora.com>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Host Registers documentation for IMX, STM and RK
the LP cfg register should not be written entirely in one go because
some bits are reserved and should be kept to reset values, for eg.
BIT(15) which is reserved in all versions.

This also cleans up the code by removing the the ugly defines
and making field ranges & values written more explicit.

Tested-by: Adrian Pop <pop.adrian61@gmail.com>
Tested-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
New in v6.
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 105 ++++++------------
 1 file changed, 33 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 70df0578cbe7b..1e47d40b5becb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -120,60 +120,6 @@
 #define DSI_TO_CNT_CFG_V101		0x40
 #define DSI_PCKHDL_CFG_V101		0x18
 
-#define MAX_RD_PKT_SIZE_LP		BIT(24)
-#define DCS_LW_TX_LP			BIT(19)
-#define DCS_SR_0P_TX_LP			BIT(18)
-#define DCS_SW_1P_TX_LP			BIT(17)
-#define DCS_SW_0P_TX_LP			BIT(16)
-#define GEN_LW_TX_LP			BIT(14)
-#define GEN_SR_2P_TX_LP			BIT(13)
-#define GEN_SR_1P_TX_LP			BIT(12)
-#define GEN_SR_0P_TX_LP			BIT(11)
-#define GEN_SW_2P_TX_LP			BIT(10)
-#define GEN_SW_1P_TX_LP			BIT(9)
-#define GEN_SW_0P_TX_LP			BIT(8)
-#define TEAR_FX_EN			BIT(0)
-
-#define CMD_MODE_ALL_LP			(MAX_RD_PKT_SIZE_LP | \
-					 DCS_LW_TX_LP | \
-					 DCS_SR_0P_TX_LP | \
-					 DCS_SW_1P_TX_LP | \
-					 DCS_SW_0P_TX_LP | \
-					 GEN_LW_TX_LP | \
-					 GEN_SR_2P_TX_LP | \
-					 GEN_SR_1P_TX_LP | \
-					 GEN_SR_0P_TX_LP | \
-					 GEN_SW_2P_TX_LP | \
-					 GEN_SW_1P_TX_LP | \
-					 GEN_SW_0P_TX_LP)
-
-#define EN_TEAR_FX_V101			BIT(14)
-#define DCS_LW_TX_LP_V101		BIT(12)
-#define GEN_LW_TX_LP_V101		BIT(11)
-#define MAX_RD_PKT_SIZE_LP_V101		BIT(10)
-#define DCS_SW_2P_TX_LP_V101		BIT(9)
-#define DCS_SW_1P_TX_LP_V101		BIT(8)
-#define DCS_SW_0P_TX_LP_V101		BIT(7)
-#define GEN_SR_2P_TX_LP_V101		BIT(6)
-#define GEN_SR_1P_TX_LP_V101		BIT(5)
-#define GEN_SR_0P_TX_LP_V101		BIT(4)
-#define GEN_SW_2P_TX_LP_V101		BIT(3)
-#define GEN_SW_1P_TX_LP_V101		BIT(2)
-#define GEN_SW_0P_TX_LP_V101		BIT(1)
-
-#define CMD_MODE_ALL_LP_V101		(DCS_LW_TX_LP_V101 | \
-					 GEN_LW_TX_LP_V101 | \
-					 MAX_RD_PKT_SIZE_LP_V101 | \
-					 DCS_SW_2P_TX_LP_V101 | \
-					 DCS_SW_1P_TX_LP_V101 | \
-					 DCS_SW_0P_TX_LP_V101 | \
-					 GEN_SR_2P_TX_LP_V101 | \
-					 GEN_SR_1P_TX_LP_V101 | \
-					 GEN_SR_0P_TX_LP_V101 | \
-					 GEN_SW_2P_TX_LP_V101 | \
-					 GEN_SW_1P_TX_LP_V101 | \
-					 GEN_SW_0P_TX_LP_V101)
-
 #define DSI_GEN_HDR			0x6c
 #define DSI_GEN_PLD_DATA		0x70
 
@@ -257,7 +203,11 @@ struct dw_mipi_dsi {
 	struct regmap_field	*field_dpi_vsync_active_low;
 	struct regmap_field	*field_dpi_hsync_active_low;
 	struct regmap_field	*field_cmd_mode_ack_rqst_en;
-	struct regmap_field	*field_cmd_mode_all_lp_en;
+	struct regmap_field	*field_cmd_mode_gen_sw_sr_en;
+	struct regmap_field	*field_cmd_mode_dcs_sw_sr_en;
+	struct regmap_field	*field_cmd_mode_gen_lw_en;
+	struct regmap_field	*field_cmd_mode_dcs_lw_en;
+	struct regmap_field	*field_cmd_mode_max_rd_pkt_size;
 	struct regmap_field	*field_cmd_mode_en;
 	struct regmap_field	*field_cmd_pkt_status;
 	struct regmap_field	*field_vid_mode_en;
@@ -315,7 +265,11 @@ struct dw_mipi_dsi_variant {
 	struct reg_field	cfg_dpi_hsync_active_low;
 	struct reg_field	cfg_cmd_mode_en;
 	struct reg_field	cfg_cmd_mode_ack_rqst_en;
-	struct reg_field	cfg_cmd_mode_all_lp_en;
+	struct reg_field	cfg_cmd_mode_gen_sw_sr_en;
+	struct reg_field	cfg_cmd_mode_dcs_sw_sr_en;
+	struct reg_field	cfg_cmd_mode_gen_lw_en;
+	struct reg_field	cfg_cmd_mode_dcs_lw_en;
+	struct reg_field	cfg_cmd_mode_max_rd_pkt_size;
 	struct reg_field	cfg_cmd_pkt_status;
 	struct reg_field	cfg_vid_mode_en;
 	struct reg_field	cfg_vid_mode_type;
@@ -366,7 +320,11 @@ static const struct dw_mipi_dsi_variant dw_mipi_dsi_v130_v131_layout = {
 	.cfg_dpi_vsync_active_low =	REG_FIELD(DSI_DPI_CFG_POL, 1, 1),
 	.cfg_dpi_hsync_active_low =	REG_FIELD(DSI_DPI_CFG_POL, 2, 2),
 	.cfg_cmd_mode_ack_rqst_en =	REG_FIELD(DSI_CMD_MODE_CFG, 1, 1),
-	.cfg_cmd_mode_all_lp_en =	REG_FIELD(DSI_CMD_MODE_CFG, 8, 24),
+	.cfg_cmd_mode_gen_sw_sr_en =	REG_FIELD(DSI_CMD_MODE_CFG, 8, 13),
+	.cfg_cmd_mode_gen_lw_en =	REG_FIELD(DSI_CMD_MODE_CFG, 14, 14),
+	.cfg_cmd_mode_dcs_sw_sr_en =	REG_FIELD(DSI_CMD_MODE_CFG, 16, 18),
+	.cfg_cmd_mode_dcs_lw_en =	REG_FIELD(DSI_CMD_MODE_CFG, 19, 19),
+	.cfg_cmd_mode_max_rd_pkt_size =	REG_FIELD(DSI_CMD_MODE_CFG, 24, 24),
 	.cfg_cmd_mode_en =		REG_FIELD(DSI_MODE_CFG, 0, 31),
 	.cfg_cmd_pkt_status =		REG_FIELD(DSI_CMD_PKT_STATUS, 0, 31),
 	.cfg_vid_mode_en =		REG_FIELD(DSI_MODE_CFG, 0, 31),
@@ -418,7 +376,11 @@ static const struct dw_mipi_dsi_variant dw_mipi_dsi_v101_layout = {
 	.cfg_dpi_vsync_active_low =	REG_FIELD(DSI_DPI_CFG, 6, 6),
 	.cfg_dpi_hsync_active_low =	REG_FIELD(DSI_DPI_CFG, 7, 7),
 	.cfg_cmd_mode_en =		REG_FIELD(DSI_CMD_MODE_CFG_V101, 0, 0),
-	.cfg_cmd_mode_all_lp_en =	REG_FIELD(DSI_CMD_MODE_CFG_V101, 1, 12),
+	.cfg_cmd_mode_gen_sw_sr_en =	REG_FIELD(DSI_CMD_MODE_CFG, 1, 6),
+	.cfg_cmd_mode_dcs_sw_sr_en =	REG_FIELD(DSI_CMD_MODE_CFG, 7, 9),
+	.cfg_cmd_mode_max_rd_pkt_size =	REG_FIELD(DSI_CMD_MODE_CFG, 10, 10),
+	.cfg_cmd_mode_gen_lw_en =	REG_FIELD(DSI_CMD_MODE_CFG, 11, 11),
+	.cfg_cmd_mode_dcs_lw_en =	REG_FIELD(DSI_CMD_MODE_CFG, 12, 12),
 	.cfg_cmd_mode_ack_rqst_en =	REG_FIELD(DSI_CMD_MODE_CFG_V101, 13, 13),
 	.cfg_cmd_pkt_status =		REG_FIELD(DSI_CMD_PKT_STATUS_V101, 0, 14),
 	.cfg_vid_mode_en =		REG_FIELD(DSI_VID_MODE_CFG_V101, 0, 0),
@@ -554,23 +516,18 @@ static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
 				   const struct mipi_dsi_msg *msg)
 {
 	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
-	u32 cmd_mode_lp = 0;
-
-	switch (dsi->hw_version) {
-	case HWVER_130:
-	case HWVER_131:
-		cmd_mode_lp = CMD_MODE_ALL_LP;
-		break;
-	case HWVER_101:
-		cmd_mode_lp = CMD_MODE_ALL_LP_V101;
-		break;
-	}
 
 	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
 		regmap_field_write(dsi->field_cmd_mode_ack_rqst_en, 1);
 
-	if (lpm)
-		regmap_field_write(dsi->field_cmd_mode_all_lp_en, cmd_mode_lp);
+	if (lpm) {
+		regmap_field_write(dsi->field_cmd_mode_gen_sw_sr_en,
+				   ENABLE_LOW_POWER);
+		regmap_field_write(dsi->field_cmd_mode_dcs_sw_sr_en, 7);
+		regmap_field_write(dsi->field_cmd_mode_gen_lw_en, 1);
+		regmap_field_write(dsi->field_cmd_mode_dcs_lw_en, 1);
+		regmap_field_write(dsi->field_cmd_mode_max_rd_pkt_size, 1);
+	}
 
 	regmap_field_write(dsi->field_phy_txrequestclkhs, lpm ? 0 : 1);
 }
@@ -1256,7 +1213,11 @@ static int dw_mipi_dsi_regmap_fields_init(struct dw_mipi_dsi *dsi)
 	INIT_FIELD(dpi_vsync_active_low);
 	INIT_FIELD(dpi_hsync_active_low);
 	INIT_FIELD(cmd_mode_ack_rqst_en);
-	INIT_FIELD(cmd_mode_all_lp_en);
+	INIT_FIELD(cmd_mode_gen_sw_sr_en);
+	INIT_FIELD(cmd_mode_dcs_sw_sr_en);
+	INIT_FIELD(cmd_mode_gen_lw_en);
+	INIT_FIELD(cmd_mode_dcs_lw_en);
+	INIT_FIELD(cmd_mode_max_rd_pkt_size);
 	INIT_FIELD(cmd_mode_en);
 	INIT_FIELD(cmd_pkt_status);
 	INIT_FIELD(vid_mode_en);
-- 
2.27.0

