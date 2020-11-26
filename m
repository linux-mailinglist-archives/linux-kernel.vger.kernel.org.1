Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2F2C5A61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbgKZRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:18:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:53382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391658AbgKZRSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:18:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9506AC2D;
        Thu, 26 Nov 2020 17:18:30 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm,thp,shmem: make khugepaged obey tmpfs mount flags
To:     Rik van Riel <riel@surriel.com>, hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, mhocko@suse.com
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-4-riel@surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <eda496c8-e248-c8fe-e7bd-f7e71d20e499@suse.cz>
Date:   Thu, 26 Nov 2020 18:18:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124194925.623931-4-riel@surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 8:49 PM, Rik van Riel wrote:
> Currently if thp enabled=[madvise], mounting a tmpfs filesystem
> with huge=always and mmapping files from that tmpfs does not
> result in khugepaged collapsing those mappings, despite the
> mount flag indicating that it should.
> 
> Fix that by breaking up the blocks of tests in hugepage_vma_check
> a little bit, and testing things in the correct order.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Fixes: c2231020ea7b ("mm: thp: register mm for khugepaged when merging vma for shmem")

Looks ok. But, it we have sysfs thp enabled=never, and shmem mount explicitly 
thp enabled, then shmem mount overrides the global sysfs setting and thp's will 
be allocated there, right? However, khugepaged_enabled() will be false and thus 
khugepaged won't run at all? So a similar situation than what you're fixing here.

> ---
>   include/linux/khugepaged.h |  2 ++
>   mm/khugepaged.c            | 22 ++++++++++++++++------
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index c941b7377321..2fcc01891b47 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -3,6 +3,7 @@
>   #define _LINUX_KHUGEPAGED_H
>   
>   #include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
> +#include <linux/shmem_fs.h>
>   
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -57,6 +58,7 @@ static inline int khugepaged_enter(struct vm_area_struct *vma,
>   {
>   	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
>   		if ((khugepaged_always() ||
> +		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
>   		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
>   		    !(vm_flags & VM_NOHUGEPAGE) &&
>   		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4e3dff13eb70..abab394c4206 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -440,18 +440,28 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
>   static bool hugepage_vma_check(struct vm_area_struct *vma,
>   			       unsigned long vm_flags)
>   {
> -	if ((!(vm_flags & VM_HUGEPAGE) && !khugepaged_always()) ||
> -	    (vm_flags & VM_NOHUGEPAGE) ||
> +	/* Explicitly disabled through madvise. */
> +	if ((vm_flags & VM_NOHUGEPAGE) ||
>   	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>   		return false;
>   
> -	if (shmem_file(vma->vm_file) ||
> -	    (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> -	     vma->vm_file &&
> -	     (vm_flags & VM_DENYWRITE))) {
> +	/* Enabled via shmem mount options or sysfs settings. */
> +	if (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) {
>   		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>   				HPAGE_PMD_NR);
>   	}
> +
> +	/* THP settings require madvise. */
> +	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> +		return false;
> +
> +	/* Read-only file mappings need to be aligned for THP to work. */
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> +	    (vm_flags & VM_DENYWRITE)) {
> +		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> +				HPAGE_PMD_NR);
> +	}
> +
>   	if (!vma->anon_vma || vma->vm_ops)
>   		return false;
>   	if (vma_is_temporary_stack(vma))
> 

