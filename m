Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC12871BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgJHJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:41:06 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C1C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 02:41:04 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id c25so659075ooe.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfMhghjBP9os9D7z08t6DZuXpLEhZ0q00x6tVMxnguE=;
        b=XhgNGt7sZGGLxtmNrRJ871VQhJd0fNw2qyyQ3bG65nG8yWrd0coT2vg98wemz73DRa
         OQFOsfFkqX3Qpv6BqvANBrGp1v/zHUL6/F//Y8Z8W+ZGO/O8NtUgc/cun0XtY3sugtqC
         rpD3wq1fMFPkSqujDdgA11TQivyGzt2VdLlYgjK/OCYOLFei2YuVtXmBbN7RTzbZJAfD
         qg8lTlu+yyX5/bTsKx6BRHDb4yxxyO3Mtr7iiyFVeFHjxKSdhHNGb+TLiumyyyP20mYk
         f39q+It7JtrMXjXHTF8AbAY15c/yMOL/TbbKTQoU4hosJJHPQ6/5rrrouihLrRtPS1gs
         HArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfMhghjBP9os9D7z08t6DZuXpLEhZ0q00x6tVMxnguE=;
        b=iZujtQ3Ij5PDf+qmSRjeDGGmW6HkjIsXUdtpnkAOLANaVmlqVci4keUQOK4zvSsiyA
         brybT24WAZfPsyVRJkLFkh3ngws2qUcaLnsRhgtkfWeGLA2fUq4yfSSNI310fZRjfmYD
         zJbSTYT9Xwyo2iRRpoHiWKEWYn+lm2/3IwxVog3vMJBdP0BLQLQpzzOlyF3qxSMqE7Dh
         PsWGMCSh2hbZdZRWhCk4RqxtOhrNLV0ECDmb6LrCDokJR1VQuWuYJ8BI+CZ2jKwZCWZb
         E0EVye8HxaPc0j+iYpyso+tRGwWaSAUlKEw61m1VuM3KP5ugXpc5JmispkI8diHdYrJ6
         Y1VQ==
X-Gm-Message-State: AOAM531U0ie0Nd2CWBkLv24KYlwSCTfvxWi2bzXCg5FUOq4M0sV7mDCU
        smAJx66NdP7rOd7wHQgJ0hG9tftsocJS4f6JWz1+FQ==
X-Google-Smtp-Source: ABdhPJz6rUkb1Txy1Mg6WERcI/aK60bYF3BpyK1h2rgllajlsKxuWqvgLfUlTY2lcTNMmGW97hxPyj88uoxYkOw99u4=
X-Received: by 2002:a4a:751a:: with SMTP id j26mr4844047ooc.14.1602150063537;
 Thu, 08 Oct 2020 02:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck> <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local> <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
 <20201001175716.GA89689@C02TD0UTHF1T.local>
In-Reply-To: <20201001175716.GA89689@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Thu, 8 Oct 2020 11:40:52 +0200
Message-ID: <CANpmjNMFrMZybOebFwJ1GRXpt8v39AN016UDgPZzE8J3zKh9RA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
To:     Mark Rutland <mark.rutland@arm.com>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 at 19:58, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> > > If you need virt_to_page() to work, the address has to be part of the
> > > linear/direct map.
[...]
>
> What's the underlying requirement here? Is this a performance concern,
> codegen/codesize, or something else?

It used to be performance, since is_kfence_address() is used in the
fast path. However, with some further tweaks we just did to
is_kfence_address(), our benchmarks show a pointer load can be
tolerated.

> > (3) For addresses belonging to that pool virt_addr_valid() is true
> > (SLAB/SLUB rely on that)
>
> As I hinted at before, there's a reasonable amount of code which relies
> on being able to round-trip convert (va->{pa,page}->va) allocations from
> SLUB, e.g. phys = virt_to_page(addr); ... ; phys = page_to_virt(phys).
> Usually this is because the phys addr is stored in some HW register, or
> in-memory structure shared with HW.
>
> I'm fairly certain KFENCE will need to support this in order to be
> deployable in production, and arm64 is the canary in the coalmine.
>
> I added tests for this back when tag-based KASAN broke this property.
> See commit:
>
>   b92a953cb7f727c4 ("lib/test_kasan.c: add roundtrip tests")
>
> ... for which IIUC the kfree_via_phys() test would be broken by KFENCE,
> even on x86:

Yeah, we're fixing that by also making x86 use a dynamically allocated
pool now. The benefits we got from the static pool no longer apply, so
the whole dance to make the static pool work right is no longer worth
it.

> | static noinline void __init kfree_via_phys(void)
> | {
> |        char *ptr;
> |        size_t size = 8;
> |        phys_addr_t phys;
> |
> |        pr_info("invalid-free false positive (via phys)\n");
> |        ptr = kmalloc(size, GFP_KERNEL);
> |        if (!ptr) {
> |                pr_err("Allocation failed\n");
> |                return;
> |        }
> |
> |        phys = virt_to_phys(ptr);
> |        kfree(phys_to_virt(phys));
> | }
>
> ... since the code will pass the linear map alias of the KFENCE VA into
> kfree().
>
> To avoid random breakage we either need to:
>
> * Have KFENCE retain this property (which effectively requires
>   allocation VAs to fall within the linear/direct map)

^^ Yes, this is the only realistic option.

> * Decide that round-trips are forbidden, and go modify that code
>   somehow, which was deemed to be impractical in the past
>
> ... and I would strongly prefer the former as it's less liable to break any
> existing code.
>
> > On x86 we achieve (2) by making our pool a .bss array, so that its
> > address is known statically. Aligning that array on 4K and calling
> > set_memory_4k() ensures that (1) is also fulfilled. (3) seems to just
> > happen automagically without any address translations.
> >
> > Now, what we are seeing on arm64 is different.
> > My understanding (please correct me if I'm wrong) is that on arm64
> > only the memory range at 0xffff000000000000 has valid struct pages,
> > and the size of that range depends on the amount of memory on the
> > system.
>
> The way virt_to_page() works is based on there being a constant (at
> runtime) offset between a linear map address and the corresponding
> physical page. That makes it easy to get the PA with a subtraction, then
> the PFN with a shift, then to index the vmemmap array with that to get
> the page. The x86 version of virt_to_page() automatically fixes up an
> image address to its linear map alias internally.
>
> > This probably means we cannot just pick a fixed address for our pool
> > in that range, unless it is very close to 0xffff000000000000.
>
> It would have to be part of the linear map, or we'd have to apply the
> same fixup as x86 does. But as above, I'm reluctant to do that as it
> only encourages writing fragile code. The only sensible way to detect
> that is to disallow virt_to_*() on image addresses, since that's the
> only time we can distinguish the source.
>
> > If we allocate the pool statically in the way x86 does (assuming we
> > somehow resolve (1)), we can apply lm_alias() to addresses returned by
> > the KFENCE allocator, making kmalloc() always return addresses from
> > the linear map and satisfying (3).
> > But in that case is_kfence_address() will also need to be updated to
> > compare the addresses to lm_alias(__kfence_pool), and this becomes
> > more heavyweight than just reading the address from memory.
>
> We can calculate the lm_alias(__kfence_pool) at boot time, so it's only
> a read from memory in the fast-path.
>
> > So looks like it's still more preferable to allocate the pool
> > dynamically on ARM64, unless there's a clever trick to allocate a
> > fixed address in the linear map (DTS maybe?)
>
> I'm not too worried about allocating this dynamically, but:
>
> * The arch code needs to set up the translation tables for this, as we
>   cannot safely change the mapping granularity live.
>
> * As above I'm fairly certain x86 needs to use a carevout from the
>   linear map to function correctly anyhow, so we should follow the same
>   approach for both arm64 and x86. That might be a static carevout that
>   we figure out the aliasing for, or something entirely dynamic.

We're going with dynamically allocating the pool (for both x86 and
arm64), since any benefits we used to measure from the static pool are
no longer measurable (after removing a branch from
is_kfence_address()). It should hopefully simplify a lot of things,
given all the caveats that you pointed out.

For arm64, the only thing left then is to fix up the case if the
linear map is not forced to page granularity.

Thanks,
-- Marco
