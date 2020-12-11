Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553672D700A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436477AbgLKGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:12:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395480AbgLKGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:12:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BB6Agdh050415;
        Fri, 11 Dec 2020 00:10:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607667042;
        bh=VzMTGPRBpEVYEVZdOuDQkqjYwCymPn7yfwS9M/0wSPs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EhQese3JWT653sd1DhsdxpS4fgUCDNwmrao9TUIjCBZysXw8oV04X+XWPZW9p0DBf
         zYPhkEuIPh0cg7ko7FxSM2a6jTrMJnSlyJ4OVE0d67QTq+HhMzr73hxnjoUxsWiexr
         li70MevqbOrmTt6V8CN/zeI4yLbZ4/jruRtAWb3I=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BB6AgfN096213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 00:10:42 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 00:10:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 00:10:42 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BB6AccC127468;
        Fri, 11 Dec 2020 00:10:39 -0600
Subject: Re: [PATCH v3] dt-bindings: usb: Add new compatible string for AM64
 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201210065450.16663-1-a-govindraju@ti.com>
 <20201211033726.GA3588782@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <4880cb28-285e-cd71-f431-3ae77bd8a2f3@ti.com>
Date:   Fri, 11 Dec 2020 11:40:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211033726.GA3588782@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/12/20 9:07 am, Rob Herring wrote:
> On Thu, Dec 10, 2020 at 12:24:50PM +0530, Aswath Govindraju wrote:
>> Add compatible string in j721e-usb binding file as the same USB subsystem
>> is present in AM64.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Acked-by: Roger Quadros <rogerq@ti.com>
>> ---
>>
>> Changes since v2:
>> - added changes done over the versions
>>
>> Changes since v1:
>> - replaced the '\t' at the beginning of the lines with spaces as it was
>>   causing the dt_binding_check to fail
>>
>>
>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> index 388245b91a55..453587f6d304 100644
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
>> +          - const: ti,j721e-usb
>> +      - items:
>> +          - const: ti,am64-usb
> 
> compatible:
>   enum:
>     - ti,j721e-usb
>     - ti,am64-usb
> 

Thank you for the comments.

I have sent a respin for this patch making the above changes.

May I please know a case where anyOf would be used rather than enum
because after reading the documentation[1], I thought that using enum
meant that only one of the listed strings in enum can be used as
compatible strings in a given node.

[1]https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/example-schema.yaml

Thanks,
Aswath

>>  
>>    reg:
>>      description: module registers
>> -- 
>> 2.17.1
>>

