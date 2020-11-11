Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04372AF06A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:18:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgKKMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605096624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y65as4hO2k5CaDRlNinPuyS+/mcMvfkWE/AmgknX/f0=;
        b=ePDDo/IVplNCu6+gd4seMQu+2rPdX3cHBMzVu9QTYHqQUVrcaSwN0PV8h4gpmlB5DFEOMu
        Jiftqd9w5r5Qg7H77fmS/aW0HwdlwSwsjXOGqvnZbpw5/eUUnaaN+GcPiQb+BrG/Zo7w99
        oweXDrQhLj8Czf24r0OUuRqQyfetEjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-KIVkhXwCPsa4RlcUPDHLEA-1; Wed, 11 Nov 2020 07:10:20 -0500
X-MC-Unique: KIVkhXwCPsa4RlcUPDHLEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE2A879526;
        Wed, 11 Nov 2020 12:10:18 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 721865C62B;
        Wed, 11 Nov 2020 12:10:16 +0000 (UTC)
Subject: Re: [PATCH v1 2/4] powerpc/mm: print warning in
 arch_remove_linear_mapping()
To:     osalvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-3-david@redhat.com>
 <20201104094255.GA4981@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <78f48ca7-d801-238d-f107-11b82d8a6384@redhat.com>
Date:   Wed, 11 Nov 2020 13:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201104094255.GA4981@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.20 10:42, osalvador wrote:
> On Thu, Oct 29, 2020 at 05:27:16PM +0100, David Hildenbrand wrote:
>> Let's print a warning similar to in arch_add_linear_mapping() instead of
>> WARN_ON_ONCE() and eventually crashing the kernel.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Rashmica Gupta <rashmica.g@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/powerpc/mm/mem.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index 8a86d81f8df0..685028451dd2 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -145,7 +145,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
>>   	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>>   
>>   	ret = remove_section_mapping(start, start + size);
>> -	WARN_ON_ONCE(ret);
>> +	if (ret)
>> +		pr_warn("Unable to remove linear mapping for 0x%llx..0x%llx: %d\n",
>> +			start, start + size, ret);
> 
> I guess the fear is to panic on systems that do have panic_on_warn (not
> sure how many productions systems have this out there).

Exactly.

> But anyway, being coherent with that, I think you should remove the WARN_ON
> in hash__remove_section_mapping as well.

Thanks, I'll add a patch doing that.

> 
> Besides that:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.
> 
> Not sure if the functions below that also have any sort of WARN_ON.
> native_hpte_removebolted has a VM_WARN_ON, but that is on
> CONFIG_DEBUG_VM so does not really matter.

Right. Thanks!

-- 
Thanks,

David / dhildenb

