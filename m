Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95426BFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIPIq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgIPIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:46:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:46:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so6013909wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7ko/vadaTCPQ7vQVmk+Y9OH/SaM0H5BPkETVKzuoxMQ=;
        b=LsOw6MfQWGMO70pAU8EBiIQqPAjtJkCv63eRluutYZ9XS7aoJt9+jU5lmeFv+0ls33
         DDj3In5ji169r1ZhtGiBqFy1w180//NuyueXni/s3udO6n4+0QM4R2RFfXfzWCnNr995
         1h+GgSgmUzBmHNE5EhPxF+UYxoXndJZPJn/MNYaRm/k4XHvv0dqBEQ+YXDsnQs33jlK2
         apDsCeTjMz+YuL5oeyBMCAM9Mvrh/aVFhqRyHtzdWpYgx9TE1NsuityKIRq5/6Dd4RjM
         PbbX3YqsD3ZRWU2e0ece+xle+K9lpkmyG3uobkvkS4vmJlOPRgX5KhjPXhFdTUMY3AfC
         ckow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ko/vadaTCPQ7vQVmk+Y9OH/SaM0H5BPkETVKzuoxMQ=;
        b=qPIFBLBAImfOEI08ljS+9mx0OYRNAWha4Sf43KvnkL0jc1TyUEAYCUw3wM1F6atI7s
         2kzwFCgWeLk6hh/201w1iqLRNaxH9gXx/MFRWNCLrg3WqRPAE40dZI3xtn0qI4xFaHwV
         /t39M4GhAwl8q2YurVja1UQeoIMJdXyVrZqj9Wz1Tty9MFdibBF+SsBTvspjAAJa/cu/
         7n0UGSnWKtxb9aCAAyrtrjgSsEF3ifBgjnr2/xT4bRu7gqRKRyq8M/M9maMfSpawOsyJ
         iNoUQOTGL46ZzLLsy86MZd8u7VUvJiGCwIpuLetV1NpfLdSpoVnyCPCR+di5GQDMqevZ
         iKoQ==
X-Gm-Message-State: AOAM531a3PA/vEMNAlIlZ5yFtt0m1woUoiQOKQTqVdjABAbN8xmwoHJc
        ZCpxLZLYcHwKTAR38XdUIqlSvyKJp6u0gA==
X-Google-Smtp-Source: ABdhPJz3kG7DxhE4vbP1qX2XdISvABQUxSGiteqDYZh++p6SAN4K1nyWfCRIu+B8MUibfQ4Fh9iG6w==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr27660284wrw.198.1600245984006;
        Wed, 16 Sep 2020 01:46:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n14sm3974621wmi.33.2020.09.16.01.46.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 01:46:23 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: fix missing of_node_put() in
 of_nvmem_device_get()
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200915214822.6756-1-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <468432ca-7835-9a35-fcd1-7ad8b4ab3817@linaro.org>
Date:   Wed, 16 Sep 2020 09:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200915214822.6756-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2020 22:48, Vadym Kochan wrote:
> of_parse_phandle() returns device_node with incremented ref count
> which needs to be decremented by of_node_put() when device_node
> is not used.
> 
> Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>   drivers/nvmem/core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)


Applied thanks,

--srini

> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..204a515d8bc5 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -835,6 +835,7 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
>   {
>   
>   	struct device_node *nvmem_np;
> +	struct nvmem_device *nvmem;
>   	int index = 0;
>   
>   	if (id)
> @@ -844,7 +845,9 @@ struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
>   	if (!nvmem_np)
>   		return ERR_PTR(-ENOENT);
>   
> -	return __nvmem_device_get(nvmem_np, device_match_of_node);
> +	nvmem = __nvmem_device_get(nvmem_np, device_match_of_node);
> +	of_node_put(nvmem_np);
> +	return nvmem;
>   }
>   EXPORT_SYMBOL_GPL(of_nvmem_device_get);
>   #endif
> 
