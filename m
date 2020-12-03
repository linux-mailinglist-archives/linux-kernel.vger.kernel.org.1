Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6062CD0C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLCID6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:03:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18611 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgLCID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:03:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc89bc50000>; Thu, 03 Dec 2020 00:03:17 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 08:03:11 +0000
Subject: Re: [PATCH 3/6] mm/gup: make __gup_longterm_locked common
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-4-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ad473039-d5be-c0a5-3f68-dd87b0dd77ec@nvidia.com>
Date:   Thu, 3 Dec 2020 00:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606982597; bh=Vo2/dDhUo+zAUDkkaQyZUZa1C3Ei/RJHl3QQ0nBpBeQ=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=fwOtTrKs6mSMwDM+VKq21n3a8sIqq1l1c2VaftL0Nr4qXxSx1mci1th7pdqLEf7id
         wCHyu5ovMKDPH6l/MMLKY2PEruIDJAzylWfvvgUlwdEKAl9/srxjMxDjRbwxJkyifS
         XuWv8q8aUr3dr6RxUmaGqXXqGXU4Rd8xZ733Tjy/2jdYaGAtfKGCkluNboJV4V7wNT
         f7am0AXmRzr/cyQZxhMNvdEx0AFhGVV0C98bLiupV8XwTWCusyPVERFnuR5S9ad1pH
         wodX3xoGB16/G3/Fpg+tMx+0ZAcZd2rUoqYNc9xmmjhEbIu+j6uVy8lgXv6v6wPvcU
         DveVC8CPtNtxA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> __gup_longterm_locked() has CMA || FS_DAX version and a common stub
> version. In the preparation of prohibiting longterm pinning of pages from
> movable zone make the CMA || FS_DAX version common, and delete the stub
> version.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 3a76c005a3e2..0e2de888a8b0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1567,7 +1567,6 @@ struct page *get_dump_page(unsigned long addr)
>   }
>   #endif /* CONFIG_ELF_CORE */
>   
> -#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
>   #ifdef CONFIG_FS_DAX
>   static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>   {
> @@ -1757,18 +1756,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   		kfree(vmas_tmp);
>   	return rc;
>   }
> -#else /* !CONFIG_FS_DAX && !CONFIG_CMA */
> -static __always_inline long __gup_longterm_locked(struct mm_struct *mm,
> -						  unsigned long start,
> -						  unsigned long nr_pages,
> -						  struct page **pages,
> -						  struct vm_area_struct **vmas,
> -						  unsigned int flags)
> -{
> -	return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> -				       NULL, flags);
> -}
> -#endif /* CONFIG_FS_DAX || CONFIG_CMA */
>   
>   static bool is_valid_gup_flags(unsigned int gup_flags)
>   {
> 

At last some simplification here, yea!

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
