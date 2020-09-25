Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81B278416
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIYJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:32:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48758C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:32:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so2863696wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4AYpniAMfRyIZxoSbDsD0cbBOi0L5LjnstW16/XYys8=;
        b=EqrRwzScHGQ9bNOBSrkfHUojoFDVtMtIJjal/XLNQHibNbnPapmCQPNa0CyTkJtJOq
         FT4mGiKvtFN4/WSMx0KLxBk0HfKOi4QCazpGg+RVc10a/l9yF2+Q1XY1qkrFv1kjE7c1
         imD377Y5IEN9kdFoMkLsbCouPuLjf8TW2biLdU+/kGfPIXZFmsjULqL68r95mXxA3TbQ
         jHsEhHSX84Ud/4Cvy4E9d+Os7KNwIba6m8QXdVZqxMMyHv3+0msyNCtVtgYC2PeESc2j
         q03Ir7j+T11lq8X6sjt/8NzPStaqAcw4QPIlNdecU63HZWsvGcPzvd4e2Uo4WyD3noBH
         Afvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4AYpniAMfRyIZxoSbDsD0cbBOi0L5LjnstW16/XYys8=;
        b=W0QuEDwEs9ck4vAejnNgW6vG9l1zjMvNckik/4jwGmN9QjCI8rn2hITZaewaUAAZ+Z
         qDBcXe7p2mmqngNBn281lftTMsoBQ/RhVlOQtE0q2nI+XLMO1bPeRMdCMsuBHIgEDO2C
         0CqrjmdBSDx8dNuOjK7eoO3DrR9RJr1kqeNhGV5g2pKSY7YAtfiYRCKMBhOWNgZK+7Tf
         eQV682DBjFhsNB8o5q3+cvbfxDkBIQOTphKg6ewoeOLAUpwZclL/MrdwOYHEC1u7MtD5
         xyXYwz7QjOQKX0EFRMsssgAh3NdhiyZBZZKkc8Do+lHIkPS2lfex8/HDzpxZAeAo+udg
         BFOw==
X-Gm-Message-State: AOAM5314Z6tKjhdZUQaMjR4eEjz0dBtQ8Lb8iPM/tTTV9ooF48FhK1VM
        hHw/TQl1yKh668aVFadZmuchFoJNLQ0D1Q==
X-Google-Smtp-Source: ABdhPJyHf1RHjhrB9mxzXcDRQWxr1EKzsHmyFu2MCCn1HMQUocjW34d4O+b4SpLPa+V9Yx36qoIh9g==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr3741279wrr.105.1601026364364;
        Fri, 25 Sep 2020 02:32:44 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h204sm2172308wmf.35.2020.09.25.02.32.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 02:32:43 -0700 (PDT)
Subject: Re: [PATCH v3] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200923204456.14032-1-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <12edae35-a927-11bf-f80a-037011c4f07a@linaro.org>
Date:   Fri, 25 Sep 2020 10:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200923204456.14032-1-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2020 21:44, Vadym Kochan wrote:
> Fix missing 'kfree_const(cell->name)' when call to
> nvmem_cell_info_to_nvmem_cell() in several places:
> 
>       * after nvmem_cell_info_to_nvmem_cell() failed during
>         nvmem_add_cells()
> 
>       * during nvmem_device_cell_{read,write} when cell->name is
>         kstrdup'ed() without calling kfree_const() at the end, but
>         really there is no reason to do that 'dup, because the cell
>         instance is allocated on the stack for some short period to be
>         read/write without exposing it to the caller.
> 
> So the new nvmem_cell_info_to_nvmem_cell_nodup() helper is introduced
> which is used to convert cell_info -> cell without name duplication as
> a lighweight version of nvmem_cell_info_to_nvmem_cell().
> 
> Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

Looks good to me! Thanks for the patch.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Greg,

Can you please pick this one? As don't have any nvmem pending patches to 
send it together.

thanks,
srini


> ---
> v3:
>      * rename __nvmem_cell_info_to_nvmem_cell() -> nvmem_cell_info_to_nvmem_cell_nodup()
> 
>      * rephrase commit description a bit
> 
>      * get rid of wrong func line wrapping
> 
> v2:
>      * remove not needed 'kfree_const(cell->name)' after nvmem_cell_info_to_nvmem_cell()
>        failed.
> 
>   drivers/nvmem/core.c | 33 ++++++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6cd3edb2eaf6..10cd935cf30e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -361,16 +361,14 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
>   }
>   
> -static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> -				   const struct nvmem_cell_info *info,
> -				   struct nvmem_cell *cell)
> +static int nvmem_cell_info_to_nvmem_cell_nodup(struct nvmem_device *nvmem,
> +					const struct nvmem_cell_info *info,
> +					struct nvmem_cell *cell)
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
> @@ -382,13 +380,30 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
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
> +static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> +				const struct nvmem_cell_info *info,
> +				struct nvmem_cell *cell)
> +{
> +	int err;
> +
> +	err = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, cell);
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
> @@ -1460,7 +1475,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>   	if (!nvmem)
>   		return -EINVAL;
>   
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
>   	if (rc)
>   		return rc;
>   
> @@ -1490,7 +1505,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
>   	if (!nvmem)
>   		return -EINVAL;
>   
> -	rc = nvmem_cell_info_to_nvmem_cell(nvmem, info, &cell);
> +	rc = nvmem_cell_info_to_nvmem_cell_nodup(nvmem, info, &cell);
>   	if (rc)
>   		return rc;
>   
> 
