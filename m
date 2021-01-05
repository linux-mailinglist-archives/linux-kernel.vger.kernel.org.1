Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B262EA393
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbhAEC7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:59:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:41795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbhAEC7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:59:41 -0500
IronPort-SDR: mNEZy1dhyqf+8L29eeisgF246NPrmK4FS5StU/mKuzHBIW+hOT9vLojJ36mmF3b/ddFCIVexPO
 P3ZUl2WX1zHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827526"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827526"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:18 -0800
IronPort-SDR: jcVVZjal4TKJXacHFduTlgQGarYxJdBo3VKMvP76aEo03JgxNq1h3hpOAXid/QL/eOzr04fw2U
 szmSNkeJLeYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632164"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:17 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: [PATCH v8 13/20] dlb: add port mmap support
Date:   Mon,  4 Jan 2021 20:58:32 -0600
Message-Id: <20210105025839.23169-14-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20210105025839.23169-1-mike.ximing.chen@intel.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a port is created, the application can mmap the corresponding DMA
memory and MMIO into user-space. This allows user-space applications to
do (performance-sensitive) enqueue and dequeue independent of the kernel
driver.

The mmap callback is only available through special port files: a producer
port (PP) file and a consumer queue (CQ) file. User-space gets an fd for
these files by calling a new ioctl, DLB_DOMAIN_CMD_GET_{LDB,
DIR}_PORT_{PP, CQ}_FD, and passing in a port ID. If the ioctl succeeds, the
returned fd can be used to mmap that port's PP/CQ.

Device reset requires first unmapping all user-space mappings, to prevent
applications from interfering with the reset operation. To this end, the
driver uses a single inode -- allocated when the first PP/CQ file is
created, and freed when the last such file is closed -- and attaches all
port files to this common inode, as done elsewhere in Linux (e.g. cxl,
dax).

Allocating this inode requires creating a pseudo-filesystem. The driver
initializes this FS when the inode is allocated, and frees the FS after the
inode is freed.

The driver doesn't use anon_inode_getfd() for these port mmap files because
the anon inode layer uses a single inode that is shared with other kernel
components -- calling unmap_mapping_range() on that shared inode would
likely break the kernel.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/misc/dlb/Makefile       |   1 +
 drivers/misc/dlb/dlb_file.c     | 150 ++++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_file.h     |  18 ++++
 drivers/misc/dlb/dlb_hw_types.h |   4 +-
 drivers/misc/dlb/dlb_ioctl.c    | 148 ++++++++++++++++++++++++++++++-
 drivers/misc/dlb/dlb_main.c     | 119 +++++++++++++++++++++++++
 drivers/misc/dlb/dlb_main.h     |  16 ++++
 drivers/misc/dlb/dlb_pf_ops.c   |  22 +++++
 drivers/misc/dlb/dlb_resource.c | 141 ++++++++++++++++++++++++++++++
 drivers/misc/dlb/dlb_resource.h |  12 +++
 include/uapi/linux/dlb.h        |  59 +++++++++++++
 11 files changed, 686 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/dlb/dlb_file.c
 create mode 100644 drivers/misc/dlb/dlb_file.h

diff --git a/drivers/misc/dlb/Makefile b/drivers/misc/dlb/Makefile
index aaafb3086d8d..66676222ca07 100644
--- a/drivers/misc/dlb/Makefile
+++ b/drivers/misc/dlb/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_INTEL_DLB) := dlb.o
 
 dlb-objs := dlb_main.o
 dlb-objs += dlb_pf_ops.o dlb_resource.o dlb_ioctl.o
