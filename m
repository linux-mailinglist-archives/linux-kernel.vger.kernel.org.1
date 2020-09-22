Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DB273B09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgIVGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:41:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13729 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgIVGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:41:17 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f699c800002>; Mon, 21 Sep 2020 23:41:04 -0700
Received: from [10.2.52.174] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 06:41:16 +0000
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when
 fork()
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212031.25233-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5e594e71-537f-3e9f-85b6-034b7f5fedbe@nvidia.com>
Date:   Mon, 21 Sep 2020 23:41:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921212031.25233-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600756864; bh=PGSDeSt3BFe4Hd1n3brR/Jj7+kPght+eaqYsY8xTtNs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=GPzc5iW3MVT6FTZ2HzvongIWa7QtLZ/1lD308KA39n/lcVCtoBOVu45lbUwFbF0Bi
         D7u/mxFBuYinhv5sztuSHdymukaPyyiBQrP7THzLyZyqSq7G3PhtkvyejmsDGzf3Vk
         oki+DjD+97hHcJAqjzDIYW4UUFOZLmWmPw/6jzEWrVVe7YfPNyyyGODxDA9yiDSjax
         r/zJR4IEisqyTuWRvD8CC0kGVUR9PuAnOT40qTi/1Mt5zleKl/tDVE7PA9ckOfsiYB
         t0nr1YEWStoXuP6MCK9tbwTORiYy47IZY7JX8VHoIgM/swmWGYKzq2ZJw5qKo1n1G2
         g97H6LWqW7Oew==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:20 PM, Peter Xu wrote:
...
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7ff29cc3d55c..c40aac0ad87e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   
>   	src_page = pmd_page(pmd);
>   	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> +
> +	/*
> +	 * If this page is a potentially pinned page, split and retry the fault
> +	 * with smaller page size.  Normally this should not happen because the
> +	 * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> +	 * best effort that the pinned pages won't be replaced by another
> +	 * random page during the coming copy-on-write.
> +	 */
> +	if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> +		     page_maybe_dma_pinned(src_page))) {

This condition would make a good static inline function. It's used in 3 places,
and the condition is quite special and worth documenting, and having a separate
function helps with that, because the function name adds to the story. I'd suggest
approximately:

     page_likely_dma_pinned()

for the name.

> +		pte_free(dst_mm, pgtable);
> +		spin_unlock(src_ptl);
> +		spin_unlock(dst_ptl);
> +		__split_huge_pmd(vma, src_pmd, addr, false, NULL);
> +		return -EAGAIN;
> +	}


Why wait until we are so deep into this routine to detect this and unwind?
It seems like if you could do a check near the beginning of this routine, and
handle it there, with less unwinding? In fact, after taking only the src_ptl,
the check could be made, right?


thanks,
-- 
John Hubbard
NVIDIA
