Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3D42C5B03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbgKZRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404532AbgKZRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:47:15 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:47:15 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id y74so3017958oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ji9tlscliCLN0LYIyEt9KD3a3MCIVAkdS9NkM4jRpzU=;
        b=GeqZtzB8CzX8/SX36WTvrTjGZINKtLen+xUmDFCJoF60rC43wPoG+F86S9YXQNSxO7
         S43tdvejsYFX3dNMSu0Taxbxc9/loWYec+adZRBEaFo0hIuyZ+MjnekJGM31pTDR7iQu
         lxtHUjWyHCoOqTKKnG4gRBCrVuNBJ0UMPFtNhII8Cyhx3BShvAFtkw+UsRtWh1G0LATm
         bbDWMd+yFVlH/gf/oR8Z9CxnXUZjYgd2fuzBLn8KF99OnlXUk5yKN6rciwrIhzcVG3nj
         fH/xe4tAgmnEb9afBRI7/LNIL5hlZ1jl/uS8PWeXXEXO/J2KVAmXD15p5utHnPCU7vaZ
         Uydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ji9tlscliCLN0LYIyEt9KD3a3MCIVAkdS9NkM4jRpzU=;
        b=joVDqnvIXXcPyXvRaA04O2ndPJEQt56cCVHpGNKwMhy5yhKmLcxVS3Ob1ANjy0OxU6
         k/9/5wRoQHMKrF2b1VY71xLd+DpIEFQKavewE6ham68jIaxxC4jtEDeqZn+PXfrC0BBq
         ePVWHBYlnotoVuBU+4p+5LRURorJc5r7yiyy8kfvS9fEKjr0klX21iL7/7s7IEVYZ4sC
         154xu6mQ3dTX7ZwuNz+ekApIa7At1ggoswSWCA23Q8MHgBP/fP6zB1KdiRTSYAAI4IJG
         HFyvD/ZHbrJ1TFoN39Sf5ONnOJ/A8kcgJmRAjP/NNRMDyKrGuU3gf8hPpThf66H1ZD9w
         wd7w==
X-Gm-Message-State: AOAM532s4XYk4z0BHrTcniw8MJcT26E2zDfEpYhFzulN47Yh+8dMInaw
        fAz1uczk02Y6mE5xGYxsQZugnQ==
X-Google-Smtp-Source: ABdhPJzV4JJZig/67KvTlQcOUGc8xVp51xSXwYlfjM7f8LjhRhYB1WlGP/8UUTGdyZAx2bNEQI2RBg==
X-Received: by 2002:aca:ed86:: with SMTP id l128mr2744772oih.0.1606412835129;
        Thu, 26 Nov 2020 09:47:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o29sm3357331ote.7.2020.11.26.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:47:14 -0800 (PST)
Date:   Thu, 26 Nov 2020 11:47:12 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc7180: limit IPA iommu streams
Message-ID: <X7/qIMCOewRMG7Hy@builder.lan>
References: <20201126015457.6557-1-elder@linaro.org>
 <20201126015457.6557-2-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126015457.6557-2-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Nov 19:54 CST 2020, Alex Elder wrote:

> Recently we learned that Android and Windows firmware don't seem to
> like using 3 as an iommu mask value for IPA.  A simple fix was to
> specify exactly the streams needed explicitly, rather than implying
> a range with the mask.  Make the same change for the SC7180 platform.
> 
> See also:
>   https://lore.kernel.org/linux-arm-msm/20201123052305.157686-1-bjorn.andersson@linaro.org/
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Fixes: d82fade846aa8 ("arm64: dts: qcom: sc7180: add IPA information")
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index c0efb101b0d61..eb66aadf360d7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1396,7 +1396,8 @@
>  		ipa: ipa@1e40000 {
>  			compatible = "qcom,sc7180-ipa";
>  
> -			iommus = <&apps_smmu 0x440 0x3>;
> +			iommus = <&apps_smmu 0x440 0x0>,
> +				 <&apps_smmu 0x442 0x0>;
>  			reg = <0 0x1e40000 0 0x7000>,
>  			      <0 0x1e47000 0 0x2000>,
>  			      <0 0x1e04000 0 0x2c000>;
> -- 
> 2.20.1
> 
