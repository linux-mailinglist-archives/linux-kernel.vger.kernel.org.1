Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A819CF99
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 07:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgDCFEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 01:04:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:62262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgDCFEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:04:45 -0400
IronPort-SDR: gw1ftj1MKfN7ke59ygW9nU8YlI5CcSL/haA3z4TS2303/mgjTp+UAZ/Dj8OjdMqHk+IFQZe4eS
 pBlvOwiQ5P3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 22:04:44 -0700
IronPort-SDR: 5/TdAYKeeRLl+uLllzCeaY/bPVM3LpudJClXHG7SMSTpF5AltNg+zC15Mwa6TguNcZj6U5p6DA
 gLHkEYu5WyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="360418378"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2020 22:04:42 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v6 1/4] mfd: syscon: Add fwnode_to_regmap
Date:   Fri,  3 Apr 2020 13:04:08 +0800
Message-Id: <9c58aeb1561f28f302921d54aee75942545c4971.1585889042.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traverse regmap handle entry from firmware node handle.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v5:
  No changes
  
Changes on v5:
  No changes

Changes on v4:
  No changes

 drivers/mfd/syscon.c       | 8 ++++++++
 include/linux/mfd/syscon.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 3a97816d0cba..e085c50816b9 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -178,6 +178,14 @@ struct regmap *device_node_to_regmap(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(device_node_to_regmap);
 
+struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
+{
+	struct device_node *np = to_of_node(fwnode);
+
+	return device_node_get_regmap(np, false);
+}
+EXPORT_SYMBOL_GPL(fwnode_to_regmap);
+
 struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	if (!of_device_is_compatible(np, "syscon"))
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 7f20e9b502a5..dacab0b4a091 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -18,6 +18,7 @@ struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
 extern struct regmap *device_node_to_regmap(struct device_node *np);
+extern struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode);
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
@@ -34,6 +35,11 @@ static inline struct regmap *device_node_to_regmap(struct device_node *np)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.11.0

