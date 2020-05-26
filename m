Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15B1B391E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDVHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgDVHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3A1C03C1A7;
        Wed, 22 Apr 2020 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9d087VRJja++jpuP4Z1KHBbq7Jtf1llG29rqp/RmNSo=; b=LccKO8vZ7mCgDsTwBSEcrmfIv/
        RgWqyMGcaxeCi8gTNub+b6asakVXkhzI92WMlbWv8FLqEvaFu5c1si2w4BwoOpxxumZfVcFuUYWp7
        KsjWCDMlgJtRyJknc6bhxFBZGHA6uiBaiaxG8TM96QBHphd7l/SX6wjukfPkV8fy27p7GHTyGyv/V
        +eXS72q7FfYNPu569HU7dSs7JU/86KoXSj2IfyqAnLtLVS9RX0XfmIAlgSgSlSohfoKDuirnyFeDy
        6utwx47RnmnLdiKDVqr53I2UeoTNpTrZj33nhYUr9tLNs9siLPnEqdbfZ7shcMRIatIF1pUlZXIwb
        giZANDUA==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yQ-0000CO-Fo; Wed, 22 Apr 2020 07:39:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] bdi: remove bdi_register_owner
Date:   Wed, 22 Apr 2020 09:38:49 +0200
Message-Id: <20200422073851.303714-8-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out a new bdi_set_owner helper to set the owner, and move the policy
for creating the bdi name back into genhd.c, where it belongs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c               |  8 +++++---
 include/linux/backing-dev.h |  2 +-
 mm/backing-dev.c            | 12 ++----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..7d10cfc38c70 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -840,13 +840,15 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
+		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
+		struct device *dev = disk_to_dev(disk);
 		int ret;
 
 		/* Register BDI before referencing it from bdev */
-		disk_to_dev(disk)->devt = devt;
-		ret = bdi_register_owner(disk->queue->backing_dev_info,
-						disk_to_dev(disk));
+		dev->devt = devt;
+		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
+		bdi_set_owner(bdi, dev);
 		blk_register_region(disk_devt(disk), disk->minors, NULL,
 				    exact_match, exact_lock, disk);
 	}
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c9ad5c3b7b4b..4098ed6ba6b4 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -33,7 +33,7 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
 __printf(2, 0)
 int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
 		    va_list args);
-int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
+void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index eb6b51e49d11..bb993f99d424 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -977,20 +977,12 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 }
 EXPORT_SYMBOL(bdi_register);
 
-int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
+void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner)
 {
-	int rc;
-
-	rc = bdi_register(bdi, "%u:%u", MAJOR(owner->devt), MINOR(owner->devt));
-	if (rc)
-		return rc;
-	/* Leaking owner reference... */
-	WARN_ON(bdi->owner);
+	WARN_ON_ONCE(bdi->owner);
 	bdi->owner = owner;
 	get_device(owner);
-	return 0;
 }
-EXPORT_SYMBOL(bdi_register_owner);
 
 /*
  * Remove bdi from bdi_list, and ensure that it is no longer visible
-- 
2.26.1

