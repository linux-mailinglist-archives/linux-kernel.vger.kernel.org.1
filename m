Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE393280D83
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJBGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBGeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:34:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBEBC0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 23:34:01 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g3so517431edu.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BDuU6sXeGKigaXtfOae0G/hnHiDrPaHNVHyy0KSsRs=;
        b=W4cmDp1w8qq1vIMaUhMz2mwvLMqpRNdnmF2tvhmQ7e84k0P1taIbBaQPsEN4hsD19B
         AU8vm1qH3umKPPVA1MK0T3ADzWgYUqgySANCLJxywkpsmHVnEUDJe9JFXQhrV0lVmFaS
         ft6xD9OtkPraoEGzzQ53j7WyrYdgUNntq01yL6DjMzXjEdklRkXL/FLawBK99mEFbj+g
         GplVRL8a6kqe07BPFifJCrq5l/fQ0SIn854ODUGxgRM/f38pthOVxuuSDu+vm+VBWVBe
         u3cbGJEfU96ZJdGjKZYEniSiiYwSWY4RixT6yXE4eY8dfDbB3Ug0pgJkE1aKjt7HRYsY
         1zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BDuU6sXeGKigaXtfOae0G/hnHiDrPaHNVHyy0KSsRs=;
        b=e0PyqVONzKq9n5R3dhITEJC/SBKSMb6yX/tHmjgnmzvpBfXBhpzXEo9WkfTP8pD4TV
         Hohdcm3Sp83KhmlNVQPJGLLFzdxtz8jkk2hheayIOf/30vuXecK1GlgbMoAoGHOrOAT+
         1xdE8jlVbplcEj6nlJFuUrWIp29DCiFYnOWwa3G7IxSlgQqE1z7UCUfhX+UR8fdcLVQf
         LTHxE+7fZTuyrZ5W+apX97yT/5pL1v/KMzyQIUglFOZBcYnRqX5SnKGyh6BKllgwRw8w
         vOM28Z24pRXL2JePabFZe0qKTIms+toqEPwb4cnSPuTW2776VprfhibQsLb6rvWPk9OB
         b/og==
X-Gm-Message-State: AOAM531hJ+ad7v9vKaypV3v7FxN+ofA65nUiulQKLiLBm5mub2zfRHeW
        bCR5+Z77cV/I8wz01X9MI25GUWdxA7Ya2ATiAAPTbA==
X-Google-Smtp-Source: ABdhPJxtkAz6DvXzPFoMwIAy2afWvGz2ppCrq5JnQILdfrhyMgT/pz2do+1qL5Nusj/THBOyPpWZ7q+rAkkmJvahHWo=
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr758061edb.230.1601620439936;
 Thu, 01 Oct 2020 23:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
In-Reply-To: <20200929133814.2834621-2-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Oct 2020 08:33:33 +0200
Message-ID: <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 3:38 PM Marco Elver <elver@google.com> wrote:
> This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> low-overhead sampling-based memory safety error detector of heap
> use-after-free, invalid-free, and out-of-bounds access errors.
>
> KFENCE is designed to be enabled in production kernels, and has near
> zero performance overhead. Compared to KASAN, KFENCE trades performance
> for precision. The main motivation behind KFENCE's design, is that with
> enough total uptime KFENCE will detect bugs in code paths not typically
> exercised by non-production test workloads. One way to quickly achieve a
> large enough total uptime is when the tool is deployed across a large
> fleet of machines.
>
> KFENCE objects each reside on a dedicated page, at either the left or
> right page boundaries.

(modulo slab alignment)

> The pages to the left and right of the object
> page are "guard pages", whose attributes are changed to a protected
> state, and cause page faults on any attempted access to them. Such page
> faults are then intercepted by KFENCE, which handles the fault
> gracefully by reporting a memory access error. To detect out-of-bounds
> writes to memory within the object's page itself, KFENCE also uses
> pattern-based redzones. The following figure illustrates the page
> layout:
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
> +static __always_inline bool is_kfence_address(const void *addr)
> +{
> +       return unlikely((char *)addr >= __kfence_pool &&
> +                       (char *)addr < __kfence_pool + KFENCE_POOL_SIZE);
> +}

