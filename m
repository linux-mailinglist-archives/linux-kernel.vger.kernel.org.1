Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40D2F1ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbhAKQYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbhAKQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:24:32 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F6C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:23:52 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id b24so244743otj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmXn46rP+BaKQyxOgQBKEYZQEKAQfc5XpHXYQHAtgII=;
        b=BPe92uclYLFDR0p/J+cSR5nmkhaOSMmsbA/TBj3A49dWE3vwu2zYfi6fQ7siE2YyW7
         j40ihLrlfq3VvOZ9xmTsAn44Ub+bkJb+JbGCDhD3VQQbd3boukGzPTURKpxZhO43vOf+
         2Y2LE1ipJskxpX3f5gH4okQnYQ6+xSMBnaJ1+qsO/J0TFwgmfa7eiaN1p/KWEtjiehYr
         5dGlfM+Wk1n8D+lFJ5W84KJXEC7lcy//zOnUBbzf88L2IVNbhsCoX7vFG5KeWDYMvPuL
         hNrZqaZB47oERt/xYF5BABEWpaGbSxxDzYBP371fDW1S8F7yeuXaytc13sbWSPMpDpIt
         16wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmXn46rP+BaKQyxOgQBKEYZQEKAQfc5XpHXYQHAtgII=;
        b=i01L8I5d7vngNXVM6APwGe6/OMPxrh0B0kRenXKFlQ55Ka84oPdwcivKuHWirdAUG9
         NyJNoIVwQN1+1OBV93JZDTChRjNDTZTlmMYTN63GkbH0/q7FyqCCnaCsk507tqHjRkzp
         3VPYve3hFAitSSreyrlR8vNp4YPFGjGlNa25xiMoCfN0rRp9rtoEhQuI620j8WHDiYQj
         fewCabD6dZ7On0rnSQUJctS+DYsOxY6s36T/2xkr6OQFGhi9obycTv6W7VFMEH9pNr5G
         nxxI4zKnclLZIRPzjnLAy9iV9x+Y2QDj5e+vpzxOG74s8dJLyki8aF4HRQgfIPE+CN3R
         /iOQ==
X-Gm-Message-State: AOAM5312T6njZmzhMTMvnMN8KUM0KMh00GUIe40PqBKEagTTOB31QO6u
        tYAz/1v2YlMLHgMVdc4y0Hjzl1WUzg7mXES1v0k=
X-Google-Smtp-Source: ABdhPJxqkQAbn1CJmiwyk59dOTsA7XNwMGTG5pS6UjDSh8zt5YmwlaKKziWPmGoX67+7qLJXA/QfHqk54k0WnJ5a5nI=
X-Received: by 2002:a05:6830:1be4:: with SMTP id k4mr11266179otb.271.1610382231703;
 Mon, 11 Jan 2021 08:23:51 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Mon, 11 Jan 2021 11:23:40 -0500
Message-ID: <CA+rxa6o4P0ZC-Ww_BTssN2KuKkdh8TSopY-F=0ECExNjTVF3Fw@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alex Elder <elder@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

