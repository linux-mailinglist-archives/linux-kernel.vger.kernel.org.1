Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E42859FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgJGHzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:55:40 -0400
Received: from verein.lst.de ([213.95.11.211]:36491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbgJGHzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:55:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4280D6736F; Wed,  7 Oct 2020 09:55:37 +0200 (CEST)
Date:   Wed, 7 Oct 2020 09:55:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <20201007075537.GA12531@lst.de>
References: <20201006155220.GA11668@lst.de> <202010070007.8FF59EC42@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010070007.8FF59EC42@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 12:13:27AM -0700, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 05:52:20PM +0200, Christoph Hellwig wrote:
> > Hi WeiXiong, hi Kees,
> > 
> > what is the use case for the code added in commit 17639f67c1d6 
> > ("pstore/blk: Introduce backend for block devices").
> > 
> > This still doesn't have a user, and the API looks really odd to me.
> 
> pstore is a beast. :) The API is there so that a blk device can declare
> its direct support of pstore (specifically, to provide a panic_write
> handler).
> 
> The MTD device does this, but yes, that's a good point, there isn't a
> blk device user of that entry point yet.
> 
> > By our normal kernel rules we should not add new exports without
> > users and this should probably be reverted for the 5.9 release.
> 
> I don't want to revert the entire patch (I'm still using
> __register_pstore_blk by way of pstore/blk's "best_effort" option), but
> I wouldn't object to something like this:

FYI, I'd be much happier with this, which removes the crazy block
device autoprobe, and the completely broken block device read/write
path as well:

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 296d5027787ac2..84d15c53d094c0 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -151,13 +151,7 @@ otherwise KMSG_DUMP_MAX.
 Configurations for driver
 -------------------------
 
-Only a block device driver cares about these configurations. A block device
-driver uses ``register_pstore_blk`` to register to pstore/blk.
-
-.. kernel-doc:: fs/pstore/blk.c
-   :identifiers: register_pstore_blk
-
-A non-block device driver uses ``register_pstore_device`` with
+Device drivers use ``register_pstore_device`` with
 ``struct pstore_device_info`` to register to pstore/blk.
 
 .. kernel-doc:: fs/pstore/blk.c
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index fcd5563dde063c..3a8224c6df24f5 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -88,15 +88,7 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
  * during the register/unregister functions.
  */
 static DEFINE_MUTEX(pstore_blk_lock);
-static struct block_device *psblk_bdev;
 static struct pstore_zone_info *pstore_zone_info;
