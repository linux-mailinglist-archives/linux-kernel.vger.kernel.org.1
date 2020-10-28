Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8329E08B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgJ2BWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgJ1WEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:04:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:04:21 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w5so538095qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0gyGFaDOcOeQhjWoBvvUrgMjgi73degQBGCdgvQxJWw=;
        b=1zT8ojDOkSyqm3LHsLojKFZue3lfDkmgiWdwR7z3MDg2KVVJQGN/8bLcvGve/9V3pS
         kBPxpkrMojKBM57d5lD99sAlDJiRCtLv7Obo9mUqTw5lqcvJb+a3sVumt4NQIsPQ0c+h
         5ZiQ3KTjFB4WDGRRJNKwnOHtY4CoJgy7lr08/ICOLvF0N/EXWRGrijyARFNwUBVjBxLJ
         JD1q1WUh/pnebnTDXWA7JpJeffYh5IFKaVEz7/CsXrXi+69HYzxfY3pQ40hxcM2sJt05
         gx5BSOdWvwBaK+xQ8yZ7PrpnOnogk80Pda4TRHVztUF6Mzv244Yy5pHVvOTgs09BfV59
         A7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0gyGFaDOcOeQhjWoBvvUrgMjgi73degQBGCdgvQxJWw=;
        b=lg6vRLhfhJBHsWFQ5q+PsoSgHr0CbLwk0lgZsh7mLzBTNZApBFCekXGQqs4eOvX2SY
         yFXdNFm2Hu+rBbXw6lMeOoSPh9J2SjCURlE3nUF/Unj0CODDYM22r9HVQ3OTWPMggT/X
         pYp8xg9T8ifEiRxgGLiSRe2KkvTr4hVRFbNSCzktpkyUbGfVQNO0eXbawx8yqAVHxeA8
         BZBXI1ipSJIPXbLswmqBuHshTNSdPtYeAYrEmJyZ7PpkG0FAAI7qrGX8VhKlpi1StOss
         LvaupOCsMNgtsowt5CZp8vkGGaJH8BphiR+VtFRfx2vjyWTENgWXNhL7f5LZs9IEjU4q
         QqpA==
X-Gm-Message-State: AOAM531J7efQJOBzYsCh+u0a5jb5PD0GaG/oOU+zdE0jMnDIedzsvWK2
        /JeN6aKEdNzDvBa8XwnVtAfYivX68jyCHA==
X-Google-Smtp-Source: ABdhPJwLK7sVbIf76eH/CksvHl+Gf+oPqZSizyfuyOV5tzPAtqjO0/LOeSMI+tR01QpsT10hmjc/Cg==
X-Received: by 2002:a62:a10a:0:b029:154:fd62:ba90 with SMTP id b10-20020a62a10a0000b0290154fd62ba90mr5423227pff.62.1603868128933;
        Tue, 27 Oct 2020 23:55:28 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au. [124.171.72.187])
        by smtp.gmail.com with UTF8SMTPSA id b6sm4288883pjq.42.2020.10.27.23.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:55:27 -0700 (PDT)
Subject: Re: [PATCH kernel v2 1/2] dma: Allow mixing bypass and normal IOMMU
 operation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201027101841.96056-1-aik@ozlabs.ru>
 <20201027101841.96056-2-aik@ozlabs.ru> <20201027164858.GA30651@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <28147035-500d-f3cd-f283-257066343697@ozlabs.ru>
Date:   Wed, 28 Oct 2020 17:55:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201027164858.GA30651@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2020 03:48, Christoph Hellwig wrote:
>> +static inline bool dma_handle_direct(struct device *dev, dma_addr_t dma_handle)
>> +{
>> +       return dma_handle >= dev->archdata.dma_offset;
>> +}
> 
> This won't compile except for powerpc, and directly accesing arch members
> in common code is a bad idea.  Maybe both your helpers need to be
> supplied by arch code to better abstract this out.


rats, overlooked it :( bus_dma_limit is generic but dma_offset is in 
archdata :-/


> 
>>   	if (dma_map_direct(dev, ops))
>>   		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>> +#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
>> +	else if (dev->bus_dma_limit &&
>> +		 can_map_direct(dev, (phys_addr_t) page_to_phys(page) + offset + size))
>> +		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>> +#endif
> 
> I don't think page_to_phys needs a phys_addr_t on the return value.
> I'd also much prefer if we make this a little more beautiful, here
> are a few suggestions:
> 
>   - hide the bus_dma_limit check inside can_map_direct, and provide a
>     stub so that we can avoid the ifdef
>   - use a better name for can_map_direct, and maybe also a better calling
>     convention by passing the page (the sg code also has the page), 

It is passing an address of the end of the mapped area so passing a page 
struct means passing page and offset which is an extra parameter and we 
do not want to do anything with the page in those hooks anyway so I'd 
keep it as is.


> and
>     maybe even hide the dma_map_direct inside it.

Call dma_map_direct() from arch_dma_map_page_direct() if 
arch_dma_map_page_direct() is defined? Seems suboptimal as it is going 
to be bypass=true in most cases and we save one call by avoiding calling 
arch_dma_map_page_direct(). Unless I missed something?


> 
> 	if (dma_map_direct(dev, ops) ||
> 	    arch_dma_map_page_direct(dev, page, offset, size))
> 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> 
>>   	BUG_ON(!valid_dma_direction(dir));
>>   	if (dma_map_direct(dev, ops))
>>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
>> +#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
>> +	else if (dev->bus_dma_limit && dma_handle_direct(dev, addr + size))
>> +		dma_direct_unmap_page(dev, addr, size, dir, attrs);
>> +#endif
> 
> Same here.
> 
>>   	if (dma_map_direct(dev, ops))
>>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>> +#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
>> +	else if (dev->bus_dma_limit) {
>> +		struct scatterlist *s;
>> +		bool direct = true;
>> +		int i;
>> +
>> +		for_each_sg(sg, s, nents, i) {
>> +			direct = can_map_direct(dev, sg_phys(s) + s->offset + s->length);
>> +			if (!direct)
>> +				break;
>> +		}
>> +		if (direct)
>> +			ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>> +		else
>> +			ents = ops->map_sg(dev, sg, nents, dir, attrs);
>> +	}
>> +#endif
> 
> This needs to go into a helper as well.  I think the same style as
> above would work pretty nicely as well:

Yup. I'll repost v3 soon with this change. Thanks for the review.


> 
>   	if (dma_map_direct(dev, ops) ||
> 	    arch_dma_map_sg_direct(dev, sg, nents))
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> 
>> +#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
>> +	if (dev->bus_dma_limit) {
>> +		struct scatterlist *s;
>> +		bool direct = true;
>> +		int i;
>> +
>> +		for_each_sg(sg, s, nents, i) {
>> +			direct = dma_handle_direct(dev, s->dma_address + s->length);
>> +			if (!direct)
>> +				break;
>> +		}
>> +		if (direct) {
>> +			dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
>> +			return;
>> +		}
>> +	}
>> +#endif
> 
> One more time here..
> 

-- 
Alexey
