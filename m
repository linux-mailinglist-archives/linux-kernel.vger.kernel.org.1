Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB091293184
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgJSWva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgJSWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:51:30 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7BCC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:51:28 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u7so858327vsq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5knxhq7CVjdPlgBy3BxP03HOY/V3PzThvC7xXq5gGQ=;
        b=OC0a2zISWY+9Gjsw14nwxC6O3itMVVWDC6aDVg4v2EmgcL/vXSJjZWkYXdUkTzxe8s
         cAD755MZ57dpMc2y810w9hN4HKdd1mPIEaK+Rhyf+6Icpc56uNmVjdhMx8V3t0ikNEmQ
         zD6SoncHRrTsQhuUBeiWz7RbQkYnuCzHoyppqlEH8CyBnjJtw9TvmlzrGNyksOi0PHt1
         JJOXZ2rwGPjrKcgd6x8agmqX6Ta3X73gLTKwO5nf0H+oyki4Fdli1II52j8lP83hVfh7
         s7+tdQlgbc3hhuzBHJL3dnlCc5OZ9mCCSUM9mgxhzSSB8r/CC/cb6lkT5AVZ16Fc4mBA
         Pfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5knxhq7CVjdPlgBy3BxP03HOY/V3PzThvC7xXq5gGQ=;
        b=enKjkzsgw4pbZCdWosD8cfNOEL3lGDoJCjcPZlxtZ15XvJjn4V1QCAE3qb9TABeh8V
         OtmYyb3dzJYq2fQ37g/7KJAWUEiAcQh8KOEHiAf6paZk2oa+fCX1igBtda7rEQb+ayjV
         zY4NIkCqBc63MsT+YQbkjQeHScYL3ttZbGKxn/RBSmzy2phJ4QtgWQZaoZennSYuv2EE
         Z8Bi1RqyaqF4gC6z12+OoNyTbWsqQcg2bZXeKcQoAYlTjy7GNbOjL4k4c9zGx71CeGce
         sJvXIWptNamIZ6IWo86c3VsXwJ47D4lUVW/89Ru9+6Y++BJ2jQRGXdgXAkA34NT8iQAz
         WWNw==
X-Gm-Message-State: AOAM532aYOBsDf4n0HCzNiVdvMP5jxlZlR1EpcndMbVuqLoR9BtWec82
        /Mojr2Nsrr9oMV3dk3uvWoL5fgp9C+tNJhGkxxSAuw==
X-Google-Smtp-Source: ABdhPJy8KN/9grhnwkimwQACJ6SAuvwZovEjixiYVhsLIag8rk3K/bJAZV1lc/Yt7ptOv+azP1Utu40/QynZ3cYAZgw=
X-Received: by 2002:a67:ff01:: with SMTP id v1mr26767vsp.10.1603147887388;
 Mon, 19 Oct 2020 15:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
 <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
 <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com> <CAAeHK+yuUJFbQBCPyp7S+hVMzBM0m=tgrWLMCskELF6SXHXimw@mail.gmail.com>
In-Reply-To: <CAAeHK+yuUJFbQBCPyp7S+hVMzBM0m=tgrWLMCskELF6SXHXimw@mail.gmail.com>
From:   Kostya Serebryany <kcc@google.com>
Date:   Mon, 19 Oct 2020 15:51:15 -0700
Message-ID: <CAN=P9pjxptTQyvZQg7Z9XA50kFfRBc=E3iaK-KR14Fqay7Xo-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Serban Constantinescu <serbanc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I would like to hear opinions from others in CC on these choices:
* Production use of In-kernel MTE should be based on stripped-down
KASAN, or implemented independently?
* Should we aim at a single boot-time flag (with several values) or
for several independent flags (OFF/SYNC/ASYNC, Stack traces on/off)

Andrey, please give us some idea of the CPU and RAM overheads other
than those coming from MTE
* stack trace collection and storage
* adding redzones to every allocation - not strictly needed for MTE,
but convenient to store the stack trace IDs.

Andrey: with production MTE we should not be using quarantine, which
means storing the stack trace IDs
in the deallocated memory doesn't provide good report quality.
We may need to consider another approach, e.g. the one used in HWASAN
(separate ring buffer, per thread or per core)

--kcc


On Fri, Oct 16, 2020 at 8:52 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Fri, Oct 16, 2020 at 3:31 PM Marco Elver <elver@google.com> wrote:
> >
> > On Fri, 16 Oct 2020 at 15:17, 'Andrey Konovalov' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > [...]
> > > > > The intention with this kind of a high level switch is to hide the
> > > > > implementation details. Arguably, we could add multiple switches that allow
> > > > > to separately control each KASAN or MTE feature, but I'm not sure there's
> > > > > much value in that.
> > > > >
> > > > > Does this make sense? Any preference regarding the name of the parameter
> > > > > and its values?
> > > >
> > > > KASAN itself used to be a debugging tool only. So introducing an "on"
> > > > mode which no longer follows this convention may be confusing.
> > >
> > > Yeah, perhaps "on" is not the best name here.
> > >
> > > > Instead, maybe the following might be less confusing:
> > > >
> > > > "full" - current "debug", normal KASAN, all debugging help available.
> > > > "opt" - current "on", optimized mode for production.
> > >
> > > How about "prod" here?
> >
> > SGTM.
> >
> > [...]
> > >
> > > > > Should we somehow control whether to panic the kernel on a tag fault?
> > > > > Another boot time parameter perhaps?
> > > >
> > > > It already respects panic_on_warn, correct?
> > >
> > > Yes, but Android is unlikely to enable panic_on_warn as they have
> > > warnings happening all over. AFAIR Pixel 3/4 kernels actually have a
> > > custom patch that enables kernel panic for KASAN crashes specifically
> > > (even though they don't obviously use KASAN in production), and I
> > > think it's better to provide a similar facility upstream. Maybe call
> > > it panic_on_kasan or something?
> >
> > Best would be if kasan= can take another option, e.g.
> > "kasan=prod,panic". I think you can change the strcmp() to a
> > str_has_prefix() for the checks for full/prod/on/off, and then check
> > if what comes after it is ",panic".
> >
> > Thanks,
> > -- Marco
>
> CC Kostya and Serban.
