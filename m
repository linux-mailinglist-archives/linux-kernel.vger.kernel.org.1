Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D52A631A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgKDLQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:16:08 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:35882 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgKDLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:16:08 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kaGlj-0007fJ-NY; Wed, 04 Nov 2020 12:15:59 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 0A4BFwZR010767
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 4 Nov 2020 12:15:58 +0100
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices
 on rk3399-roc-pc boards.
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dianders@chromium.org
References: <20201104094950.2096-1-m.reichl@fivetechno.de>
 <4984701.vSXMUKeAfh@diego>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
Message-ID: <4f4a83f2-3c9b-9549-0acf-057257b4255d@fivetechno.de>
Date:   Wed, 4 Nov 2020 12:15:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4984701.vSXMUKeAfh@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1604488568;20de08b6;
X-HE-SMSGID: 1kaGlj-0007fJ-NY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 04.11.20 um 11:51 schrieb Heiko Stübner:
> Hi Markus,
> 
> Am Mittwoch, 4. November 2020, 10:49:45 CET schrieb Markus Reichl:
>> Recently introduced async probe on mmc devices can shuffle block IDs.
>> Pin them to fixed values to ease booting in evironments where UUIDs
>> are not practical. Use newly introduced aliases for mmcblk devices from [1].
>> 
>> [1]
>> https://patchwork.kernel.org/patch/11747669/
>> 
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index e7a459fa4322..bc9482b59428 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -13,6 +13,11 @@ / {
>>  	model = "Firefly ROC-RK3399-PC Board";
>>  	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>>  
>> +	aliases {
>> +		mmc0 = &sdmmc;
>> +		mmc1 = &sdhci;
>> +	};
>> +
> 
> Any reason for this odering?

Without pinning roc-pc mostly booted as
mmcblk0 = sdmmc = µSD
mmcblk1 = sdhci = eMMC
so I kept this behaviour in aliases

roc-pc-mezzanine with populated SDIO-M2-slot booted
mmc0 = sdio = (no mmcblk)
mmcblk1 = sdmmc = µSD
mmcblk2 = sdhci = eMMC

With my aliases both boards behave the same now and the optional SDIO slot
goes out of the way to mmc2.

> 
> I.e. some previous incarnations had it ordered as (emmc, mmc, sdio).
> This is also true for the ChromeOS out-of-tree usage of those, the
> rk3399 dts in the chromeos-4.4 tree also orders this as sdhci, sdmmc, sdio.

The boards from my zoo (exynos, rk3399) mostly come up with SD-card as mmc0
and eMMC as mmc1 in mainline as opposed in some vendor kernels.
but I have no objection to set it the other way round if this is more common
with rk3399 boards.

> 
> And I guess a further question would be when we're doing arbitary orderings
> anyway, why is this not in rk3399.dtsi ;-) ?

I restricted the ordering to the boards I have, not to confuse other established
use cases, but if a standard ordering is desired this can go to rk3399.dtsi.

> 
> 
> Heiko
> 
> 

Gruß,
-- 
Markus Reichl
