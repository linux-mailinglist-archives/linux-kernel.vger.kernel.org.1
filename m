Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF7277B21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIXVgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIXVgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:36:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:36:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so806863pfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvSPAHOajbMQLOM6/h2D7KmM/xxmcFLZr4eiztRedpU=;
        b=WKIXJIcJm5TZgP1Os/fruX0TlaPAO5NQr7vZmvylXA6627JbLbHkwnb6AohgYSlEHQ
         LXap3g04t7LbrQzM1WxxEEdO67DKKpI5WjwGn3+Cp+WQPRAP/cx3zQeO1t7Q9nNzRiXK
         C5MZChdKXpWH7ZqwUL+IkWSZ5QMHMDv0vpx5+H9fBVaMfC2BA8SP/qIJOjNDUj14qm1M
         LSNRqnu1+QxwCu+lh5X7eaQ1d5cy9DRr2qdDEuwgr3WwA5Bl1BBXEr+oh+4lq1N2ufvn
         8ebnzC3wJ5Ee0BbucT26u18EOyct4TAZDoPa3xH+5S2xSWKIB9dKg/by/hXD/4+UhFcU
         Ez0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvSPAHOajbMQLOM6/h2D7KmM/xxmcFLZr4eiztRedpU=;
        b=m3fmrrmh5528Jz8Bj8uem3o0rOQNgoMqabnVIrWKOF/xR4hjs6cW9Xfo9+pJ1SB6F6
         eH7KXywes2rLgInVIayCVbvmQTF5cQ+0MvzRPZA1SR4Te/y1hclIxB+X7hFeAu0o6Dyp
         Q8kjpcJbVsS5bL2XYhRE7sefmNq8fdRMOO3m21+HGQ0ogvmhKNBe2Bkoyd8jqHB3uUeJ
         fZN9JFc6aegNvWcusVZCWTs+cLVZoHQwsfB5HMsHKS+tpHpcggrrTA4ca/4lgYSfuXcB
         t6f2zCw1yZbmnDHiQEpqCpyM18KGTXtgDnKG8nwaQ5B4v8Vx6YlKClStkRmNVBaz42zi
         f7Ng==
X-Gm-Message-State: AOAM531dX6iLOZVSg/MKHPyAEbpO2M0GS6IB2wSxWQmZkwobfL34rafm
        lLK7c9Ou+LvAcrpzpyjnPZAxRtSpxV7FZKN4eQXq4A==
X-Google-Smtp-Source: ABdhPJxStqN7EjHISyFjmOsHS2y1ySXc3npDJaEbipePmIAgVDI+mEZ3RLhDZemqEDngJfk021kqPC6nnuF8e+PunKY=
X-Received: by 2002:a63:5d07:: with SMTP id r7mr871225pgb.440.1600983370451;
 Thu, 24 Sep 2020 14:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <0a35b29d161bf2559d6e16fbd903e49351c7f6b8.1600204505.git.andreyknvl@google.com>
 <20200918105206.GB2384246@elver.google.com> <CAAeHK+wqzZJWWh+u3HaLvSAt=4SxaFT4JUgTqzMYcPNGhBFFBg@mail.gmail.com>
In-Reply-To: <CAAeHK+wqzZJWWh+u3HaLvSAt=4SxaFT4JUgTqzMYcPNGhBFFBg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 24 Sep 2020 23:35:59 +0200
Message-ID: <CAAeHK+yce9oUVG6J6oofjGLqU5gLLx8b22cqF6AgVWXT778g2g@mail.gmail.com>
Subject: Re: [PATCH v2 31/37] kasan, x86, s390: update undef CONFIG_KASAN
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

On Fri, Sep 18, 2020 at 5:07 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Sep 18, 2020 at 12:52 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> > [...]
> > >  arch/s390/boot/string.c         | 1 +
> > >  arch/x86/boot/compressed/misc.h | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
> > > index b11e8108773a..faccb33b462c 100644
> > > --- a/arch/s390/boot/string.c
> > > +++ b/arch/s390/boot/string.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/errno.h>
> > >  #undef CONFIG_KASAN
> > > +#undef CONFIG_KASAN_GENERIC
> >
> > Is CONFIG_KASAN still used to guard instrumented versions of functions?
> >
> > It looks like #undef CONFIG_KASAN is no longer needed -- at least
> > <linux/string.h> no longer mentions it.
>
> I'm pretty sure this is still necessary (something didn't work when I
> forgot to make this change), but I'll check again.

Yes, it still fails, as compressed code provides its own memmove.
