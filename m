Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE03E2FC8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbhATDUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:20:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:40628 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbhATCj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:39:59 -0500
IronPort-SDR: pSyP5hQogrtR9ID8gFqnzg7+Z8l5gxTV7JUlX7DmxOnApLxSzdvfvYk+Fo/7sz1E73KgvfS06g
 /eZfPM8bi+4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243103793"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243103793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:39:17 -0800
IronPort-SDR: AMFOgMYLSnu5sRn0bxdFzxQd+0lpYP1MsQCtQ0UDYubIzxEB9ikZrLAZlolf2v0KMi38MubRhz
 ZQCmdvEwsQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355869079"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 18:39:14 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH 2/2] mfd: intel-m10-bmc: add access table configuration to the regmap
Date:   Wed, 20 Jan 2021 10:34:41 +0800
Message-Id: <1611110081-10056-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
References: <1611110081-10056-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds access tables to the MAX 10 BMC regmap. This prevents
the host from accessing the unwanted I/O space. It also filters out the
invalid outputs when reading the regmap debugfs interface.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/mfd/intel-m10-bmc.c       | 14 ++++++++++++++
 include/linux/mfd/intel-m10-bmc.h |  5 ++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index b84579b..0ae3053 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -23,10 +23,24 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-secure" },
 };
 
+static const struct regmap_range m10bmc_regmap_range[] = {
+	regmap_reg_range(M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
+			 M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER),
+	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
+	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
+};
+
+static const struct regmap_access_table m10bmc_access_table = {
+	.yes_ranges	= m10bmc_regmap_range,
+	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
+};
+
 static struct regmap_config intel_m10bmc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
+	.wr_table = &m10bmc_access_table,
+	.rd_table = &m10bmc_access_table,
 	.max_register = M10BMC_MEM_END,
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 06da62c..4ba88ed 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,10 @@
 
 #define M10BMC_LEGACY_SYS_BASE		0x300400
 #define M10BMC_SYS_BASE			0x300800
-#define M10BMC_MEM_END			0x1fffffff
+#define M10BMC_SYS_END			0x300fff
+#define M10BMC_FLASH_BASE		0x10000000
+#define M10BMC_FLASH_END		0x1fffffff
+#define M10BMC_MEM_END			M10BMC_FLASH_END
 
 /* Register offset of system registers */
 #define NIOS2_FW_VERSION		0x0
-- 
2.7.4

