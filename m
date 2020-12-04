Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250EA2CF20A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgLDQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgLDQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:40:06 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E00C0613D1;
        Fri,  4 Dec 2020 08:39:19 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id a1so5977158ljq.3;
        Fri, 04 Dec 2020 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/HbZT1w/sDNXpdEmMytXf00NzZZfpE4/Ymz4KLprk90=;
        b=Jrqhg14JWpc+uPF6bVpjbC7w9Dv46K6kTGMipKeKq0++Atw9xsquYUfEb657MuwYUP
         6H1Twd0ov4dhgVuEBa0YFNwq2z2mgOm4piiilKmOACiPfBNN+H4+Y9rUsHIS4mPBNfiX
         0tG+vKV0VtOrNJsPDTxV/or+WysQsGOID44MY/0xA5qUqOQHgYkxvQhXStxcXBbg9SV3
         NwBQXYPwMgnqg6eUYtkuo1mWpeED+uns6GF80VBmxD2RVJsAFf8NOfmLR/BYrcLnAZfB
         RNJCg3+HGhY2J35cD0Jm6GprRXgvTRnUZ1CvnZ6gG67nMOfRQn6+w+KgospC9+AWo8MI
         CYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/HbZT1w/sDNXpdEmMytXf00NzZZfpE4/Ymz4KLprk90=;
        b=EmPF2f64xjdtHFhZhzBLUVfLg4o/KVOV0Fl+18YODjqLcqhKerAT3HGmfFUKERRJK5
         UxE5imCQL5L0IyxHLM7A3zzxzth4pLQJgRNxDlWWH+k7XQvTbm/nWSxzAjeXdd1N3EGW
         hX5pga3pDOYR1dZkfEoKwpUVQkMgKG3R4WUsiQUmgoFzLSluTJDvratjZlMGOd4ti288
         3K/U77VVgpXs68EtlPt+CZDrH8hV1lye9/nGKHePGrK0tnS9NgfnircvDsaI2iDyOTRl
         wPRvyFnyU4LOUnsqDol3bj8LyA2QtuSSTGDMZDbKSeqJUz9vULKymg3beTqbwDkfbzuC
         FT1g==
X-Gm-Message-State: AOAM531tibtb2F9i6id+4FYQljyN+4Lg2j9slCV0aHCFVBDjkKpAi9xf
        CdfYyIepMbwgXUJu28aiW+s=
X-Google-Smtp-Source: ABdhPJxx3o78HDWNrX4NRveR8CA3ggHGlOY6OVMN9hM6mRleZSTWgiZMVRrM2mpvjjmYd1izBwfOOQ==
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr189605ljj.218.1607099958228;
        Fri, 04 Dec 2020 08:39:18 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w11sm1904811lji.135.2020.12.04.08.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:39:17 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 USB
 reset binding
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201204093704.11359-1-zajec5@gmail.com>
 <0cc54a35-7d70-8a2f-0c1f-da124136a66d@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <cb2c0545-a1f6-4b85-6f9f-15813f74e323@gmail.com>
Date:   Fri, 4 Dec 2020 17:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0cc54a35-7d70-8a2f-0c1f-da124136a66d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.2020 17:32, Florian Fainelli wrote:
> On 12/4/2020 1:37 AM, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Document binding of block responsible for initializing USB controllers
>> (OHCI, EHCI, XHCI).
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../reset/brcm,bcm4908-usb-reset.yaml         | 60 +++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>> new file mode 100644
>> index 000000000000..31beb1c8f3cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/brcm,bcm4908-usb-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom BCM4908 USB host controller reset
>> +
>> +description: >
>> +  BCM4908 has a separated block controlling all USB controllers. It handles the
>> +  whole setup process and takes care of initializing PHYs at the right time
>> +  (state).
>> +
>> +maintainers:
>> +  - Rafał Miłecki <rafal@milecki.pl>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - brcm,bcm4908-usb-reset
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  phys:
>> +    minItems: 2
>> +    maxItems: 2
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +
>> +  phy-names:
>> +    items:
>> +      - const: usb2
>> +      - const: usb3
>> +
>> +  "#reset-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - phys
>> +  - phy-names
>> +  - "#reset-cells"
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    reset-controller@8000c200 {
>> +        compatible = "brcm,bcm4908-usb-reset";
>> +        reg = <0x8000c200 0x100>;
>> +
>> +        phys = <&usb2_phy>, <&usb3_phy>;
>> +        phy-names = "usb2", "usb3";
> 
> This looks quite unusual, usually the *HCI controllers would be
> consumers of the PHY and the PHY may be a consumer of the reset controller.
> 
> (still going through my emails have not fully read your separate email
> on the topic, so pardon me if this is being discussed twice).

I agree, it's the the best solution I found for this specific design.

This specific hw block perform various operations before, in the middle and
after PHY initialization. That made me make reset controlller initialize PHYs.

I'm happy to implement a more proper design if someone can just suggest how.
I don't have any better idea :(
