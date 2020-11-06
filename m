Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995362A8EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKFFaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKFFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:30:01 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C78C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:30:01 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so55310pgh.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z71+jEBhYdyIuDap+wMLDvIJbAWedgPKiHhjhJDr26s=;
        b=P8xkUgmCsBqalxnIgsqwlY65qmtSG6WjLz7ReXi83gVkIYEhWSIWfYOSwtaK/1n8EA
         lQM/rwuUliShcaLlhFISCssb91fwoYJVr3UJiAPiMZTupA42VGqzcsiuzFI5RnDAfQVT
         G+I6kzYoylZPygPHdNCq3p5SDqSbti81UP6EtBSnbyjrpjsVik2NwWclwXKNow5GzCd0
         BFmm/91LbqPUwj5Yyb/Fz+wEz8s97MY+bitQbbh4BxlQ/V2Adf+IUFFbQcPsDSYU27O2
         +h5ZooQuATMiaqACt0P3TcOi2B2p/cF3Sb9wzR3dRQ5WCnsa6j2WbR5669yOnpL1UVIf
         zLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z71+jEBhYdyIuDap+wMLDvIJbAWedgPKiHhjhJDr26s=;
        b=f+BmAHfY4rT1zkpnG/PlEbaJzex5+CeD1TsoM/tz4xsha51JrXjPpJLhIu5mEirChU
         nkthtVYUxnpLFDbALNXDTYWauduKtEpkrPwBB1mFPqekM5m+DRcnz3f7aJHwfvYlUrkl
         WIYpl+rUq6QwvilmNcwUdRc4Nej5AEj4O5SjzbqcyIyBV0SOt2YJ6/l3Q4drbgUs0Sum
         giaOPZHZRI1UfvC0DafHFcDPAq/p5/yvewqi0qVsbtpRvoQf/CRsdpQDruAqO1kqPtUh
         +TGxw1nmIBsoCMcS5aUhSZCImRLOpeWfR9B+4pK4m/5BiU3+2+uZT7uHn10/ChotyqpB
         kGng==
X-Gm-Message-State: AOAM531AY0qnLz5wpTVfZkJ5JSzXe+oOjAOVuTuR/k2H2QdR7sYkmSjZ
        YQxN5kL2SHWakzM4bSYxd4Z4
X-Google-Smtp-Source: ABdhPJxYpByrUk6pm+Bb31OolGCxB0CxH9jNdqpTzmxUT8S/wUbycSYNGfUHlT5uRumCGCwsfXEhTA==
X-Received: by 2002:a17:90a:ea03:: with SMTP id w3mr630835pjy.56.1604640601238;
        Thu, 05 Nov 2020 21:30:01 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm481729pju.38.2020.11.05.21.29.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 21:30:00 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:59:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] bus: mhi: core: Expose mhi_get_exec_env() API for
 controllers
Message-ID: <20201106052955.GD3473@work>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
 <1604622869-40212-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604622869-40212-4-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:34:26PM -0800, Bhaumik Bhatt wrote:
> The mhi_get_exec_env() APIs can be used by the controller drivers
> to query the execution environment of the MHI device. Expose it
> so it can be used in some scenarios to determine behavior of
> controllers.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/main.c | 1 +
>  include/linux/mhi.h         | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
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

And you should remove the declaration in internal.h.

Thanks,
Mani

> +
> +/**
>   * mhi_get_mhi_state - Get MHI state of the device
>   * @mhi_cntrl: MHI controller
>   */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
