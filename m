Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CAC2C7192
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390909AbgK1Vvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgK1Sw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:52:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE16AC09427D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:36:58 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f5so3714529plj.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKXoDo4GMnnXU+DzczU3JYBzijigbELAPfvY5SGNMlo=;
        b=UznWtLUhhclL/waKTKoBlETE2iVy4gCrCBSOVOtJqPbRm3yj8uXKVkjyt/rRQCDlhM
         oz1llkWiUAY4WRKEapbOX3lbO3wZDf+bX50hhcY5Me42DYUrcQ/dGHd/Q6+04Bwclqjt
         Dr2ylKtBkHH98l3rNRS1FbBt2PZ8952vnIvbQukmTgDG/5tUW8uM0jZH2nTfqvcUKNnU
         nsdieqiCLlCCAp5jpEBNd/vh1OFJoY+70CW7Vvw47cLHri8QubKARCAQUshNxSmG/a+y
         q7W54d25bfzRL/5Rk6dFe+4JovsHm3OHtC+zKzgrxbEjXlLbkzux0CEruEUyxE7AEYD1
         EB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKXoDo4GMnnXU+DzczU3JYBzijigbELAPfvY5SGNMlo=;
        b=MUWUTs8UBKSVlfpZewRRI38EtLkn+lgq4cA2ulzJuG1guOA3jPZSWQ8fHng5RDIbcr
         A+dDg66m8pq52Qt4zvAq1XT6CarmYJWFSpW2pG464j198nMEXU9WlzO0oQ/enABtnqUq
         HVK0JHMpMAK5/wpKOhm4Qrf8QDjYRaAxzVE9TfdvygBjyRRYaBr+bPQ6QOmV55HDZQBA
         uLqSN+FhFcU9vMrvU79Cy7r1hTS7TZnvOYkGLLhKCNJEXnbmbue8iPdRV5jV3XN7/svY
         QFy7gstDRDtb25fdkCDohhApnAq3ELFSnNrLaFUI8aXNYFGvFXAKElrGHaVWPMUX6cjy
         feGQ==
X-Gm-Message-State: AOAM530cXs1pPmsgPhVxofrHvQtbTRbr7DVcLjGzHYlShaqRSp6KaMcp
        iwVGLB+QFEx2WMgkm4MYQ+VhR6FoD09I
X-Google-Smtp-Source: ABdhPJxGLN0v7j8yhazmNiVoPxnlnrBEZUrVc33SJEyOg4EaMpI/vd5m1Q69beQb3jgtcS/el2CpoA==
X-Received: by 2002:a17:902:9049:b029:d5:eadd:3d13 with SMTP id w9-20020a1709029049b02900d5eadd3d13mr10086715plz.15.1606549018482;
        Fri, 27 Nov 2020 23:36:58 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id j11sm9397101pfe.26.2020.11.27.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:36:57 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:06:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] arm: dts: owl-s500-roseapplepi: Use UART clock
 from CMU
Message-ID: <20201128073650.GB3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <976d0275aadbf691df87aba27a8a6be20ca3de53.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976d0275aadbf691df87aba27a8a6be20ca3de53.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:09AM +0200, Cristian Ciocaltea wrote:
> Remove the UART fixed clock for RoseapplePi SBC and switch to using
> the clock provided by CMU.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Please club this patch with the one adding CMU clock.

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> index a2087e617cb2..800edf5d2d12 100644
> --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -25,12 +25,6 @@ memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000>; /* 2GB */
>  	};
> -
> -	uart2_clk: uart2-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <921600>;
> -		#clock-cells = <0>;
> -	};
>  };
>  
>  &twd_timer {
> @@ -43,5 +37,4 @@ &timer {
>  
>  &uart2 {
>  	status = "okay";
> -	clocks = <&uart2_clk>;
>  };
> -- 
> 2.29.2
> 
