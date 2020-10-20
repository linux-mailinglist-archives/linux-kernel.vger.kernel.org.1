Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684D9283F32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgJETAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgJETAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:00:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F54C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:00:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so9751253oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgyVeWM2KFwaEKtxvi0k5vnLHgxboX9dQWrAwhLZ6sM=;
        b=Ky1b95z9ctxi5Up6vlAjc2Sxv+MR7UCALpWjrjeUBeeemtaEGwZe9ejzUJSjnqtClo
         ReUuS+LFV7Pk5Bhi9vXooH6kJAtdsj5SAxpT4b1SzN5FmVmWgnVZZ+gmZiGkbBF/xvdc
         LbxZkShlVJragtp+g5FcfCbiM65I7so+1l5boJRu6oBARjnlFR2MwpIQaLXEsO8SsQfv
         j39YatgwTx9rnBMhn+MZSrM82o5/g1sAniUNwPFHZ/5upL26RXXMGgSklQnyM9vGF9tc
         fDxyE2Oc/XlaPyAd4iSslCujS84buEYweStGARsnJMW56Mcgdn721RtOuSFuvo/A0maq
         Inmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgyVeWM2KFwaEKtxvi0k5vnLHgxboX9dQWrAwhLZ6sM=;
        b=rbrCbi3uPWmUYkV0TMzq/cQsULikGayYHW1L6hof/ifODuNOykQ7qy/ovC1uE0B8n1
         IyshAunF13vixgeY9uck5OkAIOd34XVnYH26NROMs9WZNRObyLLonGyzP0KyeelKoQ1M
         DBaZe9b52vBjZGZYQJOWDTAaqDZ2nkXo/YOt/f+ivvbBnytZ/jVXUOYFmwEQ3UXgx2jv
         vIHBI45hEODqkMiLmScqzgfR7pIai6T/yBND6ND9wi5jj59PpBEaaG0X5HcOjD/5+isI
         oj/oavtMFLnqTLOv6OB+Z47o4OT8b8WLiPtAaMBPSz9b1e1F5cl6VZoWP9PV8q+FFsRe
         DVMw==
X-Gm-Message-State: AOAM533yjdwU7Ppq7vj+/QajaaC7dpyKRgHsXFlbd6AK/4CAeP+dQl8D
        BXXNpeS9FN+5g28gT9PmLxLJUDHIyeavISD+AJ0YhQ==
X-Google-Smtp-Source: ABdhPJyzVuth4CKP/Ne+wOuwyABlhcWUIOPRj8t4qy87nTBlOmB6Th6J+bzOAcqymPkEx9q7xzjLSwJPeD+YCnkxBi4=
X-Received: by 2002:a54:468f:: with SMTP id k15mr488388oic.121.1601924400739;
 Mon, 05 Oct 2020 12:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
 <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com>
 <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com> <CAG48ez1RYbpMFbGFB6=9Y3vVCGrMgLS3LbDdxzBfmxH6Kxddmw@mail.gmail.com>
