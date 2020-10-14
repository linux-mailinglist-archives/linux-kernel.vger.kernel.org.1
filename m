Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8916028E710
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgJNTM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390412AbgJNTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1610C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:12:50 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h10so346085oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeIyBZH1DlMazqL3WPQEWDzdrz72p5JAZek4MEGZox0=;
        b=QoXiKIK/b6kRcW6PeofIscaKrIR52aRKjK4qvKq8aq8FfwkJyBRTC0ZEcPvRccLrhQ
         u+FpbklPzt4CeRTorbjIFdSCfLOkMOflGkHc8h4q1COYv3UEi+R3nUAjbveX5cXR2V+p
         wCE7CgcPvaOdVfjawROqxRJ7rqWpmE5mbP3mPrTxWm8PrpDc5KuzQKTsrTsz1O27Csog
         KFs0ESSPZ2TcgNQ0ZsN3PYi4798fLNTOv9c63rkDZFfqUNSPRyVsOvlzYgs40HlLtSFs
         kgRH3yS4GXzfnqQaLDPtJF1yLg233FCVeq6yhxM4LWENkAIt6KpBXFiQVKjApYHQqAIV
         s10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeIyBZH1DlMazqL3WPQEWDzdrz72p5JAZek4MEGZox0=;
        b=YrYqLSV1iJ9vvYbAzfKtD3jzu5Uf5tcTgYm+vO+d8LaBmEFUoA/wCw3obk2GMSWd6n
         kPYw/XFJ2dLck1lMiCCQK3Hehv1Nmzm2228Dww7nXJirzu2cuBdcSyazFT92PZBJN0Mf
         4pOvTN1BGJAd0CSWBM+YHMf5fHmFP5Cafr1l3zKQgvHVhQ4kiyPmA9bliL4C6y+WTeB/
         Bx8dfAfISp4cgGdJoABZ707BGuxlLziZhbeGqRIziq+3h31wC3XazrAe79q6VxGHZJYX
         tZpHiC1Xij/jPqXOUKD0IciwwsZxtpVrCjql5o82HpnhcJj3EV94/exehlpbjODJvRYA
         4sXw==
X-Gm-Message-State: AOAM530bMW13ivmLk184vN3d9Hwp9qADLD7RcItTIfeYje2iDS8UGWEA
        NT3iYJxMM2NK9jLV5yVhOv8zUh3qMOo9OxBdkm5N7g==
X-Google-Smtp-Source: ABdhPJxI0rp8pxtj3cUByNFiFU6rolm7IayLQiq14hVoYtiHEk/OXGhVI9evgkFYJ4/Vus6tK95a5TvDzRsE+g22i1M=
X-Received: by 2002:aca:3d07:: with SMTP id k7mr537643oia.172.1602702769984;
 Wed, 14 Oct 2020 12:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-4-elver@google.com>
 <20200921143059.GO2139@willie-the-truck> <CAG_fn=WXknUnNmyniy_UE7daivSNmy0Da2KzNmX4wcmXC2Z_Mg@mail.gmail.com>
 <20200929140226.GB53442@C02TD0UTHF1T.local> <CAG_fn=VOR-3LgmLY-T2Fy6K_VYFgCHK0Hv+Y-atrvrVZ4mQE=Q@mail.gmail.com>
 <20201001175716.GA89689@C02TD0UTHF1T.local> <CANpmjNMFrMZybOebFwJ1GRXpt8v39AN016UDgPZzE8J3zKh9RA@mail.gmail.com>
 <20201008104501.GB72325@C02TD0UTHF1T.local>
In-Reply-To: <20201008104501.GB72325@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Wed, 14 Oct 2020 21:12:37 +0200
Message-ID: <CANpmjNOg2OeWpXn57_ikqv4KR0xVEooCDECUyRijgr0tt4+Ncw@mail.gmail.com>
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

On Thu, 8 Oct 2020 at 12:45, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Oct 08, 2020 at 11:40:52AM +0200, Marco Elver wrote:
> > On Thu, 1 Oct 2020 at 19:58, Mark Rutland <mark.rutland@arm.com> wrote:
> > [...]
> > > > > If you need virt_to_page() to work, the address has to be part of the
> > > > > linear/direct map.
> > [...]
> > >
> > > What's the underlying requirement here? Is this a performance concern,
> > > codegen/codesize, or something else?
> >
> > It used to be performance, since is_kfence_address() is used in the
> > fast path. However, with some further tweaks we just did to
> > is_kfence_address(), our benchmarks show a pointer load can be
> > tolerated.
>
> Great!
>
> I reckon that this is something we can optimize in futue if necessary
> (e.g. with some form of code-patching for immediate values), but it's
> good to have a starting point that works everywhere!
>
> [...]
>
> > > I'm not too worried about allocating this dynamically, but:
> > >
> > > * The arch code needs to set up the translation tables for this, as we
> > >   cannot safely change the mapping granularity live.
> > >
> > > * As above I'm fairly certain x86 needs to use a carevout from the
> > >   linear map to function correctly anyhow, so we should follow the same
> > >   approach for both arm64 and x86. That might be a static carevout that
> > >   we figure out the aliasing for, or something entirely dynamic.
> >
> > We're going with dynamically allocating the pool (for both x86 and
> > arm64), since any benefits we used to measure from the static pool are
> > no longer measurable (after removing a branch from
> > is_kfence_address()). It should hopefully simplify a lot of things,
> > given all the caveats that you pointed out.
> >
> > For arm64, the only thing left then is to fix up the case if the
> > linear map is not forced to page granularity.
>
> The simplest way to do this is to modify arm64's arch_add_memory() to
> force the entire linear map to be mapped at page granularity when KFENCE
> is enabled, something like:
>
[...]
>
> ... and I given that RODATA_FULL_DEFAULT_ENABLED is the default, I
> suspect it's not worth trying to only for that for the KFENCE region
> unless someone complains.

We've got most of this sorted now for v5 -- thank you!

The only thing we're wondering now, is if there are any corner cases
with using memblock_alloc'd memory for the KFENCE pool? (We'd like to
avoid page alloc's MAX_ORDER limit.) We have a version that passes
tests on x86 and arm64, but checking just in case. :-)

Thanks,
-- Marco
