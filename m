Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24C2B75AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgKRFUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:20:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:27740 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgKRFUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:20:14 -0500
IronPort-SDR: azZ/U9eIFYCdecn0nH/cd49SyDxnyjpG1Q2h2srhBZxRwX1212XMmcHcLRgP8rRQqcZfnkwmRO
 ecXOJiRPzKqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170286041"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="170286041"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 21:20:13 -0800
IronPort-SDR: zETzxMIwYyRUJPsiHoDoeJfKTPXsZzNMPDL7/UcVojzH76zDvzbiJ4hPb9raPnSMirPsWBN6AX
 Ac5PMcyIWp1g==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544347034"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 21:20:10 -0800
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
Subject: [RFC -V5] autonuma: Migrate on fault among multiple bound nodes
Date:   Wed, 18 Nov 2020 13:19:52 +0800
Message-Id: <20201118051952.39097-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
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

So in this patch, we add MPOL_F_AUTONUMA mode flag to set_mempolicy().
With the flag specified, AutoNUMA will be enabled within the thread to
optimize the page placement within the constrains of the specified
memory binding policy.  With the newly added flag, the NUMA balancing
control mechanism becomes,

- sysctl knob numa_balancing can enable/disable the NUMA balancing
  globally.

- even if sysctl numa_balancing is enabled, the NUMA balancing will be
  disabled for the memory areas or applications with the explicit memory
  policy by default.

- MPOL_F_AUTONUMA can be used to enable the NUMA balancing for the
  applications when specifying the explicit memory policy.

Various page placement optimization based on the NUMA balancing can be
done with these flags.  As the first step, in this patch, if the
memory of the application is bound to multiple nodes (MPOL_BIND), and
in the hint page fault handler the accessing node are in the policy
nodemask, the page will be tried to be migrated to the accessing node
to reduce the cross-node accessing.

In the previous version of the patch, we tried to reuse MPOL_MF_LAZY
for mbind().  But that flag is tied to MPOL_MF_MOVE.*, so it seems not
a good API/ABI for the purpose of the patch.

And because it's not clear whether it's necessary to enable AutoNUMA
for a specific memory area inside an application, so we only add the
flag at the thread level (set_mempolicy()) instead of the memory area
level (mbind()).  We can do that when it become necessary.

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

Changes:

v5:

- Remove mbind() support, because it's not clear that it's necessary.

v4:

- Use new flags instead of reuse MPOL_MF_LAZY.

v3:

- Rebased on latest upstream (v5.10-rc3)

- Revised the change log.

v2:

- Rebased on latest upstream (v5.10-rc1)

Huang Ying (2):
  mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
  autonuma: Migrate on fault among multiple bound nodes
---
 include/uapi/linux/mempolicy.h | 4 +++-
 mm/mempolicy.c                 | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774af61e..adb49f13840e 100644
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
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898f3f24..dc77827e8c08 100644
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
@@ -2490,6 +2493,12 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
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
2.29.2

