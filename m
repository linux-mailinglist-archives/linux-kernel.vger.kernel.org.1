Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E12872B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgJHKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:45:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgJHKpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:45:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21CCBD6E;
        Thu,  8 Oct 2020 03:45:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.52.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBF83F70D;
        Thu,  8 Oct 2020 03:45:03 -0700 (PDT)
Date:   Thu, 8 Oct 2020 11:45:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20201008104501.GB72325@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck>
 <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local>
 <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
 <20201001175716.GA89689@C02TD0UTHF1T.local>
 <CANpmjNMFrMZybOebFwJ1GRXpt8v39AN016UDgPZzE8J3zKh9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMFrMZybOebFwJ1GRXpt8v39AN016UDgPZzE8J3zKh9RA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:40:52AM +0200, Marco Elver wrote:
> On Thu, 1 Oct 2020 at 19:58, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> > > > If you need virt_to_page() to work, the address has to be part of the
> > > > linear/direct map.
> [...]
> >
> > What's the underlying requirement here? Is this a performance concern,
> > codegen/codesize, or something else?
> 
> It used to be performance, since is_kfence_address() is used in the
> fast path. However, with some further tweaks we just did to
> is_kfence_address(), our benchmarks show a pointer load can be
> tolerated.

Great!

I reckon that this is something we can optimize in futue if necessary
(e.g. with some form of code-patching for immediate values), but it's
good to have a starting point that works everywhere!

[...]

> > I'm not too worried about allocating this dynamically, but:
> >
> > * The arch code needs to set up the translation tables for this, as we
> >   cannot safely change the mapping granularity live.
> >
> > * As above I'm fairly certain x86 needs to use a carevout from the
> >   linear map to function correctly anyhow, so we should follow the same
> >   approach for both arm64 and x86. That might be a static carevout that
> >   we figure out the aliasing for, or something entirely dynamic.
> 
> We're going with dynamically allocating the pool (for both x86 and
> arm64), since any benefits we used to measure from the static pool are
> no longer measurable (after removing a branch from
> is_kfence_address()). It should hopefully simplify a lot of things,
> given all the caveats that you pointed out.
> 
> For arm64, the only thing left then is to fix up the case if the
> linear map is not forced to page granularity.

The simplest way to do this is to modify arm64's arch_add_memory() to
force the entire linear map to be mapped at page granularity when KFENCE
is enabled, something like:

| diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
| index 936c4762dadff..f6eba0642a4a3 100644
| --- a/arch/arm64/mm/mmu.c
| +++ b/arch/arm64/mm/mmu.c
| @@ -1454,7 +1454,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
|  {
|         int ret, flags = 0;
|  
| -       if (rodata_full || debug_pagealloc_enabled())
| +       if (rodata_full || debug_pagealloc_enabled() ||
| +           IS_ENABLED(CONFIG_KFENCE))
|                 flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
|  
|         __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),

... and I given that RODATA_FULL_DEFAULT_ENABLED is the default, I
suspect it's not worth trying to only for that for the KFENCE region
unless someone complains.

Thanks,
Mark.
