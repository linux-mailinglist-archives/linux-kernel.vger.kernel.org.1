Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858A269A78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgIOAeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIOAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:34:11 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B05C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:34:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z18so944085qvp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AMXsdcZMtd3r1FAfIZIVxJFPK/4+jeZlRHiiC+6VWdk=;
        b=ROVNsuRWiqNko5m4zp2frC9gpRSRjLNxQ2XVgBVyG7ZkgUHlYq2dfKhGAeTtqctAla
         T568uN4UtbeHz76/tSras7chrithr6p88yF4RpgN3Q5nrJVVsGqiCGWqcm2FHUC4ta7Z
         174HVWM7lKsoqMexzIvdMIYs2bLddMlpwr/TjHY053jSn83tRqpJfrcUh5/bbmFP5aAQ
         fk/wzSCnysKVOGZiEo2cgmDUhClOP8PXnQ4QxL8Aw7Wd8WeQW7BES/E0HDW8PEXSQXqI
         j2BSAzT+lMR+cb1wLOgtTRPNUCLT6+vsI/vQGjWIXmi1B1McVe+p3pbLQwl38nLxu8AC
         M1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMXsdcZMtd3r1FAfIZIVxJFPK/4+jeZlRHiiC+6VWdk=;
        b=AVI268lj6pZ1nNgZvfk6+tEDhHFyfiUGciaFv+xr0blZXVddd3XYXVikXarpjAoG19
         K9DXLLUQ4zFbfDI2NRDLNPHv61ryYkFjzp4pa5RU4lReAqZSjFwaMhiKM2tO4yjEqqKW
         I2KFI4RDFQpJkjOChFCU44hchqTWziAWKmMg+pB9BJO4mH99cPbuNvE/ok2yOYbDkatD
         8uZH5KcrQYqVgcUehji24iiHLO20sGVc1ewT0W2zv+z0vBcybQb+ZZEswoxQXmIlP9BU
         9vbhVFzy4V3CauZs+tqXADQlYZdoTXSKqpSTDkNOPmUsm9t0AXDyxNaeiIf7ESyodMiL
         XFTw==
X-Gm-Message-State: AOAM530mpZRjRujcVONwZ8zv+vMnbbYZWZhHB6aPjgZkFb0Xtgwb3jMx
        Kq5WVZO6rApB1pZ1hZ6A1fqyyw==
X-Google-Smtp-Source: ABdhPJx7isSw104HWsxh6GBnxwl7osGdt42xeZrstCu8XtSctGKh5I5nX9suDSQ1TbA7by279WI5JA==
X-Received: by 2002:a0c:9142:: with SMTP id q60mr16094189qvq.13.1600130049049;
        Mon, 14 Sep 2020 17:34:09 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id c13sm14830849qtq.5.2020.09.14.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:34:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 00:34:06 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, smasetty@codeaurora.org,
        jcrouse@codeaurora.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/a6xx: fix a potential overflow issue
Message-ID: <20200915003406.GC471@uller>
References: <20200912102558.656-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912102558.656-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Sep 10:25 UTC 2020, Zhenzhong Duan wrote:

> It's allocating an array of a6xx_gpu_state_obj structure rathor than
> its pointers.
> 
> This patch fix it.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index b12f5b4..e9ede19 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -875,7 +875,7 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
>  	int i;
>  
>  	a6xx_state->indexed_regs = state_kcalloc(a6xx_state, count,
> -		sizeof(a6xx_state->indexed_regs));
> +		sizeof(*a6xx_state->indexed_regs));
>  	if (!a6xx_state->indexed_regs)
>  		return;
>  
> -- 
> 1.8.3.1
> 
