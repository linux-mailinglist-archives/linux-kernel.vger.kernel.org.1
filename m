Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF32D1418
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLGOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:53:01 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348FC06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:52:20 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id q25so859305otn.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPzuC3l9bUVQLqVycsUsk7wyTCeGali3Xu4MVJWoAek=;
        b=nK1rhCt7896cCVPh8xtp9pEMhGJDBv8pi6Q0Bmd+Q2sEpKMERk/1kkqnAXCMwQTQZ6
         iBx7HDJbkG5Cuw6nFuV7ncY5PYu0NxKje50wOF8HJ+4A+Nc1DGKGO2a/kRTbYAmkL5tA
         fBgX0SiA411jEAvsyeYRT5B7x0+Dr7th8UCmrFEdY3a1ihneSk3P5GeesUvhubASzmlv
         IzGPbOL0b8NnYXyk2pxlgqA1by/6dlFOeWDMXn5pkulQBj1WTlewyllYH64c02u5RRyT
         krtXIdsSaou3YocF/QTB+6YCveINYeOLl2LlTNWyqNNBGmkIi3tw5ooY+lMFjhEd6p5S
         tH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPzuC3l9bUVQLqVycsUsk7wyTCeGali3Xu4MVJWoAek=;
        b=fsrheCmcHXzOm9t/htFn1lxFSqezUPKcsoAN/mVicmfLkE4vQDLcHEfFSI51baURcR
         ZSNdRwLwedHuf9RTHiVNkdEdXxQEstL5pVe+rEYOxzvGn+WzOXtvNisTatozVS+7OWJ8
         fdxBBjGjvJGdgvEV8pq87n8NllcEzFJNwFBEMTFlAW55EuzwEMzE0Exrkh3MNlf/Pg2u
         ggIQ6mBJlT3qW4uqff06SOf2aVBX2wujuqG2lHE47Wjf/2X3Z70ouoMJaHOxpyHLhrzY
         xt8XkWG4WndN3OZV+R5XD5BGph/VeJ7gdpS9+cE73OZQcZyJyJQINr67IgO7JuCKF6F1
         xEfg==
X-Gm-Message-State: AOAM5310YNK3D1Z5u2vCbX2Eq4rrbZE9uROBJT/nBZ63luk+axPQ1Bre
        UM8OilN8LZ0zR0aRYFd6aAMd+ioa9a9+bk8GAN0YzA==
X-Google-Smtp-Source: ABdhPJyVPBzD19XvHQYqi+YTmMToJMkFlooOLafje7MhAAqM0OhgEYsSse9MtAPRlADY+mNhIiLZ6x+IrvRFLhFX2pc=
X-Received: by 2002:a9d:6199:: with SMTP id g25mr3189418otk.17.1607352739427;
 Mon, 07 Dec 2020 06:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20201205172207.GA4097@rlk> <20201207082300.38f5207f@canb.auug.org.au>
 <CANpmjNPifOwd9w34dSJhsvmP2sUkKa0ESPiJ7gj+gUDffhPO3A@mail.gmail.com>
In-Reply-To: <CANpmjNPifOwd9w34dSJhsvmP2sUkKa0ESPiJ7gj+gUDffhPO3A@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Dec 2020 15:52:07 +0100
Message-ID: <CANpmjNOWpa17L7mjhKdaFjWYfAzy12NjXUDtuPHpzm808QApRg@mail.gmail.com>
Subject: Re: [PATCH][next] arm64: fix the mm build error in mm/kfence/core.c
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hui Su <sh_def@163.com>, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Dec 2020 at 23:08, Marco Elver <elver@google.com> wrote:
> On Sun, 6 Dec 2020 at 22:23, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
[...]
> > > ../arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration =
of
> > > function =E2=80=98set_memory_valid=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
> > >    12 |  set_memory_valid(addr, 1, !protect);
> > >       |  ^~~~~~~~~~~~~~~~
> > > cc1: some warnings being treated as errors
> > >
> > > which introduced by commit d54febeba2ff ("kfence: use pt_regs to
> > > generate stack trace on faults").
> > >
> > > Signed-off-by: Hui Su <sh_def@163.com>
> > > ---
> > >  arch/arm64/include/asm/kfence.h | 1 +
> > >  1 file changed, 1 insertion(+)
>
> Thanks, but a patch for this is already in the -mm tree:
> https://lore.kernel.org/mm-commits/20201205011409.o9PNsRntR%25akpm@linux-=
foundation.org/
>
> Perhaps try the latest -next?

Although I notice that patch somehow was dropped from -mm, or maybe
I'm not looking hard enough?

> > > diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm=
/kfence.h
> > > index 6c0afeeab635..4d73e34da59d 100644
> > > --- a/arch/arm64/include/asm/kfence.h
> > > +++ b/arch/arm64/include/asm/kfence.h
> > > @@ -4,6 +4,7 @@
> > >  #define __ASM_KFENCE_H
> > >
> > >  #include <asm/cacheflush.h>
> > > +#include <linux/set_memory.h>

I preferred the patch at

  https://lore.kernel.org/mm-commits/20201205011409.o9PNsRntR%25akpm@linux-=
foundation.org/

because it removed <asm/cacheflush.h> and only included <asm/set_memory.h>.

I hope the right patch finds its way into the queue. :-)

Thanks,
-- Marco

> > >  static inline bool arch_kfence_init_pool(void) { return true; }
> > >
> > > --
> > > 2.25.1
> >
> > Added to linux-next today.  I think it actually fixes patch "arm64,
> > kfence: enable KFENCE for ARM64" since that actually introduces the
> > set_memory_valid() call?
>
> The patch that moved the declaration was after the kfence patch, so
> it'd be the other way around:
> https://lkml.kernel.org/r/X8otwahnmGQGLpge@elver.google.com
>
> Thanks,
> -- Marco
