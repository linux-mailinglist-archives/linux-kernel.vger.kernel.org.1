Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F26303FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405750AbhAZOIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405725AbhAZOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:07:58 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F226BC061A31
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:07:17 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k8so16258870otr.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQ1mHRGGkeAWSLltIAOirHSUgPq2D+lfO6NPdhx+kbk=;
        b=nSntSCMT12ixFL7rKiXDb9a3nofYWhAoNV9NbbrNNorP2Il6xg18+E1tcWTCFF57lu
         /usVi7gupanU3YRCGUUt0pcPFhrNj8wEyiStsNvbNzdR9rsr5s4BNsZTFO9dDilrjCjy
         /zupnJ0BN2W9ChCIvlDFwQLXMMFF4OzqJp5xVQr2CLj1UiD8l6Wr+JDPeKq+hwaop+it
         s55taU82Xy0f2keH7UcovRUXaBVkLPe0cuvmwEqse01tIbO+oOzyDMzM5/QXq/NsUvzz
         bkeopHtSBtqexnk875g3BhNPddL1FYKjKYg52C8dL4kZjzYVgcBNKdjl0+2Qq/yrRP+/
         Yr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQ1mHRGGkeAWSLltIAOirHSUgPq2D+lfO6NPdhx+kbk=;
        b=VgyJrfI598VukcuJ8Ll8VFNpF/uBQDSfNnyni71AwOsAp7wsaCm6abmz6UEkl/pEcv
         f+eAFLV4mNk68Do9Upy48W6FJ6bPkP4+C9/1S41VTx7KAbYzSsxRb+mNhlkOqXmb5NOE
         cPraXSmQwanFoiWHRj0L9RLK+itf+ZHSq/cuCXZU4tnudDb10Hl1kxIi29bYqsKb720S
         8qtLd5ShPGqBgzqq9yv6PXUnIcJAh9ihB637gpzB25sX/f3RTNQY6s/D8CcCi8aJR+bE
         n4Un3amqqNpyTld7t9qZqvT+7EvA29E7mLcZBVkOSo7V0GZX41OulzI56P7WP0vQXKD6
         Qjsw==
X-Gm-Message-State: AOAM532rBVkae4Fkntb43AGwCeCRwdiUcCWJhNu5h+XRREFfVstoJ97T
        NN0m4aogyfGQHsBXlL4PjF0o9Q==
X-Google-Smtp-Source: ABdhPJy7AYp4AcoJFrfFGte6lqF9tUTZ+0VN9mh8hPlQxw314jX/VkvHT6IrGZ7qHf/E8GVyGkqE2w==
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr3986317otm.163.1611670037403;
        Tue, 26 Jan 2021 06:07:17 -0800 (PST)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o16sm4103118ote.79.2021.01.26.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:07:16 -0800 (PST)
Date:   Tue, 26 Jan 2021 08:07:14 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     agross@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: firmware: qcom_scm: Simplify the calculation of
 variables
Message-ID: <20210126140714.GG1241218@yoga>
References: <1611651144-42491-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611651144-42491-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Jan 02:52 CST 2021, Jiapeng Zhong wrote:

> Fix the following coccicheck warnings:
> 
> ./drivers/firmware/qcom_scm.c:324:20-22: WARNING !A || A && B is
> equivalent to !A || B.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  drivers/firmware/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 7be48c1..c530072 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -321,7 +321,7 @@ int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	if (!cpus || (cpus && cpumask_empty(cpus)))
> +	if (!cpus || cpumask_empty(cpus))
>  		return -EINVAL;
>  
>  	for_each_cpu(cpu, cpus) {
> -- 
> 1.8.3.1
> 