According to NXP
(https://www.nxp.com/products/product-information/product-longevity:PRDCT_LONGEVITY_HM),
the LPC32xx is still an active product (although it was listed for 10
years in 2009).

We still have active products in the field with this MCU and we are
still shipping products with the LPC3250.

I think this platform should remain in the kernel for now.


Regards,
Sylvain Lemieux

On Fri, Jan 8, 2021 at 5:58 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> After v5.10 was officially declared an LTS kernel, I had a look around
> the Arm platforms that look like they have not seen any patches from
> their maintainers or users that are actually running the hardware for
> at least five years (2015 or earlier). I made some statistics and lists
> for my lwn.net article last year [1], so I'd thought I'd share a summary
> here for discussion about what we should remove. As I found three
> years ago when I removed several CPU architectures, it makes sense
> to do this in bulk, to simplify a scripted search for device drivers, header
> files and Kconfig options that become unused in the process.
>
> This is probably a mix of platforms that are completely unused and
> those that just work, but I have no good way of knowing which one
> it is. Without hearing back about these, I'd propose removing all of
> these:
>
> * asm9260 -- added in 2014, no notable changes after 2015
> * axxia -- added in 2014, no notable changes after 2015
> * bcm/kona -- added in 2013, no notable changes after 2014
> * digicolor -- added in 2014, no notable changes after 2015
> * dove -- added in 2009, obsoleted by mach-mvebu in 2015
> * efm32 -- added in 2011, first Cortex-M, no notable changes after 2013
> * nspire -- added in 2013, no notable changes after 2015
> * picoxcell -- added in 2011, already queued for removal
> * prima2 -- added in 20111, no notable changes since 2015
> * spear -- added in 2010, no notable changes since 2015
> * tango -- added in 2015, sporadic changes until 2017, but abandoned
> * u300 -- added in 2009, no notable changes since 2013
> * vt8500 -- added in 2010, no notable changes since 2014
> * zx --added in 2015 for both 32, 2017 for 64 bit, no notable changes
>
> If any of the above are not dead yet[2], please let me know,
> and we'll keep them.
>
> Then there are ARM platforms that are old but have still seen some work
> in the past years. If I hear nothing, these will all stay, but if maintainers
> may want to drop them anyway, I can help with that:
>
> * clps711x -- prehistoric, converted to multiplatform+DT in 2016, no
> changes since
> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
> * ep93xx -- added in 2006, LinusW still working on it, any users left?
> * footbridge -- added in prehistory, stable since ~2013, rmk and LinusW have one
> * gemini -- added in 2009, LinusW still working on it
> * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016
> * highbank -- added in 2011, no changes after 2015, but Andre still uses it
> * iop32x -- added in 2006, no notable changes other than my cleanup, but
>   I think there are still users
> * ixp4xx -- prehistoric, but LinusW and I are still working on it
> * lpc18xx -- added in 2015, new dts in 2018, but few other changes
> * lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL
> * mmp -- added in 2009, DT support is active, but board files might go
> * moxart -- added in 2013, last Tested-by in 2017
> * mv78xx0 -- added in 2008, mostly stale but still users
>   (https://github.com/1000001101000/Debian_on_Buffalo)
> * nomadik -- added in 2009, LinusW keeps fixing it, probably no other users
> * oxnas -- added in 2016, but already old then, few changes later
> * pxa -- prehistoric, but a few boards may still have users
> * rpc -- prehistoric, but I think Russell still uses his machine
> * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it
>
> I also looked at non-ARM platforms while preparing for my article. Some of
> these look like they are no longer actively maintained or used, but I'm not
> doing anything about those unless the maintainers would like me to:
>
> * h8300: Steven Rostedt has repeatedly asked about it to be removed
>    or fixed in 2020 with no reply. This was killed before in 2013, added back
>    in 2015 but has been mostly stale again since 2016
> * c6x: Added in 2011, this has seen very few updates since, but
>     Mark still Acks patches when they come. Like most other DSP platforms,
>     the model of running Linux on a DSP appears to have been obsoleted
>     by using Linux on ARM with on-chip DSP cores running bare-metal code.
> * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
>    is currently under review
> * powerpc/cell: I'm the maintainer and I promised to send a patch to remove it.
>    it's in my backlog but I will get to it. This is separate from PS3,
> which is actively
>    maintained and used; spufs will move to ps3
> * powerpc/chrp (32-bit rs6000, pegasos2): last updated in 2009
> * powerpc/amigaone: last updated in 2009
> * powerpc/maple: last updated in 2011
> * m68k/{apollo,hp300,sun3,q40} these are all presumably dead and have not
>    seen updates in many years (atari/amiga/mac and coldfire are very much
>    alive)
> * mips/jazz: last updated in 2007
> * mips/cobalt: last updated in 2010
>
> There might be some value in dropping old CPU support on architectures
> and platforms that are almost exclusively used with more modern CPUs.
> If there are only few users, those can still keep using v5.10 or v5.4 stable
> kernels for a few more years. Again, I'm not doing anything about them,
> except mention them since I did the research.
> These are the oldest one by architecture, and they may have reached
> their best-served-by-date:
>
> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>   indications that 486 have no users either on recent kernels.
>   There is still the Vortex86 family of SoCs, and the oldest of those were
>   486SX-class, but all the modern ones are 586-class.
> * Alpha 2106x: First generation that lacks some of the later features.
>   Since all Alphas are ancient by now, it's hard to tell whether these have
>   any fewer users.
> * IA64 Merced: first generation Itanium (2001) was quickly replaced by
>   Itanium II in 2002.
> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>   supports these in DECstation and Toshiba Txx9, but it appears that most
>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
>   later are rather different and widely used.
> * PowerPC 601 (from 1992) just got removed, later 60x, 4xx, 8xx etc
>   are apparently all still used.
> * SuperH SH-2: We discussed removing SH-2 (not J2 or SH-4)
>   support in the past, I don't think there were any objections, but
>   nobody submitted a patch.
> * 68000/68328 (Dragonball): these are less capable than the
>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
>   that was removed in 2016.
>
>         Arnd
>
> [1] https://lwn.net/Articles/838807/
> [2] https://www.youtube.com/watch?v=Jdf5EXo6I68
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
