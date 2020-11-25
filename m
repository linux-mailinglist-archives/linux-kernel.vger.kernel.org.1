Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D932C3D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgKYKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:11:02 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37725 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728046AbgKYKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:11:01 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@nvidia.com)
        with SMTP; 25 Nov 2020 12:10:59 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0APAAvju025972;
        Wed, 25 Nov 2020 12:10:58 +0200
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     andy@infradead.org, hdegoede@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH platform 1/2] platform/x86: mlx-platform: Remove PSU EEPROM from default platform configuration
Date:   Wed, 25 Nov 2020 12:10:55 +0200
Message-Id: <20201125101056.174708-2-vadimp@nvidia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201125101056.174708-1-vadimp@nvidia.com>
References: <20201125101056.174708-1-vadimp@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove PSU EEPROM configuration for systems class equipped with
Mellanox chip Spectrum and Celeron CPU - system types MSN2700, MSN2100.
Till now all the systems from this class used few types of power units,
all equipped with EEPROM device with address space two bytes. Thus, all
these devices have been handled by EEPROM driver "24c02".

There is a new requirement is to support power unit replacement by "off
the shelf" device, matching electrical required parameters. Such device
can be equipped with different EEPROM type, which could be one byte
address space addressing or even could be not equipped with EEPROM.
In such case "24c02" will not work.

Fixes: c6acad68e ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Fixes: ba814fdd0 ("platform/x86: mlx-platform: Use defines for bus assignment")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/x86/mlx-platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 986ad3dda1c1..623e7f737d4a 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -383,15 +383,13 @@ static struct mlxreg_core_data mlxplat_mlxcpld_default_psu_items_data[] = {
 		.label = "psu1",
 		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
 		.mask = BIT(0),
-		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[0],
-		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
 	},
 	{
 		.label = "psu2",
 		.reg = MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
 		.mask = BIT(1),
-		.hpdev.brdinfo = &mlxplat_mlxcpld_psu[1],
-		.hpdev.nr = MLXPLAT_CPLD_PSU_DEFAULT_NR,
+		.hpdev.nr = MLXPLAT_CPLD_NR_NONE,
 	},
 };
 
-- 
2.11.0

