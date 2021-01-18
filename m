Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE712F9DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389881AbhARLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:16:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11400 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbhARKrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:47:07 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DK7j33pDQz7Wsv;
        Mon, 18 Jan 2021 18:45:11 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 18 Jan 2021 18:46:05 +0800
Message-ID: <600566ED.40906@hisilicon.com>
Date:   Mon, 18 Jan 2021 18:46:05 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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
        Krzysztof Halasa <khalasa@piap.pl>, <xuwei5@hisilicon.com>
Subject: Re: [v2] Old platforms: bring out your dead
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com> <CAK8P3a2DZ8xQp7R=H=wewHnT2=a_=M53QsZOueMVEf7tOZLKNg@mail.gmail.com> <60013F54.9050305@hisilicon.com> <CAK8P3a26Ca_59NiGGGv+CHYZSmkTRESpgV4aGFPhrY=KBa8aBA@mail.gmail.com> <14914300-b98a-fc60-fc06-0a6d62729d8e@huawei.com> <CAK8P3a3wXPANtLwPOHUqWw_EtdVwOJhwmUeT5WZbc7XKiyK7mQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3wXPANtLwPOHUqWw_EtdVwOJhwmUeT5WZbc7XKiyK7mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2021/1/15 20:04, Arnd Bergmann wrote:
> On Fri, Jan 15, 2021 at 12:09 PM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>> On 2021/1/15 17:26, Arnd Bergmann wrote:
>>> On Fri, Jan 15, 2021 at 8:08 AM Wei Xu <xuwei5@hisilicon.com> wrote:
>>>> On 2021/1/14 0:14, Arnd Bergmann wrote:
>>>>> On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>>>> * mmp -- added in 2009, DT support is active, but board files might go
>>>>> * cns3xxx -- added in 2010, last fixed in 2019, probably no users left
>>>>> * hisi (hip01/hip05) -- servers added in 2013, replaced with arm64 in 2016
>>>>
>>>> I think it is OK to drop the support of the hip01(arm32) and hip05(arm64).
>>>> Could you also help to drop the support of the hip04(arm32) which I think nobody use as well?
>>>
>>> Thank you for your reply! I actually meant to write hip04 instead of hip05,
>>> so I was only asking about the two 32-bit targets. I would expect that
>>> hip05 still has a few users, but wouldn't mind removing that as well if you
>>> are sure there are none.
>>>
>>> Since Zhen Lei is starting to upstream Kunpeng506 and Kunpeng509
>>> support, can you clarify how much reuse of IP blocks there is between
>>> hip04 and those? In particular, hip04 has custom code for (at least)
>>> platmcpm, clk, irqchip, ethernet, and hw_rng, probably more as those
>>> were only the ones I see on a quick grep.
>>>
>>> If we remove hip04, should we remove all these drivers right away,
>>> or keep some of them around?
>>
>> I think the drivers should be kept.
> 
> Ok, will do.
> 
>> Currently, at least hip04_eth.c and irq-hip04.c are used. These drivers
>> were originally written for Hip04, but the drivers used by other boards
>> maybe similar to them. Therefore, these drivers are extended without
>> adding new drivers.
> 
> Right, so the other chips just use compatible="hisilicon,hip04-intc"
> etc. in their device trees? Is there a public copy of the dts files
> somewhere that I can use for cross-referencing? Sorry if I'm
> messing up the timeline for your upstreaming plans.
> 
> It might actually be easier to leave hip01 and hip04 in the
> tree for the moment until you have upstreamed the other SoC
> support, and then we clean up by removing the unused bits
> afterwards. I'll leave it to you both to tell me which way is easier
> for you.

I have aligned with Leizhen and as you suggested it is better to keep them 
for the moment.
Thanks!

Best Regards,
Wei

> 
>       Arnd
> .
> 
