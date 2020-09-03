Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE725BB5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgICHHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 03:07:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICHHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:07:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 855D3AD21;
        Thu,  3 Sep 2020 07:07:35 +0000 (UTC)
Date:   Thu, 3 Sep 2020 09:07:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
Message-ID: <20200903070733.GO4617@dhcp22.suse.cz>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901124615.137200-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-09-20 08:46:15, Pavel Tatashin wrote:
[...]
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9d5ab5d3ca0..d6d54922bfce 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1575,6 +1575,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		/* check again */
>  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>  					    NULL, check_pages_isolated_cb);
> +		/*
> +		 * per-cpu pages are drained in start_isolate_page_range, but if
> +		 * there are still pages that are not free, make sure that we
> +		 * drain again, because when we isolated range we might
> +		 * have raced with another thread that was adding pages to
> +		 * pcp list.

I would also add
		 * Forward progress should be still guaranteed because
		 * pages on the pcp list can only belong to MOVABLE_ZONE
		 * because has_unmovable_pages explicitly checks for
		 * PageBuddy on freed pages on other zones.
> +		 */
> +		if (ret)
> +			drain_all_pages(zone);
>  	} while (ret);
>  
>  	/* Ok, all of our target is isolated.
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
