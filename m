Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF529FBAA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgJ3Cto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3Ctm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:49:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so5987481lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxX9Me9cwsFEBumfTFk5EKdPQHJ86xf2rO/msdc2EqI=;
        b=iaLTL98NqU6FBBQxLOjbfNc6+/hVBdtelfbZUgX3oDGyKoKWu35O5PvbnQ9yqiIacZ
         EJzWLLHfT9z21eWJXYkNJ3hkxuLZH6cPUEChjVxPZNie8VKwO09h5NvkLGxH8rb8eczk
         bQ33aVScXy3Hl7hXI+bHOQS2lnFt1YX8x7sYgD09huCO9OD92ak4WynH0aH+GNO4BjSF
         gtiSASThSF9TmJaYQFZMfOga3t8pU4xWUYZfsxAMequzUue6O1eHHLFKWc+BSyzuRMF8
         zh1IjwOnFWxof5hzUVLt/oh5T9YfoZFtpGiXPVRPi3Ibr8c1IT87OwTCwlIRIzsDLSxD
         B46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxX9Me9cwsFEBumfTFk5EKdPQHJ86xf2rO/msdc2EqI=;
        b=LHXS/gAadhz4+aBkHII10qKgw+wfl2vWFLrpDfiWgPTNT0r7492yxhwdNkqD8Z/72x
         H4gl+BCaQz7ToZNcACd+E/9+PRT4bNXmoFEPQxqY0+6BGQ1sL0+ZDYG4prHAwYdmyf2t
         x5pZNq0YWaYAHXDNi9m36WWLGnzUmuMdsxMETffbVFXCYh+Do/nkQUbCtA2CqK0itK/F
         OwQncPepaE78VK2YAGJqtxC8+V4uJJs57g2a7lVuRMj8VIqn3MVQ5O23t/D22XvIExJZ
         N+ITa6U6P6xNBZIBvghXFpgISkpm7J1019+RJ+c14Epzcr820PEoKp0uy6iU07K5UgiR
         lZxw==
X-Gm-Message-State: AOAM5309CxZ4eGFfC8n5dzJr6nQYoBMTDHN9LPRkYR+vnqRtNvAeb8yi
        RO2zniyJuOAHI838ZrjKLKba58d5YuKstCqLMiDE7w==
X-Google-Smtp-Source: ABdhPJx+vH+ZHNK7ydX1Nmu3QMRgdDhq55zeSv2xkmDEn8Qj0VKsLIZDBHt4K6upZ92hBQN5BdvkJJpZMYFZ0fdTTy4=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr23811lfb.576.1604026180208;
 Thu, 29 Oct 2020 19:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-2-elver@google.com>
In-Reply-To: <20201029131649.182037-2-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:12 +0100
Message-ID: <CAG48ez0TgomTec+r188t0ddYVZtivOkL1DvR3owiuDTBtgPNzA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] mm: add Kernel Electric-Fence infrastructure
To:     Marco Elver <elver@google.com>
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
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

On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.
[...]
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
[...]
> +/**
> + * is_kfence_address() - check if an address belongs to KFENCE pool
> + * @addr: address to check
> + *
> + * Return: true or false depending on whether the address is within the KFENCE
> + * object range.
> + *
> + * KFENCE objects live in a separate page range and are not to be intermixed
> + * with regular heap objects (e.g. KFENCE objects must never be added to the
> + * allocator freelists). Failing to do so may and will result in heap
> + * corruptions, therefore is_kfence_address() must be used to check whether
> + * an object requires specific handling.
> + */

It might be worth noting in the comment that this is one of the few
parts of KFENCE that are highly performance-sensitive, since that was
an important point during the review.

> +static __always_inline bool is_kfence_address(const void *addr)
> +{
> +       /*
> +        * The non-NULL check is required in case the __kfence_pool pointer was
> +        * never initialized; keep it in the slow-path after the range-check.
> +        */
> +       return unlikely((unsigned long)((char *)addr - __kfence_pool) < KFENCE_POOL_SIZE && addr);
> +}
[...]
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
[...]
> +config KFENCE_STRESS_TEST_FAULTS
> +       int "Stress testing of fault handling and error reporting"
> +       default 0
> +       depends on EXPERT
> +       help
> +         The inverse probability with which to randomly protect KFENCE object
> +         pages, resulting in spurious use-after-frees. The main purpose of
> +         this option is to stress test KFENCE with concurrent error reports
> +         and allocations/frees. A value of 0 disables stress testing logic.
> +
> +         The option is only to test KFENCE; set to 0 if you are unsure.
[...]
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
[...]
> +#ifndef CONFIG_KFENCE_STRESS_TEST_FAULTS /* Only defined with CONFIG_EXPERT. */
> +#define CONFIG_KFENCE_STRESS_TEST_FAULTS 0
> +#endif

