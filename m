Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21002F4364
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbhAMEwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAMEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:52:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796FC061575;
        Tue, 12 Jan 2021 20:52:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y12so375704pji.1;
        Tue, 12 Jan 2021 20:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIPuJG/f1iSSi0S/53GdRrE2iJhHg51i8LMP+mddyMA=;
        b=jSKe1uJroLlKt0wqGChfLjFAUxtPyB7mpxyQHsbEBAtGRoFQDXviA5yy1ENjBo9F77
         ZxE1HtkVZu9zft6hh3+dJF5oocoEscdydAxLvHVcVxJJOAsIEQxWj3WktonLkm/BQlDS
         mcfuoOlrea5bsgKcezg+8n4iOpLJjiwwboWYo9p2xnQc0TaCUdXDftPgPk+EQ+7Uh9Go
         0R4Ip+cCeYzK7/Jvd5mHraJ5FOqe/OMgOe5CgOFf4DQEtVQ9AyP1tmrMJs35tj3tAIYp
         L5HGFuy1YhhTI7KfPDnDV4pOo+etIlM7mlPULJSJ3r4w0odUMid0z9WTps4oHb76MMZX
         3lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIPuJG/f1iSSi0S/53GdRrE2iJhHg51i8LMP+mddyMA=;
        b=CmwS2jqSYL60mSTJP5R2CIlLXEJ2auOnL5uBKdoOqnINoyQQGQG13t0mLNiQq6ya//
         v9+NRy0ZXrkB5nNaeH1FLR1bqz8+GixxIhu9yRaC0+CSBjxLaAoI9PwAG/OvyYpK5Ulo
         ERiFrppS3fLBoY8rUYcidLc752ipVz4TC87DDt68aT6ucT4+CzTCPtYfpRbgoucursBI
         mnfgbEFUs/DYLshSZKB7YYw8tUHZdWhOtR3uDdn3xoagqLeNLrxc3/rjr50Y1xZcRHSp
         1iAtmriDBcSK15ITsOliwf4wKLlAfl3JY8X2GdpTcwnQSxo6FiluZyefdXNs3FbkkL/h
         XBow==
X-Gm-Message-State: AOAM531w1nyflozmC4ZMiTc6gNdHLQfVPab3uKtl9AyfAfa22xlsVKmj
        ovxmT+xvVecFDXdsLCIiegk=
X-Google-Smtp-Source: ABdhPJz8iVmHS2KCF9/RjgOLy0eJ8KBHWbbBqr2aVIOs1YCiM5ytF/+GMgL3WRv1taZH12O5MJYQeA==
X-Received: by 2002:a17:90a:ec10:: with SMTP id l16mr249353pjy.127.1610513532890;
        Tue, 12 Jan 2021 20:52:12 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g16sm753847pfh.187.2021.01.12.20.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 20:52:11 -0800 (PST)
Subject: Re: [PATCH V4 1/3] dt-bindings: phy: brcm,brcmstb-usb-phy: convert to
 the json-schema
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210106205838.10964-1-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d31b657f-6826-b276-d697-d8f8d5a711aa@gmail.com>
Date:   Tue, 12 Jan 2021 20:52:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210106205838.10964-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/2021 12:58 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Changes that require mentioning:
> 1. interrupt-names
>    Name "wakeup" was changed to the "wake". It matches example and what
>    Linux driver looks for in the first place
> 2. brcm,ipp and brcm,ioc
>    Both were described as booleans with 0 / 1 values. In examples they
>    were integers and Linux checks for int as well. Both got uint32.
> 3. Added minimal description
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
