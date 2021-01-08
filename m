Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81D2EF5F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbhAHQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbhAHQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:45:51 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF3C0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 08:45:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t16so9648373wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 08:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MG354YKqeHyUgNMxgEUcLfyaw4nS+tNiKDhutFtITdM=;
        b=lyrXu56qrmAzlKwKP703dHpcw9vR0LK7NuBeN+mVDSUwHciK8SqHbgGhSAJvPt0uP3
         gSNZttsPCUOHi+gebWpE6BiQW5oO5ifJFxV20x/F6+cXBf0q1wi2fBAzcYG8R0+fFfTL
         64v4riw2Co/e8UAxyfQPCpdDDnaV9ALjAFB2tQiyk6kQ3wstg8FwvV/tw6nrt5k6wT8V
         0tnkiGSYzx8OjbJt1ZDQpMSDZAGjduUQsYmOgtOT8qwku8Ll9ZfocmnVLp+4w50Ej6LT
         gko1/W9ueD17eU36zGWjYl80ClJRm/hxavo3kgTkOoOHhbSWXahdFXVj4TtGwamJNf+p
         uvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MG354YKqeHyUgNMxgEUcLfyaw4nS+tNiKDhutFtITdM=;
        b=gjQH+N5hOQux5q/MLmIZPzxYfTLkWIwiybw2RKd9cYY3wBmXFTvt6tvZNi5l/pHYjb
         XuDUOTmIpk7vuVGOnyzY8lUpSMyoMDT8+wCKyHdh16AQDeH2py3CWT7RAXhdb0+jQif0
         9NowPIZCqGtFuJXJvBRHNbCzWUIY1p5M0OKoVGxfCrlSHzkJAACwpWmFOYLpEOJ4ONuQ
         StiBc9tdr+m7rgBOtSN09bIW+TPkUxVGzpXqiz2MRmeQF2ABk8LPSYwT15/k+NdFIl/L
         UHJkt+n3rahLc71+FqvQ9xgQV0EhHZpWH1B46mRdKY7B/Qc0HJ25emwC4BzM3xj4ieDC
         bB5Q==
X-Gm-Message-State: AOAM532YwKDwgYVal6jVn1hKfh49573wky75t0kOpmZ1FRYmq1pjN3bh
        wIaCofbD5mjl3Rs9CeKLtlYN1F6faSQ=
X-Google-Smtp-Source: ABdhPJxatn/ZEj7UvGEu2+hg+JaQ5NTeu7t78CRbYwwW0Kh28KbdUYa3LZfTpEV2ZugSageaW42TZw==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr4577268wrs.58.1610124309479;
        Fri, 08 Jan 2021 08:45:09 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:6dbb:aa76:4e1a:5cc4? (p200300ea8f0655006dbbaa764e1a5cc4.dip0.t-ipconnect.de. [2003:ea:8f06:5500:6dbb:aa76:4e1a:5cc4])
        by smtp.googlemail.com with ESMTPSA id g78sm12178501wme.33.2021.01.08.08.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 08:45:08 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
 <ba14be47-6c77-94d6-9904-b4679e62091b@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9cd308a1-2222-8716-2002-c0dacfaa6d91@gmail.com>
Date:   Fri, 8 Jan 2021 17:45:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ba14be47-6c77-94d6-9904-b4679e62091b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.2020 14:01, Robin Murphy wrote:
> On 2020-12-13 16:32, Heiner Kallweit wrote:
>> Zillions of drivers use the unlikely() hint when checking the result of
>> dma_mapping_error(). This is an inline function anyway, so we can move
>> the hint into this function and remove it from drivers.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> FWIW I consider this case similar to the same hint in WARN_ON() and friends - it's a pretty severe condition that should never be expected to be hit in normal operation, so it's entirely logical for it to be implicitly unlikely. I struggle to imagine any case that would specifically *not* want that (or worse, want to hint it as likely). Some DMA API backends may spend considerable time trying as hard as possible to make a mapping work before eventually admitting defeat, so the idea of ever trying to optimise at the driver level for failure in hot paths just makes no sense.
> 
> Thanks,
> Robin.
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> v2:
>> Split the big patch into the change for dma-mapping.h and follow-up
>> patches per subsystem that will go through the trees of the respective
>> maintainers.
>> ---
>>   include/linux/dma-mapping.h | 2 +-
>>   kernel/dma/map_benchmark.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 2e49996a8..6177e20b5 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>>   {
>>       debug_dma_mapping_error(dev, dma_addr);
>>   -    if (dma_addr == DMA_MAPPING_ERROR)
>> +    if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>>           return -ENOMEM;
>>       return 0;
>>   }
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index b1496e744..901420a5d 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
>>             map_stime = ktime_get();
>>           dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
>> -        if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
>> +        if (dma_mapping_error(map->dev, dma_addr)) {
>>               pr_err("dma_map_single failed on %s\n",
>>                   dev_name(map->dev));
>>               ret = -ENOMEM;
>>

Is this patch going to make it to linux-next?
