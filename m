Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF50E2C63C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgK0LT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgK0LT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:19:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B93C0613D1;
        Fri, 27 Nov 2020 03:19:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so4794630wmc.5;
        Fri, 27 Nov 2020 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hF3SHuCCDkYVTDSR8oZnGZ27xoM5f8wfP/n6iXDukMs=;
        b=Aqmp1axeCyL3KGHsKFnJB8UvWoStwHsnQkyozg0HJ+wMCo3j0hRI83VOBUExZ5Liin
         A27HSOASw5jJH58GpxMvdRAcKM6OgstnO15YiL/BYJzqDc7dLrSWLtKH1Ywtb/UHH1ak
         LxrcM6/caJXvcKhuS+lvUT2HDzjuHFfvp/wi8FP1AhJ85t7Y2sjBHB3uNdm9t8KNtdIt
         EX6dMyfc90H0YNoKG6CrokhYcTboWGTB/gDvINUPCkZJHCh3ieYTyGYFzCsB/PLWZMXc
         9H6uQkjUyMHr2bGR1PZ5LsH9KBLxCrxUO4rgDKdvw8y0SrNNFKPAJB0S+JlK3X+aB1rG
         geOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hF3SHuCCDkYVTDSR8oZnGZ27xoM5f8wfP/n6iXDukMs=;
        b=be2s3GK6vxdgqo/20wkTg5FGt0VnI8l+4LIUILgsRfHlTI0ePcBg0HHI1bKg6k/oJn
         Czcqf6bSCQPbodeZfx+yHn6VFz3C2YXIufbASw7futh3xGg6CzaXEJO/Lyuda6NxJgzx
         Fx3JhhDp9K1l9R1KVDY985zvQJpudGSjqx7khDsO4u1yRd+2hD8EJsdnW8TrOcEFAaQH
         HzxGyJnkIj1wSPJWPCtJjAUzyGWCIf7yBbOkhOEuABrmiElH8Btsfq8Am9a6BnXup30G
         VBZqhL3Y5KKpjHU5SjKS2ZxGFaG4w3ytw0El9z5PrJeIc6pJy3eFfcEz1T59pIUqOXg4
         RMxQ==
X-Gm-Message-State: AOAM533hQ4P9ia2IHcDVaaZDbqz3LQmeQS7IMHiYasnLyZQHhej4Dgsb
        FO0YJcQjn5ctIKMvnW+Gizo=
X-Google-Smtp-Source: ABdhPJyOFM+XnfVxoasbZYT+/l65iZgIkXMlMnrGmRh9fJDIKbB0rxKSnpCMB4zLml/jlTVWsBCmPQ==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr8258870wme.47.1606475966436;
        Fri, 27 Nov 2020 03:19:26 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id a18sm7718933wrr.20.2020.11.27.03.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 03:19:25 -0800 (PST)
Subject: Re: [PATCH v4 00/16] soc: mediatek: pm-domains: Add new driver for
 SCPSYS power domains controller
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, fparent@baylibre.com,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201030113622.201188-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <855248fc-8c57-22c8-c5a6-bcff3a0edeab@gmail.com>
Date:   Fri, 27 Nov 2020 12:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201030113622.201188-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2020 12:36, Enric Balletbo i Serra wrote:
> Dear all,
> 
> This is a new driver with the aim to deprecate the mtk-scpsys driver.
> The problem with that driver is that, in order to support more Mediatek
> SoCs you need to add some logic to handle properly the power-up
> sequence of newer Mediatek SoCs, doesn't handle parent-child power
> domains and need to hardcode all the clocks in the driver itself. The
> result is that the driver is getting bigger and bigger every time a
> new SoC needs to be supported.
> 
> All this information can be getted from a properly defined binding, so
> can be cleaner and smaller, hence, we implemented a new driver. For
> now, only MT8173 and MT8183 is supported but should be fairly easy to
> add support for new SoCs.
> 

All patches are pushed:
DT-bindings went to v5.10-next/pm-domains-stable as they are needed by both soc 
and dts64 branch.

Regards,
Matthias

> Three important notes:
> 
> 1. This patch depends now on [1] to build correctly.
> 
> 2. Support for MT8183 is not ready to land yet because has some
>     dependencies, i.e mmsys support is still missing.
> 
> 3. Support for MT8192. I picked the patches [2] from Weiyi Lu and
>     adapted to this new series. I posted only for reference due that this
>     new version has some changes that affects that patchset.
> 
> Only patches from 1 to 9 are ready, the others are provided for reference and test.
> 
> [1] https://lore.kernel.org/patchwork/patch/1328096/
> [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=368821
> 
> Best regards,
>    Enric
> 
> Enric Balletbo i Serra (5):
>    dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains
>      controller
>    soc: mediatek: Add MediaTek SCPSYS power domains
>    arm64: dts: mediatek: Add mt8173 power domain controller
>    dt-bindings: power: Add MT8183 power domains
>    arm64: dts: mediatek: Add smi_common node for MT8183
> 
> Matthias Brugger (8):
>    soc: mediatek: pm-domains: Add bus protection protocol
>    soc: mediatek: pm_domains: Make bus protection generic
>    soc: mediatek: pm-domains: Add SMI block as bus protection block
>    soc: mediatek: pm-domains: Add extra sram control
>    soc: mediatek: pm-domains: Add subsystem clocks
>    soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
>    soc: mediatek: pm-domains: Add support for mt8183
>    arm64: dts: mediatek: Add mt8183 power domains controller
> 
> Weiyi Lu (3):
>    dt-bindings: power: Add MT8192 power domains
>    soc: mediatek: pm-domains: Add default power off flag
>    soc: mediatek: pm-domains: Add support for mt8192
> 
>   .../power/mediatek,power-controller.yaml      | 293 +++++++++
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 164 +++--
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 172 +++++
>   drivers/soc/mediatek/Kconfig                  |  12 +
>   drivers/soc/mediatek/Makefile                 |   1 +
>   drivers/soc/mediatek/mt8173-pm-domains.h      |  94 +++
>   drivers/soc/mediatek/mt8183-pm-domains.h      | 221 +++++++
>   drivers/soc/mediatek/mt8192-pm-domains.h      | 292 +++++++++
>   drivers/soc/mediatek/mtk-infracfg.c           |   5 -
>   drivers/soc/mediatek/mtk-pm-domains.c         | 614 ++++++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.h         | 102 +++
>   include/dt-bindings/power/mt8183-power.h      |  26 +
>   include/dt-bindings/power/mt8192-power.h      |  32 +
>   include/linux/soc/mediatek/infracfg.h         | 107 +++
>   14 files changed, 2081 insertions(+), 54 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>   create mode 100644 drivers/soc/mediatek/mt8173-pm-domains.h
>   create mode 100644 drivers/soc/mediatek/mt8183-pm-domains.h
>   create mode 100644 drivers/soc/mediatek/mt8192-pm-domains.h
>   create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>   create mode 100644 drivers/soc/mediatek/mtk-pm-domains.h
>   create mode 100644 include/dt-bindings/power/mt8183-power.h
>   create mode 100644 include/dt-bindings/power/mt8192-power.h
> 
