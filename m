Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46940288942
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbgJIMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgJIMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:50:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717CC0613D2;
        Fri,  9 Oct 2020 05:50:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so10143855wrp.10;
        Fri, 09 Oct 2020 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tM6Kdz3zm/Ta3Gss9N6jrcTtQpKgV/+ZBA6O7+RCUIU=;
        b=fvz7+I6mR0zZMw32XB6gmmCQotdNgOJrrC+cN0BzmWCvh/XsJp8belJ57zLJY3e/P7
         8/sx2jUAlExX14aaehwes7Fk58lq3KOylbb/hUHU5G9uOl7I4EUPltuEcegw1iCd1pee
         Uj7Yp2bv7x49Vcvdfzmzox/WpPlO+dA0B5YfGraVIPgGXTNFI/y/26pWhx8d/R5SOeJ/
         VxTTJ3lLVALX+ytUyhoLaTfRt+Uz1e16l6RAXJt8ZY8kJpeFGBw0ExAEQ+TnIYdXXlkv
         01dA86W6+YqjD5npZf9PN7anS+9AvTeWbNP8sclnSLN9XjWu6TrrsUW0TW5UzdRmqYV2
         JRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tM6Kdz3zm/Ta3Gss9N6jrcTtQpKgV/+ZBA6O7+RCUIU=;
        b=OVMiiUCqtmqbVTW9nwaqXY+uLqVbRf5rnoe8HNnuU+3LbPueXDvJLu5Wq4qUYxSGhQ
         O2/Ia9s+zB0Tk2FC7oyTMTz2PjfdLACF3I6APuG/IOWpQRaF7HiwZjNjR8vOBOGyNBHT
         62gY0RKCtiFL6Y+gYO9GyvEke5nZ96A0irs8H+TA1dfET/XzvIH070nLy8i+bA54H8CX
         xLLXgYICWI8hgGpG0FwBkmxiRZWIKEokWu9KpE0VvI/d3juOkthrbqHwYDjnha7ox9VZ
         iD31SK6Bq1ezJcLc6oBur6FTIA2gkB1fP6eM8RAqXslcsHnV9b9gQrBVTG/JRuAtGQCA
         CdXQ==
X-Gm-Message-State: AOAM530v/9MH/XdlTOHRDvgiSAXsM2FDDiytv1+Qcga6GwYh3zuMJtno
        mvXqZg8TvUGjchw40Dln+ME=
X-Google-Smtp-Source: ABdhPJwz4y/KndvcADy27gF36kL0k+wfesqMBuQbCCYUAsMR9/vizw/ke6NPsmw8w2hj4OGccaTUSQ==
X-Received: by 2002:adf:9e87:: with SMTP id a7mr1178442wrf.185.1602247853535;
        Fri, 09 Oct 2020 05:50:53 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id k190sm11691295wme.33.2020.10.09.05.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:50:52 -0700 (PDT)
Subject: Re: [PATCH 00/12] soc: mediatek: pm-domains: Add new driver for
 SCPSYS power domains controller
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, fparent@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <1601028361.1346.38.camel@mtksdaap41>
 <19678952-e354-2067-e619-ffac28b347be@gmail.com>
 <1601967207.8638.4.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f2185b28-0b1f-8cf9-8717-12e28cf2bbf0@gmail.com>
Date:   Fri, 9 Oct 2020 14:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601967207.8638.4.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2020 08:53, Weiyi Lu wrote:
> On Fri, 2020-09-25 at 16:04 +0200, Matthias Brugger wrote:
>>
>> On 25/09/2020 12:06, Weiyi Lu wrote:
>>> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>>>> Dear all,
>>>>
>>>> This is a new driver with the aim to deprecate the mtk-scpsys driver.
>>>> The problem with that driver is that, in order to support more Mediatek
>>>> SoCs you need to add some logic to handle properly the power-up
>>>> sequence of newer Mediatek SoCs, doesn't handle parent-child power
>>>> domains and need to hardcode all the clocks in the driver itself. The
>>>> result is that the driver is getting bigger and bigger every time a
>>>> new SoC needs to be supported.
>>>>
>>>
>>> Hi Enric and Matthias,
>>>
>>> First of all, thank you for the patch. But I'm worried the problem you
>>> mentioned won't be solved even if we work on this new driver in the
>>> future. My work on the MT8183 scpsys(now v17) is to implement the new
>>> hardware logic. Here, I also see related patches, which means that these
>>> new logics are necessary. Why can't we work on the original driver?
>>
>> Well the decision was to change the driver in a not compatible way to make
>> device tree entries better. If we work on the old driver, we would need to find
>> some creative ways to handle old bindings vs new bindings.
>>
>> So I thought it would be better doing a fresh start implementing mt1873 support
>> for reference and add mt8183 as new SoC. From what I have seen mt8192 and others
>> fit the driver structure too.
>>
>>> Meanwhile, I thought maybe we should separate the driver into general
>>> control and platform data for each SoC, otherwise it'll keep getting
>>> bigger and bigger if it need to be support new SoC.
>>>
>>
>> We could in a later series split the SoC depended data structures and put them
>> in drivers/soc/mediatek/pm-domains-mt8183.h or something like this. Is that what
>> you mean?
>>
> 
> Yes, that is what I want. And I guess it could avoid the collisions in
> the different defines to the control registers and power status bits you
> mentioned. Hope this will happen in this series.
> 

Sounds good to me. Enric could you move the soc specific data to separate 
include files?

Regards,
Matthias
