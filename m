Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF92CD0B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgLCICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:02:18 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18413 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgLCICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:02:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc89b610000>; Thu, 03 Dec 2020 00:01:37 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 08:01:28 +0000
Subject: Re: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
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
 <20201202052330.474592-3-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2d383ee6-c5ab-48b6-3ccd-e32d211e01e3@nvidia.com>
Date:   Thu, 3 Dec 2020 00:01:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606982497; bh=c1Tc1OG4/I/r3ZS+i1ed5+AnAPKp5CQ+Qg1jawue+8c=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EzVNbehbvE3qNEc0OOEjfoujFjnOu8xH3LcP0/TZ5jun/kyBwOstVRqdjO5aVnKYm
         XbP0eLqahbs9nBp7PdsnNGtShwKYHIKtdCX2ggxPaoA0p9CJXD5JfSUa76Js0bYw0R
         tN02uxY+Gaqr0hdzXV/V2QPVmHmHqpxw9JVIYC7yg3rQZAyTyvsss/l8cMZfFgb1Vc
         H/Mc3v4PkvxxknFORKxcqE3TNF4UX3Lw9nTfaI0RLlIrcPfjYIkjyqBzJ+4clY7Ncv
         qX8D+FZC2XItbVFfNInfIxEF6Z0pFWNZAaAuo1gNy3T+j/I5TRy/gFlPhZJgtg4SAB
         7bHefGL0F5vKg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> In order not to fragment CMA the pinned pages are migrated. However,
> they are migrated to ZONE_MOVABLE, which also should not have pinned pages.
> 
> Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
> is allowed.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index cdb8b9eeb016..3a76c005a3e2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1610,7 +1610,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>   	long ret = nr_pages;
>   	struct migration_target_control mtc = {
>   		.nid = NUMA_NO_NODE,
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
>   	};
>   
>   check_again:
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

...while I was here, I noticed this, which is outside the scope of your patchset, but
I thought I'd just mention it anyway in case anyone cares:

static inline bool is_migrate_movable(int mt)
{
	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
}

...that really should take an "enum migratetype mt" instead of an int, I think.

thanks,
-- 
John Hubbard
NVIDIA
