Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5103F290662
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408157AbgJPNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408038AbgJPNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B8C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6rGz36Vtlfw7EkGgl9l4CBXH5pAplmMk9SI4xtAvwFM=; b=k9Ma1pm1w+1L/wXVMJ7D2XgBd7
        x810YT9YFItZ0ptHm8XKM2iqw7p0JOMvh9qV5CT1GcdihOqGMJn+ECgGtPbIO7GifnV3AFUlpY6sR
        JA+v4j0y5qYv8zL8HHVl6GzzISTzCRamvdC34FwUq/RpPxEvfGkebEf90C2lTkDrPE/MXysQThhQu
        lzm0e4F6BLntp2FVt/ACSPwEBU5QWLkFg5gwFtDUJ1Tnt2uF3gICq2z6yAcC/Qonskxa79EHfeZSF
        +7v78lc9dzGtRnl6QQDy6Zt6WrEH14LOSsf8pYgF91wRyJyyTH0Dn07LLbF6UJ7e7u5eLqcelBtKV
        YHGt6aoQ==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPrr-0003UU-Af; Fri, 16 Oct 2020 13:33:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] pstore/blk: simplify the block device open / close path
Date:   Fri, 16 Oct 2020 15:20:43 +0200
Message-Id: <20201016132047.3068029-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the pointless psblk_get_bdev and psblk_put_bdev helper,
and don't bother holding pstore_blk_lock over the block device
open / close interactions given that they only happen first thing
during module init and last thing during module exit.  Also don't
bother with unregistering a zone info that did not come from the
actually block backed code, as users like mtd have to unregister
it themselves already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/blk.c | 156 ++++++++++++------------------------------------
 1 file changed, 38 insertions(+), 118 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 3a2214ecf942ae..a8aa56cba96d59 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -91,12 +91,6 @@ static DEFINE_MUTEX(pstore_blk_lock);
 static struct block_device *psblk_bdev;
 static struct pstore_zone_info *pstore_zone_info;
 
