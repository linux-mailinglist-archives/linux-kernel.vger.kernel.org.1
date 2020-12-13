Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7352D90E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgLMWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 17:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLMWYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 17:24:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF2C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 14:23:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d26so1359526wrb.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CpcQA8y5EOMq3kxe+epOyGnBZa2hF+OyoL02C9lsUQc=;
        b=ZMi5sSWUaK69ViITjTridS92Bcvx1bo8hcNEXZgc639d6QkecMcoDJXx2Ty2vfDWsL
         vS8Di+YOgabWa59QCIRWKoA8EeTlp5hIqh+LJfZX0b/c1QDx4kKNTgj6YqI2LNfwYgQ+
         tknZjAAQbQ1GMrpHFKL3UuZwAgMj6wniWqGnYJ4o+7vw0lWtNXX/e0CQkVHulVnBIBGf
         KPY7yrZWso5R+Bhtjk+B1S6HyJ+dFeX+SkijdXJweSHaRi6oidgHp7nyKpQZOVbNXkM/
         PfFCYYcyS7eX+N0DDhghQHvbpU0WepBwT3s3NGtaWO6QoAuQLg8MzpAReABeLzKHSr6W
         rvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CpcQA8y5EOMq3kxe+epOyGnBZa2hF+OyoL02C9lsUQc=;
        b=g3Fw9iiXior75SGsDZWEj9YDGXR71cB8YCHs180xocx992Eq+RpXByTGFHNbvEEXZr
         mu7VmIta1dJ7AtAG58gqnJV31VNcCe8emEFS+e2+d0eVB/jMP4MSRhCfiZeVQGDAyRTp
         R2FtrwAjI6643TR8SlACmkvUxEoRt/E5tFVsfelx7FbXy1VQVAenDNdJJG5sqB5pYMUv
         25YrFFb31hMvOA1Xj6YNOgWws1I3d8+UsBd46CCIVuSYEqaTwRgiLWON1V4SYIOczkbn
         m/mOHSAGmNHvx1UdN9VPNoeMHr1n/r1QRGJjA28DK3DeOlB3/icfoM9lxdLlhiDuwcGk
         XdzQ==
X-Gm-Message-State: AOAM530fv/sMNA5cCTdXkOkBZBaGR0ttUHbwjqTFS0jaWmN99hIuDQx6
        vsCB+V+EF9YDy3J3TJn2llD7G+vUk70=
X-Google-Smtp-Source: ABdhPJzzon2KHWc4xidKp2hBmJ8xDBSQePw9hQt0t2LBm2prz8oVNxrcYmCcJG/KkwRJkutLYv4zbA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr25652773wrw.73.1607898214399;
        Sun, 13 Dec 2020 14:23:34 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:7d4b:496c:666e:80c7? (p200300ea8f0655007d4b496c666e80c7.dip0.t-ipconnect.de. [2003:ea:8f06:5500:7d4b:496c:666e:80c7])
        by smtp.googlemail.com with ESMTPSA id d15sm28245730wrx.93.2020.12.13.14.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 14:23:33 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
 <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2faa40b9-e632-b9f3-6de0-471f0b7a6cae@gmail.com>
Date:   Sun, 13 Dec 2020 22:23:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.12.2020 um 22:27 schrieb Song Bao Hua (Barry Song):
> 
> 
>> -----Original Message-----
>> From: Heiner Kallweit [mailto:hkallweit1@gmail.com]
>> Sent: Monday, December 14, 2020 5:33 AM
>> To: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>; Song Bao Hua
>> (Barry Song) <song.bao.hua@hisilicon.com>
>> Cc: open list:AMD IOMMU (AMD-VI) <iommu@lists.linux-foundation.org>; Linux
>> Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Subject: [PATCH v2] dma-mapping: add unlikely hint for error path in
>> dma_mapping_error
>>
>> Zillions of drivers use the unlikely() hint when checking the result of
>> dma_mapping_error(). This is an inline function anyway, so we can move
>> the hint into this function and remove it from drivers.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> not sure if this is really necessary. It seems the original code
> is more readable. Readers can more easily understand we are
> predicting the branch based on the return value of
> dma_mapping_error().
> 
I basically see two points promoting the proposed change:
1. Driver authors shouldn't have to think (as far as possible) about
   whether a branch prediction hint could make sense for a standard
   core API call. I saw quite some past discussions about when
   something is unlikely enough so that an unlikely() makes sense.
   If the core can hide some more complexity from drivers, then
   I think it's a good thing.
2. If we ever want or have to change the use of unlikely with
   dma_mapping_error(), then we have to do it in just one place.

> Anyway, I don't object to this one. if other people like it, I am
> also ok with it.
> 
>> ---
>> v2:
>> Split the big patch into the change for dma-mapping.h and follow-up
>> patches per subsystem that will go through the trees of the respective
>> maintainers.
>> ---
>>  include/linux/dma-mapping.h | 2 +-
>>  kernel/dma/map_benchmark.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 2e49996a8..6177e20b5 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev,
>> dma_addr_t dma_addr)
>>  {
>>  	debug_dma_mapping_error(dev, dma_addr);
>>
>> -	if (dma_addr == DMA_MAPPING_ERROR)
>> +	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>>  		return -ENOMEM;
>>  	return 0;
>>  }
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index b1496e744..901420a5d 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
>>
>>  		map_stime = ktime_get();
>>  		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
>> -		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
>> +		if (dma_mapping_error(map->dev, dma_addr)) {
>>  			pr_err("dma_map_single failed on %s\n",
>>  				dev_name(map->dev));
>>  			ret = -ENOMEM;
>> --
>> 2.29.2
> 
> Thanks
> Barry
> 

