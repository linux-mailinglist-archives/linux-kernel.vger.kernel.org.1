Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCC2871BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgJHJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:41:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgJHJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:41:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0989f4DS026050;
        Thu, 8 Oct 2020 04:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602150064;
        bh=fmnTnaxNK7vcj4oUYy5xvoT+SbngQIFMGE0hDhvvrZ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=caOCcWCXC+CrNOthQkz8wWJpzXE24uzhqlnNwMQoQWS+y4nWJPa8HILQYkjirDY88
         XTJ+Rle3RDpxoNoWNqBMKq2BmITgoAq2PcvNsfLvBRO4fwaoxT+RIp1/RvGNkM07VW
         i+kJB8q70z0QqBkdvXUPdXtI7rn/rKK9G+QXy1qM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0989f46W075674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 04:41:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 04:41:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 04:41:04 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0989ewVC122503;
        Thu, 8 Oct 2020 04:41:00 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
 <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
 <f8877ca8-fe32-29e5-cb0c-2ce0af3eb73a@ti.com>
 <0b46dc95-6778-7f01-395a-8d4eaf33b0f7@ti.com>
 <51978593-fe09-3740-ef90-deac8ef3d2f2@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <142b9d12-ea65-320f-aef9-583389aabb3e@ti.com>
Date:   Thu, 8 Oct 2020 15:10:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <51978593-fe09-3740-ef90-deac8ef3d2f2@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tero,

On 08/10/20 2:49 pm, Tero Kristo wrote:
> On 08/10/2020 11:59, Faiz Abbas wrote:
>> Tero,
>>
>> On 06/10/20 6:40 pm, Tero Kristo wrote:
>>> On 06/10/2020 16:03, Faiz Abbas wrote:
>>>> Hi Tero,
>>>>
>>>> On 06/10/20 5:21 pm, Tero Kristo wrote:
>>>>> On 02/10/2020 19:45, Faiz Abbas wrote:
>>>>>> The following patches enable configs in the arm64 defconfig to support
>>>>>> GPIO and I2C support on TI's J721e platform.
>>>>>>
>>>>>> Faiz Abbas (2):
>>>>>>      arm64: defconfig: Enable OMAP I2C driver
>>>>>>      arm64: defconfig: Enable DAVINCI_GPIO driver
>>>>>>
>>>>>>     arch/arm64/configs/defconfig | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>
>>>>> Why are you enabling these?
>>>>>
>>>>> Are they required for booting the board?
>>>>>
>>>>> If not, they shall not be enabled, as it just clutters the arm64 defconfig unnecessarily.
>>>>>
>>>>
>>>> They are required because the SD card regulators need gpio over i2c expander and also
>>>> soc gpio support to come up in UHS modes.
>>>
>>> Is that needed for boot support? If it is only needed with UHS cards, that does not seem important enough for me. We can already boot the board via other means.
>>
>> Without these configs, the regulator drivers keep EPROBE_DEFERing waiting for their gpio drivers
>> to probe and SD card never comes up. This configuration happens before any UHS capabilities are detected.
>>
>> [    1.326654] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
>> [    1.333651] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
>> [    1.340693] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517
>> [    1.489088] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
>> [    1.496067] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
>> [    1.510392] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517
>> [    1.543210] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
>> [    1.550186] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
>> [    1.568134] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517
> 
> This happens because you have merged/enabled UHS support or? This sounds like a regression as I haven't seen this happen before.
> 

Thats right. The EPROBE_DEFERs will happen if my patches enabling UHS modes here are merged. I need to repost them for v5.11-rc1:
https://lore.kernel.org/linux-arm-kernel/20201001190541.6364-1-faiz_abbas@ti.com/

Thanks,
Faiz
