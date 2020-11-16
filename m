Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742512B40C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgKPKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgKPKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:32 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87243222C4;
        Mon, 16 Nov 2020 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521909;
        bh=AX1/gV4BBMmucDRGbJU4tMYtJIz260S1Fr1COTNhqBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GMiakQwRwspJGHxGa3uOwRSpwCAfAtC9me62rOeSN6uj9/kT3GX9BSMpqbvuQJEP
         bZNpqw0whOHjlDYbG4Bs/hw2rgtBYatw5YVgUYKzC+kfC/Z129UPmPNfkj7Bi7xNCd
         rqcg/q9qYoLihUxaIGndBlYeuPiVRI+LVxaVPpd0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEm-L7; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/27] resource: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:19 +0100
Message-Id: <c5e38e1070f8dbe2f9607a10b44afe2875bd966c.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc markups should use this format:
        identifier - description

While here, fix a kernel-doc tag that was using, instead,
a normal comment block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/resource.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 3ae2f56cc79d..9738920abdca 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -303,57 +303,59 @@ int request_resource(struct resource *root, struct resource *new)
 
 EXPORT_SYMBOL(request_resource);
 
 /**
  * release_resource - release a previously reserved resource
  * @old: resource pointer
  */
 int release_resource(struct resource *old)
 {
 	int retval;
 
 	write_lock(&resource_lock);
 	retval = __release_resource(old, true);
 	write_unlock(&resource_lock);
 	return retval;
 }
 
 EXPORT_SYMBOL(release_resource);
 
 /**
- * Finds the lowest iomem resource that covers part of [@start..@end].  The
- * caller must specify @start, @end, @flags, and @desc (which may be
- * IORES_DESC_NONE).
+ * find_next_iomem_res - Finds the lowest iomem resource that covers part of
+ *			 [@start..@end].
  *
  * If a resource is found, returns 0 and @*res is overwritten with the part
  * of the resource that's within [@start..@end]; if none is found, returns
  * -ENODEV.  Returns -EINVAL for invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
  *
  * @start:	start address of the resource searched for
  * @end:	end address of same resource
  * @flags:	flags which the resource must have
  * @desc:	descriptor the resource must have
  * @first_lvl:	walk only the first level children, if set
  * @res:	return ptr, if resource found
+ *
+ * The caller must specify @start, @end, @flags, and @desc
+ * (which may be IORES_DESC_NONE).
  */
 static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       bool first_lvl, struct resource *res)
 {
 	bool siblings_only = true;
 	struct resource *p;
 
 	if (!res)
 		return -EINVAL;
 
 	if (start >= end)
 		return -EINVAL;
 
 	read_lock(&resource_lock);
 
 	for (p = iomem_resource.child; p; p = next_resource(p, siblings_only)) {
 		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
@@ -399,52 +401,54 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 				 unsigned long flags, unsigned long desc,
 				 bool first_lvl, void *arg,
 				 int (*func)(struct resource *, void *))
 {
 	struct resource res;
 	int ret = -EINVAL;
 
 	while (start < end &&
 	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
 		ret = (*func)(&res, arg);
 		if (ret)
 			break;
 
 		start = res.end + 1;
 	}
 
 	return ret;
 }
 
 /**
- * Walks through iomem resources and calls func() with matching resource
- * ranges. This walks through whole tree and not just first level children.
- * All the memory ranges which overlap start,end and also match flags and
- * desc are valid candidates.
- *
+ * walk_iomem_res_desc - Walks through iomem resources and calls func()
+ *			 with matching resource ranges.
+ * *
  * @desc: I/O resource descriptor. Use IORES_DESC_NONE to skip @desc check.
  * @flags: I/O resource flags
  * @start: start addr
  * @end: end addr
  * @arg: function argument for the callback @func
  * @func: callback function that is called for each qualifying resource area
  *
+ * This walks through whole tree and not just first level children.
+ * All the memory ranges which overlap start,end and also match flags and
+ * desc are valid candidates.
+ *
  * NOTE: For a new descriptor search, define a new IORES_DESC in
  * <linux/ioport.h> and set it in 'desc' of a target resource entry.
  */
 int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
 		u64 end, void *arg, int (*func)(struct resource *, void *))
 {
 	return __walk_iomem_res_desc(start, end, flags, desc, false, arg, func);
 }
 EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
 
 /*
  * This function calls the @func callback against all memory ranges of type
  * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
  * Now, this function is only for System RAM, it deals with full ranges and
  * not PFNs. If resources are not PFN-aligned, dealing with PFNs can truncate
  * ranges.
  */
 int walk_system_ram_res(u64 start, u64 end, void *arg,
 			int (*func)(struct resource *, void *))
 {
@@ -1355,43 +1359,43 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 		}
 
 		break;
 	}
 
 	write_unlock(&resource_lock);
 	free_resource(new_res);
 }
 #endif	/* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 static bool system_ram_resources_mergeable(struct resource *r1,
 					   struct resource *r2)
 {
 	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
 	return r1->flags == r2->flags && r1->end + 1 == r2->start &&
 	       r1->name == r2->name && r1->desc == r2->desc &&
 	       !r1->child && !r2->child;
 }
 
-/*
+/**
  * merge_system_ram_resource - mark the System RAM resource mergeable and try to
- * merge it with adjacent, mergeable resources
+ * 	merge it with adjacent, mergeable resources
  * @res: resource descriptor
  *
  * This interface is intended for memory hotplug, whereby lots of contiguous
  * system ram resources are added (e.g., via add_memory*()) by a driver, and
  * the actual resource boundaries are not of interest (e.g., it might be
  * relevant for DIMMs). Only resources that are marked mergeable, that have the
  * same parent, and that don't have any children are considered. All mergeable
  * resources must be immutable during the request.
  *
  * Note:
  * - The caller has to make sure that no pointers to resources that are
  *   marked mergeable are used anymore after this call - the resource might
  *   be freed and the pointer might be stale!
  * - release_mem_region_adjustable() will split on demand on memory hotunplug
  */
 void merge_system_ram_resource(struct resource *res)
 {
 	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	struct resource *cur;
 
-- 
2.28.0

