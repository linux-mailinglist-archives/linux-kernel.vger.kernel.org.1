Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B662A0E41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgJ3TDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:30204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgJ3TCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:52 -0400
IronPort-SDR: qTYRaPyLhHmge4V8YZv08hNBqyfIcEArIyZCA5/6C4ByOP40WjJ8LB2KvUHVKCWE7niuMJ6Q0g
 zLb3o89b/X8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154848"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154848"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:51 -0700
IronPort-SDR: BaEq9jfMC8z/cKfYoy+F1sulYcsqWnz9zF3IlRo+BIpHkuzlqTj/BH3jtO3eGBtkr0xDiResWB
 Eb95nxA4EEPg==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167713"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:51 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] mm/mempolicy: huge-page allocation for many preferred
Date:   Fri, 30 Oct 2020 12:02:37 -0700
Message-Id: <20201030190238.306764-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the missing huge page allocation functionality while obeying
the preferred node semantics.

This uses a fallback mechanism to try multiple preferred nodes first,
and then all other nodes. It cannot use the helper function that was
introduced because huge page allocation already has its own helpers and
it was more LOC, and effort to try to consolidate that.

The weirdness is MPOL_PREFERRED_MANY can't be called yet because it is
part of the UAPI we haven't yet exposed. Instead of make that define
global, it's simply changed with the UAPI patch.

Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/hugetlb.c   | 20 +++++++++++++++++---
 mm/mempolicy.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fe76f8fd5a73..d9acc25ed3b5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1094,7 +1094,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1115,7 +1115,14 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = dequeue_huge_page_nodemask(h, gfp_mask | __GFP_RETRY_MAYFAIL,
+						  nid, nodemask);
+		if (!page)
+			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
+	} else {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	}
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1977,7 +1984,14 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = alloc_surplus_huge_page(h, gfp_mask | __GFP_RETRY_MAYFAIL,
+					       nid, nodemask);
+		if (!page)
+			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
+	} else {
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	}
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 343340c87f03..aab9ef698aa8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2075,7 +2075,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if ((*mpol)->mode == MPOL_BIND ||
+		    (*mpol)->mode == MPOL_PREFERRED_MANY)
 			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
-- 
2.29.2

