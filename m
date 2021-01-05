Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17F2EA59F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAEGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:55:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAEGz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:55:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1056rhgh014887;
        Tue, 5 Jan 2021 00:53:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609829623;
        bh=LTOT+YRmvhkR78Ae74i29OdJCgRYMyZk9XPXTNgWqKU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PcADxtvm+lP2pE7vhuMw+X7OXkvFhp7TD0IiK9c8WksUveDr/Rhl+ckM73k5LNC2y
         ho1dZpMSGdVaP9F81qST96Wa4naMXV23ixRFKdOKg2m/xhKSQvrZm5WsiT6LfTkFUI
         Y3o+pW+0TiISMdUEQ2OOhnxN8Tgx3SsOwa421xms=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1056rhWK054587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 00:53:43 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 00:53:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 00:53:43 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1056rcGq126926;
        Tue, 5 Jan 2021 00:53:39 -0600
Subject: Re: [PATCH 1/2] Documentation: devicetree: Add new compatible string
 for eeprom microchip 93LC46B
To:     Rob Herring <robh@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201218140815.9501-1-a-govindraju@ti.com>
 <20201218140815.9501-2-a-govindraju@ti.com>
 <20201231191732.GA2198038@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <fbcc277c-c8aa-1252-4e9f-ba8a4f5fd00a@ti.com>
Date:   Tue, 5 Jan 2021 12:23:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201231191732.GA2198038@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 01/01/21 12:47 am, Rob Herring wrote:
> On Fri, Dec 18, 2020 at 07:38:10PM +0530, Aswath Govindraju wrote:
>> Add a new compatible string for eeprom microchip 93LC46B in eeprom-93xx46
>> dt-binding file as it belongs to the 93xx46 family of devices.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> index a8ebb4621f79..9f272361f117 100644
>> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>  - compatible : shall be one of:
>>      "atmel,at93c46d"
>>      "eeprom-93xx46"
>> +    "microchip,93LC46B"
> 
> Generally, we use lowercase and that's the existing pattern here.

ohh ok. I was trying to match the compatible string exactly with the the
device name. I will make this change in the respin.

Thanks,
Aswath

> 
>>  - data-size : number of data bits per word (either 8 or 16)
>>  
>>  Optional properties:
>> -- 
>> 2.17.1
>>

