Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F72D2CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgLHOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgLHOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:16:25 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A972C061749;
        Tue,  8 Dec 2020 06:15:39 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id x13so8379116oto.8;
        Tue, 08 Dec 2020 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FYju9IIseHsOQsvZicie2Dx987PbfePLB40qvha0IrE=;
        b=AjPrufwymYHlzFAgEoh6VL0cteeniKiRWHjhOhi2ZgFkvyhwywRGhnnx2emH1+FGAe
         /EvVdGLqmWT4eVyu04hhjCxWx12rUYUZ1c9Kjsm4hZoxVfZiPXrkV9p+oxNFaMK0plPq
         +jxAADusBeeVBtO5GT7ng9KAn1smN9goMkIY/SHMwCyniBsI0moH4p7nandtqNeDkYKB
         BaJQJWYmkW3GWGBLSIkgEd7WWYITRUHLck/RwGsXFyNsABfZX/3ZHJPmptR5nNzrYy3e
         QGhXyWIzJ9K6IMxKSkVFJXhSXoknhggvDE6CAcrS1q4VxrnAtGfJYwFIv48Hs3Qs/trv
         03pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FYju9IIseHsOQsvZicie2Dx987PbfePLB40qvha0IrE=;
        b=ZnOdTM8TgR2BWN5urlTnc3j21oKoVJBMN6CMnPJcwnm3XvmRioTV7hbWFEVBZD+x7j
         WPmgPHhS9jVQxR7hCK8kLdTSPsMt9S2+zKlqP9txVmm3PPUlWigQuQqKifjMLpGtxeZ3
         BOYB1hqFx+53PkFIUVj1Hnkk2JmETr7FSEbBQYQl96vn3uyZbW70HYd3nhWiZvGBCnYr
         JkRfux0FxINUg4PnlD9r6Il9fvUV5kf381K2TjH9dS2mBDZ+6dCpyg7YmzQQCor3bGo0
         J7XsRoZyQNQmM1Vq3l5llJbbxsg5AoBji9Q1q/ZvHZLkZW6GfLByjQUHO6+psBC/O91j
         uIXw==
X-Gm-Message-State: AOAM531u8dmuP2n+rbi6n6tWWaXlWUxOVHryjD76yvNb6gftvsYAS1eC
        Swc77JVz9jHyDLItSBYT0lbFqrwauF4=
X-Google-Smtp-Source: ABdhPJz+yfj1FKy8nCM4h6nO63Hv9F++jG7fTFHtqPxCztzXQ8g2rQe3k2XSwe1uhkkdDvZocPY2Wg==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr16189038ots.151.1607436938502;
        Tue, 08 Dec 2020 06:15:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t186sm3737077oif.1.2020.12.08.06.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:15:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: convert AD ADM1275 bindings to
 dt-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kun Yi <kunyi@google.com>
References: <20201117220807.208747-1-krzk@kernel.org>
 <20201117220807.208747-4-krzk@kernel.org>
 <20201207211259.GA832269@robh.at.kernel.org>
 <20201208001916.GA59429@roeck-us.net> <20201208081350.GA5088@kozik-lap>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <44426458-8940-e739-1392-f4d212aa1cd4@roeck-us.net>
Date:   Tue, 8 Dec 2020 06:15:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208081350.GA5088@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 12:13 AM, Krzysztof Kozlowski wrote:
> On Mon, Dec 07, 2020 at 04:19:16PM -0800, Guenter Roeck wrote:
>> On Mon, Dec 07, 2020 at 03:12:59PM -0600, Rob Herring wrote:
>>> On Tue, Nov 17, 2020 at 11:08:07PM +0100, Krzysztof Kozlowski wrote:
>>>> Convert the Analog Devices ADM1275 bindings to dt-schema.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> ---
>>>>  .../bindings/hwmon/adi,adm1275.yaml           | 58 +++++++++++++++++++
>>>>  .../devicetree/bindings/hwmon/adm1275.txt     | 25 --------
>>>>  Documentation/hwmon/adm1275.rst               |  2 +-
>>>>  3 files changed, 59 insertions(+), 26 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>>  delete mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> new file mode 100644
>>>> index 000000000000..2cad28c499dc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
>>>> @@ -0,0 +1,58 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +
>>>> +$id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Analog Devices ADM1075/ADM127x/ADM129x digital power monitors
>>>> +
>>>> +maintainers:
>>>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>>>> +
>>>> +description: |
>>>> +  The ADM1293 and ADM1294 are high accuracy integrated digital power monitors
>>>> +  that offer digital current, voltage, and power monitoring using an on-chip,
>>>> +  12-bit analog-to-digital converter (ADC), communicated through a PMBus
>>>> +  compliant I2C interface.
>>>> +
>>>> +  Datasheets:
>>>> +    https://www.analog.com/en/products/adm1294.html
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - adi,adm1075
>>>> +      - adi,adm1272
>>>> +      - adi,adm1275
>>>> +      - adi,adm1276
>>>> +      - adi,adm1278
>>>> +      - adi,adm1293
>>>> +      - adi,adm1294
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  shunt-resistor-micro-ohms:
>>>> +    description:
>>>> +      Shunt resistor value in micro-Ohm.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> Don't need a type if you have units. With that dropped,
>>>
>>
>> Sorry, I am not familiar with the terminology. Does that refer to
>> the '$ref' line ?
> 
> Yes, it's the $ref line which can be safely removed. The core dt-schema
> applies such $ref if the property name ends with '-micro-ohms'.
> 

Thanks a lot for the information. Ill apply the patch with this line removed.

Thanks,
Guenter

