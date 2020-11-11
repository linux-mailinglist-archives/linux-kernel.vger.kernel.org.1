Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5F2AEC57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKKIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKIvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:51:39 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727FC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:51:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so1162386ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8bXg1amCva6L1BZNvv9NOL5If1TZuwvQTOK9it0P1I=;
        b=vTkloo5z5bEqhILL0UKrT4QWDrQHuoFYM37ZYgNeoGfyGFZhlrbain5hhU3TLdINzF
         QkJt3gYEzMFKKrIrNk4G8vEc9jcudLwfG6az8SBM7uZwMwrFwgg2P8V0bhtNOavoayxT
         gKia/P1Y4PUXWBj0pzsUuPsf2uxjwTLFebawsDcLPaY5uEv9J228hc2w2b9vk/QPJZlD
         hs7DXmznb2gRuA40coaK8mn1fuKnn6aLphbksrvmb+aUOghBxhlrfM9DtM+4/UIoUJih
         0qCB8keg/KV8BBA6CRqsovPXNRAvxJVUU2T7LQeJKCfcrT8RSbc7uqd00TJl5VzkSOa9
         LFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8bXg1amCva6L1BZNvv9NOL5If1TZuwvQTOK9it0P1I=;
        b=k6klfYhI22w1qclyqR5JWmLi60ToUceIOePue/SuyKbOOoqwiFsD1ypJjszEAs5cRL
         akkForChWcj0dmUSC0lLGmk6Ep+B3VTClV3UKJ5qF9jtGcykzgsev5qrDfrqEqVYlDdk
         euycqKxh6qxFzXOhh+RekqVo42qYGmaDhA//qsH7zCI3kReut/4jlgn0VhNfVrCCACjM
         dlPHnZtezq22JB8U18kZGua8zhDHXtuyBQI+dxAc89BDV33AzSIUY/ztOcHzFLXxhuuj
         VrmS/q0AXPiblyWoi61pfmSh9NadiMD+VzJoCFvS7veQSnjl171n9HxCVs4Cf2Jrpdxe
         /INw==
X-Gm-Message-State: AOAM531aAoIjncAqQWc/V+UvIuxksiYlM1SSbfZB6bC0XTSp7DwtNDPO
        jD91P7i8/kgbuAc6uOkEpCOPoJdfa9UWzyK+I6jXWQ==
X-Google-Smtp-Source: ABdhPJwZJ2pi/kSmOtA8gbDLhBCbSbTC58csx1FMOlPjNZ4CYiUMZhvLU8xIm8Lue75PRSuTxiRNjSOe3BelyRBOF7I=
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr10837211ljg.286.1605084697617;
 Wed, 11 Nov 2020 00:51:37 -0800 (PST)
MIME-Version: 1.0
References: <202011111443.lt7V48Ig-lkp@intel.com>
In-Reply-To: <202011111443.lt7V48Ig-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 09:51:26 +0100
Message-ID: <CACRpkdbYXyVGf9_6PjmPgw_KNSEfiFVrmXWWmqLD-8Hmxg1xmg@mail.gmail.com>
Subject: Re: ./include/generated/autoconf.h:1601:33: fatal error:
 mach/debug-macro.S: No such file or directory
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Olof Johansson <olof@lixom.net>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 7:18 AM kernel test robot <lkp@intel.com> wrote:

>    In file included from include/linux/kconfig.h:7,
>                     from <command-line>:
> >> ./include/generated/autoconf.h:1601:33: fatal error: mach/debug-macro.S: No such file or directory
>     1601 | #define CONFIG_DEBUG_LL_INCLUDE "mach/debug-macro.S"
>          |                                 ^~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

This is an interesting one!

It happens when CONFIG_DEBUG_LL_INCLUDE does not have a custom
debug header for the platform under arch/arm/include/debug and the
KConfig falls through to the default value, which is <mach/debug-macro.S>.

Only that the majority is not using <mach/*> anymore.

I feel a bit like setting the default to debug/8250.S or something.

Suggestions?

Then the actual bug exposed:

The config tested by the robot is using
CONFIG_ARCH_AT91=y
CONFIG_SOC_SAMV7=y

When I look into Kconfig.debug it seems that this will define
DEBUG_AT91_SAMV7_USART1 but only a physical address,
no virtual address and and actually no debug header. It seems
LL_DEBUG is broken on SAMV7 and never really worked
so now that crops up.

Nicolas, something that should be fixed, I think?

Yours,
Linus Walleij
