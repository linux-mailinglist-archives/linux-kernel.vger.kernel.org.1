Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B775285FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgJGNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgJGNJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:09:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B5C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:09:08 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l4so2103730ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+vdTZV1rixc4rZMr4BboFv1cYBtz4vmBbW7LOKVMmM=;
        b=DA6B/QuWWJ6abSG8x2CpeZdGhRX/3oToa8SdG/bY58JWSX4fHKlIpeK2iOwefjLQD3
         HLCcorm00DZfsuhcNvUP+CDarsggpjVQwQdtRNKjYndU1Y9xAWJWgnkmf/UqV6DGl/JD
         W8gR2P6U63j6Zv6/O3XbYa3D8xIfGGVOJRz2qF19GCuvh+y7WRlo/cXckCCgh32yPSdh
         UB1IIRUUHmzJTErYcVaLa4tbq6Qb+QBfapLRpJ/q/i9V0gI+2JA8kThsw/MZquNRH5Xn
         8akNq/UEOfhZ8Tum/jg+WJRmPDvXsIMlEznEkFUJCvsSVLbhZONi1eFHcsCyD/m718pd
         cccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+vdTZV1rixc4rZMr4BboFv1cYBtz4vmBbW7LOKVMmM=;
        b=bKDH3CV42UL6yC7Ym/oUyM+opPyg6ItABCCCh0lbvQbBw4VThotVUQ5yNjN4OYj/vc
         cnlKwKULmRNxleKYr30s40oU8XTpVN/Gs5vapV4ud2vY/yJS8CdFkHGkUml84UaPhr8R
         ln0BoQYTVVp1yvD1KKcQtaFs9XiAaoVbJC4WejS5OLhSRmP8hN3v+Z2TGWohyICsAEZf
         ume+26N6+HXauPjXLSp5L2T3qYBsfrIrhcoNV7iToO7MQM5/CXfN5G4rYbguoO/SkoqP
         c0BhM8sXcGDV2u+lM1hA8FWuAb07MWa4WuhhWYSsq71i2OjXBuQjVjfOyP9xSN5RmP4A
         3oMg==
X-Gm-Message-State: AOAM532hQ4629sqiri8oa53k9vcpHDML4TMqNTffy9ggQs6XatM+U1wm
        rafU7Se3nAujwsqmNnThNthEvybUBDZ7KgW34QXnJQ==
X-Google-Smtp-Source: ABdhPJzmEMbM2ed2iTUf2uXSFPJhT+rIlO7bAUUOBD8wBltb7Fr4FekytLMrMK9nNsP4GJ92+02/K0TQLxLG1w9IFBU=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr1884792otn.233.1602076147446;
 Wed, 07 Oct 2020 06:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-3-elver@google.com>
 <CAG48ez3OKj5Y8BURmqU9BAYWFJH8E8B5Dj9c0=UHutqf7r3hhg@mail.gmail.com>