In-Reply-To: <CAG48ez1RYbpMFbGFB6=9Y3vVCGrMgLS3LbDdxzBfmxH6Kxddmw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Oct 2020 20:59:49 +0200
Message-ID: <CANpmjNPZxvWXTnJvkuwUifM5EjPetKxTJ7ectbw_7JFoBLB4EA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
To:     Jann Horn <jannh@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 at 20:28, Jann Horn <jannh@google.com> wrote:
[...]
> > >
> > > Do you have performance numbers or a description of why you believe
> > > that this part of kfence is exceptionally performance-sensitive? If
> > > not, it might be a good idea to remove this optimization, at least for
> > > the initial version of this code. (And even if the optimization is
> > > worthwhile, it might be a better idea to go for the generic version
> > > immediately.)
> >
> > This check is very hot, it happens on every free. For every freed
> > object we need to understand if it belongs to KFENCE or not.
>
> Ah, so the path you care about does not dereference __kfence_pool, it
> just compares it to the supplied pointer?
>
>
> First off: The way you've written is_kfence_address(), GCC 10.2 at -O3
> seems to generate *utterly* *terrible* code (and the newest clang
> release isn't any better); something like this:
>
> kfree_inefficient:
>   mov rax, QWORD PTR __kfence_pool[rip]
>   cmp rax, rdi
>   jbe .L4
> .L2:
>   jmp kfree_not_kfence
> .L4:
>   add rax, 0x200000
>   cmp rax, rdi
>   jbe .L2
>   jmp kfree_kfence
>
> So pointers to the left of the region and pointers to the right of the
> region will take different branches, and so if you have a mix of
> objects on both sides of the kfence region, you'll get tons of branch
> mispredictions for no good reason. You'll want to rewrite that check
> as "unlikely(ptr - base <= SIZE)" instead of "unlikely(ptr >= base &&
> ptr < base + SIZE" unless you know that all the objects will be on one
> side. This would also reduce the performance impact of loading
> __kfence_pool from the data section, because the branch prediction can
> then speculate the branch that depends on the load properly and
> doesn't have to go roll back everything that happened when the object
> turns out to be on the opposite side of the kfence memory region - the
> latency of the load will hopefully become almost irrelevant.

Good point, implemented that. (It's "ptr - base < SIZE" I take it.)

> So in x86 intel assembly (assuming that we want to ensure that we only
> do a single branch on the object type), the straightforward and
> non-terrible version would be:
>
>
> kfree_unoptimized:
>   mov rax, rdi
>   sub rax, QWORD PTR __kfence_pool[rip]
>   cmp rax, 0x200000
>   jbe 1f
>   /* non-kfence case goes here */
> 1:
>   /* kfence case goes here */
>
>
> while the version you want is:
>
>
> kfree_static:
>   mov rax, rdi
>   sub rax, OFFSET FLAT:__kfence_pool
>   cmp rax, 0x200000
>   jbe 1f
>   jmp kfree_not_kfence
> 1:
>   jmp kfree_kfence
>
>
> If we instead use something like
>
> #define STATIC_VARIABLE_LOAD(variable) \
> ({ \
>   typeof(variable) value; \
>   BUILD_BUG_ON(sizeof(variable) != sizeof(unsigned long)); \
>   asm( \
>     ".pushsection .static_variable_users\n\t" \
>     ".long "  #variable " - .\n\t" \
>     ".long 123f - .\n\t" /* offset to end of constant */ \
>     ".popsection\n\t" \
>     "movabs $0x0123456789abcdef, %0" \
>     "123:\n\t" \
>     :"=r"(value) \
>   ); \
>   value; \
> })
> static __always_inline bool is_kfence_address(const void *addr)
> {
>   return unlikely((char*)addr - STATIC_VARIABLE_LOAD(__kfence_pool) <
> KFENCE_POOL_SIZE);
> }
>
> to locate the pool (which could again be normally allocated with
> alloc_pages()), we'd get code like this, which is like the previous
> except that we need an extra "movabs" because x86's "sub" can only use
> immediates up to 32 bits:
>
> kfree_hotpatchable_bigreloc:
>   mov rax, rdi
>   movabs rdx, 0x0123456789abcdef
>   sub rax, rdx
>   cmp rax, 0x200000
>   jbe .1f
>   jmp kfree_not_kfence
> 1:
>   jmp kfree_kfence
>
> The arch-specific part of this could probably be packaged up pretty
> nicely into a generic interface. If it actually turns out to have a
> performance benefit, that is.

Something like this would certainly be nice, but we'll do the due
diligence and see if it's even worth it.

> If that one extra "movabs" is actually a problem, it would
> *theoretically* be possible to get rid of that by using module_alloc()
> to allocate virtual memory to which offsets from kernel text are 32
> bits, and using special-cased inline asm, but we probably shouldn't do
> that, because as Mark pointed out, we'd then risk getting extremely
> infrequent extra bugs when drivers use phys_to_virt() on allocations
> that were done through kfence. Adding new, extremely infrequent and
> sporadically occurring bugs to the kernel seems like the exact
> opposite of the goal of KFENCE. :P
>
> Overall my expectation would be that the MOVABS version should
> probably at worst be something like one cycle slower - it adds 5
> instruction bytes (and we pay 1 cycle in the frontend per 16 bytes of
> instructions, I think?) and 1 backend cycle (for the MOVABS - Agner
> Fog's tables seem to say that at least on Skylake, MOVABS is 1 cycle).
> But that backend cycle shouldn't even be on the critical path (and it
> has a wider choice of ports than e.g. a load, and I think typical
> kernel code isn't exactly highly parallelizable, so we can probably
> schedule on a port that would've been free otherwise?), and I think
> typical kernel code should be fairly light on the backend, so with the
> MOVABS version, compared to the version with __kfence_pool in the data
> section, we probably overall just pay a fraction of a cycle in
> execution cost? I'm not a professional performance engineer, but this
> sounds to me like the MOVABS version should probably perform roughly
> as well as your version.
>
> Anyway, I guess this is all pretty vague without actually having
> concrete benchmark results. :P
>
> See <https://godbolt.org/z/Kev9dc> for examples of actual code
> generation for different options of writing this check.

Thanks for the analysis!  There is also some (11 year old) prior art,
that seems to never have made it into the kernel:
https://lore.kernel.org/lkml/20090924132626.485545323@polymtl.ca/

Maybe we need to understand why that never made it.

But I think, even if we drop the static pool, a first version of
KFENCE should not depend on it.

Thanks,
-- Marco
