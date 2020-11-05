Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3BE2A8080
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgKEONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgKEONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:13:08 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BBC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:13:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id e7so1539958pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UuZzeGQfBQQ8ri5zKvxcs8SpoLtbPsWaz4LhKSBtCI=;
        b=xKtLuwuiMdsTKVy5mfc8UkzzwH8TvFeD+K5QA+Ixeg/DWYfd21zlM6JTJezYMCjgkA
         w6nVXiV6BBUBtjuJPw7LV1z+udXZCFOikb1YTosi/G+VeevyKQWpauQWBwJ2WRjnX66S
         Biz+DMBZGbqlcDoT70kaJL1W6T3R/RVdOP+Xv39IGRzPhhhYWAmXjf7RsURVMWk6kl0Z
         qTNFT67BJyi81pioM8ZhzAB7q88zgDfKtT8wCTlmSZsW3O74YAdPGtjuewPO0DPWrJNy
         S8AhxU0AMjQKcOsQc8YEdHvNiMvh1DrMlFzEbCA5MT5IMG6pwDrDZ7eOFVNPylMVbTAq
         i4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UuZzeGQfBQQ8ri5zKvxcs8SpoLtbPsWaz4LhKSBtCI=;
        b=VgrSh7UC+4ESQFKh/O8b8SioF/uBJP83qrA771NouO0xwpoain+XmsYb/emM3cBMIF
         +Tgw0lM8sND3ejIYOEeM+2pjorwCcjx+5F5IdENOaR85x6J3gWyOg5414f+BNhk4NLqW
         ZdZJcbVZ7CG7JiITNHdeqOpUMPHGFoSrlX47dNJxXx7LhjpEdi2trf0rptdIGUKJy8t1
         bY9QxsBtVQDd0xH6ifaxHsRYAV3/h7zt5wmxrvFGoaEGhTwWHxhLGxtKa5pb+E4xGZu6
         2an/Q3HC5I25S581cl/GiX1QfDBr9SLadeUujdNEsmuf5X6hTEwyVcgI0nIoDdVPISi4
         KhLw==
X-Gm-Message-State: AOAM531fQo7qkKz4TajYnowEW8U3w/KoJNNdXOmBif029gCIX0LX6MM7
        Uo4UVm+sPdqqj0jEohc1isTu9HP4+7ch
X-Google-Smtp-Source: ABdhPJyRP48GT1hJI2tQA7hHQE6x4fqodX/4TnhObDrQaJxymfuKLJGdYeet+yGph51alKZkxFupRQ==
X-Received: by 2002:a63:5804:: with SMTP id m4mr2513254pgb.31.1604585587098;
        Thu, 05 Nov 2020 06:13:07 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id o4sm2418791pjs.53.2020.11.05.06.13.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 06:13:06 -0800 (PST)
Date:   Thu, 5 Nov 2020 19:43:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: core: fix potential operator-precedence with
 BHI macros
Message-ID: <20201105141301.GD7308@work>
References: <1603225785-21368-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603225785-21368-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:29:45PM -0600, Jeffrey Hugo wrote:
> The BHI_MSMHWID and BHI_OEMPKHASH macros take a value 'n' which is
> a BHI register index. If 'n' is an expression rather than a simple
> value, there can be an operator precedence issue which can result
> in the incorrect calculation of the register offset. Adding
> parentheses around the macro parameter can prevent such issues.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 7989269..78e4e84 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -153,8 +153,8 @@ extern struct bus_type mhi_bus_type;
>  #define BHI_SERIALNU (0x40)
>  #define BHI_SBLANTIROLLVER (0x44)
>  #define BHI_NUMSEG (0x48)
> -#define BHI_MSMHWID(n) (0x4C + (0x4 * n))
> -#define BHI_OEMPKHASH(n) (0x64 + (0x4 * n))
> +#define BHI_MSMHWID(n) (0x4C + (0x4 * (n)))
> +#define BHI_OEMPKHASH(n) (0x64 + (0x4 * (n)))
>  #define BHI_RSVD5 (0xC4)
>  #define BHI_STATUS_MASK (0xC0000000)
>  #define BHI_STATUS_SHIFT (30)
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
