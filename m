Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC267288A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgJIN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:57:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46214 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJIN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:57:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B941B29DE7B
Subject: Re: [PATCH 00/12] soc: mediatek: pm-domains: Add new driver for
 SCPSYS power domains controller
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     devicetree@vger.kernel.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, fparent@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <1601028361.1346.38.camel@mtksdaap41>
 <19678952-e354-2067-e619-ffac28b347be@gmail.com>
 <1601967207.8638.4.camel@mtksdaap41>
 <f2185b28-0b1f-8cf9-8717-12e28cf2bbf0@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <181df5c6-9046-5273-879b-ed0d1a59c8b3@collabora.com>
Date:   Fri, 9 Oct 2020 15:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f2185b28-0b1f-8cf9-8717-12e28cf2bbf0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/10/20 14:50, Matthias Brugger wrote:
> 
> 
> On 06/10/2020 08:53, Weiyi Lu wrote:
>> On Fri, 2020-09-25 at 16:04 +0200, Matthias Brugger wrote:
>>>
>>> On 25/09/2020 12:06, Weiyi Lu wrote:
>>>> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>>>>> Dear all,
>>>>>
>>>>> This is a new driver with the aim to deprecate the mtk-scpsys driver.
>>>>> The problem with that driver is that, in order to support more Mediatek
>>>>> SoCs you need to add some logic to handle properly the power-up
>>>>> sequence of newer Mediatek SoCs, doesn't handle parent-child power
>>>>> domains and need to hardcode all the clocks in the driver itself. The
>>>>> result is that the driver is getting bigger and bigger every time a
>>>>> new SoC needs to be supported.
>>>>>
>>>>
>>>> Hi Enric and Matthias,
>>>>
>>>> First of all, thank you for the patch. But I'm worried the problem you
>>>> mentioned won't be solved even if we work on this new driver in the
>>>> future. My work on the MT8183 scpsys(now v17) is to implement the new
>>>> hardware logic. Here, I also see related patches, which means that these
>>>> new logics are necessary. Why can't we work on the original driver?
>>>
>>> Well the decision was to change the driver in a not compatible way to make
>>> device tree entries better. If we work on the old driver, we would need to find
>>> some creative ways to handle old bindings vs new bindings.
>>>
>>> So I thought it would be better doing a fresh start implementing mt1873 support
>>> for reference and add mt8183 as new SoC. From what I have seen mt8192 and others
>>> fit the driver structure too.
>>>
>>>> Meanwhile, I thought maybe we should separate the driver into general
>>>> control and platform data for each SoC, otherwise it'll keep getting
>>>> bigger and bigger if it need to be support new SoC.
>>>>
>>>
>>> We could in a later series split the SoC depended data structures and put them
>>> in drivers/soc/mediatek/pm-domains-mt8183.h or something like this. Is that what
>>> you mean?
>>>
>>
>> Yes, that is what I want. And I guess it could avoid the collisions in
>> the different defines to the control registers and power status bits you
>> mentioned. Hope this will happen in this series.
>>
> 
> Sounds good to me. Enric could you move the soc specific data to separate
> include files?
> 

Sure, I'll do this in v4.

Thanks,
 Enric

> Regards,
> Matthias
> 
