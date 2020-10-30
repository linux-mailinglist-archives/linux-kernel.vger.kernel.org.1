Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1F2A0E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgJ3TC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:30204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgJ3TCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:50 -0400
IronPort-SDR: cWzcLhN/A1equlReESaPFO7iAXF09nZdGlbLFuRmA58C+hZYGRMeHbmWYSmaINA6O2f5p2OPgl
 My/+pyUQuiOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154838"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:50 -0700
IronPort-SDR: Jqs0dvB0pEpCMFGr6rZXyjqHhX8kSo1drRxzU5wtdujTa7eT6z/1D0FlJM8qXF8/uRjyVfTIQG
 sM9Vq415DLSQ==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167702"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:50 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] mm/mempolicy: Thread allocation for many preferred
Date:   Fri, 30 Oct 2020 12:02:35 -0700
Message-Id: <20201030190238.306764-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support MPOL_PREFERRED_MANY as the mode used by
set_mempolicy(2), alloc_pages_current() needs to support it. This patch
does that by using the new helper function to allocate properly based on
policy.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Link: https://lore.kernel.org/r/20200630212517.308045-10-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1fd0da0f9631..2d19235413db 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2343,7 +2343,7 @@ EXPORT_SYMBOL(alloc_pages_vma);
 struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
-	struct page *page;
+	int nid = NUMA_NO_NODE;
 
 	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
 		pol = get_task_policy(current);
@@ -2353,14 +2353,9 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_pages_policy(pol, gfp, order,
-					  interleave_nodes(pol));
-	else
-		page = __alloc_pages_nodemask(gfp, order,
-				policy_node(gfp, pol, numa_node_id()),
-				policy_nodemask(gfp, pol));
+		nid = interleave_nodes(pol);
 
-	return page;
+	return alloc_pages_policy(pol, gfp, order, nid);
 }
 EXPORT_SYMBOL(alloc_pages_current);
 
-- 
2.29.2

