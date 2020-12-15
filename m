Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC90F2DA723
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLOEb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:31:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46048 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgLOEb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:31:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BF4UJ7C122788;
        Mon, 14 Dec 2020 22:30:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608006619;
        bh=9bWv+Y231QyoS6iQbUcEuTzrVE1s5tFBEjEhlWzzl+4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PfeC5uzS5FhP3KPRfch9uDKe+CvN0j/Hx0/PGcwD+w+xOyhk9DRBZm12Xb5YRLj9/
         6YnpM+mU9rQL/tH68YHmIcA7xYvPOJ04JPvQyLWT8z//0NPCEoNleBz2CJEjDOdCXd
         znWdJE70Ee3qxlOZT3OShHskRK1l0SEmBteA0lN4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BF4UJNk079712
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 22:30:19 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 22:30:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 22:30:19 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BF4UFK1033533;
        Mon, 14 Dec 2020 22:30:16 -0600
Subject: Re: [PATCH v5] dt-bindings: usb: Add new compatible string for AM64
 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201214140109.21955-1-a-govindraju@ti.com>
 <20201214204722.GA2365525@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <c31059ae-0923-ee03-a3ed-954a58a12c1a@ti.com>
Date:   Tue, 15 Dec 2020 10:00:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214204722.GA2365525@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
On 15/12/20 2:18 am, Rob Herring wrote:
> On Mon, Dec 14, 2020 at 07:31:09PM +0530, Aswath Govindraju wrote:
>> Add compatible string in j721e-usb binding file as the same USB subsystem
>> is present in AM64.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> Changes since v4:
>>  - used oneOf instead of enum, as the schema has to convey that the strings
>>    ti,j721e-usb and ti,am64-usb can be used combined or seperately in the
>>    DT nodes.
>>
>> Changes since v3:
>>  - used enum instead of anyOf.
>>
>> Changes since v2:
>>  - added changes done over the versions.
>>
>> Changes since v1:
>>  - replaced the '\t' at the beginning of the lines with spaces as it was
>>   causing the dt_binding_check to fail.
>>
>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> index 388245b91a55..21e51ceca293 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>> @@ -11,8 +11,12 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    items:
>> +    oneOf:
>>        - const: ti,j721e-usb
>> +      - const: ti,am64-usb
>> +      - items:
>> +          - ti,j721e-usb
>> +          - ti,am64-usb
> 
>                ^
> 
> const needed before the strings
> 

Thank you for the comments. I am very sorry for this error, I forgot to
add my changes to  the commit before creating the patch. I have sent a
respin (v6).

Thanks,
Aswath

>>  
>>    reg:
>>      description: module registers
>> -- 
>> 2.17.1
>>

