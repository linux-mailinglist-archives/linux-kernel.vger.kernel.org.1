Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99602A1D02
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKAJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgKAJxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:53:50 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF4C2224F;
        Sun,  1 Nov 2020 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604224430;
        bh=HyGP8CyzoSVv4MCtKqC0pz2ILBHefcA84mBlIyrXGQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMq+e5xfRYGK+MPaFvjA5XQ1EtstRGebvmfrK3+vfb+arDfLov6n8hi7lEhvA8JZE
         z40cxD0hw5blLj6L2UKYdnzi/5gtxIYmBfUclxCvOu7zyF6h6jCeq4xX2W5yTZ2wGD
         slN22E9LD6wvSE4f/dRWU2vJNnSXKl/+kfGMYbls=
Received: by mail-qt1-f178.google.com with SMTP id j62so7328369qtd.0;
        Sun, 01 Nov 2020 01:53:50 -0800 (PST)
X-Gm-Message-State: AOAM5317nET48x+nl/anPhsPgD35Tm3tPMqLzxGI6ic3QT5r6MSHLApG
        jWxlmLOLWyDqbxrrQ/3ba6fY0+eY/+0LM11vFeY=
X-Google-Smtp-Source: ABdhPJysxelGXEjcD+tK3eXvueDK0E9An/zQqCvczumw3UuNNLcEVvMETDYrwUeexoouBWqMdjrPCeGJVcKk4WzZomA=
X-Received: by 2002:ac8:7955:: with SMTP id r21mr9418714qtt.204.1604224429108;
 Sun, 01 Nov 2020 01:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20201030151758.1241164-1-arnd@kernel.org> <alpine.LNX.2.23.453.2011011441010.32@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2011011441010.32@nippy.intranet>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 1 Nov 2020 10:53:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Dg2UEN4MoVhHMUU=xd5x+uiue4nqZDeHBBK_CG6+LoA@mail.gmail.com>
Message-ID: <CAK8P3a3Dg2UEN4MoVhHMUU=xd5x+uiue4nqZDeHBBK_CG6+LoA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] timers: clean up ARCH_GETTIMEOFFSET, LEGACY_TIMER_TICK
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 4:47 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Fri, 30 Oct 2020, Arnd Bergmann wrote:
>
> > CONFIG_ARCH_GETTIMEOFFSET has been gradually phased out from all
> > platforms, with only ARM EBSA110 recently. As this has no more known
> > users, the first three patches remove EBSA110 along with one platform
> > specific driver and the ARCH_GETTIMEOFFSET infrastructure.
> >
>
> The CONFIG_ARCH_GETTIMEOFFSET patches weren't part of v1. Is there some
> kind of dependency here?

There is technically a dependency, though nobody would notice
in practice: removing the ARM timer tick function in patch 6 would
break the ebsa110 platform if we didn't first remove it in patch 1.
Changing ebsa110 to use legacy_timer_tick in turn would introduce
a conflict against the removal patch.

Neither of those is particularly harmful as there are no users of
the affected ebsa110 code, but keeping the two series together
avoids getting complaints from the build bots.

      Arnd
