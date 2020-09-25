Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2D2787DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgIYMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbgIYMvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:51:04 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 049DF22B2D;
        Fri, 25 Sep 2020 12:51:01 +0000 (UTC)
Date:   Fri, 25 Sep 2020 13:50:59 +0100
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
Subject: Re: [PATCH v3 24/39] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200925125059.GM4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <ae603463aed82bdff74942f23338a681b8ed8820.1600987622.git.andreyknvl@google.com>
 <20200925101558.GB4846@gaia>
 <e41f2af1-f208-cc99-64f9-2311ad7d50bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41f2af1-f208-cc99-64f9-2311ad7d50bf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:28:24PM +0100, Vincenzo Frascino wrote:
> On 9/25/20 11:15 AM, Catalin Marinas wrote:
> > On Fri, Sep 25, 2020 at 12:50:31AM +0200, Andrey Konovalov wrote:
> >> +u8 mte_get_mem_tag(void *addr);
> >> +u8 mte_get_random_tag(void);
> >> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> >> +
> >> +#else /* CONFIG_ARM64_MTE */
> >> +
> >> +static inline u8 mte_get_ptr_tag(void *ptr)
> >> +{
> >> +	return 0xFF;
> >> +}
> >> +
> >> +static inline u8 mte_get_mem_tag(void *addr)
> >> +{
> >> +	return 0xFF;
> >> +}
> >> +static inline u8 mte_get_random_tag(void)
> >> +{
> >> +	return 0xFF;
> >> +}
> >> +static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >> +{
> >> +	return addr;
> >> +}
> > 
> > Maybe these can stay in mte-kasan.h, although they are not a direct
> > interface for KASAN AFAICT (the arch_* equivalent are defined in
> > asm/memory.h. If there's no good reason, we could move them to mte.h.
> 
> This is here because it is not a direct interface as you noticed. I tried to
> keep the separation (even if it I have something to fix based on your comment
> below ;)).
> 
> The other kasan implementation define the arch_* indirection in asm/memory.h in
> every architecture. I think maintaining the design is the best way to non create
> confusion.

I'm ok with asm/memory.h for kasan, no need to change that. You can also
keep these functions in asm/mte-kasan.h but add a comment that they are
only for the kasan interface defined in asm/memory.h.

> >> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> >> index 1c99fcadb58c..3a2bf3ccb26c 100644
> >> --- a/arch/arm64/include/asm/mte.h
> >> +++ b/arch/arm64/include/asm/mte.h
> >> @@ -5,14 +5,13 @@
> >>  #ifndef __ASM_MTE_H
> >>  #define __ASM_MTE_H
> >>  
> >> -#define MTE_GRANULE_SIZE	UL(16)
> >> -#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> >> -#define MTE_TAG_SHIFT		56
> >> -#define MTE_TAG_SIZE		4
> >> +#include <asm/mte-kasan.h>

And this include should be replaced by asm/mte-hwdef.h.

> >>  #ifndef __ASSEMBLY__
> >>  
> >> +#include <linux/bitfield.h>
> >>  #include <linux/page-flags.h>
> >> +#include <linux/types.h>
> >>  
> >>  #include <asm/pgtable-types.h>
> >>  
> >> @@ -45,7 +44,9 @@ long get_mte_ctrl(struct task_struct *task);
> >>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
> >>  			 unsigned long addr, unsigned long data);
> >>  
> >> -#else
> >> +void mte_assign_mem_tag_range(void *addr, size_t size);
> > 
> > So mte_set_mem_tag_range() is KASAN specific but
> > mte_assign_mem_tag_range() is not. Slightly confusing.
> 
> mte_assign_mem_tag_range() is the internal function implemented in assembler
> which is not used directly by KASAN. Is it the name that you find confusing? Do
> you have a better proposal?

I don't mind the name, just trying to find some consistency in the
headers.

> >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> index 52a0638ed967..833b63fdd5e2 100644
> >> --- a/arch/arm64/kernel/mte.c
> >> +++ b/arch/arm64/kernel/mte.c
> >> @@ -13,8 +13,10 @@
> >>  #include <linux/swap.h>
> >>  #include <linux/swapops.h>
> >>  #include <linux/thread_info.h>
> >> +#include <linux/types.h>
> >>  #include <linux/uio.h>
> >>  
> >> +#include <asm/barrier.h>
> >>  #include <asm/cpufeature.h>
> >>  #include <asm/mte.h>
> >>  #include <asm/ptrace.h>
> >> @@ -72,6 +74,48 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >>  	return ret;
> >>  }
> >>  
> >> +u8 mte_get_mem_tag(void *addr)
> >> +{
> >> +	if (!system_supports_mte())
> >> +		return 0xFF;
> >> +
> >> +	asm volatile(__MTE_PREAMBLE "ldg %0, [%0]"
> >> +		    : "+r" (addr));
[...]
> > I wonder whether we'd need the "memory" clobber. I don't see how this
> > would fail though, maybe later on with stack tagging if the compiler
> > writes tags behind our back.
> > 
> 
> As you said, I do not see how this can fail either. We can be overcautious
> though here and add a comment that the clobber has been added in prevision of
> stack tagging.

I don't think we should bother, it may not even matter.

> >> + */
> >> +SYM_FUNC_START(mte_assign_mem_tag_range)
> >> +	/* if (src == NULL) return; */
> >> +	cbz	x0, 2f
> >> +	/* if (size == 0) return; */
> >> +	cbz	x1, 2f
> > 
> > I find these checks unnecessary, as I said a couple of times before,
> > just document the function pre-conditions. They are also incomplete
> > (i.e. you check for NULL but not alignment).
> > 
> 
> I thought we agreed to harden the code further, based on [1]. Maybe I
> misunderstood. I am going to remove them and extend the comment in the next version.
> 
> [1]
> https://lore.kernel.org/linux-arm-kernel/921c4ed0-b5b5-bc01-5418-c52d80f1af59@arm.com/

Well, you concluded that but I haven't confirmed ;). Since it's called
from a single place which does the checks already, I don't see the point
in duplicating them. Documenting should be sufficient.

-- 
Catalin
