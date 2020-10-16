Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA05290656
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408052AbgJPNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407350AbgJPNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:31:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFEC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:31:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l4so2385711ota.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QuvgoP2s4jo0WikDSiJUcCamsSLK3zQlawt0pcsDSM=;
        b=oiLCg7IWLPKTDjRDQoDjtRyiP6dOyUfMf63gYkJBbrZYeOmGztsMYRK89juEA0LAQf
         wn6xsgrto6sU+S2CcFYyC2aq3GQUdN3zQKP/mg5v9aLxwRhzLbjWi3s420RCzNavwwt6
         p/8ubQBKte/eIekbVGy5/Zh4DLCLbZWc5xZ4b60dQfJOISBP0kYDnfgZW6+JHkupO5Bz
         2j7SBywfGprciwEW0ObxUYXi9TAj4RTYFaNwDDt2Ys48IeAxwvAGNHFBKFIIX2++dny0
         eu7jNE4Q18C+/J25RC8YNhNhB9NiB8EUrw8GS/KrmGJuRCPr9vNvtFxTe+s1xRQQ1y+5
         /SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QuvgoP2s4jo0WikDSiJUcCamsSLK3zQlawt0pcsDSM=;
        b=nHjP6ncMxmyR2mkzFZB2R9E2VE9q93ZWqZhUMKyKx5dHaWGYfr3Cffm/KaxAgP9o1c
         DLbg9WNly+rKpUhTIaSpR5yfQJh0Hy6X4cPCNt9QL/8Y6XRmhkw7OYjx1wAQNIZgc6aR
         ijM9at2W0jkxz/yorPSOaGV4SibteqeOEjyi9bbRTkl9bh2TMlwHnTsEL7Jcve9uZwJ9
         LdX5WmbM86g38p2hHl5H7QZO5O2ftlNYgHfcoFp20iFp7E1Rmo8gX5EhFcECVfQDYlbS
         6L1oXa5lsd14VYuN1hlCRMGFTfIM3Eg3cuhTbXwe/PXi2hBNzJ73nqc4XUaaXUuRKCKH
         OudQ==
X-Gm-Message-State: AOAM533bIPuiVnMaV7gkhIIox8EWU1ALgQLcHtL21q84EIyLMJyJrrT5
        rZYKq8uMfX2cF6lAEqSC5uht5JdRDTd+5wvwUAhsbw==
X-Google-Smtp-Source: ABdhPJxVF9gMy0Xl/FnPakpeZeakUVi8Ul5mNfn/2LDnWzqC4QF+xITkFCJdipqJKA+DJQvisoUsngHcHbdjk+nodc4=
X-Received: by 2002:a9d:34d:: with SMTP id 71mr2403102otv.251.1602855099909;
 Fri, 16 Oct 2020 06:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
 <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
In-Reply-To: <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Oct 2020 15:31:28 +0200
Message-ID: <CANpmjNPvx4oozqSf9ZXN8FhZia03Y0Ar0twrogkfoxTekHx39A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 15:17, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
[...]
> > > The intention with this kind of a high level switch is to hide the
> > > implementation details. Arguably, we could add multiple switches that allow
> > > to separately control each KASAN or MTE feature, but I'm not sure there's
> > > much value in that.
> > >
> > > Does this make sense? Any preference regarding the name of the parameter
> > > and its values?
> >
> > KASAN itself used to be a debugging tool only. So introducing an "on"
> > mode which no longer follows this convention may be confusing.
>
> Yeah, perhaps "on" is not the best name here.
>
> > Instead, maybe the following might be less confusing:
> >
> > "full" - current "debug", normal KASAN, all debugging help available.
> > "opt" - current "on", optimized mode for production.
>
> How about "prod" here?

SGTM.

[...]
>
> > > Should we somehow control whether to panic the kernel on a tag fault?
> > > Another boot time parameter perhaps?
> >
> > It already respects panic_on_warn, correct?
>
> Yes, but Android is unlikely to enable panic_on_warn as they have
> warnings happening all over. AFAIR Pixel 3/4 kernels actually have a
> custom patch that enables kernel panic for KASAN crashes specifically
> (even though they don't obviously use KASAN in production), and I
> think it's better to provide a similar facility upstream. Maybe call
> it panic_on_kasan or something?

Best would be if kasan= can take another option, e.g.
"kasan=prod,panic". I think you can change the strcmp() to a
str_has_prefix() for the checks for full/prod/on/off, and then check
if what comes after it is ",panic".

Thanks,
-- Marco
