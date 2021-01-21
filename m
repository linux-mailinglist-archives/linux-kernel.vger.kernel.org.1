Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F342FECC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbhAUOSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:18:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728970AbhAUORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:17:13 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10LECCdm146756;
        Thu, 21 Jan 2021 09:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=LgIyQwq1hR6kmioYSRjLoABMPgvbuBjTa3lrYLfCtQ4=;
 b=fJwfGmHefCX3FmP6wIV3ex21TX9Na1Q9XENeaHgy1FpUtIs5J6QN9mI7LtR1+3EDr57t
 kdWH9aCeExw00mCIDLIBfM9yXL594itZfSSGX5HZDFPQ8r50WaWTNSx6NPBDJV3nFMY8
 VICDVVty9yQpn94cRviYncLgZiev+R1gr+cWepB/V4E/VVST/l54gYvRBUUg90+DOd5X
 OAoB2bB6OXgSDqMnswoHt6mfKUTRxHN2fn03SwnehULfTn1LqPZSvoXud7Ltqu7JlWNE
 WkAlE01bW1PBaYGp9J22faE9++Hpcg6pidlpActLL7Clisny3yIzGHbjxIjtRcNL0EPS hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 367b5mg32b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 09:16:17 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LEFv9N163729;
        Thu, 21 Jan 2021 09:16:17 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 367b5mg304-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 09:16:16 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10LEE1FD024969;
        Thu, 21 Jan 2021 14:16:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3668ny0w57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 14:16:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10LEGBsv43188588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 14:16:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A3611C04C;
        Thu, 21 Jan 2021 14:16:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B63111C050;
        Thu, 21 Jan 2021 14:16:09 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.173.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Jan 2021 14:16:09 +0000 (GMT)
Date:   Thu, 21 Jan 2021 16:16:07 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Message-ID: <20210121141607.GB7648@linux.ibm.com>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_06:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:29:13PM -0800, Sudarshan Rajagopalan wrote:
> memory_block_size_bytes() determines the memory hotplug granularity i.e the
> amount of memory which can be hot added or hot removed from the kernel. The
> generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
> for memory_block_size_bytes() on platforms like arm64 that does not override.
> 
> Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
> increases memory hotplug granularity, thus improving its agility. A reduced
> section size also reduces memory wastage in vmemmmap mapping for sections
> with large memory holes. So we try to set the least section size as possible.
> 
> A section size bits selection must follow:
> (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
> 
> CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and so just following it
> would help achieve the smallest section size.
> 
> SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> 
> SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
> SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
> SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
> SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
> SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP
> 
> But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
> much would over populate /sys/devices/system/memory/ and also consume too many
> page->flags bits in the !vmemmap case. Also section size needs to be multiple
> of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
> 
> Given these constraints, lets just reduce the section size to 128MB for 4K
> and 16K base page size configs, and to 512MB for 64K base page size config.
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

BTW, after reduction of the section size maybe arm64 should consider opting
out of freeing unused memory map.

This will make David even more happy as this will allow dropping custom
pfn_valid() ;-)

> ---
>  arch/arm64/include/asm/sparsemem.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..eb4a75d720ed 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,26 @@
>  
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> -#endif
> +
> +/*
> + * Section size must be at least 512MB for 64K base
> + * page size config. Otherwise it will be less than
> + * (MAX_ORDER - 1) and the build process will fail.
> + */
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define SECTION_SIZE_BITS 29
> +
> +#else
> +
> +/*
> + * Section size must be at least 128MB for 4K base
> + * page size config. Otherwise PMD based huge page
> + * entries could not be created for vmemmap mappings.
> + * 16K follows 4K for simplicity.
> + */
> +#define SECTION_SIZE_BITS 27
> +#endif /* CONFIG_ARM64_64K_PAGES */
> +
> +#endif /* CONFIG_SPARSEMEM*/
>  
>  #endif
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Sincerely yours,
Mike.
