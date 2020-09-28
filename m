Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2134827B3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgI1SCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:48 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51225 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BB344EA0;
        Mon, 28 Sep 2020 13:55:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=n6jp16hT4oTH1
        dxVIOY600H59pcJD1Ay2zwRoDXWqKs=; b=MVxKSB4GH5gmkQT5B/PviITHQj+X5
        iQhMIQQGBGQqOH14ZUf8fjssIBRB8fPKYaJsoyu1TbzJW0SY83g2r+pIQHbG2j8L
        2VIkFQUPYRw37yia2BZPJvEB3o6Q6KRJkDB0B47a+U95sechbkVDhN5uQwtjPc87
        vePnt9Yw08q84BLbZSXbt2fG1hcw8elLooLaKZlCp3mfVe7tB7Z3L6jcjlEXZpmo
        QjXOF+wthQNjz/VdicXz92zyYK2HISx2seEmChC7Oe4LuP+WBuRu2+SWmBncxYbE
        ymjC15ggxyvaLozPGm2OqyiTakkQEE33OXB6Je3CyH5oObtDTSrYhbiEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=n6jp16hT4oTH1dxVIOY600H59pcJD1Ay2zwRoDXWqKs=; b=Qv2pOgr/
        SGuyEf0woWJpgrCAYYd82mBfIZuASR/78LOMlx9tRCv81jWke6LhdAK9V1VZb7dV
        4vcefVPgcFm0zgBWhXmuPtUW/bhlYW1DfSx1yX2q5hmNX56H7oSQvM9blKgE1Z4Q
        wt3xjsATwsLWxQCSBCSXVwkIATM7h4htQftSlLU5qIohzGtMf9ZNeksNA3yV+Nw3
        l3FbjV+U15qIIBymx9xspFV0AAv4nDSnQ+NeukDWV+EmyJpuMYz7D6RjC1n4Pv6H
        hsACRgIQWLkC1OYbd5dkqywSPy6beMrBoQdZBlpYkW1zjUo5If37UdPmxV5M+cD4
        J4dcIhMuUFQyQg==
X-ME-Sender: <xms:jiNyX8xUJxetqXSlo_issr4ezQCKzF_R-KWR7k420WsM36bveJDHSQ>
    <xme:jiNyXwR_9I26T1uDv7JLwTu6DHFP74zSUZdy_AKXBIEJ_sP9eD9iStwSiXXOoe8Ex
    fQpY6h-3rCX4rnmcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jiNyX-UESKLhGcfdfU4yCOwtmtFIeHVDPHckOix8tmbbxx7DZrihEw>
    <xmx:jiNyX6g_DysVkts9wAlW_LmBeeD0HdqmOOuT9m54HKxeg8tyCIUECA>
    <xmx:jiNyX-DO0qMDJTMMWpk_5U12WsA9otXPq_7JMmGC1z-OvBC3O3xKUw>
    <xmx:jiNyX2Yha-N8A9HxfuTKk3wYzC_laPBB8nDh6UOgCoX3wmCof5EIC2EYKG8>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBDD43064682;
        Mon, 28 Sep 2020 13:55:25 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 22/30] mm: thp: split PUD THPs at page reclaim.
Date:   Mon, 28 Sep 2020 13:54:20 -0400
Message-Id: <20200928175428.4110504-23-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

We cannot swap PUD THPs, so split them before swap them out. PUD THPs
will be split into PMD THPs, so that if THP_SWAP is enabled, PMD THPs
can be swapped out as a whole.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/swap_slots.c |  2 ++
 mm/vmscan.c     | 33 +++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 3e6453573a89..65b8742a0446 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -312,6 +312,8 @@ swp_entry_t get_swap_page(struct page *page)
 	entry.val = 0;
 
 	if (PageTransHuge(page)) {
+		if (compound_order(page) == HPAGE_PUD_ORDER)
+			return entry;
 		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, HPAGE_PMD_NR);
 		goto out;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eae57d092931..12e169af663c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1244,7 +1244,21 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (!PageSwapCache(page)) {
 				if (!(sc->gfp_mask & __GFP_IO))
 					goto keep_locked;
-				if (PageTransHuge(page)) {
+				if (!PageTransHuge(page))
+					goto try_to_swap;
+				if (compound_order(page) == HPAGE_PUD_ORDER) {
+					/* cannot split THP, skip it */
+					if (!can_split_huge_pud_page(page, NULL))
+						goto activate_locked;
+					/* Split PUD THPs before swapping */
+					if (split_huge_pud_page_to_list(page, page_list))
+						goto activate_locked;
+					else {
+						sc->nr_scanned -= (nr_pages - HPAGE_PMD_NR);
+						nr_pages = HPAGE_PMD_NR;
+					}
+				}
+				if (compound_order(page) == HPAGE_PMD_ORDER) {
 					/* cannot split THP, skip it */
 					if (!can_split_huge_page(page, NULL))
 						goto activate_locked;
@@ -1254,14 +1268,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					 * tail pages can be freed without IO.
 					 */
 					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+						split_huge_page_to_list(page,
+									page_list))
 						goto activate_locked;
 				}
+try_to_swap:
 				if (!add_to_swap(page)) {
 					if (!PageTransHuge(page))
 						goto activate_locked_split;
 					/* Fallback to swap normal pages */
+					VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER,
+						       page);
 					if (split_huge_page_to_list(page,
 								    page_list))
 						goto activate_locked;
@@ -1278,6 +1295,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				mapping = page_mapping(page);
 			}
 		} else if (unlikely(PageTransHuge(page))) {
+			VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
 			/* Split file THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
@@ -1303,9 +1321,12 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
-				flags |= TTU_SPLIT_HUGE_PMD;
-
+			if (unlikely(PageTransHuge(page))) {
+				if (compound_order(page) == HPAGE_PMD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PMD;
+				else if (compound_order(page) == HPAGE_PUD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PUD;
+			}
 			if (!try_to_unmap(page, flags)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked && PageSwapBacked(page))
-- 
2.28.0

