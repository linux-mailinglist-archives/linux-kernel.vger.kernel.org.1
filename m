Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F73281C10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgJBTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:32:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9DC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:32:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 33so2845661edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Zinz0oexRJUeJTiDko3PiAzAmypZjIdFBb1syJchnI=;
        b=uJ8KWfv+25/FG+XhuLL9aqspmzS4/2ksgNCGHjHxaCBoLjfA3voTF8dNND7znhAFte
         RND86at63+caTXf5/qxlcjXjX3Hd4SIGO6hm6YeZqjcQTrTIGMcsctoeaWTDAeObT4BW
         vsX813XHucyeRuTg1yLA3x5VbQcnEcxnXh2Gux+cgAx72FVAuSVhveS7iV+k88KwOMeS
         6Jyxt31yUeyD+zkGYrtMxoNbSVYUI4ne7d6F+9fwtBrMOSM5mDi/r9yzVpfxx1n88hAP
         wpQREvV9i9w9Pe8NcpO1syisshnCznq0JQgT200RzpizBDyN/PbeCXH0NEzYKqVx7eG9
         ZdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Zinz0oexRJUeJTiDko3PiAzAmypZjIdFBb1syJchnI=;
        b=W2Q1jxRSkhMSBXYahfDxsczuoOQb7GeNlA5GofZOC++XXNdCE6BNA3veruhNjrhrct
         Z8Bm2XdeL8enoGO1By2SJp2OfU9LcRmNmEZ7bntQYgo5grqNpQ55JsJVxzzHjs4U07yA
         87gFTzIdeSYaWVg5XfeKtbPVoXa6slJf2II/C2+YCdKESe9xzNEhyGsVTYR46B9R7P9v
         +1INcSqAcgUuZWB8eDplG1rEELIzMiDhOe95r/3mimqQ3P8NRK/tIqyopt70r4gB5rgS
         E2+zP25uPpWU+ZN8SGyaAB3MwjRwtFSp48swG/OKpM1QBcksD40EHcKt5PEqaT1KDAyh
         Dcug==
X-Gm-Message-State: AOAM533LeavJNti6iS0m4CrgWhEFBO7Ct82gejo3v8+keIqWsQyEDnuc
        DRobMyafDnj23eXfH+13A/GZcps3CFok2rwd3vBwQw==
X-Google-Smtp-Source: ABdhPJxOFlam9et89MlcMDXUZq1630DXkjSr6DyRad2cG5j+S7fc2Qz/Ps2GYaEohMCpwCOwMOSzFBsJF/tj+KJCJ90=
X-Received: by 2002:a50:e807:: with SMTP id e7mr4232314edn.84.1601667133289;
 Fri, 02 Oct 2020 12:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com> <20201002171959.GA986344@elver.google.com>
In-Reply-To: <20201002171959.GA986344@elver.google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 21:31:46 +0200
Message-ID: <CAG48ez0D1+hStZaDOigwbqNqFHJAJtXK+8Nadeuiu1Byv+xp5A@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
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

On Fri, Oct 2, 2020 at 7:20 PM Marco Elver <elver@google.com> wrote:
> On Fri, Oct 02, 2020 at 08:33AM +0200, Jann Horn wrote:
> > On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > > low-overhead sampling-based memory safety error detector of heap
> > > use-after-free, invalid-free, and out-of-bounds access errors.
> > >
> > > KFENCE is designed to be enabled in production kernels, and has near
> > > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > > for precision. The main motivation behind KFENCE's design, is that with
> > > enough total uptime KFENCE will detect bugs in code paths not typically
> > > exercised by non-production test workloads. One way to quickly achieve a
> > > large enough total uptime is when the tool is deployed across a large
> > > fleet of machines.
> > >
> > > KFENCE objects each reside on a dedicated page, at either the left or
> > > right page boundaries.
> >
> > (modulo slab alignment)
>
> There are a bunch more details missing; this is just a high-level
> summary. Because as soon as we mention "modulo slab alignment" one may
> wonder about missed OOBs, which we solve with redzones. We should not
> replicate Documentation/dev-tools/kfence.rst; we do refer to it instead.
> ;-)

Heh, fair.

