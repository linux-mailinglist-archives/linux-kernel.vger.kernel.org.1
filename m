Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7B2A640F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKDMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:18:00 -0500
Received: from foss.arm.com ([217.140.110.172]:36108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgKDMSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:18:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87CF61474;
        Wed,  4 Nov 2020 04:17:59 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE70B3F719;
        Wed,  4 Nov 2020 04:17:57 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices
 on rk3399-roc-pc boards.
To:     Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20201104094950.2096-1-m.reichl@fivetechno.de>
 <4984701.vSXMUKeAfh@diego>
 <4f4a83f2-3c9b-9549-0acf-057257b4255d@fivetechno.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3f0a710-91d8-0c05-35ab-9994fba16c82@arm.com>
Date:   Wed, 4 Nov 2020 12:17:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4f4a83f2-3c9b-9549-0acf-057257b4255d@fivetechno.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 11:15, Markus Reichl wrote:
> Hi Heiko,
> 
> Am 04.11.20 um 11:51 schrieb Heiko Stübner:
>> Hi Markus,
>>
>> Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
>>> Recently introduced async probe on mmc devices can shuffle block IDs.
>>> Pin them to fixed values to ease booting in evironments where UUIDs
>>> are not practical. Use newly introduced aliases for mmcblk devices 
>>> from [1].
>>>
>>> [1]
>>> https://patchwork.kernel.org/patch/11747669/
>>>
>>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi 
>>> b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>> index e7a459fa4322..bc9482b59428 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>>> @@ -13,6 +13,11 @@ / {
>>>      model = "Firefly ROC-RK3399-PC Board";
>>>      compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>>>
>>> +    aliases {
>>> +        mmc0 = &sdmmc;
>>> +        mmc1 = &sdhci;
>>> +    };
>>> +
>>
>> Any reason for this odering?
> 
> Without pinning roc-pc mostly booted as
> mmcblk0 = sdmmc = µSD
> mmcblk1 = sdhci = eMMC
> so I kept this behaviour in aliases
> 
> roc-pc-mezzanine with populated SDIO-M2-slot booted
> mmc0 = sdio = (no mmcblk)
> mmcblk1 = sdmmc = µSD
> mmcblk2 = sdhci = eMMC

FWIW that's also how my NanoPC-T4 behaves. Given that it's the order 
they appear in the DT, not too surprising ;)

Robin.

> With my aliases both boards behave the same now and the optional SDIO slot
> goes out of the way to mmc2.
> 
>>
>> I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
>> This is also true for the ChromeOS out-of-tree usage of those, the
>> rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc, 
>> sdio.
> 
> The boards from my zoo (exynos, rk3399) mostly come up with SD-card as mmc0
> and eMMC as mmc1 in mainline as opposed in some vendor kernels.
> but I have no objection to set it the other way round if this is more 
> common
> with rk3399 boards.
> 
>>
>> And I guess a further question would be when we're doing arbitary 
>> orderings
>> anyway, why is this not in rk3399.dtsi ;-) ?
> 
> I restricted the ordering to the boards I have, not to confuse other 
> established
> use cases, but if a standard ordering is desired this can go to 
> rk3399.dtsi.
> 
>>
>>
>> Heiko
>>
>>
> 
> Gruß,
