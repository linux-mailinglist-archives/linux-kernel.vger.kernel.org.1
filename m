Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588EE2DF858
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgLUEnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgLUEna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:43:30 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E53C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:42:49 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 11so7790328oty.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wWEd+TxYdAPpu8bXys3dBLACeriF2mvf//pdErslYdo=;
        b=fsvC0lRr9040uKgjfwIxdY5FblJVUz3r3vxNxL/TytM/xLfLMlIRXdUWAcIEA6uapV
         A7pyAdobCwrZRjyYMcfN2VCZUKf1fD//dEBgvP/+J7bM+jGfQ1CdSOHgRCX3gFuZHHEX
         ulLYrMcUfxutFHegle1CFISmppUrBIAUwsRVB0MDJgP8Ez+bhM7KZuVEIZnXWKVNzY9t
         SClqxerz90aFmSPDlIcV22/V6uh9KpKNtjMRkLHNWbJG8lWhMqGaxjaKwBUfw2T7dps9
         NfEmAgJRKXI5WbMlb14g14b3seIghHoIb9RhUC0txCYo5aToI0e0YNw4yrgxy1XhCbCE
         O3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWEd+TxYdAPpu8bXys3dBLACeriF2mvf//pdErslYdo=;
        b=fH9rre1HsV1bY3BQcb1CQqPrDSAeCE60/ijg8V+JCSq1yYUeYGJlhCvOwbBw7YATuM
         OrvIOx2ksuYm00xK14yR93/UEad18MXE8AD4VJsHb+IpVrGlcOfCpOLUYncD385slLiU
         R+a6U2Gr4BvV2aPSuTddLtByB8603zGH7RclbqawjIkQ/ZqnMQ/0Fta7+UNaEFISvkV5
         ARpMSyJoUbhFnTxrYXoQI67LW2VjR4OxvotKwOufxmJgnj62NWEczQ4ooz1mqpjGag3S
         jl3hJd7tR+pjxFohOi4xuruBitupn17AUiH8DR9dry2VtlCaxQOqXr7fsdqFPlzgAV0S
         gXhw==
X-Gm-Message-State: AOAM532E+aL0UJO2A1shqfoiC+O5LUfMtrJh4DSES+0WP/nYeaopou2d
        QE/MAKq5uli8+fohoCsX5mYj6/ml7PLY1Q==
X-Google-Smtp-Source: ABdhPJxq9/CFGCuX1W08nV7vtLJy7F85mt6X2DfoEUGGeEK1nGnoLCHycUC54CMScahha32mvW2NrA==
X-Received: by 2002:a05:6830:1493:: with SMTP id s19mr10850044otq.175.1608522817719;
        Sun, 20 Dec 2020 19:53:37 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s26sm3600580otd.8.2020.12.20.19.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 19:53:37 -0800 (PST)
Date:   Sun, 20 Dec 2020 19:54:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sdm845-db845c: Fix reset-pin of
 ov8856 node
Message-ID: <X+Acbf5Ks7R+M6ZW@ripper>
References: <20201217151200.1179555-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217151200.1179555-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Dec 07:12 PST 2020, Robert Foss wrote:

> Switch reset pin of ov8856 node from GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW,
> this issue prevented the ov8856 from probing properly as it does not respond
> to I2C messages.
> 
> Fixes: d4919a44564b ("arm64: dts: qcom: sdm845-db845c: Add ov8856 & ov7251
> camera nodes")
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 7cc236575ee2..a943b3f353ce 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1112,11 +1112,11 @@ camera@10 {
>  		reg = <0x10>;
>  
>  		// CAM0_RST_N
> -		reset-gpios = <&tlmm 9 0>;
> +		reset-gpios = <&tlmm 9 1>;

Please do use GPIO_ACTIVE_LOW as the argument...

Regards,
Bjorn

>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cam0_default>;
>  		gpios = <&tlmm 13 0>,
> -			<&tlmm 9 0>;
> +			<&tlmm 9 1>;
>  
>  		clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
>  		clock-names = "xvclk";
> -- 
> 2.27.0
> 
