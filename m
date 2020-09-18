Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4629270048
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIRO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgIRO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:56:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A821C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:56:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so3302578pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPppQo1Knuq6bNt9Dk0KPBwC7NFNhQQ/T4+rrskH/0M=;
        b=UpKAXNLbKR/gLEzv1N/o8R1oae37pRxnVIb+/wF9aSLtEfFTe08YJs2c/eMEnyGMKP
         k8mXfqcJgEWeB/rotkIyM4Lfv8/HmB/7q5xpkKw3+2BdOjHc2qsElK8jxQIfDM4DBeof
         kzqYKQF6bmsMAigKgAXRNeggnJkFcqxw3ACgnrrquJQQ+ZL0ezLY44tAcNkaDgwXHXhk
         uvtmHnRvAdmaEzgvMGBgmChHO4FdacRj8KfDDOJBtfgv1bcj96vuOVxH33UUD4lY4SsE
         28CaoUQ3vaqryubL5Jxfaf4V+/qXqlcrndOenAUxvFkA/j9qcVaLW99/AyCnuZqwoYBs
         M+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPppQo1Knuq6bNt9Dk0KPBwC7NFNhQQ/T4+rrskH/0M=;
        b=ij1jtFEbM6FjbOo40mQvdl/uz1rzVsQ4EjWoTjMuq5O833pIFrsmop7h+HK9Z82dqJ
         Oh3GaD1+UFgoTrb0ANLrPcBXdjb6UUQQOzgoGi1UMei4uslqCWQYyTnt9NJOkrHbULdN
         LjGMVaYzOozoXwp9Ehf+V17szrioRjzkZj02ns00m748edb4j+5T+EKjncnoX8dAMOCA
         0H7F6wChwJ732SJvz0c+G/CBm3+L4AARn/wXRlDiSbPDLK0GdDYikHfXQsfdtdEcTX27
         OwUhz4ScxictlhGfhoCeulS5aRpUb+1QCJQgw+WcZda8+45g0OgdtWQmLuMzLyR497Hu
         PVkA==
X-Gm-Message-State: AOAM533RoMEBscgNwY8QKzklIlIqYJw4HrwW6xilZJ/5okSQqICyLJqr
        T7VdGMrqIi/HpUw5S8JyljmXDmvkWoEbn6coqszNoA==
X-Google-Smtp-Source: ABdhPJzTCVbQjKWCWzmwvQlbcF7xCiKysY7++hSlpO780ijsSg6AOHdCNquk7KXlEL1paRECsgpFnOpNdM3wVtiGglI=
X-Received: by 2002:a17:902:b117:b029:d1:e5e7:bdf5 with SMTP id
 q23-20020a170902b117b02900d1e5e7bdf5mr15057635plr.85.1600440984513; Fri, 18
 Sep 2020 07:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <b52bdc9fc7fd11bf3e0003c96855bb4c191cc4fa.1600204505.git.andreyknvl@google.com>
 <20200918130037.GE2384246@elver.google.com>
In-Reply-To: <20200918130037.GE2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 16:56:13 +0200
Message-ID: <CAAeHK+yk6i0QUPZCw-582iX-HeifwNyMiVYsj5HLySuHvv5GVA@mail.gmail.com>
Subject: Re: [PATCH v2 23/37] arm64: kasan: Add arch layer for memory tagging helpers
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 3:00 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > This patch add a set of arch_*() memory tagging helpers currently only
> > defined for arm64 when hardware tag-based KASAN is enabled. These helpers
> > will be used by KASAN runtime to implement the hardware tag-based mode.
> >
> > The arch-level indirection level is introduced to simplify adding hardware
> > tag-based KASAN support for other architectures in the future by defining
> > the appropriate arch_*() macros.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Change-Id: I42b0795a28067872f8308e00c6f0195bca435c2a
> > ---
> >  arch/arm64/include/asm/memory.h |  8 ++++++++
> >  mm/kasan/kasan.h                | 19 +++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index e424fc3a68cb..268a3b6cebd2 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -231,6 +231,14 @@ static inline const void *__tag_set(const void *addr, u8 tag)
> >       return (const void *)(__addr | __tag_shifted(tag));
> >  }
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +#define arch_init_tags(max_tag)                      mte_init_tags(max_tag)
> > +#define arch_get_random_tag()                        mte_get_random_tag()
> > +#define arch_get_mem_tag(addr)                       mte_get_mem_tag(addr)
> > +#define arch_set_mem_tag_range(addr, size, tag)      \
> > +                     mte_set_mem_tag_range((addr), (size), (tag))
>
> Suggested edit below, assuming you're fine with checkpatch.pl's new
> 100col limit:
>
> -#define set_mem_tag_range(addr, size, tag)     \
> -                               arch_set_mem_tag_range((addr), (size), (tag))
> +#define set_mem_tag_range(addr, size, tag)     arch_set_mem_tag_range((addr), (size), (tag))

Will do in v3, thanks!
