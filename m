Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C87300FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbhAVWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbhAVWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:33 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C0C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:15 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id f27so5137077qkh.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZmSrucdUhBu46ZsatxD272VvmrYXHbHQXvEQVOPVFEU=;
        b=JDtFLQtwZpSOlcpXvoiegOK8F+gok3Wrg4bdahuoJvnzjlztUWI8/tu0HwoAahyWFz
         SuMAD59Jc4YV+MW4krHJVsk1jE+ac1kDyUZohdYROpKcHil8MvDPKu/cgX9d+tddYNli
         wpJrMyEgUgHf4Gl6fIGqnWpdCnRQF0ycGcH3Km+3wNKu9/s2S7evr+8qszwhFwJA0JOP
         fFWu1C1KxcPTiuxbyxKvNNMJ1LPLAWNOnm4RtSeEnVNOzEnmsIuxqJ/13TEQIYx+gtWZ
         tfxYjqGTlkoK7uYVT4702Gtnpf5HhUpEyJLEg9t4j6WscLE5xiHCV8t1GjqZoKurK3Wj
         xjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZmSrucdUhBu46ZsatxD272VvmrYXHbHQXvEQVOPVFEU=;
        b=GhWymV8Vszcydfu5EwMagLTQAHJIOEg/O2wVZmnmoq5vezYFsz3v/McV1QmiXtgYbH
         WKP1/eo+OTgdv4daCb5jO+QTZGmzPzJyVLGivaCMDZDUndCrP7MYkfjvf3qFqzko7Jab
         jLBL8lf6c8Xu8QwryLMB7phUTQpD2XVG6jDwU12bluj/9O6DSCYy7GlgwpV/PPeIJAVL
         ufpw6h7XA1NwX0uFrjkesQKeGpz8GR7mrVOaKGO70yqy4Sl+loQyDG46j8argQ7aLKOF
         E3FAJ6mtYlai4nJ2CrPSFTJUrUzQhVral1peUg5c6JrSz9xpwb6yLEqiCxQr1rognN1Q
         1Azg==
X-Gm-Message-State: AOAM531JOt9rTUUa7o6e0UKcW0aadx4HxmQxvfc94y79ss+AhESnzwzG
        aD1Gxu1PWe7JU9dZx/Su61zoVrFw1bg=
X-Google-Smtp-Source: ABdhPJxJR1g9iiLV+Adnxv8KJCed9JVynK18YwF71dNdHoqsbIPloddl3FMXhTeuyv1+nKRZcSzzSROoTHY=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a05:6214:125:: with SMTP id
 w5mr496804qvs.20.1611353174742; Fri, 22 Jan 2021 14:06:14 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:59 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 09/10] mm: fold __update_lru_size() into its sole caller
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
commit a892cb6b977f ("mm/vmscan.c: use update_lru_size() in
update_lru_sizes()").

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-10-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
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
2.30.0.280.ga3ce27912f-goog

