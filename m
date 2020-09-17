Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EE26DBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIQMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:39:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:62180 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbgIQMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:34:10 -0400
X-Greylist: delayed 1511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:34:10 EDT
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08HC6h7n022722;
        Thu, 17 Sep 2020 07:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=A7n7f6rZgb5aYGJ6K94h+Qe3/cur1FpWWNEBlCYl0mo=;
 b=no1zfP76hub/J69uYbghRL+HmofMjhhYw93dwfLdZtvYRzLXXUnVmdVG0+6QM4IRZ1Aj
 cdG2xin4xBceD7+N2IbXeLtcIVdtIwOI/Nw/iHbEFQDsiKAPvydE+1uXHUoZaE7GDNpG
 SvyMv8GKtFB/dsb5hDdcNzLaNaRBrh5W4YBLQ2x/kx42o/4Fr/WBatDhmSVZawQ637CY
 ZrR9hw0+0H1sjWDdxsYlkB8o8FbARuIxM5e9/v/CrnM+crQgTgSJlGpBz4aUaFY1OBi7
 gYCpQtPdHkcOvmPGk3TaW2Dj2528EH+HGwEXbIZEmuHyDq3OGtJMd5Sh0X+/6sq+VUV2 yA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33k5prjv3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Sep 2020 07:08:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Sep
 2020 13:08:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Sep 2020 13:08:28 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F0A82A1;
        Thu, 17 Sep 2020 12:08:28 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2] regmap: debugfs: Fix handling of name string for debugfs init delays
Date:   Thu, 17 Sep 2020 13:08:28 +0100
Message-ID: <20200917120828.12987-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=3
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regmap_debugfs_init the initialisation of the debugfs is delayed
if the root node isn't ready yet. Most callers of regmap_debugfs_init
pass the name from the regmap_config, which is considered temporary
ie. may be unallocated after the regmap_init call returns. This leads
to a potential use after free, where config->name has been freed by
the time it is used in regmap_debugfs_initcall.

This situation can be seen on Zynq, where the architecture init_irq
callback registers a syscon device, using a local variable for the
regmap_config. As init_irq is very early in the platform bring up the
regmap debugfs root isn't ready yet. Although this doesn't crash it
does result in the debugfs entry not having the correct name.

Regmap already sets map->name from config->name on the regmap_init
path and the fact that a separate field is used to pass the name
to regmap_debugfs_init appears to be an artifact of the debugfs
name being added before the map name. As such this patch updates
regmap_debugfs_init to use map->name, which is already duplicated from
the config avoiding the issue.