-static pstore_blk_panic_write_op blkdev_panic_write;
-
-struct bdev_info {
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
 
 #define check_size(name, alignsize) ({				\
 	long _##name_ = (name);					\
@@ -206,267 +198,6 @@ void unregister_pstore_device(struct pstore_device_info *dev)
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
-static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
-{
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
-}
-
-static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
-		loff_t pos)
-{
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
-	/* Console/Ftrace backend may handle buffer until flush dirty zones */
-	if (in_interrupt() || irqs_disabled())
-		return -EBUSY;
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
-}
-
-static ssize_t psblk_blk_panic_write(const char *buf, size_t size,
-		loff_t off)
-{
-	int ret;
-
-	if (!blkdev_panic_write)
-		return -EOPNOTSUPP;
-
-	/* size and off must align to SECTOR_SIZE for block device */
-	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
-			size >> SECTOR_SHIFT);
-	/* try next zone */
-	if (ret == -ENOMSG)
-		return ret;
-	return ret ? -EIO : size;
-}
-
-static int __register_pstore_blk(struct pstore_blk_info *info)
-{
-	char bdev_name[BDEVNAME_SIZE];
-	struct block_device *bdev;
-	struct pstore_device_info dev;
-	struct bdev_info binfo;
-	void *holder = blkdev;
-	int ret = -ENODEV;
-
-	lockdep_assert_held(&pstore_blk_lock);
-
-	/* hold bdev exclusively */
-	memset(&binfo, 0, sizeof(binfo));
-	bdev = psblk_get_bdev(holder, &binfo);
-	if (IS_ERR(bdev)) {
-		pr_err("failed to open '%s'!\n", blkdev);
-		return PTR_ERR(bdev);
-	}
-
-	/* only allow driver matching the @blkdev */
-	if (!binfo.devt || (!best_effort &&
-			    MAJOR(binfo.devt) != info->major)) {
-		pr_debug("invalid major %u (expect %u)\n",
-				info->major, MAJOR(binfo.devt));
-		ret = -ENODEV;
-		goto err_put_bdev;
-	}
-
-	/* psblk_bdev must be assigned before register to pstore/blk */
-	psblk_bdev = bdev;
-	blkdev_panic_write = info->panic_write;
-
-	/* Copy back block device details. */
-	info->devt = binfo.devt;
-	info->nr_sects = binfo.nr_sects;
-	info->start_sect = binfo.start_sect;
-
-	memset(&dev, 0, sizeof(dev));
-	dev.total_size = info->nr_sects << SECTOR_SHIFT;
-	dev.flags = info->flags;
-	dev.read = psblk_generic_blk_read;
-	dev.write = psblk_generic_blk_write;
-	dev.erase = NULL;
-	dev.panic_write = info->panic_write ? psblk_blk_panic_write : NULL;
-
-	ret = __register_pstore_device(&dev);
-	if (ret)
-		goto err_put_bdev;
-
-	bdevname(bdev, bdev_name);
-	pr_info("attached %s%s\n", bdev_name,
-		info->panic_write ? "" : " (no dedicated panic_write!)");
-	return 0;
-
-err_put_bdev:
-	psblk_bdev = NULL;
-	blkdev_panic_write = NULL;
-	psblk_put_bdev(bdev, holder);
-	return ret;
-}
-
-/**
- * register_pstore_blk() - register block device to pstore/blk
- *
- * @info: details on the desired block device interface
- *
- * Return:
- * * 0		- OK
- * * Others	- something error.
- */
-int register_pstore_blk(struct pstore_blk_info *info)
-{
-	int ret;
-
-	mutex_lock(&pstore_blk_lock);
-	ret = __register_pstore_blk(info);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_pstore_blk);
-
-static void __unregister_pstore_blk(unsigned int major)
-{
-	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
-	void *holder = blkdev;
-
-	lockdep_assert_held(&pstore_blk_lock);
-	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		__unregister_pstore_device(&dev);
-		psblk_put_bdev(psblk_bdev, holder);
-		blkdev_panic_write = NULL;
-		psblk_bdev = NULL;
-	}
-}
-
-/**
- * unregister_pstore_blk() - unregister block device from pstore/blk
- *
- * @major: the major device number of device
- */
-void unregister_pstore_blk(unsigned int major)
-{
-	mutex_lock(&pstore_blk_lock);
-	__unregister_pstore_blk(major);
-	mutex_unlock(&pstore_blk_lock);
-}
-EXPORT_SYMBOL_GPL(unregister_pstore_blk);
-
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
@@ -481,32 +212,14 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
 }
 EXPORT_SYMBOL_GPL(pstore_blk_get_config);
 
-static int __init pstore_blk_init(void)
-{
-	struct pstore_blk_info info = { };
-	int ret = 0;
-
-	mutex_lock(&pstore_blk_lock);
-	if (!pstore_zone_info && best_effort && blkdev[0])
-		ret = __register_pstore_blk(&info);
-	mutex_unlock(&pstore_blk_lock);
-
-	return ret;
-}
-late_initcall(pstore_blk_init);
-
 static void __exit pstore_blk_exit(void)
 {
-	mutex_lock(&pstore_blk_lock);
-	if (psblk_bdev)
-		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
-	else {
-		struct pstore_device_info dev = { };
+	struct pstore_device_info dev = { };
 
-		if (pstore_zone_info)
-			dev.read = pstore_zone_info->read;
-		__unregister_pstore_device(&dev);
-	}
+	mutex_lock(&pstore_blk_lock);
+	if (pstore_zone_info)
+		dev.read = pstore_zone_info->read;
+	__unregister_pstore_device(&dev);
 	mutex_unlock(&pstore_blk_lock);
 }
 module_exit(pstore_blk_exit);
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 61e914522b0193..9a9bf76ea73960 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -22,33 +22,6 @@
 typedef int (*pstore_blk_panic_write_op)(const char *buf, sector_t start_sect,
 		sector_t sects);
 
-/**
- * struct pstore_blk_info - pstore/blk registration details
- *
- * @major:	Which major device number to support with pstore/blk
- * @flags:	The supported PSTORE_FLAGS_* from linux/pstore.h.
- * @panic_write:The write operation only used for the panic case.
- *		This can be NULL, but is recommended to avoid losing
- *		crash data if the kernel's IO path or work queues are
- *		broken during a panic.
- * @devt:	The dev_t that pstore/blk has attached to.
- * @nr_sects:	Number of sectors on @devt.
- * @start_sect:	Starting sector on @devt.
- */
-struct pstore_blk_info {
-	unsigned int major;
-	unsigned int flags;
-	pstore_blk_panic_write_op panic_write;
-
-	/* Filled in by pstore/blk after registration. */
-	dev_t devt;
-	sector_t nr_sects;
-	sector_t start_sect;
-};
-
-int  register_pstore_blk(struct pstore_blk_info *info);
-void unregister_pstore_blk(unsigned int major);
-
 /**
  * struct pstore_device_info - back-end pstore/blk driver structure.
  *
