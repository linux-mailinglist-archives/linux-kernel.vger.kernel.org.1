Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B7300F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbhAVWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbhAVWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:06:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k33so6848277ybj.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=v825TuBJU359gqimRLyU0L4kx6zR5e87EOsaxQ3/+pY=;
        b=vX1/VB6OOOfUKCNJCysnx2cH3bEfyD11W9g28UBKgMxrU+mRNFPZVqAkpplFzOdE74
         5q5Ht10jKYI1z43rwA7vx/VUajqbwddShlGhUWcGEFtYslzjALozvAzzq78DZN8Cy8Vi
         NziDfiYZLpiXANXhIjZlCLxHLgMpAG0wpjefHOOvx+hKzbeQEeGCkzM/hhfU4KWfYJIX
         IeMWn/h81ShrunphLQOlPmlFo9LaJP7PUABjBre4jDlA2+r3Lok0rtZtJdQvP9LikCyP
         B7dEojxmXoRiDSSGjGwxXgqOsTLaDksKqiiwDERgNNJ+N30jq3w4UufK/juMzcDgrQOv
         +5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=v825TuBJU359gqimRLyU0L4kx6zR5e87EOsaxQ3/+pY=;
        b=m1Eqrmhjml8lyQR6PzkMECancLZtVdwDJWAPacvTur9v/IPw5OqhTL/vEk9STsgy8E
         3Lcqi9wc9gUtINVhSFgvHlGym5mWNKjUAiVE43IOiu1Rg0kZlUhUM0NxtezfcIdVK8hJ
         zgZBMJ+tgsB7D7nAeZY4P46crfCcrUJPv/atxLH6eKca++9yvvBKh0eQ1lqKx55NzcrR
         kB1lz3vnt1M2sJTJJ9aamqPd/c1Z5TepXxexiXpah1HD1eikypGA/ASJwg6wbSkXJplD
         kI602PwRDXCwtDqh7LuHl+NAMan1606gs6gTPThPv9UVD0yg/FL+2FJQJt5tx23yQymb
         ydxQ==
X-Gm-Message-State: AOAM533zCsiJXDKXPX6I+pVbbMx4mdk4Ci64z0ybqI1PNqP7fkCtl30t
        9MgI4uwBCO3pPke4uMdRGZHIf7RoU0s=
X-Google-Smtp-Source: ABdhPJzizdI1Pctd47HT9kYj/ZlA3ro/gwt1sqn9CT7+iZLcmBgO8kcRrbRVt7fvr1U0zz7GrnIzqknqmnA=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:2a86:: with SMTP id q128mr10168393ybq.387.1611353162833;
 Fri, 22 Jan 2021 14:06:02 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:50 -0700
Message-Id: <20210122220600.906146-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 00/10] mm: lru related cleanups
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

The cleanups are intended to reduce the verbosity in lru list
operations and make them less error-prone. A typical example
would be how the patches change __activate_page():

 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
 	if (!PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru);
+		del_page_from_lru_list(page, lruvec);
 		SetPageActive(page);
-		lru += LRU_ACTIVE;
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);

There are a few more places like __activate_page() and they are
unnecessarily repetitive in terms of figuring out which list a page
should be added onto or deleted from. And with the duplicated code
removed, they are easier to read, IMO.

Patch 1 to 5 basically cover the above. Patch 6 and 7 make code more
robust by improving bug reporting. Patch 8, 9 and 10 take care of
some dangling helpers left in header files.

v1 -> v2:
  dropped the last patch in this series based on the discussion here:
  https://lore.kernel.org/patchwork/patch/1350552/#1550430

Yu Zhao (10):
  mm: use add_page_to_lru_list()
  mm: shuffle lru list addition and deletion functions
  mm: don't pass "enum lru_list" to lru list addition functions
  mm: don't pass "enum lru_list" to trace_mm_lru_insertion()
  mm: don't pass "enum lru_list" to del_page_from_lru_list()
  mm: add __clear_page_lru_flags() to replace page_off_lru()
  mm: VM_BUG_ON lru page flags
  mm: fold page_lru_base_type() into its sole caller
  mm: fold __update_lru_size() into its sole caller
  mm: make lruvec_lru_size() static

 include/linux/mm_inline.h      | 113 ++++++++++++++-------------------
 include/linux/mmzone.h         |   2 -
 include/trace/events/pagemap.h |  11 ++--
 mm/compaction.c                |   2 +-
 mm/mlock.c                     |   3 +-
 mm/swap.c                      |  50 ++++++---------
 mm/vmscan.c                    |  21 ++----
 7 files changed, 77 insertions(+), 125 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

