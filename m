Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B02E8D3B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbhACQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:38:36 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A73C0613C1;
        Sun,  3 Jan 2021 08:37:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so59138754lfg.0;
        Sun, 03 Jan 2021 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOkGKxHxGXmfZ4ZwImoRwnXf5N9OB5kLyoH5znKHHzI=;
        b=c5pv6ZjnFoq0WEuGbhGmmFlHPkAXkN0uD6oScKSlye2DJoGCxluPIrHvHq0+AB1CSk
         awrUX4bSCv4UKyMXsSmdL+ZtbApWulMU8gigdMSFWGU/iIkO5u24AyjiUmWYRNsOb+7U
         yr+q3pcrGxakKQQQXrM1HYzey0TeSdS8a4YawLXaTV3wthIrVpZztN9C/A/xXxE8qvOT
         p61uB7BP2wwShIEQQXAmtKa8NBtx4VhdQ9ZQpB1LVnUE/VKRZi6KiGrtK5Cg/7KmlKZL
         4B+PssL6wJENSNiMqWM4P8yEcB4508GEwslky+03K7S5MI/LUQgT6C9t+4Z3brCYPQDy
         KRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOkGKxHxGXmfZ4ZwImoRwnXf5N9OB5kLyoH5znKHHzI=;
        b=fjCAU5ZmfYRwt/AWgha496FPQFLbe3HzpiLoj/5t7Yn7N+adbdj++lT7/frf6lf04x
         l/EoBzNcDasWXq/9pl1qaOYEhvLf5aShR4F64ydUT2T60QpDCT6qIpzDfNbWOxkNOjwQ
         KlMWfPD3Mxt4HszGb5TGPwC4tWevO54PUpHYsxHiz6EP9WkWjaXYW9lMCNxx4KhfEw4H
         N+2bnwgCcTKoyqC+pUCPo3Arw26OzqZwhuTHIJuptqWC+DxN1LnZ0HMxRLX1P6b0Gso2
         QiSBn5JT3GPdT4cSsP3bEWBVEU9cAkClyAfGptrdyE3keXLH0RZ1MBHDEWIArkzlwSLL
         E1Sw==
X-Gm-Message-State: AOAM5310YvfMMeHAj2SninKVpFCL81wGVroIfcqIJaytIZ1gLkRLWVxl
        7FVp5OTLXzWxOd1NNFkTtLQ=
X-Google-Smtp-Source: ABdhPJw6bPQ7Xwlg883wRCu68eh56hY581wh0h1QTAaCtWdSu+iWwTtOfGzDrvTh0gcBETbVd/4SzA==
X-Received: by 2002:ac2:561b:: with SMTP id v27mr29423517lfd.425.1609691874147;
        Sun, 03 Jan 2021 08:37:54 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id f3sm8408704ljp.114.2021.01.03.08.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 08:37:53 -0800 (PST)
Subject: Re: [PATCH V2 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert to
 the json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201221052339.10100-1-zajec5@gmail.com>
 <20210103162329.GA3961287@robh.at.kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <85c07078-906b-0d70-2214-874925f45c6f@gmail.com>
Date:   Sun, 3 Jan 2021 17:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210103162329.GA3961287@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.2021 17:23, Rob Herring wrote:
> On Mon, Dec 21, 2020 at 06:23:37AM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Changes that require mentioning:
>> 1. interrupt-names
>>     Name "wakeup" was changed to the "wake". It matches example and what
>>     Linux driver looks for in the first place
>> 2. brcm,ipp and brcm,ioc
>>     Both were described as booleans with 0 / 1 values. In examples they
>>     were integers and Linux driver checks for int as well.
>>     I made both uint32 but that probably should be refactored later.
> 
> Why? You're stuck with that now.

"Why?" refactor later? I thought it makes more sense for boolean-like
settings to use boolean type. Just a slightly cleaner approach.

If we care to, I believe I can do that without breaking backward
compatibility. A simple value length check:
length 1: treat 0 as false, treat 1 as true
length 0: treat property existence as true
