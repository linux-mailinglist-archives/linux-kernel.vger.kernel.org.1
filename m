Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BF2FCF84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbhATLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:37:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhATKYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:24:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pR0wawllqar92e+0i/G2KHzH+n7trSGvXHpnYgU8y9E=;
        b=OMcPSYXBHvSJXBnY9ADeFvqbIefQc34k/bofJwAESHWDlgJj6QJMQFpNonxfi7gFOPdNCo
        C/SRaUQwAARGE0wlbU87CkKpBkWAPMxm2XRePeEsoP4ORVMoSL4uGibNxEW2xHKP/lkivf
        4nMw4yVlBW2j+LG8oE/xHFp7HWrpbXo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9833AAC97;
        Wed, 20 Jan 2021 10:24:01 +0000 (UTC)
Date:   Wed, 20 Jan 2021 11:24:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210120102400.GG9371@dhcp22.suse.cz>
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058500148.1840162.4365921007820501696.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161058500148.1840162.4365921007820501696.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-01-21 16:43:21, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity
> where pfn_valid() may be limited to coarse section granularity.
> Explicitly validate subsections after pfn_valid() succeeds.

The changelog is not really clear on the underlying problem. It would
benefit from some clarification. What about something like this?
"
pfn_to_online_page is primarily used to filter out offline or fully
uninitialized pages. pfn_valid resp. online_section_nr have a coarse
per memory section granularity. If a section shared with a partially
offline memory (e.g. part of ZONE_DEVICE) then pfn_to_online_page would
lead to a false positive on some pfns. Fix this by adding
pfn_section_valid check which is subsection aware.
"

> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

With that feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..d0c81f7a3347 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,26 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  struct page *pfn_to_online_page(unsigned long pfn)
>  {
>  	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct mem_section *ms;
> +
> +	if (nr >= NR_MEM_SECTIONS)
> +		return NULL;
> +
> +	ms = __nr_to_section(nr);
> +	if (!online_section(ms))
> +		return NULL;
> +
> +	/*
> +	 * Save some code text when online_section() +
> +	 * pfn_section_valid() are sufficient.
> +	 */
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
> +		return NULL;
> +
> +	if (!pfn_section_valid(ms, pfn))
> +		return NULL;
>  
> -	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
> -	    pfn_valid_within(pfn))
> -		return pfn_to_page(pfn);
> -	return NULL;
> +	return pfn_to_page(pfn);
>  }
>  EXPORT_SYMBOL_GPL(pfn_to_online_page);
>  
> 

-- 
Michal Hocko
SUSE Labs
