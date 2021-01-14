Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E301E2F5827
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbhANCPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbhAMVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:23:54 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:23:00 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b3so2051214pft.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2oVuzEK0sHFjnoocbJw1sqteX5S5UuoEAAdB30o3rmg=;
        b=t+gXcNaa45OlK6+8xH7sItflZVBIhUj34KZPFZWe/JMyLbGnPghaSz/K8BQ4y7Guvr
         wk+cfVxX+4UJEaPnLuq3i+kANW6mX1qN6RZQBNTO99pDJxtK4i6b7XcJLDwMXZgh4ipO
         eD2yDQOuniD4PTq9feSqqc5mvmFiZ37hweclA+KmWD42DeMcdlo+hb8luIyfbscoodge
         mTVQKGIE0xsGiSYAE/VFQIYOswrZrQGxy3qXN5CNp0666Tva2F0GiaAcYRu7oJiTv7Rc
         940RCWMVXSQESVs7hvM7R0RUiR2rdYl+GKgjKt6m0/GK7llECaFlNai63pl/KVaOwmSr
         LVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oVuzEK0sHFjnoocbJw1sqteX5S5UuoEAAdB30o3rmg=;
        b=Cg0QUUSjZTBYcNq5FzM/UNm0eB5gQyCo4zwXdEFHGDBANUvfA6jT3piVglcVkX9Yvz
         V3VYz85dsZBPjYzZmB+GNcUuHOnXGooJHNcWMbaIHXqjdugEBPW7oztLBCuQ4KYODCWY
         jPRP0hAjI6YnCbgiJQmCS5lrM0MaWks6a5jpz5GJKIThrYeWuX3OKOvsSzZQu2anjg2M
         X9LPFjsK2htwJrE87nNkcXHzJ9acJznP3jZnfMwCjnyEc0EhS/BdmmUmEHLkIDjLxgnr
         7LR3r+MSuIW9XNyYsFuZbzr4JAXw7rU8xGhMIVlU+qSUJuxeMnA5tM6c+nns8QVJfyiE
         gLdg==
X-Gm-Message-State: AOAM533gFM2dmrx/pn6MoLg9zmqdk6xPcvFgaSN0jgyGKHtKgC8RSEgI
        g8dZ6Cbg7neIHpWatlrmToXWKqag0oTAQA==
X-Google-Smtp-Source: ABdhPJz17kHLtL3rBoveX55Roj7DegDuMBw9EqP3t71VYpd6/wa2ekUezRqn20cgZYLzz+dOZiLO4w==
X-Received: by 2002:a63:1322:: with SMTP id i34mr3945492pgl.282.1610572980072;
        Wed, 13 Jan 2021 13:23:00 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x15sm3284847pfn.118.2021.01.13.13.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 13:22:59 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:22:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Validate p_filesz in ELF
 loader
Message-ID: <20210113212257.GB229796@xps15>
References: <20210107235053.745888-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107235053.745888-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Jan 07, 2021 at 03:50:53PM -0800, Bjorn Andersson wrote:
> Analog to the issue in the common mdt_loader code the MSS ELF loader
> does not validate that p_filesz bytes will fit in the memory region and
> that the loaded segments are not truncated. Fix this in the same way
> as proposed for the mdt_loader.
> 
> Fixes: 135b9e8d1cd8 ("remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 66106ba25ba3..2b59e0cbdce1 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1210,6 +1210,14 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  			goto release_firmware;
>  		}
>  
> +		if (phdr->p_filesz > phdr->p_memsz) {
> +			dev_err(qproc->dev,
> +				"refusing to load segment %d with p_filesz > p_memsz\n",
> +				i);
> +			ret = -EINVAL;
> +			break;

Based on the error handling for the above and below conditions, I would have
expected a "goto release_firmware" rather than a "break".

> +		}
> +
>  		ptr = memremap(qproc->mpss_phys + offset, phdr->p_memsz, MEMREMAP_WC);
>  		if (!ptr) {
>  			dev_err(qproc->dev,
> @@ -1241,6 +1249,15 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  				goto release_firmware;
>  			}
>  
> +			if (seg_fw->size != phdr->p_filesz) {
> +				dev_err(qproc->dev,
> +					"failed to load segment %d from truncated file %s\n",
> +					i, fw_name);
> +				ret = -EINVAL;
> +				memunmap(ptr);
> +				break;

Same here.

> +			}
> +
>  			release_firmware(seg_fw);
>  		}

Thanks,
Mathieu

>  
> -- 
> 2.29.2
> 
