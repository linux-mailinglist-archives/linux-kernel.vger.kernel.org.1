Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCA2F7849
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbhAOMFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbhAOMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:05:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEAC5238EB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610712308;
        bh=3V9YgqwfCB9ETu7vLXXaseU8NA9t72oMsp6sjmLYI4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HUb+cSyHFudL1n0aRcQCKP9IbSE9++VdVFL/NMkaWcC5fzHtTosni2avPTVPydhKL
         5i4P9f7U3z+sB6nkAj6eGCDXnv3GuB+70YsYUWfq0qcbindDBbzFLzP9tWwApkLNHd
         acXap9ET5i/9XA1lRAYRn/Re6yQPY7qhMqpWP++FaQLkC9+1h27BC37VFU7uwj8+Xo
         chVtfya1zstM6CvsB/fIZtdOLapsZknEFjdCwv/JMZ2KgaUydwofdk/JtoMZPcQ8WN
         ha4FMRoc3APG0n1JysMdkn8MM/nq3YXbapcAXm5sWU/Zu9EkJopQpkGJrc5NT6h/8z
         5DFxy4fU9kEVw==
Received: by mail-ot1-f46.google.com with SMTP id b24so8312100otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:05:08 -0800 (PST)
X-Gm-Message-State: AOAM532kKyeFe/9TutznCkCy8QZAF0PoGWMnIA3epSKjRATDmfxQvqsi
        +nS037xbIi9A60XjVMVWwWtThEUaSI3S6fBP3uM=
X-Google-Smtp-Source: ABdhPJwDY0gtt9AZV/Oq8OAS9zQr424m/yvdwXMVC3cBMuaELzC4yGMUUWhDHXq8OJLgz0w6Q1ZXl+uSsK9+FqZ9ECA=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr7991233otm.305.1610712307942;
 Fri, 15 Jan 2021 04:05:07 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
 <60013F54.9050305@hisilicon.com> <CAK8P3a26Ca_59NiGGGv+CHYZSmkTRESpgV4aGFPhrY=KBa8aBA@mail.gmail.com>
 <14914300-b98a-fc60-fc06-0a6d62729d8e@huawei.com>
In-Reply-To: <14914300-b98a-fc60-fc06-0a6d62729d8e@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 15 Jan 2021 13:04:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wXPANtLwPOHUqWw_EtdVwOJhwmUeT5WZbc7XKiyK7mQ@mail.gmail.com>
Message-ID: <CAK8P3a3wXPANtLwPOHUqWw_EtdVwOJhwmUeT5WZbc7XKiyK7mQ@mail.gmail.com>
Subject: Re: [v2] Old platforms: bring out your dead
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tony Prisk <linux@prisktech.co.nz>,
        Krzysztof Halasa <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:09 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/1/15 17:26, Arnd Bergmann wrote:
> > On Fri, Jan 15, 2021 at 8:08 AM Wei Xu <xuwei5@hisilicon.com> wrote:
> >> On 2021/1/14 0:14, Arnd Bergmann wrote:
> >>> On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>> * mmp -- added in 2009, DT support is active, but board files might go
> >>> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
> >>> * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016
> >>
> >> I think it is OK to drop the support of the hip01(arm32) and hip05(arm64).
> >> Could you also help to drop the support of the hip04(arm32) which I think nobody use as well?
> >
> > Thank you for your reply! I actually meant to write hip04 instead of hip05,
> > so I was only asking about the two 32-bit targets. I would expect that
> > hip05 still has a few users, but wouldn't mind removing that as well if you
> > are sure there are none.
> >
> > Since Zhen Lei is starting to upstream Kunpeng506 and Kunpeng509
> > support, can you clarify how much reuse of IP blocks there is between
> > hip04 and those? In particular, hip04 has custom code for (at least)
> > platmcpm, clk, irqchip, ethernet, and hw_rng, probably more as those
> > were only the ones I see on a quick grep.
> >
> > If we remove hip04, should we remove all these drivers right away,
> > or keep some of them around?
>
> I think the drivers should be kept.

Ok, will do.

> Currently, at least hip04_eth.c and irq-hip04.c are used. These drivers
> were originally written for Hip04, but the drivers used by other boards
> maybe similar to them. Therefore, these drivers are extended without
> adding new drivers.

Right, so the other chips just use compatible="hisilicon,hip04-intc"
etc. in their device trees? Is there a public copy of the dts files
somewhere that I can use for cross-referencing? Sorry if I'm
messing up the timeline for your upstreaming plans.

It might actually be easier to leave hip01 and hip04 in the
tree for the moment until you have upstreamed the other SoC
support, and then we clean up by removing the unused bits
afterwards. I'll leave it to you both to tell me which way is easier
for you.

      Arnd
