Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707CD294C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439832AbgJUL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393832AbgJUL6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:58:39 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA41122251
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603281519;
        bh=wsmfCYJA1G5W18rhe1i3zWsYQ3eg08pCP9xHDplvS6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=srKfKdqrcpEmy/AMoOlSfXqIxVMzQpvZSnQrGmRq5zPV4JwMBMSeURkdtbYDTKylB
         4O2RtKuAAOeX2lyGjdAyjzpgXoPAYf93jMtuPSetIWXNoUL/iepVPgAjWiKBvOhUm7
         kn7XprIS4XIHFMPNg+PWQ9drNOdMFppItuGB1scU=
Received: by mail-qk1-f181.google.com with SMTP id r7so2035709qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:58:38 -0700 (PDT)
X-Gm-Message-State: AOAM533wf5Yr/NYTckcn8NzTmqLLB1ui4mca/p6M78+pfHWOA3nwOqym
        PkagqwFRc25TDlMqIqdGeIZImPIjoIOI5HPheQk=
X-Google-Smtp-Source: ABdhPJwQnCJxyRlYwunWKYMG17jGLNNqbGCZFz9Dt5WiF3EjZocsWix1T+MBVzPCNZLrOsbIuguORdkSjMuA7cezmC4=
X-Received: by 2002:a37:2dc6:: with SMTP id t189mr2722030qkh.394.1603281517886;
 Wed, 21 Oct 2020 04:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071628epcas5p24d196a6023a47a3b0bfa7b7f231ec811@epcas5p2.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <20201008083015.GK1551@shell.armlinux.org.uk> <CAK8P3a0h=D8_Kn_fpHbsik_jf4to2jayxj7K7B7=HaNFzKqNnw@mail.gmail.com>
In-Reply-To: <CAK8P3a0h=D8_Kn_fpHbsik_jf4to2jayxj7K7B7=HaNFzKqNnw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Oct 2020 13:58:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2tmRo0voZJLqYbNQGG9FZCGuKzMj8Zo8f+WL+dvOourw@mail.gmail.com>
Message-ID: <CAK8P3a2tmRo0voZJLqYbNQGG9FZCGuKzMj8Zo8f+WL+dvOourw@mail.gmail.com>
Subject: Re: [PATCH 0/3] IRQ stack support for ARM
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Maninder Singh <maninder1.s@samsung.com>, v.narang@samsung.com,
        a.sahrawat@samsung.com, Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(replying to my own mail, apparently my normal outgoing email server is
blacklisted, so resending from @kernel.org)

On Fri, Oct 16, 2020 at 12:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 8, 2020 at 10:32 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Thu, Oct 08, 2020 at 12:45:30PM +0530, Maninder Singh wrote:
> > > Observed Stack Overflow on 8KB kernel stack on ARM specially
> > > incase on network interrupts, which results in undeterministic behavi=
our.
> > > So there is need for per cpu dedicated IRQ stack for ARM.
> > >
> > > As ARm does not have extra co-processor register
> > > to save thread info pointer, IRQ stack will be at some
> > > performance cost, so code is under CONFIG_IRQ_STACK.
> > >
> > > and we don't have much knowledge and set up for CLANG
> > > and ARM_UNWIND, so dependency added for both cases.
> > >
> > > Tested patch set with QEMU for latest kernel
> > > and 4.1 kernel for ARM target with same patch set.
> >
> > You need to investigate and show where and why this is happening. My
> > guess is you have a network driver that uses a lot of kernel stack
> > space, which itself would be a bug.
>
> Agreed.
>
> > Note that there are compiler versions out there that mis-optimise and
> > eat stack space - the kernel build should be warning if a function
> > uses a large amount of stack.
>
> Some more ideas for figuring it out:
>
> CONFIG_DEBUG_STACK_USAGE may also be helpful in identifying
> code paths that are deeply nested with multiple functions taking a
> lot of stack space, but each one staying under the limit.
>
> CONFIG_DEBUG_STACKOVERFLOW would also help here but
> is not supported on Arm at the moment. There was a patch[1] from
> Uwe Kleine-K=C3=B6nig to add this, and I suppose we should still add
> that, in particular if it helps debug this problem.
>
> CONFIG_VMAP_STACK is probably the best way to debug
> random runtime stack overflows because using a guard page
> turns random memory corruption into an immediate oops,
> but I don't think there is an implementation for Arm yet and
> using a lot of vmalloc space means we might not be able to
> default to this.
>
> Regardless of identifying and fixing the bug Maninder found, I
> also think that supporting separate async stacks on Arm is useful
> for determinism. Most of the popular architectures use irqstack
> for this reason, and I was actually surprised that we don't do it
> on arch/arm/.
>
>      Arnd
>
> [1] https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kle=
ine-koenig@pengutronix.de/
