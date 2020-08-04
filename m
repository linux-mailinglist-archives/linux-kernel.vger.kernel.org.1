Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EC23B562
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgHDHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:09:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:60927 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHDHJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:09:00 -0400
IronPort-SDR: jP4ToGBPNGlWqoPGIn2w/DlWGeiR+3ocM9OvN4IpnxXlNyxdqzO5iaCuHvHzb8Nkjn26tLpT0t
 Cbh1sujWBKvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213801919"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="213801919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 00:08:59 -0700
IronPort-SDR: 9TMleVmY86XZaGgMcxMrtmTEbCUGTg/pBuOhjvjL4jIiPhNaaN4cr4W7NVp3jdi3m9z8IJpQ7f
 1Oqvoe8iaz2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="315226116"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2020 00:08:58 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: [PATCH v3 1/4] fpga: dfl: change data type of feature id to u16
Date:   Tue,  4 Aug 2020 15:05:12 +0800
Message-Id: <1596524715-18038-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature id is stored in a 12 bit field in DFH. So a u16 variable is
enough for feature id.

This patch changes all feature id related places to fit u16.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: no change.
---
 drivers/fpga/dfl-fme-perf.c |  2 +-
 drivers/fpga/dfl.c          | 29 +++++++++++++++--------------
 drivers/fpga/dfl.h          | 10 +++++-----
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 6ce1ed2..5312662 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -148,7 +148,7 @@ struct fme_perf_priv {
 	struct device *dev;
 	void __iomem *ioaddr;
 	struct pmu pmu;
-	u64 id;
+	u16 id;
 
 	u32 fab_users;
 	u32 fab_port_id;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 649958a..18575d9 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -58,7 +58,7 @@ static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
  */
 struct dfl_dev_info {
 	const char *name;
-	u32 dfh_id;
+	u16 dfh_id;
 	struct idr id;
 	enum dfl_fpga_devt_type devt_type;
 };
@@ -134,7 +134,7 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
 	return DFL_ID_MAX;
 }
 
-static enum dfl_id_type dfh_id_to_type(u32 id)
+static enum dfl_id_type dfh_id_to_type(u16 id)
 {
 	int i;
 
@@ -454,7 +454,7 @@ struct build_feature_devs_info {
  * @nr_irqs: number of irqs of this sub feature.
  */
 struct dfl_feature_info {
-	u64 fid;
+	u16 fid;
 	struct resource mmio_res;
 	void __iomem *ioaddr;
 	struct list_head node;
@@ -649,7 +649,7 @@ static inline u32 feature_size(void __iomem *start)
 	return ofst ? ofst : 4096;
 }
 
-static u64 feature_id(void __iomem *start)
+static u16 feature_id(void __iomem *start)
 {
 	u64 v = readq(start + DFH);
 	u16 id = FIELD_GET(DFH_ID, v);
@@ -667,7 +667,7 @@ static u64 feature_id(void __iomem *start)
 }
 
 static int parse_feature_irqs(struct build_feature_devs_info *binfo,
-			      resource_size_t ofst, u64 fid,
+			      resource_size_t ofst, u16 fid,
 			      unsigned int *irq_base, unsigned int *nr_irqs)
 {
 	void __iomem *base = binfo->ioaddr + ofst;
@@ -713,12 +713,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		return 0;
 	}
 
-	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
+	dev_dbg(binfo->dev, "feature: 0x%x, irq_base: %u, nr_irqs: %u\n",
 		fid, ibase, inr);
 
 	if (ibase + inr > binfo->nr_irqs) {
 		dev_err(binfo->dev,
-			"Invalid interrupt number in feature 0x%llx\n", fid);
+			"Invalid interrupt number in feature 0x%x\n", fid);
 		return -EINVAL;
 	}
 
@@ -726,7 +726,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		virq = binfo->irq_table[ibase + i];
 		if (virq < 0 || virq > NR_IRQS) {
 			dev_err(binfo->dev,
-				"Invalid irq table entry for feature 0x%llx\n",
+				"Invalid irq table entry for feature 0x%x\n",
 				fid);
 			return -EINVAL;
 		}
@@ -748,7 +748,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 static int
 create_feature_instance(struct build_feature_devs_info *binfo,
 			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
-			resource_size_t size, u64 fid)
+			resource_size_t size, u16 fid)
 {
 	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
@@ -819,9 +819,10 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     struct dfl_fpga_enum_dfl *dfl,
 			     resource_size_t ofst)
 {
-	u32 id, offset;
-	u64 v;
 	int ret = 0;
+	u32 offset;
+	u16 id;
+	u64 v;
 
 	v = readq(dfl->ioaddr + ofst + DFH);
 	id = FIELD_GET(DFH_ID, v);
@@ -855,8 +856,8 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
 				 resource_size_t ofst)
 {
 	if (!binfo->feature_dev) {
-		dev_err(binfo->dev, "the private feature %llx does not belong to any AFU.\n",
-			(unsigned long long)feature_id(dfl->ioaddr + ofst));
+		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
+			feature_id(dfl->ioaddr + ofst));
 		return -EINVAL;
 	}
 
@@ -1424,7 +1425,7 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
 		return 0;
 
 	feature->irq_ctx[idx].name =
-		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%llx)", idx,
+		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%x)", idx,
 			  dev_name(&pdev->dev), feature->id);
 	if (!feature->irq_ctx[idx].name)
 		return -ENOMEM;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index a32dfba..bc61942 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
  * @id: unique dfl private feature id.
  */
 struct dfl_feature_id {
-	u64 id;
+	u16 id;
 };
 
 /**
@@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
  */
 struct dfl_feature {
 	struct platform_device *dev;
-	u64 id;
+	u16 id;
 	int resource_index;
 	void __iomem *ioaddr;
 	struct dfl_feature_irq_ctx *irq_ctx;
@@ -365,7 +365,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
 
 static inline
-struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
+struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct dfl_feature *feature;
@@ -378,7 +378,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
 }
 
 static inline
-void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
+void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
 {
 	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
 
@@ -389,7 +389,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
 	return NULL;
 }
 
-static inline bool is_dfl_feature_present(struct device *dev, u64 id)
+static inline bool is_dfl_feature_present(struct device *dev, u16 id)
 {
 	return !!dfl_get_feature_ioaddr_by_id(dev, id);
 }
-- 
2.7.4

