Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DE290671
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408053AbgJPNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407429AbgJPNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:40:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410E0C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vSTdjrjTPX4m+sgqaeLeZDZ8JtUm8qruIqzoeX7Yxrw=; b=sJcQb1SagqfTGSeKXTJ8UsB+qI
        TNntJzAoTWq38ljZglq8dlm/CbEnu511bNRjjNBbm+80peVn/exhVUIlRBoIUQs7UVqfkkqqlJvn8
        AZwuX7UDRZ0wkLgWnfAMrwsd/YJOdOdbHuWiwV8qzvlPO0QPZQ9OBIWy0FS1cOmNkmpWmVA2FBvDo
        sw9kq3eEuaC6vhi4oQ92YwTupAfMZ8XpsI2G6aaWUFa2Mi+bZ94SSLtQ2ve0/77KsVTm79eVD0n/6
        j5wzgReAmeKsXspbmbws0zw1d2v/W50ZGx1D9OtTu0pSpUnp1F4MmyYHaaeAIaWW999YzrwX5WNDT
        mdvf01IA==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPyD-0003v1-ED; Fri, 16 Oct 2020 13:40:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] pstore/blk: use the normal block device I/O path
Date:   Fri, 16 Oct 2020 15:20:46 +0200
Message-Id: <20201016132047.3068029-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop poking into block layer internals and just open the block device
file an use kernel_read and kernel_write on it.  Note that this means
the transformation from name_to_dev_t can't be used anymore, and proper
block device file names must be used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/blk.c            | 152 +++++++++++++------------------------
 include/linux/pstore_blk.h |   2 +
 init/main.c                |   4 +
 3 files changed, 57 insertions(+), 101 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 0430b190a1df2a..bd4eadfc9bd795 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -8,15 +8,13 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include "../../block/blk.h"
 #include <linux/blkdev.h>
 #include <linux/string.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
 #include <linux/pstore_blk.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init_syscalls.h>
 #include <linux/mount.h>
-#include <linux/uio.h>
 
 static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
 module_param(kmsg_size, long, 0400);
@@ -88,7 +86,6 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
  * during the register/unregister functions.
  */
 static DEFINE_MUTEX(pstore_blk_lock);
-static struct block_device *psblk_bdev;
 static struct pstore_zone_info *pstore_zone_info;
 
 #define check_size(name, alignsize) ({				\
@@ -185,70 +182,20 @@ void unregister_pstore_device(const struct pstore_zone_ops *ops)
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_device);
 
