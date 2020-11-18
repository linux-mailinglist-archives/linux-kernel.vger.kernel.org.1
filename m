Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924C2B80B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKRPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgKRPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:38:30 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB786C061A48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:38:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 79so2119408otc.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TsvK+IoKETFNYhIytzLBxH/j36F8chmPX/TnN3zexa8=;
        b=wYTZDFlA3tUB95X6qvT5yBzXs1b2g8nlWXan51fiHn2N+LE4I54ylPBZRAGyURuAWL
         DEKkC/37ZcTA1+/6PpMkt/qP+wZyI9zSSF3h8plfg3GSMCdDfMgamCXK5YCCtmEsLL6T
         56WMDqhXLUIIa1oSlBVNEYdEJFDJYUV816WHapudQlwcxnnBThvaIBiTJ+/hOK/WEUdr
         8kArerUAGhZZeace4X3nLWn2FD8yXofEm3LM6/TJphpgGOBjOZPIU8BnLKYJhwOjfJL+
         uF9hOVkf0rJDyigkpyQg6/GAIMpYOqaYn8HXDf9+M5ONyYr1xW+Np3qLvrAptMaRht0m
         jhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TsvK+IoKETFNYhIytzLBxH/j36F8chmPX/TnN3zexa8=;
        b=dtvbx5RaMvn4Rn43q+VLH/yu/xmypBsrHDL9NaH9b5WL4Jv34bUrOJaT+oCMnxz1F9
         a0aYlA9GZjbcckq9sEg1IoNxYQlQnsvuImTOhvWQbNEjswuOoW/EyjOFCoIGnZ42tTIJ
         QVNQdGDIFoHE6hCTHD4KBqVth8M00BX3OF7bL2aCjpX6mRad+7mEPeMF19QrkWt8Q0Q8
         581IxEe95YjJ7YyiMUG1nsAupHpBkHMVCZV60iSCCawSP7/xC+Ck5FuDPMY3gv4W61mB
         rQ110IB2COCzdD9q5UB4Jd7261F1/8+EZM0zvrOhthZW2164EI9o2OXmpT9WD9fQos+M
         jyLw==
X-Gm-Message-State: AOAM533GZjCcpFD9uFmhO5D0C3RL1jcu1B44eSl2JzNdG59Kx4QP4FFM
        0HQj6jdLVz86UJIkbxJ0cpf7BQ==
X-Google-Smtp-Source: ABdhPJzywmas3hikLpSgLLjiOMgRkgImxu3xoAApCX2PhesJEy70rQd6gd6216DeBtWyOphhReAUCQ==
X-Received: by 2002:a05:6830:204f:: with SMTP id f15mr6534274otp.80.1605713909174;
        Wed, 18 Nov 2020 07:38:29 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y8sm7592882ota.64.2020.11.18.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 07:38:28 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:38:26 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/4] remoteproc: core: Add ops to enable custom
 coredump functionality
Message-ID: <20201118153826.GA9177@builder.lan>
References: <1604395160-12443-1-git-send-email-sidgup@codeaurora.org>
 <1604395160-12443-2-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604395160-12443-2-git-send-email-sidgup@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 Nov 03:19 CST 2020, Siddharth Gupta wrote:

> Each remoteproc might have different requirements for coredumps and might
> want to choose the type of dumps it wants to collect. This change allows
> remoteproc drivers to specify their own custom dump function to be executed
> in place of rproc_coredump. If the coredump op is not specified by the
> remoteproc driver it will be set to rproc_coredump by default.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 +++++-
>  include/linux/remoteproc.h           | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index dab2c0f..eba7543 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1704,7 +1704,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  		goto unlock_mutex;
>  
>  	/* generate coredump */
> -	rproc_coredump(rproc);
> +	rproc->ops->coredump(rproc);
>  
>  	/* load firmware */
>  	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> @@ -2126,6 +2126,10 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
>  	if (!rproc->ops)
>  		return -ENOMEM;
>  
> +	/* Default to rproc_coredump if no coredump function is specified */
> +	if (!rproc->ops->coredump)
> +		rproc->ops->coredump = rproc_coredump;
> +
>  	if (rproc->ops->load)
>  		return 0;
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 3fa3ba6..a419878 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -375,6 +375,7 @@ enum rsc_handling_status {
>   * @get_boot_addr:	get boot address to entry point specified in firmware
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
> + * @coredump:	  collect firmware dump after the subsystem is shutdown
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -393,6 +394,7 @@ struct rproc_ops {
>  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
> +	void (*coredump)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
