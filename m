Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF42C88DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgK3QB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgK3QB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:01:59 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69DC0613CF;
        Mon, 30 Nov 2020 08:01:18 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so18657747ljj.10;
        Mon, 30 Nov 2020 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlJ4oZpcN5HrVzYOryBdmloFZxZb8CgFJ5YvPXP8llo=;
        b=PUz+lCYGDI07e5fuYnj/uLHFivTRwSKgqHPdQuogBVJayIxE4LxBdJ1YadgAJ+ylKO
         wMF22xNHPcsDAX0cH5ua8iPuQbd+3ggqruR0OIYxRr9nV/9yHCmLt/MpCVwXPg1J5keX
         ZkWLGjIZitBWwqbfwNaTQudbyjWvUExRq0EmXXDWE2FUiUMGhnwiV/wo4Ji7uZAq1cdg
         i6FnvdBBBuf/mjCt2QjM8MFbBE4q2hJtY/qi6hzhtQbCah+/XRaA+x7chHa7IUznZdbB
         LPi96X9A0MxO2gJJzcMGCQFW/Dq87QbqTZvId7limsXNEQnNmUoV5txTzhQUbdD5nKyE
         5ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlJ4oZpcN5HrVzYOryBdmloFZxZb8CgFJ5YvPXP8llo=;
        b=I8938QOwxQPdm0Pezka42Q8VZOktZ97u68G6vEKGamYgoRpHV1BP7hD0fuZ0cyiQoR
         RIyKAD2FDYlSn2eEz7s5mIrCR9K6ChQD2Y/HeZA2SyoXu0uwEPdwZ6LI8rGHdJ6LVGy1
         gHaxXxzeG2eg20S4F/aTeEpzq9ea11s8i27DTmeIo4onIjLOVed+/6y7TUu5de+MWV3z
         L2L2xvghcmGznU25uLvBCgsAbKnVptdhLmv8e28OUreXf/R7GnaMXI4TlMX8jANa4kE9
         t5QQ9A1xWTa0WCGEFx8/vAPQIkuJNrp0JA98mSb9XspKEXwwY5K2+7Ek2IEzEc55U0bc
         2pIQ==
X-Gm-Message-State: AOAM530uxzbEOFkJLr58jSA89amsB9thLtRm32W1GM5EQxeHnaOq8ysU
        eUs3Y4a7kb8c4eypNg4a6o0=
X-Google-Smtp-Source: ABdhPJynbqVMw4rPgxPKlkrKm8H7NxzdaJGQnqGbRkdyzEDRlicAgxpO/k0vSOyUkBjBRWPEj9Plig==
X-Received: by 2002:a2e:b164:: with SMTP id a4mr6173701ljm.271.1606752076739;
        Mon, 30 Nov 2020 08:01:16 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id y17sm2938318ljc.50.2020.11.30.08.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:01:15 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <20201130154307.GW8403@vkoul-mobl>
 <cd28f304-cb55-8377-c5eb-2adf3ab48f79@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <dc9821fe-9490-ef08-512f-61ef8eae9e9a@gmail.com>
Date:   Mon, 30 Nov 2020 17:01:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <cd28f304-cb55-8377-c5eb-2adf3ab48f79@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2020 16:58, Rafał Miłecki wrote:
> On 30.11.2020 16:43, Vinod Koul wrote:
>> On 16-11-20, 08:46, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> 1. Change syntax from txt to yaml
>>> 2. Drop "Driver for" from the title
>>> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
>>> 4. Specify license
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>> I think this should go through linux-phy tree. Kishon, Vinod, can you
>>> take this patch?
>>>
>>> This patch generates a false positive checkpatch.pl warning [0].
>>> Please ignore:
>>> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>
>> I am seeing warnings for indentation:
>>
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:20:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:51:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:71:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:80:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
>> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:88:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
>>
>> Can you pls fix those as well
> 
> Sure, just note, it's a different YAML file (I missed that initially and was
> triple checking my bcm-ns-usb3-phy.yaml ;) ). So I'll handle it using a
> different patch.

Oh, that file doesn't actualy exist in tree yet. I guess you meant to reply to Florian's patch
[PATCH] dt-bindings: phy: Convert Broadcom SATA PHY to YAML