+static struct file *psblk_file;
+
 static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
 {
-	struct block_device *bdev = psblk_bdev;
-	struct file file;
-	struct kiocb kiocb;
-	struct iov_iter iter;
-	struct kvec iov = {.iov_base = buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-	file_ra_state_init(&file.f_ra, file.f_mapping);
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, READ, &iov, 1, bytes);
-
-	return generic_file_read_iter(&kiocb, &iter);
+	return kernel_read(psblk_file, buf, bytes, &pos);
 }
 
 static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 		loff_t pos)
 {
-	struct block_device *bdev = psblk_bdev;
-	struct iov_iter iter;
-	struct kiocb kiocb;
-	struct file file;
-	ssize_t ret;
-	struct kvec iov = {.iov_base = (void *)buf, .iov_len = bytes};
-
-	if (!bdev)
-		return -ENODEV;
-
 	/* Console/Ftrace backend may handle buffer until flush dirty zones */
 	if (in_interrupt() || irqs_disabled())
 		return -EBUSY;
-
-	memset(&file, 0, sizeof(struct file));
-	file.f_mapping = bdev->bd_inode->i_mapping;
-	file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
-	file.f_inode = bdev->bd_inode;
-
-	init_sync_kiocb(&kiocb, &file);
-	kiocb.ki_pos = pos;
-	iov_iter_kvec(&iter, WRITE, &iov, 1, bytes);
-
-	inode_lock(bdev->bd_inode);
-	ret = generic_write_checks(&kiocb, &iter);
-	if (ret > 0)
-		ret = generic_perform_write(&file, &iter, pos);
-	inode_unlock(bdev->bd_inode);
-
-	if (likely(ret > 0)) {
-		const struct file_operations f_op = {.fsync = blkdev_fsync};
-
-		file.f_op = &f_op;
-		kiocb.ki_pos += ret;
-		ret = generic_write_sync(&kiocb, ret);
-	}
-	return ret;
+	return kernel_write(psblk_file, buf, bytes, &pos);
 }
 
 static const struct pstore_zone_ops pstore_blk_zone_ops = {
@@ -257,68 +204,71 @@ static const struct pstore_zone_ops pstore_blk_zone_ops = {
 	.write		= psblk_generic_blk_write,
 };
 
-static int __init pstore_blk_init(void)
+static int __init __pstore_blk_init(const char *name)
 {
-	char bdev_name[BDEVNAME_SIZE];
-	struct block_device *bdev;
-	int ret = -ENODEV;
-	fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
-	sector_t nr_sects;
-	
+	int ret = -EINVAL;
+
 	if (!best_effort || !blkdev[0])
 		return 0;
 
-	/* hold bdev exclusively */
-	bdev = blkdev_get_by_path(blkdev, mode, blkdev);
-	if (IS_ERR(bdev)) {
-		dev_t devt;
-
-		devt = name_to_dev_t(blkdev);
-		if (devt == 0) {
-			pr_err("failed to open '%s'!\n", blkdev);
-			return -ENODEV;
-		}
-		bdev = blkdev_get_by_dev(devt, mode, blkdev);
-		if (IS_ERR(bdev)) {
-			pr_err("failed to open '%s'!\n", blkdev);
-			return PTR_ERR(bdev);
-		}
+	psblk_file = filp_open(name, O_RDWR | O_DSYNC | O_NOATIME | O_EXCL, 0);
+	if (IS_ERR(psblk_file)) {
+		ret = PTR_ERR(psblk_file);
+		pr_err("failed to open '%s': %d!\n", name, ret);
+		goto out;
 	}
-
-	nr_sects = part_nr_sects_read(bdev->bd_part);
-	if (!nr_sects) {
-		pr_err("not enough space for '%s'\n", blkdev);
-		ret = -ENOSPC;
-		goto err_put_bdev;
+	if (!S_ISBLK(file_inode(psblk_file)->i_mode)) {
+		pr_err("'%s' is not block device!\n", blkdev);
+		goto out_fput;
 	}
 
-	/* psblk_bdev must be assigned before register to pstore/blk */
-	psblk_bdev = bdev;
-
 	ret = register_pstore_device(&pstore_blk_zone_ops,
-			nr_sects << SECTOR_SHIFT, 0);
+			file_inode(psblk_file)->i_bdev->bd_inode->i_size, 0);
 	if (ret)
-		goto err_put_bdev;
+		goto out_fput;
 
-	bdevname(bdev, bdev_name);
-	pr_info("attached %s (no dedicated panic_write!)\n", bdev_name);
+	pr_info("using device '%s'\n", blkdev);
 	return 0;
-
-err_put_bdev:
-	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-	psblk_bdev = NULL;
+out_fput:
+	fput(psblk_file);
+out:
+	psblk_file = NULL;
 	return ret;
 }
+
+#ifdef MODULE
+static int __init pstore_blk_init(void)
+{
+	return __pstore_blk_init(blkdev);
+}
 late_initcall(pstore_blk_init);
 
 static void __exit pstore_blk_exit(void)
 {
-	if (!psblk_bdev)
+	if (!psblk_file)
 		return;
 	unregister_pstore_device(&pstore_blk_zone_ops);
-	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+	fput(psblk_file);
 }
 module_exit(pstore_blk_exit);
+#else /* MODULE */
+/*
+ * During early boot the real root file system hasn't been mounted yet,
+ * and not device nodes are present yet.  Use the same scheme to find
+ * the device that we use for mounting the root file system.
+ */
+void __init pstore_blk_early_init(void)
+{
+	const char devname[] = "/dev/pstore-blk";
+	dev_t dev = name_to_dev_t(blkdev);
+
+	if (!dev)
+		return;
+	init_unlink(devname);
+	init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
+	__pstore_blk_init(devname);
+}
+#endif /* MODULE */
 
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 0abd412a6cb3e3..7c06b9d6740e2a 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -39,4 +39,6 @@ struct pstore_blk_config {
  */
 int pstore_blk_get_config(struct pstore_blk_config *info);
 
+void __init pstore_blk_early_init(void);
+
 #endif
diff --git a/init/main.c b/init/main.c
index 1af84337cb18d5..058cce64f70390 100644
--- a/init/main.c
+++ b/init/main.c
@@ -98,6 +98,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
+#include <linux/pstore_blk.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1524,6 +1525,9 @@ static noinline void __init kernel_init_freeable(void)
 		prepare_namespace();
 	}
 
+	if (IS_BUILTIN(CONFIG_PSTORE_BLK))
+		pstore_blk_early_init();
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the
-- 
2.28.0

