Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9B2B0992
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgKLQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgKLQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:09:33 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06684C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:09:33 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n11so6092556ota.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4E3aNnRy7r7yE8tRTHVuCw1bn/xlTevCdbx03WDIkcU=;
        b=Y0UBlSyAlEG5wAC+1573r6LeHcNPeOPXBJvlsLmyJl9ZrfDQ3IqdTddHz8R3N7UXoU
         qmLq5HDGLOKM4IEtPxvDrScYZGgaI+BKDjQJGGjm84TnLbeNgapSHEBTaRZNFCCp5Aap
         wAL+yrrJ6kFzhvo10NSUHrOLnToMOldT/NHE6XgIV4wDhwIC5FbB9LP4onOM93VBu/uQ
         bQG4F7wdsCRjFpXGl3Rd5hyVeYO07FKSpe2MlGq6IDMrVkezWHQ9sZCIjn4v8XrS2FkK
         h7PV5ujjZZoRCcxvQRe4IT3O2pgclMrD8/jHKDW/P7YqMFrA6HX9I+9C7KD3ANd6c0Tv
         4B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4E3aNnRy7r7yE8tRTHVuCw1bn/xlTevCdbx03WDIkcU=;
        b=fz4KXAiP0hVxlfJistqJx8O1BJqBMc2Op73ium9P4mIt0GIoYFAJSgIxn8BPymV10a
         o61u7BQuMcEaut4dRukPhzJ3MChDnFJkO9ye21MjjiIvskhFWC6PGAQGIAlT5WMxZGS6
         8qlYPE5ZT9xHj9geod0GM0hjzy0HM7UgsWFMiOXVLeqvdDH1fqG1uIbQOlKj4NekQ3jr
         5Vj/vBpfw/UFWifHdbZfcH6ISxJh67mTJfdXjN9bTPJfiTiLhvyc44oYKyfSiMNTOULO
         5214JtXri2QwDdyvaeywTY1VhsMHZEooNSU4ntinkmxkLvPMaMp3zHDdRbfvORkEe4xQ
         sOlQ==
X-Gm-Message-State: AOAM532v6pWO/71KyFAhiR1i/9qtwh3rdj+NC3FkKefzCADW/qPMdB6E
        bDgmGZ/R0Zlv62h4MF6uE3tOH+D4fYIyYM9bxlX25g==
X-Google-Smtp-Source: ABdhPJwwPDL+OOchIhN43aJaZdWLSzq3g/4c4+pX3LVmYRLcTq9IHuG5sWKShxGDdJOnfOCGmFfEjElZtmXGKjuL+vM=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr20378820oth.251.1605197370706;
 Thu, 12 Nov 2020 08:09:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <bd6825832c0cb376fc68ad61ffec6d829401ed0e.1605046192.git.andreyknvl@google.com>
 <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com>
In-Reply-To: <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Nov 2020 17:09:18 +0100
Message-ID: <CANpmjNMaDkKBtWF8y22rhc6bFNN0CrXgfGNKXBLPvz3c2wd7rA@mail.gmail.com>
Subject: Re: [PATCH v9 44/44] kselftest/arm64: Check GCR_EL1 after context switch
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Thu, 12 Nov 2020 at 16:59, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > This test is specific to MTE and verifies that the GCR_EL1 register
> > is context switched correctly.
> >
> > It spawn 1024 processes and each process spawns 5 threads. Each thread
>
> Nit: "spawns"
>
>
> > +       srand(time(NULL) ^ (pid << 16) ^ (tid << 16));
> > +
> > +       prctl_tag_mask = rand() % 0xffff;
>
> Nit: if you want values between 0 and 0xffff you probably want to use
> bitwise AND.

Another question would be, is the max here meant to be 0xffff or
0xffff-1. Because, as-is now, it's 0xffff-1. Only one of them has a
trivial conversion to bitwise AND ( x % 2^n == x & (2^n - 1) ).
