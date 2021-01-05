Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21772EAD56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbhAEOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:34168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbhAEOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:25:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609856696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oD8OhFiTFS91oSo/GxxMnZWrLGad6kBBv+IR7HZxg1Q=;
        b=JP/nz1QiqHC4h0BO/jt/cnqiI07Z9EoE3GIgDqexKBUfc0T0Q57GZTpMpMn6nJ4KkV9Tkn
        u+m9AIyTm8UNWZPxMO5ku3GMG5DprV0zr/mon1H3dTKJkoaLscfW+W9i+Fi9lhZXFBxS9G
        VLXhzInzyruCVVvuW3P9Ve2PwytpzY8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9238FACC6;
        Tue,  5 Jan 2021 14:24:56 +0000 (UTC)
Date:   Tue, 5 Jan 2021 15:24:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, ziy@nvidia.com,
        shy828301@gmail.com, jack@suse.cz, willy@infradead.org,
        mgorman@suse.de, songliubraving@fb.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm: migrate: initialize err in do_migrate_pages
Message-ID: <20210105142454.GH13207@dhcp22.suse.cz>
References: <456a021c7ef3636d7668cec9dcb4a446a4244812.1609855564.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456a021c7ef3636d7668cec9dcb4a446a4244812.1609855564.git.jstancek@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-01-21 15:14:20, Jan Stancek wrote:
> After commit 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")',
> do_migrate_pages can return uninitialized variable 'err' (which is
> propagated to user-space as error) when 'from' and 'to' nodesets
> are identical. This can be reproduced with LTP migrate_pages01,
> which calls migrate_pages() with same set for both old/new_nodes.
> 
> Add 'err' initialization back.
> 
> Fixes: 236c32eb1096 ("mm: migrate: clean up migrate_prep{_local}")
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 8cf96bd21341..2c3a86502053 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1111,7 +1111,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>  		     const nodemask_t *to, int flags)
>  {
>  	int busy = 0;
> -	int err;
> +	int err = 0;
>  	nodemask_t tmp;
>  
>  	migrate_prep();
> -- 
> 2.18.1
> 

-- 
Michal Hocko
SUSE Labs
