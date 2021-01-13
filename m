Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FD2F5321
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbhAMTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:12:13 -0500
Received: from ni.piap.pl ([195.187.100.5]:53018 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbhAMTMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:12:12 -0500
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 14:12:12 EST
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id D6C8A442CEE;
        Wed, 13 Jan 2021 20:00:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D6C8A442CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1610564461; bh=uGPch0plRzGJXv12KMAcbJh5l5cGfXy0GW7mtMC5Sz4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Fu8qvEOHpxUoZifR0SCbszgYNZAY2i00ylcCetiUQhp/lNTqkMGpuDmu/s8VFqpWF
         3Nn0KQE2rgpFyDXbPrXIG943PntorcvJlPB3A5jC88mhhg/o85siJ+txfBAeQTw1EX
         YWasm9dzUKfBMCpDm2vdpVJrwqpP5Z/N5Bil3SuE=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [v2] Old platforms: bring out your dead
In-Reply-To: <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 13 Jan 2021 17:14:23 +0100")
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
        <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
Sender: khalasa@piap.pl
Date:   Wed, 13 Jan 2021 20:00:56 +0100
Message-ID: <m335z4ll07.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

Arnd Bergmann <arnd@kernel.org> writes:

> For these I received no reply yet. Again, these will stay for the moment
> unless I get a reply, but if anyone has more information, please reply
> here to document the status (adding a few more people to Cc):
>
> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left

The following is what I sent to you a week ago. I don't say whether
CNS3xxx support should stay or not, of course.

Subject: Re: cns3xxx PCIe domain support

Arnd Bergmann <arnd@kernel.org> writes:

> For the cns3xxx case, I wonder if anyone actually cares. If
> there are still users, the treewide change would make it trivial
> to set it up right, while backporting would be harder. I noticed
> that openwrt removed cns3xxx support in August with the
> explanation that the platform is not used much anymore,
> and I suspect that any users outside of openwrt stopped updating
> their kernels long ago.

I'm still using CNS3xxx-based Gateworks' boards (Laguna), with some
custom patch set, but the last kernels are over 2 years old. I have some
plan to update, but the probability it will happen very soon is rather
low. I guess I will test and, if needed, fix it when the time comes.

I'm not using them with OpenWrt, though.
They are basically a platform for (the old, parallel, not express)
mini-PCI cards and similar stuff. Nothing connected to the Internet etc.

--=20
Krzysztof Halasa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
