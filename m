Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37E427921A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgIYUdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:18986 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgIYUda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:33:30 -0400
IronPort-SDR: bO8vPEwqDqlC7aJ/OsfHW5VBbHkMqkIf1iVZdwQXXk5SUeLWlnAaBYXVcstQc682RMk+RMBwAW
 Ir+wIBVxTZNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="149272041"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="149272041"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:17 -0700
IronPort-SDR: yKtywSJjUB9ZKmM9Dm1/NkFLNg6UOlkygXJcF325A3yOAu1vGWmcg+N6lHh5/cpo3GZoAsM8yX
 +euzea32KQbw==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="512356606"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:30:17 -0700
Subject: [PATCH v5 03/17] device-dax/kmem: move resource name tracking to
 drvdata
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
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:11:56 -0700
Message-ID: <160106111639.30709.17624822766862009183.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Towards removing the mode specific @dax_kmem_res attribute from the
generic 'struct dev_dax', and preparing for multi-range support, move
resource name tracking to driver data.  The memory for the resource name
needs to have its own lifetime separate from the device bind lifetime
for cases where the driver is unbound, but the kmem range could not be
unplugged from the page allocator.

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
 drivers/dax/kmem.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index b0d6a99cf12d..6fe2cb1c5f7c 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -34,7 +34,7 @@ int dev_dax_kmem_probe(struct device *dev)
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
 	struct resource *new_res;
-	const char *new_res_name;
+	char *res_name;
 	int numa_node;
 	int rc;
 
@@ -51,15 +51,15 @@ int dev_dax_kmem_probe(struct device *dev)
 		return -EINVAL;
 	}
 
-	new_res_name = kstrdup(dev_name(dev), GFP_KERNEL);
-	if (!new_res_name)
+	res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!res_name)
 		return -ENOMEM;
 
 	/* Region is permanently reserved if hotremove fails. */
-	new_res = request_mem_region(range.start, range_len(&range), new_res_name);
+	new_res = request_mem_region(range.start, range_len(&range), res_name);
 	if (!new_res) {
 		dev_warn(dev, "could not reserve region [%#llx-%#llx]\n", range.start, range.end);
-		kfree(new_res_name);
+		kfree(res_name);
 		return -EBUSY;
 	}
 
@@ -80,9 +80,11 @@ int dev_dax_kmem_probe(struct device *dev)
 	if (rc) {
 		release_resource(new_res);
 		kfree(new_res);
-		kfree(new_res_name);
+		kfree(res_name);
 		return rc;
 	}
+
+	dev_set_drvdata(dev, res_name);
 	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
@@ -94,7 +96,7 @@ static int dev_dax_kmem_remove(struct device *dev)
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct range range = dax_kmem_range(dev_dax);
 	struct resource *res = dev_dax->dax_kmem_res;
-	const char *res_name = res->name;
+	const char *res_name = dev_get_drvdata(dev);
 	int rc;
 
 	/*

