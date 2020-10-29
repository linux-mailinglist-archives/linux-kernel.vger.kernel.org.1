Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E450829F5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgJ2UIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgJ2UIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:08:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825FBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:08:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so1840220plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwhYoZVEeWiw6d4kbJoanMt/eIpVSVu/ys3QblYHUt8=;
        b=XOFsBugQ8NPh9yAw9sVOsm+xOUaQYc4EbGzpW5U9ZMDCjhRJ72jkGNiiacd7NSOWBR
         vaCtfdNWElnY/TPJh1DrtaK1isT4G6vMsD2BwIJtaLerNi+kELzJEUczN2pW6f4PhgGy
         jjNWpybzDtKRFL7b2YCUNKkWGUu3DnvSXVeI0UaoD9LZqcSc/WLH1Kxgr41Ll+alX2Uj
         iV3hAOHdziH1SCJD0DniILjxMkmMPjnDmyhylPwLZ8JfxEj0lRtLcMsjrWYL/hbvl5cA
         EDHcwbFLStK8qQJ4/8+zmkGgeGdHXxXdCiD/fn2nUKHqOSSmD7jgjq/+HTmvg2Ho6Sed
         KvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwhYoZVEeWiw6d4kbJoanMt/eIpVSVu/ys3QblYHUt8=;
        b=c0FVOx0iWzi/GNKwJGxkNALpVza02mSQUJX6AqYGMqAa1I9ZPdGIFpGRARXENdH7GD
         Tj8Q9ubZ/sh7DCjtf47fOpljII+sAb6QKL8Ce+8ms6FLCCnD3+zrYY1UIAQbCt1Pr34z
         QXc6IfBsDhNbRXK9+C9O2mYcXxHfQnqH2hk4O5OsKjRsTI4eG7APIPtv0z4MO1uQ6J0r
         oCR40nUnFCh/BCyeAiJsCdvxSalGID/SH3rympddIBlZcL/sRyYM/No0Vb6qbUOu1p+0
         kyRYuUi+QzbQBZf4hhb0jfJiz/8XN3BQ9cXcqG8LtYAkjaSb5hNq8ebG+oG6fheA5CMl
         822A==
X-Gm-Message-State: AOAM533RmHdsKCPtlRWKBkTOuAICczhm6gNjsQcCfwpA479wDSWUGfgb
        aw/vNHt5QWGBqrgSRXumMqD5KbR4BByj5BA8Wnl2CA==
X-Google-Smtp-Source: ABdhPJxKX9N71ehxVcqJTRXl8WjS6rZjWopwVk+GFttkHHJ0ggZmkDNHEBiLNEw9Gs9wLJNFfpfy+FpU5U6QHVQrJRE=
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id
 f19-20020a170902e993b02900d641d89ca3mr5974561plb.57.1604002120836; Thu, 29
 Oct 2020 13:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Z9iE2u1g9Yg=y2TPuRaYVq3TQoJ-81cYzODso_3aJcGg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z9iE2u1g9Yg=y2TPuRaYVq3TQoJ-81cYzODso_3aJcGg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 21:08:30 +0100
Message-ID: <CAAeHK+x2URu8hGNyut_TnG-b_N5rt26CwAPHmyTc6OczAnFs4Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/21] kasan: mark kasan_init_tags as __init
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:08 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM 'Andrey Konovalov' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Similarly to kasan_init() mark kasan_init_tags() as __init.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> init_tags itself is not __init, but that's added in a different patch.
> I've commented on that patch.

Will add that change to this patch, thanks! If we combine the two
patch series, we can move this into the other one later. Thanks!

>
> > ---
> >  include/linux/kasan.h | 2 +-
> >  mm/kasan/hw_tags.c    | 2 +-
> >  mm/kasan/sw_tags.c    | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 7be9fb9146ac..93d9834b7122 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
> >
> >  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >
> > -void kasan_init_tags(void);
> > +void __init kasan_init_tags(void);
> >
> >  void *kasan_reset_tag(const void *addr);
> >
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 2a38885014e3..0128062320d5 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -15,7 +15,7 @@
> >
> >  #include "kasan.h"
> >
> > -void kasan_init_tags(void)
> > +void __init kasan_init_tags(void)
> >  {
> >         init_tags(KASAN_TAG_MAX);
> >  }
> > diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> > index c10863a45775..bf1422282bb5 100644
> > --- a/mm/kasan/sw_tags.c
> > +++ b/mm/kasan/sw_tags.c
> > @@ -35,7 +35,7 @@
> >
> >  static DEFINE_PER_CPU(u32, prng_state);
> >
> > -void kasan_init_tags(void)
> > +void __init kasan_init_tags(void)
> >  {
> >         int cpu;
> >
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl%40google.com.
