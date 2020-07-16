Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE6221A69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGPC7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 22:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGPC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:59:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02125C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:59:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so3001726pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuoIleQ9Ji/xAYuJDXT6Z6dO3ZLl5ioORiaja/lMqvU=;
        b=yDC9WRFS8c2b76sobDkpCegCdn3qmN6PPKK4I3OvnoOO/1z9MLPmZRkplla4Eg/ukz
         1yjsgCBhx+fRw0LuToGQnO47Bl+60XCpT96Y0dXbMit9EC6ZdCMqRa6JraA+u7TbAW17
         euvBlP7GfXe6acQFG64G5x6qEgGoJBqWFEiHSaCnX/VsxbRMG4tS8yt8TyP+Xu+XFWc8
         s8IvNYvyMn1Ggs7e9HxoGYCErU0nRsm5i2C2E8eXWFut8qs1G363dUt0dmSIwNP+F2WZ
         pvtlrtM37l/jWHo+7dFbDMGm8W4A4TFN8bSz8LBagKLRQNt3tcBsj0Q/osGEd8IH85lN
         GHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuoIleQ9Ji/xAYuJDXT6Z6dO3ZLl5ioORiaja/lMqvU=;
        b=C7SYjMg9b6Af9j94Jtq7EfBq1fB492QpqbkIi0fmOj/KtKgCN6ThtjWRbUDkSDnAC7
         wVV1s7+gXUCV0rW0b4cv89xGdsESq4NIRjarUyiI6YrBnsqHeaRi8gIQUSmmGcVXutO/
         Q+X/qAEI4C3c9zk41OSfWxkXKjkL32Bbaa+xYj9GqeGVmaZ7lWqBSyb9E1wQAJKfTYTU
         oXEHNzFi8YCamn/taIvJ5cNVARpBCaL2XirYF6vogq2OESTdi/bpxdjXLLIdTTXiELOm
         sURCrj0p43WR3BIfJQO3Cehys/E4KtuGeiayzxeRjMj59tMENrZGKPcZirb02WIlH92l
         F29g==
X-Gm-Message-State: AOAM532USHpAzuv6N1DXxBZBzPmD6bGwRCqAni/RNQwrtQfL0m4ioSgs
        aIWfPYxwzzp4aLp51Av1VdLG
X-Google-Smtp-Source: ABdhPJzWhG+hWqD5f/hYQ2NvZiC3lvnRQfSCnWdqN4YpElhXZ2qpZ/W6KhstotDJpZvgzwohyXYNxw==
X-Received: by 2002:a62:8688:: with SMTP id x130mr1902048pfd.280.1594868383282;
        Wed, 15 Jul 2020 19:59:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d89:fed1:9157:c271:c363:4849])
        by smtp.gmail.com with ESMTPSA id h3sm3217799pjz.23.2020.07.15.19.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 19:59:42 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:29:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8250: Drop tcsr_mutex syscon
Message-ID: <20200716025932.GA3271@Mani-XPS-13-9360>
References: <20200622075956.171058-1-bjorn.andersson@linaro.org>
 <20200622075956.171058-5-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075956.171058-5-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:59:56AM -0700, Bjorn Andersson wrote:
> Now that we don't need the intermediate syscon to represent the TCSR
> mutexes, update the dts to describe the TCSR mutex directly under /soc.
> 
> The change also fixes the sort order of the nodes.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> Changs since v1:
> - Adjusted sort order of the nodes
> 
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 7050adba7995..67a1b6f3301b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -144,12 +144,6 @@ scm: scm {
>  		};
>  	};
>  
> -	tcsr_mutex: hwlock {
> -		compatible = "qcom,tcsr-mutex";
> -		syscon = <&tcsr_mutex_regs 0 0x1000>;
> -		#hwlock-cells = <1>;
> -	};
> -
>  	memory@80000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the size */
> @@ -376,6 +370,12 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>  			};
>  		};
>  
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> @@ -486,11 +486,6 @@ rpmhpd_opp_turbo_l1: opp10 {
>  			};
>  		};
>  
> -		tcsr_mutex_regs: syscon@1f40000 {
> -			compatible = "syscon";
> -			reg = <0x0 0x01f40000 0x0 0x40000>;
> -		};
> -
>  		timer@17c20000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
> -- 
> 2.26.2
> 
