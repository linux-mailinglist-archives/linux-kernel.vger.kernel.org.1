Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126B290667
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408192AbgJPNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408068AbgJPNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:36:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE26C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NtrnzXz0f7f5lw3xcS3imskpVeu0d5PcsKR6+9fN+m0=; b=phcRZAaJQDW/GiAa7w8MQwOOiP
        hi4Qp55b/w9byl+GSj4FzrazT990omeLlHEsI0/3+xFQIXrpE11XlUZw9no5t0YecNWg010tMyslo
        Qe6nRW0FzcurXzmKn/5oGwBvh22H8/mWYDFUvpjrqnvbcS1Uyt42GWDJNALnNRzisUNdQbEsmNV+A
        WFD/cqc0WYIMJIOFifQk2loiRUo919YVLFDkbb03Yawh/uHKu1umQjJecwo1ltWqRVFMC3JlHG4hk
        IMOFkZPqu5gGKFKE0S8c0aQ0AHY2PBbcKNkUyKKz+8nkQKPcS84RChWlvLxc3bJBiFCXQaXSHIxpo
        X7D9hUOg==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPtz-0003fK-AY; Fri, 16 Oct 2020 13:36:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] pstore/zone: split struct pstore_zone_info
Date:   Fri, 16 Oct 2020 15:20:44 +0200
Message-Id: <20201016132047.3068029-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out a new pstore_zone_ops structure for static function pointers
plus the name. Also remove the unused owner field entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtdpstore.c     | 13 +++++++----
 fs/pstore/blk.c             | 23 ++++++++++---------
 fs/pstore/zone.c            | 46 +++++++++++++++++++------------------
 include/linux/pstore_blk.h  | 23 ++-----------------
 include/linux/pstore_zone.h | 41 ++++++++++++++++++---------------
 5 files changed, 69 insertions(+), 77 deletions(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index a3ae8778f6a9b9..232ba5c39c2a55 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -378,6 +378,14 @@ static ssize_t mtdpstore_panic_write(const char *buf, size_t size, loff_t off)
 	return retlen;
 }
 
