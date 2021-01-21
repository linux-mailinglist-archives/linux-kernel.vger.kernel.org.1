Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FF2FE8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbhAULit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbhAULhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:37:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ACDE238E3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611229004;
        bh=c529Zol8CrTx09rGLG9vb4AaNRN7sUXHBfb+tqUL5MY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mEvdBxSG/7amt+sKn2Q1wq1sPflHn926i7nyiiRyAkWRFcHnbimMg8Uk8F/6vL0vo
         qeOtGo/Zic34NUQMOvA+qmh4foSscCFozVEExkoqTiCBXKdYu7KVSrNLx6J6BlF6T7
         Cb83geiXehlxGT9iAageUhbBdb9ZQbW1WON7gTtLglAHgrvYc0FqZ+1ivBhmg+pVmA
         3HV0RRpcSSMGieqFXlATlcJZGjJ5R9roAlNJPIAlM6iVZwsuIolH9DyCyFEcESRJMk
         CTfI/t0GRtY6FlP4fDJzjXLw9vPoiddQMJrm7al+yZ8t0tXpl9jSvPxdqQ/VVY5241
         xxQe+ZPt4N4LA==
Received: by mail-ot1-f49.google.com with SMTP id d1so1248724otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:36:44 -0800 (PST)
X-Gm-Message-State: AOAM531XUadGs1Z+ctQonWxjVnBOuCBPm7j/C/xZUe9+yftJruKrhNS5
        Pb4ojV+fG5qIpbci3BugMkek1holk50naYjK1nU=
X-Google-Smtp-Source: ABdhPJwdzyxsACQknRLgT5ZX9OB8pFKd5fhZA/phme9eP8yz9udQHOBHLjD6RhXwelSq6oIk0+3jLAW0I9mtZ8jL7c0=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr10125507otq.305.1611229003319;
 Thu, 21 Jan 2021 03:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-3-mohamed.mediouni@caramail.com> <CAK8P3a20XRHaErO5445ds6tf0omSKLMZ_NAWdS=9nBbLb7rdvg@mail.gmail.com>
 <5403A355-A4FA-442B-8F8B-5629FCECC006@caramail.com>
In-Reply-To: <5403A355-A4FA-442B-8F8B-5629FCECC006@caramail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 12:36:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fRy8NhLJAtVpn0bH7sEgXcHJQXEJhzc7ArwTxseqLZw@mail.gmail.com>
Message-ID: <CAK8P3a0fRy8NhLJAtVpn0bH7sEgXcHJQXEJhzc7ArwTxseqLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:01 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
> > On 21 Jan 2021, at 11:52, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> > <mohamed.mediouni@caramail.com> wrote:
> >> --- a/arch/arm64/kernel/cpu_ops.c
> >> +++ b/arch/arm64/kernel/cpu_ops.c
> >
> >> #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> >> #include <linux/stackprotector.h>
> >> @@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
> >>
> >> static void noinstr __cpu_do_idle(void)
> >> {
> >> -       dsb(sy);
> >> -       wfi();
> >> +       const struct cpu_operations *ops = get_cpu_ops(task_cpu(current));
> >> +
> >> +       if (ops->cpu_wfi) {
> >> +               ops->cpu_wfi();
> >> +       } else {
> >> +               dsb(sy);
> >> +               wfi();
> >> +       }
> >> }
> >
> > I think the correct place to put this would be a platform specific driver
> > in drivers/cpuidle/ instead of an added low-level callback in the
> > default idle function and a custom cpu_operations structure.
>
> Can we make sure that wfi never gets called even on early
> boot when using a cpuidle driver?

Good question, I don't know what all the possible call sites are
for this, but if there is nothing else works (such as what Alex suggested),
it may be possible to just patch out the wfi instruction here and
do a busy loop until the cpuidle driver has come up.

The main issue here is the existence of the custom cpu_operations
in the first place: I don't think we want or need the custom start_secondary
at the moment (as commented in the other patch), but then there is
no obvious place to put the custom wfi.

Note that there are a few other uses of the wfi instruction besides the
one in __cpu_do_idle(), so whatever you do here may also apply to the
others.

arch/arm64/include/asm/smp.h:           wfi();
arch/arm64/kernel/head.S:       wfi
arch/arm64/kernel/head.S:       wfi
arch/arm64/kernel/head.S:       wfi
arch/arm64/kernel/process.c:    wfi();
arch/arm64/kvm/hyp/nvhe/hyp-init.S:     wfi

       Arnd
