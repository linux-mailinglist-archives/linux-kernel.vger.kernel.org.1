Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2432A37EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgKCAkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgKCAkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:40:33 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52669C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:40:33 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id k3so2568353otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8g3XEWhNRuQu6qyJVUDQn5Yd776lhaG/sklBeFKZtPI=;
        b=FUOw8Jw3Yvhdf10UgO7XLD1nPT5jxInmXvEt6lpwn9SBtCL+trdiJgd4BNX1lfBFpt
         2YcPd54za8rxBDUMqgErDopZKVrA0e6R358kPDgLAlxkjKUmlyRT2xuU6dnwzj3QcSFy
         nAiGIxYfjSI8PkLncWaZxCvQWTpNa3OqGclGu0KYDmD29PnhC/DmZ+ONt/wTtSSeU8Ta
         Umn2hxFJR9pVZKpqco6rCrh3PDR+Zwb0C65TPNNcP1/bGcRycBNTZUevemyRky+eSQGm
         EJfkXruzXx5d0vJ/HvlhoeAGMQCQsOlc6YEXot6dRKo7bSsagClQH29iuHuetI+IV0IU
         WQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8g3XEWhNRuQu6qyJVUDQn5Yd776lhaG/sklBeFKZtPI=;
        b=TFWU81y36bYBd/mYij6MyXAQrvFzckf0E9lKLmSKYpx9NFvBXnWpsBrdXf/vxiDKvy
         8yp7sNiL3bTIVsg+o+4JACpCU8OF01C76S53N/o/u6mZlrIL9zu0pViP5j1xDLdTKYkS
         lm52UurHme8kG+fd8BwvrfjbtmiArUZ0wSK6KeWGYcDPaz8Ulz9heJ/MZb2Yo8m4iRKi
         NLjWgezOELjXS6Ik+JCnmT970GJ6tRxOF+nptaQ39zTy57FPB7tRrYoXqBoW7yCZDn1G
         xv5dSh5JHuC3TJ6VVk2dvKfrvtV4XMbq/5ez35u4MWt1VIrzrrVhx8+dvUMFXCsxMrdW
         f0JQ==
X-Gm-Message-State: AOAM532RnPS8SXVdztRQaaCqoiuSO71lAZzjYf7uxCpoh4RoGq92F6Rh
        W3EHMZLA8r9mUCqxUB4MBTJCZQ==
X-Google-Smtp-Source: ABdhPJwhjQ2Of8xL/Q4I1BIpRv25zTfLg2l43oGPpgOU4eIvD2mTKg68sqVGmc/cfIekinpQwIGEZQ==
X-Received: by 2002:a05:6830:1af4:: with SMTP id c20mr13862979otd.198.1604364032658;
        Mon, 02 Nov 2020 16:40:32 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j7sm3904287oie.44.2020.11.02.16.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:40:32 -0800 (PST)
Date:   Mon, 2 Nov 2020 18:40:30 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 2/2] hwspinlock: sprd: use module_platform_driver()
 instead postcore initcall
Message-ID: <20201103004030.GC223412@builder.lan>
References: <20201030034654.15775-1-zhang.lyra@gmail.com>
 <20201030034654.15775-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030034654.15775-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Oct 22:46 CDT 2020, Chunyan Zhang wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> The hardware spinlock devices are defined in the DT, there's no need for
> init calls order, remove boilerplate code by using module_platform_driver.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Applied this patch with Baolin's r-b.

Thank you,
Bjorn

> ---
>  drivers/hwspinlock/sprd_hwspinlock.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
> index 4c63e2546064..19d1924044e5 100644
> --- a/drivers/hwspinlock/sprd_hwspinlock.c
> +++ b/drivers/hwspinlock/sprd_hwspinlock.c
> @@ -151,18 +151,7 @@ static struct platform_driver sprd_hwspinlock_driver = {
>  		.of_match_table = of_match_ptr(sprd_hwspinlock_of_match),
>  	},
>  };
> -
> -static int __init sprd_hwspinlock_init(void)
> -{
> -	return platform_driver_register(&sprd_hwspinlock_driver);
> -}
> -postcore_initcall(sprd_hwspinlock_init);
> -
> -static void __exit sprd_hwspinlock_exit(void)
> -{
> -	platform_driver_unregister(&sprd_hwspinlock_driver);
> -}
> -module_exit(sprd_hwspinlock_exit);
> +module_platform_driver(sprd_hwspinlock_driver);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Hardware spinlock driver for Spreadtrum");
> -- 
> 2.20.1
> 
