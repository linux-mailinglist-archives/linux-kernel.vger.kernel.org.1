Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194C12F6F49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbhAOAKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:10:06 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1201 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731040AbhAOAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:10:06 -0500
Received: from thorin.petrovitsch.priv.at (80-110-120-15.cgn.dynamic.surfer.at [80.110.120.15])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 10F03Ikx015508
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 15 Jan 2021 01:03:19 +0100
Message-ID: <6437080014a3a9af63f2c50b620f389c1f104e91.camel@petrovitsch.priv.at>
Subject: Re: Old platforms: bring out your dead
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
        Yoshinori Sato <ysato@users.osdn.me>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Fri, 15 Jan 2021 01:03:14 +0100
In-Reply-To: <CAHp75VceqwbfQ=z34K=soKu4-qvLVEtobFg1sO4jukRcT7BXBg@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
         <20210109055645.GA2009@1wt.eu>
         <CAK8P3a1C+EUvyLm3fo8TGOV39hhaxhtDM3cX_QLc-=WCzRksMw@mail.gmail.com>
         <6fb7e3f5035d44fab9801001f1811b59@AcuMS.aculab.com>
         <CAHp75Vf43_zqDX9K4GmkRd7fujY2zC8=LneSMFpC2qnJL_uG1A@mail.gmail.com>
         <CACRpkdaH-1s8DnRUPVRSQgqUE99MdWjKGLv_y6iYnXU6p4dwUg@mail.gmail.com>
         <CAHp75Ve3QqLqe2sQhNgdrDfKm2uSwXFwMr5_GgGf3tiuCp2DBQ@mail.gmail.com>
         <CAHp75VceqwbfQ=z34K=soKu4-qvLVEtobFg1sO4jukRcT7BXBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-wuwien-Metrics: esgaroth.tuxoid.at 1290; Body=35 Fuz1=35 Fuz2=35
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.5 required=5.0 tests=AWL,UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.1
X-Spam-Report: *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
        * -0.5 AWL AWL: Adjusted score from AWL reputation of From: address
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on esgaroth.tuxoid.at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-13 at 14:21 +0200, Andy Shevchenko wrote:
[...]
> WRT x86 I run the search
> https://pc104.org/product-search-results/?kw=x86&post_tag=&product_type=&specifications=&pc-bus-technology=&user=Filter+by+Member+Company
> seems like all of them are based on Vortex86DX.

There are some real/true PC104 boards left -
still in production - with boards (though
they tend to loose features like
"memory-mapping over the ISA-bus").

One is a - according to /proc/cpuinfo - a
"Intel(R) Atom(TM) CPU  E3825  @ 1.33GHz".

Sry, I cannot get the product name.

MfG,
	BErnd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
There is no cloud, just other people computers. - FSFE
                     LUGA : http://www.luga.at


