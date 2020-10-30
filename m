Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C932A0E68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgJ3TQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgJ3TQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:16:24 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:16:24 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o129so1830300ooo.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IphFE7ilzXNXur1141KXwIQedEFrpv7O0T6mxNfExvI=;
        b=RCDhFlYvuzkhj0RbKq2lgBPQSykTVOFnWK/WcFtrtTkVR3x5GXOu2PzFzOLGUOmzJj
         mB78wvCQ1fsVzChzlkxfqZuhpB+sUy5eafmPUGWeOXt+v/gjbzoB7Q/okyjNyzjJSmU3
         1PasmJcynTSBoknvZQcDTfUVzO9DXaGOOxUcj4fkSyZtYxa5BdcYmYAcTI7jNHVkctHj
         ZGx547ln5g2kzS1n66nWW0Qhw0ot8uV8tRQiKxp4ivjtCokA/pKy3E9j18NwhrMoD3b8
         NFxNVhnauAqXsTFULPRBgYMnAD4frbaY+pkRAbGZKq/sh30IrkkXj6jxp41ah2AujTN8
         DMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IphFE7ilzXNXur1141KXwIQedEFrpv7O0T6mxNfExvI=;
        b=GkbykGXJgQ/s84Pu8RtRsvkM7SJ97aBRKkXxOvCbePuMEhzH6l7zkp42o3JPbly41E
         QNdPfOTsTp+3wRpVXDe4jdi3QKuutwLNS2G1W6KetCnZaqRMKUP1RDBKBdbT5n10QCkY
         tGMy6urmncwknQzifGno4NHUweQYGN8rF0N+Frl0pgDs5AvV0Xw0M2gXFEc2/9ITG9x0
         YLc7jaNSGbCC0Ye/8qhzXhkscdxfNI5zVrltqIwvwV3uFZriTMUj5aRKIhOX3KDTDo4r
         uPMgMDXoGdBGbqiRrqPtRBWLnPehHNFExnG1ybKMg1DfcEt+df5qx+6spBZ3UuxYdmzN
         XGcw==
X-Gm-Message-State: AOAM5331+1GjDf+oHqmG6gjrIFQ6g+QGGGlx4KUu4FqkHUk8bK/wFcFG
        r4OKUk0HJfxABrnbLr0nTI/5AuU6nh6YneXlQ4hiGQ==
X-Google-Smtp-Source: ABdhPJz+Ar79arAMWb4nHKtD5m+2c2HoTc65MlGNrFoHz2E+7j17Ls4jvjkLcU+UEA7bPTumYtOoXF4YQOvbudM+bJY=
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr3076579ooo.54.1604085383351;
 Fri, 30 Oct 2020 12:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-2-elver@google.com>
 <CAG48ez0TgomTec+r188t0ddYVZtivOkL1DvR3owiuDTBtgPNzA@mail.gmail.com>
In-Reply-To: <CAG48ez0TgomTec+r188t0ddYVZtivOkL1DvR3owiuDTBtgPNzA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 20:16:11 +0100
Message-ID: <CANpmjNPFXutFT6QmTej2bCDGVP+QgBngws1fOEz=s_Q_sAJbOQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] mm: add Kernel Electric-Fence infrastructure
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 03:49, Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.
> [...]
> > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> [...]
> > +/**
> > + * is_kfence_address() - check if an address belongs to KFENCE pool
> > + * @addr: address to check
> > + *
> > + * Return: true or false depending on whether the address is within the KFENCE
> > + * object range.
> > + *
> > + * KFENCE objects live in a separate page range and are not to be intermixed
> > + * with regular heap objects (e.g. KFENCE objects must never be added to the
> > + * allocator freelists). Failing to do so may and will result in heap
> > + * corruptions, therefore is_kfence_address() must be used to check whether
> > + * an object requires specific handling.
> > + */
>
> It might be worth noting in the comment that this is one of the few
> parts of KFENCE that are highly performance-sensitive, since that was
> an important point during the review.

Done, thanks.

> > +static __always_inline bool is_kfence_address(const void *addr)
> > +{
> > +       /*
> > +        * The non-NULL check is required in case the __kfence_pool pointer was
> > +        * never initialized; keep it in the slow-path after the range-check.
> > +        */
> > +       return unlikely((unsigned long)((char *)addr - __kfence_pool) < KFENCE_POOL_SIZE && addr);
> > +}
> [...]
> > diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> [...]
> > +config KFENCE_STRESS_TEST_FAULTS
> > +       int "Stress testing of fault handling and error reporting"
> > +       default 0
> > +       depends on EXPERT
> > +       help
> > +         The inverse probability with which to randomly protect KFENCE object
> > +         pages, resulting in spurious use-after-frees. The main purpose of
> > +         this option is to stress test KFENCE with concurrent error reports
> > +         and allocations/frees. A value of 0 disables stress testing logic.
> > +
> > +         The option is only to test KFENCE; set to 0 if you are unsure.
> [...]
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> [...]
> > +#ifndef CONFIG_KFENCE_STRESS_TEST_FAULTS /* Only defined with CONFIG_EXPERT. */
> > +#define CONFIG_KFENCE_STRESS_TEST_FAULTS 0
> > +#endif
>
> I think you can make this prettier by writing the Kconfig
> appropriately. See e.g. ARCH_MMAP_RND_BITS:
>
> config ARCH_MMAP_RND_BITS
>   int "Number of bits to use for ASLR of mmap base address" if EXPERT
>   range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
>   default ARCH_MMAP_RND_BITS_DEFAULT if ARCH_MMAP_RND_BITS_DEFAULT
>   default ARCH_MMAP_RND_BITS_MIN
>   depends on HAVE_ARCH_MMAP_RND_BITS
>
> So instead of 'depends on EXPERT', I think the proper way would be to
> append ' if EXPERT' to the line
> 'int "Stress testing of fault handling and error reporting"', so that
> only whether the option is user-visible depends on EXPERT, and
> non-EXPERT configs automatically use the default value.

