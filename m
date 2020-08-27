Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B22551B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgH0XmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 19:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0XmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:42:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u128so9527701ybg.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uX2C0brQgg3f8KYRiompEJ5CYWD+yHko0WX19R75qh8=;
        b=iCkxPIo12K6HRayC/lbc1sUHAkytPkhbNtKmEcONs+Z3rnesvOYfbff1WkffIQP/kl
         QHaXLH9YqCygDflVvqUyqRq3ZJQ9vWfwR6pZ/sSrXKzwcg4jpJtyEU4vXUHnap6tMb+Q
         RI0Q0d7cQOMA9T4enLSsBrfbo+F43F2Ze5qYoNJR0sHESGhJDXQ3BKVEhvgEq/Hj6r8p
         2tx8hknDosNfzWbosydyH1bDlEZhgMaJKjQcSKuVDCpkLg9CwnuCYcsKMXVvHZkpJQyT
         cOeD0y654fMR7YVn2VhPimn3LDfFaEF6V0/TgaAPtctzNlUF4pESeMYN65saopPFYcVD
         dhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uX2C0brQgg3f8KYRiompEJ5CYWD+yHko0WX19R75qh8=;
        b=hWaNzW4JPU9BICMkDySI44lP9Xxa7+h+JBHabBIHRWAoakXHQ4elVNIRq6TBaZYUcb
         u18jlOJEuuQ0tQgqDqU1rwyYcPLRFfpqGzt9eNxgU77Z0niggVC+XUChtRLYBmwENS+o
         w/BpGt7uEV44WorXsJrLxtycm+GzOsr1Juz4ZgqvB/yxetMhK8NT9yGw1b7kIjTc23AW
         aJd0Lam9GPTbIk1KC6mqP6fre/NaUTIywkg7jRobg2bcOiVi/Qhk56/wYboRQA8iopk6
         qP5jWreMyo7f1dbFdQBe+VL9SWfCIw4/4q6eQsqwxNQzBgczYrpQ0ehtNQZYNzERhzha
         /Psw==
X-Gm-Message-State: AOAM533UNYMoF0YwWQcC01YzD77z0FudjUWaHITTjxmP7MBOr1SdPJLE
        FMMUrSVJTlFn46AF4aLpVH1nLTleUo4=
X-Google-Smtp-Source: ABdhPJwr1O7Q0pzaHP/0dpJxBxlOQE337tFMlssyqq7bHrG5DkLvoMIjZO33y8/dm4RBOB2hEALMCyEuOgA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:dc85:: with SMTP id y127mr32591366ybe.462.1598571728326;
 Thu, 27 Aug 2020 16:42:08 -0700 (PDT)
Date:   Thu, 27 Aug 2020 17:42:01 -0600
Message-Id: <20200827234202.4027996-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH 1/2] mm: use add_page_to_lru_list()/page_lru()/page_off_lru()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial but worth having clean-up patch. There should be
no side effects except page->lru is temporarily poisoned after it's
deleted but before it's added to the new list in move_pages_to_lru()
(which is not a problem).

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c   |  4 +---
 mm/vmscan.c | 14 ++++----------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 40bf20a75278..2735ecf0f566 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -597,11 +597,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec,
-				       LRU_INACTIVE_ANON + active);
+		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796eb833..b479ced26cd3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1845,13 +1845,12 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
 	struct page *page;
-	enum lru_list lru;
 
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			list_del(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
@@ -1860,16 +1859,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
-		lru = page_lru(page);
-
-		nr_pages = thp_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
+		add_page_to_lru_list(page, lruvec, page_lru(page));
 
 		if (put_page_testzero(page)) {
-			__ClearPageLRU(page);
-			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -1878,6 +1871,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 			} else
 				list_add(&page->lru, &pages_to_free);
 		} else {
+			nr_pages = thp_nr_pages(page);
 			nr_moved += nr_pages;
 			if (PageActive(page))
 				workingset_age_nonresident(lruvec, nr_pages);
-- 
2.28.0.402.g5ffc5be6b7-goog

