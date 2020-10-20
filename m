Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876FA29344F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 07:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbgJTFez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 01:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbgJTFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:34:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ECDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:34:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so568230qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s42cP9f/U3GYa0s71Z6i/ug0NaSJrPca2FKEkcjzEig=;
        b=lSWQdfR8gb//jvhTXD7ptWiD8DJJy+QjL933HmhsYV5USe+0wW1O06ws9f29EgM4qL
         dXTXghMazo5HR5hrNNZN0QWad7fuv72ijxZHgGM4dhb94NpKt5BG+UDw9dxDPm5isHbK
         VzWtr8QDDpaeXy1lNNL4aUltU0UEbqzZliXwaJmphUu/0jLamQtspESFhrUD3zPkGlFk
         7cKt2+0fes/lHWCcEVHjigO/OxF/2686l62/e9GcR3cjXVrMgDBwfIIVJ6uZAUeEadRg
         1icRhPP7aCKcIkcd6JlHEEsxQjcpF6+wjzjTcuremLItAP6IkJOKWRwmFP8Raik0rnnU
         gOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s42cP9f/U3GYa0s71Z6i/ug0NaSJrPca2FKEkcjzEig=;
        b=jVRmO5u6Dvf0P0Zju1LATg0IWsqul0Jvk3KKolPieZBeKqiDyGrjD4XARU8NzPdyob
         Jaw14CyoNLKQHOcndTcvHLH1a/3qIWBcn3ymNApdYP898sWv2TYbRtz89+IlcJqCBMJ5
         XTCPfdM7EGBoLIVgyASWpFiOFDlrMOOu+U1+NDGSFmLZqyCpNZQCZ+06dy0+J35kKg8N
         HHp0DfyYZ/vrgRHRy1E4/8ClnyqkkezHM3aGBxAmNagZak30x8ELibg86Qc0V/t+aeiJ
         5iGihicWcZ0fKmMltZ/2/mApy9Qe9YluWWCEawpfrd+am27v7rr1GExbsKUqFdrV7ME5
         C4Jg==
X-Gm-Message-State: AOAM531We4d0SSrZzcwiWbJtp6eg759vz6WfMAH/OYe+yZZ/OSHjIzhm
        VDGfPGXTWGF9qfPbeh7koSUp34HxySjhuOd2YJYVRw==
X-Google-Smtp-Source: ABdhPJxM6S0zXSmPa4/to/wlbV3NpOmdBumwfTp0AnsNgLnkahAjzxKwoC9YKJyhHRzuqbhFDQbCn/SvoNJd4p45X6c=
X-Received: by 2002:a05:620a:1657:: with SMTP id c23mr1269155qko.231.1603172094152;
 Mon, 19 Oct 2020 22:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
 <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
 <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com>
 <CAAeHK+yuUJFbQBCPyp7S+hVMzBM0m=tgrWLMCskELF6SXHXimw@mail.gmail.com> <CAN=P9pjxptTQyvZQg7Z9XA50kFfRBc=E3iaK-KR14Fqay7Xo-Q@mail.gmail.com>
In-Reply-To: <CAN=P9pjxptTQyvZQg7Z9XA50kFfRBc=E3iaK-KR14Fqay7Xo-Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Oct 2020 07:34:42 +0200
Message-ID: <CACT4Y+aw+TwUXkuVsQcSOGTDrMFoWnM-58TvCFfvVSnp6ZP5Sw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Kostya Serebryany <kcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Tue, Oct 20, 2020 at 12:51 AM Kostya Serebryany <kcc@google.com> wrote:
>
> Hi,
> I would like to hear opinions from others in CC on these choices:
> * Production use of In-kernel MTE should be based on stripped-down
> KASAN, or implemented independently?

Andrey, what are the fundamental consequences of basing MTE on KASAN?
I would assume that there are none as we can change KASAN code and
special case some code paths as necessary.

> * Should we aim at a single boot-time flag (with several values) or
> for several independent flags (OFF/SYNC/ASYNC, Stack traces on/off)

We won't be able to answer this question for several years until we
have actual hardware/users...
It's definitely safer to aim at multiple options. I would reuse the fs
opt parsing code as we seem to have lots of potential things to
configure so that we can do:
kasan_options=quarantine=off,fault=panic,trap=async

I am also always confused by the term "debug" when configuring the
kernel. In some cases it's for debugging of the subsystem (for
developers of KASAN), in some cases it adds additional checks to catch
misuses of the subsystem. in some - it just adds more debugging output
on console. And in this case it's actually neither of these. But I am
not sure what's a better name ("full"?). Even if we split options into
multiple, we still can have some kind of presents that just flip all
other options into reasonable values.



> Andrey, please give us some idea of the CPU and RAM overheads other
> than those coming from MTE
> * stack trace collection and storage
> * adding redzones to every allocation - not strictly needed for MTE,
> but convenient to store the stack trace IDs.
>
> Andrey: with production MTE we should not be using quarantine, which
> means storing the stack trace IDs
> in the deallocated memory doesn't provide good report quality.
> We may need to consider another approach, e.g. the one used in HWASAN
> (separate ring buffer, per thread or per core)
>
> --kcc
>
>
> On Fri, Oct 16, 2020 at 8:52 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 3:31 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Fri, 16 Oct 2020 at 15:17, 'Andrey Konovalov' via kasan-dev
> > > <kasan-dev@googlegroups.com> wrote:
> > > [...]
> > > > > > The intention with this kind of a high level switch is to hide the
> > > > > > implementation details. Arguably, we could add multiple switches that allow
> > > > > > to separately control each KASAN or MTE feature, but I'm not sure there's
> > > > > > much value in that.
> > > > > >
> > > > > > Does this make sense? Any preference regarding the name of the parameter
> > > > > > and its values?
> > > > >
> > > > > KASAN itself used to be a debugging tool only. So introducing an "on"
> > > > > mode which no longer follows this convention may be confusing.
> > > >
> > > > Yeah, perhaps "on" is not the best name here.
> > > >
> > > > > Instead, maybe the following might be less confusing:
> > > > >
> > > > > "full" - current "debug", normal KASAN, all debugging help available.
> > > > > "opt" - current "on", optimized mode for production.
> > > >
> > > > How about "prod" here?
> > >
> > > SGTM.
> > >
> > > [...]
> > > >
> > > > > > Should we somehow control whether to panic the kernel on a tag fault?
> > > > > > Another boot time parameter perhaps?
> > > > >
> > > > > It already respects panic_on_warn, correct?
> > > >
> > > > Yes, but Android is unlikely to enable panic_on_warn as they have
> > > > warnings happening all over. AFAIR Pixel 3/4 kernels actually have a
> > > > custom patch that enables kernel panic for KASAN crashes specifically
> > > > (even though they don't obviously use KASAN in production), and I
> > > > think it's better to provide a similar facility upstream. Maybe call
> > > > it panic_on_kasan or something?
> > >
> > > Best would be if kasan= can take another option, e.g.
> > > "kasan=prod,panic". I think you can change the strcmp() to a
> > > str_has_prefix() for the checks for full/prod/on/off, and then check
> > > if what comes after it is ",panic".
> > >
> > > Thanks,
> > > -- Marco
> >
> > CC Kostya and Serban.
