Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1B1D90D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgESHTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 03:19:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:29732 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgESHTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:19:18 -0400
IronPort-SDR: kddcaJnWBhZzkLjPcVKT6Mu+yg54x14fTUJGMJyUAhYjmkgf1rnLxE1wEdG7r86Pso0JrJtDAE
 v6Q/EvNf61pA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 00:19:18 -0700
IronPort-SDR: CtE/MwKXvBJfvbiaf+kC3FTek8yqNKfShy702JjWFdZAvkFA9Joq2hlFqAK0jTpw4vGMxISiIb
 fOyMfEhBcKMQ==
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288860289"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 00:19:17 -0700
Subject: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the region
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Tue, 19 May 2020 00:03:06 -0700
Message-ID: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Close the hole of holding a mapping over kernel driver takeover event of
a given address range.

Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
kernel against scenarios where a /dev/mem user tramples memory that a
kernel driver owns. However, this protection only prevents *new* read(),
write() and mmap() requests. Established mappings prior to the driver
calling request_mem_region() are left alone.

Especially with persistent memory, and the core kernel metadata that is
stored there, there are plentiful scenarios for a /dev/mem user to
violate the expectations of the driver and cause amplified damage.

Teach request_mem_region() to find and shoot down active /dev/mem
mappings that it believes it has successfully claimed for the exclusive
use of the driver. Effectively a driver call to request_mem_region()
becomes a hole-punch on the /dev/mem device.

The typical usage of unmap_mapping_range() is part of
truncate_pagecache() to punch a hole in a file, but in this case the
implementation is only doing the "first half" of a hole punch. Namely it
is just evacuating current established mappings of the "hole", and it
relies on the fact that /dev/mem establishes mappings in terms of
absolute physical address offsets. Once existing mmap users are
invalidated they can attempt to re-establish the mapping, or attempt to
continue issuing read(2) / write(2) to the invalidated extent, but they
will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
block those subsequent accesses.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1 [1]:

- updated the changelog to describe the usage of unmap_mapping_range().
  No other logic changes:

[1]: http://lore.kernel.org/r/158662721802.1893045.12301414116114602646.stgit@dwillia2-desk3.amr.corp.intel.com

Greg, Andrew,

I have a regression test for this case now. This was found by an
intermittent data corruption scenario on pmem from a test tool using
/dev/mem.


 drivers/char/mem.c         |  104 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ioport.h     |    6 +++
 include/uapi/linux/magic.h |    1 
 kernel/resource.c          |    5 ++
 4 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 43dd0891ca1e..3a3b7b37c5d2 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -31,11 +31,15 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/pseudo_fs.h>
+#include <uapi/linux/magic.h>
+#include <linux/mount.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
 #endif
 
+#define DEVMEM_MINOR	1
 #define DEVPORT_MINOR	4
 
 static inline unsigned long size_inside_page(unsigned long start,
@@ -805,12 +809,66 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 	return ret;
 }
 
+static struct inode *devmem_inode;
+
+#ifdef CONFIG_IO_STRICT_DEVMEM
+void revoke_devmem(struct resource *res)
+{
+	struct inode *inode = READ_ONCE(devmem_inode);
+
+	/*
+	 * Check that the initialization has completed. Losing the race
+	 * is ok because it means drivers are claiming resources before
+	 * the fs_initcall level of init and prevent /dev/mem from
+	 * establishing mappings.
+	 */
+	smp_rmb();
+	if (!inode)
+		return;
+
+	/*
+	 * The expectation is that the driver has successfully marked
+	 * the resource busy by this point, so devmem_is_allowed()
+	 * should start returning false, however for performance this
+	 * does not iterate the entire resource range.
+	 */
+	if (devmem_is_allowed(PHYS_PFN(res->start)) &&
+	    devmem_is_allowed(PHYS_PFN(res->end))) {
+		/*
+		 * *cringe* iomem=relaxed says "go ahead, what's the
+		 * worst that can happen?"
+		 */
+		return;
+	}
+
+	unmap_mapping_range(inode->i_mapping, res->start, resource_size(res), 1);
+}
+#endif
+
 static int open_port(struct inode *inode, struct file *filp)
 {
+	int rc;
+
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	return security_locked_down(LOCKDOWN_DEV_MEM);
+	rc = security_locked_down(LOCKDOWN_DEV_MEM);
+	if (rc)
+		return rc;
+
+	if (iminor(inode) != DEVMEM_MINOR)
+		return 0;
+
+	/*
+	 * Use a unified address space to have a single point to manage
+	 * revocations when drivers want to take over a /dev/mem mapped
+	 * range.
+	 */
+	inode->i_mapping = devmem_inode->i_mapping;
+	inode->i_mapping->host = devmem_inode;
+	filp->f_mapping = inode->i_mapping;
+
+	return 0;
 }
 
 #define zero_lseek	null_lseek
