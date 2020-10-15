Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F328F2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJOM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgJOM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:58:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD768ABD1;
        Thu, 15 Oct 2020 12:58:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Oct 2020 14:58:53 +0200
From:   osalvador@suse.de
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linmiaohe@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
In-Reply-To: <20201015121534.50910-1-luoshijie1@huawei.com>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
User-Agent: Roundcube Webmail
Message-ID: <a220bf939f0c9aece318197881d6f092@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-15 14:15, Shijie Luo wrote:
> When flags don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL bits, code 
> breaks
>  and passing origin pte - 1 to pte_unmap_unlock seems like not a good 
> idea.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Signed-off-by: linmiaohe <linmiaohe@huawei.com>
> ---
>  mm/mempolicy.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3fde772ef5ef..01f088630d1d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -571,7 +571,11 @@ static int queue_pages_pte_range(pmd_t *pmd,
> unsigned long addr,
>  		} else
>  			break;
>  	}
> -	pte_unmap_unlock(pte - 1, ptl);
> +
> +	if (addr >= end)
> +		pte = pte - 1;
> +
> +	pte_unmap_unlock(pte, ptl);

But this is still wrong, isn't it?
Unless I am missing something, this is "only" important under 
CONFIG_HIGHPTE.

We have:

pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);

which under CONFIG_HIGHPTE does a kmap_atomoc.

Now, we either break the loop in the first pass because of 
!(MPOL_MF_MOVE | MPOL_MF_MOVE_ALL),
or we keep incrementing pte by every pass.
Either way is wrong, because the pointer kunmap_atomic gets will not be 
the same (since we incremented pte).

Or is the loop meant to be running only once, so pte - 1 will bring us 
back to the original pte?


