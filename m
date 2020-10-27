Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ACF29A625
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894379AbgJ0IE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:04:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36586 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508689AbgJ0IDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:03:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id r10so347066plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LN3286O1QAMAK+WN2hg/G+SRa6WlZWbQzoibyYb4wWo=;
        b=PJog1NMte5d9AcJQ2N25yRGouMltF5NBzhqBTv5dYQmj59PEpXsswhsrU0LQ+VWVfn
         aLdhc9z+7+C3pAXFkSsi/4lSgs4MYKwF7uVxVl+NsaEQOQzS04XB6RLzkTkl9RkPB0Oq
         SkIb23JF1hsg16qTRBKdvWjTQabtx+3Q9R5e4k+VNRf43+TfAiWbkEICxD3t3+7NB7p7
         L8yLqDncE2eSZPNsDjZSHXJ2Wv2O3UCu1Gk29TEbivdr3CCZBt8Zstueo74xQ/0viaBY
         EDV9Pv6BY3iPIabSdepfkGEm9H2JQlMqBjsX0yyAsdIyNWdN466cnPESkPb7kZHS7hKf
         LJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LN3286O1QAMAK+WN2hg/G+SRa6WlZWbQzoibyYb4wWo=;
        b=LRUp+Qx2slchur2QcC4foK+TFsMdFLauhQAUNxcYJJsz9ZhUrKIK2VfO3GKJWNhY22
         u0v4RbS44AqTT1W2OyitV8jtvSz2s7mZnQ7kuXK6pc8k6U0wv+5+VBC+BDFo8pncToQp
         oHYs8F1uBo3Dv/0OapFqlFJiGOYm1Zlh6bUyN7gJ5tJWM/rcaBVJTk+y9sDvxdxPAy4a
         CG1xNKjYTnsLSSRCwpO95EkzHkUnB0kpdPEJWj3XMzUBuvjRGqga1sdrOfG8G6lARazI
         PToCDZTqc9IWaCfsiUjUT+cm6Hf1fms3So7BUjA0Ljz9ACHR10Ccs5inxgA5h/qZkpOV
         OFZQ==
X-Gm-Message-State: AOAM5314I8YxfD+Liny2pf0Y6DMBwcHnDRaNRsAadzwDexvfy1+hsjQ2
        bHoYqzqYjMfznrrP6Og4+r3DNA==
X-Google-Smtp-Source: ABdhPJy+4tj9XYz/K9k/YpdyvUdWeb1R34jmZQ+GTNvy94neoHvWyQPy95s/Z5NTlj+jeS4gGAA20g==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr971273pjo.85.1603785826642;
        Tue, 27 Oct 2020 01:03:46 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:46 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
Date:   Tue, 27 Oct 2020 16:02:55 +0800
Message-Id: <20201027080256.76497-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201027080256.76497-1-songmuchun@bytedance.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reparent the slab objects to the root memcg, when we free
the slab object, we need to update the per-memcg vmstats to keep
it correct for the root memcg. Now this at least affects the vmstat
of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
size is smaller than the PAGE_SIZE.

Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 22b4fb941b54..70345b15b150 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -875,8 +875,13 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 	rcu_read_lock();
 	memcg = mem_cgroup_from_obj(p);
 
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg || memcg == root_mem_cgroup) {
+	/*
+	 * Untracked pages have no memcg, no lruvec. Update only the
+	 * node. If we reparent the slab objects to the root memcg,
+	 * when we free the slab object, we need to update the per-memcg
+	 * vmstats to keep it correct for the root memcg.
+	 */
+	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-- 
2.20.1

