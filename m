Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C65266613
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIKRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIKNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:01:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72493C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:01:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m12so8285983otr.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ge/FjJXhyj8+NsSSsvCMLGtUiAk37fA1+cTelebZ4Go=;
        b=T96RFKKMbfGXmGKQW/wQkQusFFYQX5igqwU6L75Yeso5+r11VBgv0lztFH9rNbHlY3
         5B0LrTTcrBZveyQWzWcwQCKeRcyEas+n8CGz3zVLjk3BHBmngz6iniRoFzLHyeCEKgD0
         SfihZ41/sKpTvQWRFJLJgc9OiULTEBppsdBLOZxSHyOPU/g9QcvvDXQh4dY//h83F68D
         ESzkFo2LP1uYXPiZlMAQQce8uhNDJFIRPkcEU8JQ+J90kOfx32MrFwTnj/mS1FW0RD1e
         qGrx8cYDqjBlz9uoLUveNlE+9hLQk8moh/ndBUm2Yp5Ev3Kn7jiVpo/Fnwdz/WXss1W+
         TXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge/FjJXhyj8+NsSSsvCMLGtUiAk37fA1+cTelebZ4Go=;
        b=cv42zbCxaG9O9Z6Z2p0e8F8bYIfNGNK8PFuRaPp3teXovlobOhJ8CfT56ASdfCTf7g
         9QnktlDVaOeWMIGrHJu+fZtp2m+Pi+SDbCQmR0uAw2Kukk8KNh8Z8ek8ReeJ+PNXkti8
         SHxSizvv0jrexjqL6PoSKK2Dh/1aJX6b7z9qOcnF7L0p37U/XHbtvmkp6ADHiZTIHztP
         keaXvHwhFhI5WbhKcD2NZNK+jB+c6egHOg03GechnUF/P2J2bfXCMC7wsxFZQJGQxI2S
         VkIMtrlSGptamLyfhneUwDtdtWOie6F7fv/bGA1U3oz3hHS+f06WsucMyrAGephpMpfn
         R4Qg==
X-Gm-Message-State: AOAM530SN6yMMNK6nfHDmZgSyXuLHtqgF6BfFf2yhZ2IV9Ncda9nDp9i
        28eHgtrDqDpQf8R2j5KfumbUljUsICwh8WFpQmuQ6w==
X-Google-Smtp-Source: ABdhPJyvnEkxpzeJQj2l5oqacEmEr9jCCxehUw6cPnNOvxF93kxRylc4qW/tdBx2vsUZCsc/aeHXDTxenucOjpbTbWU=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr1038835otk.251.1599829266141;
 Fri, 11 Sep 2020 06:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-7-elver@google.com>
 <CACT4Y+b=Ph-fD_K5F_TNMp_dTNjD7GXGT=OXogrKc_HwH+HHwQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b=Ph-fD_K5F_TNMp_dTNjD7GXGT=OXogrKc_HwH+HHwQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Sep 2020 15:00:54 +0200
Message-ID: <CANpmjNMHHWjdLiWi+vhffcWq=UNFVGV7so6AggezcvnoOFHvKA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] kfence, kasan: make KFENCE compatible with KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 at 09:05, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
> >
> > From: Alexander Potapenko <glider@google.com>
> >
> > We make KFENCE compatible with KASAN for testing KFENCE itself. In
> > particular, KASAN helps to catch any potential corruptions to KFENCE
> > state, or other corruptions that may be a result of freepointer
> > corruptions in the main allocators.
> >
> > To indicate that the combination of the two is generally discouraged,
> > CONFIG_EXPERT=y should be set. It also gives us the nice property that
> > KFENCE will be build-tested by allyesconfig builds.
> >
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  lib/Kconfig.kfence | 2 +-
> >  mm/kasan/common.c  | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> > index 7ac91162edb0..b080e49e15d4 100644
> > --- a/lib/Kconfig.kfence
> > +++ b/lib/Kconfig.kfence
> > @@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
> >
> >  menuconfig KFENCE
> >         bool "KFENCE: low-overhead sampling-based memory safety error detector"
> > -       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> > +       depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
> >         depends on JUMP_LABEL # To ensure performance, require jump labels
> >         select STACKTRACE
> >         help
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 950fd372a07e..f5c49f0fdeff 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/init.h>
> >  #include <linux/kasan.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kfence.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/linkage.h>
> >  #include <linux/memblock.h>
> > @@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> >         tagged_object = object;
> >         object = reset_tag(object);
> >
> > +       if (is_kfence_address(object))
> > +               return false;
>
> Is this needed?
> At least in the slab patch I see that we do :
>
> if (kfence_free(objp)) {
>   kmemleak_free_recursive(objp, cachep->flags);
>   return;
> }
>
> before:
>
> /* Put the object into the quarantine, don't touch it for now. */ /*
> Put the object into the quarantine, don't touch it for now. */
> if (kasan_slab_free(cachep, objp, _RET_IP_)) if
> (kasan_slab_free(cachep, objp, _RET_IP_))
>   return; return;
>
>
> If it's not supposed to be triggered, it can make sense to replace
> with BUG/WARN.

It is required for SLUB. For SLAB, it seems it might not be necessary.
Making the check in kasan/common.c conditional on the allocator seems
ugly, so I propose we keep it there.

Thanks,
-- Marco
