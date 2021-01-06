Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB9E2EBAA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAFHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:42:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:10763 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbhAFHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:42:06 -0500
IronPort-SDR: yCe6mnf5Dqq8XBwNgYrd1R5nG9PoItxxete5HxQydudR4bIQGUBtHXGouy/4QkMv1bNkUHptZd
 b1s43y8kqKZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176462190"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="176462190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:41:26 -0800
IronPort-SDR: nNCcQ7ICPsehGsxPU29GsDppFVliFcBddIlITp8x1PwivUTtxvuj1pA/GQA3aqIVwt6wz2ANDI
 6L9QLmjyD8EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="361466725"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2021 23:41:23 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     arnd@arndb.de, lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        russell.h.weight@intel.com
Subject: [PATCH 1/2] mfd: intel-m10-bmc: specify the retimer sub devices
Date:   Wed,  6 Jan 2021 15:36:06 +0800
Message-Id: <1609918567-13339-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch specifies the 2 retimer sub devices and their resources in the
parent driver's mfd_cell. It also adds the register definition of the
retimer sub devices.

There are 2 ethernet retimer chips (C827) connected to the Intel MAX 10
BMC. They are managed by the BMC firmware, and host could query them via
retimer interfaces (shared registers) on the BMC. The 2 retimers have
identical register interfaces in different register addresses or fields,
so it is better we define 2 retimer devices and handle them with the same
driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/mfd/intel-m10-bmc.c       | 19 ++++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h |  7 +++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index b84579b..e0a99a0 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -17,9 +17,26 @@ enum m10bmc_type {
 	M10_N3000,
 };
 
+static struct resource retimer0_resources[] = {
+	{M10BMC_PKVL_A_VER, M10BMC_PKVL_A_VER, "version", IORESOURCE_REG, },
+};
+
+static struct resource retimer1_resources[] = {
+	{M10BMC_PKVL_B_VER, M10BMC_PKVL_B_VER, "version", IORESOURCE_REG, },
+};
+
 static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-hwmon" },
-	{ .name = "n3000bmc-retimer" },
+	{
+		.name = "n3000bmc-retimer",
+		.num_resources = ARRAY_SIZE(retimer0_resources),
+		.resources = retimer0_resources,
+	},
+	{
+		.name = "n3000bmc-retimer",
+		.num_resources = ARRAY_SIZE(retimer1_resources),
+		.resources = retimer1_resources,
+	},
 	{ .name = "n3000bmc-secure" },
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index c8ef2f1..d6216f9 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -21,6 +21,13 @@
 #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
 #define M10BMC_VER_LEGACY_INVALID	0xffffffff
 
+/* Retimer related registers, in system register region */
+#define M10BMC_PKVL_LSTATUS		0x164
+#define M10BMC_PKVL_A_VER		0x254
+#define M10BMC_PKVL_B_VER		0x258
+#define M10BMC_PKVL_SERDES_VER		GENMASK(15, 0)
+#define M10BMC_PKVL_SBUS_VER		GENMASK(31, 16)
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
-- 
2.7.4

