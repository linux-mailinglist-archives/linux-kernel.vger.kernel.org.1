Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A992C7108
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391170AbgK1VwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbgK1S57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DCC094260
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:26:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so6419192pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ML44tgllE4GhZ96NC55829R7slIU4zlvmTfo9Y5Ub4=;
        b=CtUTtxibbbngBmaMGzF/xBSmCb34Lme4TIY/m+4cay6AaANrJmvTxg0I/EWkxqUCXi
         JeimiBP1WQkI9Sgfxt2lMyjvgtlDpAxLTEGOau90a/m62KI4+6Jq9g91ZHRF/2wQ0NM9
         FlfyzUdWZBLbX4xZypY+TgGwMwyTzO3Ig8Su+lFDYyxtvXRTqCEeF2kY9Ur+7fO3lWFh
         dIub9/3pKICDanyhPA2dwMFecUDlSCo3skYuITqqD1Ux4hRuAeamw5auZEfxC53sRFSO
         FjQNNSalcmGUbgiFq0xns/eEUG7xmAS5mHP23s8eqRfaS/22Wc8x5LAAYmoHuik6Ec0S
         RILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ML44tgllE4GhZ96NC55829R7slIU4zlvmTfo9Y5Ub4=;
        b=Z4oHupI+Ld440u6eGKaKDjhspXNvbQeURoRiaQC/oGn49nwh5jtHPLbo0cNBSepV2v
         UTHebj8guITL3ESS39PNEfjpshz8v6MtPOJBPbnxFe1ELiwumchzmTPdmc0hVJqxnNLj
         i22GXo3lk//O9W2wLgMIBW/lT+32VDE3KI3zYD/Jjld9h91ByIwqryvsYAbm/gZM5Nyf
         F10jpMUySuIL1O+QhGhXrLn53ltXYXtHHFG+HG1KJE6LY0av5rINeH78Fozp5OTafUWR
         aqE0gCfch7WZJ+akzXyykheAdxF71n0lxRKweM83UYHNrqkmE2V4As5P9LmTGdZCd6eZ
         IOOw==
X-Gm-Message-State: AOAM531T5H6DcbR2wXyI+/yIvIXdLPgUcT0OzFQC3SsqCCzzerPiRGQp
        j5mmzWx0JDwZiARP+qrqZ0lf
X-Google-Smtp-Source: ABdhPJzGMn39e/JsDN4rfXOqDkjg/hDUA+55auPmhInOZcR/LM1+cJY+cKYT+YsuhazfPWEZWyWRAA==
X-Received: by 2002:a63:1349:: with SMTP id 9mr88511pgt.107.1606548360444;
        Fri, 27 Nov 2020 23:26:00 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id u1sm9630216pfn.181.2020.11.27.23.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:25:59 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:55:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/18] arm: dts: owl-s500: Add Reset controller
Message-ID: <20201128072552.GR3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <29caef019fc29a62e77e59f537f6caa03597cac8.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29caef019fc29a62e77e59f537f6caa03597cac8.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:55:57AM +0200, Cristian Ciocaltea wrote:
> Add reset controller property and bindings header for the
> Actions Semi S500 SoC DTS.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index ac3d04c75dd5..a57ce7d6d745 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/actions,s500-cmu.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/owl-s500-powergate.h>
> +#include <dt-bindings/reset/actions,s500-reset.h>
>  
>  / {
>  	compatible = "actions,s500";
> @@ -188,6 +189,7 @@ cmu: clock-controller@b0160000 {
>  			reg = <0xb0160000 0x8000>;
>  			clocks = <&hosc>, <&losc>;
>  			#clock-cells = <1>;
> +			#reset-cells = <1>;
>  		};
>  
>  		timer: timer@b0168000 {
> -- 
> 2.29.2
> 
