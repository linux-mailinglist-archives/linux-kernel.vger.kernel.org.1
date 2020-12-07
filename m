Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596482D17D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLGRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:48:39 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58364 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726247AbgLGRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:48:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@nvidia.com)
        with SMTP; 7 Dec 2020 19:47:48 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7Hll1Z001902;
        Mon, 7 Dec 2020 19:47:48 +0200
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     andy@infradead.org, hdegoede@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH platform 1/2] platform/x86: mlx-platform: Fix item counter assignment for MSN2700, MSN24xx systems
Date:   Mon,  7 Dec 2020 19:47:44 +0200
Message-Id: <20201207174745.22889-2-vadimp@nvidia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201207174745.22889-1-vadimp@nvidia.com>
References: <20201207174745.22889-1-vadimp@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix array names to match assignments for data items and data items
counter in 'mlxplat_mlxcpld_default_items' structure for:
	.data = mlxplat_mlxcpld_default_pwr_items_data,
	.count = ARRAY_SIZE(mlxplat_mlxcpld_pwr),
and
	.data = mlxplat_mlxcpld_default_fan_items_data,
	.count = ARRAY_SIZE(mlxplat_mlxcpld_fan),

Replace:
- 'mlxplat_mlxcpld_pwr' by 'mlxplat_mlxcpld_default_pwr_items_data' for
   ARRAY_SIZE() calculation.
- 'mlxplat_mlxcpld_fan' by 'mlxplat_mlxcpld_default_fan_items_data'
   for ARRAY_SIZE() calculation.

Fixes: c6acad68eb2d ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/x86/mlx-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 6a634b72bfc2..b30ebd17f3de 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -456,7 +456,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_default_items[] = {
 		.aggr_mask = MLXPLAT_CPLD_AGGR_PWR_MASK_DEF,
 		.reg = MLXPLAT_CPLD_LPC_REG_PWR_OFFSET,
 		.mask = MLXPLAT_CPLD_PWR_MASK,
-		.count = ARRAY_SIZE(mlxplat_mlxcpld_pwr),
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_pwr_items_data),
 		.inversed = 0,
 		.health = false,
 	},
@@ -465,7 +465,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_default_items[] = {
 		.aggr_mask = MLXPLAT_CPLD_AGGR_FAN_MASK_DEF,
 		.reg = MLXPLAT_CPLD_LPC_REG_FAN_OFFSET,
 		.mask = MLXPLAT_CPLD_FAN_MASK,
-		.count = ARRAY_SIZE(mlxplat_mlxcpld_fan),
+		.count = ARRAY_SIZE(mlxplat_mlxcpld_default_fan_items_data),
 		.inversed = 1,
 		.health = false,
 	},
-- 
2.11.0

