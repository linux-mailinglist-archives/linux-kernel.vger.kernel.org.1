Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0072C263FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgIJI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgIJIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:17:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF2C061756;
        Thu, 10 Sep 2020 01:16:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3E3EF29B5AA
Subject: Re: [PATCH 1/2] arm64: dts: mt8173: elm: Set uart0 to mmio32 iotype
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200910054635.3337487-1-hsinyi@chromium.org>
 <ba77586c-7902-9ce4-0f4f-ad1743596d85@collabora.com>
 <CAJMQK-j_Syejw1Bc53fN8OuRYppns7g_=EQW+PUDkQDhnwxvSw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <944325c1-818e-934c-907d-7ff0493446b4@collabora.com>
Date:   Thu, 10 Sep 2020 10:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJMQK-j_Syejw1Bc53fN8OuRYppns7g_=EQW+PUDkQDhnwxvSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On 10/9/20 9:57, Hsin-Yi Wang wrote:
> On Thu, Sep 10, 2020 at 3:20 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Hsin-Yi,
>>
>> On 10/9/20 7:46, Hsin-Yi Wang wrote:
>>> Set uart0 iotype to mmio32 to make earlycon work with stdout-path.
>>>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> index a5a12b2599a4a..d54e62f72c65d 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>>> @@ -1160,6 +1160,8 @@ &thermal {
>>>  };
>>>
>>>  &uart0 {
>>> +     reg-io-width = <4>;
>>> +     reg-shift = <2>;
>>
>> I am wondering if these properties are common enough to go to mt8173.dtsi
>> instead of here.
>>
> Since stdout-path is set on elm.dtsi (using uart0), so I add this
> attribute here.
> 

Why needs to be defined in the same place that stdout-path is set?

My guess is that reg-io-width and reg-shift are SoC specific, as they define how
the IO access to the register is done. In fact, I think that these properties
should be added in all the uarts, not only the one that has defined the stdout-path.

Cheers,
  Enric
