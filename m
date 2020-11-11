Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5972AF5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKKQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgKKQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:11:12 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20179C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:11:12 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id g19so2578180otp.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+ykpy+tQ8wBKh31P6ADeGnAEx1y44RGfEZjNyqN+vc=;
        b=Namw3wnM4UZgTp7jowbUZzT8wApZibHbV6PMse35e4cC25jeLpRbFUXeK9wNdVJ+Xz
         UH3H7NQxOLOj+X4tpa9sJg7GxqAAGkXwHkuKWGNO0NePWHU/5SawGJkxZeWCvasX/QFG
         bTrcXPw0olsYEoRRIimOFtwlxayXWOYlp8AgtznlGzkNze8A8c/oEgWb0VplP8Zm+gqU
         98B173z9lD68a3Mr+EjKPeNa7PBaldf+SA4mNq5ISa+R+NgvrfJXHamXq5O2jdDelHcV
         9E6bTzTxDWiPwhUXCyt7egaEzO334m4enBSh6b28p8nP5X0+8VEmL0d0PGVfhWHNIICG
         rJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+ykpy+tQ8wBKh31P6ADeGnAEx1y44RGfEZjNyqN+vc=;
        b=lxyqobtTwHX5+wCs9IOSy5tIxFO0t9ELy4hLOMcWEFeGaYFgYdKCgNkDqv4gcfDRk2
         JZqaa3x6KZq7CrrbItElsup4B9HEt8DUC/8mlJ/4oIfKw+X9+ciQkYWEG4t3ojGsh9R6
         apL5HlXvTfgaE5STRrYZXktj8QY8r5eKhjErruxbv7ca1ssbhGltEQ5YP5y/jg2oVQeh
         vqiUxRBiwy3FM2ypN+IUxzC+vLuutsyWB6Wlv742VkN3WM4u9R2jyaIGaATwxoVlJX6V
         0CNLYMU/rAcp9nlKX8fewpTyB3vX8M5b0OVmcGa47Dg1IleMvtBqXBKyT/5CL7KTPe0M
         oXOw==
X-Gm-Message-State: AOAM5307R9+v+xmJNMx3ngDMQsy7zXprBqSwKCd1SOcY8ZjB7xIF1sSw
        gcEJu9YlvTQktQbHMi0NaAZxLQ==
X-Google-Smtp-Source: ABdhPJx1ruPUefHjIi6jcYlxgdcUOSsbEa7ZcgA9fpFt3ban+Z00ztiVbxkyPVseyWooiZ5H43aPEQ==
X-Received: by 2002:a05:6830:1c62:: with SMTP id s2mr17064385otg.177.1605111071523;
        Wed, 11 Nov 2020 08:11:11 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 98sm597114otm.54.2020.11.11.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:11:10 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:11:09 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Assign numbers to eMMC and SD
Message-ID: <20201111161109.GK173948@builder.lan>
References: <20201111073652.1.Ia5bccd9eab7d74ea1ea9a7780e3cdbf662f5a464@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111073652.1.Ia5bccd9eab7d74ea1ea9a7780e3cdbf662f5a464@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11 Nov 09:37 CST 2020, Douglas Anderson wrote:

> After many years of struggle, commit fa2d0aa96941 ("mmc: core: Allow
> setting slot index via device tree alias") finally allows the use of
> aliases to number SD/MMC slots.  Let's do that for sc7180 SoCs so that
> if eMMC and SD are both used they have consistent numbers across boots
> and kernel changes.
> 
> Picking numbers can be tricky.  Do we call these "1" and "2" to match
> the name in documentation or "0" and "1" with the assertion that we
> should always start at 0 and count up?
> 
> While the "start counting at 0" makes sense if there are not already
> well-defined numbers for all sd/mmc controllers, in the case of sc7180
> there _are_ well defined numbers.  IMO it is less confusing to use
> those and match the docs.
> 

I'm happy with this motivation, patch applied.

Regards,
Bjorn

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 4e7e58c63285..625e922c273d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -31,6 +31,8 @@ / {
>  	chosen { };
>  
>  	aliases {
> +		mmc1 = &sdhc_1;
> +		mmc2 = &sdhc_2;
>  		i2c0 = &i2c0;
>  		i2c1 = &i2c1;
>  		i2c2 = &i2c2;
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
