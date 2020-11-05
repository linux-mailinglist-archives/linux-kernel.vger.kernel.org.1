Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A12A7D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgKELg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgKELfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:35:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B57C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:35:23 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so1262261pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+r/dPqbzqLZgGMdUBdXFU/WPqHd1cGIgABAmt0Dvlo=;
        b=sR+Li0rdCdEZxUspJsqWzrLwdV41Kif8THgslj84rvYxC+3GS6RGU4YDm7LxxhZpGl
         hMVkVHm8MpMC06dRTyzQnw75O8sPwOMZcFwb+mS/VrSvooJuaJic7QlLChi8xhRxrOV5
         StW5T6h8dr8Tvwd2HcN5uq+OjpbzD6TGz2VRpMABHTJzohoUc8iUQGF9IInd3VAOEPUT
         WjWOQyYTdqtu2DqKREM/1OZTsZWeM3gVcSTCsw92YJuC7fgUmj5ZaoUoB5L6rr2XpPVp
         jhgxiipeBWSE2KIxN0youkKvbKfeewPT3yo9x4V3jsATYfGV/7qYUnURpysOOHfk8g9e
         4uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+r/dPqbzqLZgGMdUBdXFU/WPqHd1cGIgABAmt0Dvlo=;
        b=QvppUWVE1DN6BYkVY1WqmME4V78KEqJp9hOXaMLnZyLZFulHsoWG9t5IB1NnLyMDrZ
         t18i6yER1kqpYD2FekPFzdLJ8KkkPU4hk3Pw4TNYvQ1ybn0oigCJNk1rVL4loTvIda8+
         uCSnWEyLWst2Rd2Ry6/dTvXup+EJY8HIbi+zDLDomvcr4hyAVpNO3sO6kxNvZBvXhebt
         G6wynDGt5aHlGaVCZ7Bt7hrBAjAm1edENUc/r+yOUsiuuVD0Jywv7Uh7EsHGAOa4A3gf
         iiucCuzRJl0qdnORxUSVBG2XD0NcIVhv9IpTVxTH5j8Y3f/9nJGS5oKhsNVe3MCVk7fc
         sn8Q==
X-Gm-Message-State: AOAM532zUNQtNkBtO5xSI/laW918PGu/O+un7jgmbEf+TBY8gd59R9Za
        2y7fQYNUJtdT+wqj31Ck0atbU+28HUx/ko+LoRX8Hg==
X-Google-Smtp-Source: ABdhPJz5sk+8mrpiVJwpfQJJfLGN1y7X0ryA389G2TdXuKM8sPBNOqsF99oameI0mbSWpVXVORL2hdGuXyWo8v/P37E=
X-Received: by 2002:a63:5153:: with SMTP id r19mr2005408pgl.130.1604576122878;
 Thu, 05 Nov 2020 03:35:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com> <5e3c76cac4b161fe39e3fc8ace614400bc2fb5b1.1604531793.git.andreyknvl@google.com>
 <58aae616-f1be-d626-de16-af48cc2512b0@arm.com>
In-Reply-To: <58aae616-f1be-d626-de16-af48cc2512b0@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 12:35:11 +0100
Message-ID: <CAAeHK+yfQJbHLP0ja=_qnEugyrtQFMgRyw3Z1ZOeu=NVPNCFgg@mail.gmail.com>
Subject: Re: [PATCH v8 30/43] arm64: kasan: Allow enabling in-kernel MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 12:13 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 11/4/20 11:18 PM, Andrey Konovalov wrote:
> > Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
> > feature and requires it to be enabled. MTE supports
> >
> > This patch adds a new mte_init_tags() helper, that enables MTE in
> > Synchronous mode in EL1 and is intended to be called from KASAN runtime
> > during initialization.
> >
> > The Tag Checking operation causes a synchronous data abort as
> > a consequence of a tag check fault when MTE is configured in
> > synchronous mode.
> >
> > As part of this change enable match-all tag for EL1 to allow the
> > kernel to access user pages without faulting. This is required because
> > the kernel does not have knowledge of the tags set by the user in a
> > page.
> >
> > Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
> > similar way as TCF0 affects EL0.
> >
> > MTE that is built on top of the Top Byte Ignore (TBI) feature hence we
> > enable it as part of this patch as well.
> >
>
> seems that in this patch you dropped me as author. Would you mind to clarify the
> reason?

Sorry, a mistake while squashing/rebasing, will fix in the next version.

>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> > Change-Id: I4d67497268bb7f0c2fc5dcacefa1e273df4af71d
> > ---
> >  arch/arm64/include/asm/mte-kasan.h |  6 ++++++
> >  arch/arm64/kernel/mte.c            |  7 +++++++
> >  arch/arm64/mm/proc.S               | 23 ++++++++++++++++++++---
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> > index 3a70fb1807fd..ae75feaea2d4 100644
> > --- a/arch/arm64/include/asm/mte-kasan.h
> > +++ b/arch/arm64/include/asm/mte-kasan.h
> > @@ -29,6 +29,8 @@ u8 mte_get_mem_tag(void *addr);
> >  u8 mte_get_random_tag(void);
> >  void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> >
> > +void __init mte_init_tags(u64 max_tag);
> > +
> >  #else /* CONFIG_ARM64_MTE */
> >
> >  static inline u8 mte_get_ptr_tag(void *ptr)
> > @@ -49,6 +51,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >       return addr;
> >  }
> >
> > +static inline void mte_init_tags(u64 max_tag)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_ARM64_MTE */
> >
> >  #endif /* __ASSEMBLY__ */
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index 06ba6c923ab7..fcfbefcc3174 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -121,6 +121,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >       return ptr;
> >  }
> >
> > +void __init mte_init_tags(u64 max_tag)
> > +{
> > +     /* Enable MTE Sync Mode for EL1. */
> > +     sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> > +     isb();
>
> I am fine with the approach of letting cpu_enable_mte() call directly
> kasan_init_tags(), but how does it work of the other 2 implementation of KASAN?
> Is it still called in arch_setup()?

Yes, the other 2 modes are initialized in setup_arch().

> I would prefer to keep the code that initializes the sync mode in
> cpu_enable_mte() (calling kasan_init_tags() before then that)

This won't work, we'll later need to make the decision about whether
to turn on MTE at all in KASAN runtime based on KASAN boot flags.

> or in a separate
> function since setting the mode has nothing to do with initializing the tags.

This will work. Any preference on the name of this function?

Alternatively we can rename mte_init_tags() to something else and let
it handle both RRND and sync/async.

Thanks!
