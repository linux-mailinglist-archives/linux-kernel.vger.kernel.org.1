Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E158E2DF5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLTPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgLTPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:44:55 -0500
X-Gm-Message-State: AOAM5316y/v0huV8jj8bupFRZQae5HinXdlOa+mAC202THLZZlxo1LV5
        FR2SYA5+EBIqIJ9Trk/kAEfYra1P95Spq+gbzTY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608479055;
        bh=HkKiub65ipire3e2ahkx2AsS2X8l0pXLoLsYAl6pgds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pYv6WnlLGyVBrw6omIVgT5oi5MEsywjaO0uyPOuEN1ETkIQRyeHnkYpfpyzs2rjAp
         gCi/VNEWzmBeK/L0z9V9Sqk96BgvN1YdEzRL6lxkKzK8JLoAZDFABfmJQdfqxWH2Og
         oFVrT+b2H5CYvaw0tFfFx5sS5OM/qYYtFBk4zUoRp7mzuvuVjCrqGy0IQPrbUTfIlA
         /L3uHzS5xQTwQpKhx2Ss43pOHlgz6vUqQKV7eznJvzTXVUZwry9MxFm8fxkHY+WDy0
         LJG5zYAEkU7+YaNRMShS0p9p4rkmoa3XF5AxaJjn+1SvxAfyLcG1TPFZjelQ9PNjIX
         7/ls3BzTTzMgg==
X-Google-Smtp-Source: ABdhPJwN37zyTdHVtAaxBp4/w7PGJLCIyce4rq1B2FeLm9BHILKVERvfHjjLnZgA9qmknN/yINNixhCWoEaQ8OrCons=
X-Received: by 2002:ac2:4987:: with SMTP id f7mr4736496lfl.41.1608479053208;
 Sun, 20 Dec 2020 07:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com> <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
In-Reply-To: <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 20 Dec 2020 23:44:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
Message-ID: <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Dec 15, 2020 at 7:26 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
> > On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > I had a look at what other architectures always implement
> > > futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> > > and I found that it's pretty much all of them, the odd ones being just sparc32
> > > and csky, which use asm-generic/futex.h but do have an SMP option,
> > > as well as xtensa
> > >
> > > I would guess that for csky, this is a mistake, as the architecture is fairly
> > > new and should be able to implement it. Not sure about sparc32.
> >
> > The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
> > with asm-generic's implementation.
> > For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
> > implementation, so futex_cmpxchg_enabled = 0.
> >
> > Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
> > and still use asm-generic for non-smp CPUs.
>
> Sounds good to me.
Done: https://lore.kernel.org/linux-csky/1608478763-60148-3-git-send-email-guoren@kernel.org/T/#u

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
