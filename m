Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598412785BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIYL0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYL0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:26:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52322C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:26:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so2842294pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxOkTxBUdDygkxQk8SSiZ/3m/eISYyIoxaAPO6Ft/3c=;
        b=AQUMaA2mUShicKX0LRfMzsr/JU4gyntiGkqnwNgVDtq5RxgOdRJLGETYAXd5xTEiha
         bkFx4pWFNuxAM5KWfR8fJ0P3dKruvwdZysZ8dGOlBYOdxgWkSkBUajMVVTCdYXWX10xi
         eAeQ1w5Ke4tzvSKmBMyJHC6GQfKNCKV0QICTJKjT2oLSXH6i34fknlc2pNy973sduyEv
         2O3BeqTW+vZ+wz2SeDFR0nvjpyP+9/av1GJgF05yKru8G5tiGqRqIoRIiAX3cPJ5FDJ0
         c8dgXhECbxM+mL+VNPhxP+d5+SdFSsxiAIZqbeUgjVeQTbCBUIAfYzPGXHDHtk6N+n3X
         wcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxOkTxBUdDygkxQk8SSiZ/3m/eISYyIoxaAPO6Ft/3c=;
        b=P4SBCjVa6veFRzzxLRgIqjuqIbFThQOQK+55azkewRrf4FVZ5RTeSbYqWVpb9fEBJO
         lk+QQHbPiNPmXlPsF0Tod5YxHTXoQ4T8U6qY360mm5Q20n2rZeu9883Pe4t7zNCd5/ot
         D06P86IfhY27LJqOqBdyaHFDJd2tXPQuCbYe+6e3kF5r/ZBQKlG1tCM7qIx/3hDV+f3u
         o2IJW4SM6CP1QjkdYwayyltwsVX/57ZPs+6i+ZTkUGOgmnCyZSFfP5PT4fZ85sub9Zbg
         GruwCjKFEuCi4mXRnNe/bBtZ2dD+X7GnrLt4sz9GkeRfXN+DbFLejd4YxtHIBcyAMLUS
         mOlw==
X-Gm-Message-State: AOAM533vXHMrhMUqGPl6sMYPWGakMz1qa3BZsReoWesj3TXH1z3fEn3/
        t5KX4HnkLzR6jRZAY45tQC9uV++x/w7cu1Gn085eQA==
X-Google-Smtp-Source: ABdhPJwfze/WXqXUgMMG8rf/dj3TrYc3bE53uc/cJm5bp9cbbzOGtFOvfgTZBQCcxs/GOFoexk6G5UC8GjCHrp+FuBY=
X-Received: by 2002:a62:1d51:0:b029:13e:d13d:a0fc with SMTP id
 d78-20020a621d510000b029013ed13da0fcmr3806915pfd.24.1601033173658; Fri, 25
 Sep 2020 04:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
 <20200925104933.GD4846@gaia>
In-Reply-To: <20200925104933.GD4846@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 25 Sep 2020 13:26:02 +0200
Message-ID: <CAAeHK+zLFRgR9eiLNyn7-iqbXJe6HGYpHYbBXXOVqOk4MyrhAA@mail.gmail.com>
Subject: Re: [PATCH v3 26/39] arm64: mte: Add in-kernel tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Fri, Sep 25, 2020 at 12:49 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index a3bd189602df..d110f382dacf 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/debug-monitors.h>
> >  #include <asm/esr.h>
> >  #include <asm/kprobes.h>
> > +#include <asm/mte.h>
> >  #include <asm/processor.h>
> >  #include <asm/sysreg.h>
> >  #include <asm/system_misc.h>
> > @@ -294,6 +295,11 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >       do_exit(SIGKILL);
> >  }
> >
> > +static void report_tag_fault(unsigned long addr, unsigned int esr,
> > +                          struct pt_regs *regs)
> > +{
> > +}
>
> Do we need to introduce report_tag_fault() in this patch? It's fine but
> add a note in the commit log that it will be populated in a subsequent
> patch.

I did, see the last line of the commit description.

> > +
> >  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> >                             struct pt_regs *regs)
> >  {
> > @@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +static void do_tag_recovery(unsigned long addr, unsigned int esr,
> > +                        struct pt_regs *regs)
> > +{
> > +     static bool reported = false;
> > +
> > +     if (!READ_ONCE(reported)) {
> > +             report_tag_fault(addr, esr, regs);
> > +             WRITE_ONCE(reported, true);
> > +     }
>
> I don't mind the READ_ONCE/WRITE_ONCE here but not sure what they help
> with.

The fault can happen on multiple cores at the same time, right? In
that case without READ/WRITE_ONCE() we'll have a data-race here.