> > > The pages to the left and right of the object
> > > page are "guard pages", whose attributes are changed to a protected
> > > state, and cause page faults on any attempted access to them. Such page
> > > faults are then intercepted by KFENCE, which handles the fault
> > > gracefully by reporting a memory access error. To detect out-of-bounds
> > > writes to memory within the object's page itself, KFENCE also uses
> > > pattern-based redzones. The following figure illustrates the page
> > > layout:
> > [...]
> > > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> > [...]
> > > +/**
> > > + * is_kfence_address() - check if an address belongs to KFENCE pool
> > > + * @addr: address to check
> > > + *
> > > + * Return: true or false depending on whether the address is within the KFENCE
> > > + * object range.
> > > + *
> > > + * KFENCE objects live in a separate page range and are not to be intermixed
> > > + * with regular heap objects (e.g. KFENCE objects must never be added to the
> > > + * allocator freelists). Failing to do so may and will result in heap
> > > + * corruptions, therefore is_kfence_address() must be used to check whether
> > > + * an object requires specific handling.
> > > + */
> > > +static __always_inline bool is_kfence_address(const void *addr)
> > > +{
> > > +       return unlikely((char *)addr >= __kfence_pool &&
> > > +                       (char *)addr < __kfence_pool + KFENCE_POOL_SIZE);
> > > +}
> >
> > If !CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL, this should probably always
> > return false if __kfence_pool is NULL, right?
>
> That's another check; we don't want to make this more expensive.

Ah, right, I missed that this is the one piece of KFENCE that is
actually really hot code until Dmitry pointed that out.

But actually, can't you reduce how hot this is for SLUB by moving
is_kfence_address() down into the freeing slowpath? At the moment you
use it in slab_free_freelist_hook(), which is in the super-hot
fastpath, but you should be able to at least move it down into
__slab_free()...

Actually, you already have hooked into __slab_free(), so can't you
just get rid of the check in the slab_free_freelist_hook()?

Also, you could do the NULL *after* the range check said "true". That
way the NULL check would be on the slowpath and have basically no
performance impact.

> This should never receive a NULL, given the places it's used from, which
> should only be allocator internals where we already know we have a
> non-NULL object. If it did receive a NULL, I think something else is
> wrong. Or did we miss a place where it can legally receive a NULL?

Well... not exactly "legally", but e.g. a kernel NULL deref (landing
in kfence_handle_page_fault()) might get weird.

[...]
> > > +         access, use-after-free, and invalid-free errors. KFENCE is designed
> > > +         to have negligible cost to permit enabling it in production
> > > +         environments.
> > [...]
> > > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > [...]
> > > +module_param_named(sample_interval, kfence_sample_interval, ulong, 0600);
> >
> > This is a writable module parameter, but if the sample interval was 0
> > or a very large value, changing this value at runtime won't actually
> > change the effective interval because the work item will never get
> > kicked off again, right?
>
> When KFENCE has been enabled, setting this to 0 actually reschedules the
> work immediately; we do not disable KFENCE once it has been enabled.

Those are weird semantics. One value should IMO unambiguously mean one
thing, independent of when it was set. In particular, I think that if
someone decides to read the current value of kfence_sample_interval
through sysfs, and sees the value "0", that should not ambiguously
mean "either kfence triggers all the time or it is completely off".

If you don't want to support runtime disabling, can you maybe make the
handler refuse to write 0 if kfence has already been initialized?

[...]
> > > +#endif
> > [...]
> > > +/* Freelist with available objects. */
> > > +static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
> > > +static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelist. */
> > [...]
> > > +/* Gates the allocation, ensuring only one succeeds in a given period. */
> > > +static atomic_t allocation_gate = ATOMIC_INIT(1);
> >
> > I don't think you need to initialize this to anything?
> > toggle_allocation_gate() will set it to zero before enabling the
> > static key, so I don't think anyone will ever see this value.
>
> Sure. But does it hurt anyone? At least this way we don't need to think
> about yet another state that only exists on initialization; who knows
> what we'll change in future.

Well, no, it doesn't hurt. But I see this as equivalent to writing code like:

int ret = 0;
ret = -EINVAL;
if (...)
  return ret;

where a write can never have any effect because a second write will
clobber the value before it can be read, which is IMO an antipattern.
But it admittedly is less clear here, so if you like it better your
way, I don't really have a problem with that.

