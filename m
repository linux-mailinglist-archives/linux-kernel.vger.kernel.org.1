Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6929DE18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgJ2Ava (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgJ2Atw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:49:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:49:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so926060pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QjqMc7l+70GPiHEtdcLDE2w5wxCubKj+e+9vvDhN4jw=;
        b=KWesP9d25XLLiCMeDoho0aDAfWKj5ghD7xuB9bZ/rz7fD2ZttLECup+c3B9hOey+de
         moHDsKZEfVZM/JNlZYMtKT3rx8fgMoLiz62UGRQXQk6zoHpZaStlCtIJNNz5EFLWD5o0
         zBTVsxNKNkaI6yNaolffTZybUeJVIAtd622/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QjqMc7l+70GPiHEtdcLDE2w5wxCubKj+e+9vvDhN4jw=;
        b=h4MoFviVUGSLt69DukpQMwMx7HLEXIufw2rfrNlgJU/MJeaeiYXro2QQqHvYHWk+7P
         rNtnssFTJHtjX3uJo5HrVLMcH3feluWNs2DXQcKbc5m/FrozEMLE+jdHecJPWdv1SD7J
         W1i8HuMmdQC1TkPke4zhBFI0055SlZzhMkrRrcKpRB3n1P4sgbvr9xVXva1FyXNefJvK
         PrXXnNx3QMakU9XqgErpJ3RLUPjolcHFDniBzri/V6nrG0CJjIhdscZ1WeyiBTrkQLYW
         l+sLE7SzeAunqyNWuFNSB7NGWSfZopRdU2kzIkESMG0qrP76WPQcJhtGDMtvBUO4v7g0
         YkrA==
X-Gm-Message-State: AOAM5334tOzn6nJDjO7hPwixt4P+exw6cA+9GGY/vQNjajY+JLwCMJoG
        uJTuelQUSWPUROQzLoScJ5H8lg==
X-Google-Smtp-Source: ABdhPJwEq/sau27VV7p4hVDzceI1BjScm1N5vyp0R9X8+H9CxHrUZkAC08SATGsvPL31v7pDv5VeSw==
X-Received: by 2002:a63:f502:: with SMTP id w2mr1727045pgh.186.1603932591575;
        Wed, 28 Oct 2020 17:49:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id 17sm789966pfj.49.2020.10.28.17.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 17:49:51 -0700 (PDT)
Date:   Wed, 28 Oct 2020 17:49:49 -0700
From:   mka@chromium.org
To:     Akhil P Oommen <akhilpo@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, dri-devel@freedesktop.org
Subject: Re: [v3,3/3] dt-bindings: drm/msm/gpu: Add cooling device support
Message-ID: <20201029004949.GB1855806@google.com>
References: <1603892395-3570-3-git-send-email-akhilpo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603892395-3570-3-git-send-email-akhilpo@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:09:54PM +0530, Akhil P Oommen wrote:
> Add cooling device support to gpu. A cooling device is bound to a
> thermal zone to allow thermal mitigation.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 1af0ff1..090dcb3 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -39,6 +39,10 @@ Required properties:
>          a4xx Snapdragon SoCs. See
>          Documentation/devicetree/bindings/sram/qcom,ocmem.yaml.
>  
> +Optional properties:
> +- #cooling-cells: The value must be 2. For details, please refer
> +	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml.
> +
>  Example 3xx/4xx:
>  
>  / {
> @@ -61,6 +65,7 @@ Example 3xx/4xx:
>  		power-domains = <&mmcc OXILICX_GDSC>;
>  		operating-points-v2 = <&gpu_opp_table>;
>  		iommus = <&gpu_iommu 0>;
> +		#cooling-cells = <2>;
>  	};
>  
>  	gpu_sram: ocmem@fdd00000 {
> @@ -98,6 +103,8 @@ Example a6xx (with GMU):
>  		reg = <0x5000000 0x40000>, <0x509e000 0x10>;
>  		reg-names = "kgsl_3d0_reg_memory", "cx_mem";
>  
> +		#cooling-cells = <2>;
> +
>  		/*
>  		 * Look ma, no clocks! The GPU clocks and power are
>  		 * controlled entirely by the GMU

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
