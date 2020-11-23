Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6E2C0C67
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgKWNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388750AbgKWNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:52:59 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17590C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:52:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id l17so3870558pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=088zmG11B7ENQeStfIt/hKr66YTpt35vQc34h9N/mec=;
        b=WwhwzWGgg7krqxKQSWo7qxirBtmz/vdt/6j2DSW4AJ7H0uqC3m0kiJkpBJUucnhIRU
         regOTZnXOw2Mi23u2xxBoyTAQh/+fHvAJiccNvPdxWN9U1cHeo5sE6tGyzX0cIJPLlaY
         w+fAPAny5FGyPfO2+0RttYdgJ/tRMrSPdYmX/bNX94ViHoyZGhRhVEIY+W8zmX6IGNA8
         nYevFmxgPTO18WEhkQw1uKz+URUyhtoqWU862+CeihUSza4nYw9m5qwhbWsJX9A2o3vA
         ZgvgnUnLQMI93t7IHi6NpCMu3KZnsu+UZObEw5s6dTmcEThWCXXZcWNZJ5cGrp5dTKMq
         9EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=088zmG11B7ENQeStfIt/hKr66YTpt35vQc34h9N/mec=;
        b=VFOcVxPGdm/ztKMp7RNA5I80Jh7Vked5/vb99aY4Xjen5794XVs3vAooEYJkgDaFYp
         lewuQ9eADzcqhn0eO2U5ziN/KYQzOGMBesdtWjHQWSDQ+3uGVPGgkYoQ9Iu55PRlcTW1
         g6Xe340t/yp7mY8R1GaT7gYRr1fsQK5MnQifaPJdaT8A68qe24H6dlaFBu3wld2T5MTD
         84jCOsnk7OGr3TjKLu+qJHkpwZv8oHEwmOYrUPDLNDXkw8Xbd3zLs4auTp3EfrERH4nI
         2Sh42XKZkje0KjvjYWUvyUoRuxo0XU3jvffD/PN/HhqO8YDs/d4OXiMgAuE2NjXxW/GW
         HDyQ==
X-Gm-Message-State: AOAM530QtGzTh8pm93LuBZu5HmJblWy5IQ6/EfHfxy3BxlVfUq8ZqS3j
        4eBemkn6KvJRj07XidhZ8mLdB7Oc1LzAtmWPY/F4+A==
X-Google-Smtp-Source: ABdhPJz7/esoZcZXlaX0WzzQ5aE2SmW1dFlTaMzQH4jQHeR8+EBmkgGNvBzdbUUfdwnFOrNPM2g04JhCTBIRIMN2d9U=
X-Received: by 2002:a63:f20:: with SMTP id e32mr27452713pgl.130.1606139575373;
 Mon, 23 Nov 2020 05:52:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
 <CACT4Y+azmp-xczEt5rQmejtrnQ=e9PFC15tOHTjA3nHfgQ5gpg@mail.gmail.com>
In-Reply-To: <CACT4Y+azmp-xczEt5rQmejtrnQ=e9PFC15tOHTjA3nHfgQ5gpg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 14:52:44 +0100
Message-ID: <CAAeHK+xc5zgoaPsE9Xg5H6ZTHhBfbPFAygOxSeoJoTAqc8SH5Q@mail.gmail.com>
Subject: Re: [PATCH mm v3 18/19] kasan, mm: allow cache merging with no metadata
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 2:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Nov 13, 2020 at 11:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > The reason cache merging is disabled with KASAN is because KASAN puts its
> > metadata right after the allocated object. When the merged caches have
> > slightly different sizes, the metadata ends up in different places, which
> > KASAN doesn't support.
> >
> > It might be possible to adjust the metadata allocation algorithm and make
> > it friendly to the cache merging code. Instead this change takes a simpler
> > approach and allows merging caches when no metadata is present. Which is
> > the case for hardware tag-based KASAN with kasan.mode=prod.
> >
> > Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> > Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
>
> Somehow gerrit contains an old version... so I was going to
> independently propose what Marco already proposed as simplification...
> until I looked at the patch in the email :)

Ah, this is because I couldn't push next/mm-based changes into Gerrit
without manually adding tags to all of the yet-out-of-tree patches. So
the Gerrit doesn't have the last version of the patchset.

> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!
