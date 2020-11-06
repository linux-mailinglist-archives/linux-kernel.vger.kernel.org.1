Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA52A9A76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKFRKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:10:53 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A27C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:10:51 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 63so762210qva.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=;
        b=O8ZZhEUu0ahk3vx3VEAynSB5X0BHcaeX65/n+GCfnMVQlCjjMM3p23k8VknqbUFUyG
         xS4iWwZ+m9Z6mkg5EpOdNoMXsSwme47E9SKHvzuTH2cbn6QNDJF2YiIdr4aqoE7iXB/k
         R26qVZFvuzWp9l9JFughus5JP/AB6TfuCX+HSeXdMTzkEtakFSXtNv9tzCAglH78ZTaw
         TxKQlv8W2NUJMBS609YgLTLtYOArXV3u02qTZ0YfEviaHGbm+YY/2p/KBah6FMWeQiQ3
         QQZnfhpfPbY0agR5AT7VNJeqCdJ5FGWJIUDioISdb0gQmdag4avVcFq3hR21efkD9fzo
         9fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=;
        b=rIFvxQg+5hrMT4xzr03Trt64X3+yseI/bGyXYsVIdHZ6KkhHCFGzZFeWBm8R+Jxem/
         BvHwxpWuBpBSxy05VRU/V1qlW8kiH4NVx1AliAVS1IuF4+pIzNzHDADhrTgJHAmwjTjE
         fg0nJuMR9TsPh1Hch1rEBjvjdzV9XKk3Lj5hC2IuEhbPKE1ajCYlYOt4ZJpVzs71polz
         hKhn3AfiyS0t1QLZdpiq2vzjzgb+IefXB8PtSkiKtZSeHXcgLmXpU2wHKKJRrBSAytx9
         EBg1c5PRdLjT540jnK3XmApo4Szb57Rv6R56S6A5ys+8sWnNDM/XzcQ2MnVyeIOmN/U4
         MJ2g==
X-Gm-Message-State: AOAM531BEF86mnC1zjK9YkabSn74HAk8Z5bY6reP8i/FYvKU375NXco7
        bbvBg3K/xUbf/iSjz00BUuorug==
X-Google-Smtp-Source: ABdhPJwF/MdD1qNke+ECauvjnsTNgCBiugOoWghae9wdj3qkdlvkqshdqouzdfR5ybfqevB97gjCZQ==
X-Received: by 2002:a0c:e346:: with SMTP id a6mr2528444qvm.9.1604682651091;
        Fri, 06 Nov 2020 09:10:51 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n4sm799428qkf.42.2020.11.06.09.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:10:49 -0800 (PST)
Subject: Re: [PATCH v5 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
To:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-6-nickrterrell@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b12254bc-7320-7170-f39d-e76afe1a7561@toxicpanda.com>
Date:   Fri, 6 Nov 2020 12:10:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103060535.8460-6-nickrterrell@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 1:05 AM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Move away from the compatibility wrapper to the zstd-1.4.6 API. This
> code is functionally equivalent.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>   fs/btrfs/zstd.c | 48 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index a7367ff573d4..6b466e090cd7 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -16,7 +16,7 @@
>   #include <linux/refcount.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
> -#include <linux/zstd_compat.h>
> +#include <linux/zstd.h>
>   #include "misc.h"
>   #include "compression.h"
>   #include "ctree.h"
> @@ -159,8 +159,8 @@ static void zstd_calc_ws_mem_sizes(void)
>   			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
>   		size_t level_size =
>   			max_t(size_t,
> -			      ZSTD_CStreamWorkspaceBound(params.cParams),
> -			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
> +			      ZSTD_estimateCStreamSize_usingCParams(params.cParams),
> +			      ZSTD_estimateDStreamSize(ZSTD_BTRFS_MAX_INPUT));
>   
>   		max_size = max_t(size_t, max_size, level_size);
>   		zstd_ws_mem_sizes[level - 1] = max_size;
> @@ -389,13 +389,23 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	*total_in = 0;
>   
>   	/* Initialize the stream */
> -	stream = ZSTD_initCStream(params, len, workspace->mem,
> -			workspace->size);
> +	stream = ZSTD_initStaticCStream(workspace->mem, workspace->size);
>   	if (!stream) {
> -		pr_warn("BTRFS: ZSTD_initCStream failed\n");
> +		pr_warn("BTRFS: ZSTD_initStaticCStream failed\n");
>   		ret = -EIO;
>   		goto out;
>   	}
> +	{
> +		size_t ret2;
> +
> +		ret2 = ZSTD_initCStream_advanced(stream, NULL, 0, params, len);
> +		if (ZSTD_isError(ret2)) {
> +			pr_warn("BTRFS: ZSTD_initCStream_advanced returned %s\n",
> +					ZSTD_getErrorName(ret2));
> +			ret = -EIO;
> +			goto out;
> +		}
> +	}

Please don't do this, you can just add size_t ret2 at the top and not put this 
in a block.  Other than that the code looks fine, once you fix that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
