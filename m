Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692FB2889C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbgJIN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgJIN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:28:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC939C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 06:28:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C786M251mz9sTc;
        Sat, 10 Oct 2020 00:28:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1602250125;
        bh=k1oGU/Plw4/wurpT2A9rREQ809726kQzTyPTfWdaJZA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PQEI33lcJzYlvG01uOWbwg/dwjrUzN2WWb1QQXscsIph8vkLzHYAA8fGUfUqr9l15
         NAY4LLIe3R/u3EcPyodz9EtnasP+x6bdIq0oA8/8Wrj9SIUzRMRJuzZBa7Poa+QNAt
         7HqzDxIMdPs5dCXPOR41R8ljpOiNpTIDm3zHmtaWmSY2ph3DgSLWesk+KmbMYixPoZ
         UjbHHolItSDSGf6ZydQmQ74e4Tk9kM/7Q/KZP+FGKKIBDh1yqqi37CFKIdDOR2ePra
         vxB87/ewyyImWSBi6QJ4g/CyV5bvSPN1sd6mT0fjJ4RAztjaNcS0QejzZJfFqmaPym
         mjHIbpexvBcCA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        Will Deacon <will@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
In-Reply-To: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com> <20201001135749.2804-2-kan.liang@linux.intel.com> <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
Date:   Sat, 10 Oct 2020 00:28:39 +1100
Message-ID: <877drz1qbc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Oct 01, 2020 at 06:57:46AM -0700, kan.liang@linux.intel.com wrote:
>> +/*
>> + * Return the MMU page size of a given virtual address
>> + */
>> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	pgd_t *pgd;
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *pte;
>> +
>> +	pgd = pgd_offset(mm, addr);
>> +	if (pgd_none(*pgd))
>> +		return 0;
>> +
>> +	p4d = p4d_offset(pgd, addr);
>> +	if (!p4d_present(*p4d))
>> +		return 0;
>> +
>> +	if (p4d_leaf(*p4d))
>> +		return 1ULL << P4D_SHIFT;
>> +
>> +	pud = pud_offset(p4d, addr);
>> +	if (!pud_present(*pud))
>> +		return 0;
>> +
>> +	if (pud_leaf(*pud))
>> +		return 1ULL << PUD_SHIFT;
>> +
>> +	pmd = pmd_offset(pud, addr);
>> +	if (!pmd_present(*pmd))
>> +		return 0;
>> +
>> +	if (pmd_leaf(*pmd))
>> +		return 1ULL << PMD_SHIFT;
>> +
>> +	pte = pte_offset_map(pmd, addr);
>> +	if (!pte_present(*pte)) {
>> +		pte_unmap(pte);
>> +		return 0;
>> +	}
>> +
>> +	pte_unmap(pte);
>> +	return PAGE_SIZE;
>> +}
>
> So this mostly works, but gets a number of hugetlb and arch specific
> things wrong.
>
> With the first 3 patches, this is only exposed to x86 and Power.
> Michael, does the above work for you?

It might work on our server CPUs (book3s) but in general no I don't
think it will work for all powerpc.

> Looking at:
>
> arch/powerpc/include/asm/book3s/64/hugetlb.h:check_and_get_huge_psize()
>
> You seem to limit yourself to page-table sizes, however if I then look
> at the same function in:
>
> arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
> arch/powerpc/include/asm/nohash/hugetlb-book3e.h
>
> it doesn't seem to constrain itself so.

Yeah the embedded CPUs have more weird sizes.

I think we have all the logic in our __find_linux_pte().

> Patch 4 makes it all far worse by exposing it to pretty much everybody.
>
> Now, I think we can fix at least the user mappings with the below delta,
> but if archs are using non-page-table MMU sizes we'll need arch helpers.
>
> ARM64 is in that last boat.

I think we probably need it to be weak so we can provide our own
version.

cheers
