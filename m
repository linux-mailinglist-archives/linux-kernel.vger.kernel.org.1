Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF77529DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbgJ2AsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgJ2ArG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:47:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2584C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:47:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b3so919072pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ldq+BaCHFGxiQTunTg58Jqzdh7VCGURX37mdUjZn1eU=;
        b=wyUORgbJvh+A575hdAXGUhNMCPw2wjQqdKzftI+f9ACZ1VWqKMv2WzlcukXSGHIcQT
         O4SGKDkosOnrJcbFMx5mGpjzLYeu1wBdshKLKwvJo4ZtCVfJHt88nV6rwcNZRyLCcuBK
         WVKbePw2HHKJIMcwmeprnWx/gMfEJKOGWu1A6PQfxS5gXwsYa5EYNW9ZgkaRJD6NXdHy
         UwnvCCMf7VA/g3JCio7G29RkHOvr7uEbJawL51kzBquv9WVcdKW5CKAWL8Vu59p2Worl
         wlw/bljoUorb5DkysNzoumwxLEi0oHQk9XsUaS6x8RfbfndUZlGC1j9zvmQkwQnvSex5
         GGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ldq+BaCHFGxiQTunTg58Jqzdh7VCGURX37mdUjZn1eU=;
        b=NkvCUahk6Bw+lbqXHP9da4JvnbsoFw64Zr1tGf9Fc4huUtdZZoq2vEme2ycSsCrnKN
         CWBJrk936VasCt59yJMN8++ccCIIJKAlfptSVzoMuRTRi88CIv7ntSOZpiQ7WHw5u2e5
         c4+Hk9A1FREQgEeZYKqIL5bO12Vv0n374lBfxkkpB+gPyJkjCcq2r+w9EZ2yYzv3NqJp
         w2eE0WJtNDoC4StjyT9IyTz7PqKz0RzU5IKQU2iEj+/vnOB5xj6mboPWquAryL107erF
         HCpMufgxo42tlIy31fsNoltzy3n9gjnPSBxnPE/eYJcOBtqt4rcmfbWvlh4xmCECMgMU
         YZlQ==
X-Gm-Message-State: AOAM533AHGaQhjKLzw2hJPdh1FYj/DNrU56F93oVpbZ3kGjinAT4eALh
        MjBGk9tyt6OwjewPiU9HpOw9oVfHqjim6w==
X-Google-Smtp-Source: ABdhPJwQeHwGAhLun9jUEWuolN0Z952UoAYpqBQvc1TiN1O0YqY/U4Wvi4c0j0oLKnp0h8WabeYK3g==
X-Received: by 2002:a63:b516:: with SMTP id y22mr1772608pge.154.1603932425075;
        Wed, 28 Oct 2020 17:47:05 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au. [124.171.72.187])
        by smtp.gmail.com with UTF8SMTPSA id v16sm533051pgk.26.2020.10.28.17.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 17:47:04 -0700 (PDT)
Subject: Re: [PATCH kernel v3 2/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-3-aik@ozlabs.ru> <87eelhx3t6.fsf@mpe.ellerman.id.au>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f285412-9e19-7888-1102-f50658c43b9d@ozlabs.ru>
Date:   Thu, 29 Oct 2020 11:46:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <87eelhx3t6.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2020 11:40, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index e4198700ed1a..91112e748491 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -1111,11 +1112,13 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>>    */
>>   static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   {
>> -	int len, ret;
>> +	int len = 0, ret;
>> +	bool pmem_present = of_find_node_by_type(NULL, "ibm,pmemory") != NULL;
> 
> That leaks a reference on the returned node.
> 
> 	dn = of_find_node_by_type(NULL, "ibm,pmemory");
> 	pmem_present = dn != NULL;
> 	of_node_put(dn);


ah, true. v4 then.


> 
> 
>> @@ -1126,7 +1129,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   
>>   	mutex_lock(&direct_window_init_mutex);
>>   
>> -	dma_addr = find_existing_ddw(pdn);
>> +	dma_addr = find_existing_ddw(pdn, &len);
> 
> I don't see len used anywhere?
> 
>>   	if (dma_addr != 0)
>>   		goto out_unlock;
>>   
>> @@ -1212,14 +1215,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   	}
>>   	/* verify the window * number of ptes will map the partition */
>>   	/* check largest block * page size > max memory hotplug addr */
>> -	max_addr = ddw_memory_hotplug_max();
>> -	if (query.largest_available_block < (max_addr >> page_shift)) {
>> -		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
>> -			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
>> -			  1ULL << page_shift);
>> +	/*
>> +	 * The "ibm,pmemory" can appear anywhere in the address space.
>> +	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
>> +	 * for the upper limit and fallback to max RAM otherwise but this
>> +	 * disables device::dma_ops_bypass.
>> +	 */
>> +	len = max_ram_len;
> 
> Here you override whatever find_existing_ddw() wrote to len?


Not always, there is a bunch of gotos before this line to the end of the 
function and one (which returns the existing window) is legit. Thanks,



> 
>> +	if (pmem_present) {
>> +		if (query.largest_available_block >=
>> +		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
>> +			len = MAX_PHYSMEM_BITS - page_shift;
>> +		else
>> +			dev_info(&dev->dev, "Skipping ibm,pmemory");
>> +	}
>> +
>> +	if (query.largest_available_block < (1ULL << (len - page_shift))) {
>> +		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
>> +			1ULL << len, query.largest_available_block, 1ULL << page_shift);
>>   		goto out_failed;
>>   	}
>> -	len = order_base_2(max_addr);
>>   	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
>>   	if (!win64) {
>>   		dev_info(&dev->dev,
> 
> 
> cheers
> 

-- 
Alexey
