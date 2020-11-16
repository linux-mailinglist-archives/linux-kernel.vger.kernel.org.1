Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90822B4509
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgKPNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgKPNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:51:00 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4220AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:50:59 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so14145510pfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn/GWbCehAJ+GBDtTEnmHyxU7fKIylPW3sz5YfB6oF4=;
        b=Qd0w7ayRM8p7I/3VxgXVb4Z+J477qPtHJvdhPbVFZ9XwhU7nk+YIXKJu4H/Ta0BwxF
         t9LBldP1K5XDosLSOw3/pnqneWKXcl2MAT7jJwhpfMGCFjCLG8nlIPEqNH5LXJzKdw4r
         hr8XIOrGSHOlI22td39a7HRCgRFjfUeDiIH734cDyKiZ68QevmkYAEuchyFDMAuLKEqZ
         EgO3AZ61AP3smMYLMHfqLFo23PKIeUJ90LOqKZx0qfAplIA9GMZ8oMr+8aX9VJiOh9PE
         bW5TpM7ui3z/vQ8pnShVeYdJ5P+56IgzT4D8odEtpOEZX5GImbBhIvwmx1hwaAFkFwc8
         L4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn/GWbCehAJ+GBDtTEnmHyxU7fKIylPW3sz5YfB6oF4=;
        b=L9vTp7Ma90sK7OPiEYGRZZi3fUFvRNrIWEYX7qdC6KgEpBWQgheZ9hywacAdfEXBJ7
         9PSs5CopWPCrpDNtO7T2euXbgB8d53Vlq1KuP8KYF3YB8+oH5TKczye2MDjU+P8f2ZRu
         LQLzJ9mfiIG4HpFicPlswmHTHogap5MjHioOi5vzCIvzlQyfAEe3iTPUyr+dCL/mtNx1
         6kAuwiQ/Cd6hX7szVGrsCE2FqsnkJgGDCSXl7M5WDu52Zti5m58q+E7h/LJs4tP/Et+F
         pxg2BFMnmmJucyZVGILS6fl4VeEt+IY4FgP74CjHHYHL88G7xZ0xv1UDnPxeLWHA/Zov
         xY9g==
X-Gm-Message-State: AOAM533E80AaM/HM3e4KkpiPoMNMPgNCjxmxX9FXDuwrlnlLLKW0JOUT
        gBiTs+3NWIFadsLtn74tdbMTqigPCWsKxVTmVE50Ow==
X-Google-Smtp-Source: ABdhPJyvNgxXCuDbqJB50x51i5+dENxPWgpyPuR9VhmAxxqRwC1mORwFApTMW9UZQkgyp1z4DmVpwkJSoeiP2hglNho=
X-Received: by 2002:a63:f20:: with SMTP id e32mr12949674pgl.130.1605534658700;
 Mon, 16 Nov 2020 05:50:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
 <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
 <CACT4Y+Z3UCwAY2Mm1KiQMBXVhc2Bobi-YrdiNYtToNgMRjOE4g@mail.gmail.com>
 <CANpmjNPNqHsOfcw7Wh+XQ_pPT1610-+B9By171t7KMS3aB2sBg@mail.gmail.com>
 <X7Jthb9D5Ekq93sS@trantor> <CACT4Y+ZubLBEiGZOVyptB4RPf=3Qr570GN+JBpSmaeEvHWQB5g@mail.gmail.com>
 <9d4156e6-ec4f-a742-a44e-f38bf7fa9ba9@arm.com>
In-Reply-To: <9d4156e6-ec4f-a742-a44e-f38bf7fa9ba9@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Nov 2020 14:50:47 +0100
Message-ID: <CAAeHK+xb4w1XSe_cXeV77d3VkHq6ABAKkKuEaFN-uFVY457-Ww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with CONFIG_KASAN_STACK
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 1:42 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> >>>>
> >>>> Not sure why we did this instead of the following, but okay.
> >>>>
> >>>>  config KASAN_STACK
> >>>> -       int
> >>>> -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> >>>> -       default 0
> >>>> +       bool
> >>>> +       default y if KASAN_STACK_ENABLE || CC_IS_GCC
> >>>> +       default n
> >>>
> >>> I wondered the same, but then looking at scripts/Makefile.kasan I
> >>> think it's because we directly pass it to the compiler:
> >>>     ...
> >>>     $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
> >>>     ...
> >>
> >> Try this instead:
> >>
> >>       $(call cc-param,asan-stack=$(if $(CONFIG_KASAN_STACK),1,0)) \
> >
> >
> > We could have just 1 config instead of 2 as well.
> > For gcc we could do no prompt and default value y, and for clang --
> > prompt and default value n. I think it should do what we need.
> >
>
> I agree with Catalin's proposal since it should simplify things.
>
> Nit: 'default n' is the default hence I do not think it should be required
> explicitly.

Fixing this sounds like a good idea, but perhaps not as a part of this
series, to not overinflate it even further.

I've filed a bug for this: https://bugzilla.kernel.org/show_bug.cgi?id=210221
