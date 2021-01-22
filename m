Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78A9300FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbhAVWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbhAVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:06:49 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F53C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:06 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d1so4558980qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zqJBSEFOCSzIlkUNnwRdzfLTBxKdVKLR5dZ8YTF2q6U=;
        b=rG/XTRwLXknzPDC4uYHVqOY/HbH5hHEQ0yFdGo+ZZKfsDhtzx12Cuti8WHf/zvmsyy
         sBFU7cHHAd7O08AQohRUGzPfke0djxwWn9N0NIcQVBArSupoca61FjSEFgn49UUmYsAY
         pM3nTXPYjd63HQ99os/k79RDZHB3rGbH5W4MIyWq4DwRGfq5c37hSp08YTbyv4CSvIrI
         RKRtA4nhcMtD87Q9Fy1bUo6VQ8ughjnUbMU6loLyrElRkDkWOogdp3MzlHDS4hbi+7hv
         v62UDbh3ZaMLytm0blgPvrZwhmTvTYhwR0bE4cK656rN6wcioXm+xenrXnfX2A2TTkB5
         HnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zqJBSEFOCSzIlkUNnwRdzfLTBxKdVKLR5dZ8YTF2q6U=;
        b=TZB8auBXQbyrcN0rs6ZveRGDaK3XCrTC+mhmhgzNqKV6JLTNi/xIlvNqH3VubXxumb
         1BIvxzaYSBIFjmgeP/xSnBz+SAeSgth+B3kN1rIoLkaeD9MPAQN4ZQZ7KrP0YEFuG0PR
         K/dRkWf5flF8j28HaBZisIUYbjno0YIYLew/YN0Kkj8ihRY2OGZro3ga6uoqp9LknPE9
         vhOczFwVkA0TYU8q36DUY0wgfuTPqvU9QBkZajPB/0VFNhvfgE+zPAAywd1pccYtvOra
         v1mo/nWebT78tknZ8zUx9xmtVSi6q2/7Y6kc94TUxPtxyun8mEefu576ZH7PZhz6syi0
         5CMQ==
X-Gm-Message-State: AOAM530tYgwzSdQvw3VN2u3ihTlvd2ALAMgnVlmDOyODMSv4mgYs2W5O
        qBl9ZMcRbtEIsWIV5Gs4S6tskbGObLc=
X-Google-Smtp-Source: ABdhPJwlAztSJs7BRfLWDrzsSVMS5kBimqXyS88rYohA6fu8gn8Ysp1ivWG7MGrOqyqiWMi9AjdSlsdSKrU=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5129:9a91:ef0e:c1a9])
 (user=yuzhao job=sendgmr) by 2002:a0c:ac44:: with SMTP id m4mr6659932qvb.45.1611353165356;
 Fri, 22 Jan 2021 14:06:05 -0800 (PST)
Date:   Fri, 22 Jan 2021 15:05:52 -0700
In-Reply-To: <20210122220600.906146-1-yuzhao@google.com>
Message-Id: <20210122220600.906146-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20210122220600.906146-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v2 02/10] mm: shuffle lru list addition and deletion functions
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

These functions will call page_lru() in the following patches. Move
them below page_lru() to avoid the forward declaration.

Link: https://lore.kernel.org/linux-mm/20201207220949.830352-3-yuzhao@google.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8fc71e9d7bb0..2889741f450a 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -45,27 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 #endif
 }
 
-static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add(&page->lru, &lruvec->lists[lru]);
-}
-
-static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add_tail(&page->lru, &lruvec->lists[lru]);
-}
-
-static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
-}
-
 /**
  * page_lru_base_type - which LRU list type should a page be on?
  * @page: the page to test
@@ -125,4 +104,25 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	}
 	return lru;
 }
+
+static __always_inline void add_page_to_lru_list(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	list_add(&page->lru, &lruvec->lists[lru]);
+}
+
+static __always_inline void add_page_to_lru_list_tail(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	list_add_tail(&page->lru, &lruvec->lists[lru]);
+}
+
+static __always_inline void del_page_from_lru_list(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	list_del(&page->lru);
+	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
+}
 #endif
-- 
2.30.0.280.ga3ce27912f-goog

