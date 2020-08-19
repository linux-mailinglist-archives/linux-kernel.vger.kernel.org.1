Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4824A87C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHSV3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 17:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHSV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:29:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B31C061757;
        Wed, 19 Aug 2020 14:29:06 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f24so154854ejx.6;
        Wed, 19 Aug 2020 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rdlsWWJDbZdwfnEbg+o9MVh1TLixf9zXqkq7OIiHr0=;
        b=rJy17LV8LA+npeEqR1IwPOHsuLI5VO90vuKSXCpGqZaxrJLKtpUKgNMRBYVtW4WhDh
         Js+DF0nxmHa4U71FlNj+SEyvHV/foLPMOz870IWZriEonZqF46GCfv3PQG7GsQaYe3M5
         YrNl2YLnb97E3V6i5JvF/LwF17D+i3T2GaQUFEndr3mZ/rRwoKoRb2kn8Nd30ZRymk8d
         sv9aIqLPm4tEEHpQdC3lctsb9Qgg/Q0h2mFrJ9XsDpuj+2Rqxhp2gnQ66H5UAGnaBnuu
         3UEBFUqsjFaP5G/wV68Rh+E6qv/rahNdYjFf1fQ+GB0ebafg+7CxWg81U29T5KPwiWB1
         yGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8rdlsWWJDbZdwfnEbg+o9MVh1TLixf9zXqkq7OIiHr0=;
        b=CQofMtYJR+RhYXYK3iaHHqz6RcldH7vhsPs7lV/4GJ9+UZEbME3B+9Fl/kowK1Ef8B
         WywYUqpgThHWHbdc2NrMhAoq716XlFbKQfd593ILoAWXkxkFpyMk2VZh4viimxXeBuV7
         qYBlGUxMMNqZ/sy+6cRaZ6VOg5zEtIcM1tnuX8ri2CmJeSFIeyyCt5GfTZZv5M781HRW
         dlo5R79GFsm8gPYwgUQLciYBmOqRimt4aJdejEWiyeNmXiY9TulJQjTbJNPSAR8iZl9r
         S71zdaxJZh7SjBgJ+VFZwhhvgiX7YhM9UUq/W/O4W3DEGPf6YkybyeyxZ2+vYOn5R7BK
         5wmw==
X-Gm-Message-State: AOAM530j+KqnvOo51FYuL6nuTSCkxVZJ/OCPARL1yTHJgCHA1iW1ghoZ
        p5APqfyzIuQ4W/JKvhMMs7ucCDoN6dU=
X-Google-Smtp-Source: ABdhPJwZaA5AKQ9Dwm2SiQ9Tfq8d4XvqevnClFDSE+bIxTod53C6u4UXvXEef4S6nmAjgArqH3O1zA==
X-Received: by 2002:a17:906:5f8a:: with SMTP id a10mr257213eju.379.1597872544765;
        Wed, 19 Aug 2020 14:29:04 -0700 (PDT)
Received: from [10.67.50.75] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a16sm38561ejy.78.2020.08.19.14.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 14:29:04 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
To:     Ray Jui <ray.jui@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200819042308.19043-1-f.fainelli@gmail.com>
 <7501cb2f-ea5a-8339-40a0-6706fea32a06@gmail.com>
 <62f89d06-e6ef-9476-1797-bec153d8e6db@gmail.com>
 <a3680cea-e97f-c4a2-de21-a83a3d2c1b5d@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <2d15e1e1-846b-6591-0c62-1bb94e2a4e92@gmail.com>
Date:   Wed, 19 Aug 2020 14:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3680cea-e97f-c4a2-de21-a83a3d2c1b5d@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 2:14 PM, Ray Jui wrote:
> 
> 
> On 8/19/2020 1:49 PM, Florian Fainelli wrote:
>> On 8/19/20 1:48 PM, Christian Lamparter wrote:
>>> On 2020-08-19 06:23, Florian Fainelli wrote:
>>>> The pin controller resources start at 0xc0 from the CRU base which is at
>>>> 0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
>>>> are currently off by 0x100. The resource size of the CRU is also
>>>> incorrect and should end at 0x248 bytes from 0x100 which is the start
>>>> address. Finally, the compatibility strings defined for the
>>>> pin-controller node should reflect the SoC being used.
>>>>
>>>> Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux
>>>> controller")
>>>> Reported-by: Christian Lamparter <chunkeey@gmail.com>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>> Christian, can you test this as a preliminary patch for your Cisco
>>>> Meraki MR32 series? Thanks!
>>>
>>> Hm, it looks like this is more complicated than this. We should have
>>> looked at pinctrl-ns.c's ns_pinctrl_probe() [0] before calling it.
>>>
>>> |    ns_pinctrl->regmap = syscon_node_to_regmap(of_get_parent(np));
>>> |    if (IS_ERR(ns_pinctrl->regmap)) {
>>> |        int err = PTR_ERR(ns_pinctrl->regmap);
>>> |
>>> |        dev_err(dev, "Failed to map pinctrl regs: %d\n", err);
>>> |
>>> |        return err;
>>> |    }
>>> |
>>> |    if (of_property_read_u32(np, "offset", &ns_pinctrl->offset)) {
>>> |        dev_err(dev, "Failed to get register offset\n");
>>> |        return -ENOENT;
>>> |    }
>>>
>>> So, the ns_pinctrl_probe() takes the address of the parent node (cru)
>>> and then looks for a "offset" property to add to this (which is missing
>>> in the bcm5301x.dtsi [1]).
>>>
>>> Thing is, for this to work, the parent-node should be a "simple-mfd" (so
>>> a regmap is created for the reg), right? This would also mean that the
>>> "reg" property in the pin-controller node is just cosmetic.
>>>
>>> I guess the reason why this sort-of-works for me is because I'm using
>>> this MR32 with OpenWrt (Rafał Miłecki is probably using it too ;) ).
>>>
>>> (Note: We should not forget to update the binding-documentation as well!)
>>>
>>> BTW: I'll reply my findings for the i2c issue with the MR32 in the other
>>> mail.
>>
>> Rafal, has this driver ever worked to begin with? None of this should be
>> necessary, we should just be using a simple platform device resource here.
>>
> 
> Florian, what if CDRU is a shared resource whose registers are accessed
> and shared by multiple blocks (and therefore device drivers) within the
> chip? Then accessing this shared CDRU resource through syscon makes sure
> there's no race condition, isn't it?

In this particular case there is no register overlap, and the driver has
been written with a binding that does not match what we have in tree,
that would need fixing one way or the other.

In fact, the entire Device Tree tree should be re-organized such that
all relevant child nodes are in the CDRU (like PLL controls).
--
Florian
