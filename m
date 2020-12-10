Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367842D4F74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLJA2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgLJA2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:28:03 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB08C0613CF;
        Wed,  9 Dec 2020 16:27:23 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id r4so1856046pls.11;
        Wed, 09 Dec 2020 16:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dx8/MX9747kjjLSB09pH76MWLAcOE3A6yZFxe87L9SM=;
        b=C9MhbGwVeBeSs601GGhBX2puShQp+Lrhd/Efcp5u/RZLom2rJ2ZzMR+cD5T5xJaSiM
         6kGZpw5G2E+KX4x5xka/+/wgyDb0QFQTBGryDn11BG1fHKFUPgg9Lx51HAxR2JrcBjtj
         P8njHAb2F64PWoyS6g8k+xePTsKGTasxLx0LIFxPMw48PdRrV/S/4askJOdJYlNqAgid
         jgsei5OoHnlm6lCWxJAUjtDJLpqqpXWYRI7gX1UPcVrT20DAbLz3PyVtrFgvKOMwp1XS
         F7yKufx60kn/aUqA08HdFN0Lwl3996+IwomUzaSqVp8oRCuxETu0Y+3AkYIqmmWLjIyG
         BVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dx8/MX9747kjjLSB09pH76MWLAcOE3A6yZFxe87L9SM=;
        b=O2fdFl69+4rUBzr5Tz+50aJOxzsmDPayRl3BOXKR/NE5PlgB63gH63HKejO87sb4Sj
         W+TVk7waDKRsyzkLtpT1vFpdlr17CTLBX3kNBIR/e5NYAms3oVS58HUk3BY2obNEmkQZ
         DEW3MRUxYrC/8UQANGrHmE1lykMB8rucF9eXFV9Yo2ugOLmLlrCXCP/4U9noBy0ZAW8m
         qPP8Cv9LhxgmGyNtA7NxrFU5rGW8+gTw/vgjMaS/BNOI5l4Ar+imG8ipZFe6O3x3ZDdF
         63NQLmRbtSlIe9Hj8PM2Zlq8jhI+LNC4SfknBRPsehBh+zP8ynJU3MLzJyRWN98/Ffbl
         LJPA==
X-Gm-Message-State: AOAM532Ag6+gX1F75Y6/i0R7IYzGAf/gopQBgmPKjfQ+vXDRIR3Zyj7s
        rfbK2f5cJ0d3KeZTj4ramKd1Cc7mvRs=
X-Google-Smtp-Source: ABdhPJyn67VNQtkoexWpKvXquxkONo6wbPPm543I5DJC3TEESgPfJU1CYYURbP4Gc6lDjVGbFxUeVQ==
X-Received: by 2002:a17:902:7689:b029:da:52:4586 with SMTP id m9-20020a1709027689b02900da00524586mr4121922pll.47.1607560042735;
        Wed, 09 Dec 2020 16:27:22 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ds24sm3362097pjb.30.2020.12.09.16.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 16:27:22 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 USB
 reset binding
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201204093704.11359-1-zajec5@gmail.com>
 <0cc54a35-7d70-8a2f-0c1f-da124136a66d@gmail.com>
 <cb2c0545-a1f6-4b85-6f9f-15813f74e323@gmail.com>
 <20201209233533.GA1281321@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <12da55ac-2271-22bd-4f75-f63d2de9a84b@gmail.com>
Date:   Wed, 9 Dec 2020 16:27:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209233533.GA1281321@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 3:35 PM, Rob Herring wrote:
> On Fri, Dec 04, 2020 at 05:39:14PM +0100, Rafał Miłecki wrote:
>> On 04.12.2020 17:32, Florian Fainelli wrote:
>>> On 12/4/2020 1:37 AM, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> Document binding of block responsible for initializing USB controllers
>>>> (OHCI, EHCI, XHCI).
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>>   .../reset/brcm,bcm4908-usb-reset.yaml         | 60 +++++++++++++++++++
>>>>   1 file changed, 60 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>>>> new file mode 100644
>>>> index 000000000000..31beb1c8f3cd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
>>>> @@ -0,0 +1,60 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/reset/brcm,bcm4908-usb-reset.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Broadcom BCM4908 USB host controller reset
>>>> +
>>>> +description: >
>>>> +  BCM4908 has a separated block controlling all USB controllers. It handles the
>>>> +  whole setup process and takes care of initializing PHYs at the right time
>>>> +  (state).
>>>> +
>>>> +maintainers:
>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - brcm,bcm4908-usb-reset
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  resets:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>> +  phys:
>>>> +    minItems: 2
>>>> +    maxItems: 2
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +
>>>> +  phy-names:
>>>> +    items:
>>>> +      - const: usb2
>>>> +      - const: usb3
>>>> +
>>>> +  "#reset-cells":
>>>> +    const: 0
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - phys
>>>> +  - phy-names
>>>> +  - "#reset-cells"
>>>> +
>>>> +additionalProperties: true
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    reset-controller@8000c200 {
>>>> +        compatible = "brcm,bcm4908-usb-reset";
>>>> +        reg = <0x8000c200 0x100>;
>>>> +
>>>> +        phys = <&usb2_phy>, <&usb3_phy>;
>>>> +        phy-names = "usb2", "usb3";
>>>
>>> This looks quite unusual, usually the *HCI controllers would be
>>> consumers of the PHY and the PHY may be a consumer of the reset controller.
>>>
>>> (still going through my emails have not fully read your separate email
>>> on the topic, so pardon me if this is being discussed twice).
>>
>> I agree, it's the the best solution I found for this specific design.
>>
>> This specific hw block perform various operations before, in the middle and
>> after PHY initialization. That made me make reset controlller initialize PHYs.
>>
>> I'm happy to implement a more proper design if someone can just suggest how.
>> I don't have any better idea :(
> 
> So the reset controller block has more than just resets? I'd hide all 
> this in the phy driver rather than hide the phy in the reset driver. So 
> for DT provide the phy a phandle to the reset block to poke the 
> registers directly.

Rafal was pointed to drivers/phy/broadcom/phy-brcm-usb-init.c which
should be a good starting point for driving the 4908 USB PHY. From there
the USB PHY may optionally be a consumer of a reset controller if it
needs to, not clear if that is necessary.
-- 
Florian
