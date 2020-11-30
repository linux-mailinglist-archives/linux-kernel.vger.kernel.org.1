Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E339F2C88D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgK3P7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3P7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:59:01 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338FC0613CF;
        Mon, 30 Nov 2020 07:58:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so22576069lfh.2;
        Mon, 30 Nov 2020 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qWxk5dtTp+nTC+lSo2kuBbV3C2me5xoWBB3XCapIF4s=;
        b=gn70FcNsKkpj/l0CcYo7kP1OlWnXfEwMR3ocBrM97DLhTY/o0ePDS99zZ+12tjMdq7
         H7rbUH392Q12b6i3rXZM7Z9y8jUzK75xvwOw1YpFtPp7yWFX74D65qurnk0LJYCDYjqj
         AYd71QUgm05FrXV3yfvbx1baSapN+98ADloHR2DBPqMm+JgQVJMz9m3STdA351iUmZID
         RvUjwGL0V0uhc0ffinBik4qwp++rZ7uyYfph4hf7B2IRH2TECEd+jifbz/ase92NEr9j
         Gg+dkQCUANwQeiEHZekbAYlDbkisVY+K45L5LttDHmCSHdJ0CHr30EzwUbQAlaqCS7PA
         k9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWxk5dtTp+nTC+lSo2kuBbV3C2me5xoWBB3XCapIF4s=;
        b=A/Qoji7roREQw0VkKr63QNt6ILDpkmmWAQDfBR6q5HFWpwMWmQgMYZmT3Z7LMAMCDa
         7U57NMs/zeR4WzNAawf9ug+wsJieddo1aP5Re+0/q4ajTe38lCZv6ht0YJ1oql3ioqVI
         n6sdxwg/ekm/3vC5V3MfmBdBsKJDikwFmzSFg8I3j1yT+gsUj5cpT0TWbnYglkCjWDp8
         yTO6nxC82UCqqdCRG93CnG+8134pBWSDmKYKWY2E/m7Cz500oQgL+t6hjHJndOLyQ4ns
         cPeBvnlwRa4dpIszeg2JvacWZbHKIg1gIBDeG+n6g5uv815htw3bYv3VGXKS9PX2qRfl
         9c+Q==
X-Gm-Message-State: AOAM531sLTBPEa/I7ppXTz7W6Dk3ICvlASXy1HRQLTPPiMHWc1QrXknN
        kF6MJX9S0PNK1YSRYxOD3GA=
X-Google-Smtp-Source: ABdhPJy2RY+JlCJr6gAc1/5zU7gi1gI4T0+MLwcFLZj/8DHxZpvsUUweObiM1BMoFmMVf/86oLVgEQ==
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr9811415lfr.149.1606751899768;
        Mon, 30 Nov 2020 07:58:19 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id u18sm2492404ljd.107.2020.11.30.07.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:58:19 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <20201130154307.GW8403@vkoul-mobl>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <cd28f304-cb55-8377-c5eb-2adf3ab48f79@gmail.com>
Date:   Mon, 30 Nov 2020 16:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201130154307.GW8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2020 16:43, Vinod Koul wrote:
> On 16-11-20, 08:46, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> 1. Change syntax from txt to yaml
>> 2. Drop "Driver for" from the title
>> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
>> 4. Specify license
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> I think this should go through linux-phy tree. Kishon, Vinod, can you
>> take this patch?
>>
>> This patch generates a false positive checkpatch.pl warning [0].
>> Please ignore:
>> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> I am seeing warnings for indentation:
> 
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:20:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:28:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:51:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:71:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:80:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
> Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml:88:11: [warning] wrong indentation: expected 9 but found 10 (indentation)
> 
> Can you pls fix those as well

Sure, just note, it's a different YAML file (I missed that initially and was
triple checking my bcm-ns-usb3-phy.yaml ;) ). So I'll handle it using a
different patch.
