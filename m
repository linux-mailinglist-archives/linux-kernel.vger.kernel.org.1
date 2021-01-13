Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FA2F48B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAMKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbhAMKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:31:07 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9710C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:30:27 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n25so1238525pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/KHSc+co25Ee+m78xXCVatn+3QKJ7s6fzi+4PHbpWI=;
        b=BbAwqI6teqSAc6KDwQj4fLhQFjvM/5r5+sriDGi+g35ai9VawnmiJRKkFp9spkL7fk
         lfeCAVO0nkP32c2PyVlApc3YP89YaVjAKZvWGnhK71ZvdvScooYAnQ9rGc32yLJxmOJQ
         xgrbpNImi36EKo3ozUwIRfMEKPsjLU3Afw4jxrzAcXbix7ZPt5dhmzxgMUgXLQ7a+RV6
         5igSD1TGtEbhC3k/eZIeCykmHD6m2KgM86Q9EZK38gP5HxA05c5pk3U0IChUsskfFHLL
         8+OwBGQDa4TahBtpXE5ja9e02SYjIACQ68hhDC1dw+hLRy4mJQ/Q11BXekz91gnWwr3x
         7ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/KHSc+co25Ee+m78xXCVatn+3QKJ7s6fzi+4PHbpWI=;
        b=sDb682nMJ+FB8SVXzWORJPxU1an+aEoxPzLaeyU5H/YJQlEnWfYgzGgxqBqqdtulTn
         vygP22exXpM0kqn6uATqeRmTSZyr4B06ACCjyqFleb7BEbkAQC59uBUAmkif3uGLpHlN
         c/WIDCzRc3ZD2AG2e2njbtBWPPri/CGr05xfB8shCy+tFkA3AbkmaczcF7rZE1ZRn3do
         pSwn67TgX8+D2dQA5Z1m8pvZcgVkYsabXMCHzroETACw2w8Lri7SMowTB+NanpoiPV+x
         LpVnf57B6BsZXvM0Yq4o8n0zwOzwO9WZq0OZu62jc7b6I4+rULJQqAVRV9EEenfb126o
         1IFA==
X-Gm-Message-State: AOAM5337GK0Z7I+0k0WwrtmThOs5pPDV/h4G0fFPGvM269gRAms916uL
        6w0uaDqnjl76qbyYmUp3HCKpJ0Npc7xMOuD1kvo=
X-Google-Smtp-Source: ABdhPJy6FsxTRaHgaub12BE8T3GrG3UmPrpX/ArkijF8P5oCBqxj4RlpEBYiirx9mhQT6O4LcrpRKBAmDKjPT/bpUrE=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr1501920pfz.73.1610533827214; Wed, 13
 Jan 2021 02:30:27 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jan 2021 12:30:10 +0200
Message-ID: <CAHp75Vc8Hie93N++o1rTmJ_L=oM51XpHtqqKH+OByV8RtoRQ0g@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 12:58 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> After v5.10 was officially declared an LTS kernel,

I have a question here. Maybe I have missed something, but how LTS
helps in this case? LTS AFAIR has a rule "upstream first". How can you
provide a patch to be backported if there is no upstream for it
anymore?

> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>   indications that 486 have no users either on recent kernels.
>   There is still the Vortex86 family of SoCs, and the oldest of those were
>   486SX-class, but all the modern ones are 586-class.
> * Alpha 2106x: First generation that lacks some of the later features.
>   Since all Alphas are ancient by now, it's hard to tell whether these have
>   any fewer users.

We still have Intel Quark available. I run vanilla from time to time
on it due to the presence of peripherals I can't find elsewhere on x86
boards.

-- 
With Best Regards,
Andy Shevchenko
