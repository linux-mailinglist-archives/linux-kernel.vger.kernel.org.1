Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD827597D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIWOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:10:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:10:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so145379wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PXrVfoz6J9yJ729BkbuwwAQsxmKu+ESUe/VkCqCFUSw=;
        b=ZxgXc+kYibkka9JAXO8m3UZLbBScd+FQocVi+m8V+BxpYQUgAlHC/TFN0ReGyC3ZHe
         8U2ByyFYaWpKHZU7NDDoEVqq69uM6UahF1m7R88ZuyGuQQ2DsPCURbuUxnd/8+CR9ZRm
         ElFK7JIm9CdPF5KG/vJ2sRyQ+YP0surZf917a3bp/ZFL/iLGhzNslX+lfSSVwn2JGkCu
         Zzi0ZOyLFbeKDNbaqUGIFQNrnzhtYLAW0DV8N5kdUv2LTzEI9MfB17FXeElAYMpg8+Uo
         YNEWJrlvQU/lKmDZgCZU33R/w7YnY/SNjdhF/mkaRdkUe+DaM4nfE4zb2LqrEtWhvjXV
         hMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXrVfoz6J9yJ729BkbuwwAQsxmKu+ESUe/VkCqCFUSw=;
        b=tI2N6sqSfP6L7AFS1uEVjbGBHIjyU6adseCbsLhHFH3VI5WVGdQy5aJ4pU+R9h+oJR
         dw0fOR6r1HOcRgTrnyRwyg7Qn+FvHbUUg5qZWQYhSTrld42OyqtOrGPh46AG9Pb2Lf+V
         rTrT+0LMeh3q/A6FtvxCP1Wc/CJfOa54NAsF4CUQCHUd2t5AnMVSyD+yYG0RqAce1s2n
         LRzJJ+U08jk14uuMBF/OM//kuB1tq2lJV2iBrrackSDIq9g86pcbVmD/hgqqCqqQDMXE
         KA4qYxiTyoVD3v1/+7lVUqLfKxhSuUzDXdwAFEsm6dNqo71lmLJxyc0h6uGlS3zLTJUb
         TwGA==
X-Gm-Message-State: AOAM533TQJwpbko185N5AC2Fp9tFIlxjeb3V3jQlS7u7Bq5eOmnhtrsX
        mSh7gS+8I9WRhotqJxkNWMaaW5KlmnpwMg==
X-Google-Smtp-Source: ABdhPJwcgAjT+ekIPeUKgmmnO4Mp3EnX+peuKXIw69hs7YpQPRB8X7Un0rQWUcp1fFVIu4PmXBbIFA==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr1203963wrw.198.1600870238430;
        Wed, 23 Sep 2020 07:10:38 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l3sm8351769wmh.27.2020.09.23.07.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 07:10:37 -0700 (PDT)
Subject: Re: [PATCH v2] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923135343.16565-1-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7a072204-a4b8-e5ef-9ce2-4db176f70366@linaro.org>
Date:   Wed, 23 Sep 2020 15:10:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923135343.16565-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 14:53, Vadym Kochan wrote:
> Fix missing 'kfree_const(cell->name)' when call to
> nvmem_cell_info_to_nvmem_cell() in several places:
> 
>       * after nvmem_cell_info_to_nvmem_cell() failed during
>         nvmem_add_cells()
> 
>       * during nvmem_device_cell_{read,write}. This is fixed by simply
>         re-using info->name instead of duplicating it:
> 
>             cell->name = info->name
> 
> Because cell->name is not used except for error message printing in case
> of un-aligned access, the new __nvmem_cell_info_to_nvmem_cell() helper
> was introduced.
> 
> Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>      * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
>        failed.
> 
>   drivers/nvmem/core.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)



Really :-)


Below change should just fix this the reported issue!
------------------------>cut<---------------------------

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6cd3edb2eaf6..9fb9112fe75d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -383,6 +383,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct 
nvmem_device *nvmem,
                 dev_err(&nvmem->dev,
                         "cell %s unaligned to nvmem stride %d\n",
                         cell->name, nvmem->stride);
+               kfree_const(cell->name);
                 return -EINVAL;
         }

------------------------>cut<---------------------------

I don't see a point in the way your patch try to fix this!!


--srini

> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..e6d1bc414faf 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -361,16 +361,15 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
>   }
>   
> -static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> -				   const struct nvmem_cell_info *info,
> -				   struct nvmem_cell *cell)
> +static int
> +__nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> +				const struct nvmem_cell_info *info,
> +				struct nvmem_cell *cell)
>   {
>   	cell->nvmem = nvmem;
>   	cell->offset = info->offset;
>   	cell->bytes = info->bytes;
> -	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> -	if (!cell->name)
> -		return -ENOMEM;
> +	cell->name = info->name;
>   
>   	cell->bit_offset = info->bit_offset;
>   	cell->nbits = info->nbits;
> @@ -382,13 +381,31 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>   	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
>   		dev_err(&nvmem->dev,
>   			"cell %s unaligned to nvmem stride %d\n",
> -			cell->name, nvmem->stride);
> +			cell->name ?: "<unknown>", nvmem->stride);
>   		return -EINVAL;
>   	}
>   
>   	return 0;
>   }
>   
> +static int
> +nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> +			      const struct nvmem_cell_info *info,
> +			      struct nvmem_cell *cell)
> +{
> +	int err;
> +
> +	err = __nvmem_cell_info_to_nvmem_cell(nvmem, info, cell);
> +	if (err)
> +		return err;
> +
> +	cell->name = kstrdup_const(info->name, GFP_KERNEL);
> +	if (!cell->name)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   /**
>    * nvmem_add_cells() - Add cell information to an nvmem device
>    *
> @@ -1460,7 +1477,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>   	if (!nvmem)
>   		return -EINVAL;
>   
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>   	if (rc)
>   		return rc;
>   
> @@ -1490,7 +1507,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
>   	if (!nvmem)
>   		return -EINVAL;
>   
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = __nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
>   	if (rc)
>   		return rc;
>   
> 
