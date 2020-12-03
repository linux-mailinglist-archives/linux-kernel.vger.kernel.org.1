Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5202CDB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501872AbgLCQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:51:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8971 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgLCQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:51:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc917820000>; Thu, 03 Dec 2020 08:51:14 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 16:51:08 +0000
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com>
 <18c9ab89-185b-395a-97ce-31940388df0e@nvidia.com>
 <CA+CK2bBBcMKcCzQJDwEXgzTZKp7KezUAyPi2DOGX16K75dE7Qw@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c16c1b3e-0c99-19d7-6181-364a928472b1@nvidia.com>
Date:   Thu, 3 Dec 2020 08:51:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBBcMKcCzQJDwEXgzTZKp7KezUAyPi2DOGX16K75dE7Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607014274; bh=j9IsbDfnAl1qZX4VCgT+JSlCiNo07VX/EW3AlozOMXU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hSzd2Q4M3B5A8VY3+3PRm6nr0EEdF7f4dRpuF3yGwczoajchGNPF7U3Hlq7e+KFTu
         NixR+30OGDTFQQZzVYd8730A871Cg/AZ7CUY9vb4/aeM2QW8hov6sMs0ZJMnuG9pkX
         +XCZhgGGn3KIaSM49mpInJjdPS8T5j+V3xIRJTJJPM75gY1dJYiNzOoRHDoxbHNwxZ
         Vg0T7J4CIbCms8mMaCF+3WSnxYr2qVKsfV/fG0Mb90DjBeXMckT9Osgc1z2X0YQ6MO
         VledQ6ELgzQ54XirC88eq9Jmt3QMoaBmt2sHnUuQKWdhwrZSevREhZtrgSZZAaoF7V
         Tk45xlZejOzDg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 7:06 AM, Pavel Tatashin wrote:
...
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 611799c72da5..7a6d86d0bc5f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>>>        return alloc_flags;
>>>    }
>>>
>>> -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
>>> -                                     unsigned int alloc_flags)
>>> +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
>>> +                                        unsigned int alloc_flags)
>>
>> Actually, maybe the original name should be left intact. This handles current alloc
>> flags, which right now happen to only cover CMA flags, so the original name seems
>> accurate, right?
> 
> The reason I re-named it is because we do not access current context
> anymore, only use gfp_mask to get cma flag.
>>> -     unsigned int pflags = current->flags;
> 
> So, keeping "current" in the function name makes its intent misleading.
> 

OK, I see. That sounds OK then.


thanks,
-- 
John Hubbard
NVIDIA
