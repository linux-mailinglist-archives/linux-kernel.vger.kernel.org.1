Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07F28D157
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgJMPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgJMPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:36:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:36:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so51571pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ox95qvJhDnil9bz6yooXTHbNTLkLwItEwWWK2Vi73M=;
        b=VkeuT8BUzhjPjsJacswMkrJ0NijklYP+nB3jOT+GvqiI3jx9FYGbjzyvaOrykMOTF2
         nSwhF1EkJx4O34zdFgah/jIOv21/bjPnc+z3Khu3mqLcLmHy7NPih0fmH00mB3syuP9D
         Kt9lm9OYx6UjIAyofJRA/M9Shp6L24sqIM1P9YbzIEW3opjnQZ3aIxUCL0Z3dTuphIjz
         OsS5rI3XCbb+Dwx4D5qkxAfyNEO/8ZN5z+1fmfy2vB8UYG8+zCOsN7u9N65nDZfk4JBQ
         MupQAZg3r9b28VEDDcm7XOnGPmt9tz8zLckQGUGSUVNoWyMcs1BL+0x5u2YJTOG0zo60
         OLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ox95qvJhDnil9bz6yooXTHbNTLkLwItEwWWK2Vi73M=;
        b=jSQu9/kQO5QzX6OL+gz8qpA+poxOoype+f8Habnu2P1hrMx+G5C+r97vRuO6CHfoMg
         N7mv9apbKXIRCHfT0qPk6W3lrsp1Fz1WpToszRcMoEzOesjvJoDu0o4hniEzLhjetqRm
         j3oPfY7otylIDcSwfITMziqxTOMUClu2ZYi5M1rczsmTVcFfQWhG3GzvTEpYQxIRukLF
         kZeQDYoj6NoDckJgcVIOvjJ7F5Y1LgtxB3LTFyvVaKi5/NJnZ3D/pRKO6dAi1YBCt6FS
         tt5pO0YyjHzEtzLr/aftddoN+7Gqoo7ZyaKRKdIcIirM+grm0XPGcpPNM+h//9jTl1P/
         rGtQ==
X-Gm-Message-State: AOAM531tPL0lj4yzjdbPfnzF07jobgnKhr8TwGkV7L9hOzM9BAcBsCHx
        I6a3tkCh8zOXCjD9Z5XM3ZNq2Q==
X-Google-Smtp-Source: ABdhPJx8AJmn2NrpVgs33N+C6pPbGr20NVTb5i0f0/DACBLUktB2tjoItgXyeq3rsE7kjeb0EXkS2w==
X-Received: by 2002:a17:90a:f617:: with SMTP id bw23mr278783pjb.95.1602603391282;
        Tue, 13 Oct 2020 08:36:31 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id y124sm14083pfy.28.2020.10.13.08.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 08:36:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, shakeelb@google.com,
        guro@fb.com, vbabka@suse.cz, laoar.shao@gmail.com,
        songmuchun@bytedance.com, chris@chrisdown.name
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: memcontrol: Remove unused mod_memcg_obj_state()
Date:   Tue, 13 Oct 2020 23:35:04 +0800
Message-Id: <20201013153504.92602-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:

  991e7673859e ("mm: memcontrol: account kernel stack per node")

There is no user of the mod_memcg_obj_state(). This patch just remove
it. Also rework type of the idx parameter of the mod_objcg_state()
from int to enum node_stat_item.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  6 ------
 mm/memcontrol.c            | 11 -----------
 mm/slab.h                  |  4 ++--
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a1395b584947..d7e339bf72dc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -795,8 +795,6 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 
-void mod_memcg_obj_state(void *p, int idx, int val);
-
 static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
 					 int val)
 {
@@ -1245,10 +1243,6 @@ static inline void mod_lruvec_slab_state(void *p, enum node_stat_item idx,
 	mod_node_page_state(page_pgdat(page), idx, val);
 }
 
-static inline void mod_memcg_obj_state(void *p, int idx, int val)
-{
-}
-
 static inline
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					    gfp_t gfp_mask,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2124ded698b2..1337775b04f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -885,17 +885,6 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_unlock();
 }
 
-void mod_memcg_obj_state(void *p, int idx, int val)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-	memcg = mem_cgroup_from_obj(p);
-	if (memcg)
-		mod_memcg_state(memcg, idx, val);
-	rcu_read_unlock();
-}
-
 /**
  * __count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
diff --git a/mm/slab.h b/mm/slab.h
index 4a24e1702923..725a0bb8b317 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -204,7 +204,7 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 void __kmem_cache_free_bulk(struct kmem_cache *, size_t, void **);
 int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
 
-static inline int cache_vmstat_idx(struct kmem_cache *s)
+static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 {
 	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
@@ -294,7 +294,7 @@ static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 
 static inline void mod_objcg_state(struct obj_cgroup *objcg,
 				   struct pglist_data *pgdat,
-				   int idx, int nr)
+				   enum node_stat_item idx, int nr)
 {
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-- 
2.20.1

