Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E329066D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408315AbgJPNib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408111AbgJPNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:38:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CD9C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZypQjGkdIffTUSz8GDPwgMrTfenFsfWw248Bj4GysnY=; b=c/I5Y/3MBbt6zQsy/HFw6qXfa2
        NgRw/XkxKjv65tqS8fi/btrS7ZS05lZQpwPkvQRmi3mf3MPHQsuVoiJOYI+u13cVtLegCnBz1P8tV
        m1KNt7u186MPbFWfoFop8VZ8yAvCpMpbFrLafOT+n52vA988INdtkzvvAS9eMwGd9G5OCBFk/F7N+
        bPjF0tDvxgxovd13XxTouTp/cppWGx7Tsvu6mGi71uWTAOcirgrIsZiLUgQmE8pfkos4vbKzR5OVa
        rkZwLBf014TGBRkuCYDBt717AT1vqEuXKBEvVzXAKuOPAxFEUKyEnbfu78ZVdxigUFI0S7/Li5afH
        YRj9AmUQ==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPw6-0003kO-Cy; Fri, 16 Oct 2020 13:38:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] pstore/blk: remove struct pstore_device_info
Date:   Fri, 16 Oct 2020 15:20:45 +0200
Message-Id: <20201016132047.3068029-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total_size and flags are only needed at registrations time, so just
pass them to register_pstore_device directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtdpstore.c    | 10 ++--
 fs/pstore/blk.c            | 98 ++++++++++++++++----------------------
 include/linux/pstore_blk.h | 21 ++------
 3 files changed, 47 insertions(+), 82 deletions(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 232ba5c39c2a55..88d0305ca27336 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -12,7 +12,6 @@
 static struct mtdpstore_context {
 	int index;
 	struct pstore_blk_config info;
-	struct pstore_device_info dev;
 	struct mtd_info *mtd;
 	unsigned long *rmmap;		/* removed bit map */
 	unsigned long *usedmap;		/* used bit map */
@@ -431,12 +430,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
 
-	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
-	cxt->dev.flags = PSTORE_FLAGS_DMESG;
-	cxt->dev.ops = &mtdpstore_ops;
-
-	ret = register_pstore_device(&cxt->dev);
+	ret = register_pstore_device(&mtdpstore_ops, mtd->size,
+				     PSTORE_FLAGS_DMESG);
 	if (ret) {
 		dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
 				mtd->index);
@@ -531,7 +527,7 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 
 	mtdpstore_flush_removed(cxt);
 
-	unregister_pstore_device(&cxt->dev);
+	unregister_pstore_device(&mtdpstore_ops);
 	kfree(cxt->badmap);
 	kfree(cxt->usedmap);
 	kfree(cxt->rmmap);
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index f7c7f325e42c71..0430b190a1df2a 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -102,27 +102,40 @@ static struct pstore_zone_info *pstore_zone_info;
 	_##name_;						\
 })
 
-static int __register_pstore_device(struct pstore_device_info *dev)
+/**
+ * register_pstore_device() - register device to pstore/blk
+ *
+ * @ops:	operations to access the device.
+ * @total_size: The total size in bytes pstore/blk can use. It must be greater
+ *		than 4096 and be multiple of 4096.
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
+ */
+int register_pstore_device(const struct pstore_zone_ops *ops,
+		unsigned long total_size, unsigned int flags)
 {
 	int ret;
 
-	lockdep_assert_held(&pstore_blk_lock);
-
-	if (!dev || !dev->total_size || !dev->ops ||
-	    !dev->ops->read || !dev->ops->write)
+	if (!ops || !ops->read || !ops->write || !total_size)
 		return -EINVAL;
 
 	/* someone already registered before */
-	if (pstore_zone_info)
-		return -EBUSY;
+	mutex_lock(&pstore_blk_lock);
+	if (pstore_zone_info) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 
 	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
-	if (!pstore_zone_info)
-		return -ENOMEM;
+	if (!pstore_zone_info) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	/* zero means not limit on which backends to attempt to store. */
-	if (!dev->flags)
-		dev->flags = UINT_MAX;
+	if (!flags)
+		flags = UINT_MAX;
 
 #define verify_size(name, alignsize, enabled) {				\
 		long _##name_;						\
@@ -134,63 +147,40 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 		pstore_zone_info->name = _##name_;			\
 	}
 
