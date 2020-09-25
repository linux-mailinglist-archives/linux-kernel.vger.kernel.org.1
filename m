Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F48279313
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgIYVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:15:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:47799 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIYVP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:15:57 -0400
IronPort-SDR: Nl85efmiz0CEJnecQ+DHiErFYX7uzMlkb1ZjgJyk6W+Km6sgmbAzmeY+bHb9/grFq2S7ESyl97
 U5L/kB9blbbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159017495"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="159017495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:20 -0700
IronPort-SDR: Xdxk8m6p/cCTik5GWyvufrRvfTX9p/4X+7HfTWaDiVGqr0ClkCAxraGJmleAl8QBxNzF9qxT8j
 54GINlHHvpZQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="455967486"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:20 -0700
Subject: [PATCH v5 14/17] device-dax: make align a per-device property
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Joao Martins <joao.m.martins@oracle.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:12:59 -0700
Message-ID: <160106117957.30709.1142303024324655705.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Introduce @align to struct dev_dax.

When creating a new device, we still initialize to the default dax_region
@align.  Child devices belonging to a region may wish to keep a different
alignment property instead of a global region-defined one.

Link: https://lkml.kernel.org/r/159643105377.4062302.4159447829955683131.stgit@dwillia2-desk3.amr.corp.intel.com
Link: https://lore.kernel.org/r/20200716172913.19658-2-joao.m.martins@oracle.com
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    1 +
 drivers/dax/dax-private.h |    3 +++
 drivers/dax/device.c      |   41 +++++++++++++++--------------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 005fa3e6d41c..852899084d13 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1218,6 +1218,7 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 
 	dev_dax->dax_dev = dax_dev;
 	dev_dax->target_node = dax_region->target_node;
+	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 	kref_get(&dax_region->kref);
 
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 13780f62b95e..5fd3a26cfcea 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -62,6 +62,7 @@ struct dax_mapping {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	unsigned int align;
 	int target_node;
 	int id;
 	struct ida ida;
@@ -84,4 +85,6 @@ static inline struct dax_mapping *to_dax_mapping(struct device *dev)
 {
 	return container_of(dev, struct dax_mapping, dev);
 }
+
+phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff, unsigned long size);
 #endif
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index bf389712a20b..25e0b84a4296 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -17,7 +17,6 @@
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
-	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
 
@@ -32,7 +31,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -EINVAL;
 	}
 
-	mask = dax_region->align - 1;
+	mask = dev_dax->align - 1;
 	if (vma->vm_start & mask || vma->vm_end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
@@ -78,21 +77,19 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf, pfn_t *pfn)
 {
 	struct device *dev = &dev_dax->dev;
-	struct dax_region *dax_region;
 	phys_addr_t phys;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
 		return VM_FAULT_SIGBUS;
 
-	dax_region = dev_dax->region;
-	if (dax_region->align > PAGE_SIZE) {
+	if (dev_dax->align > PAGE_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size != dax_region->align)
+	if (fault_size != dev_dax->align)
 		return VM_FAULT_SIGBUS;
 
 	phys = dax_pgoff_to_phys(dev_dax, vmf->pgoff, PAGE_SIZE);
@@ -111,7 +108,6 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 {
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	struct device *dev = &dev_dax->dev;
-	struct dax_region *dax_region;
 	phys_addr_t phys;
 	pgoff_t pgoff;
 	unsigned int fault_size = PMD_SIZE;
@@ -119,16 +115,15 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	if (check_vma(dev_dax, vmf->vma, __func__))
 		return VM_FAULT_SIGBUS;
 
-	dax_region = dev_dax->region;
-	if (dax_region->align > PMD_SIZE) {
+	if (dev_dax->align > PMD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -154,7 +149,6 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 {
 	unsigned long pud_addr = vmf->address & PUD_MASK;
 	struct device *dev = &dev_dax->dev;
-	struct dax_region *dax_region;
 	phys_addr_t phys;
 	pgoff_t pgoff;
 	unsigned int fault_size = PUD_SIZE;
@@ -163,16 +157,15 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	if (check_vma(dev_dax, vmf->vma, __func__))
 		return VM_FAULT_SIGBUS;
 
-	dax_region = dev_dax->region;
-	if (dax_region->align > PUD_SIZE) {
+	if (dev_dax->align > PUD_SIZE) {
 		dev_dbg(dev, "alignment (%#x) > fault size (%#x)\n",
-			dax_region->align, fault_size);
+			dev_dax->align, fault_size);
 		return VM_FAULT_SIGBUS;
 	}
 
-	if (fault_size < dax_region->align)
+	if (fault_size < dev_dax->align)
 		return VM_FAULT_SIGBUS;
-	else if (fault_size > dax_region->align)
+	else if (fault_size > dev_dax->align)
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
@@ -267,9 +260,8 @@ static int dev_dax_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	if (!IS_ALIGNED(addr, dax_region->align))
+	if (!IS_ALIGNED(addr, dev_dax->align))
 		return -EINVAL;
 	return 0;
 }
@@ -278,9 +270,8 @@ static unsigned long dev_dax_pagesize(struct vm_area_struct *vma)
 {
 	struct file *filp = vma->vm_file;
 	struct dev_dax *dev_dax = filp->private_data;
-	struct dax_region *dax_region = dev_dax->region;
 
-	return dax_region->align;
+	return dev_dax->align;
 }
 
 static const struct vm_operations_struct dax_vm_ops = {
@@ -319,13 +310,11 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 {
 	unsigned long off, off_end, off_align, len_align, addr_align, align;
 	struct dev_dax *dev_dax = filp ? filp->private_data : NULL;
-	struct dax_region *dax_region;
 
 	if (!dev_dax || addr)
 		goto out;
 
-	dax_region = dev_dax->region;
-	align = dax_region->align;
+	align = dev_dax->align;
 	off = pgoff << PAGE_SHIFT;
 	off_end = off + len;
 	off_align = round_up(off, align);

