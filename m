Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DCB29DA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbgJ1XPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbgJ1XPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:15:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:15:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b3so750105pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CR2wnnNlKWCuS4v8a17nk31my7ihb+hmRpvNks7K5nk=;
        b=GORSieNJXfwskxaxCjowLoxfeZJAJBnAwv32Jxo7LchBcWcFZsNgs2td3VwO2FpDap
         8VS39JtTsIkN16uJZ91UjVSKg4D3cjZTUmYyXQ4EdU4q/synSnECkjtEEBSLoN2otDf7
         WidryILLCwpaAcfIjcoMYYJeqknpRUgQLpKW8ZiXIT4GTH22ibwSOYE/7ay6ySN41mWG
         oBy2gdO7DYhHQrcSrV0NKdA93mlC3+0KwYn9PnadvEmLMuu4Vks70zDrrpf8Or7HUlKg
         V/RzNKoAwyVmp2MqwFjfjGLo55FVa9S6YmZfMC0064eqqicggyfyaL5fjTTN9yJRVcUS
         l80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CR2wnnNlKWCuS4v8a17nk31my7ihb+hmRpvNks7K5nk=;
        b=Z5w4ciJ9mrh+G3g8Sh/Fx+aoMkYCCGx9DwYjNSsccXgM1CnfCKF5/5OZCo0si8xwdM
         PFPVO7ScBglNbyDyIZOopfSDPBOzAz3a3Mht155fVLsbe4CkVJKm6iRj4bURI7zslKBe
         lJStC7nMFBq182HokD98CW6BtUZ768T7S3Oo2PeuALDro7zv0LZ2vQfM76bTV/w9wf6b
         wiBB3pJYpXvJpJFtiLRF4w0ohNgMT4k2LHvyGzB8HL5JJuNwNTRVc3bqbyi5UnlvfkaA
         JG5DnQi2VVhl1S1+x2J9SpylD+V74AhKUWXbGnoQu+2rJrIztXC5WdIqHQTHJBSYIatl
         JEKg==
X-Gm-Message-State: AOAM533xRiP0cwdAkCc2UymMqtM7EshukKWhikQINTFPbi5qbwGmu6S9
        cXPfxAPLB1UqafMllkoD2nNvmdHmjfvO+g==
X-Google-Smtp-Source: ABdhPJxWh5VuvnxVzHg1hXVvHKS4O8oUFbCH3BrcZ/J9wYqZvKrr/xcdDBUJybZIB3+Txzd8Jp2CCg==
X-Received: by 2002:a62:f846:0:b029:15f:f897:7647 with SMTP id c6-20020a62f8460000b029015ff8977647mr1225887pfm.75.1603926919318;
        Wed, 28 Oct 2020 16:15:19 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au. [124.171.72.187])
        by smtp.gmail.com with UTF8SMTPSA id e6sm634704pfn.190.2020.10.28.16.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:15:18 -0700 (PDT)
Subject: Re: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA
 operation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-2-aik@ozlabs.ru> <20201028172201.GB10015@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2d9957af-23b6-943f-faac-fc7607b6e250@ozlabs.ru>
Date:   Thu, 29 Oct 2020 10:15:13 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201028172201.GB10015@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2020 04:22, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 06:00:29PM +1100, Alexey Kardashevskiy wrote:
>> At the moment we allow bypassing DMA ops only when we can do this for
>> the entire RAM. However there are configs with mixed type memory
>> where we could still allow bypassing IOMMU in most cases;
>> POWERPC with persistent memory is one example.
>>
>> This adds an arch hook to determine where bypass can still work and
>> we invoke direct DMA API. The following patch checks the bus limit
>> on POWERPC to allow or disallow direct mapping.
>>
>> This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
>> hooks no-op by default.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   kernel/dma/mapping.c | 24 ++++++++++++++++++++----
>>   kernel/dma/Kconfig   |  4 ++++
>>   2 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 51bb8fa8eb89..a0bc9eb876ed 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
>>   	return dma_go_direct(dev, *dev->dma_mask, ops);
>>   }
>>   
>> +#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
>> +bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
>> +bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
>> +bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
>> +bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
>> +#else
>> +#define arch_dma_map_page_direct(d, a) (0)
>> +#define arch_dma_unmap_page_direct(d, a) (0)
>> +#define arch_dma_map_sg_direct(d, s, n) (0)
>> +#define arch_dma_unmap_sg_direct(d, s, n) (0)
>> +#endif
> 
> A bunch of overly long lines here.  Except for that this looks ok to me.
> If you want me to queue up the series I can just fix it up.

I thought 100 is the new limit since 
https://lkml.org/lkml/2020/5/29/1038 (yeah that mentioned some Christoph 
:) ) and having these multiline does not make a huge difference but feel 
free fixing them up.

Are you going to take both patches? Do you need mpe's ack? Thanks,


-- 
Alexey
