Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE22C2908DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408799AbgJPPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406328AbgJPPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D951C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:52:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h4so1757534pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=571s3sQDBAJDkliF7o6LeQ1FWJNszmME0SBRVCm2JiM=;
        b=iyAo2KZUzj/LDn6ZFkYiu45BJo1ppdpiLdRMB8QctbZlFzkRt9+FYS4/OwxHbehUn2
         qZLecRkAGcVurCFpj3AwynSk0e8iyWpALAfP7Ske/9e2LLYxBhQRgAhxgczpE7ofzXr2
         nibB6sC4bTNjJBPnTBkXigHYvob4uNHerEueF76qg0gp0RtqVK/e5kVLTeIufqX65EPf
         PIwdXS5p2lv6SvcyhEARhTiEnhX4fKYJ1Qq6bzErIXaiDetXf4oQDYjUhGPIuAaULwwx
         wT+WwOWW6INhnwvfaKb4s7bLAtb1VXM+ZaFunxxetlDMKRCFtl14XXOq6oGlH3j6+Gxr
         OTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=571s3sQDBAJDkliF7o6LeQ1FWJNszmME0SBRVCm2JiM=;
        b=VnIy4B0qsXHvSnSsFCIDHIAazWi50o4EBOo5ZOrV1qHqJbPE5MLKPnMsSeVfsBotiq
         uYJMS+P27jI4/7xlpGT+GTC4T8gXvGU6TC0lwKE4XrTqu434qwuq71r7gpPVtDQlm33o
         ZRDhsPiG0d05aEWyeVZrYOKsjVlicraFx4balOAZiADf39T7+iPEQD7YBOnlGksd2sxX
         sDPT/7N28jAvBhrZFMKiZux1pc+vjgPcgIxHStQh46yo68qyRptvHIi7fPont7qsIq3r
         VOpnVOTfFOKjPpFhoIz0RICAgzU/6B4LY8BaauQ488HmXYSl5EeLpGvO8FRqCVbNwvUw
         0f8w==
X-Gm-Message-State: AOAM531qaK/oOpl6i8Qo7RgQq6xnlC2CtqsZZ8ErGH81WWsFj4jl6TRS
        vcXl3OnwzY1FE1N3gd5sx9c2fhaf6vApbOesctv1zg==
X-Google-Smtp-Source: ABdhPJxJesxysHwAqwIXLA6gTLyxc6p37UMDFD2+P+vU71kz7jc7JylNAaTUW5g0O3A4qrZWkpDGOGxtrvrUuilCYNA=
X-Received: by 2002:a17:902:d888:b029:d0:cb2d:f274 with SMTP id
 b8-20020a170902d888b02900d0cb2df274mr4625974plz.13.1602863547567; Fri, 16 Oct
 2020 08:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
In-Reply-To: <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 17:52:16 +0200
Message-ID: <CAAeHK+wo2UE5JqHfui5o08pUPCFZPQTXKeicE+dTjxwj_2euww@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Kostya Serebryany <kcc@google.com>,
        Serban Constantinescu <serbanc@google.com>
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
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 4:41 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
> > This patchset is not complete (see particular TODOs in the last patch),
> > and I haven't performed any benchmarking yet, but I would like to start the
> > discussion now and hear people's opinions regarding the questions mentioned
> > below.
> >
> > === Overview
> >
> > This patchset adopts the existing hardware tag-based KASAN mode [1] for
> > use in production as a memory corruption mitigation. Hardware tag-based
> > KASAN relies on arm64 Memory Tagging Extension (MTE) [2] to perform memory
> > and pointer tagging. Please see [3] and [4] for detailed analysis of how
> > MTE helps to fight memory safety problems.
> >
> > The current plan is reuse CONFIG_KASAN_HW_TAGS for production, but add a
> > boot time switch, that allows to choose between a debugging mode, that
> > includes all KASAN features as they are, and a production mode, that only
> > includes the essentials like tag checking.
> >
> > It is essential that switching between these modes doesn't require
> > rebuilding the kernel with different configs, as this is required by the
> > Android GKI initiative [5].
> >
> > The last patch of this series adds a new boot time parameter called
> > kasan_mode, which can have the following values:
> >
> > - "kasan_mode=on" - only production features
> > - "kasan_mode=debug" - all debug features
> > - "kasan_mode=off" - no checks at all (not implemented yet)
> >
> > Currently outlined differences between "on" and "debug":
> >
> > - "on" doesn't keep track of alloc/free stacks, and therefore doesn't
> >   require the additional memory to store those
> > - "on" uses asyncronous tag checking (not implemented yet)
> >
> > === Questions
> >
> > The intention with this kind of a high level switch is to hide the
> > implementation details. Arguably, we could add multiple switches that allow
> > to separately control each KASAN or MTE feature, but I'm not sure there's
> > much value in that.
> >
> > Does this make sense? Any preference regarding the name of the parameter
> > and its values?
>
> KASAN itself used to be a debugging tool only. So introducing an "on"
> mode which no longer follows this convention may be confusing.
> Instead, maybe the following might be less confusing:
>
> "full" - current "debug", normal KASAN, all debugging help available.
> "opt" - current "on", optimized mode for production.
> "on" - automatic selection => chooses "full" if CONFIG_DEBUG_KERNEL,
> "opt" otherwise.
> "off" - as before.
>
> Also, if there is no other kernel boot parameter named "kasan" yet,
> maybe it could just be "kasan=..." ?
>
> > What should be the default when the parameter is not specified? I would
> > argue that it should be "debug" (for hardware that supports MTE, otherwise
> > "off"), as it's the implied default for all other KASAN modes.
>
> Perhaps we could make this dependent on CONFIG_DEBUG_KERNEL as above.
> I do not think that having the full/debug KASAN enabled on production
> kernels adds any value because for it to be useful requires somebody
> to actually look at the stacktraces; I think that choice should be
> made explicitly if it's a production kernel. My guess is that we'll
> save explaining performance differences and resulting headaches for
> ourselves and others that way.
>
> > Should we somehow control whether to panic the kernel on a tag fault?
> > Another boot time parameter perhaps?
>
> It already respects panic_on_warn, correct?
>
> > Any ideas as to how properly estimate the slowdown? As there's no
> > MTE-enabled hardware yet, the only way to test these patches is use an
> > emulator (like QEMU). The delay that is added by the emulator (for setting
> > and checking the tags) is different from the hardware delay, and this skews
> > the results.
> >
> > A question to KASAN maintainers: what would be the best way to support the
> > "off" mode? I see two potential approaches: add a check into each kasan
> > callback (easier to implement, but we still call kasan callbacks, even
> > though they immediately return), or add inline header wrappers that do the
> > same.
> [...]

CC Kostya and Serban.
