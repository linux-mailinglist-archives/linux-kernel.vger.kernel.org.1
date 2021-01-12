Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252442F2B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbhALJnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:43:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbhALJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:43:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610444545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vTDInRI/kOghavjr/N1f2NIOeZI8zUluYp25QiXkfh4=;
        b=df4jZCVZqAPa003N3s6ofve4uaIubd8PQ2I+00M5QAgJ1FOBOiBKefKpsAQuZ/oyStPYfN
        8B7MQfh1W6pK/LOCVXckOpU4bmYvjM79CmJtOjM5EOy3sdcQk+VszutMqA5rtiWO2Qb2wm
        NAwyE9FGZHQmVSGiA8Mu4IY6uvc2Ua8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C472AD19;
        Tue, 12 Jan 2021 09:42:25 +0000 (UTC)
Date:   Tue, 12 Jan 2021 10:42:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210112094222.GI22493@dhcp22.suse.cz>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110124017.86750-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 10-01-21 20:40:12, Muchun Song wrote:
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.

I would consider the following easier to understand. Feel free to reuse.
"
All pages isolated for the migration have an elevated reference count
and therefore seeing a reference count equal to 1 means that the last
user of the page has dropped the reference and the page has became
unused and there doesn't make much sense to migrate it anymore. This has
been done for regular pages and this patch does the same for hugetlb
pages. Although the likelyhood of the race is rather small for hugetlb
pages it makes sense the two code paths in sync.
"

> 
> This optimization is consistent with the regular pages, just like
> unmap_and_move() does.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Yang Shi <shy828301@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4385f2fb5d18..a6631c4eb6a6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		return -ENOSYS;
>  	}
>  
> +	if (page_count(hpage) == 1) {
> +		/* page was freed from under us. So we are done. */
> +		putback_active_hugepage(hpage);
> +		return MIGRATEPAGE_SUCCESS;
> +	}
> +
>  	new_hpage = get_new_page(hpage, private);
>  	if (!new_hpage)
>  		return -ENOMEM;
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
