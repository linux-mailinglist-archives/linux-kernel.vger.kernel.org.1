Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D6280F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbgJBJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:11:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65FC0613D0;
        Fri,  2 Oct 2020 02:11:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j136so926381wmj.2;
        Fri, 02 Oct 2020 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8sjYxuBkwwfLCJdcsNIECFFL7vsWBubB9+n9PHGGPs=;
        b=TCdfGntsyw1waB7d5uBvcniLx8tutSj7FDcOqvJU4dyVkDfnDWJ7IhasTN846qxkRF
         eUvNlYKJ60wEdTN0SxEicLHUPbdVzztUVIkfC6nNeWtfsRQmqRZgu2UJynLpfcWrFq7Y
         +C82+9ko/wvLdY7CmZPElmbUnO3WXiI8VCKr9TgiHKCeJyDhfXmggU6DX/AGICVxLwnW
         y+kppNhU4mF28ptAXoXC6pqbG28FxSBRpMrnzD/JhC8P2/5TxPjJ3VvgHv2VKBYelR2L
         zNJ6Kzu0yp/qHcih9cM51/HNxs1+UxqB/OA/CVr8KBOkAoDweaiUJhNkbrWWBUhqINm8
         y7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8sjYxuBkwwfLCJdcsNIECFFL7vsWBubB9+n9PHGGPs=;
        b=KxCTgSMMssZQE/EVdI/M0LoyOS5I3Bf5NqkTihGEPI4N193DBezF3SPadxmh/t6Zru
         rCRyDBBMEg92lVa1/JuLGgWMY0mrEux92p3nWEGJvgf3GzH1ZW+L5jij6v3+B9nYzvZF
         woIuqsachUjFqVSUoUvL+SOY9DM8s+Rbq3rnXYagWTuuU7N8K+GEVWGe/HimZSSXlGNl
         0cjAP13IxC7+wzbhNetrszlDUPPFjgX3wMYEGD3vF+vmhgwSfVHEOgeWbIz59Rabkh+A
         89chjsjzRgP6dkdRuGj/VjjKLaiyJzlwJi4uFATCJPl8cLzBXAnR41t6yTrwXuwSCqX+
         J+hA==
X-Gm-Message-State: AOAM530JebwTPsSTkG1FrndY8usvSZXaLP9eRip0eyiK6XInj28gOcOj
        ty9nSmrok5lFd7T+GyTnzWQ=
X-Google-Smtp-Source: ABdhPJy8Mrw34LM+35Ok95pZgOyUQ2MIWncbi40rYI4yc/UePQnaewZFhARbTSOC00ajkgbtSYmNnA==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr1748837wmb.139.1601629886617;
        Fri, 02 Oct 2020 02:11:26 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id t203sm1031893wmg.43.2020.10.02.02.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 02:11:26 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] arm64: dts: mediatek: Add mt8183 power domains
 controller
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-13-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6b972d3c-df15-7900-eeb0-df928fa3899f@gmail.com>
Date:   Fri, 2 Oct 2020 11:11:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001160154.3587848-13-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Add power domains controller node for SoC mt8183
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 162 +++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c         |   4 -
>   2 files changed, 162 insertions(+), 4 deletions(-)
> 
[...]
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index ec4cc5eeabff..0c490f509655 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -560,10 +560,6 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   		.compatible = "mediatek,mt8173-mmsys",
>   		.data = &mt8173_mmsys_driver_data,
>   	},
> -	{
> -		.compatible = "mediatek,mt8183-mmsys",
> -		.data = &mt8183_mmsys_driver_data,
> -	},

Looks like an oversight from your side? At least it's not explained in the 
commit message.

Regards,
Matthias
