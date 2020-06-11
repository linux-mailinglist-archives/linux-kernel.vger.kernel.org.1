Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D11F6B57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgFKPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 11:45:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbgFKPpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:45:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6E71F1;
        Thu, 11 Jun 2020 08:45:49 -0700 (PDT)
Received: from [10.57.43.165] (unknown [10.57.43.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B299B3F6CF;
        Thu, 11 Jun 2020 08:45:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm-nommu: Add use_reserved_mem() to check if device
 support reserved memory
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kstewart@linuxfoundation.org, devicetree@vger.kernel.org,
        alexandre.torgue@st.com, info@metux.net, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
        tglx@linutronix.de, dillon.minfei@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com, allison@lohutok.net
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
 <1591605038-8682-3-git-send-email-dillon.minfei@gmail.com>
 <90df5646-e0c4-fcac-d934-4cc922230dd2@arm.com>
 <20200610072444.GA6293@infradead.org>
 <9c3a7b4e-0190-e9bb-91fe-6d5692559888@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <27881ee0-dc40-e8c6-34f6-712f9acc3fbc@arm.com>
Date:   Thu, 11 Jun 2020 16:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c3a7b4e-0190-e9bb-91fe-6d5692559888@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 9:19 AM, Vladimir Murzin wrote:
> On 6/10/20 8:24 AM, Christoph Hellwig wrote:
>> Ok, I finally found the original patch from Vladimir.  Comments below:
>>
>>> +++ b/kernel/dma/direct.c
>>> @@ -456,14 +456,14 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>>>  #else /* CONFIG_MMU */
>>>  bool dma_direct_can_mmap(struct device *dev)
>>>  {
>>> -	return false;
>>> +	return true;
>>>  }
>>>  
>>>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>>>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>>  		unsigned long attrs)
>>>  {
>>> -	return -ENXIO;
>>> +	return vm_iomap_memory(vma, vma->vm_start, (vma->vm_end - vma->vm_start));;
>>
>> I think we should try to reuse the mmu dma_direct_mmap implementation,
>> which does about the same.  This version has been compile tested on
>> arm-nommu only, let me know what you think: (btw, a nommu_defconfig of
>> some kind for arm would be nice..)
> 
> Catch-all nommu_defconfig is not easy for ARM, AFAIK folk carry few hacks
> for randconfig...
> 
> Meanwhile, known working NOMMU configs
> 
> $ git grep "# CONFIG_MMU is not set" arch/arm/configs/
> arch/arm/configs/efm32_defconfig:# CONFIG_MMU is not set
> arch/arm/configs/lpc18xx_defconfig:# CONFIG_MMU is not set
> arch/arm/configs/mps2_defconfig:# CONFIG_MMU is not set
> arch/arm/configs/stm32_defconfig:# CONFIG_MMU is not set
> arch/arm/configs/vf610m4_defconfig:# CONFIG_MMU is not set
> 
>>
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index d006668c0027d2..e0dae570a51530 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -71,6 +71,7 @@ config SWIOTLB
>>  # in the pagetables
>>  #
>>  config DMA_NONCOHERENT_MMAP
>> +	default y if !MMU
>>  	bool
> 
> Nit: def_bool !MMU
> 
>>  
>>  config DMA_REMAP
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 0a4881e59aa7d6..9ec6a5c3fc578c 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -459,7 +459,6 @@ int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
>>  	return ret;
>>  }
>>  
>> -#ifdef CONFIG_MMU
>>  bool dma_direct_can_mmap(struct device *dev)
>>  {
>>  	return dev_is_dma_coherent(dev) ||
>> @@ -485,19 +484,6 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>>  	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
>>  			user_count << PAGE_SHIFT, vma->vm_page_prot);
>>  }
>> -#else /* CONFIG_MMU */
>> -bool dma_direct_can_mmap(struct device *dev)
>> -{
>> -	return false;
>> -}
>> -
>> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>> -		unsigned long attrs)
>> -{
>> -	return -ENXIO;
>> -}
>> -#endif /* CONFIG_MMU */
>>  
>>  int dma_direct_supported(struct device *dev, u64 mask)
>>  {
>>
> 
> LGTM. FWIW:
> 
> Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> 

@dillon, can you give it a try?

I think Christoph would appreciate your Tested-by and that might speed up
getting fix mainline.


Cheers
Vladimir

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

