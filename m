Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF71279306
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgIYVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:10:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:47454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgIYVK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:10:57 -0400
IronPort-SDR: 8lpKJqa3emzRqQiqNGA7kGvUEPosMG9sU1PePgDSbA7xA3NRM3GdjZvnUsd8ZqDXf9SEXS43Ib
 1H2NPb54o9uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159017172"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="159017172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:34 -0700
IronPort-SDR: DsQInKHtxp+L/93F9cb6oSBu0oo2zJMFOp0N/ySAYpoxvdhKsPPgZW1bBARjHjFGCEcsstKs2R
 aliaOxo52PbA==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="323503157"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:34 -0700
Subject: [PATCH v5 06/17] device-dax: introduce 'struct dev_dax'
 typed-driver operations
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jia He <justin.he@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hulk Robot <hulkci@huawei.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:12:13 -0700
Message-ID: <160106113357.30709.4541750544799737855.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for introducing seed devices the dax-bus core needs to be
able to intercept ->probe() and ->remove() operations. Towards that end
arrange for the bus and drivers to switch from raw 'struct device'
driver operations to 'struct dev_dax' typed operations.

Cc: Jason Yan <yanaijie@huawei.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |   18 ++++++++++++++++++
 drivers/dax/bus.h         |    4 +++-
 drivers/dax/device.c      |   12 +++++-------
 drivers/dax/kmem.c        |   18 ++++++++----------
 drivers/dax/pmem/compat.c |    2 +-
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0a48ce378686..9549f11ebed0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -135,10 +135,28 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static int dax_bus_probe(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return dax_drv->probe(dev_dax);
+}
+
+static int dax_bus_remove(struct device *dev)
+{
+	struct dax_device_driver *dax_drv = to_dax_drv(dev->driver);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return dax_drv->remove(dev_dax);
+}
+
 static struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
 	.match = dax_bus_match,
+	.probe = dax_bus_probe,
+	.remove = dax_bus_remove,
 	.drv_groups = dax_drv_groups,
 };
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 44592a8cac0f..da27ea70a19a 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -38,6 +38,8 @@ struct dax_device_driver {
 	struct device_driver drv;
 	struct list_head ids;
 	int match_always;
+	int (*probe)(struct dev_dax *dev);
+	int (*remove)(struct dev_dax *dev);
 };
 
 int __dax_driver_register(struct dax_device_driver *dax_drv,
@@ -48,7 +50,7 @@ void dax_driver_unregister(struct dax_device_driver *dax_drv);
 void kill_dev_dax(struct dev_dax *dev_dax);
 
 #if IS_ENABLED(CONFIG_DEV_DAX_PMEM_COMPAT)
-int dev_dax_probe(struct device *dev);
+int dev_dax_probe(struct dev_dax *dev_dax);
 #endif
 
 /*
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 287cf0a3db23..9833fa83b537 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -392,11 +392,11 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-int dev_dax_probe(struct device *dev)
+int dev_dax_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct range *range = &dev_dax->range;
+	struct device *dev = &dev_dax->dev;
 	struct dev_pagemap *pgmap;
 	struct inode *inode;
 	struct cdev *cdev;
@@ -446,17 +446,15 @@ int dev_dax_probe(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_dax_probe);
 
-static int dev_dax_remove(struct device *dev)
+static int dev_dax_remove(struct dev_dax *dev_dax)
 {
 	/* all probe actions are unwound by devm */
 	return 0;
 }
 
 static struct dax_device_driver device_dax_driver = {
-	.drv = {
-		.probe = dev_dax_probe,
-		.remove = dev_dax_remove,
-	},
+	.probe = dev_dax_probe,
+	.remove = dev_dax_remove,
 	.match_always = 1,
 };
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e56fc688bdc5..c2ac465cc342 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -29,10 +29,10 @@ static struct range dax_kmem_range(struct dev_dax *dev_dax)
 	return range;
 }
 
-int dev_dax_kmem_probe(struct device *dev)
+static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
+	struct device *dev = &dev_dax->dev;
 	struct resource *res;
 	char *res_name;
 	int numa_node;
@@ -88,12 +88,12 @@ int dev_dax_kmem_probe(struct device *dev)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-static int dev_dax_kmem_remove(struct device *dev)
+static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	struct dev_dax *dev_dax = to_dev_dax(dev);
+	int rc;
+	struct device *dev = &dev_dax->dev;
 	struct range range = dax_kmem_range(dev_dax);
 	const char *res_name = dev_get_drvdata(dev);
-	int rc;
 
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
@@ -116,7 +116,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	return 0;
 }
 #else
-static int dev_dax_kmem_remove(struct device *dev)
+static int dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
@@ -131,10 +131,8 @@ static int dev_dax_kmem_remove(struct device *dev)
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static struct dax_device_driver device_dax_kmem_driver = {
-	.drv = {
-		.probe = dev_dax_kmem_probe,
-		.remove = dev_dax_kmem_remove,
-	},
+	.probe = dev_dax_kmem_probe,
+	.remove = dev_dax_kmem_remove,
 };
 
 static int __init dax_kmem_init(void)
diff --git a/drivers/dax/pmem/compat.c b/drivers/dax/pmem/compat.c
index d7b15e6f30c5..863c114fd88c 100644
--- a/drivers/dax/pmem/compat.c
+++ b/drivers/dax/pmem/compat.c
@@ -22,7 +22,7 @@ static int dax_pmem_compat_probe(struct device *dev)
 		return -ENOMEM;
 
 	device_lock(&dev_dax->dev);
-	rc = dev_dax_probe(&dev_dax->dev);
+	rc = dev_dax_probe(dev_dax);
 	device_unlock(&dev_dax->dev);
 
 	devres_close_group(&dev_dax->dev, dev_dax);

