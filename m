Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E426F2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgIRDBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgIRDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9257C061224
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q131so3389431qke.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wq04R7kZnQOtaC6LIn5FEyAUuNq1+kFsvgljt2u93LM=;
        b=gMRyeCTkVNljPnLMYO/c5iwSUJPLZYnD8yVlrpNnYNQl+BUx4Gp6/CVq2UXghQXGL0
         DsDMaadax8KWE8X5qaIMvpG6T690scGvd3Umzz2c8LXQDxhE5P42VbtJwYEG5wO+jFGZ
         L1gYoNlhdLpsUUd9kzHg0DoMrL069TOq4UpyUgaStksAyD4JM0446iezsZlMDIKjXeVJ
         K+15ABfhWQghGRPSS5tivLNMvFtAiisjVBtwvc/dxiDYVE6hCRMbnimrwIAZSPG1X0g0
         7Db4ovJPLWWGZgL8IdeKqCGHLlA8tr+98Io6ncueImMNiVlVOpsrvmFQY4NauP0wGXb6
         Swbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wq04R7kZnQOtaC6LIn5FEyAUuNq1+kFsvgljt2u93LM=;
        b=mGI5b1NVIoUryOiesZgVqBl5Q8XqtOG1+SkCAMbmnXo0e5j8PLRFcPq+Tx0BNYDXZ5
         KuY1kKt9gGYn7OrsLiGDBYmT/buoJTg7Re0jcns2YnVMD41QEQgN99XbOrc4pDfP1qQg
         7ljNab0Tj0Z1JgEQ3d+0R66pO5skbda0tagpP51K+VEGTiu+RHXxuigrkQlDULZhYCgG
         HwXX0Bd2BTY4CqezRLqZuRrSNO/sXe+ryL8Dtq8wYTkZ2RZVLjvVziDaYyjQY9RFoMrl
         k+Znx0j0194KHppM+8ZwOrWEEjDz4UEm3JCZD8Pcn/vZSD/AjNpe2w+52z2CVrNDRtdu
         85Bg==
X-Gm-Message-State: AOAM530PfkYfw8s3a/VTwPcGpS9w7t0byd/NQ+O7VtxMfW/TrlyxQZQH
        Ia04BL1PsgeymiVfu8sweHiWVhgk/Vc=
X-Google-Smtp-Source: ABdhPJxaysxGdARme+9yjmforBPIN7Zkq7S72PiA++g2NnAT+54HUXkrR7L5CWXZOP3wm2phDI5l8TxTG5E=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:aed5:: with SMTP id n21mr32541779qvd.20.1600398074007;
 Thu, 17 Sep 2020 20:01:14 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:49 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-12-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 11/13] mm: inline __update_lru_size()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other references to the function were removed after
commit a892cb6b977f ("mm/vmscan.c: use update_lru_size() in update_lru_sizes()")

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 7183c7a03f09..355ea1ee32bd 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -24,7 +24,7 @@ static inline int page_is_file_lru(struct page *page)
 	return !PageSwapBacked(page);
 }
 
-static __always_inline void __update_lru_size(struct lruvec *lruvec,
+static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				int nr_pages)
 {
@@ -33,13 +33,6 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
-}
-
-static __always_inline void update_lru_size(struct lruvec *lruvec,
-				enum lru_list lru, enum zone_type zid,
-				int nr_pages)
-{
-	__update_lru_size(lruvec, lru, zid, nr_pages);
 #ifdef CONFIG_MEMCG
 	mem_cgroup_update_lru_size(lruvec, lru, zid, nr_pages);
 #endif
-- 
2.28.0.681.g6f77f65b4e-goog