+dlb-objs += dlb_file.o
diff --git a/drivers/misc/dlb/dlb_file.c b/drivers/misc/dlb/dlb_file.c
new file mode 100644
index 000000000000..adddcd320301
--- /dev/null
+++ b/drivers/misc/dlb/dlb_file.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/pseudo_fs.h>
+
+#include "dlb_file.h"
+#include "dlb_main.h"
+
+/*
+ * dlb tracks its memory mappings so it can revoke them when a reset is
+ * requested and user-space cannot be allowed to access the device. To achieve
+ * that, the driver creates a single inode through which all driver-created
+ * files can share a struct address_space, and unmaps the inode's address space
+ * during the reset preparation phase. Since the anon inode layer shares its
+ * inode with multiple kernel components, we cannot use that here.
+ *
+ * Doing so requires a custom pseudo-filesystem to allocate the inode. The FS
+ * and the inode are allocated on demand when a file is created, and both are
+ * freed when the last such file is closed.
+ *
+ * This is inspired by other drivers (cxl, dax, mem) and the anon inode layer.
+ */
+static int dlb_fs_cnt;
+static struct vfsmount *dlb_vfs_mount;
+
+#define DLBFS_MAGIC 0x444C4232 /* ASCII for DLB */
+static int dlb_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, DLBFS_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type dlb_fs_type = {
+	.name	 = "dlb",
+	.owner	 = THIS_MODULE,
+	.init_fs_context = dlb_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+/* Allocate an anonymous inode. Must hold the resource mutex while calling. */
+static struct inode *dlb_alloc_inode(struct dlb *dlb)
+{
+	struct inode *inode;
+	int ret;
+
+	/* Increment the pseudo-FS's refcnt and (if not already) mount it. */
+	ret = simple_pin_fs(&dlb_fs_type, &dlb_vfs_mount, &dlb_fs_cnt);
+	if (ret < 0) {
+		dev_err(dlb->dev,
+			"[%s()] Cannot mount pseudo filesystem: %d\n",
+			__func__, ret);
+		return ERR_PTR(ret);
+	}
+
+	dlb->inode_cnt++;
+
+	if (dlb->inode_cnt > 1) {
+		/*
+		 * Return the previously allocated inode. In this case, there
+		 * is guaranteed >= 1 reference and so ihold() is safe to call.
+		 */
+		ihold(dlb->inode);
+		return dlb->inode;
+	}
+
+	inode = alloc_anon_inode(dlb_vfs_mount->mnt_sb);
+	if (IS_ERR(inode)) {
+		dev_err(dlb->dev,
+			"[%s()] Cannot allocate inode: %ld\n",
+			__func__, PTR_ERR(inode));
+		dlb->inode_cnt = 0;
+		simple_release_fs(&dlb_vfs_mount, &dlb_fs_cnt);
+	}
+
+	dlb->inode = inode;
+
+	return inode;
+}
+
+/*
+ * Decrement the inode reference count and release the FS. Intended for
+ * unwinding dlb_alloc_inode(). Must hold the resource mutex while calling.
+ */
+static void dlb_free_inode(struct inode *inode)
+{
+	iput(inode);
+	simple_release_fs(&dlb_vfs_mount, &dlb_fs_cnt);
+}
+
+/*
+ * Release the FS. Intended for use in a file_operations release callback,
+ * which decrements the inode reference count separately. Must hold the
+ * resource mutex while calling.
+ */
+void dlb_release_fs(struct dlb *dlb)
+{
+	mutex_lock(&dlb_driver_mutex);
+
+	simple_release_fs(&dlb_vfs_mount, &dlb_fs_cnt);
+
+	dlb->inode_cnt--;
+
+	/* When the fs refcnt reaches zero, the inode has been freed */
+	if (dlb->inode_cnt == 0)
+		dlb->inode = NULL;
+
+	mutex_unlock(&dlb_driver_mutex);
+}
+
+/*
+ * Allocate a file with the requested flags, file operations, and name that
+ * uses the device's shared inode. Must hold the resource mutex while calling.
+ *
+ * Caller must separately allocate an fd and install the file in that fd.
+ */
+struct file *dlb_getfile(struct dlb *dlb,
+			 int flags,
+			 const struct file_operations *fops,
+			 const char *name)
+{
+	struct inode *inode;
+	struct file *f;
+
+	if (!try_module_get(THIS_MODULE))
+		return ERR_PTR(-ENOENT);
+
+	mutex_lock(&dlb_driver_mutex);
+
+	inode = dlb_alloc_inode(dlb);
+	if (IS_ERR(inode)) {
+		mutex_unlock(&dlb_driver_mutex);
+		module_put(THIS_MODULE);
+		return ERR_CAST(inode);
+	}
+
+	f = alloc_file_pseudo(inode, dlb_vfs_mount, name, flags, fops);
+	if (IS_ERR(f)) {
+		dlb_free_inode(inode);
+		mutex_unlock(&dlb_driver_mutex);
+		module_put(THIS_MODULE);
+		return f;
+	}
+
+	mutex_unlock(&dlb_driver_mutex);
+
+	return f;
+}
diff --git a/drivers/misc/dlb/dlb_file.h b/drivers/misc/dlb/dlb_file.h
new file mode 100644
index 000000000000..278c66321948
--- /dev/null
+++ b/drivers/misc/dlb/dlb_file.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(C) 2016-2020 Intel Corporation. All rights reserved. */
+
+#ifndef __DLB_FILE_H
+#define __DLB_FILE_H
+
+#include <linux/file.h>
+
+#include "dlb_main.h"
+
+void dlb_release_fs(struct dlb *dlb);
+
+struct file *dlb_getfile(struct dlb *dlb,
+			 int flags,
+			 const struct file_operations *fops,
+			 const char *name);
+
+#endif /* __DLB_FILE_H */
diff --git a/drivers/misc/dlb/dlb_hw_types.h b/drivers/misc/dlb/dlb_hw_types.h
index 43fd93ce50ef..3c9cc2bd6c01 100644
--- a/drivers/misc/dlb/dlb_hw_types.h
+++ b/drivers/misc/dlb/dlb_hw_types.h
@@ -68,12 +68,12 @@
 #define DLB_LDB_PP_STRIDE     0x1000
 #define DLB_LDB_PP_BOUND      (DLB_LDB_PP_BASE + \
 				DLB_LDB_PP_STRIDE * DLB_MAX_NUM_LDB_PORTS)
