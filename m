Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465061C7E66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEGAQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 20:16:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56700 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726860AbgEGAQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588810573;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSCA9RBsimoObRbae5ozwK5uzV2+0s8IdfYdBDLhAxc=;
        b=AmbX5+IIfviu+sH1mvDLx4dTqtH6UJX1VQ+FlTSc+o2GV9BcdlLX8MaAjGGkjiksJDK+Wa
        s0VLMPFwn3S0LjqSC5FqNKn1g4gF6Vl8GIGsQMf7L2KXte5Di1oL+X+mNaB3FSYEULrFeR
        v53jNjR7Z1Ck2uMYXxHw8zhGWscz4Xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-3aBf_r36NcKdIyBHyYDctA-1; Wed, 06 May 2020 20:16:07 -0400
X-MC-Unique: 3aBf_r36NcKdIyBHyYDctA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 915801005510;
        Thu,  7 May 2020 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-199.bne.redhat.com [10.64.54.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 152475C1D4;
        Thu,  7 May 2020 00:16:02 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Remove add_huge_page_size()
To:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
References: <20200506064635.20114-1-gshan@redhat.com>
 <fa3ad75d-9c4d-d6c9-1664-53b4c9770c6b@arm.com>
 <20200506071927.GB7021@willie-the-truck>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e13bb496-7988-e096-2131-78c004231f27@redhat.com>
Date:   Thu, 7 May 2020 10:15:59 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200506071927.GB7021@willie-the-truck>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 5:19 PM, Will Deacon wrote:
> On Wed, May 06, 2020 at 12:36:43PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 05/06/2020 12:16 PM, Gavin Shan wrote:
>>> The function add_huge_page_size(), wrapper of hugetlb_add_hstate(),
>>> avoids to register duplicated huge page states for same size. However,
>>> the same logic has been included in hugetlb_add_hstate(). So it seems
>>> unnecessary to keep add_huge_page_size() and this just removes it.
>>
>> Makes sense.
>>
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/mm/hugetlbpage.c | 18 +++++-------------
>>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>> index bbeb6a5a6ba6..ed7530413941 100644
>>> --- a/arch/arm64/mm/hugetlbpage.c
>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>> @@ -441,22 +441,14 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>>>   	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>>>   }
>>>   
>>> -static void __init add_huge_page_size(unsigned long size)
>>> -{
>>> -	if (size_to_hstate(size))
>>> -		return;
>>> -
>>> -	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
>>> -}
>>> -
>>>   static int __init hugetlbpage_init(void)
>>>   {
>>>   #ifdef CONFIG_ARM64_4K_PAGES
>>> -	add_huge_page_size(PUD_SIZE);
>>> +	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>>>   #endif
>>> -	add_huge_page_size(CONT_PMD_SIZE);
>>> -	add_huge_page_size(PMD_SIZE);
>>> -	add_huge_page_size(CONT_PTE_SIZE);
>>> +	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);
>>> +	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
>>> +	hugetlb_add_hstate(CONT_PTE_SHIFT);
> 
> Something similar has already been done in linux-next.
> 

Thanks, Will. I didn't check linux-next before posting this patch.
Please ignore it then :)

>> Should these page order values be converted into macros instead. Also
>> we should probably keep (CONT_PTE_SHIFT + PAGE_SHIFT - PAGE_SHIFT) as
>> is to make things more clear.
> 
> I think the real confusion stems from us not being consistent with your
> *_SHIFT definitions on arm64. It's madness for CONT_PTE_SHIFT to be smaller
> than PAGE_SHIFT imo, but it's just cosmetic I guess.
> 

Yeah, Do you want me to post a patch, to fix it?

> Will
> 

Thanks,
Gavin

