Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB82AFC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgKLBgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgKLAFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:05:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A26C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:05:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so2571136pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIXncWLvf3BJhcwIlL7/HzTlh6QP9c7KA+O5cQg6G3M=;
        b=a9rslGNNyF79v94Kg4Q/UmR2Xmf/bZEGFLn4vd48EBDq+CC8G2JRrpsbNUuHeJVehx
         jimGRp6ErXtI6zqp9GXe7tHGi9GbMzq89KQauoNglSskzAWUuW0MHt7AZ2WpSxbsPl5+
         tPBtVTY42Zt8DxyLlBMdyLvzOFzQeTwzQ6oNMmxkqbn7L8eFqBIE0bUYz7iKYJBiWvOk
         Z52DcVu3U2Z/Dh5yup94zky1g85mDQrh4l67WRMiR0tfsddDwMcWkXs6zgH+SCbZmBxb
         z/IGM+O7cakfJmeAUYqCtMRlbKe90jDKBPM4MV3qNmypw1mXVRuFAOTgWLUGtCgpICq7
         Q57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIXncWLvf3BJhcwIlL7/HzTlh6QP9c7KA+O5cQg6G3M=;
        b=bPphCqpwjoyj9KSIoBE3iM8Vz80JLfPnT0upTVPWxm0vzH4q8IwjFU8Z+oOYAn2khr
         IZl+kswT3nm2B0IXAlLG7CW0z450dX6mi5s662K31blWjzk2dimmNd3s2dMCRCGwmtlQ
         XKVM5uHWo7XCiP4oAzxf+yrSrxtNq3mtAe0nSXm6t1gueKQEQ2Lm96YgPw1bkPR+u3GG
         RjO/i4/f9htfNCF1V4oOcDVsLd0qJ9StDnvcE8Tw66lWDOIwiwwEZkrUR6R3zXfFDk07
         N8UCHP7YesiYPFkKW4CNc3LcWEZG82y20Msp0VHopnLguj0uwUSuaOpa+DHxLOpxQZI2
         otmw==
X-Gm-Message-State: AOAM531nHJB30ei0NRzCSNlyxeno3wYLOIcWZzpXuJX8dmKm5qmjMPEN
        yP87SEHTQSu4k76ono7LJjkA6XmZab4M1McmkOcvrw==
X-Google-Smtp-Source: ABdhPJyY5iBbncGSNeuN2E9vNBsMMt4g0qABGf83cqeejP9fYxXQvlFAsZV4kqoi6HIJ0aXz6AHkP0LkyCe9oKXhBFI=
X-Received: by 2002:a63:1f53:: with SMTP id q19mr24237607pgm.286.1605139541442;
 Wed, 11 Nov 2020 16:05:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
 <CAG_fn=VuM=4axS6ex7_MgCeZ47o+Scon1WuFGStF78T36sHayw@mail.gmail.com>
 <CAAeHK+xq2tuVYGOPx=_uj08Xwa_1o9Wv-ODrgN3yWXxAgEGV3w@mail.gmail.com> <CANpmjNPkUJreN0YRSWB743L-nrJvMObdKXdL_b9pBAK7AaLGVQ@mail.gmail.com>
In-Reply-To: <CANpmjNPkUJreN0YRSWB743L-nrJvMObdKXdL_b9pBAK7AaLGVQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 01:05:30 +0100
Message-ID: <CAAeHK+yf11KvZWkL1HCrxFT0R4VWH+Bz8YtnOYW7k6vm5c_h=A@mail.gmail.com>
Subject: Re: [PATCH v9 10/44] kasan: define KASAN_GRANULE_PAGE
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Wed, Nov 11, 2020 at 8:05 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 11 Nov 2020 at 19:48, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 3:13 PM Alexander Potapenko <glider@google.com> wrote:
> > >
> > > On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
> > > > the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN code
> > > > to simplify it.
> > >
> > > What's the physical sense behind KASAN_GRANULE_PAGE? Is it something
> > > more than just a product of two constants?
> >
> > No, just a product.
> >
> > > The name suggests it might be something page-sized, but in reality it is not.
> >
> > What name would you prefer?
>
> Is it actually KASAN_GRANULES_PER_SHADOW_PAGE ?   AFAIK we're trying
> to calculate the granules that we can fit into a page of shadow
> memory.

Not exactly, it's the amount of memory, not the number of granules.

Will name it KASAN_MEMORY_PER_SHADOW_PAGE in v10.
