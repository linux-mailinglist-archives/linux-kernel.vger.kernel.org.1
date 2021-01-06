Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187772EC1E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbhAFRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:17:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbhAFRRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609953394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lukOtk5vWvi/tM4jLgHNVQUDURDlLIkiY4jfId8l/Js=;
        b=JpsbvF6+NvVCCctrT9sAw9PNGW9lFxCWc8XQ8oTtrazcndqDgEaGWfl2O3ybX50tHclVyr
        pVEDFOZazW0ds1qMoZEy8u2XKmd/1VJqc6UXkkbQTwbb2Rbb9a/1OtIl9aMnboMvfflr65
        S1ihMVzZcnMxmXy+OSLZRBOZ/+qOPY8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9CC6ACAF;
        Wed,  6 Jan 2021 17:16:34 +0000 (UTC)
Date:   Wed, 6 Jan 2021 18:16:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from
 page_huge_active
Message-ID: <20210106171632.GW13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084739.63318-7-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:47:39, Muchun Song wrote:
> The page_huge_active() can be called from scan_movable_pages() which
> do not hold a reference count to the HugeTLB page. So when we call
> page_huge_active() from scan_movable_pages(), the HugeTLB page can
> be freed parallel. Then we will trigger a BUG_ON which is in the
> page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
> VM_BUG_ON_PAGE.
> 
> Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

The BUG_ON looks like a wrong thing to do regardless of the memory
hotplug use. Which is admittedly ugly as well.

> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 67200dd25b1d..7a24ed28ec4f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1372,7 +1372,6 @@ struct hstate *size_to_hstate(unsigned long size)
>   */
>  bool page_huge_active(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHuge(page), page);
>  	return PageHead(page) && PagePrivate(&page[1]);
>  }
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
