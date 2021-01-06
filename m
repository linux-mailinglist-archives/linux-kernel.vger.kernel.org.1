Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318012EC0E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbhAFQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:12:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:43870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbhAFQMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:12:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609949499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7JhlgCNmTzJnSaTOtYRKn0UypYzbYBadTXNNZC6YOE=;
        b=n4FGgwCvt8KIHxYsIHaOQT3JiAZSNzf0DuTeKny9bAOaOlLEp/odwY9nuIhjw9gUlZFSNR
        yXmScmQP41sOFWqSlTUZc3WWtzeayeIkuFop3o6Uxf8vCAcpYX/vaNAAlyAYjNdPu4aov2
        rYHG84HsUK3YUZxxcWWDIr1mki43TWQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0148BAD75;
        Wed,  6 Jan 2021 16:11:39 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:11:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
Message-ID: <20210106161135.GP13207@dhcp22.suse.cz>
References: <20210104065843.5658-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 14:58:38, Muchun Song wrote:
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.

Is this common enough that it would warrant the explicit check for each
migration?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
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
