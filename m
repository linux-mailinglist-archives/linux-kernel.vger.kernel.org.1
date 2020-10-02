Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6559528190E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbgJBRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388256AbgJBRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:20:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE189C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 10:20:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so2648375wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v/hEFFtQ+0xxAg96E+/6Cxc0JK2K443dm/brFX78osE=;
        b=TB7iBskyHmBs6VotNA/y0rmxjpyyixzVulmFRSi9jNkFzvQsQvYLmp5sC2YQKm9wui
         +XPAfFdvNpMsH4/E9FstzCfr8YbOcduYLgECGC5f0c+UNov+wxIxTQR09q0DQ6JOcyV1
         uLfdBV/W2DJxp/+Dux4LegP/NgmIclf8q4c2G5ACf7Os3fForu5NSexeA4e+0ThJ0IQY
         weQZ+IqJasaybdmRyMWPMsWIUh0e7XeIqmluKScHaWH4ZV2EtByFIV/RZBj0egr/YjB+
         Bl1qgC/Y74zB+1s61J9gIijRlAWyY34FZcbkxnA/qucsFd+0z/H2Y5h1vEcOVmu9Ngp6
         GYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v/hEFFtQ+0xxAg96E+/6Cxc0JK2K443dm/brFX78osE=;
        b=jalT/ElPHzQI+ETGmO+yxpmUvmCuCe4cQjhDj1QzBmpxlGKLb7rFrXzDRJy5cKz8Eq
         vZfPBOCERgd24NOUo7DFarNsrfFlHZ+Do0M7F4ua8KJMDHfej73TVoAog59brHob7SY/
         S0m3bQEEEZUD1+iTdcY6WkxeNpkTC3hyiFn4TI8iLpKgh/+I3+rJ1YgA0mzqyRaSn6D0
         AM6s5DZ6LPGt8EpU+7tytuI5nSpel63hy5rsTMLOTrVS6pUyAu4jTicOb4AcNK1RIpIG
         qfnAwafJECbp4C6c2Vz61yqfCMLQPenE28uYKVIDuy1IbOMEWzk8Xcm5ELzJZyH6GH3u
         zcVw==
X-Gm-Message-State: AOAM531ZRRF+WbG4gRF4d2HNucgveYY0o7NP1U17CZDUUmETimoW0M7N
        3WlDnLLUER3fn+6Pr+5xot4jTA==
X-Google-Smtp-Source: ABdhPJy2KpCV4zJzmIvbaU/OgRKx09JYuQ1w3drJE604tC1XtWA/orZCbgSKhdrYIDooyZ1lMf/KUA==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr4073978wrs.85.1601659206022;
        Fri, 02 Oct 2020 10:20:06 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id f14sm2634897wme.22.2020.10.02.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:20:05 -0700 (PDT)
Date:   Fri, 2 Oct 2020 19:19:59 +0200
From:   Marco Elver <elver@google.com>
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
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20201002171959.GA986344@elver.google.com>
References: <20200929133814.2834621-1-elver@google.com>
 <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

Thanks for your comments!!

On Fri, Oct 02, 2020 at 08:33AM +0200, Jann Horn wrote:
> On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.
> >
> > KFENCE is designed to be enabled in production kernels, and has near
> > zero performance overhead. Compared to KASAN, KFENCE trades performance
> > for precision. The main motivation behind KFENCE's design, is that with
> > enough total uptime KFENCE will detect bugs in code paths not typically
> > exercised by non-production test workloads. One way to quickly achieve a
> > large enough total uptime is when the tool is deployed across a large
> > fleet of machines.
> >
> > KFENCE objects each reside on a dedicated page, at either the left or
> > right page boundaries.
>=20
> (modulo slab alignment)

There are a bunch more details missing; this is just a high-level
summary. Because as soon as we mention "modulo slab alignment" one may
wonder about missed OOBs, which we solve with redzones. We should not
replicate Documentation/dev-tools/kfence.rst; we do refer to it instead.
;-)

