Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419AA2F7671
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbhAOKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:17:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:36744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbhAOKRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:17:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97BD1B7C6;
        Fri, 15 Jan 2021 10:16:37 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:16:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/3] hugetlb: convert PageHugeTemporary() to
 HPageTempSurplus
Message-ID: <20210115101629.GA5213@linux>
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111210152.118394-4-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:01:52PM -0800, Mike Kravetz wrote:
> Use new hugetlb specific flag HPageTempSurplus to replace the
> PageHugeTemporary() interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 34ce82f4823c..949e1f987319 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -58,6 +58,7 @@ static unsigned long hugetlb_cma_size __initdata;
>  enum htlb_page_flags {
>  	HPAGE_RestoreReserve = 0,
>  	HPAGE_Migratable,
> +	HPAGE_TempSurplus,
>  };
>  
>  /*
> @@ -99,6 +100,7 @@ void ClearHPage##flname(struct page *page)	\
>  
>  HPAGEFLAG(RestoreReserve)
>  EXT_HPAGEFLAG(Migratable)
> +HPAGEFLAG(TempSurplus)

Would HPAGE_Temporary/Temporary not be a better fit?
The point about current PageHugeTemporary is that these pages are temporary as
they do not belong to the pool and will vanish once the last reference gets drop.
We do not really care that much about the surplus part?

Besides, alloc_migrate_huge_page seems to not want to thread these pages as surplus.

Also, I would add a comment either next to each flag or above
the enum htlb_page_flags (probably the latter) with a brief explanation
of each flag.

Besides that, it looks fine to me.
Here I do not see the same problem in
stripping the PageHuge check in PageHugeTemporary, as I did in previous patch,
because all callers of it make sure they operate on a hugetlb page.

-- 
Oscar Salvador
SUSE L3
