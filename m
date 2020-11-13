Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A42B296A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKMX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:58:07 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47761 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:58:06 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A898A1C0005;
        Fri, 13 Nov 2020 23:58:02 +0000 (UTC)
Date:   Sat, 14 Nov 2020 00:58:01 +0100
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
Message-ID: <20201113235801.GB6117@piout.net>
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

I confirm DEBUG_LL is not broken on SAMV7. The config used by lkp doen't
define DEBUG_AT91_SAMV7_USART1, it is not the culprit. Select it and the
problem is gone since DEBUG_AT91_SAMV7_USART1 selects DEBUG_AT91_UART
and DEBUG_LL_INCLUDE has:
default "debug/at91.S" if DEBUG_AT91_UART

Your issue is CONFIG_DEBUG_SEMIHOSTING

