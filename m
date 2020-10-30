Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D485E2A094A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgJ3PJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgJ3PJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:09:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217CFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:09:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i6so8338047lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mk8TOBtLAUSh5UUmmftefVTpJAKNzTPUbZbR4xmTmm4=;
        b=GJxiwN9xabxRUEX1wI54H5lalSd1TYmvurtYqc/M2fA6V8U33bHNZ9KUnm+NrEFIZC
         Qrvcf8Oz1kmgZNU8G9hQ+3LL+ggO/PwDnFadE0BF68AW4sCZ0neyXtjFVi1hvLP2jw7o
         +tMXm8/POQ6ky6KAGphB5Uqn9dvqIRhiRBJegWSiGd9F0gAwKolszqsF6awnzU/IOT89
         CBp89samOLM2uSJ4eB+cN7lZ/Hqu00LAQlRIY8YNBjayjS3ZLFFpVYVGo12j6uLwDEpR
         lWIWKskV5OFyjvLzv+TFVnFJOmKD/NODIpy3k5jGGi34kLl4uTFGiR9+v0q/Kqcx+q0W
         QaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk8TOBtLAUSh5UUmmftefVTpJAKNzTPUbZbR4xmTmm4=;
        b=OposxeTuS4P6ocAz2JJDLkko9CAiR0gWuENF3I6amuEb96LM+LYYFwiMa/k3CedhR2
         KrCnpSORWgU8C2kIDUtnEuS8NirLwtsQrAxlzgj/L8zkpNpc/1NJrM+zofepX6osbdBt
         x8cURkw9AQeBp5bGMHd1TtePAL/w739bz7VOhbewjEWCjDr3Z2ebwl0JMoTTsAQRohLc
         tcFIpVSF71GhKJpMGcuGIlQGJXEMZvX0sdIIq7M58EAGYY5f5/5yIWR9fmBpaoX0Iq0k
         HydtThY1gKIo0Km08r0SxpVFWnZ1OEdCWQCBhy0VZPWrErlSEUs26uZG8LiefMeVoe0e
         GPNQ==
X-Gm-Message-State: AOAM533za+FZJ864ZreAZuwHWitSMKZaL/k59PoRZXQmB7EkIJvi+G68
        K9ckc37HhF2iZ/G/JjxQgkQ8FsRlxFax4o8nQCN9lw==
X-Google-Smtp-Source: ABdhPJwFpY6gAtBTRZBpckeKfkvLswlZHFXWkaX0WYhbn78B0G6kn/sPe6PzVY5TSbxBhNY24ss2alpqvzB69CmY910=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr1077748lfr.198.1604070563207;
 Fri, 30 Oct 2020 08:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-7-elver@google.com>
 <CAG48ez0N5iKCmg-JEwZ2oKw3zUA=5EdsL0CMi6biwLbtqFXqCA@mail.gmail.com> <CANpmjNONPovgW6d4srQNQ-S-tiYCSxot7fmh=HDOdcRwO32z6A@mail.gmail.com>
In-Reply-To: <CANpmjNONPovgW6d4srQNQ-S-tiYCSxot7fmh=HDOdcRwO32z6A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 16:08:56 +0100
Message-ID: <CAG48ez30tzadrtJm_ShY8oGjnYpf3GDfcajm7S0xX6UxfTCQZw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] kfence, kasan: make KFENCE compatible with KASAN
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
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 2:46 PM Marco Elver <elver@google.com> wrote:
> On Fri, 30 Oct 2020 at 03:50, Jann Horn <jannh@google.com> wrote:
> > On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > > We make KFENCE compatible with KASAN for testing KFENCE itself. In
> > > particular, KASAN helps to catch any potential corruptions to KFENCE
> > > state, or other corruptions that may be a result of freepointer
> > > corruptions in the main allocators.
> > >
> > > To indicate that the combination of the two is generally discouraged,
> > > CONFIG_EXPERT=y should be set. It also gives us the nice property that
> > > KFENCE will be build-tested by allyesconfig builds.
> > >
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > Co-developed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
>
> Thanks!
>
> > with one nit:
> >
> > [...]
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > [...]
> > > @@ -141,6 +142,14 @@ void kasan_unpoison_shadow(const void *address, size_t size)
> > >          */
> > >         address = reset_tag(address);
> > >
> > > +       /*
> > > +        * We may be called from SL*B internals, such as ksize(): with a size
> > > +        * not a multiple of machine-word size, avoid poisoning the invalid
> > > +        * portion of the word for KFENCE memory.
> > > +        */
> > > +       if (is_kfence_address(address))
> > > +               return;
> >
> > It might be helpful if you could add a comment that explains that
> > kasan_poison_object_data() does not need a similar guard because
> > kasan_poison_object_data() is always paired with
> > kasan_unpoison_object_data() - that threw me off a bit at first.
>
> Well, KFENCE objects should never be poisoned/unpoisoned because the
> kasan_alloc and free hooks have a kfence guard, and none of the code
> in sl*b.c that does kasan_{poison,unpoison}_object_data() should be
> executed for KFENCE objects.
>
> But I just noticed that kernel/scs.c seems to kasan_poison and
> unpoison objects, and keeps them poisoned for most of the object
> lifetime.

FWIW, I wouldn't be surprised if other parts of the kernel also ended
up wanting to have in-object redzones eventually - e.g. inside skb
buffers, which have a struct skb_shared_info at the end. AFAIU at the
moment, KASAN can't catch small OOB accesses from these buffers
because of the following structure.

> I think we better add a kfence guard to
> kasan_poison_shadow() as well.

Sounds good.
