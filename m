Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE326F969
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIRJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRJhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:37:03 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C1C21973;
        Fri, 18 Sep 2020 09:36:59 +0000 (UTC)
Date:   Fri, 18 Sep 2020 10:36:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/37] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200918093656.GB6335@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <4ac1ed624dd1b0851d8cf2861b4f4aac4d2dbc83.1600204505.git.andreyknvl@google.com>
 <20200917134653.GB10662@gaia>
 <7904f7c2-cf3b-315f-8885-e8709c232718@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7904f7c2-cf3b-315f-8885-e8709c232718@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:21:41PM +0100, Vincenzo Frascino wrote:
> On 9/17/20 2:46 PM, Catalin Marinas wrote:
> > On Tue, Sep 15, 2020 at 11:16:04PM +0200, Andrey Konovalov wrote:
> >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> index 52a0638ed967..e238ffde2679 100644
> >> --- a/arch/arm64/kernel/mte.c
> >> +++ b/arch/arm64/kernel/mte.c
> >> @@ -72,6 +74,52 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >>  	return ret;
> >>  }
> >>  
> >> +u8 mte_get_mem_tag(void *addr)
> >> +{
> >> +	if (system_supports_mte())
> >> +		asm volatile(ALTERNATIVE("ldr %0, [%0]",
> >> +					 __MTE_PREAMBLE "ldg %0, [%0]",
> >> +					 ARM64_MTE)
> >> +			     : "+r" (addr));
> > 
> > This doesn't do what you think it does. LDG indeed reads the tag from
> > memory but LDR loads the actual data at that address. Instead of the
> > first LDR, you may want something like "mov %0, #0xf << 56" (and use
> > some macros to avoid the hard-coded 56).
> 
> The result of the load should never be used since it is meaningful only if
> system_supports_mte(). It should be only required for compilation purposes.
> 
> Said that, I think I like more your solution hence I am going to adopt it.

Forgot to mention, please remove the system_supports_mte() if you use
ALTERNATIVE, we don't need both. I think the first asm instruction can
be a NOP since the kernel addresses without KASAN_HW or ARM64_MTE have
the top byte 0xff.

> >> +
> >> +	return 0xF0 | mte_get_ptr_tag(addr);
> >> +}
> >> +
> >> +u8 mte_get_random_tag(void)
> >> +{
> >> +	u8 tag = 0xF;
> >> +	u64 addr = 0;
> >> +
> >> +	if (system_supports_mte()) {
> >> +		asm volatile(ALTERNATIVE("add %0, %0, %0",
> >> +					 __MTE_PREAMBLE "irg %0, %0",
> >> +					 ARM64_MTE)
> >> +			     : "+r" (addr));
> > 
> > What was the intention here? The first ADD doubles the pointer value and
> > gets a tag out of it (possibly doubled as well, depends on the carry
> > from bit 55). Better use something like "orr %0, %0, #0xf << 56".
> 
> Same as above but I will use the orr in the next version.

I wonder whether system_supports_mte() makes more sense here than the
alternative:

	if (!system_supports_mte())
		return 0xff;

	... mte irg stuff ...

(you could do the same for the mte_get_mem_tag() function)

> >> +
> >> +		tag = mte_get_ptr_tag(addr);
> >> +	}
> >> +
> >> +	return 0xF0 | tag;
> > 
> > This function return seems inconsistent with the previous one. I'd
> > prefer the return line to be the same in both.
> 
> The reason why it is different is that in this function extracting the tag from
> the address makes sense only if irg is executed.
> 
> I can initialize addr to 0xf << 56 and make them the same.

I think you are right, they can be different. But see my comment above
about not doing the unnecessary shifting when all you want is to return
0xff with !MTE.

-- 
Catalin
