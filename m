Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85AB28060E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbgJAR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:58:03 -0400
Received: from foss.arm.com ([217.140.110.172]:41792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732842AbgJAR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:58:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BE31042;
        Thu,  1 Oct 2020 10:58:01 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604693F6CF;
        Thu,  1 Oct 2020 10:57:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 18:57:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20201001175716.GA89689@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local>
 <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 01:24:49PM +0200, Alexander Potapenko wrote:
> Mark,
> 
> > If you need virt_to_page() to work, the address has to be part of the
> > linear/direct map.
> >
> > If you need to find the struct page for something that's part of the
> > kernel image you can use virt_to_page(lm_alias(x)).
> >
> > > Looks like filling page table entries (similarly to what's being done
> > > in arch/arm64/mm/kasan_init.c) is not enough.
> > > I thought maybe vmemmap_populate() would do the job, but it didn't
> > > (virt_to_pfn() still returns invalid PFNs).
> >
> > As above, I think lm_alias() will solve the problem here. Please see
> > that and CONFIG_DEBUG_VIRTUAL.
> 
> The approach you suggest works to some extent, but there are some caveats.
> 
> To reiterate, we are trying to allocate the pool (2Mb by default, but
> users may want a bigger one, up to, say, 64 Mb) in a way that:
> (1) The underlying page tables support 4K granularity.
> (2) is_kfence_address() (checks that __kfence_pool <= addr <=
> __kfence_pool + KFENCE_POOL_SIZE) does not reference memory

What's the underlying requirement here? Is this a performance concern,
codegen/codesize, or something else?

> (3) For addresses belonging to that pool virt_addr_valid() is true
> (SLAB/SLUB rely on that)

As I hinted at before, there's a reasonable amount of code which relies
on being able to round-trip convert (va->{pa,page}->va) allocations from
SLUB, e.g. phys = virt_to_page(addr); ... ; phys = page_to_virt(phys).
Usually this is because the phys addr is stored in some HW register, or
in-memory structure shared with HW.

I'm fairly certain KFENCE will need to support this in order to be
deployable in production, and arm64 is the canary in the coalmine.

I added tests for this back when tag-based KASAN broke this property.
See commit:

  b92a953cb7f727c4 ("lib/test_kasan.c: add roundtrip tests")

... for which IIUC the kfree_via_phys() test would be broken by KFENCE,
even on x86:

| static noinline void __init kfree_via_phys(void)
| {
|        char *ptr;
|        size_t size = 8;
|        phys_addr_t phys;
| 
|        pr_info("invalid-free false positive (via phys)\n");
|        ptr = kmalloc(size, GFP_KERNEL);
|        if (!ptr) {
|                pr_err("Allocation failed\n");
|                return;
|        }
| 
|        phys = virt_to_phys(ptr);
|        kfree(phys_to_virt(phys));
| }

... since the code will pass the linear map alias of the KFENCE VA into
kfree().

To avoid random breakage we either need to:

* Have KFENCE retain this property (which effectively requires
  allocation VAs to fall within the linear/direct map)

* Decide that round-trips are forbidden, and go modify that code
  somehow, which was deemed to be impractical in the past

... and I would strongly prefer the former as it's less liable to break any
existing code.

> On x86 we achieve (2) by making our pool a .bss array, so that its
> address is known statically. Aligning that array on 4K and calling
> set_memory_4k() ensures that (1) is also fulfilled. (3) seems to just
> happen automagically without any address translations.
> 
> Now, what we are seeing on arm64 is different.
> My understanding (please correct me if I'm wrong) is that on arm64
> only the memory range at 0xffff000000000000 has valid struct pages,
> and the size of that range depends on the amount of memory on the
> system.

The way virt_to_page() works is based on there being a constant (at
runtime) offset between a linear map address and the corresponding
physical page. That makes it easy to get the PA with a subtraction, then
the PFN with a shift, then to index the vmemmap array with that to get
the page. The x86 version of virt_to_page() automatically fixes up an
image address to its linear map alias internally.

> This probably means we cannot just pick a fixed address for our pool
> in that range, unless it is very close to 0xffff000000000000.

It would have to be part of the linear map, or we'd have to apply the
same fixup as x86 does. But as above, I'm reluctant to do that as it
only encourages writing fragile code. The only sensible way to detect
that is to disallow virt_to_*() on image addresses, since that's the
only time we can distinguish the source.

> If we allocate the pool statically in the way x86 does (assuming we
> somehow resolve (1)), we can apply lm_alias() to addresses returned by
> the KFENCE allocator, making kmalloc() always return addresses from
> the linear map and satisfying (3).
> But in that case is_kfence_address() will also need to be updated to
> compare the addresses to lm_alias(__kfence_pool), and this becomes
> more heavyweight than just reading the address from memory.

We can calculate the lm_alias(__kfence_pool) at boot time, so it's only
a read from memory in the fast-path.

> So looks like it's still more preferable to allocate the pool
> dynamically on ARM64, unless there's a clever trick to allocate a
> fixed address in the linear map (DTS maybe?)

I'm not too worried about allocating this dynamically, but:

* The arch code needs to set up the translation tables for this, as we
  cannot safely change the mapping granularity live.

* As above I'm fairly certain x86 needs to use a carevout from the
  linear map to function correctly anyhow, so we should follow the same
  approach for both arm64 and x86. That might be a static carevout that
  we figure out the aliasing for, or something entirely dynamic.

Thanks,
Mark.
