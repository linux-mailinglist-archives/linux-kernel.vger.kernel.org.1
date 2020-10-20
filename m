Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F66293B03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394276AbgJTMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394242AbgJTMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:13:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34705C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:13:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h4so881563pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ozLNOPkf0S7L5SxL6HFc1I8U+KuG7maLq27YKTCUYHs=;
        b=O+WQf8ZsYiZjkr3gEOBjWyzKrfvHEq3aKJ8d9HcKcEKgwvtDihveeQvKbbMu3hjman
         cTw7hCBlJcu7C8gt2qRH5N8XHLT2MUbL5topuaCSg5nblYfgu4CbnZJi0PLHSWSPgJfT
         UlxT6i5qsQRfQZKJ4H/Ez4EU1/Uf+RpAcZB3XGKc2oD5vkwR8eM0fQrTVNHVLawTNxme
         7CuS8TwisSRK08UErg7+VJYhS4zCt8pLRmlNKvqVyDkqFKmAHRd5ioiKgFVuSYd0XRmu
         6TlZz4PKzcnb41ZnSHSmVGq4AWc+xFapaM5UPiYRxWSWSp2ueBdJ8hCV1tFNCmUDrVXK
         3FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ozLNOPkf0S7L5SxL6HFc1I8U+KuG7maLq27YKTCUYHs=;
        b=bO1ohdKZ/bQB5maFwaSaUGeapIpcVAkqb/tLeDj/U5zyvvOtNDe7pnE+OLLXRgMKlh
         N+uepoBJBozH/6iYceP+va2kt99hRSDBSTK78g2m/Wjgf5XtuXWSEs43vYZgcT73klfi
         bEt4X1lc/UIt0+regO4sZlOnAlk3IbYs779hFOIUYHdNGgXmCBOBf6yGkwFUraYJ+G35
         Wtxz+FvmZw+2GWaVWaXsC32YZRUslL2Tq+BZPNdtzKFvNMy4OunUHD7JMZmO/6ipvtPg
         mXrNxrB+EycG3wZu+JTdq8vw/UCnJMPRTHIYICOhzxk9nHaSfHH6qkixn9mtqSO2i3Jp
         nLTw==
X-Gm-Message-State: AOAM531gE3DvdxVNvFpUtMbGohNwPcBprEPhLzUkY0yBUckGLuLxYIRD
        JsFzLo7vwO4ae7ZVUs4icTQpqg6KjtZqYxpUgjnnng==
X-Google-Smtp-Source: ABdhPJzI7/G68CXv/SFIlGYC2SxZYGtX2T5HcmEbZeWUgH77nTI1fOUrf8QB9k6apPyGNTps1PCNymMBytOuOD4dFCw=
X-Received: by 2002:a17:90b:228f:: with SMTP id kx15mr2530393pjb.41.1603195995550;
 Tue, 20 Oct 2020 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
 <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
 <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com>
 <CAAeHK+yuUJFbQBCPyp7S+hVMzBM0m=tgrWLMCskELF6SXHXimw@mail.gmail.com>
 <CAN=P9pjxptTQyvZQg7Z9XA50kFfRBc=E3iaK-KR14Fqay7Xo-Q@mail.gmail.com> <CACT4Y+aw+TwUXkuVsQcSOGTDrMFoWnM-58TvCFfvVSnp6ZP5Sw@mail.gmail.com>
In-Reply-To: <CACT4Y+aw+TwUXkuVsQcSOGTDrMFoWnM-58TvCFfvVSnp6ZP5Sw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 20 Oct 2020 14:13:04 +0200
Message-ID: <CAAeHK+xoShCZB-XPWauVPxct6eBkxHMZtWWpXCFgCHpiws2NXw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>
Cc:     Serban Constantinescu <serbanc@google.com>,
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

On Tue, Oct 20, 2020 at 7:34 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Oct 20, 2020 at 12:51 AM Kostya Serebryany <kcc@google.com> wrote:
> >
> > Hi,
> > I would like to hear opinions from others in CC on these choices:
> > * Production use of In-kernel MTE should be based on stripped-down
> > KASAN, or implemented independently?
>
> Andrey, what are the fundamental consequences of basing MTE on KASAN?
> I would assume that there are none as we can change KASAN code and
> special case some code paths as necessary.

The main consequence is psychological and manifests in inheriting the name :)

But generally you're right. As we can change KASAN code, we can do
whatever we want, like adding fast paths for MTE, etc. If we Ctrl+C
Ctrl+V KASAN common code, we could potentially do some micro
optimizations (like avoiding a couple of checks), but I doubt that
will make any difference.

> > * Should we aim at a single boot-time flag (with several values) or
> > for several independent flags (OFF/SYNC/ASYNC, Stack traces on/off)
>
> We won't be able to answer this question for several years until we
> have actual hardware/users...
> It's definitely safer to aim at multiple options. I would reuse the fs
> opt parsing code as we seem to have lots of potential things to
> configure so that we can do:
> kasan_options=quarantine=off,fault=panic,trap=async
>
> I am also always confused by the term "debug" when configuring the
> kernel. In some cases it's for debugging of the subsystem (for
> developers of KASAN), in some cases it adds additional checks to catch
> misuses of the subsystem. in some - it just adds more debugging output
> on console. And in this case it's actually neither of these. But I am
> not sure what's a better name ("full"?). Even if we split options into
> multiple, we still can have some kind of presents that just flip all
> other options into reasonable values.

OK, let me try to incorporate the feedback I've heard so far into the
next version.

>
> > Andrey, please give us some idea of the CPU and RAM overheads other
> > than those coming from MTE
> > * stack trace collection and storage
> > * adding redzones to every allocation - not strictly needed for MTE,
> > but convenient to store the stack trace IDs.
> >
> > Andrey: with production MTE we should not be using quarantine, which
> > means storing the stack trace IDs
> > in the deallocated memory doesn't provide good report quality.
> > We may need to consider another approach, e.g. the one used in HWASAN
> > (separate ring buffer, per thread or per core)

My current priority is cleaning up the mode where stack traces are
disabled and estimating the slowdown from KASAN callbacks. Once done
with that, I'll switch to these ones.