If !CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL, this should probably always
return false if __kfence_pool is NULL, right?

[...]
> diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
[...]
> +menuconfig KFENCE
> +       bool "KFENCE: low-overhead sampling-based memory safety error detector"
> +       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> +       depends on JUMP_LABEL # To ensure performance, require jump labels
> +       select STACKTRACE
> +       help
> +         KFENCE is low-overhead sampling-based detector for heap out-of-bounds

nit: "is a"

> +         access, use-after-free, and invalid-free errors. KFENCE is designed
> +         to have negligible cost to permit enabling it in production
> +         environments.
[...]
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
[...]
> +module_param_named(sample_interval, kfence_sample_interval, ulong, 0600);

This is a writable module parameter, but if the sample interval was 0
or a very large value, changing this value at runtime won't actually
change the effective interval because the work item will never get
kicked off again, right?

Should this maybe use module_param_cb() instead, with a "set" callback
that not only changes the value, but also schedules the work item?

[...]
> +/*
> + * The pool of pages used for guard pages and objects. If supported, allocated
> + * statically, so that is_kfence_address() avoids a pointer load, and simply
> + * compares against a constant address. Assume that if KFENCE is compiled into
> + * the kernel, it is usually enabled, and the space is to be allocated one way
> + * or another.
> + */

If this actually brings a performance win, the proper way to do this
would probably be to implement this as generic kernel infrastructure
that makes the compiler emit large-offset relocations (either through
compiler support or using inline asm statements that move an immediate
into a register output and register the location in a special section,
kinda like how e.g. static keys work) and patches them at boot time,
or something like that - there are other places in the kernel where
very hot code uses global pointers that are only ever written once
during boot, e.g. the dentry cache of the VFS and the futex hash
table. Those are probably far hotter than the kfence code.

While I understand that that goes beyond the scope of this project, it
might be something to work on going forward - this kind of
special-case logic that turns the kernel data section into heap memory
would not be needed if we had that kind of infrastructure.

> +#ifdef CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL
> +char __kfence_pool[KFENCE_POOL_SIZE] __kfence_pool_attrs;
> +#else
> +char *__kfence_pool __read_mostly;

not __ro_after_init ?

> +#endif
[...]
> +/* Freelist with available objects. */
> +static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
> +static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelist. */
[...]
> +/* Gates the allocation, ensuring only one succeeds in a given period. */
> +static atomic_t allocation_gate = ATOMIC_INIT(1);

I don't think you need to initialize this to anything?
toggle_allocation_gate() will set it to zero before enabling the
static key, so I don't think anyone will ever see this value.

[...]
> +/* Check canary byte at @addr. */
> +static inline bool check_canary_byte(u8 *addr)
> +{
> +       if (*addr == KFENCE_CANARY_PATTERN(addr))

You could maybe add a likely() hint here if you want.

> +               return true;
> +
> +       atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> +       kfence_report_error((unsigned long)addr, addr_to_metadata((unsigned long)addr),
> +                           KFENCE_ERROR_CORRUPTION);
> +       return false;
> +}
> +
> +static inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))

Given how horrendously slow this would be if the compiler decided to
disregard the "inline" hint and did an indirect call for every byte,
you may want to use __always_inline here.

