Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C82AEF85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKKLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKKLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:23:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B2C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KgdGA3v0tMFY+LdkByRcueN/4L/CqvvSlGUg4n7YnPw=; b=h2BH7xY69v4i95iMmVWI5y9pjF
        Lh/JCr5eigFjdsLgZElTq2SiaytBRf9CiBFe3WDePzWClaIO67j4FkACsBi7fHj+GvjdbQW22yOcL
        Ema1wCQoTP2pbfzp1Beb2VAoDCXx5XDLXrP7N1ntaD+SMc1GYiEvmOmKpbFIhOPmloTmDkZxYKi5d
        krK1avRES/A8u+6OHFlp+xgyyorFEhNyE+U7hryIrEaADqKce62fGYYoeC+tmhYM5iJCRQyyszF+4
        nz9odYdmz81ugao3Lgygew+hJFoR+gaiqvby/xkuEVRuXuG2gQG374bf2bIb9P3p3d2CXVEL2TmSD
        2AJmtbvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcoDA-00035e-F8; Wed, 11 Nov 2020 11:22:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2039301EE3;
        Wed, 11 Nov 2020 12:22:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D92942025CA2B; Wed, 11 Nov 2020 12:22:46 +0100 (CET)
Date:   Wed, 11 Nov 2020 12:22:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>, vbabka@suse.cz,
        willy@infradead.org
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201111112246.GR2651@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
 <20201013154615.GE2594@hirez.programming.kicks-ass.net>
 <20201013163449.GR2651@hirez.programming.kicks-ass.net>
 <8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com>
 <20201111095750.GS2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111095750.GS2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:57:50AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 04, 2020 at 12:11:16PM -0500, Liang, Kan wrote:
> > On 10/13/2020 12:34 PM, Peter Zijlstra wrote:
> 
> > > @@ -7037,13 +7057,20 @@ static u64 __perf_get_page_size(struct m
> > >   		return 0;
> > >   	}
> > > +	page = pte_page(*pte);
> > > +	if (PageHuge(page)) {
> > > +		u64 size = page_size(compound_head(page));
> > > +		pte_unmap(pte);
> > > +		return size;
> > > +	}
> > > +
> > 
> > The PageHuge() check for PTE crashes my machine when I did page size test.
> > (Sorry, I didn't find the issue earlier. I just found some time to re-run
> > the page size test.)
> > 
> > It seems we don't need the check for PTE here. The size should be always
> > PAGE_SIZE, no? After I remove the check, everything looks good.
> 
> That's the thing, an architecture could have non-page-table aligned
> huge-pages. For example using 4 consecutive 4k pages to create 16k
> pages. In that case the above code would trigger and find a 16k compound
> page with HUGETLB_PAGE_DTOR (assuming it was created through hugetlbfs).

So, from your splat:

