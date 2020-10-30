Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49F2A0E43
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgJ3TDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:30204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgJ3TCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:53 -0400
IronPort-SDR: N6ngrwAY3ERDU0qyDWYJUTrPbMG5RufOGWWOZzcrk8TCu8rOyhVkCZjd0FUrkA7w97h+AYytO0
 dBQtMkYK3cuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154853"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:52 -0700
IronPort-SDR: 2EzgMc4crjn5qzbC34oumoE1oQS+ksxq4lt03rxhuDIFPECdjcfNlG0oNoJeG3E+pkqyjJvia8
 FgbRmZ3NhjfA==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167717"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:52 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] mm/mempolicy: Advertise new MPOL_PREFERRED_MANY
Date:   Fri, 30 Oct 2020 12:02:38 -0700
Message-Id: <20201030190238.306764-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new mode to the existing mempolicy modes, MPOL_PREFERRED_MANY.

MPOL_PREFERRED_MANY will be adequately documented in the internal
admin-guide with this patch. Eventually, the man pages for mbind(2),
get_mempolicy(2), set_mempolicy(2) and numactl(8) will also have text
about this mode.  Those shall contain the canonical reference.

NUMA systems continue to become more prevalent. New technologies like
PMEM make finer grain control over memory access patterns increasingly
desirable. MPOL_PREFERRED_MANY allows userspace to specify a set of
nodes that will be tried first when performing allocations. If those
allocations fail, all remaining nodes will be tried. It's a straight
forward API which solves many of the presumptive needs of system
administrators wanting to optimize workloads on such machines. The mode
will work either per VMA, or per thread.

Generally speaking, this is similar to the way MPOL_BIND works, except
the user will only get a SIGSEGV if all nodes in the system are unable
to satisfy the allocation request.

Link: https://lore.kernel.org/r/20200630212517.308045-13-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .../admin-guide/mm/numa_memory_policy.rst        | 16 ++++++++++++----
 include/uapi/linux/mempolicy.h                   |  6 +++---
 mm/hugetlb.c                                     |  4 ++--
 mm/mempolicy.c                                   | 14 ++++++--------
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 1ad020c459b8..b69963a37fc8 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -245,6 +245,14 @@ MPOL_INTERLEAVED
 	address range or file.  During system boot up, the temporary
 	interleaved system default policy works in this mode.
 
+MPOL_PREFERRED_MANY
+        This mode specifies that the allocation should be attempted from the
+        nodemask specified in the policy. If that allocation fails, the kernel
+        will search other nodes, in order of increasing distance from the first
+        set bit in the nodemask based on information provided by the platform
+        firmware. It is similar to MPOL_PREFERRED with the main exception that
+        is is an error to have an empty nodemask.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -253,10 +261,10 @@ MPOL_F_STATIC_NODES
 	nodes changes after the memory policy has been defined.
 
 	Without this flag, any time a mempolicy is rebound because of a
-	change in the set of allowed nodes, the node (Preferred) or
-	nodemask (Bind, Interleave) is remapped to the new set of
-	allowed nodes.  This may result in nodes being used that were
-	previously undesired.
+        change in the set of allowed nodes, the preferred nodemask (Preferred
+        Many), preferred node (Preferred) or nodemask (Bind, Interleave) is
+        remapped to the new set of allowed nodes.  This may result in nodes
+        being used that were previously undesired.
 
 	With this flag, if the user-specified nodes overlap with the
 	nodes allowed by the task's cpuset, then the memory policy is
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774af61e..ad3eee651d4e 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -16,13 +16,13 @@
  */
 
 /* Policies */
-enum {
-	MPOL_DEFAULT,
+enum { MPOL_DEFAULT,
 	MPOL_PREFERRED,
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
-	MPOL_MAX,	/* always last member of enum */
+	MPOL_PREFERRED_MANY,
+	MPOL_MAX, /* always last member of enum */
 };
 
 /* Flags for set_mempolicy */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d9acc25ed3b5..9539d0429706 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1115,7 +1115,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+	if (mpol->mode == MPOL_PREFERRED_MANY) {
 		page = dequeue_huge_page_nodemask(h, gfp_mask | __GFP_RETRY_MAYFAIL,
 						  nid, nodemask);
 		if (!page)
@@ -1984,7 +1984,7 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+	if (mpol->mode != MPOL_PREFERRED_MANY) {
 		page = alloc_surplus_huge_page(h, gfp_mask | __GFP_RETRY_MAYFAIL,
 					       nid, nodemask);
 		if (!page)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aab9ef698aa8..038c0432ec32 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -108,8 +108,6 @@
 
 #include "internal.h"
 
-#define MPOL_PREFERRED_MANY MPOL_MAX
-
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
 #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
@@ -180,7 +178,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
 	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
-} mpol_ops[MPOL_MAX + 1];
+} mpol_ops[MPOL_MAX];
 
 static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
 {
@@ -385,8 +383,8 @@ static void mpol_rebind_preferred_common(struct mempolicy *pol,
 }
 
 /* MPOL_PREFERRED_MANY allows multiple nodes to be set in 'nodes' */
-static void __maybe_unused mpol_rebind_preferred_many(struct mempolicy *pol,
-						      const nodemask_t *nodes)
+static void mpol_rebind_preferred_many(struct mempolicy *pol,
+				       const nodemask_t *nodes)
 {
 	mpol_rebind_preferred_common(pol, nodes, nodes);
 }
@@ -448,7 +446,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	mmap_write_unlock(mm);
 }
 
-static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
+static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	[MPOL_DEFAULT] = {
 		.rebind = mpol_rebind_default,
 	},
@@ -466,8 +464,8 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
 	},
 	/* [MPOL_LOCAL] - see mpol_new() */
 	[MPOL_PREFERRED_MANY] = {
-		.create = NULL,
-		.rebind = NULL,
+		.create = mpol_new_preferred_many,
+		.rebind = mpol_rebind_preferred_many,
 	},
 };
 
-- 
2.29.2

