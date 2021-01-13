Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360802F454E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAMHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:36:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:51012 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbhAMHgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:36:09 -0500
IronPort-SDR: 46t7xAEYRZoO9WmE0Lh1UYss4wjTx5MatGrMspAM5k71O7li0mNfvgzjPBUTHAtinMFY9gBicW
 I0PsQkVxySgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="196799236"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="196799236"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:28 -0800
IronPort-SDR: TxaCVHWg9sHbgbbnmaJoX83Ad9yllXRKmlOa04N3hMfRvtzA0XjaxcTjtdpq8+VY66nf+DHuVm
 hoYIkt//vKDw==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="397639445"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:35:28 -0800
Subject: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jan 2021 23:35:27 -0800
Message-ID: <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory_hotplug.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 55a69d4396e7..9f37f8a68da4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
+		if (!pfn_valid(pfn))
+			return NULL;
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
 

