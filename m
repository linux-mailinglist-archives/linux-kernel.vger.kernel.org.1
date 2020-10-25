Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940A12981C7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416202AbgJYNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405431AbgJYNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:11:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E19C0613CE;
        Sun, 25 Oct 2020 06:11:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n6so7111598ioc.12;
        Sun, 25 Oct 2020 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTEB6IFYnVAM56TbsbavtmYJvZn7wh6OWujZVz8Rygo=;
        b=E5mmH5rLz8flkRNJlGESTamThJNPU79IXL4KFcYv+0oLrk9GaH9BjOy+aUZ1R1gwTn
         /n2WZifOU4/uZS83sBEcyXwIAKcmhu3+TViGfux+2xIL28c3fZAVq4bTykBabfe+3AHU
         Elj4XLeOUTzUD+IXtQcRLNZwuH9RPeb5Fy0mZHoXj+du4CszRaF3XhePUxUXqWs9Ydwb
         C+nEhK5B6SHryTF62jV3nSXwdLK7f40ZKJjpm/ZAL4x4X3qD8v1QGKXOea2WGRHmYRpw
         6SUxQvzw40r3p1Up4Rm9oUn4bw+Oh7+383N/mYPBBXStbvVHk+IsLKkCTyF6rSpCTrrf
         zFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTEB6IFYnVAM56TbsbavtmYJvZn7wh6OWujZVz8Rygo=;
        b=JvHwh0zaQdZRhs+gy+Efox45JhWJeNHtKiey9qWGpjse/ji5TVgNz/xroD5ogUMLJK
         /teDuQY/WxhKY/DdZDxkerHjn/m2ZK/vvfOz6glsfu5mKiIi/8oSjxg3Nm3wMxOOSS/m
         KqktkDZUz+tV/B1GaPNKXh0jp8DPtUZtDblES3u1DIatVtBHMLPPWmXNlsCLC4msQDkZ
         TRBaPRgv4I+hvgL/BlVt6mLd1ys9+Wywr8CQ54qIOv+r3aWVyDrZSC7kjVa+tReadLI1
         ALDwLc/bFTMX4V0eKIqqjL1WpttbO/+BDTfnRBRLbB6lcwt7BUfwifQSWPYBXAcNQjz8
         bioQ==
X-Gm-Message-State: AOAM5303FGHtkMZDmrNZ2ZaPhUXozu/mw2+qgQAZmQH5Yf7sfDtbrH91
        14ISYmRheyaTG8tLv+Gv5LGMxzwPiF3a5yoAWw==
X-Google-Smtp-Source: ABdhPJw6/4c1bYd4+WCqTBC1gEJVSrhGv+toWf59dho9IuTF454XgHRdOCCZSNtdzLEKnLGHcVR+ixcJk0O8xOavYLo=
X-Received: by 2002:a02:1ac1:: with SMTP id 184mr7830856jai.40.1603631478925;
 Sun, 25 Oct 2020 06:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAOSf1CG=Pvr8Yw_+6J3c4VOD0QJwv58iRtSAqBFpeZM6S=7Viw@mail.gmail.com>
In-Reply-To: <CAOSf1CG=Pvr8Yw_+6J3c4VOD0QJwv58iRtSAqBFpeZM6S=7Viw@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 25 Oct 2020 21:11:07 +0800
Message-ID: <CAFgQCTveoz0fOELrwUY5ZSG_iNKkjGJ32QW1POo-OfjvXM=YLQ@mail.gmail.com>
Subject: Re: [Skiboot] [PATCH 0/3] warn and suppress irqflood
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <mkshah@codeaurora.org>,
        Petr Mladek <pmladek@suse.com>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 8:21 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Sun, Oct 25, 2020 at 10:22 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > > > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > > > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > > > may be nothing or just soft lockup warning showed in console. It is better
> > > > to warn users with irq flood info.
> > > >
> > > > In the kdump case, the kernel can move on by suppressing the irq flood.
> > >
> > > You're curing the symptom not the cause and the cure is just magic and
> > > can't work reliably.
> > Yeah, it is magic. But at least, it is better to printk something and
> > alarm users about what happens. With current code, it may show nothing
> > when system hangs.
> > >
> > > Where is that irq flood originated from and why is none of the
> > > mechanisms we have in place to shut it up working?
> > The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
> > driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
> > triggered.
> >
> > But things are complicated by introducing a firmware layer: Skiboot.
> > This software layer hides the detail of manipulating the hardware from
> > Linux.
> >
> > I guess the software logic can not enter a sane state when kernel crashes.
> >
> > Cc Skiboot and ppc64 community to see whether anyone has idea about it.
>
> What system are you using?

Here is the info, if not enough, I will get more.
 Product Name          : OpenPOWER Firmware
 Product Version       : open-power-SUPERMICRO-P9DSU-V1.16-20180531-imp
 Product Extra         : op-build-e4b3eb5
 Product Extra         : skiboot-v6.0-p1da203b
 Product Extra         : hostboot-f911e5c-pda8239f
 Product Extra         : occ-77bb5e6-p623d1cd
 Product Extra         : linux-4.16.7-openpower2-pbc45895
 Product Extra         : petitboot-v1.7.1-pf773c0d
 Product Extra         : machine-xml-218a77a

>
> There's an external interrupt pin which is supposed to be wired to the
> TPM. I think we bounce that interrupt to FW by default since the
> external interrupt is sometimes used for other system-specific
> purposes. Odds are FW doesn't know what to do with it so you
> effectively have an always-on LSI. I fixed a similar bug a while ago
> by having skiboot mask any interrupts it doesn't have a handler for,
This sounds like the root cause. But here Skiboot should have handler,
otherwise the first kernel can not run smoothly.

Do you have any idea about an unexpected re-initialization introducing
an unsane stage?

Thanks,
Pingfan
