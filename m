Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A08294801
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440685AbgJUGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406908AbgJUGAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:00:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04486C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:00:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b6so1684608pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sV3+wt9zFFbC6+nsUltQzVVUqo2YMcdWS+EAIoi53yw=;
        b=bVAKtLkRtJ5M+V7D6AGwnhR/VLVukU3Chge7kAM9veyx3a7zpwCcoqADy3+D+co+9y
         +AjC76EQu9jBB9tOOhKbh/+1GeWx/SjSVTathWihC16iH69TAMv1ipH5jKa9CCGejByk
         7IwWfIesQPzg3LeQ3HDXFhYxjclcagvcU28NO3wM7YPXrVrTOw6etxNwFeeS0QQgLxS4
         A0swdFIgrwCGlIec2JJwGZegyuqdkw4jMpVqXNpMS+z2xdKQ73RS8kRYgQimsu8wU7Jy
         GmGP67oDLGy4bJT1Z5udsX4/W5kdbHyv0Ty6d86XLhbs5UGCWW95IWQpEAo7sGqLUmAU
         PVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sV3+wt9zFFbC6+nsUltQzVVUqo2YMcdWS+EAIoi53yw=;
        b=G+HPnu/7hdTX1LvnyRFOFzOW8lqA+9RpscxEj9EHAgmT+3a96PgGYa8HefFm/n+6bt
         NXg73oEhyYdktBLW1kL4+KIbH9vdUYjmWjn0n7hfYcDgPleoJOjRgo2Yz4ppr5hH4kE0
         lfwGKS7RVPBndA/uI7yn4yBDXrJUam66ncdmd1uLOv39y+fm0X1xjygQQjEYmIvkAwWz
         PJzB8WQbUmJoLouO3dvUzCsNDuBxXpj3SD7uWy5OmSantWDY3cQe9JxQS/k6TrDBbG/B
         jxx7jJOfw3LptbFkbWVhfm8uQTtFL+KIlF+oNDcWtJ0EKtNpEGihCVNOVq9mxOuwOH5E
         UgqQ==
X-Gm-Message-State: AOAM533xiL02gr+kLLkpyszB3Q7CSyUBmiQJ8WHzg2lCgwvSqk3XvScf
        y/D91csNpa0CG3NF0DhcZI5y
X-Google-Smtp-Source: ABdhPJyAqTQulqdyuk6k5/4yZ5jU6lIcDcfHXYbAMlDk1J2/ElxDeCOAY8TEWDDz2aNUv7e052XPng==
X-Received: by 2002:a17:902:ee93:b029:d5:c3f7:9718 with SMTP id a19-20020a170902ee93b02900d5c3f79718mr1978138pld.20.1603260005295;
        Tue, 20 Oct 2020 23:00:05 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:498:9282:adc1:1b7b:1f08:762d])
        by smtp.gmail.com with ESMTPSA id d2sm848301pjx.4.2020.10.20.23.00.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 23:00:04 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:29:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Huang Yiwei <hyiwei@codeaurora.org>
Cc:     jassisinghbrar@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom: Support building QCOM IPCC driver as
 module
Message-ID: <20201021055955.GA4223@Mani-XPS-13-9360>
References: <1603246552-23601-1-git-send-email-hyiwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603246552-23601-1-git-send-email-hyiwei@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please CC the driver maintainer(s) for relevant patches. For this driver,
I've been listed as the maintainer in the MAINTAINERS file.

On Wed, Oct 21, 2020 at 10:15:52AM +0800, Huang Yiwei wrote:
> Change CONFIG_QCOM_IPCC to tristate and add exit function to
> support module build for QCOM IPCC driver.
> 

This is not going to work, sorry! There was a reason to make this driver
built-in in the first place. This driver registers itself as an irqchip and
provides interrupts to be consumed by the client drivers. So if we want to
unload the driver, then we should make sure to dispose all irqs consumed by
the client drivers and that's not possible currently. If you look into other
irqchip drivers, they're all made as built-in.

Thanks,
Mani

> Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
> ---
>  drivers/mailbox/Kconfig     | 2 +-
>  drivers/mailbox/qcom-ipcc.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05b1009..78f3006 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -245,7 +245,7 @@ config SPRD_MBOX
>  	  you want to build the Spreatrum mailbox controller driver.
>  
>  config QCOM_IPCC
> -	bool "Qualcomm Technologies, Inc. IPCC driver"
> +	tristate "Qualcomm Technologies, Inc. IPCC driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  Qualcomm Technologies, Inc. Inter-Processor Communication Controller
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2d13c72..1ed9a87 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -280,6 +280,12 @@ static int __init qcom_ipcc_init(void)
>  }
>  arch_initcall(qcom_ipcc_init);
>  
> +static __exit void qcom_ipcc_exit(void)
> +{
> +	platform_driver_unregister(&qcom_ipcc_driver);
> +}
> +module_exit(qcom_ipcc_exit);
> +
>  MODULE_AUTHOR("Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>");
>  MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. IPCC driver");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
