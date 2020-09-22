Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB627384D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgIVCCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:02:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45670 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgIVCCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:02:04 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kKXcv-0003Cm-EZ; Mon, 21 Sep 2020 22:01:53 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, niketa@fb.com,
        akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        konrad.wilk@oracle.com, hannes@cmpxchg.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/2] mm,swap: skip swap readahead if page was obtained instantaneously
Date:   Mon, 21 Sep 2020 22:01:48 -0400
Message-Id: <20200922020148.3261797-3-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200922020148.3261797-1-riel@surriel.com>
References: <20200922020148.3261797-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether a swap page was obtained instantaneously, for example
because it is in zswap, or on a very fast IO device which uses busy
waiting, and we did not wait on IO to swap in this page.

If no IO was needed to get the swap page we want, kicking off readahead
on surrounding swap pages is likely to be counterproductive, because the
extra loads will cause additional latency, use up extra memory, and chances
are the surrounding pages in swap are just as fast to load as this one,
making readahead pointless.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/swap_state.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index aacb9ba53f63..6919f9d5fe88 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -637,6 +637,7 @@ static struct page *swap_cluster_read_one(swp_entry_t entry,
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
 {
+	struct page *page;
 	unsigned long entry_offset = swp_offset(entry);
 	unsigned long offset = entry_offset;
 	unsigned long start_offset, end_offset;
@@ -668,11 +669,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		end_offset = si->max - 1;
 
 	blk_start_plug(&plug);
+	/* If we read the page without waiting on IO, skip readahead. */
+	page = swap_cluster_read_one(entry, offset, gfp_mask, vma, addr, false);
+	if (page && PageUptodate(page))
+		goto skip_unplug;
+
+	/* Ok, do the async read-ahead now. */
 	for (offset = start_offset; offset <= end_offset ; offset++) {
-		/* Ok, do the async read-ahead now */
-		swap_cluster_read_one(entry, offset, gfp_mask, vma, addr,
-				      offset != entry_offset);
+		if (offset == entry_offset)
+			continue;
+		swap_cluster_read_one(entry, offset, gfp_mask, vma, addr, true);
 	}
+skip_unplug:
 	blk_finish_plug(&plug);
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
-- 
2.25.4

