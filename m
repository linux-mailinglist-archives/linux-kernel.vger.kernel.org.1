Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E3D300FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbhAVWIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbhAVWGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:06:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y1so6887149ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c4ouleZZAXyP3qydY74TQhV9ZSx17hh5bTzcAWO3/yk=;
        b=LJ4Yix2VskMpUEhAiL78cfZDxjzB/3aVHbtqNdaziJ2e9O7HzLZEr38cde4kZMqjhI
         w5XeiPekl7yVlhUlraMHTPWWN1AhSAlrfyqaspcro3faG4B9iIiZSJAbJtILO+ygDVwB
         giQmTZR1OqfJlHyBot2M7xj9v71DHuqhkqYlnNLt4fffp/BqeSiCeVM6CMTV+pWmWncS
         8qjn3JbHZ3vs2mIgq/AcGnsHz6iyYQBB3vU2s+mMiiAxK46mNO0mCRKTDQLDeJqLi32L
         TVdotZnoY2YRgunsmJDQi3x2Ez0bRd5w7HwtJo8NG7waS5Tetq/8a1vUnArVT0kqXfRE
         eb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c4ouleZZAXyP3qydY74TQhV9ZSx17hh5bTzcAWO3/yk=;
        b=bSoLlJgWhNj8LMTIwrAwV0joY2UwkW0AobEp97rfyr2WW0/Ivw6Vxh4Qbm0KN9J50N
         mrxq+rj3FPKI7yBK8Y/+61SlC5iiJTpsm+Fv8A7u4PwgJHTzUnLdu6xt2uoQKCuH+Yc/
         tAVpr3mNkeIyOvLwredMQyg5aTNgGhdsUF0ya+QPwyE+KrRQml2wYP2MJnhKQLecrGHd
         lVO73afd1oyM4y3GGKMl1RK1IYKJRcZZAbN57aYluYBsZozbvFBuImqcw4ldvY42wfU8
         iprzmcHeR/maCvnXWvjcu3Gmn0TtPxY6AFHaIcMa01uwiWrmLq4M/oXp8HEenfuGztAx
         Ex1A==
X-Gm-Message-State: AOAM531peWcRFND2ZVBN8CvKwTVsEhJQmoAR2QbqF28GnzEqIZNRmN2S
        FjbzTBdNaT1HGSGQ3noxygBSd694JMg=
X-Google-Smtp-Source: ABdhPJxwnkls4lek3K2Bu6I6WtNTJS4RqTJ/dfpcTohJcwpNyB1skccdLulymzj/A83VL8khtl5YjK1oQEc=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a25:ac5a:: with SMTP id r26mr9406387ybd.336.1611353164151;
 Fri, 22 Jan 2021 14:06:04 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:51 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 01/10] mm: use add_page_to_lru_list()
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

There is add_page_to_lru_list(), and move_pages_to_lru() should reuse
it, not duplicate it.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-2-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 mm/vmscan.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04509994aed4..19875660e8f8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1823,7 +1823,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
-	enum lru_list lru;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
@@ -1868,11 +1867,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 * inhibits memcg migration).
 		 */
 		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
-		lru = page_lru(page);
+		add_page_to_lru_list(page, lruvec, page_lru(page));
 		nr_pages = thp_nr_pages(page);
-
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_add(&page->lru, &lruvec->lists[lru]);
 		nr_moved += nr_pages;
 		if (PageActive(page))
 			workingset_age_nonresident(lruvec, nr_pages);
-- 
2.30.0.280.ga3ce27912f-goog

