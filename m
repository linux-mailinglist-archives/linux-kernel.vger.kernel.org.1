Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC261EA0D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgFAJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:08 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51545 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgFAJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:07 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:19:03 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSs003135;
        Mon, 1 Jun 2020 12:19:03 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 4/8] platform/x86: mlx-platform: Add more definitions for system attributes
Date:   Mon,  1 Jun 2020 12:18:47 +0300
Message-Id: <20200601091851.5491-5-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200601091851.5491-1-vadimp@mellanox.com>
References: <20200601091851.5491-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new attributes for the all type systems specifying for each
equipped CPLD device, the CPLD part number and the CPLD minor version
of the device: 'cpld{n}_pn' and 'cpld{n}_version_min'.
This information is to be used for mathcing the current CPLD image and
for making decision if image upgrade is required for CPLD device.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 drivers/platform/x86/mlx-platform.c | 128 ++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index c27548fd386a..034736cec9a6 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -26,6 +26,10 @@
 #define MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET	0x01
 #define MLXPLAT_CPLD_LPC_REG_CPLD3_VER_OFFSET	0x02
 #define MLXPLAT_CPLD_LPC_REG_CPLD4_VER_OFFSET	0x03
+#define MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET	0x04
+#define MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET	0x06
+#define MLXPLAT_CPLD_LPC_REG_CPLD3_PN_OFFSET	0x08
+#define MLXPLAT_CPLD_LPC_REG_CPLD4_PN_OFFSET	0x0a
 #define MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET	0x1d
 #define MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET	0x1e
 #define MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET	0x1f
@@ -72,6 +76,10 @@
 #define MLXPLAT_CPLD_LPC_REG_WD3_TMR_OFFSET	0xd1
 #define MLXPLAT_CPLD_LPC_REG_WD3_TLEFT_OFFSET	0xd2
 #define MLXPLAT_CPLD_LPC_REG_WD3_ACT_OFFSET	0xd3
+#define MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET	0xde
+#define MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET	0xdf
+#define MLXPLAT_CPLD_LPC_REG_CPLD3_MVER_OFFSET	0xe0
+#define MLXPLAT_CPLD_LPC_REG_CPLD4_MVER_OFFSET	0xe1
 #define MLXPLAT_CPLD_LPC_REG_UFM_VERSION_OFFSET	0xe2
 #define MLXPLAT_CPLD_LPC_REG_PWM1_OFFSET	0xe3
 #define MLXPLAT_CPLD_LPC_REG_TACHO1_OFFSET	0xe4
@@ -1304,6 +1312,32 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "cpld1_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld2_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld1_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld2_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
 		.label = "reset_long_pb",
 		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(0),
@@ -1410,6 +1444,32 @@ static struct mlxreg_core_data mlxplat_mlxcpld_msn21xx_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "cpld1_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld2_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld1_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld2_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
 		.label = "reset_long_pb",
 		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(0),
@@ -1528,6 +1588,58 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_ng_regs_io_data[] = {
 		.mode = 0444,
 	},
 	{
+		.label = "cpld1_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld2_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld3_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD3_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld4_pn",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD4_PN_OFFSET,
+		.bit = GENMASK(15, 0),
+		.mode = 0444,
+		.regnum = 2,
+	},
+	{
+		.label = "cpld1_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld2_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld3_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD3_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
+		.label = "cpld4_version_min",
+		.reg = MLXPLAT_CPLD_LPC_REG_CPLD4_MVER_OFFSET,
+		.bit = GENMASK(7, 0),
+		.mode = 0444,
+	},
+	{
 		.label = "reset_long_pb",
 		.reg = MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET,
 		.mask = GENMASK(7, 0) & ~BIT(0),
@@ -2006,6 +2118,10 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_CPLD3_VER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_CPLD4_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD3_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD4_PN_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET:
@@ -2051,6 +2167,10 @@ static bool mlxplat_mlxcpld_readable_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_WD3_TMR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WD3_TLEFT_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WD3_ACT_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD3_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD4_MVER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_PWM1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO2_OFFSET:
@@ -2085,6 +2205,10 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_CPLD2_VER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_CPLD3_VER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_CPLD4_VER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD3_PN_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD4_PN_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RESET_CAUSE_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RST_CAUSE1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_RST_CAUSE2_OFFSET:
@@ -2122,6 +2246,10 @@ static bool mlxplat_mlxcpld_volatile_reg(struct device *dev, unsigned int reg)
 	case MLXPLAT_CPLD_LPC_REG_WD2_TLEFT_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WD3_TMR_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_WD3_TLEFT_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD1_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD2_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD3_MVER_OFFSET:
+	case MLXPLAT_CPLD_LPC_REG_CPLD4_MVER_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_PWM1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO1_OFFSET:
 	case MLXPLAT_CPLD_LPC_REG_TACHO2_OFFSET:
-- 
2.11.0

