Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12502DAC02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgLOL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgLOL1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:27:09 -0500
X-Gm-Message-State: AOAM531kJNVJoHVhvxeleYcztgLRmGaDuhRIOBA3AeDIqecI4V8Us3rR
        Hy1ZCkJ6p36+OwqfqsBzyo/ylvQjRIx5QuPNT5A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608031587;
        bh=rKOqa+R7y7mNp4eGjcH7gQWW+nLwZbAUT9kBD3lZKQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k70ldZS0l6V88WrQxLMEndoVnq2m/KjFtz+SI9cpIncROfnOXbQdLcAX96kzj9Jr4
         fUIoGhMYqJOMl38ILevJCDrE3t2yTfjYzzQADCZ1gZshSXyJQlduncAe5omcuIrkzx
         QsoDU0j7rYXoLIKwgsQe7J1M2guKtrkeQd6GqMQeC9yfRm2fFEr8YfHvnW7CbOGx5+
         t+JvW1xPZsG/NgHenIb7r4mVYv9YZCpkjwxJ6kyYj6djesVaD15t5Cz3ZWWYXM+fpe
         GlvBVjkoa6AJGfKyQzRSYhtE2ygHodgwifn0jUCCLqv3uzlzLaSUOBPAlr83DBCRPZ
         7fNh1AdAfPmdQ==
X-Google-Smtp-Source: ABdhPJzPyvmL8dDsf1iieoW9f95hiyyM8AowO7irrDFRwVfuGZ4n22u3MxoO/K4BU5ug1mXFiWGDS9GALpaS0p3jmPk=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr22991912oth.210.1608031586660;
 Tue, 15 Dec 2020 03:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
In-Reply-To: <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Dec 2020 12:26:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
Message-ID: <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
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

On Tue, Dec 15, 2020 at 7:09 AM Guo Ren <guoren@kernel.org> wrote:
> On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > I had a look at what other architectures always implement
> > futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> > and I found that it's pretty much all of them, the odd ones being just sparc32
> > and csky, which use asm-generic/futex.h but do have an SMP option,
> > as well as xtensa
> >
> > I would guess that for csky, this is a mistake, as the architecture is fairly
> > new and should be able to implement it. Not sure about sparc32.
>
> The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
> with asm-generic's implementation.
> For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
> implementation, so futex_cmpxchg_enabled = 0.
>
> Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
> and still use asm-generic for non-smp CPUs.

Sounds good to me.

With that, I would suggest we actually remove the -ENOSYS fallback
for arch_futex_atomic_op_inuser() and futex_atomic_cmpxchg_inatomic()
in asm-generic/futex.h as well as the HAVE_FUTEX_CMPXCHG Kconfig
symbol, plus these additional fixups:

- for xtensa and mips configurations without ll/sc, fall back to the
  asm-generic version. These are all uniprocessor, while the
  corresponding SMP machines have a working
  arch_futex_atomic_op_inuser().

- Disable SMP support for sun4m/sun4d. From the historic git
  tree, it's unclear how well this ever worked, and very few machines
  of this class ever existed

- Mark SMP for LEON as temporarily broken. As I see in the LEON
  patch set, they have changes to enable compare-and-swap-atomic
  instructions unconditionally, as all SMP Leons have those and
  seem to require this support already for other things.

         Arnd
