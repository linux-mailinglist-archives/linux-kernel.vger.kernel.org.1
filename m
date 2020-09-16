Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2526BDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIPH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgIPH1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F149CAC4D;
        Wed, 16 Sep 2020 07:27:20 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:27:02 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200916072658.GA10692@linux>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915212222.GA18315@cathedrallabs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:22:22PM -0400, Aristeu Rozanski wrote:
> Hi Oscar, Naoya,

Hi Aristeu,

thanks for reporting this.

> I've run these tests using mmotm and mmotm with this patchset on top.

Could you please re-run the tests with the below patch applied, and
attached then the logs here?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 84a7f228af36..d7b6e7724e47 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -67,6 +67,7 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
+	dump_page(page, "page_handle_poison");
 	if (release) {
 		put_page(page);
 		drain_all_pages(page_zone(page));
@@ -77,7 +78,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 		 * Doing this check for free pages is also fine since dissolve_free_huge_page
 		 * returns 0 for non-hugetlb pages as well.
 		 */
-		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
+		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page)) {
 			/*
 			 * We could fail to take off the target page from buddy
 			 * for example due to racy page allocaiton, but that's
@@ -85,7 +86,9 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
 			 * and if someone really want to use it, they should
 			 * take it.
 			 */
+			pr_info("%s: hugepage_or_freepage failed¸n", __func__);
 			return false;
+		}
 	}
 
 	SetPageHWPoison(page);
@@ -1858,8 +1861,11 @@ static int __soft_offline_page(struct page *page)
 		if (!ret) {
 			bool release = !huge;
 
-			if (!page_handle_poison(page, true, release))
+			if (!page_handle_poison(page, true, release)) {
+				pr_info("%s: page_handle_poison -EBUSY\n", __func__);
+				dump_page(page, "__soft_offline_page after migrate");
 				ret = -EBUSY;
+			}
 		} else {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
@@ -1872,6 +1878,7 @@ static int __soft_offline_page(struct page *page)
 	} else {
 		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
 			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
+		dump_page(page, "__soft_offline_page isolation failed");
 		ret = -EBUSY;
 	}
 	return ret;
@@ -1882,8 +1889,11 @@ static int soft_offline_in_use_page(struct page *page)
 	struct page *hpage = compound_head(page);
 
 	if (!PageHuge(page) && PageTransHuge(hpage))
-		if (try_to_split_thp_page(page, "soft offline") < 0)
+		if (try_to_split_thp_page(page, "soft offline") < 0) {
+			pr_info("%s: try_to_split_thp_page -EBUSY\n", __func__);
+			dump_page(page, "try_to_split_thp_page");
 			return -EBUSY;
+		}
 	return __soft_offline_page(page);
 }
 
@@ -1891,8 +1901,11 @@ static int soft_offline_free_page(struct page *page)
 {
 	int rc = 0;
 
-	if (!page_handle_poison(page, true, false))
+	if (!page_handle_poison(page, true, false)) {
+		pr_info("%s: page_handle_poison -EBUSY\n", __func__);
+		dump_page(page, "soft_offline_free_page");
 		rc = -EBUSY;
+	}
 
 	return rc;
 }

Thanks

-- 
Oscar Salvador
SUSE L3