-	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
-	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
-	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
-	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
+	verify_size(kmsg_size, 4096, flags & PSTORE_FLAGS_DMESG);
+	verify_size(pmsg_size, 4096, flags & PSTORE_FLAGS_PMSG);
+	verify_size(console_size, 4096, flags & PSTORE_FLAGS_CONSOLE);
+	verify_size(ftrace_size, 4096, flags & PSTORE_FLAGS_FTRACE);
 #undef verify_size
 
-	pstore_zone_info->total_size = dev->total_size;
+	pstore_zone_info->total_size = total_size;
 	pstore_zone_info->max_reason = max_reason;
-	pstore_zone_info->ops = dev->ops;
+	pstore_zone_info->ops = ops;
 
 	ret = register_pstore_zone(pstore_zone_info);
 	if (ret) {
 		kfree(pstore_zone_info);
 		pstore_zone_info = NULL;
 	}
+out_unlock:
+	mutex_unlock(&pstore_blk_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(register_pstore_device);
+
 /**
- * register_pstore_device() - register non-block device to pstore/blk
- *
- * @dev: non-block device information
+ * unregister_pstore_device() - unregister a device from pstore/blk
  *
- * Return:
- * * 0		- OK
- * * Others	- something error.
+ * @ops: device operations
  */
-int register_pstore_device(struct pstore_device_info *dev)
+void unregister_pstore_device(const struct pstore_zone_ops *ops)
 {
-	int ret;
-
 	mutex_lock(&pstore_blk_lock);
-	ret = __register_pstore_device(dev);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_pstore_device);
-
-static void __unregister_pstore_device(struct pstore_device_info *dev)
-{
-	lockdep_assert_held(&pstore_blk_lock);
-	if (pstore_zone_info && pstore_zone_info->ops == dev->ops) {
+	if (pstore_zone_info && pstore_zone_info->ops == ops) {
 		unregister_pstore_zone(pstore_zone_info);
 		kfree(pstore_zone_info);
 		pstore_zone_info = NULL;
 	}
-}
-
-/**
- * unregister_pstore_device() - unregister non-block device from pstore/blk
- *
- * @dev: non-block device information
- */
-void unregister_pstore_device(struct pstore_device_info *dev)
-{
-	mutex_lock(&pstore_blk_lock);
-	__unregister_pstore_device(dev);
 	mutex_unlock(&pstore_blk_lock);
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_device);
@@ -271,7 +261,6 @@ static int __init pstore_blk_init(void)
 {
 	char bdev_name[BDEVNAME_SIZE];
 	struct block_device *bdev;
-	struct pstore_device_info dev;
 	int ret = -ENODEV;
 	fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
 	sector_t nr_sects;
@@ -306,11 +295,8 @@ static int __init pstore_blk_init(void)
 	/* psblk_bdev must be assigned before register to pstore/blk */
 	psblk_bdev = bdev;
 
-	memset(&dev, 0, sizeof(dev));
-	dev.ops = &pstore_blk_zone_ops;
-	dev.total_size = nr_sects << SECTOR_SHIFT;
-
-	ret = register_pstore_device(&dev);
+	ret = register_pstore_device(&pstore_blk_zone_ops,
+			nr_sects << SECTOR_SHIFT, 0);
 	if (ret)
 		goto err_put_bdev;
 
@@ -327,11 +313,9 @@ late_initcall(pstore_blk_init);
 
 static void __exit pstore_blk_exit(void)
 {
-	struct pstore_device_info dev = { .ops = &pstore_blk_zone_ops };
-
 	if (!psblk_bdev)
 		return;
-	unregister_pstore_device(&dev);
+	unregister_pstore_device(&pstore_blk_zone_ops);
 	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
 }
 module_exit(pstore_blk_exit);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 095a44ce5e122c..0abd412a6cb3e3 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -7,24 +7,9 @@
 #include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
-/**
- * struct pstore_device_info - back-end pstore/blk driver structure.
- *
- * @total_size: The total size in bytes pstore/blk can use. It must be greater
- *		than 4096 and be multiple of 4096.
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all backends for compatible.
- * @ops:	operations to access the device.
- */
-struct pstore_device_info {
-	unsigned long total_size;
-	unsigned int flags;
-	const struct pstore_zone_ops *ops;
-};
-
-int  register_pstore_device(struct pstore_device_info *dev);
-void unregister_pstore_device(struct pstore_device_info *dev);
+int register_pstore_device(const struct pstore_zone_ops *ops,
+		unsigned long total_size, unsigned int flags);
+void unregister_pstore_device(const struct pstore_zone_ops *ops);
 
 /**
  * struct pstore_blk_config - the pstore_blk backend configuration
-- 
2.28.0

