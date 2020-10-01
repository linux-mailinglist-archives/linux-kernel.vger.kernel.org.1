Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E6280222
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgJAPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJAPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:06:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFADC0613D0;
        Thu,  1 Oct 2020 08:06:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so6216516wrv.1;
        Thu, 01 Oct 2020 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9X3iERDbIbWtybzrjpm4PyjretbOiJRxybaokBX9Fg0=;
        b=Tzq+4MRra4zQj+RCJIesVpnmOpe+lMM0r5EyIM+dLL5Y8ZF45juiRpqBPjXpJjTEep
         jZqq+RlXkaF/7ymYK2gdZSuAo1xTI2zzeGOyiH5XRCGvh9uPRFbC3h8nx1n33VUQlrZ0
         /kr0x697ID/2lcyIjaxNcz0mJG3bStTpSsihScQjy0hHcaic+wJFZrzkLiuRuTSUUIlb
         KgwwBZlSaKNU+ROfDzecfBCJY+QlrcpwkhAzMqLAWFnUI6TFgByOePz4Hfz/nt+yzrp4
         HXkxXEl5Im4vKPPK02YrT5J+KVFE70i2d49HTdnpdbQkmwnBqU8+NiBXJxGMUHqwIKf7
         /M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9X3iERDbIbWtybzrjpm4PyjretbOiJRxybaokBX9Fg0=;
        b=US0EdcxOgO7lEHeLkN2GT+Mu9bq6sybb466zv0JKMTY7/0AKhu+PrkhL85uGi8P5XO
         YDPL7P4OEntne3ZhMaTxjd9Lp8axRjpnk2axtMXoRQF3lsGuMzhj6FN3ghdEjF7jdGpg
         gu091jfdyZTBZY30qv8249XUAXYnr2FbkF7fcs0MGNnN3KW11D2wsvPSBQl7TfGOtOLy
         AYuXvxv82B3pNub9FOnKL/MZ6C9zgzIXXG0RNFSVU2Gl5FrHoExZBZ31GZ9CqfB6Yp+Z
         BfVwV/mnFVtmbp+MLVbuh12FP5nDvSJvrmr1y0/2eVrPTE+wVLgn5hXbqdjkxdVNF9M3
         Iq/g==
X-Gm-Message-State: AOAM532UMd4TfMVo0gwYObSRMtnh6+0xgUF+aE5C034p3snNylpjB3Lg
        fsoxaisAJ6q5yimwf1orWZM=
X-Google-Smtp-Source: ABdhPJytgs70Nfgs1c16EtWZewVO9V+uwz7ZoF4TGOHupPJthQ6GrjQPZnvAXDHBzTfqqriYbRKa+Q==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr10257410wrp.271.1601564781886;
        Thu, 01 Oct 2020 08:06:21 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id d19sm391985wmd.0.2020.10.01.08.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 08:06:20 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173-elm: Remove ddc property from panel
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        hsinyi@chromium.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200826090218.682931-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <55a87e63-0c9d-3481-797a-b2b4a13946c4@gmail.com>
Date:   Thu, 1 Oct 2020 17:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826090218.682931-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/2020 11:02, Enric Balletbo i Serra wrote:
> The elm and hana devices uses an Embedded DisplayPort (eDP) as interface
> for its panel, so the DDC channel specified in the binding is useless.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Applied to v5.10-tmp/dts64 which will be rebased on v5.10-rc1 and called 
v5.10-next/dts64

Thanks,
Matthias

> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index a5a12b2599a4..1fe5dac24ba1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -86,7 +86,6 @@ volume_up {
>   	panel: panel {
>   		compatible = "lg,lp120up1";
>   		power-supply = <&panel_fixed_3v3>;
> -		ddc-i2c-bus = <&i2c0>;
>   		backlight = <&backlight>;
>   
>   		port {
> 