I guess the idea was to not pollute the config in non-EXPERT configs,
but it probably doesn't matter much. Changed it to the suggested
cleaner approach.

> [...]
> > +static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
> > +{
> > +       unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
> > +       unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> > +
> > +       /* The checks do not affect performance; only called from slow-paths. */
> > +
> > +       /* Only call with a pointer into kfence_metadata. */
> > +       if (KFENCE_WARN_ON(meta < kfence_metadata ||
> > +                          meta >= kfence_metadata + CONFIG_KFENCE_NUM_OBJECTS))
> > +               return 0;
> > +
> > +       /*
> > +        * This metadata object only ever maps to 1 page; verify the calculation
> > +        * happens and that the stored address was not corrupted.
>
> nit: This reads a bit weirdly to me. Maybe "; verify that the stored
> address is in the expected range"? But feel free to leave it as-is if
> you prefer it that way.

Hmm, that really sounds weird... I've changed it. :-)

> > +        */
> > +       if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> > +               return 0;
> > +
> > +       return pageaddr;
> > +}
> [...]
> > +/* __always_inline this to ensure we won't do an indirect call to fn. */
> > +static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
> > +{
> > +       const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
> > +       unsigned long addr;
> > +
> > +       lockdep_assert_held(&meta->lock);
> > +
> > +       /* Check left of object. */
> > +       for (addr = pageaddr; addr < meta->addr; addr++) {
> > +               if (!fn((u8 *)addr))
> > +                       break;
>
> It could be argued that "return" instead of "break" would be cleaner
> here if the API is supposed to be "invoke fn() on each canary byte,
> but stop when fn() returns false". But I suppose it doesn't really
> matter, so either way is fine.

Hmm, perhaps if there are corruptions on either side of an object
printing both errors (which includes indications of which bytes were
corrupted) might give more insights into what went wrong. Printing
errors for every canary byte on one side didn't make much sense
though, hence the break.

Until we see this in the wild, let's err on the side of "more
information might be better".

> > +       }
> > +
> > +       /* Check right of object. */
> > +       for (addr = meta->addr + meta->size; addr < pageaddr + PAGE_SIZE; addr++) {
> > +               if (!fn((u8 *)addr))
> > +                       break;
> > +       }
> > +}
> > +
> > +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> > +{
> [...]
> > +       /* Set required struct page fields. */
> > +       page = virt_to_page(meta->addr);
> > +       page->slab_cache = cache;
> > +       if (IS_ENABLED(CONFIG_SLUB))
> > +               page->objects = 1;
> > +       if (IS_ENABLED(CONFIG_SLAB))
> > +               page->s_mem = addr;
>
> Maybe move the last 4 lines over into the "hooks for SLAB" and "hooks
> for SLUB" patches?

Done.

> [...]
> > +}
> [...]
> > diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> [...]
> > +/*
> > + * Get the number of stack entries to skip get out of MM internals. @type is
>
> s/to skip get out/to skip to get out/ ?

Done.

> > + * optional, and if set to NULL, assumes an allocation or free stack.
> > + */
> > +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
> > +                           const enum kfence_error_type *type)
> [...]
> > +void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
> > +                        enum kfence_error_type type)
> > +{
> [...]
> > +       case KFENCE_ERROR_CORRUPTION: {
> > +               size_t bytes_to_show = 16;
> > +
> > +               pr_err("BUG: KFENCE: memory corruption in %pS\n\n", (void *)stack_entries[skipnr]);
> > +               pr_err("Corrupted memory at 0x" PTR_FMT " ", (void *)address);
> > +
> > +               if (address < meta->addr)
> > +                       bytes_to_show = min(bytes_to_show, meta->addr - address);
> > +               print_diff_canary((u8 *)address, bytes_to_show);
>
> If the object was located on the right side, but with 1 byte padding
> to the right due to alignment, and a 1-byte OOB write had clobbered
> the canary byte on the right side, we would later detect a
> KFENCE_ERROR_CORRUPTION at offset 0xfff inside the page, right? In
> that case, I think we'd end up trying to read 15 canary bytes from the
> following guard page and take a page fault?
>
> You may want to do something like:
>
> unsigned long canary_end = (address < meta->addr) ? meta->addr :
> address | (PAGE_SIZE-1);
> bytes_to_show = min(bytes_to_show, canary_end);

print_diff_canary() calculates max_addr using PAGE_ALIGN(), and we
won't read from the next page. I think I'll move all this logic into
print_diff_canary() to simplify.

Thanks,
-- Marco