> > The pages to the left and right of the object
> > page are "guard pages", whose attributes are changed to a protected
> > state, and cause page faults on any attempted access to them. Such page
> > faults are then intercepted by KFENCE, which handles the fault
> > gracefully by reporting a memory access error. To detect out-of-bounds
> > writes to memory within the object's page itself, KFENCE also uses
> > pattern-based redzones. The following figure illustrates the page
> > layout:
> [...]
> > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> [...]
> > +/**
> > + * is_kfence_address() - check if an address belongs to KFENCE pool
> > + * @addr: address to check
> > + *
> > + * Return: true or false depending on whether the address is within th=
e KFENCE
> > + * object range.
> > + *
> > + * KFENCE objects live in a separate page range and are not to be inte=
rmixed
> > + * with regular heap objects (e.g. KFENCE objects must never be added =
to the
> > + * allocator freelists). Failing to do so may and will result in heap
> > + * corruptions, therefore is_kfence_address() must be used to check wh=
ether
> > + * an object requires specific handling.
> > + */
> > +static __always_inline bool is_kfence_address(const void *addr)
> > +{
> > +       return unlikely((char *)addr >=3D __kfence_pool &&
> > +                       (char *)addr < __kfence_pool + KFENCE_POOL_SIZE=
);
> > +}
>=20
> If !CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL, this should probably always
> return false if __kfence_pool is NULL, right?

That's another check; we don't want to make this more expensive.

This should never receive a NULL, given the places it's used from, which
should only be allocator internals where we already know we have a
non-NULL object. If it did receive a NULL, I think something else is
wrong. Or did we miss a place where it can legally receive a NULL?

> [...]
> > diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> [...]
> > +menuconfig KFENCE
> > +       bool "KFENCE: low-overhead sampling-based memory safety error d=
etector"
> > +       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> > +       depends on JUMP_LABEL # To ensure performance, require jump lab=
els
> > +       select STACKTRACE
> > +       help
> > +         KFENCE is low-overhead sampling-based detector for heap out-o=
f-bounds
>=20
> nit: "is a"

Done.

> > +         access, use-after-free, and invalid-free errors. KFENCE is de=
signed
> > +         to have negligible cost to permit enabling it in production
> > +         environments.
> [...]
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> [...]
> > +module_param_named(sample_interval, kfence_sample_interval, ulong, 060=
0);
>=20
> This is a writable module parameter, but if the sample interval was 0
> or a very large value, changing this value at runtime won't actually
> change the effective interval because the work item will never get
> kicked off again, right?

When KFENCE has been enabled, setting this to 0 actually reschedules the
work immediately; we do not disable KFENCE once it has been enabled.

Conversely, if KFENCE has been disabled at boot (this param is 0),
changing this to anything else will not enable KFENCE.

This simplifies a lot of things, in particular, if KFENCE was disabled
we do not want to run initialization code and also do not want to kick
off KFENCE initialization code were we to allow dynamically turning
KFENCE on/off (it complicates a bunch of things, e.g. the various
arch-specific initialization would need to be able to deal with all
this).

> Should this maybe use module_param_cb() instead, with a "set" callback
> that not only changes the value, but also schedules the work item?

Whether or not we want to reschedule the work if the value was changed
=66rom a huge value to a smaller one is another question. Probably...
we'll consider it.

> [...]
> > +/*
> > + * The pool of pages used for guard pages and objects. If supported, a=
llocated
> > + * statically, so that is_kfence_address() avoids a pointer load, and =
simply
> > + * compares against a constant address. Assume that if KFENCE is compi=
led into
> > + * the kernel, it is usually enabled, and the space is to be allocated=
 one way
> > + * or another.
> > + */
>=20
> If this actually brings a performance win, the proper way to do this
> would probably be to implement this as generic kernel infrastructure
> that makes the compiler emit large-offset relocations (either through
> compiler support or using inline asm statements that move an immediate
> into a register output and register the location in a special section,
> kinda like how e.g. static keys work) and patches them at boot time,
> or something like that - there are other places in the kernel where
> very hot code uses global pointers that are only ever written once
> during boot, e.g. the dentry cache of the VFS and the futex hash
> table. Those are probably far hotter than the kfence code.
>=20
> While I understand that that goes beyond the scope of this project, it
> might be something to work on going forward - this kind of
> special-case logic that turns the kernel data section into heap memory
> would not be needed if we had that kind of infrastructure.
>=20
> > +#ifdef CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL
> > +char __kfence_pool[KFENCE_POOL_SIZE] __kfence_pool_attrs;
> > +#else
> > +char *__kfence_pool __read_mostly;
>=20
> not __ro_after_init ?

