Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADCF2DF7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 04:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgLUC7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 21:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgLUC7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 21:59:33 -0500
X-Gm-Message-State: AOAM530pn7rmVqsXiGABYed+AGXkkwhMXinScdLrDPtSmqT7VKU8Bgih
        ZYpHWHa4Pw9hBWIjvELU5inmTbeoBw5vCtKLt1k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608519532;
        bh=SZun7TJm7wCXlJxQxcZrzlk8v6yvxc/nAR0yaGvTZu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KnNET7Lg40h3y5kFwF1waDYdIM8Do0+T2isXSZpLIjVJHXvg0BfIqCvJkjtPxCkFL
         JQ7bVyERdGu/FzYlZN2MFSyeEjnd8gJ+1rkJYGwWLnDgJOk2E3cuNbfkGamcAXyIJt
         RMlA7a9j81ZzSxufNR4vdFhkUY3qFMU9f83PuMzCGRsLWOebk5ePK36HIpwhNKW/60
         LxhwVNCvg15YNnvXcdpq/+x2hWELFpHcDPUW8hh+bygmQb8g3op7OveZMBhcW/qUqz
         q08W5Pw2YELINNhxFI52BjULPc5Txzzm6f5Q+b0SDTzALSBP/+LqoDI5iuJkGJO2nl
         VFOEUSt0b+YLA==
X-Google-Smtp-Source: ABdhPJx09BMHVq0KkSgpUsvrCS7aZUZUQ68ReymvsEtc1ivryBp80GH4ho6nbTRrPxmTlRcdp7vXNmLo69BQ/g4I9GA=
X-Received: by 2002:a19:c511:: with SMTP id w17mr5425729lfe.557.1608519530327;
 Sun, 20 Dec 2020 18:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <CAJF2gTQUPXzRL4P2ghoSt6t+pyAJ7A9dqdD6VWYNdOmJjd2HQg@mail.gmail.com> <CAK8P3a3mrD7U__T-X2jr1Mw9Xk=dBE=Fuid_BHNE85GcX0g-rg@mail.gmail.com>
In-Reply-To: <CAK8P3a3mrD7U__T-X2jr1Mw9Xk=dBE=Fuid_BHNE85GcX0g-rg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Dec 2020 10:58:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSc5FS-iUZUiEygviFwa17e=iBncmL+mZ_BORbSthmxiQ@mail.gmail.com>
Message-ID: <CAJF2gTSc5FS-iUZUiEygviFwa17e=iBncmL+mZ_BORbSthmxiQ@mail.gmail.com>
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

On Mon, Dec 21, 2020 at 1:49 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sun, Dec 20, 2020 at 4:46 PM Guo Ren <guoren@kernel.org> wrote:
> > On Tue, Dec 15, 2020 at 7:26 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
> > > > On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > > I had a look at what other architectures always implement
> > > > > futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> > > > > and I found that it's pretty much all of them, the odd ones being just sparc32
> > > > > and csky, which use asm-generic/futex.h but do have an SMP option,
> > > > > as well as xtensa
> > > > >
> > > > > I would guess that for csky, this is a mistake, as the architecture is fairly
> > > > > new and should be able to implement it. Not sure about sparc32.
> > > >
> > > > The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
> > > > with asm-generic's implementation.
> > > > For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
> > > > implementation, so futex_cmpxchg_enabled = 0.
> > > >
> > > > Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
> > > > and still use asm-generic for non-smp CPUs.
> > >
> > > Sounds good to me.
> > Done: https://lore.kernel.org/linux-csky/1608478763-60148-3-git-send-email-guoren@kernel.org/T/#u
>
> Thanks!
>
> Can you clarify if there are any dependencies on the other patches in
> that series?
No dependency.

>
> I'd like to take the futex patch through the asm-generic tree along with the
> patches for the other architectures.
You take the futex patch and I'll remove it from my tree.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
