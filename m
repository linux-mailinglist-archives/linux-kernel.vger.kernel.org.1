Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B92283CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgJEQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgJEQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:49:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7FC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:49:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 33so10117311edq.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e75sgfE0gBHuZ+sQh5xSznZKqRTfepXZ5BM13ORNfbc=;
        b=YVj4GC3JL8go1+BQzjpqRqC+/HErXCrcVSbeTGXkmGNDW0inx8fYasntI3xi6q8VOM
         hJVNYfqKZPCzxROaMECiKmwLcdalUc1GdONuilK01tVtKa891PSDahBolGt9vJKkkSOL
         B0hyh8ssSuuwmiS2dIotXfe6KCbVlfk7jvA1blxGgHgJbdflFwobWNcvSrGx058Q/beR
         KU4kN/C5m3lc95eHwZLfKb3lf2wCsj5934cQIzfTnG9+JSUg0kYxuitggcx40qWKFVgI
         77FMQRT8Q4W2BepuQvyuFCNaAX2Na1W5CNqAiuR2rDWjdrpuNHqtkwhLe9xKwKVBWEBG
         M3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e75sgfE0gBHuZ+sQh5xSznZKqRTfepXZ5BM13ORNfbc=;
        b=f/5b8wIosChX0rJ6WD8jmevG4v61vV1XzZMZ9c8pcGuZGLEhKXxr8s3YetdSBPBQq5
         jE9qDPCbQwbERZ284XqX9VnROV6GB4CEEazbL3Cbxtw8esMPFv3RnaNqIDSKpVglToij
         hz4q1CQMUrKFEYaJP0kK96j3EP4NXbAjFpu60dBMuYJkkvZz+NgF9bd5YtRdFiwX3UCz
         XJaNfbjLYaH7Xl7V2IOrQG0w1lx1a3AHoILkevOZ9QAwmN8mY9EBDMg714xnnD1wcwbP
         wr6gCeQdKP7Mb4rsjFuizI5WZRxbPcLEusYd1EUBsVy7+lIANS05TX6g7hBQ5uuT79y3
         T1fA==
X-Gm-Message-State: AOAM530UxRPqBx9Eg+RB087MCBe81XTflpmSYVat+WFCEzMQn0EIE2PP
        6I+kwIYfkGKqqOl/cYh4jlRmAV+yQpJ2OusC7cf9Zg==
X-Google-Smtp-Source: ABdhPJzebiK7XGTTGSesU9XZZts7MY9QebXYMDbKFDRw9FyOaSzmZF06erodX8ExTD8H4foe9ncp1NqIIGZDvVpWzfo=
X-Received: by 2002:a50:ccd2:: with SMTP id b18mr555817edj.51.1601916589473;
 Mon, 05 Oct 2020 09:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-2-elver@google.com>
 <20200929142411.GC53442@C02TD0UTHF1T.local> <CANpmjNNQGrpq+fBh4OypP9aK+-548vbCbKYiWQnSHESM0SLVzw@mail.gmail.com>
 <20200929150549.GE53442@C02TD0UTHF1T.local> <CAG_fn=WKEtVSRLASSZV1A9dnPGoaZM_DgJeH5Q1WcLcFBqH00g@mail.gmail.com>
In-Reply-To: <CAG_fn=WKEtVSRLASSZV1A9dnPGoaZM_DgJeH5Q1WcLcFBqH00g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 5 Oct 2020 18:49:23 +0200
Message-ID: <CAG48ez3kmvvymiCemX_U1=CoRrn2Ayx1fbwAzPQ2jNE-qfj4MA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Alexander Potapenko <glider@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
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

On Mon, Oct 5, 2020 at 6:01 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Sep 29, 2020 at 5:06 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 04:51:29PM +0200, Marco Elver wrote:
> > > On Tue, 29 Sep 2020 at 16:24, Mark Rutland <mark.rutland@arm.com> wrote:
> > > [...]
> > > >
> > > > From other sub-threads it sounds like these addresses are not part of
> > > > the linear/direct map. Having kmalloc return addresses outside of the
> > > > linear map is going to break anything that relies on virt<->phys
> > > > conversions, and is liable to make DMA corrupt memory. There were
> > > > problems of that sort with VMAP_STACK, and this is why kvmalloc() is
> > > > separate from kmalloc().
> > > >
> > > > Have you tested with CONFIG_DEBUG_VIRTUAL? I'd expect that to scream.
> > > >
> > > > I strongly suspect this isn't going to be safe unless you always use an
> > > > in-place carevout from the linear map (which could be the linear alias
> > > > of a static carevout).
> > >
> > > That's an excellent point, thank you! Indeed, on arm64, a version with
> > > naive static-pool screams with CONFIG_DEBUG_VIRTUAL.
> > >
> > > We'll try to put together an arm64 version using a carveout as you suggest.
> >
> > Great, thanks!
> >
> > Just to be clear, the concerns for DMA and virt<->phys conversions also
> > apply to x86 (the x86 virt<->phys conversion behaviour is more forgiving
> > in the common case, but still has cases that can go wrong).
>
> To clarify, shouldn't kmalloc/kmem_cache allocations used with DMA be
> allocated with explicit GFP_DMA?
> If so, how practical would it be to just skip such allocations in
> KFENCE allocator?

AFAIK GFP_DMA doesn't really mean "I will use this allocation for
DMA"; it means "I will use this allocation for DMA using some ancient
hardware (e.g. stuff on the ISA bus?) that only supports 16-bit
physical addresses (or maybe different limits on other
architectures)".
There's also GFP_DMA32, which means the same thing, except with 32-bit
physical addresses.

You can see in e.g. __dma_direct_alloc_pages() that the GFP_DMA32 and
GFP_DMA flags are only used if the hardware can't address the full
physical address space supported by the CPU.
