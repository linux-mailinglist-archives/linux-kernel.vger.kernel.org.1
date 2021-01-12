Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F12F3CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436803AbhALVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbhALT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:57:55 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:57:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y8so1984264plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgOj3ewtZHsgYpuiLe3BFwKHrGEWEDXGYzULDKuvxQQ=;
        b=j+uYJ02WLo/yAEwfWyCdG4VHNmT3d87J+yhNRugdeCR3VR74kMt+9flAkqaGRXVoSd
         IWyobA1CBIm8NYdKVJAy0GdW+uGncU041V2g+am/rMSaQ6QKifzmjQsAQ5Mjf+3DfrrB
         WStfn8/6JqwjOY9DRkVD+q2R9XhTU+rO8sTKIuc0SRhVEHYw6lJrR0l7spq5p11wmk1u
         /3N8zSXDBgz7i0sT4bvzeFbzD0rZrtexdCIICbt4dImj+EIwDlRryReYNgc61fobKcYk
         2P1lW3u+KNrjpV/n5z9uA9GIy11EdctesXfeOdFeG6mZM3u7X9cBqQtphBi1aMt0VEHz
         Azwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgOj3ewtZHsgYpuiLe3BFwKHrGEWEDXGYzULDKuvxQQ=;
        b=O6caSd+JnPPmK6aLmtisbD7aDRZyo9J5bkw0eiTcHnmjqbRBX2MzFn51gMujyTujrk
         0+1Xj0OX9vqttOppLxmvhWBKpFN/vLBxDjA+CKEKfXanxVJ04IVD+0Jl6TcEzXTd4fgH
         p62gl+a27mb73WJM+wdK+fbN/33uOJTabHApsLN2K5BJCFhd1ykYk0VkCK5TqTsKfHx7
         KZFTgSqz0+Dj5gPtuLnt/ElyACh+BHhrhjE9F0YvRVKlg1eyTH/6xoOd7VEKiSor/PvR
         P61Cm5wy5F/E/77GQqK3D/zYuxU0F5NV0d6EhcC2VmgN3l9izPaogF+EY/PZNKzSGNSx
         Yh+Q==
X-Gm-Message-State: AOAM530QGS6go5W/wKl7l+MLxLekejy14SxflvZ+IoGGCuR/laCQpAoI
        L+4qW7ISd+2CDvKzwMEmWcZ5E+mjIBSY2TPSq4+Itw==
X-Google-Smtp-Source: ABdhPJxI0QGOzv5kpWUwTH2+9PK5o9lI0ts3/aC2qseS8/cQtBU9A8LRgrhYiNGzhreGwNSlfT3z+6wp8m/08MXvN2k=
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr813985pjb.136.1610481434518;
 Tue, 12 Jan 2021 11:57:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
 <CAG_fn=Uqp6dt5VGF8Dt6FeQzDgcEbVY8fs+5+wyMp2d1Z98sEw@mail.gmail.com> <CAAeHK+yFw5YcR1jAYbE+PSLc0NowCv88mS8kJLspe_RkSjX37w@mail.gmail.com>
In-Reply-To: <CAAeHK+yFw5YcR1jAYbE+PSLc0NowCv88mS8kJLspe_RkSjX37w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 20:57:03 +0100
Message-ID: <CAAeHK+yf4omWg-UHLiy4-6NjWXQs7pe4GyOgQOZnnpkhco1DGw@mail.gmail.com>
Subject: Re: [PATCH 07/11] kasan: add compiler barriers to KUNIT_EXPECT_KASAN_FAIL
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 8:50 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:18 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > It might not be obvious to the compiler that the expression must be
> > > executed between writing and reading to fail_data. In this case, the
> > > compiler might reorder or optimize away some of the accesses, and
> > > the tests will fail.
> >
> > Have you seen this happen in practice?
>
> Yes.
>
> > Are these accesses to fail_data that are optimized (in which case we
> > could make it volatile)?
>
> Yes. AFAIU compiler doesn't expect expression to change fail_data
> fields, no those accesses and checks are optimized away.

Ah, actually no, it reorders the expression and puts it after
fail_data fields checks. That's why I put the barriers.

> > Note that compiler barriers won't probably help against removing
> > memory accesses, they only prevent reordering.

But using WRITE/READ_ONCE() might also be a good idea, as technically
the compiler can optimize away the accesses.
