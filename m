Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8D2B2925
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKMX2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:28:43 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39085 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMX2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:28:42 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C00EE240004;
        Fri, 13 Nov 2020 23:28:39 +0000 (UTC)
Date:   Sat, 14 Nov 2020 00:28:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Olof Johansson <olof@lixom.net>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: ./include/generated/autoconf.h:1601:33: fatal error:
 mach/debug-macro.S: No such file or directory
Message-ID: <20201113232839.GA6117@piout.net>
References: <202011111443.lt7V48Ig-lkp@intel.com>
 <CACRpkdbYXyVGf9_6PjmPgw_KNSEfiFVrmXWWmqLD-8Hmxg1xmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbYXyVGf9_6PjmPgw_KNSEfiFVrmXWWmqLD-8Hmxg1xmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 09:51:26+0100, Linus Walleij wrote:
> On Wed, Nov 11, 2020 at 7:18 AM kernel test robot <lkp@intel.com> wrote:
> 
> >    In file included from include/linux/kconfig.h:7,
> >                     from <command-line>:
> > >> ./include/generated/autoconf.h:1601:33: fatal error: mach/debug-macro.S: No such file or directory
> >     1601 | #define CONFIG_DEBUG_LL_INCLUDE "mach/debug-macro.S"
> >          |                                 ^~~~~~~~~~~~~~~~~~~~
> >    compilation terminated.
> 
> This is an interesting one!
> 
> It happens when CONFIG_DEBUG_LL_INCLUDE does not have a custom
> debug header for the platform under arch/arm/include/debug and the
> KConfig falls through to the default value, which is <mach/debug-macro.S>.
> 
> Only that the majority is not using <mach/*> anymore.
> 
> I feel a bit like setting the default to debug/8250.S or something.
> 
> Suggestions?
> 
> Then the actual bug exposed:
> 
> The config tested by the robot is using
> CONFIG_ARCH_AT91=y
> CONFIG_SOC_SAMV7=y
> 
> When I look into Kconfig.debug it seems that this will define
> DEBUG_AT91_SAMV7_USART1 but only a physical address,
> no virtual address and and actually no debug header. It seems
> LL_DEBUG is broken on SAMV7 and never really worked
> so now that crops up.
> 
> Nicolas, something that should be fixed, I think?
> 

This is what the platforms without an MMU are doing. I don't think there
is anything platform specific to fix.
