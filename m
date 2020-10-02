Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908D2280D23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgJBFpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgJBFpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:45:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14764C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 22:45:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so242543ejy.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 22:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/Mw4dhIBbKvuicToqPryCf8ZS6JkibVyJYbIfuE7Gs=;
        b=nEcpsbTxpqqR71sX3y9AeMu/5IDZjBWpyv3LTWExEnlMfdABMkG6DRWo06vinq90ka
         v0yKY98+cFdnzQaGPNqgP67Qi9jy40ePsimddpuPZK6/8+YptTg00PoI6JI+R6+xHlM7
         7IIh84MVJc1TIsQGsF0COrkSpLSXnQuttWl3oCsAFb/86eFiRu8LMpBI62BrvWHqYDCt
         igLUiBNCWVCc82jzMx1R4TEruzIymmgeSBaPaguSMN8pUkQYZNLXXkP4V51VdUdj5w19
         7NpXjxLmPtWTYGqVPqKTlrhupfuKQklo6bXJHXlJsBt1W9xk1SGNWZqoa8SM/vrMPR8I
         TOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/Mw4dhIBbKvuicToqPryCf8ZS6JkibVyJYbIfuE7Gs=;
        b=Qr2yLTQkTliWlSVK/i1rrvEIRu9UyBtDRHdh1pA3tEP7DzrJMVn9kAqhY1Cy5nb6fe
         fMCJtlbG4+Jo+VKyz8P4KevSZEsKkff0zlSVP+0R/a/c+/cXgD++Y3iUA08iurdGP/Zp
         C6aw+NtdTCw51whKkoeRnXpu99HjnBuYX2NXF7r0znKu+3NaembO6c5fphRF48I0x3IR
         xTkBLfCHhliL6QLNe+Vj6A6SAZxsXjtsfUrdTxyZjecZI3SYmMfCr9Ppi2DfO2k7TePv
         FwdE0Xm4dy7nwSjwzVkdToCV0V5CmX4kqD/zmQJZG+23aOCaj4VGLDwqW8kx4S7IsxWG
         dYhA==
X-Gm-Message-State: AOAM530AyY+dw1237yODkVbx/LSoVgoyC6aukOOm7Th/hFjFktePW/fn
        E3hbaGYA2XayVGnfo74R7xG6j/s7t3ERMG/HuxI2LQ==
X-Google-Smtp-Source: ABdhPJzXOQ4q/0XNF+hH7IjC+tsOfmsFCnx+oA/SC0g0BOQxITnnOLwyjE9pbF+CiN/9VUfkrD72NheY/yFuiHP5P8s=
X-Received: by 2002:a17:906:9156:: with SMTP id y22mr174829ejw.184.1601617547226;
 Thu, 01 Oct 2020 22:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-3-elver@google.com>
In-Reply-To: <20200929133814.2834621-3-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 07:45:20 +0200
Message-ID: <CAG48ez3OKj5Y8BURmqU9BAYWFJH8E8B5Dj9c0=UHutqf7r3hhg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
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
        Ingo Molnar <mingo@redhat.com>, Jonathan.Cameron@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the x86 architecture. In particular, this implements the
> required interface in <asm/kfence.h> for setting up the pool and
> providing helper functions for protecting and unprotecting pages.
>
> For x86, we need to ensure that the pool uses 4K pages, which is done
> using the set_memory_4k() helper function.
[...]
> diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
[...]
> +/* Protect the given page and flush TLBs. */
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +       unsigned int level;
> +       pte_t *pte = lookup_address(addr, &level);
> +
> +       if (!pte || level != PG_LEVEL_4K)

Do we actually expect this to happen, or is this just a "robustness"
check? If we don't expect this to happen, there should be a WARN_ON()
around the condition.

> +               return false;
> +
> +       if (protect)
> +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> +       else
> +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));

Hmm... do we have this helper (instead of using the existing helpers
for modifying memory permissions) to work around the allocation out of
the data section?

> +       flush_tlb_one_kernel(addr);
> +       return true;
> +}
> +
> +#endif /* _ASM_X86_KFENCE_H */
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
[...]
> @@ -701,6 +702,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>         }
>  #endif
>
> +       if (kfence_handle_page_fault(address))
> +               return;
> +
>         /*
>          * 32-bit:
>          *

The standard 5 lines of diff context don't really make it obvious
what's going on here. Here's a diff with more context:


        /*
         * Stack overflow?  During boot, we can fault near the initial
         * stack in the direct map, but that's not an overflow -- check
         * that we're in vmalloc space to avoid this.
         */
        if (is_vmalloc_addr((void *)address) &&
            (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
             address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
                unsigned long stack = __this_cpu_ist_top_va(DF) -
sizeof(void *);
                /*
                 * We're likely to be running with very little stack space
                 * left.  It's plausible that we'd hit this condition but
                 * double-fault even before we get this far, in which case
                 * we're fine: the double-fault handler will deal with it.
                 *
                 * We don't want to make it all the way into the oops code
                 * and then double-fault, though, because we're likely to
                 * break the console driver and lose most of the stack dump.
                 */
                asm volatile ("movq %[stack], %%rsp\n\t"
                              "call handle_stack_overflow\n\t"
                              "1: jmp 1b"
                              : ASM_CALL_CONSTRAINT
                              : "D" ("kernel stack overflow (page fault)"),
                                "S" (regs), "d" (address),
                                [stack] "rm" (stack));
                unreachable();
        }
 #endif

+       if (kfence_handle_page_fault(address))
+               return;
+
        /*
         * 32-bit:
         *
         *   Valid to do another page fault here, because if this fault
         *   had been triggered by is_prefetch fixup_exception would have
         *   handled it.
         *
         * 64-bit:
         *
         *   Hall of shame of CPU/BIOS bugs.
         */
        if (is_prefetch(regs, error_code, address))
                return;

        if (is_errata93(regs, address))
                return;

        /*
         * Buggy firmware could access regions which might page fault, try to
         * recover from such faults.
         */
        if (IS_ENABLED(CONFIG_EFI))
                efi_recover_from_page_fault(address);

 oops:
        /*
         * Oops. The kernel tried to access some bad page. We'll have to
         * terminate things with extreme prejudice:
         */
        flags = oops_begin();



Shouldn't kfence_handle_page_fault() happen after prefetch handling,
at least? Maybe directly above the "oops" label?
