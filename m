Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70133287118
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgJHI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:59:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45048 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgJHI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:59:48 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0988xc3C093379;
        Thu, 8 Oct 2020 03:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602147578;
        bh=fH5kr2N5SyFUa/ZxIrBAUV8BtVu6f13S91PY7jpzcx0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bQdBsU4W2DhY2ju+BvH0BljlJvSb5A0zafkPoiKBKiFrfjSGYJriBxNsfAfQGOBmw
         cvt9k0RBnV85oJ5JpoWg8GKlVGA6DyhjT3LCq1TB7YICIWXuBd15C5ws/Y4H84EAbg
         9R15Gpnh1ilT3j19io5A0OiJ+hzOrpk2/g0L3BGU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0988xcBP089033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 03:59:38 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 03:59:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 03:59:37 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0988xW0B128961;
        Thu, 8 Oct 2020 03:59:34 -0500
Subject: Re: [PATCH 0/2] Enable GPIO and I2C configs for TI's J721e platform
To:     Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>, <nm@ti.com>
References: <20201002164535.9920-1-faiz_abbas@ti.com>
 <68cadd9b-63b1-caaf-080c-e2f346f4a908@ti.com>
 <ce66e552-a816-9e67-5e94-d9a20bbc2bc7@ti.com>
 <f8877ca8-fe32-29e5-cb0c-2ce0af3eb73a@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <0b46dc95-6778-7f01-395a-8d4eaf33b0f7@ti.com>
Date:   Thu, 8 Oct 2020 14:29:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8877ca8-fe32-29e5-cb0c-2ce0af3eb73a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tero,

On 06/10/20 6:40 pm, Tero Kristo wrote:
> On 06/10/2020 16:03, Faiz Abbas wrote:
>> Hi Tero,
>>
>> On 06/10/20 5:21 pm, Tero Kristo wrote:
>>> On 02/10/2020 19:45, Faiz Abbas wrote:
>>>> The following patches enable configs in the arm64 defconfig to support
>>>> GPIO and I2C support on TI's J721e platform.
>>>>
>>>> Faiz Abbas (2):
>>>>     arm64: defconfig: Enable OMAP I2C driver
>>>>     arm64: defconfig: Enable DAVINCI_GPIO driver
>>>>
>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>
>>> Why are you enabling these?
>>>
>>> Are they required for booting the board?
>>>
>>> If not, they shall not be enabled, as it just clutters the arm64 defconfig unnecessarily.
>>>
>>
>> They are required because the SD card regulators need gpio over i2c expander and also
>> soc gpio support to come up in UHS modes.
> 
> Is that needed for boot support? If it is only needed with UHS cards, that does not seem important enough for me. We can already boot the board via other means.

Without these configs, the regulator drivers keep EPROBE_DEFERing waiting for their gpio drivers
to probe and SD card never comes up. This configuration happens before any UHS capabilities are detected.

[    1.326654] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
[    1.333651] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
[    1.340693] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517
[    1.489088] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
[    1.496067] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
[    1.510392] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517
[    1.543210] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vmmc ret:-517
[    1.550186] sdhci-am654 4fb0000.sdhci: _devm_regulator_get id:vqmmc ret:-517
[    1.568134] sdhci-am654 4fb0000.sdhci: sdhci_am654_probe ret:-517

Thanks,
Faiz
