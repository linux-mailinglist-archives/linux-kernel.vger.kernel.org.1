Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1C27928E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgIYUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:45:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:13951 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgIYUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:45:40 -0400
IronPort-SDR: pJxCBJ8C9DHYJCmpJllKclI/37zP6KWRkx83+hkEsT1B7pvTwPpU/rj9yZGcz2fcrwM22NGzuI
 omD05Spx4sJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="223215846"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="223215846"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:36 -0700
IronPort-SDR: VMbc7ZmBQB/F8HKZReuENs4o+rZepmL6hLQ53EkUQItqX8nx6NIeOUZnodDC+yf9ejTO0Iw0Rz
 xkvwopeQ9iCQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="349880741"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 12:31:36 -0700
Subject: [PATCH v5 17/17] device-dax: add a range mapping allocation
 attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Joao Martins <joao.m.martins@oracle.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:13:15 -0700
Message-ID: <160106119570.30709.4548889722645210610.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Add a sysfs attribute which denotes a range from the dax region to be
allocated.  It's an write only @mapping sysfs attribute in the format of
'<start>-<end>' to allocate a range.  @start and @end use hexadecimal
values and the @pgoff is implicitly ordered wrt to previous writes to
@mapping sysfs e.g.  a write of a range of length 1G the pgoff is
0..1G(-4K), a second write will use @pgoff for 1G+4K..<size>.

This range mapping interface is useful for:

 1) Application which want to implement its own allocation logic,
 and thus pick the desired ranges from dax_region.

 2) For use cases like VMM fast restart[0] where after kexec we
 want to the same gpa<->phys mappings (as originally created
 before kexec).

[0] https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf

Link: https://lkml.kernel.org/r/159643106970.4062302.10402616567780784722.stgit@dwillia2-desk3.amr.corp.intel.com
Link: https://lore.kernel.org/r/20200716172913.19658-5-joao.m.martins@oracle.com
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0ac4a9c0fd18..27513d311242 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1043,6 +1043,67 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t range_parse(const char *opt, size_t len, struct range *range)
+{
+	unsigned long long addr = 0;
+	char *start, *end, *str;
+	ssize_t rc = EINVAL;
+
+	str = kstrdup(opt, GFP_KERNEL);
+	if (!str)
+		return rc;
+
+	end = str;
+	start = strsep(&end, "-");
+	if (!start || !end)
+		goto err;
+
+	rc = kstrtoull(start, 16, &addr);
+	if (rc)
+		goto err;
+	range->start = addr;
+
+	rc = kstrtoull(end, 16, &addr);
+	if (rc)
+		goto err;
+	range->end = addr;
+
+err:
+	kfree(str);
+	return rc;
+}
+
+static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	size_t to_alloc;
+	struct range r;
+	ssize_t rc;
+
+	rc = range_parse(buf, len, &r);
+	if (rc)
+		return rc;
+
+	rc = -ENXIO;
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return rc;
+	}
+	device_lock(dev);
+
+	to_alloc = range_len(&r);
+	if (alloc_is_aligned(dev_dax, to_alloc))
+		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+	device_unlock(dev);
+	device_unlock(dax_region->dev);
+
+	return rc == 0 ? len : rc;
+}
+static DEVICE_ATTR_WO(mapping);
+
 static ssize_t align_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1175,6 +1236,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
 		return 0;
+	if (a == &dev_attr_mapping.attr && is_static(dax_region))
+		return 0;
 	if ((a == &dev_attr_align.attr ||
 	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;
@@ -1184,6 +1247,7 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_size.attr,
+	&dev_attr_mapping.attr,
 	&dev_attr_target_node.attr,
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,

