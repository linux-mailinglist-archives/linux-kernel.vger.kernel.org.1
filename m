Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80172984B4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 23:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419777AbgJYW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 18:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1418993AbgJYW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 18:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603664867;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fc6Wc/tM4Lhn+mkq5GzT0PLSJugPSj6zN4yvXTZ8zv0=;
        b=AJlVnZFr/L6My8kHF63+4t/HIIqoJG5MWj9Y4yiujK7ykEWK5L2AOhKAFNH0eSRh6dPQAN
        wGcz3Ff6Q2tqTbAJd2l00lAWLpmLs+RiUYY/ubQXQxY+sAHr1UnCHtzqR8+iGglI+EIhQt
        dgp8bB94HTGe41d2IuFWnJKOxTcFKDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-SpX1ey7SPEentKBfC_fSzg-1; Sun, 25 Oct 2020 18:27:43 -0400
X-MC-Unique: SpX1ey7SPEentKBfC_fSzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 063BF1006C8C;
        Sun, 25 Oct 2020 22:27:42 +0000 (UTC)
Received: from [10.64.54.35] (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 457A31043263;
        Sun, 25 Oct 2020 22:27:39 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/3] KVM: arm64: Don't map PUD huge page if it's not
 available
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-3-gshan@redhat.com> <87zh4aoc22.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <3d4b80e6-95c4-4634-5e7e-a53ef3af0d75@redhat.com>
Date:   Mon, 26 Oct 2020 09:27:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87zh4aoc22.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/25/20 9:05 PM, Marc Zyngier wrote:
> On Sun, 25 Oct 2020 01:27:38 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> PUD huge page isn't available when CONFIG_ARM64_4K_PAGES is disabled.
>> In this case, we needn't try to map the memory through PUD huge pages
>> to save some CPU cycles in the hot path.
>>
>> This also corrects the code style issue, which was introduced by
>> commit <523b3999e5f6> ("KVM: arm64: Try PMD block mappings if PUD mappings
>> are not supported").
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index a816cb8e619b..0f51585adc04 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -787,9 +787,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   		vma_shift = PAGE_SHIFT;
>>   	}
>>   
>> +#ifdef CONFIG_ARM64_4K_PAGES
>>   	if (vma_shift == PUD_SHIFT &&
>>   	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
>> -	       vma_shift = PMD_SHIFT;
>> +		vma_shift = PMD_SHIFT;
>> +#endif
>>   
>>   	if (vma_shift == PMD_SHIFT &&
>>   	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
> 
> 
> I really don't buy the "CPU cycles" argument here either. Can you
> actually measure any difference here?
> 
> You have taken a fault, gone through a full guest exit, triaged it,
> and are about to into a page mapping operation which may result in a
> TLBI, and reenter the guest. It only happen a handful of times per
> page over the lifetime of the guest unless you start swapping. Hot
> path? I don't think so.
> 

Thanks for the explanation. Agreed and I will drop this in v2.

Thanks,
Gavin

