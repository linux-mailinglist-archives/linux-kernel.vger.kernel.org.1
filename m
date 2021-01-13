Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A52F4FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAMQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbhAMQPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:15:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226F62343B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610554481;
        bh=LRZtK9pyt0SpVoJz/B7j1psLWAogQheRZwfMXMgvX68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dTypzfx1QGHDlhNTrrRn9FL5sYmhbYHHroFOBmsgjFSJ7fzmiGKvvWp+vTAo+ZKL9
         wvGTLfc26f5K95sVoN138p2D6i1iipdwsLNO3dPlrRH0qsqz8Z8Xas84iz32WNlhBi
         8SHHO+hxHF8EY3sEL1+THECigmWs4Y7Qd/Dp2e9ONdPvHS2xb83ap0h/e3CZ696sMa
         ePIwNdq1LSKLtKND0E387cLblmQwMgRRtVluLSuX2l5hWtwE36HWq+tB0xWoMWpSsN
         4+hH3rthZdgtLWJI+6UOwCHxVHDW7rn3k6w+Kl4/S2dj6UX1Nz7Jph0FHR2O0sIV8k
         rZkH4GvFLoRkw==
Received: by mail-oi1-f179.google.com with SMTP id q25so2634632oij.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:14:41 -0800 (PST)
X-Gm-Message-State: AOAM530kTJI8Dg0ZyFElC1ZSrMQvTzdw74YLhYJSxtxbhppOurvtch1f
        borW2LJHKIz7sd+g6MprDCtjIQ2xPsWBrAN4+q4=
X-Google-Smtp-Source: ABdhPJz3Wpcu62os0B9sU+M69umsE4GDOJQxPr8IBN0g8xJFsdd376QN5BRpKwU8S6LmZ9dUPZxH0GLY6olDSQHf5W0=
X-Received: by 2002:aca:44d:: with SMTP id 74mr45594oie.4.1610554480192; Wed,
 13 Jan 2021 08:14:40 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Jan 2021 17:14:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
Message-ID: <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
Subject: [v2] Old platforms: bring out your dead
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
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
        Tony Prisk <linux@prisktech.co.nz>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:

Just to catch up on the replies I received on my initial email, here
is the updated status of all the Arm platforms I listed earlier, thanks
for everyone that contributed information on these platforms!

These platforms were listed as likely unused and are now going to
be kept around, as we wait for work on them to resume:

* axxia -- added in 2014, no notable changes after 2015
  (Alexander Sverdlin has patches and volunteered as a maintainer)
* bcm/kona -- added in 2013, no notable changes after 2014
  (Found activity in PostmarketOS, waiting for usptreaming)
* digicolor -- added in 2014, no notable changes after 2015
  (Baruch still uses it, no changes needed)
* dove -- added in 2009, obsoleted by mach-mvebu in 2015
  (Russell still has patches for cubox, we might remove the other
   boards that are converted to DT though)
* nspire -- added in 2013, no notable changes after 2015
  (Fabian and Daniel confirmed this is alive and well, more
   hardware support is planned)
* spear -- added in 2010, no notable changes since 2015
  (My mistake in reading the changelog, should have been
  on the second list. The platform is still active, and Mattias
  Wallin plans to send more hardware support and cleanup
  patches)

These platforms are confirmed to be dead upstream, and are going to
be removed:

* efm32 -- added in 2011, first Cortex-M, no notable changes after 2013
* picoxcell -- added in 2011, already queued for removal
* prima2 -- added in 20111, no notable changes since 2015
* tango -- added in 2015, sporadic changes until 2017, but abandoned
* u300 -- added in 2009, no notable changes since 2013
* zx --added in 2015 for both 32, 2017 for 64 bit, no notable changes

No reply yet, still planning for  removal. Oleksij and Tony, please
confirm this is ok or let us know if we should keep them:

* asm9260 -- added in 2014, no notable changes after 2015
* vt8500 -- added in 2010, no notable changes since 2014

These were on the original list of platforms that are likely still
maintained and used despite their age, and I received a
confirmation that this is true (some of them off-list)

* clps711x -- prehistoric, converted to multiplatform+DT in 2016
* ep93xx -- added in 2006, LinusW still working on it, any users left?
* footbridge -- added in prehistory, stable since ~2013, rmk and LinusW have one
* gemini -- added in 2009, LinusW still working on it
* highbank -- added in 2011, no changes after 2015, but Andre still uses it
* iop32x -- added in 2006, no notable changes other than my cleanup, still used
* ixp4xx -- prehistoric, but LinusW and I are still working on it
* lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL
* nomadik -- added in 2009, LinusW keeps fixing it, probably no other users
* orion5x -- DT support still active, board files support to get reviewed
     for removal and conversion to DT individually
* oxnas -- added in 2016, but already old then, few changes later
* pxa -- prehistoric, but a few boards may still have users
* rpc -- prehistoric, but I think Russell still uses his machine
* sa1100 -- prehistoric, but rmk and LinusW sporadically working in it

For these I received no reply yet. Again, these will stay for the moment
unless I get a reply, but if anyone has more information, please reply
here to document the status (adding a few more people to Cc):

* mmp -- added in 2009, DT support is active, but board files might go
* cns3xxx -- added in 2010, last fixed in 2019, probably no users left
* hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016
* lpc18xx -- added in 2015, new dts in 2018, but few other changes
* moxart -- added in 2013, last Tested-by in 2017
* mv78xx0 -- added in 2008, mostly stale but still users
  (https://github.com/1000001101000/Debian_on_Buffalo)

For the non-Arm platforms I listed, little has changed:

* Thomas Bogendoerfer confirms that he all the MIPS platforms and
  the R3000 CPU are still in active use
* Mark Salter steps down as the maintainer for C6x and the architecture
  will be removed
* No objection to removing arch/powerpc/platforms/cell that I
  had mentioned I plan to do.
* For the other architectures, a couple of users replied, but no
  architecture maintainer added any information, so I won't take
  any action.

         Arnd
