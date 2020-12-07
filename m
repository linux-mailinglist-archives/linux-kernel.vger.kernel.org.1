Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4D2D1CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgLGWKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:10:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7294C061794
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a13so19793074ybj.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yunM0GzjyBS9Tj5OpBUgPwlJ+GO4Rh/4ODWoqMPhgLY=;
        b=L/5sxQoi/steUdZ1iakY0CpLHtXtlyL4xGgsmB6jlyk96aUMo0Xjqf9ctO1MUu9GEY
         fwogQLmTERTk/34k9lC7+R0nKY1/HVvqflMAVjVn/7fiC8t5pReZawJFMOLgYUuLZ6zs
         K7nRT3UY+mxBYKOab765OT3uPDwVX01ruKvCgznxOXWJcnj4IXqDC7+lVFa6nzPjtAz8
         H3MQrexyDtxUVmFtNlzMIFY+4oWZGeJzaDTY/7EZYNCalujNmHZED6tplTZ/NKRC35bP
         h716FyyJJnRXFZ63choQC2Tg4m9SAkgi1/iIkM15cdfkILsGTTCQeNyZczeWXDVj1mA3
         yXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yunM0GzjyBS9Tj5OpBUgPwlJ+GO4Rh/4ODWoqMPhgLY=;
        b=nuEP+NJyEXXxa5d2XkWOPvWoUfLhJq+NuO6JqKsXUcibGL1MSKGVmli1Imsfy6u981
         JriGfuHHzI/uWAM2lVYs8ifjOgl6ffCDZvezrZZ4C5M4+6XBzGiIQEIZssq+zEvDzPun
         30Bb9nbFqhXFjb3YbNnDxuvc2ruUO7lvPyzC48hw+oAVda94i0LX6b3TNORrFoGJx5xA
         UKTp56+Ai03iaJ3BDwXznREvvsw7bTsHWI62u3qDNCK103fVHKyjBvQYNfyT0gAk03qU
         rPevW2qdLbd94ZANITCoR/okBDks2XXPdsESXMJg89D3kJaDnTLQoeuM5tSmwMoGphUI
         I2Zg==
X-Gm-Message-State: AOAM533W4pz5SRGDVOyGs10d6PjmsTeKDZS9hbxaSYj+e2sN5F0dnXHg
        /xIExa9w9lSkHTLm/AMoxeAkI6GNrOo=
X-Google-Smtp-Source: ABdhPJxfxXnIKekgCXL9sgcYlVQb7+vLQGjiaJKdHs4NLWPelxbqlH5ESdSC6kZZmkhVSKxz6DQ2sk1Vf1k=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:d18c:: with SMTP id i134mr26549772ybg.448.1607379002924;
 Mon, 07 Dec 2020 14:10:02 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:40 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 02/11] mm: shuffle lru list addition and deletion functions
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
2.29.2.576.ga3fc446d84-goog

