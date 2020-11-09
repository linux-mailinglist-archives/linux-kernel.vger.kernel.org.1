Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E202AC4B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgKITKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgKITKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:10:48 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91B120781
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604949047;
        bh=3GZSXnDY/4VW+T6OBozDfktu51uTkDhfRjwsCBd4s/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SOJdy0+DXFwGyE41OgNUYc3ykCl35DJVCdXX4buSc9oi/DNR5uJJhbeJ6gmf7IqGy
         vrvMKlfWA+YbD8imK3r5KociJNHHkIuJ+uVDM9TX49hK3hKV1TiKQr59nNpbrgVpew
         wAVcTThMswUke6ZmGUfbQt3YqoXJdQJbMtlKJDGI=
Received: by mail-ot1-f42.google.com with SMTP id 32so10050496otm.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:10:46 -0800 (PST)
X-Gm-Message-State: AOAM533MjB6MFxy3mJ2Wlp9PbckONu9YYdHfI2YqQXP7q4sHumJZUchk
        3/Hov19wrLbCjy2zMdb3kIB6xMp2wGCBly6pD+U=
X-Google-Smtp-Source: ABdhPJy/aPuLCY9Xfg0r2peivRY3rAnNzum8JYo2dyP/lzpT91+Pn3Zdok45eAJtH8S1O7owA4UbnhGnO/lv8Zze/r8=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr10408283otc.305.1604949046185;
 Mon, 09 Nov 2020 11:10:46 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk> <20201021125740.GM1551@shell.armlinux.org.uk>
 <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com> <20201109144549.GA26857@atomide.com>
In-Reply-To: <20201109144549.GA26857@atomide.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 9 Nov 2020 20:10:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2tM1Gzy7Y98tiYGoNcLye77je_UCtTUQYcP2UuRNRKwQ@mail.gmail.com>
Message-ID: <CAK8P3a2tM1Gzy7Y98tiYGoNcLye77je_UCtTUQYcP2UuRNRKwQ@mail.gmail.com>
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

On Mon, Nov 9, 2020 at 3:45 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > As discussed on IRC, I think it can still be done in one of these
> > ways, though admittedly none of them are perfect:
> >
> > a) add runtime patching for __my_cpu_offset() when
> >   CONFIG_SMP_ON_UP is set. This adds complexity but avoids the
> >   fallback for for SMP&&CPU_V6. It possibly also speeds up
> >   running on single-cpu systems if the TPIDRPRW access adds
> >   any measurable runtime overhead compared to patching it out.
>
> Out of these options a) sounds best to me.

Ok. Maninder, would you like to give implementing this a try?

> > b) If irq stacks are left as a compile-time option, that could be
> >   made conditional on "!(SMP&&CPU_V6)". Presumably very
> >   few people still run kernels built that way any more. The only
> >   supported platforms are i.MX3, OMAP2 and Realview-eb, all of
> >   which are fairly uncommon these days and would usually
> >   run v6-only non-SMP kernels.
>
> This has been working just fine for years though. In general,
> removing the conditional compile ifdefferey has made things quite
> a bit easier for us, so let's continue on that.
>
> > c) If we decide that we no longer care about that configuration
> >   at all, we could decide to just make SMP depend on !CPU_V6,
> >   and possibly kill off the entire SMP_ON_UP patching logic.
> >   I suspect we still want to keep SMP_ON_UP for performance
> >   reasons, but I don't know how significant they are to start with.
>
> And this too has been working just fine for years :)

I know it works, my point was that I'm not sure anyone cares
any more ;-)

I suppose the existence of omap2plus_defconfig and
imx_v6_v7_defconfig means it does at least get tested
regularly.

       Arnd
