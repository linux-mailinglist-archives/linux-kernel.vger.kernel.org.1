Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85C2888AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgJIM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:29:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:28196 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgJIM3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:29:30 -0400
IronPort-SDR: pbTyASPO5UrvShCN3Ey+lYF4yfGclNSJMg05vEHKVFWzJ63rQm4p0CTxkXPPfQmhi9bcCbft/D
 UsYs2o+3ONEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="227125831"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="227125831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 05:29:29 -0700
IronPort-SDR: brXMhEC7edjubEjxgKYipSodYTOetuw4sSXc7kdr+55p2nw/DYer2MUcKjs9fK7nbAnmFn6pLm
 MAu2yGF63+5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="349813720"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2020 05:29:28 -0700
Received: from [10.251.2.196] (kliang2-MOBL.ccr.corp.intel.com [10.251.2.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DDB085807BA;
        Fri,  9 Oct 2020 05:29:26 -0700 (PDT)
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Will Deacon <will@kernel.org>,
        David Miller <davem@davemloft.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a184fa36-a25d-cc7f-57b7-a1cf278b5465@linux.intel.com>
Date:   Fri, 9 Oct 2020 08:29:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2020 5:09 AM, Peter Zijlstra wrote:
> (we might not need the #ifdef gunk, but I've not yet dug out my cross
>   compilers this morning)
> 
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7009,6 +7009,7 @@ static u64 perf_virt_to_phys(u64 virt)
>    */
>   static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>   {
> +	struct page *page;
>   	pgd_t *pgd;
>   	p4d_t *p4d;
>   	pud_t *pud;
> @@ -7030,15 +7031,27 @@ static u64 __perf_get_page_size(struct m
>   	if (!pud_present(*pud))
>   		return 0;
>   
> -	if (pud_leaf(*pud))
> +	if (pud_leaf(*pud)) {
> +#ifdef pud_page
> +		page = pud_page(*pud);
> +		if (PageHuge(page))
> +			return page_size(compound_head(page));

I think the page_size() returns the Kernel Page Size of a compound page.
What we want is the MMU page size.

If it's for the generic code, I think it should be a problem for X86.

Thanks,
Kan

> +#endif
>   		return 1ULL << PUD_SHIFT;
> +	}
>   
>   	pmd = pmd_offset(pud, addr);
>   	if (!pmd_present(*pmd))
>   		return 0;
>   
> -	if (pmd_leaf(*pmd))
> +	if (pmd_leaf(*pmd)) {
> +#ifdef pmd_page
> +		page = pmd_page(*pmd);
> +		if (PageHuge(page))
> +			return page_size(compound_head(page));
> +#endif
>   		return 1ULL << PMD_SHIFT;
> +	}
>   
>   	pte = pte_offset_map(pmd, addr);
>   	if (!pte_present(*pte)) {
> @@ -7046,6 +7059,10 @@ static u64 __perf_get_page_size(struct m
>   		return 0;
>   	}
>   
> +	page = pte_page(*pte);
> +	if (PageHuge(page))
> +		return page_size(compound_head(page));
> +
>   	pte_unmap(pte);
>   	return PAGE_SIZE;
>   }
