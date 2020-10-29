Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A729E7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgJ2Jzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:55:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34805 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgJ2Jzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:55:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMLRB4Xjhz9sRR;
        Thu, 29 Oct 2020 20:55:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603965334;
        bh=pPb0aB9btC0IoWiJ/n8aYnf7SCRhymJbOyiHpUiPwqI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YohtxlNkEk3R8Lh0G91PkqvSgHhGhAmSb2IpNRUYxsa1EJedF6Jc794Dbuol7jcnw
         L5pam1X/riHVUCBb2mcUYJIHOGNy0aq+YpvpJBLXcLXqY64913dhFFIHycPT+yeczd
         HCOY9BfnkFeNgWtHuwR8MyvM4htdMMX3Roc0ffmKFD+pibw9wIUukXNUWQBYZ7D6tN
         5tV97PCBHYT5ivAx22/S5pY6tkXAsktrd+yz734fsBvNCYCMjc54WodP3NdcFAStV0
         4GFL8QQhancEk6AtpQxBTe1at6ZWT3EeX7VcZz8iUdC9cFsLppuwBhsi/sSPhNbLqa
         Kndi83BW+6AbA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v3 2/2] powerpc/dma: Fallback to dma_ops when persistent memory present
In-Reply-To: <2f285412-9e19-7888-1102-f50658c43b9d@ozlabs.ru>
References: <20201028070030.60643-1-aik@ozlabs.ru> <20201028070030.60643-3-aik@ozlabs.ru> <87eelhx3t6.fsf@mpe.ellerman.id.au> <2f285412-9e19-7888-1102-f50658c43b9d@ozlabs.ru>
Date:   Thu, 29 Oct 2020 20:55:33 +1100
Message-ID: <87blglwe3u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 29/10/2020 11:40, Michael Ellerman wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>> @@ -1126,7 +1129,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>>   
>>>   	mutex_lock(&direct_window_init_mutex);
>>>   
>>> -	dma_addr = find_existing_ddw(pdn);
>>> +	dma_addr = find_existing_ddw(pdn, &len);
>> 
>> I don't see len used anywhere?
>> 
>>>   	if (dma_addr != 0)
>>>   		goto out_unlock;
>>>   
>>> @@ -1212,14 +1215,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>>   	}
>>>   	/* verify the window * number of ptes will map the partition */
>>>   	/* check largest block * page size > max memory hotplug addr */
>>> -	max_addr = ddw_memory_hotplug_max();
>>> -	if (query.largest_available_block < (max_addr >> page_shift)) {
>>> -		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
>>> -			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
>>> -			  1ULL << page_shift);
>>> +	/*
>>> +	 * The "ibm,pmemory" can appear anywhere in the address space.
>>> +	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
>>> +	 * for the upper limit and fallback to max RAM otherwise but this
>>> +	 * disables device::dma_ops_bypass.
>>> +	 */
>>> +	len = max_ram_len;
>> 
>> Here you override whatever find_existing_ddw() wrote to len?
>
> Not always, there is a bunch of gotos before this line to the end of the 
> function and one (which returns the existing window) is legit. Thanks,

Ah yep I see it.

Gotos considered confusing ;)

cheers
