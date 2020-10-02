Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B079281ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbgJBS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:28:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:28:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md26so3231096ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsYux+2mDidOv01anJDY4ry73gJii56cZfxQL8DhjP4=;
        b=iyd0xHn4pqAUWDMGwczEUFCBJENEtyZtyKCMJHta/ydXRMM9/B99IrtUiiRN+s5bOF
         TTtr781sbHxsOWsEU5+byp+ROmF9ODhkPJHBOslK1Y9ry1Ji08z/rLjC3CK+391Yba5B
         VFeGBNOweTd+OzOFQHgzSldQFVLX+tbjgtZyz1hMEmIUFFs7GecCx0rxlPaNYodd7ER4
         zyIOJci5vzTKf6Z224hXvN2ABvNft70rqsw9MsbdNEXQWu3Dl5OdAYJOfQLpwgDtgvkt
         rQqnq41eu2st0HnmbRX+mvmKbKEJRkEkmjMvSVq0dHXpdwNET9/wZZzdNahlc1LYPg6F
         WAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsYux+2mDidOv01anJDY4ry73gJii56cZfxQL8DhjP4=;
        b=SnuSlkGIigFWuT1Vrk417BiJtkI2XMEfZsgMpmF+5Qb2Iffs/FO7vPbSrvDiV5fDNX
         n57Niacu+1SzyrjfYpKM3B9YIhF2cROo4kSgp8THhEHlWHnhKcYLQ1cwww8AwwrXBKba
         15mWnUQJGOCAn6SAI7hoS/D5faV0/6YTc/TCOeDq2uOSJavewn9GmwGv3CjWL1LF/79o
         hi2QtVWcM6wOROaTofbvLqNyyZXDc5Rb4v+VxZetRjuYBkvioZmOzp4rmNNI2MZ+UVss
         /puIwIz3yr55QS5ytfX2934eNNugnyu96s6JQNINIlOfb2ckNXCNRv++wxr0gj1vXmzM
         4wKw==
X-Gm-Message-State: AOAM530YIFN64qcM/eQhgtoRSI3lPHi+ej2jQPlhxQFXXr4zmwEOu4gc
        oQe1o+8UWaFgO7utST5xSQM4idVL1G3ugzdlp/H1iA==
X-Google-Smtp-Source: ABdhPJzgKrliXRN5QPqAAT9OPrizyhjQuMQ0C89osYzNNCBB+hq/RPtF3G0uUVP4RgyWMHeWl01Rv7KBt75igmVc/08=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr3465227eja.513.1601663305597;
 Fri, 02 Oct 2020 11:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
 <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com> <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com>
In-Reply-To: <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 20:27:59 +0200
Message-ID: <CAG48ez1RYbpMFbGFB6=9Y3vVCGrMgLS3LbDdxzBfmxH6Kxddmw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
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

On Fri, Oct 2, 2020 at 4:23 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Oct 2, 2020 at 9:54 AM Jann Horn <jannh@google.com> wrote:
> > On Fri, Oct 2, 2020 at 8:33 AM Jann Horn <jannh@google.com> wrote:
> > > On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > > > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > > > low-overhead sampling-based memory safety error detector of heap
> > > > use-after-free, invalid-free, and out-of-bounds access errors.
> > > >
> > > > KFENCE is designed to be enabled in production kernels, and has near
> > > > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > > > for precision. The main motivation behind KFENCE's design, is that with
> > > > enough total uptime KFENCE will detect bugs in code paths not typically
> > > > exercised by non-production test workloads. One way to quickly achieve a
> > > > large enough total uptime is when the tool is deployed across a large
> > > > fleet of machines.
> > [...]
> > > > +/*
> > > > + * The pool of pages used for guard pages and objects. If supported, allocated
> > > > + * statically, so that is_kfence_address() avoids a pointer load, and simply
> > > > + * compares against a constant address. Assume that if KFENCE is compiled into
> > > > + * the kernel, it is usually enabled, and the space is to be allocated one way
> > > > + * or another.
> > > > + */
> > >
> > > If this actually brings a performance win, the proper way to do this
> > > would probably be to implement this as generic kernel infrastructure
> > > that makes the compiler emit large-offset relocations (either through
> > > compiler support or using inline asm statements that move an immediate
> > > into a register output and register the location in a special section,
> > > kinda like how e.g. static keys work) and patches them at boot time,
> > > or something like that - there are other places in the kernel where
> > > very hot code uses global pointers that are only ever written once
> > > during boot, e.g. the dentry cache of the VFS and the futex hash
> > > table. Those are probably far hotter than the kfence code.
> > >
> > > While I understand that that goes beyond the scope of this project, it
> > > might be something to work on going forward - this kind of
> > > special-case logic that turns the kernel data section into heap memory
> > > would not be needed if we had that kind of infrastructure.
> >
> > After thinking about it a bit more, I'm not even convinced that this
> > is a net positive in terms of overall performance - while it allows
> > you to avoid one level of indirection in some parts of kfence, that
> > kfence code by design only runs pretty infrequently. And to enable
> > this indirection avoidance, your x86 arch_kfence_initialize_pool() is
> > shattering potentially unrelated hugepages in the kernel data section,
> > which might increase the TLB pressure (and therefore the number of
> > memory loads that have to fall back to slow page walks) in code that
> > is much hotter than yours.
> >
> > And if this indirection is a real performance problem, that problem
> > would be many times worse in the VFS and the futex subsystem, so
> > developing a more generic framework for doing this cleanly would be
> > far more important than designing special-case code to allow kfence to
> > do this.
> >
> > And from what I've seen, a non-trivial chunk of the code in this
> > series, especially the arch/ parts, is only necessary to enable this
> > microoptimization.
> >
> > Do you have performance numbers or a description of why you believe
> > that this part of kfence is exceptionally performance-sensitive? If
> > not, it might be a good idea to remove this optimization, at least for
> > the initial version of this code. (And even if the optimization is
> > worthwhile, it might be a better idea to go for the generic version
> > immediately.)
>
> This check is very hot, it happens on every free. For every freed
> object we need to understand if it belongs to KFENCE or not.

