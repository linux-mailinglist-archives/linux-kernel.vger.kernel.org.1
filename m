Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA122EF329
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbhAHNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbhAHNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:37:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92912C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:36:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y8so5663439plp.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H4NRUpssxmHvO//onxHk/0LPtfW86OVu0j9eYubnLc=;
        b=SLY+QxdrqHdJ2uP5KNaiBHXk48J1xlfhCMQIVdxTzXaENX8pz32T0lesa+t0AWstHA
         ARdGIcwCAcMUYw3EG7rttfsxeRdwK+AnmQ3ErSrt+2TME17Z4+XNi/F2DBqfV9uJKRAa
         udyKmiOCfTjpxv5s4kAW833BX3PTrWacStDLcFUFT2UFPMjfUeLcTXKVsLvC/7ssD0C+
         NNFFFuLp8KYEyD9oUg4ft529Pc9h7jr3B6kS2rmHFzcy2V3z/B98L8a/hWZcwyVhLnMs
         CBC3/eUZMyTO2i4qRv6d4o/78FtYTdKPGKx04E5N57UuSjV7X7ze3jv2ugfdvTZfeo/e
         X1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H4NRUpssxmHvO//onxHk/0LPtfW86OVu0j9eYubnLc=;
        b=WXh8gtGXce0+BzkBKU+47BEwZSu9qjFt3KbWTQV6iTeQLn/43ifszCimuQSGBUzIYN
         iyqo0Ju+MCj+6XaVa1zsNXbYQX1Od232eb5o2XgvPjRF6yWW09E60TijaJsviQr/wbBd
         9gnbH9IJ7NYcPH8wTYB9Q56XT5gSTyYu2tfZ52SlVcJDICM9H+CEkDoOkPThOpmq2yit
         iYNvIRhC6aJdbtVxn3U8ZCMC3DRdy+7bijIMOJEdgfJ0GtFMRr3KUCEUjXHeXOvJTmnH
         viRUA6fGsMQdzhSpZb27lNIXzotJFUkd7OGsVCrdoHMffGQcmhtZJEcy9Qc745fk2ZjR
         Thsw==
X-Gm-Message-State: AOAM533sORK80qfG5skvlICt73oanuDyAW74uBvu+Kk6opcFp2yvf1qx
        gLCfPU/AJOBKFjO54xntbAP94VrZPB1m7oovxQc/ZQ==
X-Google-Smtp-Source: ABdhPJzpTc0UQR+hgscAav0gZ5De9rk59XFTJC1VFhvY0Dfql8DGLIjtuXMtQBjGOFKQCOMvXn3p388NehqzJiu5ZJY=
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id
 a9-20020a1709029009b02900dc52a60575mr3718033plp.57.1610113018926; Fri, 08 Jan
 2021 05:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <20210106115519.32222-3-vincenzo.frascino@arm.com> <CAAeHK+xuGRzkLdrfGZVo-RVfkH31qUrNdBaPd4k5ffMKHWGfTQ@mail.gmail.com>
 <c4f04127-a682-d809-1dad-5ee1f51d3e0a@arm.com> <CAAeHK+xBrCX1Ly0RU-=ySEU8SsyyRkMdOYrN52ONc4DeRJA5eg@mail.gmail.com>
 <c3efaa8d-cb3a-0c2a-457e-bfba60551d80@arm.com>
In-Reply-To: <c3efaa8d-cb3a-0c2a-457e-bfba60551d80@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 14:36:47 +0100
Message-ID: <CAAeHK+zjwr0M92zqUjseJmRmhHb=4GjevEft-mahfx5DOkq==w@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: mte: Add asynchronous mode support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 11:44 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 1/7/21 7:18 PM, Andrey Konovalov wrote:
> >> Boolean arguments are generally bad for legibility, hence I tend to avoid them.
> >> In this case exposing the constants does not seem a big issue especially because
> >> the only user of this code is "KASAN_HW_TAGS" and definitely improves its
> >> legibility hence I would prefer to keep it as is.
> >
> > I don't like that this spills KASAN internals to the arm64 code.
>
> Could you please elaborate a bit more on this?
>
> If I understand it correctly these enumerations I exposed are the direct
> representation of a kernel command line parameter which, according to me, should
> not be considered an internal interface.
> Seems that in general the kernel subsystems expose the interface for the
> architectures to consume which is the same design pattern I followed in this case.

It's fine from the point of view of kernel interfaces and such, but
not from a higher-level design perspective.

I think the best way to approach the KASAN-MTE architecture is: 1.
arm64 code provides API to enable, disable and otherwise work with
MTE, and 2. KASAN builds on top of this API to implement the logic of
the bug detector, including which APIs to use. Part #2 includes making
the decisions about which mode - sync or async - to use and when. And
that mode is chosen by KASAN code based on the command line configs.

With your current approach, the active decision about enabling
sync/async is made by the arm64 code, and that doesn't fit within this
architecture. But having a decisionless arm64 API to choose the MTE
mode and using it from KASAN code would fit.

> > Let's add another enum with two values and pass it as an argument then.
> > Something like:
> >
> > enum mte_mode {
> >   ARM_MTE_SYNC,
> >   ARM_MTE_ASYNC
> > }
>
> I had something similar at the beginning of the development but I ended up in a
> situation in which the generic kasan code had to know about "enum mte_mode",
> hence I preferred to keep kasan agnostic to the hw implementation details.
>
> What do you think?

Perhaps we could add a generic arch-agnostic enum to
include/linux/kasan.h and use it in both arm64 and KASAN code?

enum kasan_hw_tags_mode {
  KASAN_HW_TAGS_SYNC,
  KASAN_HW_TAGS_ASYNC
}

Assuming other architectures that support memory tagging will end up
with sync/async mode separation as well, this should work. But even if
that doesn't happen, this interface can be adjusted later.