Changed, thanks.

> > +#endif
> [...]
> > +/* Freelist with available objects. */
> > +static struct list_head kfence_freelist =3D LIST_HEAD_INIT(kfence_free=
list);
> > +static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting f=
reelist. */
> [...]
> > +/* Gates the allocation, ensuring only one succeeds in a given period.=
 */
> > +static atomic_t allocation_gate =3D ATOMIC_INIT(1);
>=20
> I don't think you need to initialize this to anything?
> toggle_allocation_gate() will set it to zero before enabling the
> static key, so I don't think anyone will ever see this value.

Sure. But does it hurt anyone? At least this way we don't need to think
about yet another state that only exists on initialization; who knows
what we'll change in future.

> [...]
> > +/* Check canary byte at @addr. */
> > +static inline bool check_canary_byte(u8 *addr)
> > +{
> > +       if (*addr =3D=3D KFENCE_CANARY_PATTERN(addr))
>=20
> You could maybe add a likely() hint here if you want.

Added; but none of this is in a hot path.

> > +               return true;
> > +
> > +       atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> > +       kfence_report_error((unsigned long)addr, addr_to_metadata((unsi=
gned long)addr),
> > +                           KFENCE_ERROR_CORRUPTION);
> > +       return false;
> > +}
> > +
> > +static inline void for_each_canary(const struct kfence_metadata *meta,=
 bool (*fn)(u8 *))
>=20
> Given how horrendously slow this would be if the compiler decided to
> disregard the "inline" hint and did an indirect call for every byte,
> you may want to use __always_inline here.

Done.

> > +{
> > +       unsigned long addr;
> > +
> > +       lockdep_assert_held(&meta->lock);
> > +
> > +       for (addr =3D ALIGN_DOWN(meta->addr, PAGE_SIZE); addr < meta->a=
ddr; addr++) {
> > +               if (!fn((u8 *)addr))
> > +                       break;
> > +       }
> > +
> > +       for (addr =3D meta->addr + meta->size; addr < PAGE_ALIGN(meta->=
addr); addr++) {
>=20
> Hmm... if the object is on the left side (meaning meta->addr is
> page-aligned) and the padding is on the right side, won't
> PAGE_ALIGN(meta->addr)=3D=3Dmeta->addr , and therefore none of the padding
> will be checked?

No, you're thinking of ALIGN_DOWN. PAGE_ALIGN gives us the next page.

> > +               if (!fn((u8 *)addr))
> > +                       break;
> > +       }
> > +}
> > +
> > +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t siz=
e, gfp_t gfp)
> > +{
> > +       struct kfence_metadata *meta =3D NULL;
> > +       unsigned long flags;
> > +       void *addr;
> > +
> > +       /* Try to obtain a free object. */
> > +       raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> > +       if (!list_empty(&kfence_freelist)) {
> > +               meta =3D list_entry(kfence_freelist.next, struct kfence=
_metadata, list);
> > +               list_del_init(&meta->list);
> > +       }
> > +       raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> > +       if (!meta)
> > +               return NULL;
>=20
> Should this use pr_warn_once(), or something like that, to inform the
> user that kfence might be stuck with all allocations used by
> long-living objects and therefore no longer doing anything?

I don't think so; it might as well recover, and seeing this message once
is no indication that we're stuck. Instead, we should (and plan to)
monitor /sys/kernel/debug/kfence/stats.

> [...]
> > +}
> [...]
> > +/* =3D=3D=3D Allocation Gate Timer =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +
> > +/*
> > + * Set up delayed work, which will enable and disable the static key. =
We need to
> > + * use a work queue (rather than a simple timer), since enabling and d=
isabling a
> > + * static key cannot be done from an interrupt.
> > + */
> > +static struct delayed_work kfence_timer;
> > +static void toggle_allocation_gate(struct work_struct *work)
> > +{
> > +       if (!READ_ONCE(kfence_enabled))
> > +               return;
> > +
> > +       /* Enable static key, and await allocation to happen. */
> > +       atomic_set(&allocation_gate, 0);
> > +       static_branch_enable(&kfence_allocation_key);
> > +       wait_event(allocation_wait, atomic_read(&allocation_gate) !=3D =
0);
> > +
> > +       /* Disable static key and reset timer. */
> > +       static_branch_disable(&kfence_allocation_key);
> > +       schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sa=
mple_interval));
>=20
> We end up doing two IPIs to all CPU cores for each kfence allocation
> because of those static branch calls, right? Might be worth adding a
> comment to point that out, or something like that. (And if it ends up
> being a problem in the future, we could probably get away with using
> some variant that avoids the IPI, but flushes the instruction pipeline
> if we observe the allocation_gate being nonzero, or something like
> that. At the cost of not immediately capturing new allocations if the
> relevant instructions are cached. But the current version is
> definitely fine for an initial implementation, and for now, you should
> probably *not* implement what I just described.)

