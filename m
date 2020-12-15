Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F22DB77C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgLPAAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730147AbgLOX2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:28:13 -0500
X-Gm-Message-State: AOAM531/H7pDPWSXuGnSA+UkFoaK4Bo908RGj1yZCjOUv3Lw7UkG/YMA
        2D0TfukSsL3qmeYbOgffS/Gewtxd2TO71yEFZCY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608074705;
        bh=Yek6HG48EL+fBxIl/n3oPNvuVpQoWA77lJXD5WjiI9Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OXiXAijrTa58QSy8Hn4Q0b3hdD2jgwIRoLmtDqwg/MPYV+x+/pyUW3AbpOjuV+nB6
         qHbSrFKdTAC1m0NcEbvtYljyHA1Zv6nyt6mmLr4bYwvpPyFiyCUHn4CnIK8/cBSc0E
         EYjofvBG3KtB7FlpeBmxHXvvJmHvJe3WKC6LfFjRhhPmTisypkx78haSU7XGGrPorE
         3ccgTkYkfLW05m1Rj6N7U3TPsHcORlASXLxejCT1VrKCp1ImslMHIzW7NpCoESfP0I
         62gQP4OWlFeRISBJ9icDmjEWn2VN2Tgc2qYhihJtakC4Gutsd58WlpC+7MIqSCVJwH
         T0Oa101XVRWAw==
X-Google-Smtp-Source: ABdhPJxH866216C7G/BMIMBE230x06G3zn+SdnjshW+g3sn46anBomdPBt+CWfMoRqv5Aq9onCCRAb9k2ZkZw+XIpKg=
X-Received: by 2002:aca:44d:: with SMTP id 74mr659088oie.4.1608074704756; Tue,
 15 Dec 2020 15:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com> <20201215193800.GA1098247@ravnborg.org>
In-Reply-To: <20201215193800.GA1098247@ravnborg.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 16 Dec 2020 00:24:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
Message-ID: <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Dec 15, 2020 at 8:38 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Dec 15, 2020 at 12:26:10PM +0100, Arnd Bergmann wrote:
> >
> > - Disable SMP support for sun4m/sun4d. From the historic git
> >   tree, it's unclear how well this ever worked, and very few machines
> >   of this class ever existed
> Yeah, I have collection of sparc32 machines that I played around with
> once. Including one sun4d that I brought from a friendly Linux fellow in
> the UK. But somehow I lost interest as this is all very nice machines
> but not useful for anything real work.
>
> I think we would be better served dropping support for sun4m and sun4d
> from the kernel.

This seems appropriate as well to me.

> Last I suggested deleting sun4m/sun4d the argument to keep sun4m was that
> QEMU supports sun4m - which is a good argument for sun4m. I dunno what
> would be needed to migrate QEMU to LEON, see below.

"qemu-system-sparc -M help" shows a "leon3_generic" platform, apparently
added in 2013. Do you think that would be sufficient?

> > - Mark SMP for LEON as temporarily broken. As I see in the LEON
> >   patch set, they have changes to enable compare-and-swap-atomic
> >   instructions unconditionally, as all SMP Leons have those and
> >   seem to require this support already for other things.
> LEON on the other hand could have some nice future. They are right now
> stuck on an older kernel and someone that was motivated should be able
> to get LEON4 running on latest upstream.
> We had it working in the past - but is was around the time I lost my
> sparc interest and no-one jumped in to move it much more forward.

My best guess from the public information I could find on LEON is that
it keeps shifting away from Linux on LEON to other OSs, and to
and to Linux on NOEL-V.

So even though the CPU itself will likely have a long life ahead of it
with LEON5 only a year old, it's unclear how many more updates
we'll see to the kernel from the current 4.9 based release.

> So in other words - no complains for the plan you outline.

Thanks. I'd probably queue up a patch in my asm-generic tree for
v5.12 to disable SMP on all SPARC32, add the helpers for C-Sky
once Guo Ren has tested a patch, and clean up the futex code based
on this. I guess we want the one-line fix for Arm that Thomas suggested
for v5.10 and backports anyway, The sun4m/sun4d removal should
clearly be discussed separately and go through the sparc tree, to see
if anyone has objections, or if we want to remove other obsolete
platforms (sun3?) along with it.

      Arnd
