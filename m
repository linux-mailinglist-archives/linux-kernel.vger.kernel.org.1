Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCA2EEA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbhAHAD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbhAHAD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:03:57 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBAAC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:03:17 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s75so9474638oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnrWTd2vISRaf7ZK8SYvTF83BwjJL1Dds3Ex444l+Oc=;
        b=eUtAZ6C1q8Ukgw7rArZ5bwk0Slk89o1R9bsNuxQztd8bC1pOKDzL88J5sR4CXV7d9B
         dTdn6ZSlzVj/gvEQ5AMDSYSL+AT2hj3c8Av8x2ZiGJoJKXE/5zV2R9Cq+waYNCPXwott
         g/QiAb8ukx56QCeb2nCYGFe4XbtXNsqczpdZP0LxyBxlLXvLdjJxGGsi/uvJ5YvP1geS
         YPFFb8JO0KwvQ6zCQcVKR5T28Blwb9MysxXyc5TSZAcSdu0g76XYRPuvMFiCkyXs0CMG
         Hp6g/PePlDsz9Pzx/WRXwH+HtthVNlR/LDZbNxYI+0yuQuG2jneMev/4F1fDefd06IU4
         IA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnrWTd2vISRaf7ZK8SYvTF83BwjJL1Dds3Ex444l+Oc=;
        b=HR6x/xWaVE5F/l4XdeFnBI5dyGyZh+VWZDBNz3cKfG6wuB/mQodetCn2b5Y5/OzPPw
         e7ppvjr8USDlKc5dYzLarzRhiPtQdafWcaH7LgmlyfOjK6bNMF2/v56Es5E/UgZ9TyBr
         SvoqX17cByVDrLDvQjtP8A1NJrr/eSAJiBVYKuHXIoVNlXzk9jsodUZhqpinJWVEEtCe
         5sn6vPh+rwFKlbyJimG4Ba8JRnQ7q5pLCghK4IF8HPA0IT3OvH7u7YX8+BUfSY7wYgc9
         2Q9uw1pBs6hfz3OgJdP18ssJCniptqEA/nRBgh+tCTw7iO6CDT+U0HVFc44PK75k9w2g
         dIcw==
X-Gm-Message-State: AOAM532zU+XekjH31OOy1LbqbMbHZETELgmJ5ZFOiX/iFymRVz5V6IV3
        g4pLrk4Y9iN9kPe9s1i8j7Fwih2F5NJiLA==
X-Google-Smtp-Source: ABdhPJx1J1V8KwZ4CTnKn+pXjpgiMdH7CWez2YUIny/CpRre+sbZGyDpfawEU/b9ofFVSKqaGdeu/g==
X-Received: by 2002:aca:afd0:: with SMTP id y199mr701814oie.7.1610064196811;
        Thu, 07 Jan 2021 16:03:16 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o49sm1420932ota.51.2021.01.07.16.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:03:15 -0800 (PST)
Date:   Thu, 7 Jan 2021 18:03:14 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH 1/3] soc: qcom: mdt_loader: Allow hash at any phdr
Message-ID: <X/ehQiTzo+AW0DRK@builder.lan>
References: <1609968211-7579-1-git-send-email-sidgup@codeaurora.org>
 <1609968211-7579-2-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609968211-7579-2-git-send-email-sidgup@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jan 15:23 CST 2021, Siddharth Gupta wrote:

> The assumption that the elf program header will always have the hash
> segment program header at index 1 may not hold true in all cases. This
> change updates the read metadata function to find the hash program header
> dynamically.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/soc/qcom/mdt_loader.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 24cd193..813216d 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (C) 2016 Linaro Ltd
>   * Copyright (C) 2015 Sony Mobile Communications Inc
> - * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2012-2013, 2020 The Linux Foundation. All rights reserved.
>   */
>  
>  #include <linux/device.h>
> @@ -88,6 +88,7 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
>  	const struct elf32_phdr *phdrs;
>  	const struct elf32_hdr *ehdr;
>  	size_t hash_offset;
> +	size_t hash_index;
>  	size_t hash_size;
>  	size_t ehdr_size;
>  	void *data;
> @@ -98,14 +99,19 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
>  	if (ehdr->e_phnum < 2)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (phdrs[0].p_type == PT_LOAD || phdrs[1].p_type == PT_LOAD)
> +	if (phdrs[0].p_type == PT_LOAD)
>  		return ERR_PTR(-EINVAL);
>  
> -	if ((phdrs[1].p_flags & QCOM_MDT_TYPE_MASK) != QCOM_MDT_TYPE_HASH)
> +	for (hash_index = 1; hash_index < ehdr->e_phnum; hash_index++) {
> +		if (phdrs[hash_index].p_type != PT_LOAD &&
> +		   (phdrs[hash_index].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH)
> +			break;
> +	}
> +	if (hash_index >= ehdr->e_phnum)
>  		return ERR_PTR(-EINVAL);
>  
>  	ehdr_size = phdrs[0].p_filesz;
> -	hash_size = phdrs[1].p_filesz;
> +	hash_size = phdrs[hash_index].p_filesz;
>  
>  	data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
>  	if (!data)
> @@ -115,7 +121,7 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
>  	if (ehdr_size + hash_size == fw->size)
>  		hash_offset = phdrs[0].p_filesz;
>  	else
> -		hash_offset = phdrs[1].p_offset;
> +		hash_offset = phdrs[hash_index].p_offset;
>  
>  	memcpy(data, fw->data, ehdr_size);
>  	memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