+static const struct pstore_zone_ops mtdpstore_ops = {
+	.name		= KBUILD_MODNAME,
+	.read		= mtdpstore_read,
+	.write		= mtdpstore_write,
+	.erase		= mtdpstore_erase,
+	.panic_write	= mtdpstore_panic_write,
+};
+
 static void mtdpstore_notify_add(struct mtd_info *mtd)
 {
 	int ret;
@@ -426,10 +434,7 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
-	cxt->dev.read = mtdpstore_read;
-	cxt->dev.write = mtdpstore_write;
-	cxt->dev.erase = mtdpstore_erase;
-	cxt->dev.panic_write = mtdpstore_panic_write;
+	cxt->dev.ops = &mtdpstore_ops;
 
 	ret = register_pstore_device(&cxt->dev);
 	if (ret) {
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index a8aa56cba96d59..f7c7f325e42c71 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -108,7 +108,8 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	lockdep_assert_held(&pstore_blk_lock);
 
-	if (!dev || !dev->total_size || !dev->read || !dev->write)
+	if (!dev || !dev->total_size || !dev->ops ||
+	    !dev->ops->read || !dev->ops->write)
 		return -EINVAL;
 
 	/* someone already registered before */
@@ -141,12 +142,7 @@ static int __register_pstore_device(struct pstore_device_info *dev)
 
 	pstore_zone_info->total_size = dev->total_size;
 	pstore_zone_info->max_reason = max_reason;
-	pstore_zone_info->read = dev->read;
-	pstore_zone_info->write = dev->write;
-	pstore_zone_info->erase = dev->erase;
-	pstore_zone_info->panic_write = dev->panic_write;
-	pstore_zone_info->name = KBUILD_MODNAME;
-	pstore_zone_info->owner = THIS_MODULE;
+	pstore_zone_info->ops = dev->ops;
 
 	ret = register_pstore_zone(pstore_zone_info);
 	if (ret) {
@@ -179,7 +175,7 @@ EXPORT_SYMBOL_GPL(register_pstore_device);
 static void __unregister_pstore_device(struct pstore_device_info *dev)
 {
 	lockdep_assert_held(&pstore_blk_lock);
-	if (pstore_zone_info && pstore_zone_info->read == dev->read) {
+	if (pstore_zone_info && pstore_zone_info->ops == dev->ops) {
 		unregister_pstore_zone(pstore_zone_info);
 		kfree(pstore_zone_info);
 		pstore_zone_info = NULL;
@@ -265,6 +261,12 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 	return ret;
 }
 
+static const struct pstore_zone_ops pstore_blk_zone_ops = {
+	.name		= KBUILD_MODNAME,
+	.read		= psblk_generic_blk_read,
+	.write		= psblk_generic_blk_write,
+};
+
 static int __init pstore_blk_init(void)
 {
 	char bdev_name[BDEVNAME_SIZE];
@@ -305,9 +307,8 @@ static int __init pstore_blk_init(void)
 	psblk_bdev = bdev;
 
 	memset(&dev, 0, sizeof(dev));
+	dev.ops = &pstore_blk_zone_ops;
 	dev.total_size = nr_sects << SECTOR_SHIFT;
-	dev.read = psblk_generic_blk_read;
-	dev.write = psblk_generic_blk_write;
 
 	ret = register_pstore_device(&dev);
 	if (ret)
@@ -326,7 +327,7 @@ late_initcall(pstore_blk_init);
 
 static void __exit pstore_blk_exit(void)
 {
-	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
+	struct pstore_device_info dev = { .ops = &pstore_blk_zone_ops };
 
 	if (!psblk_bdev)
 		return;
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 5266ccbec007f3..111d26bb2a8f56 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -218,7 +218,7 @@ static int psz_zone_write(struct pstore_zone *zone,
 	if (!is_on_panic() && !atomic_read(&pstore_zone_cxt.recovered))
 		goto dirty;
 
-	writeop = is_on_panic() ? info->panic_write : info->write;
+	writeop = is_on_panic() ? info->ops->panic_write : info->ops->write;
 	if (!writeop)
 		goto dirty;
 
@@ -337,7 +337,7 @@ static int psz_kmsg_recover_data(struct psz_context *cxt)
 	unsigned long i;
 	ssize_t rcnt;
 
-	if (!info->read)
+	if (!info->ops->read)
 		return -EINVAL;
 
 	for (i = 0; i < cxt->kmsg_max_cnt; i++) {
@@ -360,8 +360,8 @@ static int psz_kmsg_recover_data(struct psz_context *cxt)
 		if (!zone->should_recover)
 			continue;
 		buf = zone->buffer;
-		rcnt = info->read((char *)buf, zone->buffer_size + sizeof(*buf),
-				zone->off);
+		rcnt = info->ops->read((char *)buf, zone->buffer_size +
+				sizeof(*buf), zone->off);
 		if (rcnt != zone->buffer_size + sizeof(*buf))
 			return (int)rcnt < 0 ? (int)rcnt : -EIO;
 	}
@@ -383,7 +383,7 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 	 */
 	char buffer_header[sizeof(*buf) + sizeof(*hdr)] = {0};
 
-	if (!info->read)
+	if (!info->ops->read)
 		return -EINVAL;
 
 	len = sizeof(*buf) + sizeof(*hdr);
@@ -393,13 +393,14 @@ static int psz_kmsg_recover_meta(struct psz_context *cxt)
 		if (unlikely(!zone))
 			return -EINVAL;
 
-		rcnt = info->read((char *)buf, len, zone->off);
+		rcnt = info->ops->read((char *)buf, len, zone->off);
 		if (rcnt == -ENOMSG) {
 			pr_debug("%s with id %lu may be broken, skip\n",
 					zone->name, i);
 			continue;
 		} else if (rcnt != len) {
-			pr_err("read %s with id %lu failed\n", zone->name, i);
+			pr_err("read %s with id %lu failed\n", zone->name,
+					i);
 			return (int)rcnt < 0 ? (int)rcnt : -EIO;
 		}
 
@@ -495,11 +496,11 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 		return 0;
 	}
 
-	if (unlikely(!info->read))
+	if (unlikely(!info->ops->read))
 		return -EINVAL;
 
 	len = sizeof(struct psz_buffer);
-	rcnt = info->read((char *)&tmpbuf, len, zone->off);
+	rcnt = info->ops->read((char *)&tmpbuf, len, zone->off);
 	if (rcnt != len) {
 		pr_debug("read zone %s failed\n", zone->name);
 		return (int)rcnt < 0 ? (int)rcnt : -EIO;
@@ -541,7 +542,7 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 	off = zone->off + sizeof(*oldbuf);
 
 	/* get part of data */
-	rcnt = info->read(buf, len - start, off + start);
+	rcnt = info->ops->read(buf, len - start, off + start);
 	if (rcnt != len - start) {
 		pr_err("read zone %s failed\n", zone->name);
 		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
@@ -549,7 +550,7 @@ static int psz_recover_zone(struct psz_context *cxt, struct pstore_zone *zone)
 	}
 
 	/* get the rest of data */
-	rcnt = info->read(buf + len - start, start, off);
+	rcnt = info->ops->read(buf + len - start, start, off);
 	if (rcnt != start) {
 		pr_err("read zone %s failed\n", zone->name);
 		ret = (int)rcnt < 0 ? (int)rcnt : -EIO;
@@ -671,8 +672,8 @@ static inline int psz_kmsg_erase(struct psz_context *cxt,
 
 	size = buffer_datalen(zone) + sizeof(*zone->buffer);
 	atomic_set(&zone->buffer->datalen, 0);
-	if (cxt->pstore_zone_info->erase)
-		return cxt->pstore_zone_info->erase(size, zone->off);
+	if (cxt->pstore_zone_info->ops->erase)
+		return cxt->pstore_zone_info->ops->erase(size, zone->off);
 	else
 		return psz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
@@ -1185,8 +1186,9 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 
 	*off += size;
 
-	pr_debug("pszone %s: off 0x%llx, %zu header, %zu data\n", zone->name,
-			zone->off, sizeof(*zone->buffer), zone->buffer_size);
+	pr_debug("pszone %s: off 0x%llx, %zu header, %zu data\n",
+			zone->name, zone->off, sizeof(*zone->buffer),
+			zone->buffer_size);
 	return zone;
 }
 
@@ -1310,7 +1312,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 		return -EINVAL;
 	}
 
-	if (!info->name || !info->name[0])
+	if (!info->ops->name || !info->ops->name[0])
 		return -EINVAL;
 
 #define check_size(name, size) {					\
@@ -1338,7 +1340,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	 * if no @read, pstore may mount failed.
 	 * if no @write, pstore do not support to remove record file.
 	 */
-	if (!info->read || !info->write) {
+	if (!info->ops || !info->ops->read || !info->ops->write) {
 		pr_err("no valid general read/write interface\n");
 		return -EINVAL;
 	}
@@ -1346,13 +1348,13 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	mutex_lock(&cxt->pstore_zone_info_lock);
 	if (cxt->pstore_zone_info) {
 		pr_warn("'%s' already loaded: ignoring '%s'\n",
-				cxt->pstore_zone_info->name, info->name);
+				cxt->pstore_zone_info->ops->name, info->ops->name);
 		mutex_unlock(&cxt->pstore_zone_info_lock);
 		return -EBUSY;
 	}
 	cxt->pstore_zone_info = info;
 
-	pr_debug("register %s with properties:\n", info->name);
+	pr_debug("register %s with properties:\n", info->ops->name);
 	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
 	pr_debug("\tkmsg size : %ld Bytes\n", info->kmsg_size);
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
@@ -1376,14 +1378,14 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	}
 	cxt->pstore.data = cxt;
 
-	pr_info("registered %s as backend for", info->name);
+	pr_info("registered %s as backend for", info->ops->name);
 	cxt->pstore.max_reason = info->max_reason;
-	cxt->pstore.name = info->name;
+	cxt->pstore.name = info->ops->name;
 	if (info->kmsg_size) {
 		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
 		pr_cont(" kmsg(%s",
 			kmsg_dump_reason_str(cxt->pstore.max_reason));
-		if (cxt->pstore_zone_info->panic_write)
+		if (cxt->pstore_zone_info->ops->panic_write)
 			pr_cont(",panic_write");
 		pr_cont(")");
 	}
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 99564f93d77488..095a44ce5e122c 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -15,31 +15,12 @@
  * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
  *		linux/pstore.h. It means what front-ends this device support.
  *		Zero means all backends for compatible.
- * @read:	The general read operation. Both of the function parameters
- *		@size and @offset are relative value to bock device (not the
- *		whole disk).
- *		On success, the number of bytes should be returned, others
- *		means error.
- * @write:	The same as @read, but the following error number:
- *		-EBUSY means try to write again later.
- *		-ENOMSG means to try next zone.
- * @erase:	The general erase operation for device with special removing
- *		job. Both of the function parameters @size and @offset are
- *		relative value to storage.
- *		Return 0 on success and others on failure.
- * @panic_write:The write operation only used for panic case. It's optional
- *		if you do not care panic log. The parameters are relative
- *		value to storage.
- *		On success, the number of bytes should be returned, others
- *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
+ * @ops:	operations to access the device.
  */
 struct pstore_device_info {
 	unsigned long total_size;
 	unsigned int flags;
-	pstore_zone_read_op read;
-	pstore_zone_write_op write;
-	pstore_zone_erase_op erase;
-	pstore_zone_write_op panic_write;
+	const struct pstore_zone_ops *ops;
 };
 
 int  register_pstore_device(struct pstore_device_info *dev);
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 1e35eaa33e5e0d..7bff124c96d8b1 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -5,22 +5,10 @@
 
 #include <linux/types.h>
 
-typedef ssize_t (*pstore_zone_read_op)(char *, size_t, loff_t);
-typedef ssize_t (*pstore_zone_write_op)(const char *, size_t, loff_t);
-typedef ssize_t (*pstore_zone_erase_op)(size_t, loff_t);
 /**
- * struct pstore_zone_info - pstore/zone back-end driver structure
+ * struct pstore_zone_ops - pstore/zone ops structure
  *
- * @owner:	Module which is responsible for this back-end driver.
  * @name:	Name of the back-end driver.
- * @total_size: The total size in bytes pstore/zone can use. It must be greater
- *		than 4096 and be multiple of 4096.
- * @kmsg_size:	The size of oops/panic zone. Zero means disabled, otherwise,
- *		it must be multiple of SECTOR_SIZE(512 Bytes).
- * @max_reason: Maximum kmsg dump reason to store.
- * @pmsg_size:	The size of pmsg zone which is the same as @kmsg_size.
- * @console_size:The size of console zone which is the same as @kmsg_size.
- * @ftrace_size:The size of ftrace zone which is the same as @kmsg_size.
  * @read:	The general read operation. Both of the function parameters
  *		@size and @offset are relative value to storage.
  *		On success, the number of bytes should be returned, others
@@ -38,20 +26,35 @@ typedef ssize_t (*pstore_zone_erase_op)(size_t, loff_t);
  *		On success, the number of bytes should be returned, others
  *		excluding -ENOMSG mean error. -ENOMSG means to try next zone.
  */
-struct pstore_zone_info {
-	struct module *owner;
+struct pstore_zone_ops {
 	const char *name;
+	ssize_t (*read)(char *buf, size_t count, loff_t pos);
+	ssize_t (*write)(const char *buf, size_t bytes, loff_t pos);
+	ssize_t (*erase)(size_t byes, loff_t pos);
+	ssize_t (*panic_write)(const char *buf, size_t bytes, loff_t pos);
+};
 
+/**
+ * struct pstore_zone_info - pstore/zone back-end driver structure
+ *
+ * @ops:	Operations to access the zone.
+ * @total_size: The total size in bytes pstore/zone can use. It must be greater
+ *		than 4096 and be multiple of 4096.
+ * @kmsg_size:	The size of oops/panic zone. Zero means disabled, otherwise,
+ *		it must be multiple of SECTOR_SIZE(512 Bytes).
+ * @max_reason: Maximum kmsg dump reason to store.
+ * @pmsg_size:	The size of pmsg zone which is the same as @kmsg_size.
+ * @console_size:The size of console zone which is the same as @kmsg_size.
+ * @ftrace_size:The size of ftrace zone which is the same as @kmsg_size.
+ */
+struct pstore_zone_info {
+	const struct pstore_zone_ops *ops;
 	unsigned long total_size;
 	unsigned long kmsg_size;
 	int max_reason;
 	unsigned long pmsg_size;
 	unsigned long console_size;
 	unsigned long ftrace_size;
-	pstore_zone_read_op read;
-	pstore_zone_write_op write;
-	pstore_zone_erase_op erase;
-	pstore_zone_write_op panic_write;
 };
 
 extern int register_pstore_zone(struct pstore_zone_info *info);
-- 
2.28.0