> [  167.383120] BUG: unable to handle page fault for address: fffffca803fb8000
> [  167.383121] #PF: supervisor read access in kernel mode
> [  167.383121] #PF: error_code(0x0000) - not-present page
> [  167.383121] PGD 4adfc8067 P4D 4adfc8067 PUD 4adfc7067 PMD 0
> [  167.383122] Oops: 0000 [#1] SMP NOPTI
> [  167.383122] CPU: 0 PID: 2461 Comm: perf Not tainted 5.10.0-rc1_page_size+ #54
> [  167.383123] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3162.A00.1904162000 04/16/2019
> [  167.383123] traps: PANIC: double fault, error_code: 0x0
> [  167.383123] double fault: 0000 [#2] SMP NOPTI
> [  167.383123] CPU: 0 PID: 2461 Comm: perf Not tainted 5.10.0-rc1_page_size+ #54
> [  167.383124] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3162.A00.1904162000 04/16/2019
> [  167.383124] RIP: 0010:__sprint_symbol+0xb/0x100
> [  167.383124] Code: 85 e4 75 b9 48 85 c0 75 bc 49 89 d8 4c 89 e1 4c 89 fa 4c 89 f6 4c 89 ef e8 42 70 04 00 eb a6 0f 1f 44 00 00 55 48 89 e5 41 57 <41> 56 49 89 f6 41 55 41 89 cd 48 8d 4d b8 41 54 49 89 fc 53 48 63
> [  167.383125] RSP: 0018:fffffe000000b000 EFLAGS: 00010046
> [  167.383125] RAX: 0000000000000053 RBX: 00000000ffff0a00 RCX: 0000000000000001
> [  167.383125] RDX: 0000000000000000 RSI: ffffffff9f8a6176 RDI: fffffe000000b029
> [  167.383126] RBP: fffffe000000b008 R08: ffffffffa0bf8661 R09: 0000000000000001
> [  167.383126] R10: 000000000000000f R11: ffff9e641dc189c8 R12: ffff9e641dc189c9
> [  167.383126] R13: ffff9e641dc1a7e0 R14: ffff0a00ffffff05 R15: fffffe000000b029
> [  167.383126] FS:  0000000000000000(0000) GS:ffff9e641dc00000(0000) knlGS:0000000000000000
> [  167.383127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  167.383127] CR2: fffffe000000aff8 CR3: 000000014a0ba004 CR4: 0000000000770ef0
> [  167.383127] PKRU: 55555554
> [  167.383127] Call Trace:
> [  167.383127]  <NMI>
> [  167.383128]  sprint_symbol+0x15/0x20
> [  167.383128]  symbol_string+0x49/0x90
> [  167.383128]  pointer+0x118/0x3e0
> [  167.383128]  vsnprintf+0x1ec/0x4e0
> [  167.383128]  vscnprintf+0xd/0x30
> [  167.383129]  printk_safe_log_store+0x65/0xe0
> [  167.383129]  vprintk_func+0x8d/0x100
> [  167.383129]  printk+0x58/0x6f
> [  167.383129]  ? PageHuge+0x6/0x40
> [  167.383129]  show_ip+0x2c/0x3d
> [  167.383130]  show_iret_regs+0x17/0x40
> [  167.383130]  __show_regs+0x27/0x40
> [  167.383130]  ? dump_stack_print_info+0x9e/0xb0
> [  167.383130]  show_regs+0x3b/0x50
> [  167.383130]  __die_body+0x20/0x70
> [  167.383131]  __die+0x2b/0x33
> [  167.383131]  no_context+0x152/0x350
> [  167.383131]  __bad_area_nosemaphore+0x50/0x160
> [  167.383131]  bad_area_nosemaphore+0x16/0x20
> [  167.383131]  do_kern_addr_fault+0x62/0x70
> [  167.383132]  exc_page_fault+0xcd/0x150
> [  167.383132]  asm_exc_page_fault+0x1e/0x30
> [  167.383132] RIP: 0010:PageHuge+0x6/0x40
> [  167.383132] Code: c8 48 89 0e 48 39 47 08 48 0f 46 47 08 48 89 02 c3 0f 1f 00 55 be 00 04 00 00 48 89 e5 e8 72 90 2a 00 5d c3 0f 1f 44 00 00 55 <48> 8b 07 48 89 e5 a9 00 00 01 00 75 09 48 8b 47 08 83 e0 01 74 17
> [  167.383133] RSP: 0018:fffffe000000b5c0 EFLAGS: 00010086
> [  167.383133] RAX: 00000000fee0017b RBX: fffffca803fb8000 RCX: 0000000000000000
> [  167.383133] RDX: 7fffffff011ffe84 RSI: ffff9e635b614fe8 RDI: fffffca803fb8000
> [  167.383134] RBP: fffffe000000b5d8 R08: 000fffffc0000000 R09: 000000000000000d
> [  167.383134] R10: 0000000000000001 R11: 00000000000011da R12: 000000000048c14f
> [  167.383134] R13: fffffe000000b8c0 R14: ffff9e60955aa800 R15: ffffffffff5fd340
> [  167.383134]  ? arch_perf_get_page_size+0x2e4/0x330
> [  167.383135]  perf_get_page_size.part.0+0x3c/0x50
> [  167.383135]  perf_prepare_sample+0x1cc/0x740
> [  167.383135]  perf_event_output_forward+0x30/0x90
> [  167.383135]  ? sched_clock+0x9/0x10
> [  167.383135]  ? __perf_event_account_interrupt+0xcc/0xe0
> [  167.383136]  __perf_event_overflow+0x57/0xf0
> [  167.383136]  perf_event_overflow+0x14/0x20

The faulting instruction decodes to:

  48 8b 07                mov    (%rdi),%rax

And the RDI value is indeed fffffca803fb8000 as per the first BUG line,
which, afaict, is in a hole per x86_64/mm.rst

Trying to match the Code: to PageHuge as generate here makes this the
PageCompound() test burning, not even compound_head() going bad.

must ponder more...
