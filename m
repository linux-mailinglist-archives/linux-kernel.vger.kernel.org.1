Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C76283BDD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgJEQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJEQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:01:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:01:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so6573756wre.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F38mYIS/X8WyXHWOLkz8wuYqStbWhqnLSCK7WusSBkg=;
        b=GK57Nxy/OTB2bIJciaPrbDjU2sHiyot+50pQ2m5FW7HuIwHGJhv3j2yy9HQYKMargZ
         LOSnHsb3W0lqhzu46Zz2ljmS2ivy+eEYiqizC1IVLU4/FEAWpyW6T4O55G+z/pSBwDm/
         K49lhz4Cg8Y5R04yvR84W0GYJ45F01wM6S9p/DMEwSOlnb1peLFlwL51ujSgMzOY4/6i
         Ic4X/u3t9NZkAMMr9AXCDwFy359DRdr8slvGR9AOiQMTsA8TEIzdon5Afqyviv8OL3DI
         UrID089P1T2Kj6UAZjIWXe5uxnWuq5smjmloM/nDyS+tDmK/T5WavOHy1VUUmpSxuDeN
         2TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F38mYIS/X8WyXHWOLkz8wuYqStbWhqnLSCK7WusSBkg=;
        b=iG9YxD/usrQDBb+aaoEn8wg73FH7RAYur8K/1dY16X4Tps416Kgwv8k5vWay3efBZR
         h/vjH0ivTG7nKnTnWH/cQVUJCiWAXK//kK8WpjppOVCnou0RE46tYedxCt7NwZ9llvld
         6QatRr3HhkN4FclzmActWG1QLOqaJAXwQ1ifB0/l1HjnB1dO61B96X3YIozA3d1QKGXm
         ZyneeNA2rKZTZJxGOZ73jrFQOqMWAvHUj9n3iudZF7oakVexlA49hcFEiNQ9VBCr53qp
         BjlFcEPGlp9oDd13HdT6h+MoZ4sx0/2HdtfCI6nvfFQKR5BHl0ikXdxCb4UMF3DSmj1w
         lqew==
X-Gm-Message-State: AOAM530pPQaYx7WHP1FmYpGKl9RMMlGlbAz3hzlkFOkEttwnoicOddl5
        qwq5wDsY95FC/jHOCC4ER12iEja/OtzaO7nvyFN1RQ==
X-Google-Smtp-Source: ABdhPJxqK7BunDKr3q1TD4Lm3VUncdK+5sIvfkPRcNilb6WHgWFEJqYzsuqa09MZ/AYjykQNbq7vnfoSU2sjAJbERC0=
X-Received: by 2002:adf:f101:: with SMTP id r1mr66271wro.314.1601913669054;
 Mon, 05 Oct 2020 09:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-2-elver@google.com>
 <20200929142411.GC53442@C02TD0UTHF1T.local> <CANpmjNNQGrpq+fBh4OypP9aK+-548vbCbKYiWQnSHESM0SLVzw@mail.gmail.com>
 <20200929150549.GE53442@C02TD0UTHF1T.local>
In-Reply-To: <20200929150549.GE53442@C02TD0UTHF1T.local>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 5 Oct 2020 18:00:57 +0200
Message-ID: <CAG_fn=WKEtVSRLASSZV1A9dnPGoaZM_DgJeH5Q1WcLcFBqH00g@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
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

On Tue, Sep 29, 2020 at 5:06 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Sep 29, 2020 at 04:51:29PM +0200, Marco Elver wrote:
> > On Tue, 29 Sep 2020 at 16:24, Mark Rutland <mark.rutland@arm.com> wrote:
> > [...]
> > >
> > > From other sub-threads it sounds like these addresses are not part of
> > > the linear/direct map. Having kmalloc return addresses outside of the
> > > linear map is going to break anything that relies on virt<->phys
> > > conversions, and is liable to make DMA corrupt memory. There were
> > > problems of that sort with VMAP_STACK, and this is why kvmalloc() is
> > > separate from kmalloc().
> > >
> > > Have you tested with CONFIG_DEBUG_VIRTUAL? I'd expect that to scream.
> > >
> > > I strongly suspect this isn't going to be safe unless you always use an
> > > in-place carevout from the linear map (which could be the linear alias
> > > of a static carevout).
> >
> > That's an excellent point, thank you! Indeed, on arm64, a version with
> > naive static-pool screams with CONFIG_DEBUG_VIRTUAL.
> >
> > We'll try to put together an arm64 version using a carveout as you suggest.
>
> Great, thanks!
>
> Just to be clear, the concerns for DMA and virt<->phys conversions also
> apply to x86 (the x86 virt<->phys conversion behaviour is more forgiving
> in the common case, but still has cases that can go wrong).

To clarify, shouldn't kmalloc/kmem_cache allocations used with DMA be
allocated with explicit GFP_DMA?
If so, how practical would it be to just skip such allocations in
KFENCE allocator?
