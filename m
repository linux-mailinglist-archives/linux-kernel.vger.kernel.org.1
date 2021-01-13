Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7618A2F4694
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbhAMIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:31:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbhAMIbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:31:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F71FAC8F;
        Wed, 13 Jan 2021 08:30:55 +0000 (UTC)
Date:   Wed, 13 Jan 2021 09:30:52 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] mm: Teach pfn_to_online_page() to consider
 subsection validity
Message-ID: <20210113083048.GA23676@linux>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161052332755.1805594.9846390935351758277.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:35:27PM -0800, Dan Williams wrote:
> pfn_section_valid() determines pfn validity on subsection granularity
> where pfn_valid() may be limited to coarse section granularity.
> Explicitly validate subsections after pfn_valid() succeeds.
> 
> Fixes: b13bc35193d9 ("mm/hotplug: invalid PFNs from pfn_to_online_page()")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55a69d4396e7..9f37f8a68da4 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,11 +308,27 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
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
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
> +		if (!pfn_valid(pfn))
> +			return NULL;
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
Oscar Salvador
SUSE L3
