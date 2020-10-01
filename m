Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06528011D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbgJAORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:17:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE220C0613D0;
        Thu,  1 Oct 2020 07:17:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so5968287wrp.8;
        Thu, 01 Oct 2020 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wrgbpSMujaBkBPxDtAAR67AoZk1S06YHAzySi1MsGYU=;
        b=ditlDCKKU9HqUqfVFjYSDHW942T4w9nZZt0RWGaRFgLJpwzM/pfBUyuBv6Hr7U1IqS
         XwvJR3w41IgTU938MCI3AljNPScbvZwirGpmDJ/G1Cedh1aBe/G0pKvI5/8SGRZ4flmw
         kmZvBd9+rPUXAIUdjD9DwXvigTmnENGDrAZqOdMylnHxeeyczkUP8Gsrnf0BzVV839gr
         KkhhIFhS1U+qriLRT7hCK6/tbMR/mAyq4+pKDlTt4tVViPzN7N/Y0uSZbdh2S9LKtDiM
         KyKSJD7gjLnIMjaOFnIHJVCDbLC03ioXlGgkC7LzMHTEXLNwxPQ204Nt4s+Ue4UcYMrn
         dejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wrgbpSMujaBkBPxDtAAR67AoZk1S06YHAzySi1MsGYU=;
        b=L0jYAsy5h+5Yu6kvryB4O1X9obifeemPOccotez3ZSJjK4YmvOa5fs8iNjLXnk5pvq
         hrdQ/2cjga30QhKEtihkzct4ILUDVt0oW3NyEkJi2+tg+P3I5Ckvcx27zK8kj5OL1MbU
         5TgsNbGRAIEPv+U/qytlX8kNyky8rvrnhLnh0JnXWLcGjXMEVZMIwKzkg6z6UGB/XXfa
         8X/YmHgTSRQBUEdhnTzHSal9MugdtBvgD6iy0xKNE2IOrkgzV/U8wIBr25g8DZUxR3fT
         6r+5hQlTjxoscYQA4BZdvzHh+96T025f/gIg1UKFB+Ijtx+PDRFGap11Tb5zAAe8kQdE
         V90Q==
X-Gm-Message-State: AOAM533VgF0MW+usedIP9feyirG1Jt9msVRRR2vVwtO7uXXH8irkS2DZ
        AEGuX1zzcr6brvkLemwoD1w=
X-Google-Smtp-Source: ABdhPJzDdMobU6yFcAy6Zrkvz4ePQZ4w54ThvdXfXBqTNiIkY00AycivITxuDsvIy9DNgXukDplFXw==
X-Received: by 2002:a5d:43cb:: with SMTP id v11mr9707751wrr.188.1601561843371;
        Thu, 01 Oct 2020 07:17:23 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id h3sm10070951wrq.0.2020.10.01.07.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 07:17:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] Mediatek MT8192 clock support
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Wendell Lin <wendell.lin@mediatek.com>
References: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <206e01ba-24a6-57b1-6768-b6629d713eb7@gmail.com>
Date:   Thu, 1 Oct 2020 16:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

On 03/09/2020 05:22, Weiyi Lu wrote:
> This series is based on v5.9-rc1 and MT8192 dts[1].
> 
> [1] https://patchwork.kernel.org/cover/11713555/
> 
> changes since v2:
> - update and split dt-binding documents by functionalities
> - add error checking in probe() function
> - fix incorrect clock relation and add critical clocks
> - update license identifier and minor fix of coding style
> 
> changes since v1:
> - fix asymmetrical control of PLL
> - have en_mask used as divider enable mask on all MediaTek SoC
> 
> Weiyi Lu (9):
>    dt-bindings: ARM: Mediatek: Document bindings for MT8192 BSP
>    dt-bindings: ARM: Mediatek: Document bindings for MT8192 Audio
>    dt-bindings: ARM: Mediatek: Document bindings for MT8192 Multimedia
>    dt-bindings: ARM: Mediatek: Document bindings for MT8192 Camera
>    dt-bindings: ARM: Mediatek: Document bindings for MT8192 APU and GPU
>    clk: mediatek: Add dt-bindings for MT8192 clocks
>    clk: mediatek: Fix asymmetrical PLL enable and disable control
>    clk: mediatek: Add configurable enable control to mtk_pll_data
>    clk: mediatek: Add MT8192 clock support

This looks like a big mix of different changes and I don't see the relation 
between them.
To help facilitate the review process, I'd propose:
Any new binding with a new yaml file should be a single patch. Don't mix just 
adding one string with adding a new binding file in the same patch.

