Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E264286E28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgJHFhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgJHFho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:37:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2CCC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 22:37:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l11so5077905wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A6XCjatiL9NzFQM+NdxMv/RvtW9AfjiLEaWTMjp5zoI=;
        b=Wna3U3JA7eZqXSqKp499zxZzQziRQTdFekU1KZnuA6WKKgK/lB3nSJ1rF6+N9OdRe7
         bXz7WhEajXOoS4rqh4OJ8thr4zXSjvN+GMkCY2QINEqp1wyyJb0bUnvP0QCK1FMGCXi4
         /45h0GsDXzfft8Uue82SmspgY02SLP7aRoke9jM0Dn/CF7RlKsYIhZqmPOic+3dPbEYa
         dPjLgLpyj6o1kwjIX5M2VWCU9UoBvsOGtOsvYFLNn81ukB00VIov0k++l/CWTcGqP6nh
         2l6SDIOI2g4XQbqLoyvqy3DVnWbZ/nl9qHRPvImp6nIdwhA04AlRIScXaIeoiBwBH4QY
         kmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A6XCjatiL9NzFQM+NdxMv/RvtW9AfjiLEaWTMjp5zoI=;
        b=m6uo2t4knzbSqC8xGmaomORm4z8fqwo644K5Uy+Qyt7FVE19Vr1wi8SZ1bWM30Gyxk
         f94h22TCPg0B2P8CdrNERY63iz9EkGbRbjnTD8cBtrA4NzkITpl+ZU06g2F+NW0hgzER
         Jzkp4CkMFUeBP73UK7Y5ChGXZSEXz2HldaUVYSecOfzEtrBhxy6Qnco2cXv51xNL/bVX
         h1w/L3PiMKxarfYDNn6yUbfamqTZGxtCX65tmqlnECMWnHz1j3RGCFUPlaU/FLvGCkMm
         J+4WMNH9FBXWjdDa8p0Bd2UuBrJd9fQHtRLRvWJ8+u/nbVvzV2J4v1Os43yVCqSway8z
         mNGg==
X-Gm-Message-State: AOAM532V9JLamgcwkqBwMtUwvjcCDzBvSKG+abKwmDTftGgzT5gKzt4U
        DsI3rHgSrvXUUE33omM1i9YR5heyH+6t6Q==
X-Google-Smtp-Source: ABdhPJzqouWaKGAaiL8Srtog8oaCNxGNm6BRRyanUcbWr+H31MrZoIhMQp7sQKJcjsJATK+qh1xmuw==
X-Received: by 2002:a1c:7ed5:: with SMTP id z204mr6752967wmc.177.1602135462857;
        Wed, 07 Oct 2020 22:37:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id a3sm5165998wmb.46.2020.10.07.22.37.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 22:37:42 -0700 (PDT)
Subject: Re: [PATCH v11 0/7] Qualcomm's lpass-hdmi ASoC driver to support
 audio over dp port
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1602134223-2562-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <244e74f6-fa8c-692a-aa84-4677a0fd815b@linaro.org>
Date:   Thu, 8 Oct 2020 06:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1602134223-2562-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2020 06:16, Srinivasa Rao Mandadapu wrote:
> These patches are to support audio over DP port on Qualcomm's SC7180 LPASS
> Asoc. It includes machine driver, cpu driver, platform driver updates for
> HDMI path support, device tree documention, lpass variant structure
> optimization and configuration changes.
> These patches depends on the DP patch series
> https://patchwork.kernel.org/project/dri-devel/list/?series=332029
> https://lore.kernel.org/patchwork/project/lkml/list/?series=464856
> 
> changes since V10:
>      -- Moved hdmi regmap functions from lpass-hdmi.c to lpass-cpu.c
>      -- Moved QCOM_REGMAP_FIELD_ALLOC macro from lpass-hdmi.c to lpass.h
> changes since V9:
>      -- Removed unused structures lpass_hdmi.h
> changes since V8:
>      -- Removed redundant structure wrapper for reg map field memebrs
>      -- Updated lpass_hdmi_regmap_volatile API with appropriate registers as true
>         and others as false.
> changes since V7:
>      -- Fixed typo errors
>      -- Created Separate patch for buffer size change
> changes since V6:
>      -- Removed compile time define flag, which used for enabling
>       HDMI code, based on corresponding config param is included.
>      -- Updated reg map alloc API with reg map bulk API.
>      -- Removed unnecessary line splits
> changes since V5:
>      -- Removed unused struct regmap *map in lpass_platform_alloc_hdmidmactl_fields.
>      -- DMA alloc and free API signature change in lpass-apq8016.c, lpass-ipq806x.c
>      -- Keeping API "irqreturn_t lpass_platform_hdmiif_irq" under ifdef macro
> Changes Since v4:
>      -- Updated with single compatible node for both I2S and HDMI.
> Changes Since v3:
>      -- Removed id in lpass variant structure and used snd_soc_dai_driver id.
> Changes Since v2:
>      -- Audio buffer size(i.e. LPASS_PLATFORM_BUFFER_SIZE) in lpass-platform.c increased.
> Changes Since v1:
>      -- Commit messages are updated
>      -- Addressed Rob Herring review comments
> 
> V Sujith Kumar Reddy (7):
>    ASoC: Add sc7180-lpass binding header hdmi define
>    ASoC: dt-bindings: Add dt binding for lpass hdmi
>    Asoc:qcom:lpass-cpu:Update dts property read API
>    Asoc: qcom: lpass:Update lpaif_dmactl members order
>    ASoC: qcom: Add support for lpass hdmi driver
>    Asoc: qcom: lpass-platform : Increase buffer size
>    ASoC: qcom: sc7180: Add support for audio over DP
> 
>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  74 ++--
>   include/dt-bindings/sound/sc7180-lpass.h           |   1 +
>   sound/soc/qcom/Kconfig                             |   5 +
>   sound/soc/qcom/Makefile                            |   2 +
>   sound/soc/qcom/lpass-apq8016.c                     |   4 +-
>   sound/soc/qcom/lpass-cpu.c                         | 249 ++++++++++++-
>   sound/soc/qcom/lpass-hdmi.c                        | 258 ++++++++++++++
>   sound/soc/qcom/lpass-hdmi.h                        | 102 ++++++
>   sound/soc/qcom/lpass-ipq806x.c                     |   4 +-
>   sound/soc/qcom/lpass-lpaif-reg.h                   |  49 ++-
>   sound/soc/qcom/lpass-platform.c                    | 395 +++++++++++++++++----
>   sound/soc/qcom/lpass-sc7180.c                      | 116 +++++-
>   sound/soc/qcom/lpass.h                             | 124 ++++++-
>   13 files changed, 1240 insertions(+), 143 deletions(-)
>   create mode 100644 sound/soc/qcom/lpass-hdmi.c
>   create mode 100644 sound/soc/qcom/lpass-hdmi.h
> 

Tested this series on DragonBoard 410c

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
