Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCFC2A8EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKFFi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFFi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:38:27 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CACC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:38:26 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 72so279974pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73giOY8/PzyS+yOm7jOoDVLjSGxoM+4SVlRTyYDUinw=;
        b=X1tDkKTo99uAhP7XFRlGX3sF8frIqTphOl+qm8VHVipTgcOZP39gA0sGRR9UQy6t4e
         J3e+jP3Xg1x9TlKvF/RgoY/nQEfV//3Mo8Wwh7xIttar0K0LasJfrQYJ32TavYJzKbF3
         xLonyKL7KBmRd7kYc5L4N4addK6GrmKWYAalK/WJX61XS4gvbDLWHk1T6TyyM/QVWt3c
         YHc+fsh9142e/M66CT1taprGfFOUBvlHfjCoQyvoe3Sl3CvXD7szuqH5yb3rKGB1A5Kb
         QkNO9W0RUvYw7ZRa8wlnndDf3unx4zRchUZOA4ZfcEAwGTwo2wTn8AL0wbmg9tmGz+Ns
         io/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73giOY8/PzyS+yOm7jOoDVLjSGxoM+4SVlRTyYDUinw=;
        b=I7E7MBpul2zE7XEL6Ee6ac0RWjkdc7DUI/cuwvo5mLxYY0R3RppqyeAdkqypnbZJ0H
         qdNK8/TDgB9kmXP8EjEmFkmi/UMYy3dGTP5xSCImsvCoJdlRyd8mLIlHrkIFIJPN4jvt
         1/k/FqicmXTJEUuxA5Ll3ouCx5dcRv0O9WqgwL515t70+VGEMpArmmRMAdd8zLfWmVbv
         +r7iVpZwr4QjGon0pp1dl7VKlfKJOq3lJ7qoTp85qWxkSKWjm4ZzxhaiD87K9Kverh1o
         Xwtwd2viYTiRv4op8ehsLJ56B7DNkc4NqLO4fEVbrSSu3NZX1cfnwpZewMl+DhfKME7X
         TfUQ==
X-Gm-Message-State: AOAM5313fpq+v1+0aEAlXTBW0a5pL1VFW3KzrbGQi4NyBIZ95xjSl/Td
        FEnPwm343Ye637pYt0LBcRdi
X-Google-Smtp-Source: ABdhPJxDAX67kINgrfO8PMvQka+j2zGlDvcmtKmFcqKFnx6uIstK2oGN9OPnLU+5Qj0vHvcUllvPyA==
X-Received: by 2002:a17:90a:6392:: with SMTP id f18mr614677pjj.143.1604641105637;
        Thu, 05 Nov 2020 21:38:25 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id i11sm414301pfd.211.2020.11.05.21.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 21:38:24 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:08:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/6] bus: mhi: core: Skip RDDM download for unknown
 execution environment
Message-ID: <20201106053819.GG3473@work>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
 <1604622869-40212-7-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604622869-40212-7-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:34:29PM -0800, Bhaumik Bhatt wrote:
> If MHI is unable to determine the execution environment during
> the panic path, host must skip the RDDM download. This can happen
> if the BHI offset read or the BHI_EXECENV register read fails
> indicating that the underlying transport is unresponsive. Hence,
> there is no need to trigger an RDDM using SYSERR or request an
> SOC reset.
> 
> Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/boot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 16244cc..40606e5 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -92,6 +92,9 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  	 * image download completion.
>  	 */
>  	ee = mhi_get_exec_env(mhi_cntrl);
> +	if (ee == MHI_EE_MAX)
> +		goto error_exit_rddm;
> +
>  	if (ee != MHI_EE_RDDM) {
>  		dev_dbg(dev, "Trigger device into RDDM mode using SYS ERR\n");
>  		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_SYS_ERR);
> @@ -140,9 +143,11 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  	ret = mhi_read_reg(mhi_cntrl, base, BHIE_RXVECSTATUS_OFFS, &rx_status);
>  
>  	dev_err(dev, "Did not complete RDDM transfer\n");
> -	dev_err(dev, "Current EE: %s\n", TO_MHI_EXEC_STR(ee));
>  	dev_err(dev, "RXVEC_STATUS: 0x%x\n", rx_status);
>  
> +error_exit_rddm:
> +	dev_err(dev, "Current EE: %s\n", TO_MHI_EXEC_STR(ee));

Can this error message improved? It doesn't make much sense if error
path is taken.

Thanks,
Mani

> +
>  	return -EIO;
>  }
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