> +{
> +       unsigned long addr;
> +
> +       lockdep_assert_held(&meta->lock);
> +
> +       for (addr = ALIGN_DOWN(meta->addr, PAGE_SIZE); addr < meta->addr; addr++) {
> +               if (!fn((u8 *)addr))
> +                       break;
> +       }
> +
> +       for (addr = meta->addr + meta->size; addr < PAGE_ALIGN(meta->addr); addr++) {

Hmm... if the object is on the left side (meaning meta->addr is
page-aligned) and the padding is on the right side, won't
PAGE_ALIGN(meta->addr)==meta->addr , and therefore none of the padding
will be checked?

> +               if (!fn((u8 *)addr))
> +                       break;
> +       }
> +}
> +
> +static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp)
> +{
> +       struct kfence_metadata *meta = NULL;
> +       unsigned long flags;
> +       void *addr;
> +
> +       /* Try to obtain a free object. */
> +       raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> +       if (!list_empty(&kfence_freelist)) {
> +               meta = list_entry(kfence_freelist.next, struct kfence_metadata, list);
> +               list_del_init(&meta->list);
> +       }
> +       raw_spin_unlock_irqrestore(&kfence_freelist_lock, flags);
> +       if (!meta)
> +               return NULL;

Should this use pr_warn_once(), or something like that, to inform the
user that kfence might be stuck with all allocations used by
long-living objects and therefore no longer doing anything?

[...]
> +}
[...]
> +/* === Allocation Gate Timer ================================================ */
> +
> +/*
> + * Set up delayed work, which will enable and disable the static key. We need to
> + * use a work queue (rather than a simple timer), since enabling and disabling a
> + * static key cannot be done from an interrupt.
> + */
> +static struct delayed_work kfence_timer;
> +static void toggle_allocation_gate(struct work_struct *work)
> +{
> +       if (!READ_ONCE(kfence_enabled))
> +               return;
> +
> +       /* Enable static key, and await allocation to happen. */
> +       atomic_set(&allocation_gate, 0);
> +       static_branch_enable(&kfence_allocation_key);
> +       wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
> +
> +       /* Disable static key and reset timer. */
> +       static_branch_disable(&kfence_allocation_key);
> +       schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sample_interval));

We end up doing two IPIs to all CPU cores for each kfence allocation
because of those static branch calls, right? Might be worth adding a
comment to point that out, or something like that. (And if it ends up
being a problem in the future, we could probably get away with using
some variant that avoids the IPI, but flushes the instruction pipeline
if we observe the allocation_gate being nonzero, or something like
that. At the cost of not immediately capturing new allocations if the
relevant instructions are cached. But the current version is
definitely fine for an initial implementation, and for now, you should
probably *not* implement what I just described.)

> +}
> +static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
> +
> +/* === Public interface ===================================================== */
> +
> +void __init kfence_init(void)
> +{
> +       /* Setting kfence_sample_interval to 0 on boot disables KFENCE. */
> +       if (!kfence_sample_interval)
> +               return;
> +
> +       if (!kfence_initialize_pool()) {
> +               pr_err("%s failed\n", __func__);
> +               return;
> +       }
> +
> +       WRITE_ONCE(kfence_enabled, true);
> +       schedule_delayed_work(&kfence_timer, 0);

This is schedule_work(&kfence_timer).

[...]
> +}
[...]
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
[...]
> +/* KFENCE metadata per guarded allocation. */
> +struct kfence_metadata {
[...]
> +       /*
> +        * In case of an invalid access, the page that was unprotected; we
> +        * optimistically only store address.

Is this supposed to say something like "only store one address"?

> +        */
> +       unsigned long unprotected_page;
> +};
[...]
> +#endif /* MM_KFENCE_KFENCE_H */
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
[...]
> +void kfence_report_error(unsigned long address, const struct kfence_metadata *meta,
> +                        enum kfence_error_type type)
> +{
[...]
> +       pr_err("==================================================================\n");
> +       /* Print report header. */
> +       switch (type) {
[...]
> +       case KFENCE_ERROR_INVALID_FREE:
> +               pr_err("BUG: KFENCE: invalid free in %pS\n\n", (void *)stack_entries[skipnr]);
> +               pr_err("Invalid free of 0x" PTR_FMT " (in kfence-#%zd):\n", (void *)address,
> +                      object_index);
> +               break;
> +       }
> +
> +       /* Print stack trace and object info. */
> +       stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr, 0);
> +
> +       if (meta) {
> +               pr_err("\n");
> +               kfence_print_object(NULL, meta);
> +       }
> +
> +       /* Print report footer. */
> +       pr_err("\n");
> +       dump_stack_print_info(KERN_DEFAULT);

Shouldn't this be KERN_ERR, to keep the loglevel consistent with the
previous messages?
