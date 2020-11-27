Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B52C685A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgK0PAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:00:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:51506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730920AbgK0O75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:59:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606489196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LNiQ8ZXM8OcHPCX2BFxIKzNPs/e6rdjPX9IsX5bEjg=;
        b=M3o2V3LV5wl5siiMclRFUfelzmuaTVZKHH0eAu63xIR582r0+sq5CyT1JS/KQ9VP2ATDNY
        ZkjEvvZtqLtdKSzrxq2qHyB90asifGAe9W1bEOmcn71vWZ5WPBR/qbJ9xaY53jl2WShbUl
        tUD/+rNA7kq9VPPf8WlEJorWEk7/PR4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CB03ABD7;
        Fri, 27 Nov 2020 14:59:56 +0000 (UTC)
Date:   Fri, 27 Nov 2020 15:59:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 1/4] mm,memory_hotplug: Introduce
 MHP_MEMMAP_ON_MEMORY
Message-ID: <20201127145955.GT31550@dhcp22.suse.cz>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125112048.8211-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-11-20 12:20:45, Oscar Salvador wrote:
> MHP_MEMMAP_ON_MEMORY tells the system that we want the memmap
> pagetables to be built from the hot-added range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

This should be folded into the patch which uses the flag.

> ---
>  include/linux/memory_hotplug.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 551093b74596..5b1ea1f8d1ab 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -70,6 +70,14 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
> +/*
> + * We want memmap (struct page array) to be self contained.
> + * To do so, we will use the beginning of the hot-added range to build
> + * the page tables for the memmap array that describes the entire range.
> + * Only selected architectures support it with SPARSE_VMEMMAP.
> + */
> +#define MHP_MEMMAP_ON_MEMORY	((__force mhp_t)BIT(1))
> +
>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
