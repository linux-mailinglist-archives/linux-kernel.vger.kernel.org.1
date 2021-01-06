Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089772EC1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAFRIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:08:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbhAFRIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:08:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609952876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMDGStXu5aOKdSM+cuLv8ZbVcDEjNhgE+EM0ieJw6OE=;
        b=k7JyX+a5xGNYm2Iavk9sgx0VgM1jAxWJ6msI+j+XiFr+f8TmPCqw6zeWXFuo3wv4XDg8TO
        DMHVdhCkirqO1aAzlzu5OsrB5jHtJQd1N1JbykFzlwXPKt46FyUKqK2LgOTudJZB5MGygF
        n/GTy4xQufCeCTRQt/b1Aj+YE6I9G6M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 116E0ACAF;
        Wed,  6 Jan 2021 17:07:56 +0000 (UTC)
Date:   Wed, 6 Jan 2021 18:07:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mm: hugetlb: add return -EAGAIN for
 dissolve_free_huge_page
Message-ID: <20210106170754.GU13207@dhcp22.suse.cz>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106084739.63318-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-01-21 16:47:37, Muchun Song wrote:
> When dissolve_free_huge_page() races with __free_huge_page(), we can
> do a retry. Because the race window is small.

Is this a bug fix or mere optimization. I have hard time to tell from
the description.
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
[...]
> @@ -1825,6 +1828,14 @@ int dissolve_free_huge_page(struct page *page)
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * If the freeing of the HugeTLB page is put on a work queue, we should
> +	 * flush the work before retrying.
> +	 */
> +	if (unlikely(rc == -EAGAIN))
> +		flush_work(&free_hpage_work);

Is it safe to wait for the work to finish from this context?

-- 
Michal Hocko
SUSE Labs
