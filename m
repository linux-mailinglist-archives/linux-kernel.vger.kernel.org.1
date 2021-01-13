Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7A2F438E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbhAMFRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:17:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42618 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbhAMFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:17:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10D5G0iT039032;
        Tue, 12 Jan 2021 23:16:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610514960;
        bh=B0sgAIzINuUXLzynuaOg3ej+kFQiaCLuv73Cxqm1laU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xS16+qObDbLIcihnzSXcE9xtv7akF/P+xIrC0aGl6d0yVoX811qO+W6gHBs66S/tq
         1PXeqFaBp1mWGSCA2sb+N9xJDMkbjpx7eeDRg0g68g5H1hCF8Ilzr5p8rADkTrqBva
         C1HdG0ceMv5XoS920J5E7paSNxXJNEYbNZHdNmM4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10D5G0ip058879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 23:16:00 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 23:16:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 23:16:00 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10D5Ft7U090946;
        Tue, 12 Jan 2021 23:15:56 -0600
Subject: Re: [PATCH 1/2] misc: eeprom_93xx46: Fix module alias to enable
 module autoprobe
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anatolij Gustschin <agust@denx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210107163957.28664-1-a-govindraju@ti.com>
 <20210107163957.28664-2-a-govindraju@ti.com>
 <5c719840-7fa2-6b90-21a8-351f8460d938@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <487d20da-88d0-4d7b-8a39-b5a52f5cd63e@ti.com>
Date:   Wed, 13 Jan 2021 10:45:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c719840-7fa2-6b90-21a8-351f8460d938@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 12:49 pm, Vignesh Raghavendra wrote:
> 
> 
> On 1/7/21 10:09 PM, Aswath Govindraju wrote:
>> Fix module autoprobe by correcting module alias to match the string from
>> /sys/class/.../spi1.0/modalias content.
>>
>> Fixes: 06b4501e88ad ("misc/eeprom: add driver for microwire 93xx46 EEPROMs")
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/misc/eeprom/eeprom_93xx46.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
>> index a18247696ce7..890624d97774 100644
>> --- a/drivers/misc/eeprom/eeprom_93xx46.c
>> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
>> @@ -526,4 +526,4 @@ module_spi_driver(eeprom_93xx46_driver);
>>  MODULE_LICENSE("GPL");
>>  MODULE_DESCRIPTION("Driver for 93xx46 EEPROMs");
>>  MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
>> -MODULE_ALIAS("spi:93xx46");
> 
> This will break non DT users of this driver like
> drivers/misc/eeprom/digsy_mtc_eeprom.c
> 
>> +MODULE_ALIAS("spi:eeprom-93xx46");
>>
> 
> Can be a new entry.
> 

Thank you for the comments. Addressed this by sending a follow up patch,
https://lore.kernel.org/patchwork/patch/1364431/

Thanks,
Aswath