@@ -885,7 +943,7 @@ static const struct memdev {
 	fmode_t fmode;
 } devlist[] = {
 #ifdef CONFIG_DEVMEM
-	 [1] = { "mem", 0, &mem_fops, FMODE_UNSIGNED_OFFSET },
+	 [DEVMEM_MINOR] = { "mem", 0, &mem_fops, FMODE_UNSIGNED_OFFSET },
 #endif
 #ifdef CONFIG_DEVKMEM
 	 [2] = { "kmem", 0, &kmem_fops, FMODE_UNSIGNED_OFFSET },
@@ -939,6 +997,46 @@ static char *mem_devnode(struct device *dev, umode_t *mode)
 
 static struct class *mem_class;
 
+static int devmem_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, DEVMEM_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type devmem_fs_type = {
+	.name		= "devmem",
+	.owner		= THIS_MODULE,
+	.init_fs_context = devmem_fs_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int devmem_init_inode(void)
+{
+	static struct vfsmount *devmem_vfs_mount;
+	static int devmem_fs_cnt;
+	struct inode *inode;
+	int rc;
+
+	rc = simple_pin_fs(&devmem_fs_type, &devmem_vfs_mount, &devmem_fs_cnt);
+	if (rc < 0) {
+		pr_err("Cannot mount /dev/mem pseudo filesystem: %d\n", rc);
+		return rc;
+	}
+
+	inode = alloc_anon_inode(devmem_vfs_mount->mnt_sb);
+	if (IS_ERR(inode)) {
+		rc = PTR_ERR(inode);
+		pr_err("Cannot allocate inode for /dev/mem: %d\n", rc);
+		simple_release_fs(&devmem_vfs_mount, &devmem_fs_cnt);
+		return rc;
+	}
+
+	/* publish /dev/mem initialized */
+	WRITE_ONCE(devmem_inode, inode);
+	smp_wmb();
+
+	return 0;
+}
+
 static int __init chr_dev_init(void)
 {
 	int minor;
@@ -960,6 +1058,8 @@ static int __init chr_dev_init(void)
 		 */
 		if ((minor == DEVPORT_MINOR) && !arch_has_dev_port())
 			continue;
+		if ((minor == DEVMEM_MINOR) && devmem_init_inode() != 0)
+			continue;
 
 		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
 			      NULL, devlist[minor].name);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index a9b9170b5dd2..6c3eca90cbc4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -301,5 +301,11 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+#ifdef CONFIG_IO_STRICT_DEVMEM
+void revoke_devmem(struct resource *res);
+#else
+static inline void revoke_devmem(struct resource *res) { };
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index d78064007b17..f3956fc11de6 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -94,6 +94,7 @@
 #define BALLOON_KVM_MAGIC	0x13661366
 #define ZSMALLOC_MAGIC		0x58295829
 #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
+#define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 76036a41143b..841737bbda9e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1126,6 +1126,7 @@ struct resource * __request_region(struct resource *parent,
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct resource *res = alloc_resource(GFP_KERNEL);
+	struct resource *orig_parent = parent;
 
 	if (!res)
 		return NULL;
@@ -1176,6 +1177,10 @@ struct resource * __request_region(struct resource *parent,
 		break;
 	}
 	write_unlock(&resource_lock);
+
+	if (res && orig_parent == &iomem_resource)
+		revoke_devmem(res);
+
 	return res;
 }
 EXPORT_SYMBOL(__request_region);

