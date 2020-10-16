Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819ED290674
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408326AbgJPNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:42:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:34632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408186AbgJPNmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:42:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602855736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLWRvYYXUO47dYQW4nDaQupe4h8/87CElGZFuPU0ZGg=;
        b=e+kzxg5P2cYcA3iqY8DQAbdAkvIKuc4qr+PABYuLWc2x5OgCUgpQ4TOj9e0Wb4MqTl0Ycb
        Ynt1KKkEhAXJBTd3NanyST++1EQlZC2faj3tNXhABXKTGsWq8/whsUz6P0VxEVF7z4xa05
        TFg3b4RH52o/fYVXpjSlu+zs1+nKqv0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6323B2D8;
        Fri, 16 Oct 2020 13:42:16 +0000 (UTC)
Date:   Fri, 16 Oct 2020 15:42:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     osalvador@suse.de
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
Message-ID: <20201016134215.GL22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
 <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
 <20201016131112.GJ22589@dhcp22.suse.cz>
 <20201016131531.GK22589@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016131531.GK22589@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 15:15:32, Michal Hocko wrote:
> On Fri 16-10-20 15:11:17, Michal Hocko wrote:
> > On Fri 16-10-20 14:37:08, osalvador@suse.de wrote:
> > > On 2020-10-16 14:31, Michal Hocko wrote:
> > > > I do not like the fix though. The code is really confusing. Why should
> > > > we check for flags in each iteration of the loop when it cannot change?
> > > > Also why should we take the ptl lock in the first place when the look is
> > > > broken out immediately?
> > > 
> > > About checking the flags:
> > > 
> > > https://lore.kernel.org/linux-mm/20190320081643.3c4m5tec5vx653sn@d104.suse.de/#t
> > 
> > This didn't really help. Maybe the code was different back then but
> > right now the code doesn't make much sense TBH. The only reason to check
> > inside the loop would be to have a completely unpopulated address range.
> > Note about MPOL_MF_STRICT is not checked explicitly and I do not see how
> > it makes any difference.
> 
> Ohh, I have missed queue_pages_required. Let me think some more.

OK, I finally managed to convince my friday brain to think and grasped
what the code is intended to do. The loop is hairy and we want to
prevent from spurious EIO when all the pages are on a proper node. So
the check has to be done inside the loop. Anyway I would find the
following fix less error prone and easier to follow
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..8cc1fc9c4d13 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -525,7 +525,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long flags = qp->flags;
 	int ret;
 	bool has_unmovable = false;
-	pte_t *pte;
+	pte_t *pte, *mapped_pte;
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -539,7 +539,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		if (!pte_present(*pte))
 			continue;
@@ -571,7 +571,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		} else
 			break;
 	}
-	pte_unmap_unlock(pte - 1, ptl);
+	pte_unmap_unlock(mapped_pte, ptl);
 	cond_resched();
 
 	if (has_unmovable)
-- 
Michal Hocko
SUSE Labs
