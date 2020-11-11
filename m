Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEC2AE925
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKGiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:38:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:29963 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgKKGiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:38:12 -0500
IronPort-SDR: +rmJjgFFmex/JYtdyQ4+C77dxvMg3GPZwHs+1FYTG0ffZZVfFksK20sy5Uddqn2dgedKFICFOj
 uOONsjPIuLLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="157111499"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="157111499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 22:38:11 -0800
IronPort-SDR: aGUBJXPQTTedajjqdlRakP4Sq1QNv9YfJuR0WliIznMReZcd9XgQBvFZBTYIxqscUFF6yzgQG7
 J4qadlxCKJeA==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="541655517"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 22:38:05 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [RFC -V4] autonuma: Migrate on fault among multiple bound nodes
Date:   Wed, 11 Nov 2020 14:37:17 +0800
Message-Id: <20201111063717.186589-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, AutoNUMA can only optimize the page placement among the NUMA
nodes if the default memory policy is used.  Because the memory policy
specified explicitly should take precedence.  But this seems too
strict in some situations.  For example, on a system with 4 NUMA
nodes, if the memory of an application is bound to the node 0 and 1,
AutoNUMA can potentially migrate the pages between the node 0 and 1 to
reduce cross-node accessing without breaking the explicit memory
binding policy.

So in this patch, we added MPOL_MF_AUTONUMA to mbind() and
MPOL_F_AUTONUMA to set_mempolicy().  With these flags specified,
AutoNUMA will be enabled within the memory area or thread to optimize
the page placement within the constrains of the specified memory
binding policy.  With these newly added flags, the NUMA balancing
control mechanism becomes,

- sysctl knob numa_balancing can enable/disable the NUMA balancing
  globally.

- even if sysctl numa_balancing is enabled, the NUMA balancing will be
  disabled for the memory areas or applications with the explicit memory
  policy by default.

- MPOL_MF_AUTONUMA and MPOL_F_AUTONUMA can be used to enable the NUMA
  balancing for the memory areas or applications when specifying the
  explicit memory policy.

Various page placement optimization based on the NUMA balancing can be
done with these flags.  As the first step, in this patch, if the
memory of the application is bound to multiple nodes (MPOL_BIND), and
in the hint page fault handler both the faulting page node and the
accessing node are in the policy nodemask, the page will be tried to
be migrated to the accessing node to reduce the cross-node accessing.

In the previous version of the patch, we tried to reuse MPOL_MF_LAZY
for mbind().  But that flag is tied to MPOL_MF_MOVE.*, so it seems not
a good API/ABI for the purpose of the patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
---
 include/uapi/linux/mempolicy.h | 10 +++++++---
 mm/mempolicy.c                 | 13 +++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774af61e..99afe7f4b61e 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -28,12 +28,14 @@ enum {
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
+#define MPOL_F_AUTONUMA		(1 << 13) /* Optimize with AutoNUMA if possible */
 
 /*
  * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
  * either set_mempolicy() or mbind().
  */
-#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
+#define MPOL_MODE_FLAGS							\
+	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_AUTONUMA)
 
 /* Flags for get_mempolicy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
@@ -46,11 +48,13 @@ enum {
 				   to policy */
 #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
 #define MPOL_MF_LAZY	 (1<<3)	/* Modifies '_MOVE:  lazy migrate on fault */
-#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
+#define MPOL_MF_AUTONUMA (1<<4)	/* Optimize with AutoNUMA if possible */
+#define MPOL_MF_INTERNAL (1<<5)	/* Internal flags start here */
 
 #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
 			 MPOL_MF_MOVE     | 	\
-			 MPOL_MF_MOVE_ALL)
+			 MPOL_MF_MOVE_ALL |	\
+			 MPOL_MF_AUTONUMA)
 
 /*
  * Internal flags that share the struct mempolicy flags word with
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898f3f24..37e4e76ded62 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -875,6 +875,9 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
+	if (new && new->mode == MPOL_BIND && (flags & MPOL_F_AUTONUMA))
+		new->flags |= (MPOL_F_MOF | MPOL_F_MORON);
+
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		mpol_put(new);
@@ -1278,6 +1281,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & ~(unsigned long)MPOL_MF_VALID)
 		return -EINVAL;
+	if ((flags & MPOL_MF_LAZY) && (flags & MPOL_MF_AUTONUMA))
+		return -EINVAL;
 	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_NICE))
 		return -EPERM;
 
@@ -1301,6 +1306,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 	if (flags & MPOL_MF_LAZY)
 		new->flags |= MPOL_F_MOF;
+	if (new && new->mode == MPOL_BIND && (flags & MPOL_MF_AUTONUMA))
+		new->flags |= (MPOL_F_MOF | MPOL_F_MORON);
 
 	/*
 	 * If we are using the default policy then operation
@@ -2490,6 +2497,12 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_BIND:
+		/* Optimize placement among multiple nodes via NUMA balancing */
+		if (pol->flags & MPOL_F_MORON) {
+			if (node_isset(thisnid, pol->v.nodes))
+				break;
+			goto out;
+		}
 
 		/*
 		 * allows binding to multiple nodes.
-- 
2.28.0