-#define DLB_LDB_PP_OFFS(id)   (DLB_LDB_PP_BASE + (id) * DLB_PP_SIZE)
+#define DLB_LDB_PP_OFFSET(id) (DLB_LDB_PP_BASE + (id) * DLB_PP_SIZE)
 #define DLB_DIR_PP_BASE       0x2000000
 #define DLB_DIR_PP_STRIDE     0x1000
 #define DLB_DIR_PP_BOUND      (DLB_DIR_PP_BASE + \
 				DLB_DIR_PP_STRIDE * DLB_MAX_NUM_DIR_PORTS)
-#define DLB_DIR_PP_OFFS(id)   (DLB_DIR_PP_BASE + (id) * DLB_PP_SIZE)
+#define DLB_DIR_PP_OFFSET(id) (DLB_DIR_PP_BASE + (id) * DLB_PP_SIZE)
 
 struct dlb_resource_id {
 	u32 phys_id;
diff --git a/drivers/misc/dlb/dlb_ioctl.c b/drivers/misc/dlb/dlb_ioctl.c
index 75ffa75a0a7b..4a11595671a7 100644
--- a/drivers/misc/dlb/dlb_ioctl.c
+++ b/drivers/misc/dlb/dlb_ioctl.c
@@ -7,6 +7,7 @@
 
 #include <uapi/linux/dlb.h>
 
+#include "dlb_file.h"
 #include "dlb_ioctl.h"
 #include "dlb_main.h"
 
@@ -153,6 +154,141 @@ static int dlb_domain_ioctl_create_dir_port(struct dlb *dlb,
 	return ret;
 }
 
+static int dlb_create_port_fd(struct dlb *dlb,
+			      const char *prefix,
+			      u32 id,
+			      const struct file_operations *fops,
+			      int *fd,
+			      struct file **f)
+{
+	char *name;
+	int ret;
+
+	ret = get_unused_fd_flags(O_RDWR);
+	if (ret < 0)
+		return ret;
+
+	*fd = ret;
+
+	name = kasprintf(GFP_KERNEL, "%s:%d", prefix, id);
+	if (!name) {
+		put_unused_fd(*fd);
+		return -ENOMEM;
+	}
+
+	*f = dlb_getfile(dlb, O_RDWR | O_CLOEXEC, fops, name);
+
+	kfree(name);
+
+	if (IS_ERR(*f)) {
+		put_unused_fd(*fd);
+		return PTR_ERR(*f);
+	}
+
+	return 0;
+}
+
+static int dlb_domain_get_port_fd(struct dlb *dlb,
+				  struct dlb_domain *domain,
+				  void *karg,
+				  const char *name,
+				  const struct file_operations *fops,
+				  bool is_ldb)
+{
+	struct dlb_cmd_response *resp;
+	struct dlb_get_port_fd_args *arg = karg;
+	struct dlb_port *port;
+	struct file *file;
+	int ret, fd;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	BUILD_BUG_ON(offsetof(typeof(*arg), response) != 0);
+	resp = &arg->response;
+
+	if ((is_ldb &&
+	     dlb->ops->ldb_port_owned_by_domain(&dlb->hw,
+						domain->id,
+						arg->port_id) != 1)) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (!is_ldb &&
+	    dlb->ops->dir_port_owned_by_domain(&dlb->hw,
+					       domain->id,
+					       arg->port_id) != 1) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	port = (is_ldb) ? &dlb->ldb_port[arg->port_id] :
+			  &dlb->dir_port[arg->port_id];
+
+	if (!port->valid) {
+		resp->status = DLB_ST_INVALID_PORT_ID;
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = dlb_create_port_fd(dlb, name, arg->port_id, fops, &fd, &file);
+	if (ret < 0)
+		goto end;
+
+	file->private_data = port;
+
+	resp->id = fd;
+
+end:
+	/*
+	 * Save fd_install() until after the last point of failure. The domain
+	 * refcnt is decremented in the close callback.
+	 */
+	if (ret == 0) {
+		kref_get(&domain->refcnt);
+
+		fd_install(fd, file);
+	}
+
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
+static int dlb_domain_ioctl_get_ldb_port_pp_fd(struct dlb *dlb,
+					       struct dlb_domain *domain,
+					       void *karg)
+{
+	return dlb_domain_get_port_fd(dlb, domain, karg,
+				      "dlb_ldb_pp:", &dlb_pp_fops, true);
+}
+
+static int dlb_domain_ioctl_get_ldb_port_cq_fd(struct dlb *dlb,
+					       struct dlb_domain *domain,
+					       void *karg)
+{
+	return dlb_domain_get_port_fd(dlb, domain, karg,
+				      "dlb_ldb_cq:", &dlb_cq_fops, true);
+}
+
+static int dlb_domain_ioctl_get_dir_port_pp_fd(struct dlb *dlb,
+					       struct dlb_domain *domain,
+					       void *karg)
+{
+	return dlb_domain_get_port_fd(dlb, domain, karg,
+				      "dlb_dir_pp:", &dlb_pp_fops, false);
+}
+
+static int dlb_domain_ioctl_get_dir_port_cq_fd(struct dlb *dlb,
+					       struct dlb_domain *domain,
+					       void *karg)
+{
+	return dlb_domain_get_port_fd(dlb, domain, karg,
+				      "dlb_dir_cq:", &dlb_cq_fops, false);
+}
+
 typedef int (*dlb_domain_ioctl_fn_t)(struct dlb *dlb,
 				     struct dlb_domain *domain,
 				     void *karg);
@@ -163,7 +299,11 @@ static dlb_domain_ioctl_fn_t dlb_domain_ioctl_fns[NUM_DLB_DOMAIN_CMD] = {
 	dlb_domain_ioctl_get_ldb_queue_depth,
 	dlb_domain_ioctl_get_dir_queue_depth,
 	dlb_domain_ioctl_create_ldb_port,
-	dlb_domain_ioctl_create_dir_port
+	dlb_domain_ioctl_create_dir_port,
+	dlb_domain_ioctl_get_ldb_port_pp_fd,
+	dlb_domain_ioctl_get_ldb_port_cq_fd,
+	dlb_domain_ioctl_get_dir_port_pp_fd,
+	dlb_domain_ioctl_get_dir_port_cq_fd
 };
 
 static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
@@ -172,7 +312,11 @@ static int dlb_domain_ioctl_arg_size[NUM_DLB_DOMAIN_CMD] = {
 	sizeof(struct dlb_get_ldb_queue_depth_args),
 	sizeof(struct dlb_get_dir_queue_depth_args),
 	sizeof(struct dlb_create_ldb_port_args),
-	sizeof(struct dlb_create_dir_port_args)
+	sizeof(struct dlb_create_dir_port_args),
+	sizeof(struct dlb_get_port_fd_args),
+	sizeof(struct dlb_get_port_fd_args),
+	sizeof(struct dlb_get_port_fd_args),
+	sizeof(struct dlb_get_port_fd_args)
 };
 
 long
diff --git a/drivers/misc/dlb/dlb_main.c b/drivers/misc/dlb/dlb_main.c
index 21cea1399c95..97aae4c880d2 100644
--- a/drivers/misc/dlb/dlb_main.c
+++ b/drivers/misc/dlb/dlb_main.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 
+#include "dlb_file.h"
 #include "dlb_ioctl.h"
 #include "dlb_main.h"
 #include "dlb_resource.h"
@@ -18,6 +19,9 @@
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel(R) Dynamic Load Balancer (DLB) Driver");
 
+/* The driver mutex protects data structures that used by multiple devices. */
+DEFINE_MUTEX(dlb_driver_mutex);
+
 static struct class *dlb_class;
 static struct cdev dlb_cdev;
 static dev_t dlb_devt;
@@ -246,6 +250,121 @@ const struct file_operations dlb_domain_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 };
 
+static unsigned long dlb_get_pp_addr(struct dlb *dlb, struct dlb_port *port)
+{
+	unsigned long pgoff = dlb->hw.func_phys_addr;
+
+	if (port->is_ldb)
+		pgoff += DLB_LDB_PP_OFFSET(port->id);
+	else
+		pgoff += DLB_DIR_PP_OFFSET(port->id);
+
+	return pgoff;
+}
+
+static int dlb_pp_mmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dlb_port *port = f->private_data;
+	struct dlb_domain *domain = port->domain;
+	struct dlb *dlb = domain->dlb;
+	unsigned long pgoff;
+	pgprot_t pgprot;
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	if ((vma->vm_end - vma->vm_start) != DLB_PP_SIZE) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	pgprot = pgprot_noncached(vma->vm_page_prot);
+
+	pgoff = dlb_get_pp_addr(dlb, port);
+	ret = io_remap_pfn_range(vma,
+				 vma->vm_start,
+				 pgoff >> PAGE_SHIFT,
+				 vma->vm_end - vma->vm_start,
+				 pgprot);
+
+end:
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
+static int dlb_cq_mmap(struct file *f, struct vm_area_struct *vma)
+{
+	struct dlb_port *port = f->private_data;
+	struct dlb_domain *domain = port->domain;
+	struct dlb *dlb = domain->dlb;
+	struct page *page;
+	int ret;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	if ((vma->vm_end - vma->vm_start) != DLB_CQ_SIZE) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	page = virt_to_page(port->cq_base);
+
+	ret = remap_pfn_range(vma,
+			      vma->vm_start,
+			      page_to_pfn(page),
+			      vma->vm_end - vma->vm_start,
+			      vma->vm_page_prot);
+end:
+	mutex_unlock(&dlb->resource_mutex);
+
+	return ret;
+}
+
+static void dlb_port_unmap(struct dlb *dlb, struct dlb_port *port)
+{
+	if (!port->cq_base) {
+		unmap_mapping_range(dlb->inode->i_mapping,
+				    (unsigned long)port->cq_base,
+				    DLB_CQ_SIZE, 1);
+	} else {
+		unmap_mapping_range(dlb->inode->i_mapping,
+				    dlb_get_pp_addr(dlb, port),
+				    DLB_PP_SIZE, 1);
+	}
+}
+
+static int dlb_port_close(struct inode *i, struct file *f)
+{
+	struct dlb_port *port = f->private_data;
+	struct dlb_domain *domain = port->domain;
+	struct dlb *dlb = domain->dlb;
+
+	mutex_lock(&dlb->resource_mutex);
+
+	kref_put(&domain->refcnt, dlb_free_domain);
+
+	dlb_port_unmap(dlb, port);
+	/* Decrement the refcnt of the pseudo-FS used to allocate the inode */
+	dlb_release_fs(dlb);
+
+	mutex_unlock(&dlb->resource_mutex);
+
+	return 0;
+}
+
+const struct file_operations dlb_pp_fops = {
+	.owner   = THIS_MODULE,
+	.release = dlb_port_close,
+	.mmap    = dlb_pp_mmap,
+};
+
+const struct file_operations dlb_cq_fops = {
+	.owner   = THIS_MODULE,
+	.release = dlb_port_close,
+	.mmap    = dlb_cq_mmap,
+};
+
 /**********************************/
 /****** PCI driver callbacks ******/
 /**********************************/
diff --git a/drivers/misc/dlb/dlb_main.h b/drivers/misc/dlb/dlb_main.h
index 6b06ba42e50a..6458fea7c1be 100644
--- a/drivers/misc/dlb/dlb_main.h
+++ b/drivers/misc/dlb/dlb_main.h
@@ -27,6 +27,8 @@
 #define DLB_NUM_FUNCS_PER_DEVICE (1 + DLB_MAX_NUM_VDEVS)
 #define DLB_MAX_NUM_DEVICES	  (DLB_MAX_NUM_PFS * DLB_NUM_FUNCS_PER_DEVICE)
 
+extern struct mutex dlb_driver_mutex;
+
 enum dlb_device_type {
 	DLB_PF,
 };
@@ -63,6 +65,12 @@ struct dlb_device_ops {
 	int (*get_num_resources)(struct dlb_hw *hw,
 				 struct dlb_get_num_resources_args *args);
 	int (*reset_domain)(struct dlb_hw *hw, u32 domain_id);
+	int (*ldb_port_owned_by_domain)(struct dlb_hw *hw,
+					u32 domain_id,
+					u32 port_id);
+	int (*dir_port_owned_by_domain)(struct dlb_hw *hw,
+					u32 domain_id,
+					u32 port_id);
 	int (*get_ldb_queue_depth)(struct dlb_hw *hw,
 				   u32 domain_id,
 				   struct dlb_get_ldb_queue_depth_args *args,
@@ -78,6 +86,8 @@ struct dlb_device_ops {
 
 extern struct dlb_device_ops dlb_pf_ops;
 extern const struct file_operations dlb_domain_fops;
+extern const struct file_operations dlb_pp_fops;
+extern const struct file_operations dlb_cq_fops;
 
 struct dlb_port {
 	void *cq_base;
@@ -103,6 +113,11 @@ struct dlb {
 	struct file *f;
 	struct dlb_port ldb_port[DLB_MAX_NUM_LDB_PORTS];
 	struct dlb_port dir_port[DLB_MAX_NUM_DIR_PORTS];
+	/*
+	 * Anonymous inode used to share an address_space for all domain
+	 * device file mappings.
+	 */
+	struct inode *inode;
 	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
@@ -110,6 +125,7 @@ struct dlb {
 	struct mutex resource_mutex;
 	enum dlb_device_type type;
 	int id;
+	u32 inode_cnt;
 	dev_t dev_number;
 	u8 domain_reset_failed;
 };
diff --git a/drivers/misc/dlb/dlb_pf_ops.c b/drivers/misc/dlb/dlb_pf_ops.c
index 74393fb1e944..8065f880ba99 100644
--- a/drivers/misc/dlb/dlb_pf_ops.c
+++ b/drivers/misc/dlb/dlb_pf_ops.c
@@ -217,6 +217,26 @@ dlb_pf_query_cq_poll_mode(struct dlb *dlb,
 	return 0;
 }
 
+/**************************************/
+/****** Resource query callbacks ******/
+/**************************************/
+
+static int
+dlb_pf_ldb_port_owned_by_domain(struct dlb_hw *hw,
+				u32 domain_id,
+				u32 port_id)
+{
+	return dlb_ldb_port_owned_by_domain(hw, domain_id, port_id, false, 0);
+}
+
+static int
+dlb_pf_dir_port_owned_by_domain(struct dlb_hw *hw,
+				u32 domain_id,
+				u32 port_id)
+{
+	return dlb_dir_port_owned_by_domain(hw, domain_id, port_id, false, 0);
+}
+
 /********************************/
 /****** DLB PF Device Ops ******/
 /********************************/
@@ -234,6 +254,8 @@ struct dlb_device_ops dlb_pf_ops = {
 	.create_dir_port = dlb_pf_create_dir_port,
 	.get_num_resources = dlb_pf_get_num_resources,
 	.reset_domain = dlb_pf_reset_domain,
+	.ldb_port_owned_by_domain = dlb_pf_ldb_port_owned_by_domain,
+	.dir_port_owned_by_domain = dlb_pf_dir_port_owned_by_domain,
 	.get_ldb_queue_depth = dlb_pf_get_ldb_queue_depth,
 	.get_dir_queue_depth = dlb_pf_get_dir_queue_depth,
 	.init_hardware = dlb_pf_init_hardware,
diff --git a/drivers/misc/dlb/dlb_resource.c b/drivers/misc/dlb/dlb_resource.c
index d9d1c0e164e8..6947353afe34 100644
--- a/drivers/misc/dlb/dlb_resource.c
+++ b/drivers/misc/dlb/dlb_resource.c
@@ -237,6 +237,34 @@ static struct dlb_hw_domain *dlb_get_domain_from_id(struct dlb_hw *hw,
 	return NULL;
 }
 
+static struct dlb_ldb_port *
+dlb_get_domain_ldb_port(u32 id,
+			bool vdev_req,
+			struct dlb_hw_domain *domain)
+{
+	struct dlb_ldb_port *port;
+	int i;
+
+	if (id >= DLB_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	for (i = 0; i < DLB_NUM_COS_DOMAINS; i++) {
+		list_for_each_entry(port, &domain->used_ldb_ports[i], domain_list) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+
+		list_for_each_entry(port, &domain->avail_ldb_ports[i], domain_list) {
+			if ((!vdev_req && port->id.phys_id == id) ||
+			    (vdev_req && port->id.virt_id == id))
+				return port;
+		}
+	}
+
+	return NULL;
+}
+
 static struct dlb_dir_pq_pair *
 dlb_get_domain_used_dir_pq(u32 id,
 			   bool vdev_req,
@@ -256,6 +284,31 @@ dlb_get_domain_used_dir_pq(u32 id,
 	return NULL;
 }
 
+static struct dlb_dir_pq_pair *
+dlb_get_domain_dir_pq(u32 id,
+		      bool vdev_req,
+		      struct dlb_hw_domain *domain)
+{
+	struct dlb_dir_pq_pair *port;
+
+	if (id >= DLB_MAX_NUM_DIR_PORTS)
+		return NULL;
+
+	list_for_each_entry(port, &domain->used_dir_pq_pairs, domain_list) {
+		if ((!vdev_req && port->id.phys_id == id) ||
+		    (vdev_req && port->id.virt_id == id))
+			return port;
+	}
+
+	list_for_each_entry(port, &domain->avail_dir_pq_pairs, domain_list) {
+		if ((!vdev_req && port->id.phys_id == id) ||
+		    (vdev_req && port->id.virt_id == id))
+			return port;
+	}
+
+	return NULL;
+}
+
 static struct dlb_ldb_queue *
 dlb_get_domain_ldb_queue(u32 id,
 			 bool vdev_req,
@@ -3543,6 +3596,94 @@ int dlb_reset_domain(struct dlb_hw *hw,
 	return dlb_domain_reset_software_state(hw, domain);
 }
 
+/**
+ * dlb_ldb_port_owned_by_domain() - query whether a port is owned by a domain
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @port_id: port ID.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function returns whether a load-balanced port is owned by a specified
+ * domain.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 if false, 1 if true, <0 otherwise.
+ *
+ * EINVAL - Invalid domain or port ID, or the domain is not configured.
+ */
+int dlb_ldb_port_owned_by_domain(struct dlb_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	struct dlb_hw_domain *domain;
+	struct dlb_ldb_port *port;
+
+	if (vdev_req && vdev_id >= DLB_MAX_NUM_VDEVS)
+		return -EINVAL;
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain || !domain->configured)
+		return -EINVAL;
+
+	port = dlb_get_domain_ldb_port(port_id, vdev_req, domain);
+
+	if (!port)
+		return -EINVAL;
+
+	return port->domain_id.phys_id == domain->id.phys_id;
+}
+
+/**
+ * dlb_dir_port_owned_by_domain() - query whether a port is owned by a domain
+ * @hw: dlb_hw handle for a particular device.
+ * @domain_id: domain ID.
+ * @port_id: port ID.
+ * @vdev_req: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_req is true, this contains the vdev's ID.
+ *
+ * This function returns whether a directed port is owned by a specified
+ * domain.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return:
+ * Returns 0 if false, 1 if true, <0 otherwise.
+ *
+ * EINVAL - Invalid domain or port ID, or the domain is not configured.
+ */
+int dlb_dir_port_owned_by_domain(struct dlb_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id)
+{
+	struct dlb_dir_pq_pair *port;
+	struct dlb_hw_domain *domain;
+
+	if (vdev_req && vdev_id >= DLB_MAX_NUM_VDEVS)
+		return -EINVAL;
+
+	domain = dlb_get_domain_from_id(hw, domain_id, vdev_req, vdev_id);
+
+	if (!domain || !domain->configured)
+		return -EINVAL;
+
+	port = dlb_get_domain_dir_pq(port_id, vdev_req, domain);
+
+	if (!port)
+		return -EINVAL;
+
+	return port->domain_id.phys_id == domain->id.phys_id;
+}
+
 /**
  * dlb_hw_get_num_resources() - query the PCI function's available resources
  * @hw: dlb_hw handle for a particular device.
diff --git a/drivers/misc/dlb/dlb_resource.h b/drivers/misc/dlb/dlb_resource.h
index 9cec0102ed12..7a3f699b8d20 100644
--- a/drivers/misc/dlb/dlb_resource.h
+++ b/drivers/misc/dlb/dlb_resource.h
@@ -55,6 +55,18 @@ int dlb_reset_domain(struct dlb_hw *hw,
 		     bool vdev_req,
 		     unsigned int vdev_id);
 
+int dlb_ldb_port_owned_by_domain(struct dlb_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id);
+
+int dlb_dir_port_owned_by_domain(struct dlb_hw *hw,
+				 u32 domain_id,
+				 u32 port_id,
+				 bool vdev_req,
+				 unsigned int vdev_id);
+
 int dlb_hw_get_num_resources(struct dlb_hw *hw,
 			     struct dlb_get_num_resources_args *arg,
 			     bool vdev_req,
diff --git a/include/uapi/linux/dlb.h b/include/uapi/linux/dlb.h
index 54d81a03d5cb..31fb99a463a7 100644
--- a/include/uapi/linux/dlb.h
+++ b/include/uapi/linux/dlb.h
@@ -369,6 +369,40 @@ struct dlb_create_dir_port_args {
 	__s32 queue_id;
 };
 
+/*
+ * DLB_CMD_GET_LDB_PORT_PP_FD: Get file descriptor to mmap a load-balanced
+ *	port's producer port (PP).
+ * DLB_CMD_GET_LDB_PORT_CQ_FD: Get file descriptor to mmap a load-balanced
+ *	port's consumer queue (CQ).
+ *
+ *	The load-balanced port must have been previously created with the ioctl
+ *	DLB_CMD_CREATE_LDB_PORT. The fd is used to mmap the PP/CQ region.
+ *
+ * DLB_CMD_GET_DIR_PORT_PP_FD: Get file descriptor to mmap a directed port's
+ *	producer port (PP).
+ * DLB_CMD_GET_DIR_PORT_CQ_FD: Get file descriptor to mmap a directed port's
+ *	consumer queue (CQ).
+ *
+ *	The directed port must have been previously created with the ioctl
+ *	DLB_CMD_CREATE_DIR_PORT. The fd is used to mmap PP/CQ region.
+ *
+ * Input parameters:
+ * - port_id: port ID.
+ * - padding0: Reserved for future use.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ * - response.id: fd.
+ */
+struct dlb_get_port_fd_args {
+	/* Output parameters */
+	struct dlb_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u32 padding0;
+};
+
 enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -376,12 +410,21 @@ enum dlb_domain_user_interface_commands {
 	DLB_DOMAIN_CMD_GET_DIR_QUEUE_DEPTH,
 	DLB_DOMAIN_CMD_CREATE_LDB_PORT,
 	DLB_DOMAIN_CMD_CREATE_DIR_PORT,
+	DLB_DOMAIN_CMD_GET_LDB_PORT_PP_FD,
+	DLB_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,
+	DLB_DOMAIN_CMD_GET_DIR_PORT_PP_FD,
+	DLB_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,
 
 	/* NUM_DLB_DOMAIN_CMD must be last */
 	NUM_DLB_DOMAIN_CMD,
 };
 
+/*
+ * Mapping sizes for memory mapping the consumer queue (CQ) memory space, and
+ * producer port (PP) MMIO space.
+ */
 #define DLB_CQ_SIZE 65536
+#define DLB_PP_SIZE 4096
 
 /********************/
 /* dlb ioctl codes */
@@ -429,5 +472,21 @@ enum dlb_domain_user_interface_commands {
 		_IOWR(DLB_IOC_MAGIC,				\
 		      DLB_DOMAIN_CMD_CREATE_DIR_PORT,		\
 		      struct dlb_create_dir_port_args)
+#define DLB_IOC_GET_LDB_PORT_PP_FD				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_LDB_PORT_PP_FD,	\
+		      struct dlb_get_port_fd_args)
+#define DLB_IOC_GET_LDB_PORT_CQ_FD				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_LDB_PORT_CQ_FD,	\
+		      struct dlb_get_port_fd_args)
+#define DLB_IOC_GET_DIR_PORT_PP_FD				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_DIR_PORT_PP_FD,	\
+		      struct dlb_get_port_fd_args)
+#define DLB_IOC_GET_DIR_PORT_CQ_FD				\
+		_IOWR(DLB_IOC_MAGIC,				\
+		      DLB_DOMAIN_CMD_GET_DIR_PORT_CQ_FD,	\
+		      struct dlb_get_port_fd_args)
 
 #endif /* __DLB_H */
-- 
2.17.1

