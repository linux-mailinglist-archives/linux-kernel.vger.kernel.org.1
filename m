Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62F292597
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgJSKUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgJSKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:20:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42431C0613CE;
        Mon, 19 Oct 2020 03:20:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j136so12219454wmj.2;
        Mon, 19 Oct 2020 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+od8QsmdcNI8OZjA/3MTkatI2Okd5ynxtRsQkbg/yc=;
        b=pmwp+5e60HkAwpCaj/SLLxEqogIbgvYgFIxOzeafEv6VTReH3z9OwBI848M9V6YTKu
         IZSniaGT7oXG0lEucuJ2xYKmxd7mECOKOHDk3MxeHruFUFxn4nBsNiO1BA3Daoq7IHrF
         Pcgqqr9vWzLjbUvn6RlgZ3I+prAmYeiJOGIfpM92GoWSZTG2Q4sd747U5NY5IfEO3JD2
         4oWscg7fgEtvX96hr9OZuCRkOkJbo2++oYK5ZXTos58q5OcFKuBQq8guiZ46HppV51LB
         B8si3ER0ePrLxpQfuL3xf/MoV3JAx5NkEJAL56X7lHYlUoRQSAtyT2EF5i12G/jpIdfz
         q//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+od8QsmdcNI8OZjA/3MTkatI2Okd5ynxtRsQkbg/yc=;
        b=DauPjW86tF+EJM8eEH96mY/gPhnDNK+YltV8nxasAJKd4OJUA8+SZ1As5ZzhSXy/Y2
         ny5MJCLpvsM4gLDPJmi0L/zY26IdKB2kbNI6pkQVb+c6Aq+DghGg7f1gi5h4bahX5rhD
         9uju01ndYwIPVex1lFiab7yQd7r23Yf95NklayrYwHbfzTAPfdRWrTXqKY8QnQR1z1g8
         xgjrFPIjpyOJfJAhhlhJCPZp0667FA44eVmG99o7P/FXYVPDFWY1RXdeCFTmR72RwV5r
         YWJSRr6+JX/xT7fkS2F2YCDdEwRv/3cMORRkwLz4ZeTqzN0Fht4naVdn6j2xc6zhhkvh
         uvNg==
X-Gm-Message-State: AOAM531Y/wf7ybR8S0bqJRVVJA8gvB0nhlNkpvygJ2mSMWkdKNZ6UOaV
        LBX2VRUdRh+a7dPZ4Jzqu70o2HGcFUTUtw==
X-Google-Smtp-Source: ABdhPJwaThc/I1/6bHe8HaT0JLVMEFTIjQn5CdrK0Yp5RP7RnlmLxY6edO/B86i5ytCYtGFLwJd5lg==
X-Received: by 2002:a7b:ce8f:: with SMTP id q15mr16837362wmj.88.1603102808024;
        Mon, 19 Oct 2020 03:20:08 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id i9sm16093776wma.47.2020.10.19.03.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:20:07 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: fix gce incorrect
 mbox-cells value
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     bibby.hsieh@mediatek.com, robh+dt@kernel.org
References: <20201018194225.3361182-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a7798c9b-ac25-6eed-055b-af3efe5a18e8@gmail.com>
Date:   Mon, 19 Oct 2020 12:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201018194225.3361182-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2020 21:42, Fabien Parent wrote:
> The binding documentation says:
> - #mbox-cells: Should be 2.
> 	<&phandle channel priority>
> 	phandle: Label name of a gce node.
> 	channel: Channel of mailbox. Be equal to the thread id of GCE.
> 	priority: Priority of GCE thread.
> 
> Fix the value of #mbox-cells.
> 
> Fixes: d3c306e31bc7 ("arm64: dts: add gce node for mt8183")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied, to v5.10-tmp/dts64 thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 102105871db2..9a3cf95676e1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -352,7 +352,7 @@ gce: mailbox@10238000 {
>   			compatible = "mediatek,mt8183-gce";
>   			reg = <0 0x10238000 0 0x4000>;
>   			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
> -			#mbox-cells = <3>;
> +			#mbox-cells = <2>;
>   			clocks = <&infracfg CLK_INFRA_GCE>;
>   			clock-names = "gce";
>   		};
> 
