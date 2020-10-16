Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB211290512
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407543AbgJPMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:31:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:54990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407399AbgJPMbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:31:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602851502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnNDbj6l7WMvrQvc+zjQs6EUzuq+0A4IIoPAnkQTOfw=;
        b=Aa6d2VWvtbILY6JauVQQzfZu0Qjm1p52YSqJ3LX1gV+FqJ/NQvVqwA2ytojMzLP6aHCNeX
        uuZ1fVsvqX+i6qA8RPpJJOF3Cir0dviheNbntBLEMth/CJKU81I6BXbSH6F2XJhEad4gVq
        K8Uht2RhZm1GDaHoUpiTCTSBixyCWgg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C6BBAFF8;
        Fri, 16 Oct 2020 12:31:42 +0000 (UTC)
Date:   Fri, 16 Oct 2020 14:31:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
Message-ID: <20201016123137.GH22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015121534.50910-1-luoshijie1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-10-20 08:15:34, Shijie Luo wrote:
> When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code breaks
>  and passing origin pte - 1 to pte_unmap_unlock seems like not a good idea.

Yes the code is suspicious to say the least. At least mbind can reach to
here with both MPOL_MF_MOVE, MPOL_MF_MOVE_ALL unset and then the pte
would be pointing outside of the current pmd.

I do not like the fix though. The code is really confusing. Why should
we check for flags in each iteration of the loop when it cannot change?
Also why should we take the ptl lock in the first place when the look is
broken out immediately?

I have to admit that I do not fully understand a7f40cfe3b7ad so this
should be carefuly evaluated.

If anything something like below would be a better fix

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..7877b36a5a6d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -539,6 +539,10 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* A COMMENT GOES HERE. */
+	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)))
+		return -EIO;
+
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
@@ -554,28 +558,26 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (!queue_pages_required(page, qp))
 			continue;
-		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			/* MPOL_MF_STRICT must be specified if we get here */
-			if (!vma_migratable(vma)) {
-				has_unmovable = true;
-				break;
-			}
 
-			/*
-			 * Do not abort immediately since there may be
-			 * temporary off LRU pages in the range.  Still
-			 * need migrate other LRU pages.
-			 */
-			if (migrate_page_add(page, qp->pagelist, flags))
-				has_unmovable = true;
-		} else
+		/* MPOL_MF_STRICT must be specified if we get here */
+		if (!vma_migratable(vma)) {
+			has_unmovable = true;
 			break;
+		}
+
+		/*
+		 * Do not abort immediately since there may be
+		 * temporary off LRU pages in the range.  Still
+		 * need migrate other LRU pages.
+		 */
+		if (migrate_page_add(page, qp->pagelist, flags))
+			has_unmovable = true;
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
 
 	if (has_unmovable)
 		return 1;
 	return addr != end ? -EIO : 0;
 }
-- 
Michal Hocko
SUSE Labs
