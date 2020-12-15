Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3422DB111
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgLOQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:14:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgLOQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:13:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFGC8CF127517;
        Tue, 15 Dec 2020 10:12:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608048728;
        bh=ttnyMr3PlO1+hk5NmAEKzHi90iThMHE0scfvWZGu4mQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=glKV1FQmSfC2UT9JaYcida2Yp7Xhc55izx0bR85gjbh78PLb4Q+RKoG2FKEaN0n+P
         t0Ba2L3ECfd2uaDXqYttD/IroP/suZ0TrmVwKx185RpyXBUs3iilRaJXCONpV1ptDy
         rfM4GkVpPGrhZWQxlatjj5NtKn2xDnegbp0yhJ6Y=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFGC8KM096619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 10:12:08 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 10:12:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 10:12:06 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFGC1xD124122;
        Tue, 15 Dec 2020 10:12:02 -0600
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
 <70d6c152-5d8d-9ad6-ce06-95a9f599c492@ti.com>
 <20201214222339.GA2471866@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <76e73cc7-fdb7-45bb-6270-1f668969ad50@ti.com>
Date:   Tue, 15 Dec 2020 21:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214222339.GA2471866@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On 15/12/20 3:53 am, Rob Herring wrote:
> On Fri, Dec 11, 2020 at 08:34:57PM +0530, Aswath Govindraju wrote:
>> Hi,
>> On 11/12/20 9:03 am, Rob Herring wrote:
>>> On Wed, Dec 09, 2020 at 11:27:07PM +0530, Aswath Govindraju wrote:
>>>> Dummy zero bits are sent before data during a read transfer. This causes
>>>> the data read to be shifted to the right. To fix this send zero bits after
>>>> the address during a read transfer.
>>>>
>>>> Add property to send zero bits after the address during a read transfer.
>>>
>>> When is this necessary? Why can't it be implied by the compatible 
>>> string which should be specific to the chip model?
>>>
>>
>> This is necessary for 93AA46A/B/C, 93LC46A/B/C, 93C46A/B/C eeproms, as
>> it can be seen in section 2.7 of [1]. We were not sure if these were the
>> only devices supported by the driver(eeprom_93xx46.c). So, in order to
>> apply this only to the above listed devices, we thought that it would be
>> better to apply this change when required by introducing a DT property.
>>
>> May I know how has this case been handled till now ??
>>
> 
> No idea. From the at93c46d (which has a compatible string) datasheet it 
> looks like it has the same thing.
> 
>> If this is required by all the devices then we can drop the property and
>> include the zero bit by default.
> 
> Looks like you need a combination of compatible strings for the above  
> devices and a property for the ORG pin state on the C devices. I assume 
> s/w needs to know if x8 or x16?
> 
Yes, there are separate properties for indicating different types of
types of eeproms.

So, do you think that it is better to add it as a seperate property??

Thanks,
Aswath
> Rob
> 