This does however leave two lose ends, both regmap_attach_dev and
regmap_reinit_cache can be called after a regmap is registered and
would have had the effect of applying a new name to the debugfs
entries. In both of these cases it was chosen to update the map
name. In the case of regmap_attach_dev there are 3 users that
currently use this function to update the name, thus doing so avoids
changes for those users and it seems reasonable that attaching
a device would want to set the name of the map. In the case of
regmap_reinit_cache the primary use-case appears to be devices that
need some register access to identify the device (for example devices
in the same family) and then update the cache to match the exact
hardware. Whilst no users do currently update the name here, given the
use-case it seemed reasonable the name might want to be updated once
the device is better identified.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/internal.h       |  4 ++--
 drivers/base/regmap/regmap-debugfs.c |  7 +++---
 drivers/base/regmap/regmap.c         | 44 +++++++++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 8a59359e145f6..e7ab94cc327a9 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -220,7 +220,7 @@ struct regmap_field {
 
 #ifdef CONFIG_DEBUG_FS
 extern void regmap_debugfs_initcall(void);
-extern void regmap_debugfs_init(struct regmap *map, const char *name);
+extern void regmap_debugfs_init(struct regmap *map);
 extern void regmap_debugfs_exit(struct regmap *map);
 
 static inline void regmap_debugfs_disable(struct regmap *map)
@@ -230,7 +230,7 @@ static inline void regmap_debugfs_disable(struct regmap *map)
 
 #else
 static inline void regmap_debugfs_initcall(void) { }
-static inline void regmap_debugfs_init(struct regmap *map, const char *name) { }
+static inline void regmap_debugfs_init(struct regmap *map) { }
 static inline void regmap_debugfs_exit(struct regmap *map) { }
 static inline void regmap_debugfs_disable(struct regmap *map) { }
 #endif
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f58baff2be0af..b6d63ef16b442 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -17,7 +17,6 @@
 
 struct regmap_debugfs_node {
 	struct regmap *map;
-	const char *name;
 	struct list_head link;
 };
 
@@ -544,11 +543,12 @@ static const struct file_operations regmap_cache_bypass_fops = {
 	.write = regmap_cache_bypass_write_file,
 };
 
-void regmap_debugfs_init(struct regmap *map, const char *name)
+void regmap_debugfs_init(struct regmap *map)
 {
 	struct rb_node *next;
 	struct regmap_range_node *range_node;
 	const char *devname = "dummy";
+	const char *name = map->name;
 
 	/*
 	 * Userspace can initiate reads from the hardware over debugfs.
@@ -569,7 +569,6 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		if (!node)
 			return;
 		node->map = map;
-		node->name = name;
 		mutex_lock(&regmap_debugfs_early_lock);
 		list_add(&node->link, &regmap_debugfs_early_list);
 		mutex_unlock(&regmap_debugfs_early_lock);
@@ -679,7 +678,7 @@ void regmap_debugfs_initcall(void)
 
 	mutex_lock(&regmap_debugfs_early_lock);
 	list_for_each_entry_safe(node, tmp, &regmap_debugfs_early_list, link) {
-		regmap_debugfs_init(node->map, node->name);
+		regmap_debugfs_init(node->map);
 		list_del(&node->link);
 		kfree(node);
 	}
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2807e544658e0..4876e5f543c70 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -581,14 +581,34 @@ static void regmap_range_exit(struct regmap *map)
 	kfree(map->selector_work_buf);
 }
 
+static int regmap_set_name(struct regmap *map, const struct regmap_config *config)
+{
+	if (config->name) {
+		const char *name = kstrdup_const(config->name, GFP_KERNEL);
+
+		if (!name)
+			return -ENOMEM;
+
+		kfree_const(map->name);
+		map->name = name;
+	}
+
+	return 0;
+}
+
 int regmap_attach_dev(struct device *dev, struct regmap *map,
 		      const struct regmap_config *config)
 {
 	struct regmap **m;
+	int ret;
 
 	map->dev = dev;
 
-	regmap_debugfs_init(map, config->name);
+	ret = regmap_set_name(map, config);
+	if (ret)
+		return ret;
+
+	regmap_debugfs_init(map);
 
 	/* Add a devres resource for dev_get_regmap() */
 	m = devres_alloc(dev_get_regmap_release, sizeof(*m), GFP_KERNEL);
@@ -674,9 +694,9 @@ struct regmap *__regmap_init(struct device *dev,
 			     const char *lock_name)
 {
 	struct regmap *map;
-	int ret = -EINVAL;
 	enum regmap_endian reg_endian, val_endian;
 	int i, j;
+	int ret;
 
 	if (!config)
 		goto err;
@@ -687,13 +707,9 @@ struct regmap *__regmap_init(struct device *dev,
 		goto err;
 	}
 
-	if (config->name) {
-		map->name = kstrdup_const(config->name, GFP_KERNEL);
-		if (!map->name) {
-			ret = -ENOMEM;
-			goto err_map;
-		}
-	}
+	ret = regmap_set_name(map, config);
+	if (ret)
+		goto err_map;
 
 	if (config->disable_locking) {
 		map->lock = map->unlock = regmap_lock_unlock_none;
@@ -1140,7 +1156,7 @@ struct regmap *__regmap_init(struct device *dev,
 		if (ret != 0)
 			goto err_regcache;
 	} else {
-		regmap_debugfs_init(map, config->name);
+		regmap_debugfs_init(map);
 	}
 
 	return map;
@@ -1300,6 +1316,8 @@ EXPORT_SYMBOL_GPL(regmap_field_free);
  */
 int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 {
+	int ret;
+
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 
@@ -1312,7 +1330,11 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
-	regmap_debugfs_init(map, config->name);
+	ret = regmap_set_name(map, config);
+	if (ret)
+		return ret;
+
+	regmap_debugfs_init(map);
 
 	map->cache_bypass = false;
 	map->cache_only = false;
-- 
2.11.0

