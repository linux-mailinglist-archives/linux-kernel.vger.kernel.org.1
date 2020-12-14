Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CE2D997A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438638AbgLNOKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:10:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgLNOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:10:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BEE8wOr072018;
        Mon, 14 Dec 2020 08:08:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607954938;
        bh=LQXFOzbcEpV//6PZYz8OunMZKEVrd2RDcf9Ymqtwwtc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QUvKXXsw5r6qLRZcQe1VqjrWLRWRGzWXgaPCHjDNGj+tkW1C0kpvv7uj0wnxp7Gnl
         Qj6glRVeS+H6XhITKVi7EK0BGfyrYXFuN6Dp/rL85NszxLa2tPzdlnLnYgWaBh8SZM
         iARIyIefV/fSxl+yyIO+lc/ou5aj+ssrTHFpmrPc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BEE8wNj031983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 08:08:58 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 08:08:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 08:08:57 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BEE8s0C127943;
        Mon, 14 Dec 2020 08:08:55 -0600
Subject: Re: [EXTERNAL] Re: [PATCH v4] dt-bindings: usb: Add new compatible
 string for AM64 SoC
To:     Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201211060429.20027-1-a-govindraju@ti.com>
 <062c861a-b35e-06cd-2bda-a2d3f5034290@ti.com>
 <CAL_JsqJoq20v7wj0x9Nzp2dFeeEunEmschF+VTXMtPdLwg1izA@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <814ec065-6dc5-bec5-092d-cc89d1530172@ti.com>
Date:   Mon, 14 Dec 2020 19:38:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJoq20v7wj0x9Nzp2dFeeEunEmschF+VTXMtPdLwg1izA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On 12/12/20 4:18 am, Rob Herring wrote:
> On Fri, Dec 11, 2020 at 6:04 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> Hi,
>> On 11/12/20 11:34 am, Aswath Govindraju wrote:
>>> Add compatible string in j721e-usb binding file as the same USB subsystem
>>> is present in AM64.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>
>>> Changes since v3:
>>> - used enum instead of anyOf.
>>>
>>> Changes since v2:
>>> - added changes done over the versions.
>>>
>>> Changes since v1:
>>> - replaced the '\t' at the beginning of the lines with spaces as it was
>>>   causing the dt_binding_check to fail.
>>>
>>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>> index 388245b91a55..1a5c7bbb40d1 100644
>>> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>> @@ -11,8 +11,9 @@ maintainers:
>>>
>>>  properties:
>>>    compatible:
>>> -    items:
>>> -      - const: ti,j721e-usb
>>> +    enum:
>>> +      - ti,j721e-usb
>>> +      - ti,am64-usb
>>>
>>
>> I am trying to use the compatible strings in the following manner
>>
>> ```
>> compatible = "ti,am64-usb", "ti,j721e-usb";
>>
>> ```
>> If I use above patch I am getting an error while doing a dtbs check.
>>
>> ```
>> /home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
>> cdns-usb@f900000: compatible: Additional items are not allowed
>> ('ti,j721e-usb' was unexpected)
>>         From schema:
>> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> /home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
>> cdns-usb@f900000: compatible: ['ti,am64-usb', 'ti,j721e-usb'] is too long
>>         From schema:
>> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>
>> ```
>>
>>
>> I have looked around for examples but I am unable to find a similar
>> case. I tried using anyOf in the following manner
> 
> You didn't look hard enough. There are lots.
>
>> ```
>> compatible:
>>      anyOf:
>>         - const: ti,am64-usb
>>         - const: ti,j721e-usb
> 
> This is really no different than a single 'enum' with the 2 values.
> 'anyOf' means one or more in the list are true, but more than 1 is
> impossible here.
> 
> If you have different possible lengths of values, then you need
> 'oneOf' for each case and then 'items' when you have a value with
> multiple entries:
> 
> oneOf:
>   - const: ti,j721e-usb
>   - items:
>       - const: ti,am64-usb
>       - const: ti,j721e-usb
> 

Thank you for the detailed explanation :) . I am sorry for not being
able figure this out on my own. I have sent a respin of this patch(v5).

Thanks,
Aswath

>> ```
>>
>> But I am getting an error
>>
>> ```
>> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dt.yaml:
>> cdns_usb@4104000: compatible: 'anyOf' conditional failed, one must be fixed:
>>         Additional items are not allowed ('ti,j721e-usb' was unexpected)
>>         ['ti,am64-usb', 'ti,j721e-usb'] is too long
>>         'ti,j721e-usb' was expected
>> ```
>>
>> Doesn't anyof mean that the compatible strings can be used in any
>> combination ??
>>
>> Thanks,
>> Aswath
>>
>>>    reg:
>>>      description: module registers
>>>
>>

