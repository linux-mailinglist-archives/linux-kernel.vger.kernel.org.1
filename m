Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C32DF652
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgLTRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 12:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgLTRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 12:50:12 -0500
X-Gm-Message-State: AOAM532fX3ZEitY8vX8TpMD3BLnOWMAiOzWkl2RzSJNxv3rD742gpRe6
        zH6iPYiGMVb5+ufiBXeoIgaIPBi0mZ4CItfXtj8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608486570;
        bh=iqp7gUniW01cFIdAe/0kjZ8VQGLxFBk/ZcEA3tr8OgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lVA5iy3RnN5NMkXR+rvQPyPQwEdd4+pkEzV+s4yFYx8aAtP3YkpuyL7oIKpgSoKz+
         pp3s2l0TVs58AFJelPCM12d0A56Dt9wyBrIwKMA2KHDAm7/A+epMpADhJ7MTx4HVm7
         wn7UPYoxsz1Jgfxwg0tEMh23M6xVmwOgmlmHNK+uQU0fl9/fwDJqRJX9fXnFmHeiOI
         /3Tihq/quPiz5XGePD/Ge5DW8h9Rm1Swg0pLynu3T/IFgdoLwslx4HYuK+fW+T+3tH
         v3TpjbI9eWnLp0HlfM5g5Z06OogGtq+4unPLYY7eUog0irLl2AmrDIKFfSlg/ZxG8P
         bBMSh4W9VgeEw==
X-Google-Smtp-Source: ABdhPJykjGV9LSsGbTTTe2PJBFyDya6l+Fbx0dVC2hpEZ9YGnkZZDZFhzdBB5yyQhBuNS5/ttLQ7QB665uMCRI5xNNY=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr9589019otm.305.1608486570097;
 Sun, 20 Dec 2020 09:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com> <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
In-Reply-To: <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 20 Dec 2020 18:49:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3mrD7U__T-X2jr1Mw9Xk=dBE=Fuid_BHNE85GcX0g-rg@mail.gmail.com>
Message-ID: <CAK8P3a3mrD7U__T-X2jr1Mw9Xk=dBE=Fuid_BHNE85GcX0g-rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Guo Ren <guoren@kernel.org>
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

On Sun, Dec 20, 2020 at 4:46 PM Guo Ren <guoren@kernel.org> wrote:
> On Tue, Dec 15, 2020 at 7:26 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
> > > On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > I had a look at what other architectures always implement
> > > > futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> > > > and I found that it's pretty much all of them, the odd ones being just sparc32
> > > > and csky, which use asm-generic/futex.h but do have an SMP option,
> > > > as well as xtensa
> > > >
> > > > I would guess that for csky, this is a mistake, as the architecture is fairly
> > > > new and should be able to implement it. Not sure about sparc32.
> > >
> > > The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
> > > with asm-generic's implementation.
> > > For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
> > > implementation, so futex_cmpxchg_enabled = 0.
> > >
> > > Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
> > > and still use asm-generic for non-smp CPUs.
> >
> > Sounds good to me.
> Done: https://lore.kernel.org/linux-csky/1608478763-60148-3-git-send-email-guoren@kernel.org/T/#u

Thanks!

Can you clarify if there are any dependencies on the other patches in
that series?

I'd like to take the futex patch through the asm-generic tree along with the
patches for the other architectures.

       Arnd