In-Reply-To: <CAG48ez3OKj5Y8BURmqU9BAYWFJH8E8B5Dj9c0=UHutqf7r3hhg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Oct 2020 15:08:55 +0200
Message-ID: <CANpmjNP6mukCZ931_aW9dDqbkOyv=a2zbS7MuEMkE+unb7nYeg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 at 07:45, Jann Horn <jannh@google.com> wrote:
>
> On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > Add architecture specific implementation details for KFENCE and enable
> > KFENCE for the x86 architecture. In particular, this implements the
> > required interface in <asm/kfence.h> for setting up the pool and
> > providing helper functions for protecting and unprotecting pages.
> >
> > For x86, we need to ensure that the pool uses 4K pages, which is done
> > using the set_memory_4k() helper function.
> [...]
> > diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
> [...]
> > +/* Protect the given page and flush TLBs. */
> > +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> > +{
> > +       unsigned int level;
> > +       pte_t *pte = lookup_address(addr, &level);
> > +
> > +       if (!pte || level != PG_LEVEL_4K)
>
> Do we actually expect this to happen, or is this just a "robustness"
> check? If we don't expect this to happen, there should be a WARN_ON()
> around the condition.

It's not obvious here, but we already have this covered with a WARN:
the core.c code has a KFENCE_WARN_ON, which disables KFENCE on a
warning.

> > +               return false;
> > +
> > +       if (protect)
> > +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> > +       else
> > +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>
> Hmm... do we have this helper (instead of using the existing helpers
> for modifying memory permissions) to work around the allocation out of
> the data section?

I just played around with using the set_memory.c functions, to remind
myself why this didn't work. I experimented with using
set_memory_{np,p}() functions; set_memory_p() isn't implemented, but
is easily added (which I did for below experiment). However, this
didn't quite work:

WARNING: CPU: 6 PID: 107 at kernel/smp.c:490
smp_call_function_many_cond+0x9c/0x2a0 kernel/smp.c:490
[...]
Call Trace:
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x3e/0x90 kernel/smp.c:698
 __purge_vmap_area_lazy+0x58/0x670 mm/vmalloc.c:1352
 _vm_unmap_aliases.part.0+0x10b/0x140 mm/vmalloc.c:1770
 change_page_attr_set_clr+0xb4/0x1c0 arch/x86/mm/pat/set_memory.c:1732
 change_page_attr_set arch/x86/mm/pat/set_memory.c:1782 [inline]
 set_memory_p+0x21/0x30 arch/x86/mm/pat/set_memory.c:1950
 kfence_protect_page arch/x86/include/asm/kfence.h:55 [inline]
 kfence_protect_page arch/x86/include/asm/kfence.h:43 [inline]
 kfence_unprotect+0x42/0x70 mm/kfence/core.c:139
 no_context+0x115/0x300 arch/x86/mm/fault.c:705
 handle_page_fault arch/x86/mm/fault.c:1431 [inline]
 exc_page_fault+0xa7/0x170 arch/x86/mm/fault.c:1486
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538

For one, smp_call_function_many_cond() doesn't want to be called with
interrupts disabled, and we may very well get a KFENCE allocation or
page fault with interrupts disabled / within interrupts.

Therefore, to be safe, we should avoid IPIs. It follows that setting
the page attribute is best-effort, and we can tolerate some
inaccuracy. Lazy fault handling should take care of faults after we
set the page as PRESENT.

Which hopefully also answers your other comment:

> flush_tlb_one_kernel() -> flush_tlb_one_user() ->
> __flush_tlb_one_user() -> native_flush_tlb_one_user() only flushes on
> the local CPU core, not on others. If you want to leave it this way, I
> think this needs a comment explaining why we're not doing a global
> flush (locking context / performance overhead / ... ?).

We'll add a comment to clarify why it's done this way.

> > +       flush_tlb_one_kernel(addr);
> > +       return true;
> > +}
> > +
> > +#endif /* _ASM_X86_KFENCE_H */
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> [...]
> > @@ -701,6 +702,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> >         }
> >  #endif
> >
> > +       if (kfence_handle_page_fault(address))
> > +               return;
> > +
> >         /*
> >          * 32-bit:
> >          *
>
> The standard 5 lines of diff context don't really make it obvious
> what's going on here. Here's a diff with more context:
>
>
>         /*
>          * Stack overflow?  During boot, we can fault near the initial
>          * stack in the direct map, but that's not an overflow -- check
>          * that we're in vmalloc space to avoid this.
>          */
>         if (is_vmalloc_addr((void *)address) &&
>             (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
>              address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
>                 unsigned long stack = __this_cpu_ist_top_va(DF) -
> sizeof(void *);
>                 /*
>                  * We're likely to be running with very little stack space
>                  * left.  It's plausible that we'd hit this condition but
>                  * double-fault even before we get this far, in which case
>                  * we're fine: the double-fault handler will deal with it.
>                  *
>                  * We don't want to make it all the way into the oops code
>                  * and then double-fault, though, because we're likely to
>                  * break the console driver and lose most of the stack dump.
>                  */
>                 asm volatile ("movq %[stack], %%rsp\n\t"
>                               "call handle_stack_overflow\n\t"
>                               "1: jmp 1b"
>                               : ASM_CALL_CONSTRAINT
>                               : "D" ("kernel stack overflow (page fault)"),
>                                 "S" (regs), "d" (address),
>                                 [stack] "rm" (stack));
>                 unreachable();
>         }
>  #endif
>
> +       if (kfence_handle_page_fault(address))
> +               return;
> +
>         /*
>          * 32-bit:
>          *
>          *   Valid to do another page fault here, because if this fault
>          *   had been triggered by is_prefetch fixup_exception would have
>          *   handled it.
>          *
>          * 64-bit:
>          *
>          *   Hall of shame of CPU/BIOS bugs.
>          */
>         if (is_prefetch(regs, error_code, address))
>                 return;
>
>         if (is_errata93(regs, address))
>                 return;
>
>         /*
>          * Buggy firmware could access regions which might page fault, try to
>          * recover from such faults.
>          */
>         if (IS_ENABLED(CONFIG_EFI))
>                 efi_recover_from_page_fault(address);
>
>  oops:
>         /*
>          * Oops. The kernel tried to access some bad page. We'll have to
>          * terminate things with extreme prejudice:
>          */
>         flags = oops_begin();
>
>
>
> Shouldn't kfence_handle_page_fault() happen after prefetch handling,
> at least? Maybe directly above the "oops" label?

Good question. AFAIK it doesn't matter, as is_kfence_address() should
never apply for any of those that follow, right? In any case, it
shouldn't hurt to move it down.

Thanks,
-- Marco