Ah, so the path you care about does not dereference __kfence_pool, it
just compares it to the supplied pointer?


First off: The way you've written is_kfence_address(), GCC 10.2 at -O3
seems to generate *utterly* *terrible* code (and the newest clang
release isn't any better); something like this:

kfree_inefficient:
  mov rax, QWORD PTR __kfence_pool[rip]
  cmp rax, rdi
  jbe .L4
.L2:
  jmp kfree_not_kfence
.L4:
  add rax, 0x200000
  cmp rax, rdi
  jbe .L2
  jmp kfree_kfence

So pointers to the left of the region and pointers to the right of the
region will take different branches, and so if you have a mix of
objects on both sides of the kfence region, you'll get tons of branch
mispredictions for no good reason. You'll want to rewrite that check
as "unlikely(ptr - base <= SIZE)" instead of "unlikely(ptr >= base &&
ptr < base + SIZE" unless you know that all the objects will be on one
side. This would also reduce the performance impact of loading
__kfence_pool from the data section, because the branch prediction can
then speculate the branch that depends on the load properly and
doesn't have to go roll back everything that happened when the object
turns out to be on the opposite side of the kfence memory region - the
latency of the load will hopefully become almost irrelevant.



So in x86 intel assembly (assuming that we want to ensure that we only
do a single branch on the object type), the straightforward and
non-terrible version would be:


kfree_unoptimized:
  mov rax, rdi
  sub rax, QWORD PTR __kfence_pool[rip]
  cmp rax, 0x200000
  jbe 1f
  /* non-kfence case goes here */
1:
  /* kfence case goes here */


while the version you want is:


kfree_static:
  mov rax, rdi
  sub rax, OFFSET FLAT:__kfence_pool
  cmp rax, 0x200000
  jbe 1f
  jmp kfree_not_kfence
1:
  jmp kfree_kfence


If we instead use something like

#define STATIC_VARIABLE_LOAD(variable) \
({ \
  typeof(variable) value; \
  BUILD_BUG_ON(sizeof(variable) != sizeof(unsigned long)); \
  asm( \
    ".pushsection .static_variable_users\n\t" \
    ".long "  #variable " - .\n\t" \
    ".long 123f - .\n\t" /* offset to end of constant */ \
    ".popsection\n\t" \
    "movabs $0x0123456789abcdef, %0" \
    "123:\n\t" \
    :"=r"(value) \
  ); \
  value; \
})
static __always_inline bool is_kfence_address(const void *addr)
{
  return unlikely((char*)addr - STATIC_VARIABLE_LOAD(__kfence_pool) <
KFENCE_POOL_SIZE);
}

to locate the pool (which could again be normally allocated with
alloc_pages()), we'd get code like this, which is like the previous
except that we need an extra "movabs" because x86's "sub" can only use
immediates up to 32 bits:

kfree_hotpatchable_bigreloc:
  mov rax, rdi
  movabs rdx, 0x0123456789abcdef
  sub rax, rdx
  cmp rax, 0x200000
  jbe .1f
  jmp kfree_not_kfence
1:
  jmp kfree_kfence

The arch-specific part of this could probably be packaged up pretty
nicely into a generic interface. If it actually turns out to have a
performance benefit, that is.

If that one extra "movabs" is actually a problem, it would
*theoretically* be possible to get rid of that by using module_alloc()
to allocate virtual memory to which offsets from kernel text are 32
bits, and using special-cased inline asm, but we probably shouldn't do
that, because as Mark pointed out, we'd then risk getting extremely
infrequent extra bugs when drivers use phys_to_virt() on allocations
that were done through kfence. Adding new, extremely infrequent and
sporadically occurring bugs to the kernel seems like the exact
opposite of the goal of KFENCE. :P

Overall my expectation would be that the MOVABS version should
probably at worst be something like one cycle slower - it adds 5
instruction bytes (and we pay 1 cycle in the frontend per 16 bytes of
instructions, I think?) and 1 backend cycle (for the MOVABS - Agner
Fog's tables seem to say that at least on Skylake, MOVABS is 1 cycle).
But that backend cycle shouldn't even be on the critical path (and it
has a wider choice of ports than e.g. a load, and I think typical
kernel code isn't exactly highly parallelizable, so we can probably
schedule on a port that would've been free otherwise?), and I think
typical kernel code should be fairly light on the backend, so with the
MOVABS version, compared to the version with __kfence_pool in the data
section, we probably overall just pay a fraction of a cycle in
execution cost? I'm not a professional performance engineer, but this
sounds to me like the MOVABS version should probably perform roughly
as well as your version.

Anyway, I guess this is all pretty vague without actually having
concrete benchmark results. :P

See <https://godbolt.org/z/Kev9dc> for examples of actual code
generation for different options of writing this check.

> The generic framework for this already exists -- you simply create a
> global variable ;)

Yeah, except for all the arch-specific bits you then need to twiddle
with because nobody expects heap memory inside the data section...

> KFENCE needs the range to be covered by struct page's and that's what
> creates problems for arm64. But I would assume most other users don't
> need that.

Things like the big VFS dentry cache and the futex hashtable have
their size chosen at boot time, so they also can't be placed in the
data/bss section.
