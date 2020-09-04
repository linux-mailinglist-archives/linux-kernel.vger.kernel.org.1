Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC86225DF4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIDQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIDQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:07:10 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293ACC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:07:09 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 185so6953731oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=doLJDgNe0qt085BNPu/3Io3kfNCUU7JOawvznIdKbdg=;
        b=Bls3T86mzryTn+qU1zsr/9PYb0zkdzQQ2ypAxX9SKP9tu98U+eVySYDoXF3jIyFa8G
         XH3HYfOWR693y7ALBNUYECipnhoSVq9uQtmNNn8ZNJMY3gWyc7pbJWqOcy39gmSAsouj
         U8vUn6yRiuL/09+Q3ZPurtyUqlRFuuSAdVbkVyt9CLW/Hw0QFIVg8PBZUUjOuAjxdnu1
         Eak3IlxA4JLKEFyjL/fgoyooxv3/37UcREE9CZ1SSFV7DDDliFlyEcDpvFWUzCLDScXZ
         bwWi0RyelmbdQqrcGz83/qEBJCTQpYYw3g4kHp1J/RwwCAauH4+RwTUXB4UB+CfxXbSP
         lZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=doLJDgNe0qt085BNPu/3Io3kfNCUU7JOawvznIdKbdg=;
        b=lYxeVGEJeuO4rororjHNHL1wcVQ6TdZO0njzhKaHYLrF7FHbrvYCG/BYqDKU1JRJ3h
         tU0nlsJ40qwtGjGBDg0bcYcTxzVyy8U+WtiqEfbbQOiKmdU4k/P8vCKcVxgnMroQcXgb
         wK1lgMfnUcocU5Z/LmBLTwk228zfkGUBs70oFLSLbW48LDXTOe4nwG+MJmqjuB6E0pBm
         S7ffsRQg65xyDVaWGuVOyfgxOjzJ7C8m5+RcJWoQdhbNsgUEMGiy/R/ukkTluWcYvnOj
         krS00KH2/DPyB7LZzG929Mssxbcr6j9AmxbgmxGiutBg+qjRIypJt7eAvP5Nl4sa2dJT
         1r/A==
X-Gm-Message-State: AOAM53206pP8WRfXzrWqCwAlsAK+8+3R2mzOkoIxb21JItPKbzvQDt5e
        bpb6gDnqKxUBo5rLiO4cgJav5A==
X-Google-Smtp-Source: ABdhPJyW9FGADBJOCZRrQYFZdHWHjGtQOzqZty0xfmulX35Zut5RGG3F7ZSeSB47qhRZIBUayNPRPA==
X-Received: by 2002:a54:4f85:: with SMTP id g5mr5738063oiy.27.1599235628680;
        Fri, 04 Sep 2020 09:07:08 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id w1sm1370649oop.16.2020.09.04.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:07:07 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:06:58 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v16 20/20] arm: dts: qcom: sc7180: Set the compatible
 string for the GPU SMMU
Message-ID: <20200904160658.GJ3715@yoga>
References: <20200901164707.2645413-1-robdclark@gmail.com>
 <20200901164707.2645413-21-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901164707.2645413-21-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Sep 11:46 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
> split pagetables and per-instance pagetables for drm/msm.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d46b3833e52f..f3bef1cad889 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1937,7 +1937,7 @@ opp-180000000 {
>  		};
>  
>  		adreno_smmu: iommu@5040000 {
> -			compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,sc7180-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>  			reg = <0 0x05040000 0 0x10000>;
>  			#iommu-cells = <1>;
>  			#global-interrupts = <2>;
> -- 
> 2.26.2
> 
