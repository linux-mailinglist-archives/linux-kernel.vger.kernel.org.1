Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C042906C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407816AbgJPOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405249AbgJPOFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16BC0AD19;
        Fri, 16 Oct 2020 14:05:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 16:05:37 +0200
From:   osalvador@suse.de
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
In-Reply-To: <20201016134215.GL22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
 <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
 <20201016131112.GJ22589@dhcp22.suse.cz>
 <20201016131531.GK22589@dhcp22.suse.cz>
 <20201016134215.GL22589@dhcp22.suse.cz>
User-Agent: Roundcube Webmail
Message-ID: <8b1e52b7a07b9ff1be9badb73209abda@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-16 15:42, Michal Hocko wrote:
> OK, I finally managed to convince my friday brain to think and grasped
> what the code is intended to do. The loop is hairy and we want to
> prevent from spurious EIO when all the pages are on a proper node. So
> the check has to be done inside the loop. Anyway I would find the
> following fix less error prone and easier to follow
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..8cc1fc9c4d13 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -525,7 +525,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
> unsigned long addr,
>  	unsigned long flags = qp->flags;
>  	int ret;
>  	bool has_unmovable = false;
> -	pte_t *pte;
> +	pte_t *pte, *mapped_pte;
>  	spinlock_t *ptl;
> 
>  	ptl = pmd_trans_huge_lock(pmd, vma);
> @@ -539,7 +539,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
> unsigned long addr,
>  	if (pmd_trans_unstable(pmd))
>  		return 0;
> 
> -	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	for (; addr != end; pte++, addr += PAGE_SIZE) {
>  		if (!pte_present(*pte))
>  			continue;
> @@ -571,7 +571,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
> unsigned long addr,
>  		} else
>  			break;
>  	}
> -	pte_unmap_unlock(pte - 1, ptl);
> +	pte_unmap_unlock(mapped_pte, ptl);
>  	cond_resched();
> 
>  	if (has_unmovable)

It is more clear to grasp, definitely.

