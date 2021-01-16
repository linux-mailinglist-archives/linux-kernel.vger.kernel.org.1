Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4302F8CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbhAPJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAPJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:44:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572BC061757;
        Sat, 16 Jan 2021 01:43:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m25so16823314lfc.11;
        Sat, 16 Jan 2021 01:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tH1FfnEn8JXTNa4hydnSMQatFGPe506ZHFNVWjurTFI=;
        b=n61YhPHsdYSoCtMD+DHDWHjOy/cP7S+HNnm/vVGgjvoSfHtfR5Mg9xHODAHtMyD/L6
         wsNOYb4W++J8YKDpJfI1sNkLJa2NvuGEgwubg/KoW59EHKNNVsvIqHXX8dDW5FwIjTwy
         2WuH3Wi2kiM2T6QqyCd8QetHQp4IFPogNnfEx6xA4Wl4eOyCmd9KsClOBALv3woAjD3r
         a1JpSVit/FtPAPYPrkHr4PweaigrQTFzeXze1wUfFt0b+dUYNtp6ZUFev9qb9VrIxuAL
         HDFreWJcORyLWT1toQenBk7S8pE5aOTXHonu38WsZKnFfaigUZH27wvf1sHj3gRzpVtX
         g8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tH1FfnEn8JXTNa4hydnSMQatFGPe506ZHFNVWjurTFI=;
        b=F2rIshS9Qi3bvAR+wFl0DZjsa6XvXc8DMv5b35zUUShW+U2GEvXMLqoH/GyJROp/Dm
         4DnHXPEOjjNzTztLVbGr6pkNW0V3CPG1Wh6098GSZKm22xEZH827EFCivleAxC0Y5wT/
         inpLElqdxbNeLx9rtcj0dbtdqCJoCS8sCib5cE2ej4rs71PhBOHISQvFV1SP6LuVwLde
         In/LW1Nxd02BqDcInKdHn7Fvcnv0T+s8V40HOdf8jnUbSxoVRsFtqdpoywJ3ww+63gb5
         C0uLeMn+IoAHOvR5TMO4msUK7SMpbUsLKdADgi6uk6SyJe8SIrT9b0nngfXl9o8Ctm33
         4xmg==
X-Gm-Message-State: AOAM531+6DCyTU7Ea8CIYyujlAyIMMgFchCPYLVhffh+foHIvH7128V3
        NPPiRwtCthVC6BSPZhw1uNmEk2Ii+KVTXQ==
X-Google-Smtp-Source: ABdhPJxkrY0FRHa3eEYLnBkBzPh2RfODh8hCDtchdj62H5fYZ9LULwnc7eSwbmYwjIw8MZyYYndp1w==
X-Received: by 2002:a19:7d2:: with SMTP id 201mr6935698lfh.518.1610790231095;
        Sat, 16 Jan 2021 01:43:51 -0800 (PST)
Received: from [192.168.1.100] ([178.176.75.157])
        by smtp.gmail.com with ESMTPSA id t26sm1048194ljo.16.2021.01.16.01.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 01:43:50 -0800 (PST)
Subject: Re: [PATCH next 12/15] arm64: dts: mediatek: mt8183: fix dtbs_check
 warning
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
 <20210116090656.11752-12-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <8973d175-441d-0b03-6763-6eeed8595b17@gmail.com>
Date:   Sat, 16 Jan 2021 12:43:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116090656.11752-12-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.2021 12:06, Chunfeng Yun wrote:

> Harmonize node names, compatibles and properties.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5b782a4769e7..a69a033a68ac 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
[...]
> @@ -908,11 +908,11 @@
>   			status = "disabled";
>   		};
>   
> -		mipi_tx0: mipi-dphy@11e50000 {
> +		mipi_tx0: dsi-phy@11e50000 {

    Again, why not just "phy@..."?

[...]
> @@ -931,11 +931,10 @@
>   			};
>   		};
>   
> -		u3phy: usb-phy@11f40000 {
> +		u3phy: t-phy@11f40000 {

    Here as well...

[...]

MBR, Sergei
