Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8432A8EED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKFFdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKFFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:33:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB67FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:33:02 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so63900pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eyET7eunTU1N4qKS4HiW2HJnqL8ULPnOINkAMkcX078=;
        b=P5o9LhfpdCQUMN2gtDP6TXLBVbn9Ry39mWui9gBKS6oMZBjElfjgtCKBByOb/weA9h
         QpD9GyxuNhcvMz284hyE6vBqJDYmm83E0nJqZfOfIUtDgKh3hkAvr8a9ZsZj4i8kkypz
         c6uTf9dv6HRV1elBysg4AvVA2/8yWu147k6zPMCwOjCpWIg7EbObacAx0fCwMTkD+R64
         lmnxgMqvrhJ427bcsGXKm3k21nkqMD703jW1/ukfxszWuOEiwwLmUgZJl8y6vqj6gc8H
         AceE1xARorIr9ozwAlUGFcA/TV9BO5dQHTO40MaHTVDLaXhq9h17eDxzTccQ3BUPMFCs
         ckYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyET7eunTU1N4qKS4HiW2HJnqL8ULPnOINkAMkcX078=;
        b=l7u0CjhPhHWV0zBGvZKeLqP1ZicE1M8NdSPMUUKhja/ONnKJWiqRJoHdZYnm0x+EME
         lXzoLwZhjpPqRTswe2+eCB+QeQOxJZynMPNO60hPEZBHSJyuwr3aYHwbkL4IGoDp6W9w
         mNTaHVNb7GpCad4m4H1gK6M+9vBEL5l3RmD3ctARGkGzltqfLMgw23g5oTZhRoEmSTb4
         mJTlvF1cRoBk+gBwRFexteteFSfYtHaNXeNzND8FpTAim1EBpR7NjPw/IMnOszlqk1Wd
         Bayma+3TGk0P1AkAew+YAhZiyfn6DtD+ayl8cj/9+Ov8kuRdcYT6pCSQjLW2Z/2gbnYh
         qNvw==
X-Gm-Message-State: AOAM5334CH3Tp3p9jXcZom9mJaFRqzUcq2I6Qnd+kUztREdXPokJ58MW
        DvJlNQ0M/yMIbQPu9KTq0RCVwzwYAOil
X-Google-Smtp-Source: ABdhPJx7YKY0s/0gIG3dRX4Ao+euYUH7yIxhCei4XX/s83z/fmJ7WyqushqIiUWmNRSIokVOLBmCpw==
X-Received: by 2002:a65:5286:: with SMTP id y6mr336396pgp.117.1604640782149;
        Thu, 05 Nov 2020 21:33:02 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id j25sm391646pfa.199.2020.11.05.21.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 21:33:00 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:02:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] bus: mhi: core: Rename RDDM download function to
 use proper words
Message-ID: <20201106053254.GF3473@work>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
 <1604622869-40212-6-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604622869-40212-6-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:34:28PM -0800, Bhaumik Bhatt wrote:
> mhi_download_rddm_img() uses a shorter version of the word image.
> Expand it and rename the function to mhi_download_rddm_image().
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 4 ++--
>  include/linux/mhi.h         | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 6b6fd96..16244cc 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -147,7 +147,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  }
>  
>  /* Download RDDM image from device */
> -int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
> +int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic)
>  {
>  	void __iomem *base = mhi_cntrl->bhie;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -169,7 +169,7 @@ int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic)
>  
>  	return (rx_status == BHIE_RXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
>  }
> -EXPORT_SYMBOL_GPL(mhi_download_rddm_img);
> +EXPORT_SYMBOL_GPL(mhi_download_rddm_image);
>  
>  static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  			    const struct mhi_buf *mhi_buf)
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 9225d55..52b3c60 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -645,12 +645,12 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl);
>  int mhi_pm_resume(struct mhi_controller *mhi_cntrl);
>  
>  /**
> - * mhi_download_rddm_img - Download ramdump image from device for
> - *                         debugging purpose.
> + * mhi_download_rddm_image - Download ramdump image from device for
> + *                           debugging purpose.
>   * @mhi_cntrl: MHI controller
>   * @in_panic: Download rddm image during kernel panic
>   */
> -int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
> +int mhi_download_rddm_image(struct mhi_controller *mhi_cntrl, bool in_panic);
>  
>  /**
>   * mhi_force_rddm_mode - Force device into rddm mode
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
