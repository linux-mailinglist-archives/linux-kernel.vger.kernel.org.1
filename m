Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E72B65E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKQN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbgKQN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:58:54 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15282468D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605621532;
        bh=h0tP/2EDBP+w629n4RIUFP0ww+ilNgg3bULmsl5N/go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eO7ncMNKEnEk/C0m3RgjKwLdSouPFjHJwPBiE8nfas8R7lqi/yMmAXCOWSp3YpTyJ
         z5KMePS+uNSarTpLyw/daiN/5UYiZvg2fPxYMwkOYO/tRm+jSGqlVUMxiVLIIkirCC
         2OMu18Ps9RBdIzuMA3koS8dZNh1c+p4iPO77STR0=
Received: by mail-ot1-f43.google.com with SMTP id l36so19454654ota.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:58:52 -0800 (PST)
X-Gm-Message-State: AOAM5324Yj3Dc8NhjUt4rhrtZChiV9XFdWrB0k+V8xpcq3gLtMqNiNJU
        naWtYlaTih2UU9CKzGu/bITh2K3qLQwj+LEg8EQ=
X-Google-Smtp-Source: ABdhPJzWjY5Ize8OPQB6lZT19ylq0ipsqvKTMzVBF9gDabFABnJhhWpHeGx7Yx96l6oO+GI+kqjNKJtrAwz8bPTMKWw=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr2829215oth.251.1605621531812;
 Tue, 17 Nov 2020 05:58:51 -0800 (PST)
MIME-Version: 1.0
References: <202011111443.lt7V48Ig-lkp@intel.com> <CACRpkdbYXyVGf9_6PjmPgw_KNSEfiFVrmXWWmqLD-8Hmxg1xmg@mail.gmail.com>
 <20201113235801.GB6117@piout.net>
In-Reply-To: <20201113235801.GB6117@piout.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 17 Nov 2020 14:58:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MyLnULmUr4zgzkiWPiYfp+Xs8ruz9_q-PugVf_9DCCw@mail.gmail.com>
Message-ID: <CAK8P3a2MyLnULmUr4zgzkiWPiYfp+Xs8ruz9_q-PugVf_9DCCw@mail.gmail.com>
Subject: Re: ./include/generated/autoconf.h:1601:33: fatal error:
 mach/debug-macro.S: No such file or directory
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Olof Johansson <olof@lixom.net>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 12:58 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 11/11/2020 09:51:26+0100, Linus Walleij wrote:
> > On Wed, Nov 11, 2020 at 7:18 AM kernel test robot <lkp@intel.com> wrote:
> >
> > >    In file included from include/linux/kconfig.h:7,
> > >                     from <command-line>:
> > > >> ./include/generated/autoconf.h:1601:33: fatal error: mach/debug-macro.S: No such file or directory
> > >     1601 | #define CONFIG_DEBUG_LL_INCLUDE "mach/debug-macro.S"
> > >          |                                 ^~~~~~~~~~~~~~~~~~~~
> > >    compilation terminated.
> >
> > This is an interesting one!
> >
> > It happens when CONFIG_DEBUG_LL_INCLUDE does not have a custom
> > debug header for the platform under arch/arm/include/debug and the
> > KConfig falls through to the default value, which is <mach/debug-macro.S>.
> >
> > Only that the majority is not using <mach/*> anymore.
> >
> > I feel a bit like setting the default to debug/8250.S or something.
> >
> > Suggestions?
> >
> > Then the actual bug exposed:
> >
> > The config tested by the robot is using
> > CONFIG_ARCH_AT91=y
> > CONFIG_SOC_SAMV7=y
> >
> > When I look into Kconfig.debug it seems that this will define
> > DEBUG_AT91_SAMV7_USART1 but only a physical address,
> > no virtual address and and actually no debug header. It seems
> > LL_DEBUG is broken on SAMV7 and never really worked
> > so now that crops up.

The last mach/debug-macro.S file was apparently removed in 2015,
in commit 0045c0dd2f64 ("ARM: debug-ll: rework footbridge handling").
At that point we should have changed the fallback

> > Nicolas, something that should be fixed, I think?
> >
>
> I confirm DEBUG_LL is not broken on SAMV7. The config used by lkp doen't
> define DEBUG_AT91_SAMV7_USART1, it is not the culprit. Select it and the
> problem is gone since DEBUG_AT91_SAMV7_USART1 selects DEBUG_AT91_UART
> and DEBUG_LL_INCLUDE has:
> default "debug/at91.S" if DEBUG_AT91_UART
>
> Your issue is CONFIG_DEBUG_SEMIHOSTING

Right, in particular, semihosting is not handled in
arch/arm/boot/compressed/head.S the way it is handled in
arch/arm/boot/compressed/debug.S, arch/arm/kernel/debug.S
and arch/arm/kernel/head.S.

I wonder if we should move the semihosting code into a separate
arch/arm/include/debug/semihosting.S to make the generic
code treat it the same as all the other options.

Alternatively, disabling CONFIG_DEBUG_UNCOMPRESS
when SEMIHOSTING is set would be the cheapest workaround
for the particular build failure.

      Arnd
