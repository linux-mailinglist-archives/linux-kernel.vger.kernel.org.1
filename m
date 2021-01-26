Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87FF303A26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391969AbhAZKYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:24:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:20190 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbhAZB2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:28:01 -0500
IronPort-SDR: weWuBJNkQov4X/6TDjx6IjPKQOsZKjtSXWOGnfZT+z6lhuqarkewQ2NzjHP8aB5xJLR2SjUFc2
 IcXeedi3cOXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="243908458"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="243908458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:39 -0800
IronPort-SDR: hOJfIs/C4PU8o2XSx/YV0eVbYfsSWcLbCKOxKOfY8Xe4I5nKGX89Oj08ePyqrk4jaGgPj3LsCi
 GfLcZQl2rr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="472556473"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2021 16:41:39 -0800
Subject: [RFC][PATCH 04/13] mm/numa: node demotion data structure and lookup
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:19 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003419.43281680@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare for the kernel to auto-migrate pages to other memory nodes
with a user defined node migration table. This allows creating single
migration target for each NUMA node to enable the kernel to do NUMA
page migrations instead of simply reclaiming colder pages. A node
with no target is a "terminal node", so reclaim acts normally there.
The migration target does not fundamentally _need_ to be a single node,
but this implementation starts there to limit complexity.

If you consider the migration path as a graph, cycles (loops) in the
graph are disallowed.  This avoids wasting resources by constantly
migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
never be allowed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

changes in July 2020:
 - Remove loop from next_demotion_node() and get_online_mems().
   This means that the node returned by next_demotion_node()
   might now be offline, but the worst case is that the
   allocation fails.  That's fine since it is transient.
---

 b/mm/migrate.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff -puN mm/migrate.c~0006-node-Define-and-export-memory-migration-path mm/migrate.c
--- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path	2021-01-25 16:23:09.553866709 -0800
+++ b/mm/migrate.c	2021-01-25 16:23:09.558866709 -0800
@@ -1161,6 +1161,22 @@ out:
 	return rc;
 }
 
+static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
+
+/**
+ * next_demotion_node() - Get the next node in the demotion path
+ * @node: The starting node to lookup the next node
+ *
+ * @returns: node id for next memory node in the demotion path hierarchy
+ * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
+ * @node online or guarantee that it *continues* to be the next demotion
+ * target.
+ */
+int next_demotion_node(int node)
+{
+	return node_demotion[node];
+}
+
 /*
  * Obtain the lock on page, remove all ptes and migrate the page
  * to the newly allocated page in newpage.
_
