Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826C02F7387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbhAOHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:09:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11390 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbhAOHJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:09:00 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DHC0z5krdz7Vkw;
        Fri, 15 Jan 2021 15:07:15 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 15:08:12 +0800
Message-ID: <60013F54.9050305@hisilicon.com>
Date:   Fri, 15 Jan 2021 15:08:04 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "Jamie Iles" <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        "Alexander Shiyan" <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tony Prisk <linux@prisktech.co.nz>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [v2] Old platforms: bring out your dead
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com> <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
In-Reply-To: <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2021/1/14 0:14, Arnd Bergmann wrote:
> On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> Just to catch up on the replies I received on my initial email, here
> is the updated status of all the Arm platforms I listed earlier, thanks
> for everyone that contributed information on these platforms!
> 
> These platforms were listed as likely unused and are now going to
> be kept around, as we wait for work on them to resume:
> 
> * axxia -- added in 2014, no notable changes after 2015
>   (Alexander Sverdlin has patches and volunteered as a maintainer)
> * bcm/kona -- added in 2013, no notable changes after 2014
>   (Found activity in PostmarketOS, waiting for usptreaming)
> * digicolor -- added in 2014, no notable changes after 2015
>   (Baruch still uses it, no changes needed)
> * dove -- added in 2009, obsoleted by mach-mvebu in 2015
>   (Russell still has patches for cubox, we might remove the other
>    boards that are converted to DT though)
> * nspire -- added in 2013, no notable changes after 2015
>   (Fabian and Daniel confirmed this is alive and well, more
>    hardware support is planned)
> * spear -- added in 2010, no notable changes since 2015
>   (My mistake in reading the changelog, should have been
>   on the second list. The platform is still active, and Mattias
>   Wallin plans to send more hardware support and cleanup
>   patches)
> 
> These platforms are confirmed to be dead upstream, and are going to
> be removed:
> 
> * efm32 -- added in 2011, first Cortex-M, no notable changes after 2013
> * picoxcell -- added in 2011, already queued for removal
> * prima2 -- added in 20111, no notable changes since 2015
> * tango -- added in 2015, sporadic changes until 2017, but abandoned
> * u300 -- added in 2009, no notable changes since 2013
> * zx --added in 2015 for both 32, 2017 for 64 bit, no notable changes
> 
> No reply yet, still planning for  removal. Oleksij and Tony, please
> confirm this is ok or let us know if we should keep them:
> 
> * asm9260 -- added in 2014, no notable changes after 2015
> * vt8500 -- added in 2010, no notable changes since 2014
> 
> These were on the original list of platforms that are likely still
> maintained and used despite their age, and I received a
> confirmation that this is true (some of them off-list)
> 
> * clps711x -- prehistoric, converted to multiplatform+DT in 2016
> * ep93xx -- added in 2006, LinusW still working on it, any users left?
> * footbridge -- added in prehistory, stable since ~2013, rmk and LinusW have one
> * gemini -- added in 2009, LinusW still working on it
> * highbank -- added in 2011, no changes after 2015, but Andre still uses it
> * iop32x -- added in 2006, no notable changes other than my cleanup, still used
> * ixp4xx -- prehistoric, but LinusW and I are still working on it
> * lpc32xx -- added in 2010, multiplatform 2019, hardware is EOL
> * nomadik -- added in 2009, LinusW keeps fixing it, probably no other users
> * orion5x -- DT support still active, board files support to get reviewed
>      for removal and conversion to DT individually
> * oxnas -- added in 2016, but already old then, few changes later
> * pxa -- prehistoric, but a few boards may still have users
> * rpc -- prehistoric, but I think Russell still uses his machine
> * sa1100 -- prehistoric, but rmk and LinusW sporadically working in it
> 
> For these I received no reply yet. Again, these will stay for the moment
> unless I get a reply, but if anyone has more information, please reply
> here to document the status (adding a few more people to Cc):
> 
> * mmp -- added in 2009, DT support is active, but board files might go
> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
> * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016

I think it is OK to drop the support of the hip01(arm32) and hip05(arm64).
Could you also help to drop the support of the hip04(arm32) which I think nobody use as well?
Thanks!

Best Regards,
Wei
