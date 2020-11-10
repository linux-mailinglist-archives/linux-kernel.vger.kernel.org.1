Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9552ACF58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgKJGAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:00:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:16590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbgKJGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:00:44 -0500
IronPort-SDR: ljPb5munH+owk4/Mflm9ZUzVPt7vJcMMzqX5KR/8pDZpiiq07H1OVU7iEa65GLHnk7m2TiYY3J
 bHYGbEdVWFXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149773099"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="149773099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:43 -0800
IronPort-SDR: 2LYPzJLb+/AXPFNaNTGObsHzQ5gbjla3dXal+FXRuy7clHIYuIdENVqb0JUYDqgpCkbPsSqspR
 xRV/9OppJPcw==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="473300189"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:39 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH -V3 1/2] mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
Date:   Tue, 10 Nov 2020 13:59:50 +0800
Message-Id: <20201110055951.85085-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110055951.85085-1-ying.huang@intel.com>
References: <20201110055951.85085-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow code-of-conduct better.  Although the patch changes a user
visible flag definition in uapi, the flag isn't used by the user space
at all.  The flag is only used internally by kernel in struct
mempolicy flags field.  It is defined in uapi just to avoid to
conflict with MPOL_MODE_FLAGS.  The flag is upper case with prefix, so
it looks generally OK by itself.  But in the following patch, we will
introduce a label named after the flag, which is lower case and
without prefix, so it's better to rename it.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Acked-by: Rafael Aquini <aquini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
---
 include/uapi/linux/mempolicy.h | 2 +-
 kernel/sched/debug.c           | 2 +-
 mm/mempolicy.c                 | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774af61e..3c3666d017e6 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -60,7 +60,7 @@ enum {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
-#define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_MOPRON	(1 << 4) /* Migrate On Protnone Reference On Node */
 
 
 #endif /* _UAPI_LINUX_MEMPOLICY_H */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..8bfb6adb3f31 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -898,7 +898,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 
 	task_lock(p);
 	pol = p->mempolicy;
-	if (pol && !(pol->flags & MPOL_F_MORON))
+	if (pol && !(pol->flags & MPOL_F_MOPRON))
 		pol = NULL;
 	mpol_get(pol);
 	task_unlock(p);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898f3f24..63d91fbd3ce6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2511,7 +2511,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	}
 
 	/* Migrate the page towards the node whose CPU is referencing it */
-	if (pol->flags & MPOL_F_MORON) {
+	if (pol->flags & MPOL_F_MOPRON) {
 		polnid = thisnid;
 
 		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
@@ -2802,7 +2802,7 @@ void __init numa_policy_init(void)
 		preferred_node_policy[nid] = (struct mempolicy) {
 			.refcnt = ATOMIC_INIT(1),
 			.mode = MPOL_PREFERRED,
-			.flags = MPOL_F_MOF | MPOL_F_MORON,
+			.flags = MPOL_F_MOF | MPOL_F_MOPRON,
 			.v = { .preferred_node = nid, },
 		};
 	}
@@ -3010,7 +3010,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	unsigned short mode = MPOL_DEFAULT;
 	unsigned short flags = 0;
 
-	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
+	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MOPRON)) {
 		mode = pol->mode;
 		flags = pol->flags;
 	}
-- 
2.28.0

