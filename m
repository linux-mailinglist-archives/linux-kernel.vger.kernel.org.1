Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9542CD0AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLCIAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:00:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1539 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:00:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc89ae90000>; Wed, 02 Dec 2020 23:59:37 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 07:59:30 +0000
Subject: Re: [PATCH 1/6] mm/gup: perform check_dax_vmas only when FS_DAX is
 enabled
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
 <20201202052330.474592-2-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <be8546cc-bad3-d47e-dae7-0daca69c699c@nvidia.com>
Date:   Wed, 2 Dec 2020 23:59:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606982377; bh=uipdsnFR3vsfE+3SRgmX/F8BCY4jFybcQkfThgPlIMI=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=TQIsGgED/40CjvuD1Xosm5duWI0sKLGdpiy19u6tW5tWagbDrXfi/Ei8goPG9fhKN
         G5yLRSnuq1t/tO8Nfgik3qFHLP42gN3z04pw2OrPPN1CbWLQWpYxEEiTaufj9/Mzr7
         j2m1iSNbtkOSy+ws7Dksfnkyp68j24af1+8FxLv6b81THzgguKOwZPCYcmwVDoCUoe
         Fkyo+nK8mHB3IJ+zhx/uVssUKgX0y5bGmiwhDNQtu+BbSiw4EdjjJbYFKdrWJB3/pn
         kdK0rBZc65SWbM6cUoJqKrD5VWIvG9Nq6daLl2iWKlAZSjxqUY5rzLxG7u8g1qyKAJ
         K1sOoC8oiQDGA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> There is no need to check_dax_vmas() and run through the npage loop of
> pinned pages if FS_DAX is not enabled.
> 
> Add a stub check_dax_vmas() function for no-FS_DAX case.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98eb8e6d2609..cdb8b9eeb016 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1568,6 +1568,7 @@ struct page *get_dump_page(unsigned long addr)
>   #endif /* CONFIG_ELF_CORE */
>   
>   #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
> +#ifdef CONFIG_FS_DAX
>   static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>   {
>   	long i;
> @@ -1586,6 +1587,12 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>   	}
>   	return false;
>   }
> +#else
> +static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> +{
> +	return false;
> +}
> +#endif
>   
>   #ifdef CONFIG_CMA
>   static long check_and_migrate_cma_pages(struct mm_struct *mm,
> 

Looks obviously correct, and the follow-up simplication is very nice.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
