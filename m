Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFA2D3BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgLIHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:03:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9560 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgLIHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:03:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrSdp2CYKzM2ZQ;
        Wed,  9 Dec 2020 15:01:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 15:02:28 +0800
Subject: Re: [PATCH v2 1/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings
 when make dtbs
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201207084752.1665-1-thunder.leizhen@huawei.com>
 <20201207084752.1665-2-thunder.leizhen@huawei.com>
 <CAK8P3a13CdDzdPOG_2ps4dXLaZC8jUDTPJDpp8Di-u87qBpRzQ@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <07a4d7d7-29e1-80dd-52de-315caafa1ebc@huawei.com>
Date:   Wed, 9 Dec 2020 15:02:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a13CdDzdPOG_2ps4dXLaZC8jUDTPJDpp8Di-u87qBpRzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/8 21:58, Arnd Bergmann wrote:
> On Mon, Dec 7, 2020 at 9:47 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The check_spi_bus_bridge() in scripts/dtc/checks.c requires that the node
>> have "spi-slave" property must with "#address-cells = <0>" and
>> "#size-cells = <0>". But currently both "#address-cells" and "#size-cells"
>> properties are deleted, the corresponding default values are 2 and 1. As a
>> result, the check fails and below warnings is displayed.
>>
>> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
>> /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
>>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
>> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): \
>> /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
>>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
>> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): \
>> Failed prerequisite 'spi_bus_bridge'
>>
>> Because the value of "#size-cells" is already defined as zero in the node
>> "ssp3: spi@d4037000" in arch/arm/boot/dts/mmp2.dtsi. So we only need to
>> explicitly add "#address-cells = <0>" and keep "#size-cells" no change.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Right, I already sent the same patch earlier.

Oh, sorry, I don't known it. If you send it earlier, please apply your patch!

> 
> Lubomir, can I apply this to the fixes branch?

This fix is really should be considered to merge into v5.10.

> 
>>  arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
>> index adde62d6fce73b9..82da44dacba7172 100644
>> --- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
>> +++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
>> @@ -224,7 +224,7 @@
>>
>>  &ssp3 {
>>         /delete-property/ #address-cells;
>> -       /delete-property/ #size-cells;
>> +       #address-cells = <0>;
>>         spi-slave;
>>         status = "okay";
>>         ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
>> --
>> 1.8.3
>>
>>
> 
> .
> 

