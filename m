Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE62F7C36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbhAONMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732113AbhAONM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:12:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD65C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:11:49 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so5469926pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6umvCsAyn8LNlLKR4Gh0cZmveVk8fGwHsSK6SRMZEbU=;
        b=SnDXl4aRWGAJQrgks0Grcn4RXlp7beT1MVhlVxEpU3TYCdsLusC3zjvFEdBUuJbxv9
         voc4nnYlVMenWvl4emWLynQg+zP6dbg9orCRq6jch6Xo+bBEqF506NWzvkctVJt5RoXt
         gnC48NAEujee9t3+ov6QKNCwmWWsfv8FKzMu8tM6nwCi2XgYtRdDuycsaKnU+f43+vzN
         l5J0ux4ZYcJL1DWNpDSX+3O5LQiFQqs4O06LVTo9aEBm8GY2jy8s7s1bDiyn4LjH+RVp
         4JR5HOFLoFUtEs9SLWWEeZIQERqV0NJe4sRXdgr05pMjVLS8WRsA/yMk8hhEsR4eQp/5
         /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6umvCsAyn8LNlLKR4Gh0cZmveVk8fGwHsSK6SRMZEbU=;
        b=UjBlZCSWic6DJQmGssDE72GTy4khpZ7IyPpFOkaFJs+holkIZClL8yjAVLPlNPM+ll
         Zkh8Ou2hqF4oDG2hKwv80LPEd/fpcJ5QekOkolFFvNOTA63AycpKQPozrwl9mQbQgCDh
         f78Tubkt2cMuZ9JFYFiNPbGmUIWgVuws4BUfdezGNjZUstntJYCrmBi0X32mo/Agd9Sd
         ehSerEcv2U2JuDib/vBBATBtI3lCj9D8H8O/RnbKsqunEuIJNGMEBQquAPp3L3rNy4sd
         C09pCe5LXcjGgypC+BwrlYUMz5oZas7mqXOmXtFKuv9AVAUu28hXMN6NSjE2TED+hoxw
         dafw==
X-Gm-Message-State: AOAM532VOI6GsYEyxu5gb9O78SNXJpWcKUjzDY4EFCtr01aZ/OTIZZZU
        GByNgEy0BuUZVdw48mPSUQcS4Y98Bx6/WjSRTVV5PA==
X-Google-Smtp-Source: ABdhPJxP4nRrKwZSBlUFpmikVpl6k4pzHnULL/yc60R1uCe8Ns1peu8s87V06K5tB60ue3skQrwX/CMP31Tu2zYjM9o=
X-Received: by 2002:a62:e309:0:b029:1ae:5b4a:3199 with SMTP id
 g9-20020a62e3090000b02901ae5b4a3199mr12292780pfh.24.1610716308705; Fri, 15
 Jan 2021 05:11:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
 <X/3yDGfTJ+ng+GJt@Catalins-MacBook-Air.local>
In-Reply-To: <X/3yDGfTJ+ng+GJt@Catalins-MacBook-Air.local>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 15 Jan 2021 14:11:37 +0100
Message-ID: <CAAeHK+ztACu-tU65a7iFfX+TaQixCUzi2fngypOYuaRhOcUcdg@mail.gmail.com>
Subject: Re: [PATCH 05/11] kasan, arm64: allow using KUnit tests with HW_TAGS mode
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
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

On Tue, Jan 12, 2021 at 8:01 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jan 05, 2021 at 07:27:49PM +0100, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 3c40da479899..57d3f165d907 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -302,12 +302,20 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >  static void report_tag_fault(unsigned long addr, unsigned int esr,
> >                            struct pt_regs *regs)
> >  {
> > -     bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > +     static bool reported;
> > +     bool is_write;
> > +
> > +     if (READ_ONCE(reported))
> > +             return;
> > +
> > +     if (mte_report_once())
> > +             WRITE_ONCE(reported, true);
>
> I guess the assumption here is that you don't get any report before the
> tests start and temporarily set report_once to false. It's probably
> fine, if we get a tag check failure we'd notice in the logs anyway.

Good point. I'll add a note in a comment in v4.

> >       /*
> >        * SAS bits aren't set for all faults reported in EL1, so we can't
> >        * find out access size.
> >        */
> > +     is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
>
> I now noticed, you could write this in a shorter way:
>
>         is_write = !!(esr & ESR_ELx_WNR);
>
> >       kasan_report(addr, 0, is_write, regs->pc);
> >  }

Will do in v4.

> The patch looks fine to me.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