Split patch 9/9 into different patches, one for each driver. Otherwise it is 
nearly impossible to review such a big chunk of code.

Regards,
Matthias

> 
>   .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
>   .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
>   .../arm/mediatek/mediatek,camsys-raw.yaml     |   54 +
>   .../bindings/arm/mediatek/mediatek,camsys.txt |    1 +
>   .../bindings/arm/mediatek/mediatek,imgsys.txt |    2 +
>   .../arm/mediatek/mediatek,imp_iic_wrap.yaml   |   78 +
>   .../arm/mediatek/mediatek,infracfg.txt        |    1 +
>   .../bindings/arm/mediatek/mediatek,ipesys.txt |    1 +
>   .../arm/mediatek/mediatek,mdpsys.yaml         |   38 +
>   .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
>   .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
>   .../bindings/arm/mediatek/mediatek,msdc.yaml  |   46 +
>   .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
>   .../arm/mediatek/mediatek,scp-adsp.yaml       |   38 +
>   .../arm/mediatek/mediatek,topckgen.txt        |    1 +
>   .../arm/mediatek/mediatek,vdecsys-soc.yaml    |   38 +
>   .../arm/mediatek/mediatek,vdecsys.txt         |    1 +
>   .../arm/mediatek/mediatek,vencsys.txt         |    1 +
>   drivers/clk/mediatek/Kconfig                  |  146 ++
>   drivers/clk/mediatek/Makefile                 |   24 +
>   drivers/clk/mediatek/clk-mt2701.c             |   26 +-
>   drivers/clk/mediatek/clk-mt2712.c             |   30 +-
>   drivers/clk/mediatek/clk-mt6765.c             |   20 +-
>   drivers/clk/mediatek/clk-mt6779.c             |   24 +-
>   drivers/clk/mediatek/clk-mt6797.c             |   20 +-
>   drivers/clk/mediatek/clk-mt7622.c             |   18 +-
>   drivers/clk/mediatek/clk-mt7629.c             |   12 +-
>   drivers/clk/mediatek/clk-mt8173.c             |   28 +-
>   drivers/clk/mediatek/clk-mt8183.c             |   22 +-
>   drivers/clk/mediatek/clk-mt8192-aud.c         |  118 ++
>   drivers/clk/mediatek/clk-mt8192-cam.c         |   72 +
>   drivers/clk/mediatek/clk-mt8192-cam_rawa.c    |   59 +
>   drivers/clk/mediatek/clk-mt8192-cam_rawb.c    |   59 +
>   drivers/clk/mediatek/clk-mt8192-cam_rawc.c    |   59 +
>   drivers/clk/mediatek/clk-mt8192-img.c         |   60 +
>   drivers/clk/mediatek/clk-mt8192-img2.c        |   62 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_c.c  |   61 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_e.c  |   58 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_n.c  |   59 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_s.c  |   60 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_w.c  |   58 +
>   .../clk/mediatek/clk-mt8192-imp_iic_wrap_ws.c |   60 +
>   drivers/clk/mediatek/clk-mt8192-ipe.c         |   64 +
>   drivers/clk/mediatek/clk-mt8192-mdp.c         |   89 ++
>   drivers/clk/mediatek/clk-mt8192-mfg.c         |   57 +
>   drivers/clk/mediatek/clk-mt8192-mm.c          |  108 ++
>   drivers/clk/mediatek/clk-mt8192-msdc.c        |   57 +
>   drivers/clk/mediatek/clk-mt8192-msdc_top.c    |   71 +
>   drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |   57 +
>   drivers/clk/mediatek/clk-mt8192-vdec.c        |   82 +
>   drivers/clk/mediatek/clk-mt8192-vdec_soc.c    |   82 +
>   drivers/clk/mediatek/clk-mt8192-venc.c        |   60 +
>   drivers/clk/mediatek/clk-mt8192.c             | 1340 +++++++++++++++++
>   drivers/clk/mediatek/clk-mtk.h                |    2 +
>   drivers/clk/mediatek/clk-mux.h                |   15 +
>   drivers/clk/mediatek/clk-pll.c                |   28 +-
>   include/dt-bindings/clock/mt8192-clk.h        |  592 ++++++++
>   57 files changed, 4116 insertions(+), 108 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys-raw.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys-soc.yaml
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-aud.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-cam.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-cam_rawa.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-cam_rawb.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-cam_rawc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-img.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-img2.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_c.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_e.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_n.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_s.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_w.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap_ws.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-ipe.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-mdp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-msdc_top.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-scp_adsp.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-vdec_soc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192-venc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8192.c
>   create mode 100644 include/dt-bindings/clock/mt8192-clk.h
> 