-struct bdev_info {
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
-
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
 	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
@@ -205,75 +199,6 @@ void unregister_pstore_device(struct pstore_device_info *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_device);
 
-/**
- * psblk_get_bdev() - open block device
- *
- * @holder:	Exclusive holder identifier
- * @info:	Information about bdev to fill in
- *
- * Return: pointer to block device on success and others on error.
- *
- * On success, the returned block_device has reference count of one.
- */
-static struct block_device *psblk_get_bdev(void *holder,
-					   struct bdev_info *info)
-{
-	struct block_device *bdev = ERR_PTR(-ENODEV);
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-	sector_t nr_sects;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (pstore_zone_info)
-		return ERR_PTR(-EBUSY);
-
-	if (!blkdev[0])
-		return ERR_PTR(-ENODEV);
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	bdev = blkdev_get_by_path(blkdev, mode, holder);
-	if (IS_ERR(bdev)) {
-		dev_t devt;
-
-		devt = name_to_dev_t(blkdev);
-		if (devt == 0)
-			return ERR_PTR(-ENODEV);
-		bdev = blkdev_get_by_dev(devt, mode, holder);
-		if (IS_ERR(bdev))
-			return bdev;
-	}
-
-	nr_sects = part_nr_sects_read(bdev->bd_part);
-	if (!nr_sects) {
-		pr_err("not enough space for '%s'\n", blkdev);
-		blkdev_put(bdev, mode);
-		return ERR_PTR(-ENOSPC);
-	}
-
-	if (info) {
-		info->devt = bdev->bd_dev;
-		info->nr_sects = nr_sects;
-		info->start_sect = get_start_sect(bdev);
-	}
-
-	return bdev;
-}
-
-static void psblk_put_bdev(struct block_device *bdev, void *holder)
-{
-	fmode_t mode = FMODE_READ | FMODE_WRITE;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (!bdev)
-		return;
-
-	if (holder)
-		mode |= FMODE_EXCL;
-	blkdev_put(bdev, mode);
-}
-
 static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
 {
 	struct block_device *bdev = psblk_bdev;
@@ -340,29 +265,39 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 	return ret;
 }
 
-static int __register_pstore_blk(void)
+static int __init pstore_blk_init(void)
 {
 	char bdev_name[BDEVNAME_SIZE];
 	struct block_device *bdev;
 	struct pstore_device_info dev;
-	struct bdev_info binfo;
-	void *holder = blkdev;
 	int ret = -ENODEV;
-
-	lockdep_assert_held(&pstore_blk_lock);
+	fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
+	sector_t nr_sects;
+	
+	if (!best_effort || !blkdev[0])
+		return 0;
 
 	/* hold bdev exclusively */
-	memset(&binfo, 0, sizeof(binfo));
-	bdev = psblk_get_bdev(holder, &binfo);
+	bdev = blkdev_get_by_path(blkdev, mode, blkdev);
 	if (IS_ERR(bdev)) {
-		pr_err("failed to open '%s'!\n", blkdev);
-		return PTR_ERR(bdev);
+		dev_t devt;
+
+		devt = name_to_dev_t(blkdev);
+		if (devt == 0) {
+			pr_err("failed to open '%s'!\n", blkdev);
+			return -ENODEV;
+		}
+		bdev = blkdev_get_by_dev(devt, mode, blkdev);
+		if (IS_ERR(bdev)) {
+			pr_err("failed to open '%s'!\n", blkdev);
+			return PTR_ERR(bdev);
+		}
 	}
 
-	/* only allow driver matching the @blkdev */
-	if (!binfo.devt) {
-		pr_debug("no major\n");
-		ret = -ENODEV;
+	nr_sects = part_nr_sects_read(bdev->bd_part);
+	if (!nr_sects) {
+		pr_err("not enough space for '%s'\n", blkdev);
+		ret = -ENOSPC;
 		goto err_put_bdev;
 	}
 
@@ -370,11 +305,11 @@ static int __register_pstore_blk(void)
 	psblk_bdev = bdev;
 
 	memset(&dev, 0, sizeof(dev));
-	dev.total_size = binfo.nr_sects << SECTOR_SHIFT;
+	dev.total_size = nr_sects << SECTOR_SHIFT;
 	dev.read = psblk_generic_blk_read;
 	dev.write = psblk_generic_blk_write;
 
-	ret = __register_pstore_device(&dev);
+	ret = register_pstore_device(&dev);
 	if (ret)
 		goto err_put_bdev;
 
@@ -383,10 +318,22 @@ static int __register_pstore_blk(void)
 	return 0;
 
 err_put_bdev:
+	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
 	psblk_bdev = NULL;
-	psblk_put_bdev(bdev, holder);
 	return ret;
 }
+late_initcall(pstore_blk_init);
+
+static void __exit pstore_blk_exit(void)
+{
+	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
+
+	if (!psblk_bdev)
+		return;
+	unregister_pstore_device(&dev);
+	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+}
+module_exit(pstore_blk_exit);
 
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
@@ -402,33 +349,6 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_get_config);
 
-static int __init pstore_blk_init(void)
-{
-	int ret = 0;
-
-	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0])
-		ret = __register_pstore_blk();
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-late_initcall(pstore_blk_init);
-
-static void __exit pstore_blk_exit(void)
-{
-	struct pstore_device_info dev = { };
-
-	mutex_lock(&pstore_blk_lock);
-	if (pstore_zone_info)
-		dev.read = pstore_zone_info->read;
-	__unregister_pstore_device(&dev);
-	if (psblk_bdev)
-		psblk_put_bdev(psblk_bdev, blkdev);
-	mutex_unlock(&pstore_blk_lock);
-}
-module_exit(pstore_blk_exit);
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
-- 
2.28.0

