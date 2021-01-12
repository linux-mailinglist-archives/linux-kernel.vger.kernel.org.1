Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364752F3B31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436654AbhALTvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392194AbhALTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:51:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7312C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:51:05 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be12so1990041plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCxpZYyPI/Y3trjmBrRTDlsX92cIUAx7GVVWW0wsbxI=;
        b=dl6ZgRi9ij44HXmd2XU7K74XFPFFHQ6YbWi5O5gtBlRtrWztUCSGWdyWd+3qeguTVs
         8tn/vz/z3VLBofexzZYp03t4+c0mFqWJoc0csBZYoKkLJ3JGts4ME74sNY123M7y2rC+
         5B4ek1KX33mZIajq+a7cjKFHJd4QVo2yEg0f6RDZxHLTiYe2d0i0qEQwm2+MkKzDQVi3
         4gLqtT6hY2OeQVnKtwrz+8qv72YHCa9sO7tFhF11ef3YJ6+kevbzCYJLr4SCNt35f7T0
         E0+A2t6syBvdnbQ0mT+VmtGInIGpgWRN+TMo8tve8ta7kbdgSbDLPB+X6Aqee2oDqNAj
         T7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCxpZYyPI/Y3trjmBrRTDlsX92cIUAx7GVVWW0wsbxI=;
        b=o2J1OrP8wvlwkHQyYvSZC1tXGilaMTyDyPNhDzm4YeKaHbavINWcQsub0wiGYBRhBV
         1g+DAsawPIqMbp9Z6sg1ah+xS9Dmo6hzyLbbEQPxfvsQZjJ2sua7twc282WsQ+WETlY1
         nqT9IIhRBn+y6oBlRu2By5OsjIrgenR6Hf4N2n1gwhrqbbTLapltliLrIIgTUzsuAxMs
         XGh55OiiEwhFqaPZVeSCYq9RoeYn2PpuzmKaPeyTqglqld4gOYqNf8v0/Qi38RZ1QncX
         jRnL4PJHcfElJkyZf6no550zINU2rwkZsc6EtmykgxDQES7c08ZWwFGpiNkOvYxqTBkS
         GUVA==
X-Gm-Message-State: AOAM531Gq8BjxKjCQmF6h5bNU4DnClwYWuRWUskADxpQjaz3y5cuPFrf
        mibW2vHo99dxNOw6aEBNsuLpqVh+18pP7B46QKemHg==
X-Google-Smtp-Source: ABdhPJxGJE1yS/s9s+ksrWctiL27QxvN6soZWFglHG4SDVeKOCR+wRpE5ZKzd/h5wic0rNwapIWBKsY2pZ4didhM1DU=
X-Received: by 2002:a17:90a:f683:: with SMTP id cl3mr792157pjb.136.1610481065204;
 Tue, 12 Jan 2021 11:51:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <a37dab02f89ad93cc986a87866da74fb8be1850d.1609871239.git.andreyknvl@google.com>
 <CAG_fn=Uqp6dt5VGF8Dt6FeQzDgcEbVY8fs+5+wyMp2d1Z98sEw@mail.gmail.com>
In-Reply-To: <CAG_fn=Uqp6dt5VGF8Dt6FeQzDgcEbVY8fs+5+wyMp2d1Z98sEw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 20:50:54 +0100
Message-ID: <CAAeHK+yFw5YcR1jAYbE+PSLc0NowCv88mS8kJLspe_RkSjX37w@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 9:18 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > It might not be obvious to the compiler that the expression must be
> > executed between writing and reading to fail_data. In this case, the
> > compiler might reorder or optimize away some of the accesses, and
> > the tests will fail.
>
> Have you seen this happen in practice?

Yes.

> Are these accesses to fail_data that are optimized (in which case we
> could make it volatile)?

Yes. AFAIU compiler doesn't expect expression to change fail_data
fields, no those accesses and checks are optimized away.

> Note that compiler barriers won't probably help against removing
> memory accesses, they only prevent reordering.
>
> > +       barrier();                                              \
> >         expression;                                             \
> > +       barrier();                                              \
>
> The need for barriers is not obvious to the reader, so a comment in
> the code clarifying that would be nice.

Will add a comment in v2, thanks!
