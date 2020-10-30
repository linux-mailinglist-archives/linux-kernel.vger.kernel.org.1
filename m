Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004C92A0A77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgJ3PzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgJ3PzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:55:03 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCADC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:55:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m22so5966820ots.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCugon9AoPEJ8csYK/QZPsPZOpWR2wJLxLfUDJUrNWA=;
        b=K0Bt4tbRQHFuGp039wzieHLjfl0FuYhnRx5bfqQwpQXcTVdbCpoeUKNfv5Ij31ox1y
         Kws5dwUYP+1Z1b0TCvdeeALRVxpVZ1kz8I3/bm1D9orCfONXEhAJUNAdi+s6OVB3SRoB
         lVG2y3PV1epogTO8AjkZs5Y17FJXXdSHdEeIeROL4OyAiGcGEjXR2mMg6TXOSoqJG7KW
         1yJcYhY9GzfGcUdSnVR0oHtCe5c5HEsVjJmA8uwwAESkc9CJT6QnbSn1CPMEwlPWSjQC
         FWRgCdmSzxorAWWMWF7FZDcGsPLG/FNlKSttzXuCH6+u/MNwmJdJa8wUh6sGnwEcn/uk
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCugon9AoPEJ8csYK/QZPsPZOpWR2wJLxLfUDJUrNWA=;
        b=h4NLov9TyOpvS48X62Us02XIo4zgQVw5imJcHhx4hnCmjWGBchpDk2FHWSZMNOVmog
         5026tGsRi1mXuPYSm8T1mK3KbiQeRfYayGfXbFItQ795D0LJEe3mr7tUNsYpFz+Bsnv1
         WJliY4+3BdP5A7M6wpycfTu9dmozEnEHGUzhdRuYoUv9A5OcOj5EmP3VgkqqD0KJjumB
         tUvyJVjT6wKon/mV8N9A9Ky9/XubBy1fOaFpt1VtoN51+HP+We7EjuRS5OZhNcEmgYrl
         AFK2VNrsrfLuok7wrcyz2tSsDn6/ZhXWfrrXa1M7JCVd1OngPaDujofnofd91bWt34Lv
         Zjow==
X-Gm-Message-State: AOAM531TBchr72s9fFFWEN8WRjr99a3mmQi/t+onR7N8KUjYuEluHhqs
        PXOqFAc2D+BBjuYHtIZxpUvWyrM1JBeFYTPsoXjowQ==
X-Google-Smtp-Source: ABdhPJwFbGXqi/JUtaO8L3QpxlNT87x8n1E4ITjvXc7fTnDKfS6vdmn4tuvb4bOooP2JLa8nQWHFVlMXtC4HQiPhYYM=
X-Received: by 2002:a9d:649:: with SMTP id 67mr2236333otn.233.1604073302210;
 Fri, 30 Oct 2020 08:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-4-elver@google.com>
 <20201030154745.GD50718@C02TD0UTHF1T.local>
In-Reply-To: <20201030154745.GD50718@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 16:54:50 +0100
Message-ID: <CANpmjNNko4pYa3zrzWOVROZF8RGsaH4tNffZrDOaNpVa2ZkNRA@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] arm64, kfence: enable KFENCE for ARM64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
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
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
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

On Fri, 30 Oct 2020 at 16:47, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 29, 2020 at 02:16:43PM +0100, Marco Elver wrote:
> > Add architecture specific implementation details for KFENCE and enable
> > KFENCE for the arm64 architecture. In particular, this implements the
> > required interface in <asm/kfence.h>.
> >
> > KFENCE requires that attributes for pages from its memory pool can
> > individually be set. Therefore, force the entire linear map to be mapped
> > at page granularity. Doing so may result in extra memory allocated for
> > page tables in case rodata=full is not set; however, currently
> > CONFIG_RODATA_FULL_DEFAULT_ENABLED=y is the default, and the common case
> > is therefore not affected by this change.
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Co-developed-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v5:
> > * Move generic page allocation code to core.c [suggested by Jann Horn].
> > * Remove comment about HAVE_ARCH_KFENCE_STATIC_POOL, since we no longer
> >   support static pools.
> > * Force page granularity for the linear map [suggested by Mark Rutland].
> > ---
> >  arch/arm64/Kconfig              |  1 +
> >  arch/arm64/include/asm/kfence.h | 19 +++++++++++++++++++
> >  arch/arm64/mm/fault.c           |  4 ++++
> >  arch/arm64/mm/mmu.c             |  7 ++++++-
> >  4 files changed, 30 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/kfence.h
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index f858c352f72a..2f8b32dddd8b 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -135,6 +135,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> >       select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> > +     select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)
>
> Why does this depend on the page size?
>
> If this is functional, but has a larger overhead on 16K or 64K, I'd
> suggest removing the dependency, and just updating the Kconfig help text
> to explain that.

Good point, I don't think anything is requiring us to force 4K pages.
Let's remove it.

Thanks,
-- Marco

> Otherwise, this patch looks fine to me.
>
> Thanks,
> Mark.
