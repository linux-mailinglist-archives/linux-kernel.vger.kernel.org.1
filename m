Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD927278A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgIYOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:04:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA4C0613CE;
        Fri, 25 Sep 2020 07:04:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so3453074wmm.2;
        Fri, 25 Sep 2020 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JzMHEh8Ube79dljEkqdya1eUh9+uHB8BNvZsHGcfoPo=;
        b=RZX5Z/hUWLlZ4970yusa9NzXdDDTM0bEXWhQUIxScaseARZPFZX2wi3+rATvzx6SZ+
         Q8mKdnsOhcF5zlFYDHy6nn6yjV4OAhfOwPTKh25agDNQ/vbbm4eIe+fM2yuWHk65Qa6Z
         5GdlaXp0EalwnqUZQVt3XHvy30Bl/0j8B8xzLACd89z6/Sr9+QiND+W1UVI+YjeqOCOI
         RekXCvsLFN5ZB+XTMplpJ20irr1tF3dw7QHjHKOrKX+ZzJnpDjB0llPh588G0CJt/HB9
         pA1XAbedTSKHhWyb5cbJnatucotHiZcR5gNgbcJrkWT1RykKsQbL+6FS3sJQ4u7fRkG7
         pm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzMHEh8Ube79dljEkqdya1eUh9+uHB8BNvZsHGcfoPo=;
        b=mbLzFWRvkhVXoKcFWuTlHL3ExiuN8nAk3AQWTqJAG72uW4Dj7K9SC/fGdoogxOy5KO
         LlTe42LvllLvukyNhw5qC0Zz7FEQEhMJwPHCnyOz0Pbf9rcMdQEzbssoGwFvij+4zM60
         UIkRCbfUkaLPBIf3LBPgUPEhor8hLend0u5fU0e7kPg0HwUYK5NDzefiMQ/Ec7+oWTD6
         Daz1qeg5JJwdBE0f2+2lw0/E0X2w38RMg9LDH6hZfTCOfTkpc3K9YxOnjqIkt1dGRhkb
         5E47ic6OqxBXaB9Mtz5NLgUK7BAHsnuA/XBJ1HKuXotE5HFXRKTqYyQN8kGASIu5KqrH
         BPXA==
X-Gm-Message-State: AOAM531YRkk22fMwdCgdu1vHGi/6Goaip5c3LIDYbOtY7ttkjL567nki
        Bka2OlE86CumJLw9CitSR1w=
X-Google-Smtp-Source: ABdhPJxeAyUCloE/hd0Mz6RZVZupL00UDeDG3zrN7h7y87RIOj0aH5w91JpDNJbdnuSnYvqtg2+njw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr3532728wml.131.1601042671950;
        Fri, 25 Sep 2020 07:04:31 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id k22sm3233428wrd.29.2020.09.25.07.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:04:31 -0700 (PDT)
Subject: Re: [PATCH 00/12] soc: mediatek: pm-domains: Add new driver for
 SCPSYS power domains controller
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <1601028361.1346.38.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <19678952-e354-2067-e619-ffac28b347be@gmail.com>
Date:   Fri, 25 Sep 2020 16:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601028361.1346.38.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 12:06, Weiyi Lu wrote:
> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>> Dear all,
>>
>> This is a new driver with the aim to deprecate the mtk-scpsys driver.
>> The problem with that driver is that, in order to support more Mediatek
>> SoCs you need to add some logic to handle properly the power-up
>> sequence of newer Mediatek SoCs, doesn't handle parent-child power
>> domains and need to hardcode all the clocks in the driver itself. The
>> result is that the driver is getting bigger and bigger every time a
>> new SoC needs to be supported.
>>
> 
> Hi Enric and Matthias,
> 
> First of all, thank you for the patch. But I'm worried the problem you
> mentioned won't be solved even if we work on this new driver in the
> future. My work on the MT8183 scpsys(now v17) is to implement the new
> hardware logic. Here, I also see related patches, which means that these
> new logics are necessary. Why can't we work on the original driver?

Well the decision was to change the driver in a not compatible way to make 
device tree entries better. If we work on the old driver, we would need to find 
some creative ways to handle old bindings vs new bindings.

So I thought it would be better doing a fresh start implementing mt1873 support 
for reference and add mt8183 as new SoC. From what I have seen mt8192 and others 
fit the driver structure too.

> Meanwhile, I thought maybe we should separate the driver into general
> control and platform data for each SoC, otherwise it'll keep getting
> bigger and bigger if it need to be support new SoC.
> 

We could in a later series split the SoC depended data structures and put them 
in drivers/soc/mediatek/pm-domains-mt8183.h or something like this. Is that what 
you mean?

> And consider DVFSRC
> (dynamic voltage and frequency scaling resource collector), should we
> keep the original driver name "scpsys" instead of "pm-domains" because
> it may provide more functions than power domains?
> 

It's on my list to look deeper into this series. The thing with the new driver 
is, that the binding takes into account, that scpsys has several hardware block, 
which are represented as child nodes in DTS. The pm-domains is just one of these 
functionalities and I think DVFSRC should be a new driver with a child node of 
scpsys in DTS. Does this make sense?

Regards,
Matthias

>> All this information can be getted from a properly defined binding, so
>> can be cleaner and smaller, hence, we implemented a new driver. For
>> now, only MT8173 and MT8183 is supported but should be fairly easy to
>> add support for new SoCs.
>>
>> Best regards,
>>    Enric
>>
>> Enric Balletbo i Serra (4):
>>    dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains
>>      controller
>>    soc: mediatek: Add MediaTek SCPSYS power domains
>>    arm64: dts: mediatek: Add mt8173 power domain controller
>>    dt-bindings: power: Add MT8183 power domains
>>
>> Matthias Brugger (8):
>>    soc: mediatek: pm-domains: Add bus protection protocol
>>    soc: mediatek: pm_domains: Make bus protection generic
>>    soc: mediatek: pm-domains: Add SMI block as bus protection block
>>    soc: mediatek: pm-domains: Add extra sram control
>>    soc: mediatek: pm-domains: Add subsystem clocks
>>    soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
>>    soc: mediatek: pm-domains: Add support for mt8183
>>    arm64: dts: mediatek: Add mt8183 power domains controller
>>
>>   .../power/mediatek,power-controller.yaml      | 173 ++++
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  78 +-
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 160 +++
>>   drivers/soc/mediatek/Kconfig                  |  13 +
>>   drivers/soc/mediatek/Makefile                 |   1 +
>>   drivers/soc/mediatek/mtk-infracfg.c           |   5 -
>>   drivers/soc/mediatek/mtk-pm-domains.c         | 952 ++++++++++++++++++
>>   include/dt-bindings/power/mt8183-power.h      |  26 +
>>   include/linux/soc/mediatek/infracfg.h         |  39 +
>>   9 files changed, 1433 insertions(+), 14 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>   create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>>   create mode 100644 include/dt-bindings/power/mt8183-power.h
>>
> 