I think you can make this prettier by writing the Kconfig
appropriately. See e.g. ARCH_MMAP_RND_BITS:

config ARCH_MMAP_RND_BITS
  int "Number of bits to use for ASLR of mmap base address" if EXPERT
  range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
  default ARCH_MMAP_RND_BITS_DEFAULT if ARCH_MMAP_RND_BITS_DEFAULT
  default ARCH_MMAP_RND_BITS_MIN
  depends on HAVE_ARCH_MMAP_RND_BITS

So instead of 'depends on EXPERT', I think the proper way would be to
append ' if EXPERT' to the line
'int "Stress testing of fault handling and error reporting"', so that
only whether the option is user-visible depends on EXPERT, and
non-EXPERT configs automatically use the default value.

[...]
> +static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
> +{
> +       unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
> +       unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> +
> +       /* The checks do not affect performance; only called from slow-paths. */
> +
> +       /* Only call with a pointer into kfence_metadata. */
> +       if (KFENCE_WARN_ON(meta < kfence_metadata ||
> +                          meta >= kfence_metadata + CONFIG_KFENCE_NUM_OBJECTS))
> +               return 0;
> +
> +       /*
> +        * This metadata object only ever maps to 1 page; verify the calculation
> +        * happens and that the stored address was not corrupted.

nit: This reads a bit weirdly to me. Maybe "; verify that the stored
address is in the expected range"? But feel free to leave it as-is if
you prefer it that way.

> +        */
> +       if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> +               return 0;
> +
> +       return pageaddr;
> +}
[...]
> +/* __always_inline this to ensure we won't do an indirect call to fn. */
> +static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
> +{
> +       const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
> +       unsigned long addr;
> +
> +       lockdep_assert_held(&meta->lock);
> +
> +       /* Check left of object. */
> +       for (addr = pageaddr; addr < meta->addr; addr++) {
> +               if (!fn((u8 *)addr))
> +                       break;

It could be argued that "return" instead of "break" would be cleaner
here if the API is supposed to be "invoke fn() on each canary byte,
but stop when fn() returns false". But I suppose it doesn't really
matter, so either way is fine.

> +       }
> +
> +       /* Check right of object. */
> +       for (addr = meta->addr + meta->size; addr < pageaddr + PAGE_SIZE; addr++) {
> +               if (!fn((u8 *)addr))
> +                       break;
> +       }
> +}
> +
> +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> +{
[...]
> +       /* Set required struct page fields. */
> +       page = virt_to_page(meta->addr);
> +       page->slab_cache = cache;
> +       if (IS_ENABLED(CONFIG_SLUB))
> +               page->objects = 1;
> +       if (IS_ENABLED(CONFIG_SLAB))
> +               page->s_mem = addr;

Maybe move the last 4 lines over into the "hooks for SLAB" and "hooks
for SLUB" patches?

[...]
> +}
[...]
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
[...]
> +/*
> + * Get the number of stack entries to skip get out of MM internals. @type is

s/to skip get out/to skip to get out/ ?

> + * optional, and if set to NULL, assumes an allocation or free stack.
> + */
> +static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
> +                           const enum kfence_error_type *type)
[...]
> +void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
> +                        enum kfence_error_type type)
> +{
[...]
> +       case KFENCE_ERROR_CORRUPTION: {
> +               size_t bytes_to_show = 16;
> +
> +               pr_err("BUG: KFENCE: memory corruption in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Corrupted memory at 0x" PTR_FMT " ", (void *)address);
> +
> +               if (address < meta->addr)
> +                       bytes_to_show = min(bytes_to_show, meta->addr - address);
> +               print_diff_canary((u8 *)address, bytes_to_show);

If the object was located on the right side, but with 1 byte padding
to the right due to alignment, and a 1-byte OOB write had clobbered
the canary byte on the right side, we would later detect a
KFENCE_ERROR_CORRUPTION at offset 0xfff inside the page, right? In
that case, I think we'd end up trying to read 15 canary bytes from the
following guard page and take a page fault?

You may want to do something like:

unsigned long canary_end = (address < meta->addr) ? meta->addr :
address | (PAGE_SIZE-1);
bytes_to_show = min(bytes_to_show, canary_end);



> +               pr_cont(" (in kfence-#%zd):\n", object_index);
> +               break;
> +       }
