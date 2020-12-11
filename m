Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1832C2D78D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392543AbgLKPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:07:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38712 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgLKPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:06:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BBF518x092786;
        Fri, 11 Dec 2020 09:05:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607699101;
        bh=f4WWNv6FU5wFV+4eClkA6MR4n2vI87HqAi5xbWG774Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HmyLlv3Y2qnn2J4zsglXuWlhtl66Z2jROSRvJEDkNtnLHQuEbX7e2TV9hLSImggjC
         gXPWTZtx0r6RGZckr1z5Ld4rYsAHXHZmuyuYnPtNzvmNkX5nTkTMhE/1zqdubeagoT
         2GJbZM/yrOeTrSukni3TgumCeRyAaOfn8ORMy0EQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BBF51Ob118526
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 09:05:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 09:05:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 09:05:01 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BBF4vFv051826;
        Fri, 11 Dec 2020 09:04:58 -0600
Subject: Re: [PATCH RFC 1/2] Documentation: devicetree: Add property for
 ignoring the dummy bits sent before read transfer
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <20201209175708.16252-1-a-govindraju@ti.com>
 <20201209175708.16252-2-a-govindraju@ti.com>
 <20201211033301.GA3581630@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <70d6c152-5d8d-9ad6-ce06-95a9f599c492@ti.com>
Date:   Fri, 11 Dec 2020 20:34:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211033301.GA3581630@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 11/12/20 9:03 am, Rob Herring wrote:
> On Wed, Dec 09, 2020 at 11:27:07PM +0530, Aswath Govindraju wrote:
>> Dummy zero bits are sent before data during a read transfer. This causes
>> the data read to be shifted to the right. To fix this send zero bits after
>> the address during a read transfer.
>>
>> Add property to send zero bits after the address during a read transfer.
> 
> When is this necessary? Why can't it be implied by the compatible 
> string which should be specific to the chip model?
> 

This is necessary for 93AA46A/B/C, 93LC46A/B/C, 93C46A/B/C eeproms, as
it can be seen in section 2.7 of [1]. We were not sure if these were the
only devices supported by the driver(eeprom_93xx46.c). So, in order to
apply this only to the above listed devices, we thought that it would be
better to apply this change when required by introducing a DT property.

May I know how has this case been handled till now ??

If this is required by all the devices then we can drop the property and
include the zero bit by default.

[1]- https://www.mouser.com/datasheet/2/268/20001749K-277859.pdf

Thanks,
Aswath
>>
>> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> index a8ebb4621f79..09fb1cec54f0 100644
>> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> @@ -10,7 +10,9 @@ Optional properties:
>>  - read-only : parameter-less property which disables writes to the EEPROM
>>  - select-gpios : if present, specifies the GPIO that will be asserted prior to
>>    each access to the EEPROM (e.g. for SPI bus multiplexing)
>> -
>> +- read-op-dummy-cycles: If present specifies the number of dummy zero-bits to
>> +  be sent after the address during a read transfer to ignore any bits sent
>> +  preceding the data.
>>  Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
>>  apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
>>  
>> -- 
>> 2.17.1
>>