Thanks, yeah, this is a good point, and I wondered if we could optimize
this along these lines. We'll add a comment. Maybe somebody wants to
optimize this in future. :-)

> > +}
> > +static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
> > +
> > +/* =3D=3D=3D Public interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +
> > +void __init kfence_init(void)
> > +{
> > +       /* Setting kfence_sample_interval to 0 on boot disables KFENCE.=
 */
> > +       if (!kfence_sample_interval)
> > +               return;
> > +
> > +       if (!kfence_initialize_pool()) {
> > +               pr_err("%s failed\n", __func__);
> > +               return;
> > +       }
> > +
> > +       WRITE_ONCE(kfence_enabled, true);
> > +       schedule_delayed_work(&kfence_timer, 0);
>=20
> This is schedule_work(&kfence_timer).

No, schedule_work() is not generic and does not take a struct delayed_work.

> [...]
> > +}
> [...]
> > diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> [...]
> > +/* KFENCE metadata per guarded allocation. */
> > +struct kfence_metadata {
> [...]
> > +       /*
> > +        * In case of an invalid access, the page that was unprotected;=
 we
> > +        * optimistically only store address.
>=20
> Is this supposed to say something like "only store one address"?

Done.

> > +        */
> > +       unsigned long unprotected_page;
> > +};
> [...]
> > +#endif /* MM_KFENCE_KFENCE_H */
> > diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> [...]
> > +void kfence_report_error(unsigned long address, const struct kfence_me=
tadata *meta,
> > +                        enum kfence_error_type type)
> > +{
> [...]
> > +       pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > +       /* Print report header. */
> > +       switch (type) {
> [...]
> > +       case KFENCE_ERROR_INVALID_FREE:
> > +               pr_err("BUG: KFENCE: invalid free in %pS\n\n", (void *)=
stack_entries[skipnr]);
> > +               pr_err("Invalid free of 0x" PTR_FMT " (in kfence-#%zd):=
\n", (void *)address,
> > +                      object_index);
> > +               break;
> > +       }
> > +
> > +       /* Print stack trace and object info. */
> > +       stack_trace_print(stack_entries + skipnr, num_stack_entries - s=
kipnr, 0);
> > +
> > +       if (meta) {
> > +               pr_err("\n");
> > +               kfence_print_object(NULL, meta);
> > +       }
> > +
> > +       /* Print report footer. */
> > +       pr_err("\n");
> > +       dump_stack_print_info(KERN_DEFAULT);
>=20
> Shouldn't this be KERN_ERR, to keep the loglevel consistent with the
> previous messages?

Done.

Thanks,
-- Marco
