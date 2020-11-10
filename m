Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763652AD314
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKJKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731960AbgKJKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:25 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF62421D91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605002664;
        bh=7IIeKX2s7WW6cbqVTlUhSpTs98HOO9ub/MiDrEiCkGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aiioJ9LI/t1gpemUaZVzG8Z7WiNDuMZzN9imH/b6vRNBRfDOULcqDgnFdD9S+u7Eb
         Iit/Fc/vfMYi84z0n1v+wybqXFNe+sYdrKUg6TARjwSZP3LU5iRR6jGWFOGEWN8EJL
         KxXq9xbUmnmHmQzZECoP3PWiDZ8nNHSrZXUykXxg=
Received: by mail-oo1-f53.google.com with SMTP id y3so2804042ooq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:23 -0800 (PST)
X-Gm-Message-State: AOAM531n1t62jwtXNTm2xMwajN8+JCbA0/3AtrSeVjX+LYfLXD846p0b
        7kI0N0J3sYzXtSH9JC9cyHKUfKjndau0TBKimyA=
X-Google-Smtp-Source: ABdhPJzELEiTqwIVykbdQnbr19rVSaEqCjteNtkrsDtuOjKZYvnYUaKufR4R8FuAkHtvScyNBRgsqB/c/ugejO5pWmU=
X-Received: by 2002:a4a:a217:: with SMTP id m23mr12940161ool.26.1605002663105;
 Tue, 10 Nov 2020 02:04:23 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk> <20201021125740.GM1551@shell.armlinux.org.uk>
 <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
 <20201109144549.GA26857@atomide.com> <CAK8P3a2tM1Gzy7Y98tiYGoNcLye77je_UCtTUQYcP2UuRNRKwQ@mail.gmail.com>
 <20201110091904.GC26857@atomide.com>
In-Reply-To: <20201110091904.GC26857@atomide.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 11:04:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dZMnEV-Sg_ep6_dQ3XEf73fEpCF0T03255KxMrJZH8g@mail.gmail.com>
Message-ID: <CAK8P3a3dZMnEV-Sg_ep6_dQ3XEf73fEpCF0T03255KxMrJZH8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
To:     Tony Lindgren <tony@atomide.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        v.narang@samsung.com, a.sahrawat@samsung.com,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:19 AM Tony Lindgren <tony@atomide.com> wrote:
> * Arnd Bergmann <arnd@kernel.org> [201109 19:10]:
> > On Mon, Nov 9, 2020 at 3:45 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > I know it works, my point was that I'm not sure anyone cares
> > any more ;-)
>
> Well for example whatever Linux running ARMv6 LTE modems out there might
> need to be supported for quite some time. Not sure how many of them are
> able to update kernels though. Certainly network security related issues
> would be a good reason to update the kernels.

While I agree they should update their kernels, I suspect none of those
modems do. I am however certain that none of them are running an
SMP-enabled multiplatform kernel on an ARM1136r0!

Are these actually ARMv6? Most ARM11 cores you'd come across
in practice are ARMv6K (ARM1136r1, ARM1167, ARM11MPCore),
in particular every SoC that has any mainline support except for
the ARM1136r0 based OMAP2 and i.MX3.

        Arnd
