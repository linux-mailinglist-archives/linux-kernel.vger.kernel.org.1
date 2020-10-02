Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7025C2814F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgJBOXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgJBOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:23:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09569C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:23:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j22so1310888qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAgelpYpJihRsjmlp4EjmhmaunlYd8C4mVKtF8jDi3w=;
        b=RKfZWi+RUXInTmQ3BLHhXRQmW4buor7BLC4IxwXfU0Vqf9mByJNzip/dve4hOmvzk6
         EaPUIEdyK1G1ywRnCXUSs6nvcfZgwNa9fxlrgjhNf6Lx1tOsZrRqjN9/KaNIfA3BeviP
         YAVkCBrNlInA7HUts3canKehhdEDbAXhYkd/3n/HlYQAaC0a6m+AKB7qz+rs84ZfK7A3
         ea3Shr+TAS/DiGKVASkTi14XB182x/nbUVybsej3xjWJgec9CX3W/cxbq374DFY9JlTT
         3dnQFEJNiGdMLbJxX3RuO43mIUOn+sDon5zqHf5EDY4guonk1AnckfPwU4PkR4lsqbpu
         n4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAgelpYpJihRsjmlp4EjmhmaunlYd8C4mVKtF8jDi3w=;
        b=JEwgZ2Wh/qqvzyWBvVsju4jJq0DFH8wDVVRlQTRtHhRH8o3GSEOZl8dWGPB9EKY6eB
         88mSAUPZxNR5xs6gAMb6DaLYf7vsgm/VQSDtQn0IaJcrObc4vLjx7P5fyG6HNrPcf+bn
         5Bk9dOGy4INVMXKchlauHBe6aC0Crmfv2JCdnaY02RGUWZo9OagdvbWtrzIkTpuXWAXE
         x+fx+HaQfNkkcMX+nwSGRU8r0tL/+f9Q4HxTmx/cRmHCgw1VmppeEt6vcxMPAASy38hs
         AD1tKIdoKwbXaHg/Yu+i6KqwfCF96GMKUWR5hGZJyrlBDi6BE6w10mbTH8VUmm6O6xF+
         f3Aw==
X-Gm-Message-State: AOAM5334M3h4AK3WmwbpyK6u1Jpelmu0J7TWoeGoM+5jwu0RZwo3gOUB
        Dgt7+FDgB2VElngVWVSd6X6A1df4WhRdrtHOzNV20A==
X-Google-Smtp-Source: ABdhPJxhXvszZ3go98nq7QHOuHf3kr4I/tA2aQd/4OmU/YkV5N0hrqi5M/eM2IoMPwR8MVkfDwfA94y9edqNJufG7i4=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr2529805qtq.380.1601648590888;
 Fri, 02 Oct 2020 07:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200929133814.2834621-1-elver@google.com> <20200929133814.2834621-2-elver@google.com>
 <CAG48ez3+_K6YXoXgKBkB8AMeSQj++Mxi5u2OT--B+mJgE7Cyfg@mail.gmail.com> <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com>
In-Reply-To: <CAG48ez1MQks2na23g_q4=ADrjMYjRjiw+9k_Wp9hwGovFzZ01A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Oct 2020 16:22:59 +0200
Message-ID: <CACT4Y+a3hLF1ph1fw7xVz1bQDNKL8W0s6pXe7aKm9wTNrJH3=w@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: add Kernel Electric-Fence infrastructure
To:     Jann Horn <jannh@google.com>
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 9:54 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Oct 2, 2020 at 8:33 AM Jann Horn <jannh@google.com> wrote:
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
> [...]
> > > +/*
> > > + * The pool of pages used for guard pages and objects. If supported, allocated
> > > + * statically, so that is_kfence_address() avoids a pointer load, and simply
> > > + * compares against a constant address. Assume that if KFENCE is compiled into
> > > + * the kernel, it is usually enabled, and the space is to be allocated one way
> > > + * or another.
> > > + */
> >
> > If this actually brings a performance win, the proper way to do this
> > would probably be to implement this as generic kernel infrastructure
> > that makes the compiler emit large-offset relocations (either through
> > compiler support or using inline asm statements that move an immediate
> > into a register output and register the location in a special section,
> > kinda like how e.g. static keys work) and patches them at boot time,
> > or something like that - there are other places in the kernel where
> > very hot code uses global pointers that are only ever written once
> > during boot, e.g. the dentry cache of the VFS and the futex hash
> > table. Those are probably far hotter than the kfence code.
> >
> > While I understand that that goes beyond the scope of this project, it
> > might be something to work on going forward - this kind of
> > special-case logic that turns the kernel data section into heap memory
> > would not be needed if we had that kind of infrastructure.
>
> After thinking about it a bit more, I'm not even convinced that this
> is a net positive in terms of overall performance - while it allows
> you to avoid one level of indirection in some parts of kfence, that
> kfence code by design only runs pretty infrequently. And to enable
> this indirection avoidance, your x86 arch_kfence_initialize_pool() is
> shattering potentially unrelated hugepages in the kernel data section,
> which might increase the TLB pressure (and therefore the number of
> memory loads that have to fall back to slow page walks) in code that
> is much hotter than yours.
>
> And if this indirection is a real performance problem, that problem
> would be many times worse in the VFS and the futex subsystem, so
> developing a more generic framework for doing this cleanly would be
> far more important than designing special-case code to allow kfence to
> do this.
>
> And from what I've seen, a non-trivial chunk of the code in this
> series, especially the arch/ parts, is only necessary to enable this
> microoptimization.
>
> Do you have performance numbers or a description of why you believe
> that this part of kfence is exceptionally performance-sensitive? If
> not, it might be a good idea to remove this optimization, at least for
> the initial version of this code. (And even if the optimization is
> worthwhile, it might be a better idea to go for the generic version
> immediately.)

This check is very hot, it happens on every free. For every freed
object we need to understand if it belongs to KFENCE or not.

The generic framework for this already exists -- you simply create a
global variable ;)
KFENCE needs the range to be covered by struct page's and that's what
creates problems for arm64. But I would assume most other users don't
need that.