> > [...]
> > > +/* Check canary byte at @addr. */
> > > +static inline bool check_canary_byte(u8 *addr)
> > > +{
> > > +       if (*addr == KFENCE_CANARY_PATTERN(addr))
> >
> > You could maybe add a likely() hint here if you want.
>
> Added; but none of this is in a hot path.

Yeah, but when we do hit the kfence alloc/free paths, we should
probably still try to be reasonably fast to reduce jitter?

[...]
> > > +{
> > > +       unsigned long addr;
> > > +
> > > +       lockdep_assert_held(&meta->lock);
> > > +
> > > +       for (addr = ALIGN_DOWN(meta->addr, PAGE_SIZE); addr < meta->addr; addr++) {
> > > +               if (!fn((u8 *)addr))
> > > +                       break;
> > > +       }
> > > +
> > > +       for (addr = meta->addr + meta->size; addr < PAGE_ALIGN(meta->addr); addr++) {
> >
> > Hmm... if the object is on the left side (meaning meta->addr is
> > page-aligned) and the padding is on the right side, won't
> > PAGE_ALIGN(meta->addr)==meta->addr , and therefore none of the padding
> > will be checked?
>
> No, you're thinking of ALIGN_DOWN. PAGE_ALIGN gives us the next page.

Hm, really? Let me go through those macros...


#define __AC(X,Y) (X##Y)
#define _AC(X,Y) __AC(X,Y)
#define PAGE_SHIFT 12
#define PAGE_SIZE (_AC(1,UL) << PAGE_SHIFT)

so:
PAGE_SIZE == (1UL << 12) == 0x1000UL

#define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
#define __ALIGN_KERNEL(x, a) __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
#define ALIGN(x, a) __ALIGN_KERNEL((x), (a))

so (omitting casts):
ALIGN(x, a) == ((x + (a - 1)) & ~(a - 1))

#define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)

so (omitting casts):
PAGE_ALIGN(addr) == ((addr + (0x1000UL - 1)) & ~(0x1000UL - 1))
  == ((addr + 0xfffUL) & 0xfffffffffffff000UL)

meaning that if we e.g. pass in 0x5000, we get:

PAGE_ALIGN(0x5000) == ((0x5000 + 0xfffUL) & 0xfffffffffffff000UL)
 == 0x5fffUL & 0xfffffffffffff000UL == 0x5000UL

So if the object is on the left side (meaning meta->addr is
page-aligned), we won't check padding.


ALIGN_DOWN rounds down, while PAGE_ALIGN rounds up, but both leave the
value as-is if it is already page-aligned.


> > > +               if (!fn((u8 *)addr))
> > > +                       break;
> > > +       }
> > > +}
> > > +
> > > +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> > > +{
> > > +       struct kfence_metadata *meta = NULL;
> > > +       unsigned long flags;
> > > +       void *addr;
> > > +
> > > +       /* Try to obtain a free object. */
> > > +       raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> > > +       if (!list_empty(&kfence_freelist)) {
> > > +               meta = list_entry(kfence_freelist.next, struct kfence_metadata, list);
> > > +               list_del_init(&meta->list);
> > > +       }
> > > +       raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> > > +       if (!meta)
> > > +               return NULL;
> >
> > Should this use pr_warn_once(), or something like that, to inform the
> > user that kfence might be stuck with all allocations used by
> > long-living objects and therefore no longer doing anything?
>
> I don't think so; it might as well recover, and seeing this message once
> is no indication that we're stuck. Instead, we should (and plan to)
> monitor /sys/kernel/debug/kfence/stats.

Ah, I guess that's reasonable.

[...]
> > > +}
> > > +static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
> > > +
> > > +/* === Public interface ===================================================== */
> > > +
> > > +void __init kfence_init(void)
> > > +{
> > > +       /* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
> > > +       if (!kfence_sample_interval)
> > > +               return;
> > > +
> > > +       if (!kfence_initialize_pool()) {
> > > +               pr_err("%s failed\n", __func__);
> > > +               return;
> > > +       }
> > > +
> > > +       WRITE_ONCE(kfence_enabled, true);
> > > +       schedule_delayed_work(&kfence_timer, 0);
> >
> > This is schedule_work(&kfence_timer).
>
> No, schedule_work() is not generic and does not take a struct delayed_work.

Ah, of course. Never mind.
