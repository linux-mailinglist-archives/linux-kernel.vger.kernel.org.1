Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957EB2C0D03
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbgKWON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:13:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:52562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgKWON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:13:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606140835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctnkZidQcbONL2E2GNXaD6vWwJeHp8xZUqynseoO/sA=;
        b=kd7EHCERweUSVilu2uB4nLfReLStHEYhuU1ziibqx0MG3I0FjP4Wt9AZ7rMZY6GOBfjwfM
        Zyl+pcYt1NmcZP6J6XfW76nkR6ZxVStM8Dd6qoDNOvKdiKRUEWvYY2UPbA3ZdWmrRwALyL
        nFUApIeWlgMH/omBSFYOZpv8XfH5Y1g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A260AC23;
        Mon, 23 Nov 2020 14:13:55 +0000 (UTC)
Date:   Mon, 23 Nov 2020 15:13:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
Message-ID: <20201123141354.GQ27488@dhcp22.suse.cz>
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-11-20 19:33:16, Charan Teja Reddy wrote:
> When the pages are failed to get isolate or migrate, the page owner
> information along with page info is dumped. If there are continuous
> failures in migration(say page is pinned) or isolation, the log buffer
> is simply getting flooded with the page owner information. As most of
> the times page info is sufficient to know the causes for failures of
> migration or isolation, place the page owner information under DEBUG_VM.

I do not see why this path is any different from others that call
dump_page. Page owner can add a very valuable information to debug
the underlying reasons for failures here. It is an opt-in debugging
feature which needs to be enabled explicitly. So I would argue users
are ready to accept a lot of data in the kernel log.
 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/memory_hotplug.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63b2e46..f48f30d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1326,7 +1326,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		} else {
>  			pr_warn("failed to isolate pfn %lx\n", pfn);
> -			dump_page(page, "isolation failed");
> +			__dump_page(page, "isolation failed");
> +#if defined(CONFIG_DEBUG_VM)
> +			dump_page_owner(page);
> +#endif
>  		}
>  		put_page(page);
>  	}
> @@ -1357,7 +1360,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			list_for_each_entry(page, &source, lru) {
>  				pr_warn("migrating pfn %lx failed ret:%d ",
>  				       page_to_pfn(page), ret);
> -				dump_page(page, "migration failure");
> +				__dump_page(page, "migration failure");
> +#if defined(CONFIG_DEBUG_VM)
> +				dump_page_owner(page);
> +#endif
>  			}
>  			putback_movable_pages(&source);
>  		}
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation

-- 
Michal Hocko
SUSE Labs
