Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC152984B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419472AbgJYWXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 18:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1419175AbgJYWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 18:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603664622;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knz5z/9c0D7sKmx0JVXHqKCTNlD5WcWiwXXiyziSRaQ=;
        b=eyAHA0Fe3qA2S9IIaD8WqHsLDSD8aK5fzQffQfXoi/MMiQQDru9pvDFw1H2uwEYGfoV7kO
        2/+zwBIPltAf7PEiWx4Vai+M7GPeHWS7651DPUj5hb4FZLOZYUrd6TeXItVJ0tkbXfjsRk
        FzcbnrDHZdAlcFJN+D+gOQy9PowD5Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-LWPRSDNYMKuzKqqkToLHPQ-1; Sun, 25 Oct 2020 18:23:37 -0400
X-MC-Unique: LWPRSDNYMKuzKqqkToLHPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ECB08049D0;
        Sun, 25 Oct 2020 22:23:36 +0000 (UTC)
Received: from [10.64.54.35] (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2EBE6EF42;
        Sun, 25 Oct 2020 22:23:34 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/3] KVM: arm64: Check if 52-bits PA is enabled
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-2-gshan@redhat.com> <871rhmpr92.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <333451bd-4730-4ebb-f76c-28fa5d0e1f7d@redhat.com>
Date:   Mon, 26 Oct 2020 09:23:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <871rhmpr92.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/25/20 8:52 PM, Marc Zyngier wrote:
> On Sun, 25 Oct 2020 01:27:37 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> The 52-bits physical address is disabled until CONFIG_ARM64_PA_BITS_52
>> is chosen. This uses option for that check, to avoid the unconditional
>> check on PAGE_SHIFT in the hot path and thus save some CPU cycles.
> 
> PAGE_SHIFT is known at compile time, and this code is dropped by the
> compiler if the selected page size is not 64K. This patch really only
> makes the code slightly less readable and the "CPU cycles" argument
> doesn't hold at all.
> 
> So what are you trying to solve exactly?
> 

There are two points covered by the patch: (1) The 52-bits physical address
is visible only when CONFIG_ARM64_PA_BITS_52 is enabled in arch/arm64 code.
The code looks consistent with this option used here. (2) I had the assumption
that gcc doesn't optimize the code and PAGE_SHIFT is always checked in order
to get higher 4 physical address bits, but you said gcc should optimize the
code accordingly. However, it would be still nice to make the code explicit.

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/hyp/pgtable.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> index 0cdf6e461cbd..fd850353ee89 100644
>> --- a/arch/arm64/kvm/hyp/pgtable.c
>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>> @@ -132,8 +132,9 @@ static u64 kvm_pte_to_phys(kvm_pte_t pte)
>>   {
>>   	u64 pa = pte & KVM_PTE_ADDR_MASK;
>>   
>> -	if (PAGE_SHIFT == 16)
>> -		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
>> +#ifdef CONFIG_ARM64_PA_BITS_52
>> +	pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
>> +#endif
>>   
>>   	return pa;
>>   }
>> @@ -142,8 +143,9 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
>>   {
>>   	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
>>   
>> -	if (PAGE_SHIFT == 16)
>> -		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
>> +#ifdef CONFIG_ARM64_PA_BITS_52
>> +	pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
>> +#endif
>>   
>>   	return pte;
>>   }
>> -- 
>> 2.23.0
>>
>>
> 

