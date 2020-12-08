Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203D2D2835
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgLHJy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgLHJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:54:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD91C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:53:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v3so6700149plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CIOYlRgtphmf+WmK1R+aOhJzgaX/le8P/Q7sWamhAQ=;
        b=F38cAAV8Hsq7gNN4wz6Mlgpz78c9+U/9pMam2t514mSZvpMBMINEdbTKhTTGebaqxz
         tbZmtyC62U+wSA7GToz5yGiCDhXoeFbnGTc9w8nEDjfsHAwmMTaA7h7WcgL6lUEGajpr
         8vcZ40JKiLE+/RbRitqJSgAKVPmT6b9UHSOOE0gUoLfarLPo90g2jElNiJ+XvZtL2UAh
         u/RHXEcOqJZ2nxpxsJ155rLUV8wlysExb2Fc3FOc+1h32VXw8fpDS1TXmDRvJ8wmmXRS
         oy8LggNdBHaJAHu9rYDImijFL6FstkicZjOiijpa7dcSO4KIhPTlF2PHnmnzsKXN52DN
         mWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CIOYlRgtphmf+WmK1R+aOhJzgaX/le8P/Q7sWamhAQ=;
        b=cmpx9FfWVfsthYPMbqjv5T+8NesuOB61rV+AhSGLag+eqp+Cpwexc5ddXmSnXEBvQ0
         5gsmok8RE89Qh7t6Nd/HVleD5AfwagAgznn5WuEg4P8C5MQDym4p9VpkylC8g0cFFFZt
         PQ6fraW3X6IQdOzSo/Z4ioQFanhar2gEI3B6MltuDdn1kABy124JhPK98cpXr/keoFVK
         nkUpvke5THLiNsZt08Pi53BrdobW+tcvJUHRdrRl+ATLS/bZ2fyzkfFZ7qelMq9M0jZY
         edK9GK6ZZugrSh2Y9rXoKYHKduiJYLA5PryDVz7KaG5KEwla3s1TdlxJDnSuoJf8hO7J
         xmeA==
X-Gm-Message-State: AOAM530tCWBrlrPiUornKAkw1rkdJJuJ8vtvNg8akx6fDyjyunNp2ftb
        gjUUxURzXl/trNDZuXt/S5TYNQ==
X-Google-Smtp-Source: ABdhPJx6nCLdNO2wjDxRZ5BSzSgHPcLiRtQ+HqNdJSQt3D7SF5MhWPaaIZRVjVcBUrh4jPLZNuAlXw==
X-Received: by 2002:a17:902:a404:b029:d6:ebe0:6e57 with SMTP id p4-20020a170902a404b02900d6ebe06e57mr20588719plq.12.1607421222034;
        Tue, 08 Dec 2020 01:53:42 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id w9sm2496281pjq.0.2020.12.08.01.53.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:53:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        sfr@canb.auug.org.au, chris@chrisdown.name, laoar.shao@gmail.com,
        richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: optimize per-lruvec stats counter memory usage
Date:   Tue,  8 Dec 2020 17:51:32 +0800
Message-Id: <20201208095132.79383-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
to optimize memory usage.

The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
bytes per-memcg per-node where ncpu is the number of the possible CPU.
If there are c memory cgroup (include dying cgroup) and n NUMA node in
the system. Finally, we can save (152 * ncpu * c * n) bytes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v1 -> v2:
 - Update the commit log to point out how many bytes that we can save.

 include/linux/memcontrol.h |  6 +++++-
 mm/memcontrol.c            | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3febf64d1b80..290d6ec8535a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -92,6 +92,10 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+struct per_cpu_lruvec_stat {
+	s32 count[NR_VM_NODE_STAT_ITEMS];
+};
+
 /*
  * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
  * which have elements charged to this memcg.
@@ -111,7 +115,7 @@ struct mem_cgroup_per_node {
 	struct lruvec_stat __percpu *lruvec_stat_local;
 
 	/* Subtree VM stats (batched updates) */
-	struct lruvec_stat __percpu *lruvec_stat_cpu;
+	struct per_cpu_lruvec_stat __percpu *lruvec_stat_cpu;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eec44918d373..da6dc6ca388d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5198,7 +5198,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		return 1;
 	}
 
-	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
+	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct per_cpu_lruvec_stat,
 					       GFP_KERNEL_ACCOUNT);
 	if (!pn->lruvec_stat_cpu) {
 		free_percpu(pn->lruvec_stat_local);
@@ -7089,6 +7089,14 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
 
+	/*
+	 * Currently s32 type (can refer to struct per_cpu_lruvec_stat) is
+	 * used for per-memcg-per-cpu caching of per-node statistics. In order
+	 * to work fine, we should make sure that the overfill threshold can't
+	 * exceed S32_MAX / PAGE_SIZE.
+	 */
+	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE);
+
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-- 
2.11.0

