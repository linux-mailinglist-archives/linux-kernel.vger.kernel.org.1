Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A320A2AB7B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgKIMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:06:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33245C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:06:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id x13so6978239pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsQ0RfGEN98O6U0pfoQHdfqC1128zMaGcHe9cgH9UMo=;
        b=DcVpQWLJJ8Ef9q5EDvIAZ+kgNtC4RUWkM7I2eJ6JniOuRLN+wqPwMXjPDgmGfuQ2cl
         1IhnPJuJCnChmX8w/UVHdOm01q1x6thwOYVL/nCZOcrIGY/UAyvqGbAIo50G5WPQTp1I
         9Lim6QnhH/PexeQgOwGK/WhDBo9bys4BXZfr6oAWHFZwlldcCYCiIc8lIpB7GpZDuGfo
         SASKo2eqpnAJjnSP6bIuHZ6bSJRLuGJm3olKE82UpmPxIQWZvS9G9UKZflXzUtOUWz4Z
         PjmD6WCSH9rMC6eN+DJzLsmifng8kIOVJDge3HvQGOFwL6EfeHkpelfgAk2Qr/tJs1CA
         ljTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsQ0RfGEN98O6U0pfoQHdfqC1128zMaGcHe9cgH9UMo=;
        b=lkLc3ens2C/lynPnTapc1Efo+MR8G/sAlWB574MVSxok3A4zM/0a2yUmr/7yU6I9UU
         r7xevQxXBkcDQ+V9TwPWo1HLayzPziMzr25iSBKgteHX+ZG9CP4IbmUyrHG02MqUajPL
         lcQ/RTjc+r8QSendy9iOfI6gdVXKvm8zfw4PMBOUsb34RzL5r8/UGxTtEebcig+ZhOtL
         pXxVWCPtdakTKg9XVK8ivjnE/8qFTI1rPM0k8z2zJbUVg22xhU4XAkI/WbzLfswYzwxz
         SWua7pScCA2hfd9xkgw07zwtqyLbR+OpyvjGrdPJ/B5jW2pseIYcikkWoThmF4dlKRqh
         gIbQ==
X-Gm-Message-State: AOAM5324ruGGeUof2fnHz0yma2mXa5t+qs/zbyd9EYB+zTOEWdq8CFwp
        QzDBk2kqD2iFWjKtFbKxv6k6zapKt1i4
X-Google-Smtp-Source: ABdhPJzeGPBfXiqOqPaPV43WfkRtlBnQZPRzVCLNQBHslfWi+n7S9uZ5N5sCIjoQMjio29+M3oKV5g==
X-Received: by 2002:a63:2d41:: with SMTP id t62mr12679074pgt.292.1604923569716;
        Mon, 09 Nov 2020 04:06:09 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id x18sm5555837pfi.206.2020.11.09.04.06.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 04:06:08 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:36:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] bus: mhi: core: Expose mhi_get_exec_env() API for
 controllers
Message-ID: <20201109120603.GI24289@work>
References: <1604684690-31065-1-git-send-email-bbhatt@codeaurora.org>
 <1604684690-31065-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604684690-31065-4-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:44:47AM -0800, Bhaumik Bhatt wrote:
> The mhi_get_exec_env() APIs can be used by the controller drivers
> to query the execution environment of the MHI device. Expose it
> so it can be used in some scenarios to determine behavior of
> controllers.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/internal.h | 1 -
>  drivers/bus/mhi/core/main.c     | 1 +
>  include/linux/mhi.h             | 6 ++++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 7989269..124c1b9 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -609,7 +609,6 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(
>  					struct mhi_controller *mhi_cntrl,
>  					enum mhi_pm_state state);
>  const char *to_mhi_pm_state_str(enum mhi_pm_state state);
> -enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
>  int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
>  			       enum dev_st_transition state);
>  void mhi_pm_st_worker(struct work_struct *work);
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 778897e..7c45657 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -123,6 +123,7 @@ enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl)
>  
>  	return (ret) ? MHI_EE_MAX : exec;
>  }
> +EXPORT_SYMBOL_GPL(mhi_get_exec_env);
>  
>  enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl)
>  {
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d4841e5..9225d55 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -659,6 +659,12 @@ int mhi_download_rddm_img(struct mhi_controller *mhi_cntrl, bool in_panic);
>  int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl);
>  
>  /**
> + * mhi_get_exec_env - Get BHI execution environment of the device
> + * @mhi_cntrl: MHI controller
> + */
> +enum mhi_ee_type mhi_get_exec_env(struct mhi_controller *mhi_cntrl);
> +
> +/**
>   * mhi_get_mhi_state - Get MHI state of the device
>   * @mhi_cntrl: MHI controller
>   */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
