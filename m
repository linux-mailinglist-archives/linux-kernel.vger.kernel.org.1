Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7826E2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIQRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:47:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35538 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgIQRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:46:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HEv5XR076594;
        Thu, 17 Sep 2020 09:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600354625;
        bh=lwel9jR3MUubR3w9CBXWSKGdcMrbCrgrM9DNikesG4E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o98P/fX9YDR/sDkCSJI6xZrD78ImaM4fabxiaHzxiOmXWiwRcAEMjzAn7/3QhbIAc
         twobkheLi2Os6/Wbc+KjSFdHeKjqgM7wmrhFLZO/HppsYM24TUcaWlbyzxhPrdTvhB
         W7Z97mmQNn/ZUKtWVIII1N0nWlN+w2SMClL4QBbs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HEv5tu103936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 09:57:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 09:57:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 09:57:04 -0500
Received: from [10.250.33.187] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HEv4mO095616;
        Thu, 17 Sep 2020 09:57:04 -0500
Subject: Re: [PATCH] dt-bindings: soc: ti: ti,pruss: fix schema ID
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200917070543.19064-1-krzk@kernel.org>
 <CAMxfBF5WWQX3ZH0YcRZ_N8q4njTdG-RA4eM+zyQwmK7tYvw6DQ@mail.gmail.com>
 <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <4a49d5c2-f4eb-edda-6ec2-157bfb3db3d9@ti.com>
Date:   Thu, 17 Sep 2020 09:57:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfd9iWHDNo9v=COroD_wuYL0xmOkRt-63WS_7G3As=kXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 3:35 AM, Krzysztof Kozlowski wrote:
> On Thu, 17 Sep 2020 at 10:32, Grzegorz Jaszczyk
> <grzegorz.jaszczyk@linaro.org> wrote:
>>
>> On Thu, 17 Sep 2020 at 09:05, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> Add missing '#' to fix schema errors:
>>>
>>>   $id: 'http://devicetree.org/schemas/soc/ti/ti,pruss.yaml' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
>>>   $schema: 'http://devicetree.org/meta-schemas/core.yaml' is not one of ['http://devicetree.org/meta-schemas/core.yaml#', 'http://devicetree.org/meta-schemas/base.yaml#']
>>>   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml: ignoring, error in schema: $id
>>>

Thanks for the fix, Krzysztof.

Fixes: bd691ce0ba9d ("dt-bindings: soc: ti: Add TI PRUSS bindings")
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

With that,
Acked-by: Suman Anna <s-anna@ti.com>

Santosh,
Can you please pick this up before you send your pull request to arm-soc
maintainers?

You may also want to check your tooling to see what happened.

regards
Suman


>>> ---
>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> index cf7dc83f724f..037c51b2f972 100644
>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>> @@ -1,8 +1,8 @@
>>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>  %YAML 1.2
>>>  ---
>>> -$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml
>>> -$schema: http://devicetree.org/meta-schemas/core.yaml
>>> +$id: http://devicetree.org/schemas/soc/ti/ti,pruss.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>> I've double checked and "#" was present in the original patch sent and
>> ack for upstream: https://patchwork.kernel.org/patch/11729649/
>> It seems like something got wrong on linux-next but this is the only
>> diff between original patch and one found in linux-next. Thank you for
>> taking care of it.
> 
> Indeed that's weird. It must get lost when applying...
> 
> Best regards,
> Krzysztof
> 

