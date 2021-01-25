Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDB30233F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbhAYJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:31:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11584 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbhAYJYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:24:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPNYW5NWwzMPrB;
        Mon, 25 Jan 2021 16:38:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 16:39:44 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
CC:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <song.bao.hua@hisilicon.com>,
        <liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Date:   Mon, 25 Jan 2021 16:34:56 +0800
Message-ID: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uacce driver supports to use devices in user space safely by SVA. However,
IO page fault may happen when doing DMA operations, which will affect DMA
performance severely.

For some accelerators which need stable performance, it is better to
avoid IO page fault totally. Current memory related APIs, like mlock,
could not achieve this requirement. Idealy we should have a system call,
like "mpin", to pin related pages. However, there is no such API in
kernel, currently drivers which need pin pages implement ioctl interfaces
in their own drivers, like v412, gpu, infiniband, media, vfio etc.

This patch also tries to do this by introducing a pin user page interface in
uacce driver. This patch introduces a new char device named /dev/uacce_ctrl
to help to maintain pin/unpin pages. User space can do pin/unpin pages by
ioctls of an open file of /dev/uacce_ctrl, all pinned pages under one file
will be unpinned in file release process.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
---
Changes v1 -> v2:
 - Some tiny fixes
 - Follow Greg's suggestion to get mm-list and iommu-list involved.

v1: https://lwn.net/Articles/843432/
---
 drivers/misc/uacce/uacce.c      | 172 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/misc/uacce/uacce.h |  16 ++++
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4e..69d3ba8 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -2,16 +2,28 @@
 #include <linux/compat.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/uacce.h>
+#include <linux/vmalloc.h>
 
 static struct class *uacce_class;
 static dev_t uacce_devt;
 static DEFINE_MUTEX(uacce_mutex);
 static DEFINE_XARRAY_ALLOC(uacce_xa);
 
+struct uacce_pin_container {
+	struct xarray array;
+};
+
+struct pin_pages {
+	unsigned long first;
+	unsigned long nr_pages;
+	struct page **pages;
+};
+
 static int uacce_start_queue(struct uacce_queue *q)
 {
 	int ret = 0;
@@ -497,6 +509,151 @@ void uacce_remove(struct uacce_device *uacce)
 }
 EXPORT_SYMBOL_GPL(uacce_remove);
 
+static int uacce_ctrl_open(struct inode *inode, struct file *file)
+{
+	struct uacce_pin_container *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	file->private_data = p;
+
+	xa_init(&p->array);
+
+	return 0;
+}
+
+static int uacce_ctrl_release(struct inode *inode, struct file *file)
+{
+	struct uacce_pin_container *priv = file->private_data;
+	struct pin_pages *p;
+	unsigned long idx;
+
+	xa_for_each(&priv->array, idx, p) {
+		unpin_user_pages(p->pages, p->nr_pages);
+		xa_erase(&priv->array, p->first);
+		vfree(p->pages);
+		kfree(p);
+	}
+
+	xa_destroy(&priv->array);
+	kfree(priv);
+
+	return 0;
+}
+
+static int uacce_pin_page(struct uacce_pin_container *priv,
+			  struct uacce_pin_address *addr)
+{
+	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
+	unsigned long first, last, nr_pages;
+	struct page **pages;
+	struct pin_pages *p;
+	int ret;
+
+	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
+	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	nr_pages = last - first + 1;
+
+	pages = vmalloc(nr_pages * sizeof(struct page *));
+	if (!pages)
+		return -ENOMEM;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
+				  flags | FOLL_LONGTERM, pages);
+	if (ret != nr_pages) {
+		pr_err("uacce: Failed to pin page\n");
+		goto free_p;
+	}
+	p->first = first;
+	p->nr_pages = nr_pages;
+	p->pages = pages;
+
+	ret = xa_err(xa_store(&priv->array, p->first, p, GFP_KERNEL));
+	if (ret)
+		goto unpin_pages;
+
+	return 0;
+
+unpin_pages:
+	unpin_user_pages(pages, nr_pages);
+free_p:
+	kfree(p);
+free:
+	vfree(pages);
+	return ret;
+}
+
+static int uacce_unpin_page(struct uacce_pin_container *priv,
+			    struct uacce_pin_address *addr)
+{
+	unsigned long first, last, nr_pages;
+	struct pin_pages *p;
+
+	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
+	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
+	nr_pages = last - first + 1;
+
+	/* find pin_pages */
+	p = xa_load(&priv->array, first);
+	if (!p)
+		return -ENODEV;
+
+	if (p->nr_pages != nr_pages)
+		return -EINVAL;
+
+	/* unpin */
+	unpin_user_pages(p->pages, p->nr_pages);
+
+	/* release resource */
+	xa_erase(&priv->array, first);
+	vfree(p->pages);
+	kfree(p);
+
+	return 0;
+}
+
+static long uacce_ctrl_unl_ioctl(struct file *filep, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct uacce_pin_container *p = filep->private_data;
+	struct uacce_pin_address addr;
+
+	if (copy_from_user(&addr, (void __user *)arg,
+			   sizeof(struct uacce_pin_address)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case UACCE_CMD_PIN:
+		return uacce_pin_page(p, &addr);
+
+	case UACCE_CMD_UNPIN:
+		return uacce_unpin_page(p, &addr);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations uacce_ctrl_fops = {
+	.owner = THIS_MODULE,
+	.open = uacce_ctrl_open,
+	.release = uacce_ctrl_release,
+	.unlocked_ioctl	= uacce_ctrl_unl_ioctl,
+};
+
+static struct miscdevice uacce_ctrl_miscdev = {
+	.name = "uacce_ctrl",
+	.minor = MISC_DYNAMIC_MINOR,
+	.fops = &uacce_ctrl_fops,
+};
+
 static int __init uacce_init(void)
 {
 	int ret;
@@ -507,13 +664,26 @@ static int __init uacce_init(void)
 
 	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
 	if (ret)
-		class_destroy(uacce_class);
+		goto destroy_class;
+
+	ret = misc_register(&uacce_ctrl_miscdev);
+	if (ret) {
+		pr_err("uacce: ctrl dev registration failed\n");
+		goto unregister_cdev;
+	}
 
+	return 0;
+
+unregister_cdev:
+	unregister_chrdev_region(uacce_devt, MINORMASK);
+destroy_class:
+	class_destroy(uacce_class);
 	return ret;
 }
 
 static __exit void uacce_exit(void)
 {
+	misc_deregister(&uacce_ctrl_miscdev);
 	unregister_chrdev_region(uacce_devt, MINORMASK);
 	class_destroy(uacce_class);
 }
diff --git a/include/uapi/misc/uacce/uacce.h b/include/uapi/misc/uacce/uacce.h
index cc71856..0b10551 100644
--- a/include/uapi/misc/uacce/uacce.h
+++ b/include/uapi/misc/uacce/uacce.h
@@ -35,4 +35,20 @@ enum uacce_qfrt {
 	UACCE_QFRT_DUS = 1,
 };
 
+/**
+ * struct uacce_pin_address - Expected pin user space address and size
+ * @addr: Address to pin
+ * @size: Size of pin address
+ */
+struct uacce_pin_address {
+	__u64 addr;
+	__u64 size;
+};
+
+/* UACCE_CMD_PIN: Pin a range of memory */
+#define UACCE_CMD_PIN		_IOW('W', 2, struct uacce_pin_address)
+
+/* UACCE_CMD_UNPIN: Unpin a range of memory */
+#define UACCE_CMD_UNPIN		_IOW('W', 3, struct uacce_pin_address)
+
 #endif
-- 
2.8.1

