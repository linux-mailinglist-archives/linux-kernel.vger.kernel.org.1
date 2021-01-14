Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631BA2F55B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbhANBGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:06:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:43797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbhANA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:56:08 -0500
IronPort-SDR: lfm+jt1H5zM3QXqvp1+E5XDG8nRMYyG0OxFlBkiyQNCZ4tDK/vuy7tuTIhMjFY3i6QHJsJMiR4
 bcOwz5yCOSUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165963396"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="165963396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:16 -0800
IronPort-SDR: 115jzHosqSjA608xwh/hG5WnzVebIk5BCHEyB+oFTxzD9/L652pWRDfYgK/3swoa2h56CJIW3w
 Swad5KOTXWEg==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="364059362"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:16 -0800
Subject: [PATCH v4 1/5] mm: Move pfn_to_online_page() out of line
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 16:43:16 -0800
Message-ID: <161058499608.1840162.10165648147615238793.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_to_online_page() is already too large to be a macro or an inline
function. In anticipation of further logic changes / growth, move it out
of line.

No functional change, just code movement.

Reported-by: Michal Hocko <mhocko@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memory_hotplug.h |   17 +----------------
 mm/memory_hotplug.c            |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 15acce5ab106..3d99de0db2dd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,22 +16,7 @@ struct resource;
 struct vmem_altmap;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-/*
- * Return page for the valid pfn only if the page is online. All pfn
- * walkers which rely on the fully initialized page->flags and others
- * should use this rather than pfn_valid && pfn_to_page
- */
-#define pfn_to_online_page(pfn)					   \
-({								   \
-	struct page *___page = NULL;				   \
-	unsigned long ___pfn = pfn;				   \
-	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
-								   \
-	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
-	    pfn_valid_within(___pfn))				   \
-		___page = pfn_to_page(___pfn);			   \
-	___page;						   \
-})
+struct page *pfn_to_online_page(unsigned long pfn);
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..55a69d4396e7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -300,6 +300,22 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 	return 0;
 }
 
+/*
+ * Return page for the valid pfn only if the page is online. All pfn
+ * walkers which rely on the fully initialized page->flags and others
+ * should use this rather than pfn_valid && pfn_to_page
+ */
+struct page *pfn_to_online_page(unsigned long pfn)
+{
+	unsigned long nr = pfn_to_section_nr(pfn);
+
+	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
+	    pfn_valid_within(pfn))
+		return pfn_to_page(pfn);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pfn_to_online_page);
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will

