Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D211C2C2BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbgKXPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:46:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40778 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbgKXPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:46:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOFZaIE097294;
        Tue, 24 Nov 2020 15:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=zD/LiCUlStMAH7DcAVf8Du6mll1JjO7supRGV9k3jR0=;
 b=R1YMySCSAztxRmCiAoDmUvr+LZwZTDIlVqdLsd+JjBzTn8BEu8gslXfBaYp1+Z+5hHVa
 0yvQFttpgzyuG6n2CTUv3km+JV257cgb0WhaZVeNXEwhZzYV4zQA8Hyi/h0uQZPwVSg8
 swwjFwumCwkGUV5yLL8OvQ6k3m7qyDDKcCjhD9uDGG5PhlDYCj4EEwzaV6KhCc+ApCta
 o+UwfE9NrSnX1ggBUqDiPMNDIUh+ey4+y3oxUAlrdhpA8GBDR1NGms6yEAnb6o/Zp4G7
 KmPgVRw4lcfptxOGDZ0R3RFTheK8gORbo/zYbrLeQbV2bqLBwg3SSyhM0Nu/9d1fGy4P pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34xtum3fbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 15:46:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AOFYuU3067460;
        Tue, 24 Nov 2020 15:44:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34yctwnebd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 15:44:18 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AOFiHtE022369;
        Tue, 24 Nov 2020 15:44:17 GMT
Received: from [10.154.96.46] (/10.154.96.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Nov 2020 07:44:16 -0800
Subject: Re: [PATCH] sparc64: Use arch_validate_flags() to validate ADI flag
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     jannh@google.com, hch@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, anthony.yznaga@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20201023175611.12819-1-khalid.aziz@oracle.com>
 <20201120180119.GM24344@gaia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <ab73559b-c8bf-dd8d-c959-72049dafe8fa@oracle.com>
Date:   Tue, 24 Nov 2020 08:44:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201120180119.GM24344@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9815 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/20 11:01 AM, Catalin Marinas wrote:
> Hi Khalid,
> 
> On Fri, Oct 23, 2020 at 11:56:11AM -0600, Khalid Aziz wrote:
>> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
>> index f94532f25db1..274217e7ed70 100644
>> --- a/arch/sparc/include/asm/mman.h
>> +++ b/arch/sparc/include/asm/mman.h
>> @@ -57,35 +57,39 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>>   {
>>   	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>>   		return 0;
>> -	if (prot & PROT_ADI) {
>> -		if (!adi_capable())
>> -			return 0;
>> +	return 1;
>> +}
> 
> We kept the equivalent of !adi_capable() check in the arm64
> arch_validate_prot() and left arch_validate_flags() more relaxed. I.e.
> you can pass PROT_MTE to mmap() even if the hardware doesn't support
> MTE. This is in line with the pre-MTE ABI where unknown mmap() flags
> would be ignored while mprotect() would reject them. This discrepancy
> isn't nice but we decided to preserve the pre-MTE mmap ABI behaviour.
> Anyway, it's up to you if you want to change the sparc behaviour, I
> don't think it matters in practice.

Hi Catalin,

Thanks for taking a look at this patch. I felt mmap() silently accepting 
PROT_ADI but not really enabling protection can be dangerous since it 
leads the end user to be under false impression that they have protected 
the memory. I chose to treat PROT_ADI as a known flag and provide a 
definite feedback to user whether it can be honored or not.

> 
> I think with this patch, arch_validate_prot() no longer needs the 'addr'
> argument. Maybe you can submit an additional patch to remove them (not
> urgent, the compiler should get rid of them).

Yes, 'addr' is an unused argument now. On the other hand, I suspect with 
additional protections being implemented in hardware for memory regions, 
sooner or later someone will see a need to validate protection bits in 
the context of memory region it is being applied to. Address is not 
going to be enough information though and we are most likely going to 
need size of the memory region being operated upon as well. That means 
this code is likely to need a patch to add the size argument. So it is 
reasonable to remove 'addr' for now and reintroduce a more complete 
version with size as well later in a patch when the need comes up.

> 
>>   
>> -		if (addr) {
>> -			struct vm_area_struct *vma;
>> +#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
>> +/* arch_validate_flags() - Ensure combination of flags is valid for a
>> + *	VMA.
>> + */
>> +static inline bool arch_validate_flags(unsigned long vm_flags)
>> +{
>> +	/* If ADI is being enabled on this VMA, check for ADI
>> +	 * capability on the platform and ensure VMA is suitable
>> +	 * for ADI
>> +	 */
>> +	if (vm_flags & VM_SPARC_ADI) {
>> +		if (!adi_capable())
>> +			return false;
>>   
>> -			vma = find_vma(current->mm, addr);
>> -			if (vma) {
>> -				/* ADI can not be enabled on PFN
>> -				 * mapped pages
>> -				 */
>> -				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> -					return 0;
>> +		/* ADI can not be enabled on PFN mapped pages */
>> +		if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> +			return false;
>>   
>> -				/* Mergeable pages can become unmergeable
>> -				 * if ADI is enabled on them even if they
>> -				 * have identical data on them. This can be
>> -				 * because ADI enabled pages with identical
>> -				 * data may still not have identical ADI
>> -				 * tags on them. Disallow ADI on mergeable
>> -				 * pages.
>> -				 */
>> -				if (vma->vm_flags & VM_MERGEABLE)
>> -					return 0;
>> -			}
>> -		}
>> +		/* Mergeable pages can become unmergeable
>> +		 * if ADI is enabled on them even if they
>> +		 * have identical data on them. This can be
>> +		 * because ADI enabled pages with identical
>> +		 * data may still not have identical ADI
>> +		 * tags on them. Disallow ADI on mergeable
>> +		 * pages.
>> +		 */
>> +		if (vm_flags & VM_MERGEABLE)
>> +			return false;
> 
> Ah, you added a check to the madvise(MADV_MERGEABLE) path to ignore the
> flag if VM_SPARC_ADI. On arm64 we intercept memcmp_pages() but we have a
> PG_arch_2 flag to mark a page as containing tags. Either way should
> work.
> 
> FWIW, if you are happy with the mmap() rejecting PROT_ADI on
> !adi_capable() hardware:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks!

--
Khalid
