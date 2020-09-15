Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD8269C66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgIODRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgIODRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:17:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D901AC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:17:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so1856844otq.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qWVDCASGrupwV9JyWG9rVOnOXEyxffQY/mwb2teeCs=;
        b=BkDvLW7nAAL4GOlIYSYdl2x/5Qq28C/sTVEIPMBw26Rrbkvpt/Xb7lX5rpYZbODXBV
         aU94PH/Fu+cXV91D+Kiz0xT7RXFt5FXn4tVycuXCbyFArNvqP7lahl9DsDXz1cK3ZcFX
         QuOdnku7vWl4kAaGpxoclI8+BkG12hoyJfQfaEue9veJs+YiJ6nZYXG1I9runEiURDQM
         F47nnsIZqtvAt/xagjHNybWagPhUaz9tzKrsJTS+TNXk2ZsfZZ8nZo2Bpo2NCJvuN10d
         ILvdGoJ5MKTbeGGDDk2524IBboHEnvMkQQcAQr6fstWwN7km1oz5JGfce2AOXRYp7YIi
         9tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qWVDCASGrupwV9JyWG9rVOnOXEyxffQY/mwb2teeCs=;
        b=TIrDRVaxCYJg4CP6fl3edufNdc7mxSrzSmmy8cW/l7uKqlmTu+OwpMagVRCNt51YR8
         7IiWPOTDDfoowFqr7ARaYvHw2xI78SGvyWb9h5AdIY6HzjrIeyjj22xNfclL/xno1mjR
         oO7/9f1drHjmznpjVz/PhNMdK6wI4KvfAtIcyzXqTHhEpMPnSLfkYL1osTCj1LSpAApS
         ouoX0UcjphAqsxg8SkdPUMr8ajy+/1LLhqEqBYlkaTx3+Kespx4KsFX5U2iGW1cUPCOu
         XgW1cVFt2gqC2zPdDe6UbsdJIaxTdeMtgC2mhkPtBLo+KaA+nZ6VAo+418TiRBo1YpxD
         +Nug==
X-Gm-Message-State: AOAM532ZGcbMN1LaqU8uK9rDWJJ1GoJ0NDUCqh1aM6rjlQDgrmA6ubc2
        Hh+AzRPUnDJlEe8c0Gja0zsXXA==
X-Google-Smtp-Source: ABdhPJxBKiKJdxNtWNtq+f2bA/z02TwJEliskpuCyFZRXsHFO/Z9F1FHqBPOVxb6uI6t341ojQlFGA==
X-Received: by 2002:a05:6830:144f:: with SMTP id w15mr10880048otp.62.1600139836899;
        Mon, 14 Sep 2020 20:17:16 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id l23sm4525960otk.79.2020.09.14.20.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:17:16 -0700 (PDT)
Date:   Mon, 14 Sep 2020 22:17:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power: avs: qcom-cpr: simplify the return
 expression of cpr_disable()
Message-ID: <20200915031714.GA670377@yoga>
References: <20200915032629.1772569-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915032629.1772569-1-liushixin2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Sep 22:26 CDT 2020, Liu Shixin wrote:

> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/power/avs/qcom-cpr.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index bd7c3e48b386..b24cc77d1889 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -665,8 +665,6 @@ static int cpr_enable(struct cpr_drv *drv)
>  
>  static int cpr_disable(struct cpr_drv *drv)
>  {
> -	int ret;
> -
>  	mutex_lock(&drv->lock);
>  
>  	if (cpr_is_allowed(drv)) {
> @@ -676,11 +674,7 @@ static int cpr_disable(struct cpr_drv *drv)
>  
>  	mutex_unlock(&drv->lock);
>  
> -	ret = regulator_disable(drv->vdd_apc);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return regulator_disable(drv->vdd_apc);
>  }
>  
>  static int cpr_config(struct cpr_drv *drv)
> -- 
> 2.25.1
> 
