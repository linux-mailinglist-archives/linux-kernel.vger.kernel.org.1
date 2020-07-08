Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3521816D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGHHlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 03:41:01 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56616 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgGHHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:40:52 -0400
Received: from [78.134.117.153] (port=41602 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jt4hF-0009Wd-5L; Wed, 08 Jul 2020 09:40:49 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v2 3/4] clk: vc5: use a dedicated struct to describe the output drivers
Date:   Wed,  8 Jul 2020 09:40:34 +0200
Message-Id: <20200708074035.31595-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708074035.31595-1-luca@lucaceresoli.net>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reusing the generic struct vc5_hw_data for all blocks is handy. However it
implies we allocate space the div_int and div_frc fields even for the
output drivers where they are unused, and the clk_output_cfg0 and
clk_output_cfg0_mask fields that are used only for the output
drivers.

Use a dedicated struct for the output drivers so that each block uses
exactly the fields it needs, not more.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/clk/clk-versaclock5.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 9a5fb3834b9a..944c7c7c843f 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -167,6 +167,12 @@ struct vc5_hw_data {
 	u32			div_int;
 	u32			div_frc;
 	unsigned int		num;
+};
+
+struct vc5_out_data {
+	struct clk_hw		hw;
+	struct vc5_driver_data	*vc5;
+	unsigned int		num;
 	unsigned int		clk_output_cfg0;
 	unsigned int		clk_output_cfg0_mask;
 };
@@ -184,7 +190,7 @@ struct vc5_driver_data {
 	struct clk_hw		clk_pfd;
 	struct vc5_hw_data	clk_pll;
 	struct vc5_hw_data	clk_fod[VC5_MAX_FOD_NUM];
-	struct vc5_hw_data	clk_out[VC5_MAX_CLK_OUT_NUM];
+	struct vc5_out_data	clk_out[VC5_MAX_CLK_OUT_NUM];
 };
 
 /*
@@ -567,7 +573,7 @@ static const struct clk_ops vc5_fod_ops = {
 
 static int vc5_clk_out_prepare(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_SELB_NORM |
 			VC5_OUT_DIV_CONTROL_SEL_EXT |
@@ -609,7 +615,7 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 
 static void vc5_clk_out_unprepare(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 
 	/* Disable the clock buffer */
@@ -619,7 +625,7 @@ static void vc5_clk_out_unprepare(struct clk_hw *hw)
 
 static unsigned char vc5_clk_out_get_parent(struct clk_hw *hw)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_SELB_NORM |
 			VC5_OUT_DIV_CONTROL_SEL_EXT |
@@ -649,7 +655,7 @@ static unsigned char vc5_clk_out_get_parent(struct clk_hw *hw)
 
 static int vc5_clk_out_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
+	struct vc5_out_data *hwdata = container_of(hw, struct vc5_out_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	const u8 mask = VC5_OUT_DIV_CONTROL_RESET |
 			VC5_OUT_DIV_CONTROL_SELB_NORM |
@@ -704,7 +710,7 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 }
 
 static int vc5_update_mode(struct device_node *np_output,
-			   struct vc5_hw_data *clk_out)
+			   struct vc5_out_data *clk_out)
 {
 	u32 value;
 
@@ -729,7 +735,7 @@ static int vc5_update_mode(struct device_node *np_output,
 }
 
 static int vc5_update_power(struct device_node *np_output,
-			    struct vc5_hw_data *clk_out)
+			    struct vc5_out_data *clk_out)
 {
 	u32 value;
 
@@ -754,7 +760,7 @@ static int vc5_update_power(struct device_node *np_output,
 }
 
 static int vc5_update_slew(struct device_node *np_output,
-			   struct vc5_hw_data *clk_out)
+			   struct vc5_out_data *clk_out)
 {
 	u32 value;
 
@@ -782,7 +788,7 @@ static int vc5_update_slew(struct device_node *np_output,
 }
 
 static int vc5_get_output_config(struct i2c_client *client,
-				 struct vc5_hw_data *clk_out)
+				 struct vc5_out_data *clk_out)
 {
 	struct device_node *np_output;
 	char *child_name;
-- 
2.27.0

