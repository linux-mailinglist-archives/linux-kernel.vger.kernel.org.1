Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D88290626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407356AbgJPNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395512AbgJPNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:17:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F474C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:17:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so1435591pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QL3/zaLDIDJL7ythZO9+VfLF2/gKs2of9IcU9332u94=;
        b=GxBuew5MDtRY2618+D5SI58D1s8+noXUXKNpeUsPHxGasQUYna1X1sKnYL/RCr9W+I
         TVenQkpVDq67PglFCmkdh58kFTtIZnwKbqeKLrbehtV5J8DfV2dSburDCR7Xg2OV2L/w
         6pfjAtf4M66sMTQXdPRA5hdiuo14EFCz/Rm9GehD9Dh6UfBOs2YzqtMXHQFFYqhB37Qg
         8oQFJqiC7v/dFTqng88tthWe19W2K8rjFRB7OeLt1rpjO7XBT32IWlnjlpCKf0pu8pj+
         DruA7hsPqExtfefuXdvLq2Tc/Gy3McU7W/wMd0ASthYJqGXdOMDjmnDIgtp9IczrWrik
         cEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QL3/zaLDIDJL7ythZO9+VfLF2/gKs2of9IcU9332u94=;
        b=a7M3SrTFzz1spUHA0+Rd9xXM3IHKMlso0MAY+pHsmx/c78FkQgJAN4DXIN/MKFWZHt
         jaHcsl1Syxx9HTszevMKEyNd7sIGr+raFcFFfLqYoll6vAbsZPa2NiKNLQ6hMrM90Hm+
         L9S763tzeYrxJMdWPxyzDIrMnGA27wYcUKUNKjpfDTeLWIhdd5oFcn34eJQb7kRg9lGV
         gnYrmXol+IbGwRlTt25hSmNlBDTMvPA+HbDu7AA0iwrYMefRlek11LxFdozNOccu7FzQ
         7p9t3R7/ZMkd+KXIJjMAelS3+BarYhKOQoMMx1gYSAOghZ0HfOCtTb+ggQTE8wjs3T7i
         LRqg==
X-Gm-Message-State: AOAM531fp5rU4IHM9E7SkK7c0/pyuQ+pUb50fKhTolcL/XhpNxY/PbfX
        hMcW64YObTuhNKU+8e7L1UGSbkr2H1tUX01aKNXvFg==
X-Google-Smtp-Source: ABdhPJzzHKZfnBav2HobW7A6XwuVJj70HQe8x5G3opXTbj9PUHDUF1SAyaKmCVaW6NmRyIMfki7lXkt/YYotyrfk8tc=
X-Received: by 2002:a63:5d07:: with SMTP id r7mr3134194pgb.440.1602854265382;
 Fri, 16 Oct 2020 06:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
In-Reply-To: <CANpmjNOV90-eZyX9wjsahBkzCFMtm=Y0KtLn_VLDXVO_ehsR1g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 15:17:34 +0200
Message-ID: <CAAeHK+zOaGJbG0HbVRHrYv8yNmPV0Anf5hvDGcHoZVZ2bF+LBg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Marco Elver <elver@google.com>
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

Yeah, perhaps "on" is not the best name here.

> Instead, maybe the following might be less confusing:
>
> "full" - current "debug", normal KASAN, all debugging help available.
> "opt" - current "on", optimized mode for production.

How about "prod" here?

> "on" - automatic selection => chooses "full" if CONFIG_DEBUG_KERNEL,
> "opt" otherwise.
> "off" - as before.

It actually makes sense to depend on CONFIG_DEBUG_KERNEL, I like this idea.

>
> Also, if there is no other kernel boot parameter named "kasan" yet,
> maybe it could just be "kasan=..." ?

Sounds good to me too.

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

Ack.

> > Should we somehow control whether to panic the kernel on a tag fault?
> > Another boot time parameter perhaps?
>
> It already respects panic_on_warn, correct?

Yes, but Android is unlikely to enable panic_on_warn as they have
warnings happening all over. AFAIR Pixel 3/4 kernels actually have a
custom patch that enables kernel panic for KASAN crashes specifically
(even though they don't obviously use KASAN in production), and I
think it's better to provide a similar facility upstream. Maybe call
it panic_on_kasan or something?
