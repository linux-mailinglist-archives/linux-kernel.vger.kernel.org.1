Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39862F5661
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhANBqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:46:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:41975 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbhANA42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:56:28 -0500
IronPort-SDR: Ext10eaOhXfYbKHZaX12nKe7uXebQOdi+BN/usTqrCtbb81a+hPe+2VOTAgJDJoJbGJSoOYK6U
 0cxVn5VH+85w==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="174781378"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="174781378"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:38 -0800
IronPort-SDR: 5HKoXBKoyGb3n9NZ5CSoSgpslTMJGeu3Q/HP1qdDNEM0W8PUXDj/VZ5I9mv6uURdMVoGUcknp1
 WxWFxf/T5a8g==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="568019431"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:38 -0800
Subject: [PATCH v4 5/5] mm: Fix memory_failure() handling of dax-namespace
 metadata
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 16:43:37 -0800
Message-ID: <161058501758.1840162.4239831989762604527.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given 'struct dev_pagemap' spans both data pages and metadata pages be
careful to consult the altmap if present to delineate metadata. In fact
the pfn_first() helper already identifies the first valid data pfn, so
export that helper for other code paths via pgmap_pfn_valid().

Other usage of get_dev_pagemap() are not a concern because those are
operating on known data pfns having been looked up by get_user_pages().
I.e. metadata pfns are never user mapped.

Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |    6 ++++++
 mm/memory-failure.c      |    6 ++++++
 mm/memremap.c            |   15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 79c49e7f5c30..f5b464daeeca 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -137,6 +137,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
+bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
 void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
@@ -165,6 +166,11 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	return NULL;
 }
 
+static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
+{
+	return false;
+}
+
 static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
 	return 0;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 78b173c7190c..541569cb4a99 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1308,6 +1308,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 */
 		put_page(page);
 
+	/* device metadata space is not recoverable */
+	if (!pgmap_pfn_valid(pgmap, pfn)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
 	/*
 	 * Prevent the inode from being freed while we are interrogating
 	 * the address_space, typically this would be handled by
diff --git a/mm/memremap.c b/mm/memremap.c
index 16b2fb482da1..2455bac89506 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -80,6 +80,21 @@ static unsigned long pfn_first(struct dev_pagemap *pgmap, int range_id)
 	return pfn + vmem_altmap_offset(pgmap_altmap(pgmap));
 }
 
+bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < pgmap->nr_range; i++) {
+		struct range *range = &pgmap->ranges[i];
+
+		if (pfn >= PHYS_PFN(range->start) &&
+		    pfn <= PHYS_PFN(range->end))
+			return pfn >= pfn_first(pgmap, i);
+	}
+
+	return false;
+}
+
 static unsigned long pfn_end(struct dev_pagemap *pgmap, int range_id)
 {
 	const struct range *range = &pgmap->ranges[range_id];

