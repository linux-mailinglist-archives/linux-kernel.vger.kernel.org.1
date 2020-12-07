Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BE2D1CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgLGWKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgLGWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:10:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83903C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:10:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z83so19808097ybz.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LIYHOEA3PKvDsVgiHjdmx9YU9pD0AIzqmU7pPjIkHgc=;
        b=SRTEYO3VD9UFrTY1qt4R0yH0vlwmlgziaRTQfYygwrkX8kNy7mRB36+gr8+gx+Ricp
         unh2OtzCqK8zJ12qwX0VbKP47DHd2l5cNXg5czCIaRSCXooTf2YEDoSXbqQ3h/VgumY9
         FKd4BDr6z736sF2hKk7wVbbtazgFcPIRnawoMSv7YOJuwyk3Z9lq9hLVSSvURNR27/4E
         7O8NNEbrDsxteqTwKomQvvq4EtDvjydc4r8eEXOzrjwT43RPCrjc+DYqdrVaI49TVzlA
         AHEsg3t1+MQQWc1iU5nj8IZlaumfDnRrGpQowv3JHTuT/VPTz37aoVPM+KDxF+sGmCx5
         0GCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LIYHOEA3PKvDsVgiHjdmx9YU9pD0AIzqmU7pPjIkHgc=;
        b=Gu2h/0D6uqZfhOEqViKU8RZ5bnjctTTJolB63n21+inyhA3k9p5LsxcYI5NeSDo7bu
         41p79N2cg0ORKdOP5n8jenB2Wo0UnXao/qhbYOIKQyxYxO2fRG08067Jqa7Lt3JL3e/T
         2piqxlgnugJTHVNi7236F1Dql2DWhm0Uvd9/ugWonv1Vj4ZakT199S6GQQYFtKOc6A3c
         neK34YV9UQhdFWXY1Lg7dNY5frTTjeL7ZC24E24LwiYJ0ZS9sa3sJu+DlpLsjsWO3Fzy
         Pg9bTpdk+aviCQxg6T90cZlAf1c6phOFle2jkyZWelrkvJTcnjqn74BpDnn5HEPOTfGJ
         NIQw==
X-Gm-Message-State: AOAM531b4zJlRrVC2D9lsrqH2SEaGcSS87LySLwVJrw3sbCrhm19uMZu
        q0he38JfM4vWAvZ77zHuGe40T/9cUvc=
X-Google-Smtp-Source: ABdhPJz7hXUtem/Ga7wk+XyAE/X9Oz3SO0UGGwnI81ZSyCjKlfiQlsGQVEWWGqaa80fwndrDIlmsA8Z7ciQ=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:2485:: with SMTP id k127mr13179519ybk.315.1607379001691;
 Mon, 07 Dec 2020 14:10:01 -0800 (PST)
Date:   Mon,  7 Dec 2020 15:09:39 -0700
In-Reply-To: <20201207220949.830352-1-yuzhao@google.com>
Message-Id: <20201207220949.830352-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20201207220949.830352-1-yuzhao@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH 01/11] mm: use add_page_to_lru_list()
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

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 469016222cdb..a174594e40f8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1821,7 +1821,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
-	enum lru_list lru;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
@@ -1866,11 +1865,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
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
2.29.2.576.ga3fc446d84-goog

