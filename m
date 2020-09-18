Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C41F26F2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIRDCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgIRDBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:01:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9114C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207so3983990ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qvnHHsvBI3sH+b5g6Iv8RJ5s4+ZnaHU0vmrrO4o5gi4=;
        b=lqyqyA8BFWcwFuv/9+MGNQiOru0sKjIbm0eSJ1ByXF6JVc9vr8FDv47rnqSsdyTs7t
         S3NxZnk+2iO6CRHdaA4UalB3w3yZF3qC28jCD2uRk5cxex4zVBD5qDQbnTRcrAf07Nsc
         ygcQl37PtmLBFqLAL8rbF46ASLQ1gAydzClOP5DevnlAsHwK/PfIrGSFDMam+ySaujJT
         hanmi+54Txv+6VjCu9U3o7d4IJIv2iwSEqK4D9aDrbo1zTg7iqka8SpMD+NpS6lHugQs
         AtUjhjYt1eOv7g1ZT8k0bRjvxL28/U/JID1UhXh/ggjhBucFBF095ClBMUlEnjXVJwfd
         7itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qvnHHsvBI3sH+b5g6Iv8RJ5s4+ZnaHU0vmrrO4o5gi4=;
        b=JjhX6iIz5HUi1MAIkoWJmy6AkV9PHId/cs2rcutbMogVYPOd5EhmHrUXdAMrmchhsx
         42I9KT0sL/4kf3zWxJTtaYonqBjgIJs9NhmzYZzuasaAUJUmIa9fGvCl6D953fRxzRDK
         b3Ey/TYTsZ0s8g1ASwhttjEAzY/BeSrYRIuMPdhgzFBUM496xKg7CHL1KZNh6gyG1Zip
         2ZXOdw7hNX+/jJ/GhgaU42c4zHvaOcb2rjaAPc9vpqQmbgquPFBejGSh8DITNOLcvLuQ
         jIPBNaqgCqhS7qXJA+m5zelHQKbzhPGIXLytb5iRftbXFckz40yal+Hd83OSFWZ8r3Qb
         K+Yg==
X-Gm-Message-State: AOAM531z4y/nH6RnG71YKEfWxQl+8icC40CkvFuW65bGqbNuqamPum7o
        YLOVT2tZFWkmLMk7jG5ExU6BK2nmYj0=
X-Google-Smtp-Source: ABdhPJyA4fGWHBfcQZD/N2EVVdQdNHe3Em/oy/TsXnSZ8yngh1zsEqbYH+EijegunexsuYkqKBR265IH8Wg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:ad16:: with SMTP id y22mr6703066ybi.331.1600398060014;
 Thu, 17 Sep 2020 20:01:00 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:39 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 01/13] mm: use add_page_to_lru_list()
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

This patch replaces the only open-coded lru list addition with
add_page_to_lru_list().

Before this patch, we have:
	update_lru_size()
	list_move()

After this patch, we have:
	list_del()
	add_page_to_lru_list()
		update_lru_size()
		list_add()

The only side effect is that page->lru is temporarily poisoned
after a page is deleted from its old list, which shouldn't be a
problem.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9727dd8e2581..503fc5e1fe32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1850,8 +1850,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			list_del(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
@@ -1862,9 +1862,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 		lru = page_lru(page);
 
-		nr_pages = thp_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
+		add_page_to_lru_list(page, lruvec, lru);
 
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
@@ -1878,6 +1876,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
+			nr_pages = thp_nr_pages(page);
 			nr_moved += nr_pages;
 			if (PageActive(page))
 				workingset_age_nonresident(lruvec, nr_pages);
-- 
2.28.0.681.g6f77f65b4e-goog

