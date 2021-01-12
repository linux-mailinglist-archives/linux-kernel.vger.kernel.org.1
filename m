Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA382F2B70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392696AbhALJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:35:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:27794 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392682AbhALJf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:35:29 -0500
IronPort-SDR: 8ahfpQxhPov/wvTUaKZQPfDDwmXuyKdE9Z3tetVHCERTM9UYe7C6Nn0BKKv/GZJwHmdZrRLDEL
 /UycvJYeNynQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="175431841"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="175431841"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:47 -0800
IronPort-SDR: F+QHxLFNOOiU2I7WoXCiKIDJj6S1wHU/yGPTRdWIb32AROKUSDXxZnOHt8KVKHCCGYMkr7zU2f
 ZIsgw8hhmZsQ==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="400110663"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 01:34:47 -0800
Subject: [PATCH v2 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jan 2021 01:34:47 -0800
Message-ID: <161044408728.1482714.9086710868634042303.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_section_valid() determines pfn validity on subsection granularity.

pfn_valid_within() internally uses pfn_section_valid(), but gates it
with early_section() to preserve the traditional behavior of pfn_valid()
before subsection support was added.

pfn_to_online_page() wants the explicit precision that pfn_valid() does
not offer, so use pfn_section_valid() directly. Since
pfn_to_online_page() already open codes the validity of the section
number vs NR_MEM_SECTIONS, there's not much value to using
pfn_valid_within(), just use pfn_section_valid(). This loses the
valid_section() check that pfn_valid_within() was performing, but that
was already redundant with the online check.

Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
Cc: Qian Cai <cai@lca.pw>
Cc: Michal Hocko <mhocko@suse.com>
Reported-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55a69d4396e7..a845b3979bc0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,11 +308,19 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
+	if (!pfn_section_valid(ms, pfn))
+		return NULL;
 
-	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
-	    pfn_valid_within(pfn))
-		return pfn_to_page(pfn);
-	return NULL;
+	return pfn_to_page(pfn);
 }
 EXPORT_SYMBOL_GPL(pfn_to_online_page);
 

