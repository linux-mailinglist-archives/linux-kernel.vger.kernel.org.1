Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3C278652
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgIYLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgIYLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:53:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:53:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x16so1566265pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1oOkyfsqFH1LfQrqPkW7aNFfIeXKev/R5cazxL0aFM=;
        b=VNgZuBxUpAgJ8TImvaNn2mHkfg9QdQXl830VbRYRx2TXZC7HlzA0A11WFHU3nH9AYz
         Cc3KAsNx7MblsfZCJ+9RFgyH70bkLziaw2lR6NWTlmwozfDYdjaeNUEUuZyIE03fWCqL
         F9JjA5ryhGFZPYkXihGXzaKj4V1T2+Y1T8x2uZrBAm/SkvIVkUDUiRWOkOBSfCT8f0hU
         H/+Kr/rWddToxWq705+hpL4PrXmXFwpIcx+bZJ4xlYWWAv6eV7UR8xg7h/OV3I9GRNQa
         zVnpLvCcENqK5uXej0r63VuhHMzJH5wI6CKS+QceAoxK+raeyg9olUJUF1HPGKpkwH77
         7x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1oOkyfsqFH1LfQrqPkW7aNFfIeXKev/R5cazxL0aFM=;
        b=rrUaL5sCtLouPU7Bs6ft/xM6bs6/cxbt68cbjJEFl4dV/TCrln9vzY86iCQcAYxuaK
         ky79NkoYgIpvbA5+k68DCjxSYUc6tqKR23s7RtjAePFRx8iHmDYlGfdAH0G3SiSxk4KG
         8J/xTZUkAlYj+ivLfv4qyBKTamZGLKDFFAUK8tixUxmdJTkijfo6dDlgDGLwlJG20NCI
         zxAiRbUWWVfScy1fVdowYInNwNf3aLYIe4EfUl+KNn20Q/HhYDBNYgCB8sitJqMV1l8e
         7hKFa5mxcDHZasbxx2xqfvBkEu5Y0ANxlOnlsefK/BYgEe4VlMexDMlzrKVV8yawqxhq
         1VLQ==
X-Gm-Message-State: AOAM533bcaPf6vaOIOV4jEHhhtlDHzBuzenW6hVAuVZfgqVF8gYP6s3h
        C8RAe6JfBJrU2NhGGtmTJJDQqX8Ya4Abgv3X3s0jCg==
X-Google-Smtp-Source: ABdhPJx0QjhXx2O6yAB1JFuqfI8C4Gskzovi86WJ/DlXN39Y17g2CJxltdIp9/zADsheICMyr2n9j8vzcXCPG7woAGM=
X-Received: by 2002:a17:902:b117:b029:d1:e5e7:bdf5 with SMTP id
 q23-20020a170902b117b02900d1e5e7bdf5mr3803333plr.85.1601034787254; Fri, 25
 Sep 2020 04:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com> <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
 <20200925104933.GD4846@gaia> <CAAeHK+zLFRgR9eiLNyn7-iqbXJe6HGYpHYbBXXOVqOk4MyrhAA@mail.gmail.com>
 <20200925114703.GI4846@gaia>
In-Reply-To: <20200925114703.GI4846@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 25 Sep 2020 13:52:56 +0200
Message-ID: <CAAeHK+x=bchXN4DDui2Gfr_yNW4+9idc_3nQAyjRTwMN6UuvHg@mail.gmail.com>
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

On Fri, Sep 25, 2020 at 1:47 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Sep 25, 2020 at 01:26:02PM +0200, Andrey Konovalov wrote:
> > On Fri, Sep 25, 2020 at 12:49 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > index a3bd189602df..d110f382dacf 100644
> > > > --- a/arch/arm64/mm/fault.c
> > > > +++ b/arch/arm64/mm/fault.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <asm/debug-monitors.h>
> > > >  #include <asm/esr.h>
> > > >  #include <asm/kprobes.h>
> > > > +#include <asm/mte.h>
> > > >  #include <asm/processor.h>
> > > >  #include <asm/sysreg.h>
> > > >  #include <asm/system_misc.h>
> > > > @@ -294,6 +295,11 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> > > >       do_exit(SIGKILL);
> > > >  }
> > > >
> > > > +static void report_tag_fault(unsigned long addr, unsigned int esr,
> > > > +                          struct pt_regs *regs)
> > > > +{
> > > > +}
> > >
> > > Do we need to introduce report_tag_fault() in this patch? It's fine but
> > > add a note in the commit log that it will be populated in a subsequent
> > > patch.
> >
> > I did, see the last line of the commit description.
>
> Sorry, I missed that.

No problem!

> > > > +
> > > >  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> > > >                             struct pt_regs *regs)
> > > >  {
> > > > @@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static void do_tag_recovery(unsigned long addr, unsigned int esr,
> > > > +                        struct pt_regs *regs)
> > > > +{
> > > > +     static bool reported = false;
> > > > +
> > > > +     if (!READ_ONCE(reported)) {
> > > > +             report_tag_fault(addr, esr, regs);
> > > > +             WRITE_ONCE(reported, true);
> > > > +     }
> > >
> > > I don't mind the READ_ONCE/WRITE_ONCE here but not sure what they help
> > > with.
> >
> > The fault can happen on multiple cores at the same time, right? In
> > that case without READ/WRITE_ONCE() we'll have a data-race here.
>
> READ/WRITE_ONCE won't magically solve such races. If two CPUs enter
> simultaneously in do_tag_recovery(), they'd both read 'reported' as
> false and both print the fault info.

They won't solve the race condition, but they will solve the data
race. I guess here we don't really care about the race condition, as
printing a tag fault twice is OK. But having a data race here will
lead to KCSAN reports, although won't probably break anything in
practice.

> If you really care about this race, you need to atomically both read and
> update the variable with an xchg() or cmpxchg().
