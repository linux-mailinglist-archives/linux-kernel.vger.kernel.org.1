Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B80300FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbhAVWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbhAVWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07CC0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 9so6898834ybj.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sJrGKpeNyS1dvitdd7/CVnT7XOMWnD+nOyuu7AB/5R8=;
        b=PaYjsBYtTrDDzt5pYHU45kKGTmhrNTR9niMbhBSqDsMoox5X12em6igRycW0igVlgQ
         WxYjb5IAcekuqf0FhM7WgFy2xY1z+bc+YGS0Z/kFg8we4hH3dBYUIupKPSCHGlB4txuO
         oTjmO9rC5AhWBEOnbBUXuskVtfnPAwCd916qiG5SCaNKF18/GjlXAF9yZ3S3SjVDii16
         u/BWgizAru+RCL2BfbWZYTvSVBowHENz8ukh55NOJD6/yQMuCkmzPxVPaXg8w/O2p6cv
         6fxbrKTqoMoPsl7R++kGfJZo0/PWmHk+f/0pJcXc470nwx2TMgBJ5CGAKAOTdiJrHBsI
         OUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sJrGKpeNyS1dvitdd7/CVnT7XOMWnD+nOyuu7AB/5R8=;
        b=oSST45NnoNe0i7s937cx0c6Mke9QqqzrX1lJU4DmbMpNABL/MRZKgoNfUo2Psfo+fZ
         4xZadqDgm1u9G01obFCiDTVfwbLPlI9XTfenNj8Bv9FJkbgUuE7EOmfr9OZNpyzOrR2a
         0pbit3/wpcdvVp6140tH+hq6uCw88asxcKrpy5ztlWBhodP/Iqg1UgIJ/+Fgbqem4R3y
         rFYy2pdVqocscjFMCA/HXnO+qvxi79oHe2tnuyKp0IuPD129x8eNJnvxvjkgJXxgG2Xp
         zfUQqSALZgpxtxRLr42W/cniiAA6SByWmaRA/z2pm2/0m7sb6mWFbe/oYE1ID0BWkYqX
         MpcA==
X-Gm-Message-State: AOAM533SFqop5T7w/Mfi3kRKLjEzl5aVTo29KdCl1GrdYO34YYqqddKq
        X7LzQ2f4sz0+oXyU3/A2p0DxZVd+sVM=
X-Google-Smtp-Source: ABdhPJyZ6IfKOqnLhsNxU/fgAPLEHfJH6yEHcszvuzoztIspZM4HsxAWYCZhYyJA4ml1smYkHtPKLVsvVGY=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:6187:: with SMTP id v129mr9256460ybb.318.1611353176247;
 Fri, 22 Jan 2021 14:06:16 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:06:00 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 10/10] mm: make lruvec_lru_size() static
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other references to the function were removed after
commit b910718a948a ("mm: vmscan: detect file thrashing at the reclaim
root").

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-11-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 include/linux/mmzone.h | 2 --
 mm/vmscan.c            | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae588b2f87ef..844bb93d2a1e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -892,8 +892,6 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
 #endif
 }
 
-extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
-
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 348a90096550..fea6b43bc1f9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -310,7 +310,8 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  * @lru: lru to use
  * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
  */
-unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
+static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
+				     int zone_idx)
 {
 	unsigned long size = 0;
 	int zid;
-- 
2.30.0.280.ga3ce27912f-goog

