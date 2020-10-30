Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43882A06EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgJ3Nw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgJ3Nw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0563C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:52:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so2984340plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+CEIHwWqhzYV0HYraVzQ8V9w34WyYUMjOlZvUacIk1Q=;
        b=Hci+DOmsFbgm/TX4qcIXrLGP3OMWs3vkOhfvGyDYWrx4aYFn/fk2EvFWsj0GWTJFlg
         GiAabMc3GwKjcNOvGytBfRtyp76NYMOwC+bbB7td3oeViVRXUn0hlDV0U2Q94iIXSiHb
         RqKMAbi5L6J5z901jn6qEp7D0RC7U2R9Nibo5GGBCrOQavJtr3sUp1qhLTdMIhcLUZHJ
         cF5JJdpuXBeWOHOM1hkmBW0/EqQFC7JYC2NdJF10DSXhd7GfLrA5nRmLlv0X///axZmo
         7PvWWzfugk4hjKWU9IOjnq3zJjN9Grrg1ZqRSjrODPPDCEiVfpHa5QNi1SgdhLI2DzTZ
         Gb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+CEIHwWqhzYV0HYraVzQ8V9w34WyYUMjOlZvUacIk1Q=;
        b=fQSHGQC8j087sPcHd/xr7YFFlE9U6FcLLZ2NaOuLXho/2p3jmK3C8Qi8M20g2avZ+w
         otXT8T3NQ9kw40rOQwqmWSdGTDAJQ43u9g432150zBdF1tFcfvHyfIpbVGy2iEcdwkrr
         ZiFLAxAshsN8KX+83O3bRWb3HDZFY3sOh7M2G+myRjuFOkeBseHrYmTK90TK+1ENYj1H
         jpcbap0PluSkSo1K7ucLKiUAJPknV4oRAjB/GRHUOafDpb8f/BYWREz7bqRU4U9R/IxR
         bNal4Vr3/CRwn5QFb3C7M3JspNOw3epJElO2X0wM/drZfI9fFD1NYkM8KZt9gKyfXO7W
         7GPA==
X-Gm-Message-State: AOAM532ybQLy/huOvcxJRwO+HvJPA0fHkDW1YJu9eWMazY3Japw9cMMu
        lznS1KzKi+zRDQvq8mlkAGow
X-Google-Smtp-Source: ABdhPJwnGrBAu6iWpi46kC4FDKMFhTq8fVcVyFyg4IrVmVfZB/SfHK9CU+5YDA1dEOgJqtqKiENrNw==
X-Received: by 2002:a17:902:b78c:b029:d4:da94:8766 with SMTP id e12-20020a170902b78cb02900d4da948766mr1841212pls.31.1604065946276;
        Fri, 30 Oct 2020 06:52:26 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:918:28fe:10d5:aaf5:e319:ec72])
        by smtp.gmail.com with ESMTPSA id nv5sm2741190pjb.54.2020.10.30.06.52.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Oct 2020 06:52:25 -0700 (PDT)
Date:   Fri, 30 Oct 2020 19:22:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] bus: mhi: core: Move to SYS_ERROR regardless of
 RDDM capability
Message-ID: <20201030135218.GG3818@Mani-XPS-13-9360>
References: <1604031057-32820-1-git-send-email-bbhatt@codeaurora.org>
 <1604031057-32820-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604031057-32820-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:10:49PM -0700, Bhaumik Bhatt wrote:
> In some cases, the entry of device to RDDM execution environment
> can occur after a significant amount of time has elapsed and a
> SYS_ERROR state change event has already arrived.

I don't quite understand this statement. Can you elaborate? This doesn't
relate to what the patch is doing.

> This can result
> in scenarios where MHI controller and client drivers are unaware
> of the error state of the device. Remove the check for rddm_image
> when processing the SYS_ERROR state change as it is present in
> mhi_pm_sys_err_handler() already and prevent further activity
> until the expected RDDM execution environment change occurs or
> the controller driver decides further action.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 2cff5dd..1f32d67 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -733,19 +733,15 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  				break;
>  			case MHI_STATE_SYS_ERR:
>  			{
> -				enum mhi_pm_state new_state;
> -
> -				/* skip SYS_ERROR handling if RDDM supported */
> -				if (mhi_cntrl->ee == MHI_EE_RDDM ||
> -				    mhi_cntrl->rddm_image)
> -					break;
> +				enum mhi_pm_state state = MHI_PM_STATE_MAX;
>  
>  				dev_dbg(dev, "System error detected\n");
>  				write_lock_irq(&mhi_cntrl->pm_lock);
> -				new_state = mhi_tryset_pm_state(mhi_cntrl,
> +				if (mhi_cntrl->ee != MHI_EE_RDDM)

But you are still checking for RDDM EE?

Please explain why you want to skip RDDM check.

Thanks,
Mani

> +					state = mhi_tryset_pm_state(mhi_cntrl,
>  							MHI_PM_SYS_ERR_DETECT);
>  				write_unlock_irq(&mhi_cntrl->pm_lock);
> -				if (new_state == MHI_PM_SYS_ERR_DETECT)
> +				if (state == MHI_PM_SYS_ERR_DETECT)
>  					mhi_pm_sys_err_handler(mhi_cntrl);
>  				break;
>  			}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
