Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8A2F5CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbhANIwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbhANIwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:52:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C20A5239FD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610614280;
        bh=Rweiiv+Vqqb2vc5nsS6M0iSUIT6QSa4xnvtvHh0m7u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RbV0NrDu7hAY2KY7M6WURxC2C0I2fAtHayjuZYlDpS51nIRtNxkTqEYCDoJJNmjR+
         Fgk0XbvBbYJ5gZZYJiBa1bB9EUCfAX1h7lIWwLMn6KbWJu50e7a3bxkRv0gJJtYpAT
         eXuuXfWVddn4B9nFcfsxiicW/s4jB/+oN5GUmrpFWmNXgv4YqBR0ce3rRrCiPOLMoW
         4QNZ3bP6oGnl3+ktDAvYICSbN8h2B41kl007VAP2jyJY61G5D48PdoqskD2tQjFAqD
         zamRQRgR1TTM/ntILAN4qc4GxFz89DmnI/1GyCNczxnnrf6PRrCeMXuZzdN4F1/5lP
         s+DdwoSjFESzw==
Received: by mail-ot1-f48.google.com with SMTP id o11so4553498ote.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:51:20 -0800 (PST)
X-Gm-Message-State: AOAM530FGmHNOwXvk3RJt0yFXvQNcQBeLmcyEGuyztxVSzcHIEr3iXCx
        ddmm3pjtcZBYeYpoBRYuHkR7xfr3vRCR5h2iuEM=
X-Google-Smtp-Source: ABdhPJz+VkxNA8vFXBX+19qSZu61+eJVPgAGqzIHg2D8NDE6mDrMhRYBU8R4tlHhK4PsN6kNMFeH8ncEgkZNrAlH6Fw=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr3919945otr.210.1610614280071;
 Thu, 14 Jan 2021 00:51:20 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com> <m335z4ll07.fsf@t19.piap.pl>
In-Reply-To: <m335z4ll07.fsf@t19.piap.pl>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 14 Jan 2021 09:51:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2H=23o521OP1xgwRhkB3x6axnksdBW4vPX+-FUv2qF5A@mail.gmail.com>
Message-ID: <CAK8P3a2H=23o521OP1xgwRhkB3x6axnksdBW4vPX+-FUv2qF5A@mail.gmail.com>
Subject: Re: [v2] Old platforms: bring out your dead
To:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 8:00 PM Krzysztof Ha=C5=82asa <khalasa@piap.pl> wro=
te:
> Arnd Bergmann <arnd@kernel.org> writes:
>
> > For these I received no reply yet. Again, these will stay for the momen=
t
> > unless I get a reply, but if anyone has more information, please reply
> > here to document the status (adding a few more people to Cc):
> >
> > * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
>
> The following is what I sent to you a week ago. I don't say whether
> CNS3xxx support should stay or not, of course.
>
> Subject: Re: cns3xxx PCIe domain support
>
> Arnd Bergmann <arnd@kernel.org> writes:
>
> > For the cns3xxx case, I wonder if anyone actually cares. If
> > there are still users, the treewide change would make it trivial
> > to set it up right, while backporting would be harder. I noticed
> > that openwrt removed cns3xxx support in August with the
> > explanation that the platform is not used much anymore,
> > and I suspect that any users outside of openwrt stopped updating
> > their kernels long ago.
>
> I'm still using CNS3xxx-based Gateworks' boards (Laguna), with some
> custom patch set, but the last kernels are over 2 years old. I have some
> plan to update, but the probability it will happen very soon is rather
> low. I guess I will test and, if needed, fix it when the time comes.
>
> I'm not using them with OpenWrt, though.
> They are basically a platform for (the old, parallel, not express)
> mini-PCI cards and similar stuff. Nothing connected to the Internet etc.

Hi Krzysztof,

Thanks for your reply. I think I misremembered it from when you
originally said this in the other thread and thought you meant
you were unlikely to ever do it, not just for doing it soon.

No need to rush things then by removing it prematurely then, but it
might help if you could point to a git tree with your last working patches
in case someone else has a Laguna and wants to update it to a more
recent kernel before you do.

         Arnd
