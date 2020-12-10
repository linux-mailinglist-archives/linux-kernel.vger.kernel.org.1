Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E247B2D5346
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgLJF2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:28:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41592 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLJF2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:28:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BA5RQkx028286;
        Wed, 9 Dec 2020 23:27:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607578046;
        bh=wcps/Y8Os9Y3CDLlV7380+d6JPtTFkhrHuzTjkXqp4g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W1eHfXk1KUIkxqUEpn+jEvPea408QOJAP9ADdWVun5Mz4Il8pU742OaGt3haaC8kR
         jBN5KyVlbghS9VhftLCwDC0XmPX852CXQnPSDD8OsYoBOVOsvqwRsJnCUEZ9T25pmm
         EH1pSzeqlwNRN+7ZMz8ej9Hzp4ejDmq4VYD1ALYo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BA5RQ52061561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 23:27:26 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 23:27:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 23:27:26 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BA5RIn0094657;
        Wed, 9 Dec 2020 23:27:21 -0600
Subject: Re: [EXTERNAL] Re: [PATCH] dt-bindings: usb: Add new compatible
 string for AM64 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201209165733.8204-1-a-govindraju@ti.com>
 <20201209165733.8204-2-a-govindraju@ti.com>
 <20201209193417.GB807821@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <dec457d6-5dc2-0823-e405-f5c2d7d555f6@ti.com>
Date:   Thu, 10 Dec 2020 10:57:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209193417.GB807821@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 10/12/20 1:04 am, Rob Herring wrote:
> On Wed, Dec 09, 2020 at 10:27:32PM +0530, Aswath Govindraju wrote:
>> Add compatible string in j721e-usb binding file as similar USB subsystem
>> is present in AM64.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Acked-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> index 388245b91a55..05d976bb06d0 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> @@ -11,8 +11,11 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    items:
>> -      - const: ti,j721e-usb
>> +    anyOf:
>> +      - items:
>> +	  - const: ti,j721e-usb
>> +      - items:
>> +	  - const: ti,am64-usb
> 
> Use 'enum'.
> 
Thank you for the comments.

I used anyOf to mention that the compatible strings can be either used
separately or together in the DT files after referring [1].

Using enum brought in constraints such as if one compatible string is
used the other cannot be used.

The error that I made was use of '\t' at the start of the lines. I will
correct it and send a respin.


[1]https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/example-schema.yaml

Thanks,
Aswath

>>  
>>    reg:
>>      description: module registers
>> -- 
>> 2.17.1
>>

