Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84A2F2B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392688AbhALJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:35:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:57028 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387724AbhALJfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:35:23 -0500
IronPort-SDR: P8w34Cw7qQJMumANlJJucebqVzbCLWkOO5ino8aCFBtHIoGwXts0eLGyuLkZnADQ9GirTBNkWM
 gNQiA5mzMPhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165691342"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="165691342"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:42 -0800
IronPort-SDR: KALVxv4kl/bC4nRvYL9sEK1WXA26sL3/CdeeJ3rm/UmQykRn2Gr0fhm/Mye3XZZQOzQd5XOq+3
 yjZ5udYclLiw==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="363445952"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:42 -0800
Subject: [PATCH v2 1/5] mm: Move pfn_to_online_page() out of line
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jan 2021 01:34:42 -0800
Message-ID: <161044408207.1482714.1125458890762969867.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Cc: David Hildenbrand <david@redhat.com>
Reported-by: Michal Hocko <mhocko@kernel.org>
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

