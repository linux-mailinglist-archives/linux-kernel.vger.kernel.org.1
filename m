Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0827384C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgIVCCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:02:05 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45652 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgIVCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:02:03 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kKXcv-0003Cm-DM; Mon, 21 Sep 2020 22:01:53 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, niketa@fb.com,
        akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        konrad.wilk@oracle.com, hannes@cmpxchg.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/2] mm,swap: extract swap single page readahead into its own function
Date:   Mon, 21 Sep 2020 22:01:47 -0400
Message-Id: <20200922020148.3261797-2-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200922020148.3261797-1-riel@surriel.com>
References: <20200922020148.3261797-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split swap single page readahead into its own function, to make
the next patch easier to read. No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/swap_state.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index c16eebb81d8b..aacb9ba53f63 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -594,6 +594,28 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	return pages;
 }
 
+static struct page *swap_cluster_read_one(swp_entry_t entry,
+		unsigned long offset, gfp_t gfp_mask,
+		struct vm_area_struct *vma, unsigned long addr, bool readahead)
+{
+	bool page_allocated;
+	struct page *page;
+
+	page =__read_swap_cache_async(swp_entry(swp_type(entry), offset),
+				      gfp_mask, vma, addr, &page_allocated);
+	if (!page)
+		return NULL;
+	if (page_allocated) {
+		swap_readpage(page, false);
+		if (readahead) {
+			SetPageReadahead(page);
+			count_vm_event(SWAP_RA);
+		}
+	}
+	put_page(page);
+	return page;
+}
+
 /**
  * swap_cluster_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
@@ -615,14 +637,13 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
 {
-	struct page *page;
 	unsigned long entry_offset = swp_offset(entry);
 	unsigned long offset = entry_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
-	bool do_poll = true, page_allocated;
+	bool do_poll = true;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
@@ -649,19 +670,8 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
-		page = __read_swap_cache_async(
-			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
-		if (!page)
-			continue;
-		if (page_allocated) {
-			swap_readpage(page, false);
-			if (offset != entry_offset) {
-				SetPageReadahead(page);
-				count_vm_event(SWAP_RA);
-			}
-		}
-		put_page(page);
+		swap_cluster_read_one(entry, offset, gfp_mask, vma, addr,
+				      offset != entry_offset);
 	}
 	blk_finish_plug(&plug);
 
-- 
2.25.4

