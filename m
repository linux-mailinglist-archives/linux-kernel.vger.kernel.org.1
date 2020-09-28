Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEB27B1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgI1Qf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1QfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E1C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s31so1322179pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uhV9FbhFzcIeQA7/8itpaMiUW3+R2wmKNKtzK5dqCs=;
        b=eLp58MgKFDC8ooYfcBKgfgoC8G9TGGGsTiscFJ/UPULzDzfYWftqG8pqiHDSRhkRnI
         q2t5MXMJg5C2kJnV/Tb1p5Emtj95mL3scE2xgmFm3NDFWaBPnA5aItFGny3AULySpHba
         B8dQPj0JpKz2ULMcI758KZ09KA4Apilu/33ScI1jbWt6ztnswNdaZkuYA5VRdiT8pl7e
         YYPtVyIRWcXwNu97UNeMAiCa59AxmK0N+F6WoVJUI+sg6M3Frxy2tfgXS2fG8jAuWgtQ
         kK8MjRpW8X+nnfMG3Kd8uXYNB1S/PfcxZ+yp6eH0nKe9AgJsTfIdzQJ3eO6SHnhjkbts
         orDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uhV9FbhFzcIeQA7/8itpaMiUW3+R2wmKNKtzK5dqCs=;
        b=UHfWLtXrgSzSptDTDly8UUrNC8f9nkR8qQwP2dNUNy5iROGSN1P31KMSnwDugxls/q
         Spa9rbadzcsoGQFMKSUfyRWZ/QBlMFgajkaZk3PlGgh4kBmL2rJ9HR60PjyQ+CID78Up
         ikbHLpOiqz2gfHnMEQbi5+Q0ufys7Z0yZuiHomSs4giAkT066OPV67KcJnCqNYdlqu26
         qVZgHfNsVXR/X8xBvrYmBsMXYqE+Q3Zt2QGcPIWkns2AS+JiCf/trOJQ+pWoW/pEiOA6
         u6pqIrfBV/exBRAyt0hTkWrh8nLDLXHZPj9/lrS6vu+RCErjdpDId7WZQlFtINv8+STt
         Xf/w==
X-Gm-Message-State: AOAM5306GUCPoDIyQT9KkfqjtND4yV42STTSyLw/wDUdEJYyqJCsALfz
        BB2PBDQBO/4Wnip4RhrRe8ocMmjSvD2yhQ==
X-Google-Smtp-Source: ABdhPJxUr7s+Tln57fdPUapsg6If3k+BJojIGBOTCtkV+KH3vwliAqU0Uc+8lxxS1EDP0A+HXQLU2Q==
X-Received: by 2002:a05:6a00:792:b029:13c:1611:652d with SMTP id g18-20020a056a000792b029013c1611652dmr235509pfu.13.1601310920056;
        Mon, 28 Sep 2020 09:35:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] coresight: Export global symbols
Date:   Mon, 28 Sep 2020 10:34:53 -0600
Message-Id: <20200928163513.70169-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Export symbols used among coresight modules.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 drivers/hwtracing/coresight/coresight-sysfs.c    | 2 ++
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 6 ++++++
 drivers/hwtracing/coresight/coresight.c          | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index b4e5758b6c12..644805e0a9ec 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -525,6 +525,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(etm_perf_symlink);
 
 static ssize_t etm_perf_sink_name_show(struct device *dev,
 				       struct device_attribute *dattr,
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 82afeaf2ccc4..34d2a2d31d00 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -102,6 +102,7 @@ int coresight_add_sysfs_link(struct coresight_sysfs_link *info)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(coresight_add_sysfs_link);
 
 void coresight_remove_sysfs_link(struct coresight_sysfs_link *info)
 {
@@ -122,6 +123,7 @@ void coresight_remove_sysfs_link(struct coresight_sysfs_link *info)
 	info->orig->nr_links--;
 	info->target->nr_links--;
 }
+EXPORT_SYMBOL_GPL(coresight_remove_sysfs_link);
 
 /*
  * coresight_make_links: Make a link for a connection from a @orig
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b29c2db94d96..ad991a37e2d2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -255,6 +255,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
 	tmc_free_table_pages(sg_table);
 	tmc_free_data_pages(sg_table);
 }
+EXPORT_SYMBOL_GPL(tmc_free_sg_table);
 
 /*
  * Alloc pages for the table. Since this will be used by the device,
@@ -340,6 +341,7 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
 
 	return sg_table;
 }
+EXPORT_SYMBOL_GPL(tmc_alloc_sg_table);
 
 /*
  * tmc_sg_table_sync_data_range: Sync the data buffer written
@@ -360,6 +362,7 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 					PAGE_SIZE, DMA_FROM_DEVICE);
 	}
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_sync_data_range);
 
 /* tmc_sg_sync_table: Sync the page table */
 void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
@@ -372,6 +375,7 @@ void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
 		dma_sync_single_for_device(real_dev, table_pages->daddrs[i],
 					   PAGE_SIZE, DMA_TO_DEVICE);
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_sync_table);
 
 /*
  * tmc_sg_table_get_data: Get the buffer pointer for data @offset
@@ -401,6 +405,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 		*bufpp = page_address(data_pages->pages[pg_idx]) + pg_offset;
 	return len;
 }
+EXPORT_SYMBOL_GPL(tmc_sg_table_get_data);
 
 #ifdef ETR_SG_DEBUG
 /* Map a dma address to virtual address */
@@ -766,6 +771,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(tmc_etr_get_catu_device);
 
 static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
 				      struct etr_buf *etr_buf)
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index ae40bb0539fd..d1aea3a1e7b6 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -54,6 +54,7 @@ static struct list_head *stm_path;
  * it needs to look for another sync sequence.
  */
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static int coresight_id_match(struct device *dev, void *data)
 {
@@ -179,6 +180,7 @@ int coresight_claim_device_unlocked(void __iomem *base)
 	coresight_clear_claim_tags(base);
 	return -EBUSY;
 }
+EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
 
 int coresight_claim_device(void __iomem *base)
 {
@@ -190,6 +192,7 @@ int coresight_claim_device(void __iomem *base)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(coresight_claim_device);
 
 /*
  * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
@@ -208,6 +211,7 @@ void coresight_disclaim_device_unlocked(void __iomem *base)
 		 */
 		WARN_ON_ONCE(1);
 }
+EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
 
 void coresight_disclaim_device(void __iomem *base)
 {
@@ -215,6 +219,7 @@ void coresight_disclaim_device(void __iomem *base)
 	coresight_disclaim_device_unlocked(base);
 	CS_LOCK(base);
 }
+EXPORT_SYMBOL_GPL(coresight_disclaim_device);
 
 /* enable or disable an associated CTI device of the supplied CS device */
 static int
@@ -467,6 +472,7 @@ void coresight_disable_path(struct list_head *path)
 {
 	coresight_disable_path_from(path, NULL);
 }
+EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 {
@@ -1368,6 +1374,7 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout);
 
 struct bus_type coresight_bustype = {
 	.name	= "coresight",
@@ -1544,6 +1551,7 @@ bool coresight_loses_context_with_cpu(struct device *dev)
 	return fwnode_property_present(dev_fwnode(dev),
 				       "arm,coresight-loses-context-with-cpu");
 }
+EXPORT_SYMBOL_GPL(coresight_loses_context_with_cpu);
 
 /*
  * coresight_alloc_device_name - Get an index for a given device in the
-- 
2.25.1

