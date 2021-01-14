Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370762F5660
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbhANBqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:46:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:65494 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbhANA4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:56:33 -0500
IronPort-SDR: F3a9celQliSO1lFha5Zfbp6Ylc6DByay8bENunqwbZKhOxCLQLVPoGMW9tNMFGG8f2Lbuassx4
 vLyeU/QK7iCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="157470355"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="157470355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:21 -0800
IronPort-SDR: 9Fkr+vtQiYNC6KHDg9P1BPiU9cebLEwQpH+qEGsboHEOeqGHMwn1rVIknyF06J25kU7XVFeJZt
 t66Bu++NFWuw==
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="348995326"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:43:21 -0800
Subject: [PATCH v4 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jan 2021 16:43:21 -0800
Message-ID: <161058500148.1840162.4365921007820501696.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_section_valid() determines pfn validity on subsection granularity
where pfn_valid() may be limited to coarse section granularity.
Explicitly validate subsections after pfn_valid() succeeds.

Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
Cc: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Reported-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory_hotplug.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55a69d4396e7..d0c81f7a3347 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,11 +308,26 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 struct page *pfn_to_online_page(unsigned long pfn)
 {
 	unsigned long nr = pfn_to_section_nr(pfn);
+	struct mem_section *ms;
+
+	if (nr >= NR_MEM_SECTIONS)
+		return NULL;
+
+	ms = __nr_to_section(nr);
+	if (!online_section(ms))
+		return NULL;
+
+	/*
+	 * Save some code text when online_section() +
+	 * pfn_section_valid() are sufficient.
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
+		return NULL;
+
+	if (!pfn_section_valid(ms, pfn))
+		return NULL;
 
-	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
-	    pfn_valid_within(pfn))
-		return pfn_to_page(pfn);
-	return NULL;
+	return pfn_to_page(pfn);
 }
 EXPORT_SYMBOL_GPL(pfn_to_online_page);
 

