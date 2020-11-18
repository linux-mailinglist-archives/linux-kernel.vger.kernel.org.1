Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7852B836F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKRR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKRR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:57:30 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:57:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f3so1633035plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bsCN5N4JAInCrP+YslG6n3+5vM/Uc6NYHq4aIGZzdzI=;
        b=OGRSdH36h0ql+bIlfx/9tGobraLomjaMP/OGf7xW5gcwYX/S+wGFedmGUIuhxC0LSR
         hKh+6e2I/P/ivkmCMV69IPmrpjif2Ee1Qbd4bBoJSwf3dYAbZJYnAgcn0UOQks0sDsu0
         c4u4eFtfKg3wDQU/FXPU3e2Ai8Hn4c45tOv5CGexd5fJRohaQe0eZDQy5PhSlMm25KvC
         /LszuxocTrAvMgTq6qnAaJN4zBeBR9svkTdmnf+Qf21ndZE5kmVEd0mhclsv3+swrjB9
         BXkn/ihkNkSyShamgRdPhCvShPte1OaDz9gILzY6uLxXnU/qrb0SyR3Z+ZV6pRVFItSK
         lIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bsCN5N4JAInCrP+YslG6n3+5vM/Uc6NYHq4aIGZzdzI=;
        b=ezyBGycO2XYAl+REUxeYMW4jyTGzPVGEARgDCbPPE3xvOQlHamlhp+s5wxbYI10EkJ
         wdrbCAX1QRR0xJdTpyTFy8i6+bHNJpr7LUaQFTQf3BXLXfPuA8HZ8uD0HRQs9ZGWwvHz
         ce0RNJq60uXXEBfyEFeUJ6Okp2qrmWsZ4DBVMTsRWt9vvzrx9lRUAC+BV8HI0QwhxorT
         VXMnjfPLojZ1rfYpIClt1aLZyFSKMAq/Xa3V8dDI6RRZjq0Ac3z06FPOqEZbxCShTQIv
         0if3p6/W1jcOsRjqTVJLSLDii70Ncrl97D8KREr+2ESPp8iABauZzvPppSZ+fFOImAHt
         KPyg==
X-Gm-Message-State: AOAM531qUkH/trZN/z8BcVNv7BXt8kqMFGXibWlT2gZ28SUfhEOJYyWQ
        sfJpObiPaOde7mHYoJEuZT0QQ3rFVQUTgg==
X-Google-Smtp-Source: ABdhPJx00ige9yBV83xg5Lg2I5cK9a2WIVrg3dF4PjKIbJbAgldyXx0PiGCaJRFgGCNymksPSdS/KbohifO0IA==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a17:90a:f0c7:: with SMTP id fa7mr235213pjb.3.1605722249509;
 Wed, 18 Nov 2020 09:57:29 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:57:26 -0800
Message-Id: <20201118175726.2453120-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deprecation process of kmem.limit_in_bytes started with the commit
0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
explains in detail the motivation behind the deprecation. To summarize,
it is the unexpected behavior on hitting the kmem limit. This patch
moves the deprecation process to the next stage by disallowing to set
the kmem limit. In future we might just remove the kmem.limit_in_bytes
file completely.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 .../admin-guide/cgroup-v1/memory.rst          |  6 ++--
 mm/memcontrol.c                               | 35 +++----------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 52688ae34461..cb993d80194d 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -87,10 +87,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
-                                     This knob is deprecated and shouldn't be
-                                     used. It is planned that this be removed in
-                                     the foreseeable future.
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -EINVAL.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 45465c03a8d7..78d17b3181ad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3075,28 +3075,14 @@ static void memcg_free_cache_id(int id)
 int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
 			unsigned int nr_pages)
 {
-	struct page_counter *counter;
 	int ret;
 
 	ret = try_charge(memcg, gfp, nr_pages);
 	if (ret)
 		return ret;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
-	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
-
-		/*
-		 * Enforce __GFP_NOFAIL allocation because callers are not
-		 * prepared to see failures and likely do not have any failure
-		 * handling code.
-		 */
-		if (gfp & __GFP_NOFAIL) {
-			page_counter_charge(&memcg->kmem, nr_pages);
-			return 0;
-		}
-		cancel_charge(memcg, nr_pages);
-		return -ENOMEM;
-	}
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		page_counter_charge(&memcg->kmem, nr_pages);
 	return 0;
 }
 
@@ -3769,17 +3755,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-static int memcg_update_kmem_max(struct mem_cgroup *memcg,
-				 unsigned long max)
-{
-	int ret;
-
-	mutex_lock(&memcg_max_mutex);
-	ret = page_counter_set_max(&memcg->kmem, max);
-	mutex_unlock(&memcg_max_mutex);
-	return ret;
-}
-
 static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 {
 	int ret;
@@ -3845,10 +3820,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
 		case _KMEM:
-			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
-				     "Please report your usecase to linux-mm@kvack.org if you "
-				     "depend on this functionality.\n");
-			ret = memcg_update_kmem_max(memcg, nr_pages);
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -EINVAL;
 			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
-- 
2.29.2.299.gdc1121823c-goog

