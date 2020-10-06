Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672C2846DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgJFHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:13:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:23379 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgJFHNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:13:33 -0400
IronPort-SDR: NAAcnTQX2qWUraI5Zmj8mE0ZIUkgKJHrvp32Vigr3wOKr5gcj9ZTUlpJ186OqnJLcCbz+7ovDK
 pfeQdoO7iahg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163620322"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="163620322"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:32 -0700
IronPort-SDR: Lpburd44iz5IWPN6MOMltmCFpFdExXzrzkx+2xwoR0GxQaypnhjpuB9lSPS6Xi4GWoUFMZ/d8S
 kDUNUAjjIeYg==
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="315498301"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 00:13:31 -0700
Subject: [PATCH v6 03/11] device-dax/kmem: move resource tracking to drvdata
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jia He <justin.he@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, david@redhat.com,
        joao.m.martins@oracle.com
Date:   Mon, 05 Oct 2020 23:55:02 -0700
Message-ID: <160196730203.2166475.10332959995680506711.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards removing the mode specific @dax_kmem_res attribute from the
generic 'struct dev_dax', and preparing for multi-range support, move
resource tracking to driver data.  The memory for the resource name
needs to have its own lifetime separate from the device bind lifetime
for cases where the driver is unbound, but the kmem range could not be
unplugged from the page allocator.

The resource reservation also needs to be released manually via
release_resource() given the awkward manipulation of the
IORESOURCE_BUSY flag.

Cc: David Hildenbrand <david@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |    3 --
 drivers/dax/kmem.c        |   55 +++++++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index fbaea36938ae..0668b58c64aa 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -42,8 +42,6 @@ struct dax_region {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @range: resource range for the instance
- * @dax_mem_res: physical address range of hotadded DAX memory
- * @dax_mem_name: name for hotadded DAX memory via add_memory_driver_managed()
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -52,7 +50,6 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	struct range range;
-	struct resource *dax_kmem_res;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index b0d6a99cf12d..a415bc239db4 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -29,14 +29,19 @@ static struct range dax_kmem_range(struct dev_dax *dev_dax)
 	return range;
 }
 
+struct dax_kmem_data {
+	const char *res_name;
+	struct resource *res;
+};
+
 int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
+	struct dax_kmem_data *data;
 	struct resource *new_res;
-	const char *new_res_name;
+	int rc = -ENOMEM;
 	int numa_node;
-	int rc;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -51,17 +56,22 @@ int dev_dax_kmem_probe(struct device *dev)
 		return -EINVAL;
 	}
 
-	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!new_res_name)
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!data->res_name)
+		goto err_res_name;
+
 	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(range.start, range_len(&range), new_res_name);
+	new_res = request_mem_region(range.start, range_len(&range), data->res_name);
 	if (!new_res) {
 		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
-		kfree(new_res_name);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto err_request_mem;
 	}
+	data->res = new_res;
 
 	/*
 	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
@@ -77,15 +87,21 @@ int dev_dax_kmem_probe(struct device *dev)
 	 */
 	rc = add_memory_driver_managed(numa_node, new_res->start,
 				       resource_size(new_res), kmem_name);
-	if (rc) {
-		release_resource(new_res);
-		kfree(new_res);
-		kfree(new_res_name);
-		return rc;
-	}
-	dev_dax->dax_kmem_res = new_res;
+	if (rc)
+		goto err_add_memory;
+
+	dev_set_drvdata(dev, data);
 
 	return 0;
+
+err_add_memory:
+	release_resource(data->res);
+	kfree(data->res);
+err_request_mem:
+	kfree(data->res_name);
+err_res_name:
+	kfree(data);
+	return rc;
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
@@ -93,8 +109,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
-	struct resource *res = dev_dax->dax_kmem_res;
-	const char *res_name = res->name;
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
 	int rc;
 
 	/*
@@ -112,10 +127,10 @@ static int dev_dax_kmem_remove(struct device *dev)
 	}
 
 	/* Release and free dax resources */
-	release_resource(res);
-	kfree(res);
-	kfree(res_name);
-	dev_dax->dax_kmem_res = NULL;
+	release_resource(data->res);
+	kfree(data->res);
+	kfree(data->res_name);
+	kfree(data);
 
 	return 0;
 }

