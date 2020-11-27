Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30C72C60C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgK0IQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:16:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgK0IQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:16:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AR7sfCQ181368;
        Fri, 27 Nov 2020 03:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vgymwzag5zA2fKbiNo8dCMHEWOwdEsBiUd4m3WTddlM=;
 b=gvKrQcqglEtczT94oIXTY8qfMEqNHPxG90v+zRBo0I74++dvkYlVQiIh2KA3dW1cR9N6
 KDHI+hISEt/aLF69+D70pYZsgG0aiuWlR1jb69kc/8+vFBCKHfWaoSDdXhbHNNZaeWvf
 R7HkcVWFdxRHXCXjnR4d3eb2yydUBYhHvAfIbX0sUtbBRxkAnPi/v09ZxqKjCJIWwH8r
 0HVm5uU9LSe5CjNB+6a9goXEiAw3eK8yXIjyWXJ/tyYQiiPlUusM4WS0z1qBQQfYLRKb
 RpYlzGWap0CdTlXEH1UaLc0+PW2JGIO4VorUZRBbELYsqFNtmywOAY7Vld4/3wx5vhJB dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352971vs8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 03:16:13 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AR7tc0d185781;
        Fri, 27 Nov 2020 03:16:13 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352971vs7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 03:16:13 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AR86C62028519;
        Fri, 27 Nov 2020 08:16:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8edes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:16:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AR8G8Pe8979118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Nov 2020 08:16:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73D6F11C069;
        Fri, 27 Nov 2020 08:16:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD55211C04C;
        Fri, 27 Nov 2020 08:16:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 27 Nov 2020 08:16:07 +0000 (GMT)
Date:   Fri, 27 Nov 2020 10:16:05 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201127081605.GX123287@linux.ibm.com>
References: <20201126222359.8120-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126222359.8120-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_04:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=1 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> Faulting around for reads are in most cases helpful for the performance so that
> continuous memory accesses may avoid another trip of page fault.  However it
> may not always work as expected.
> 
> For example, userfaultfd registered regions may not be the best candidate for
> pre-faults around the reads.
> 
> For missing mode uffds, fault around does not help because if the page cache
> existed, then the page should be there already.  If the page cache is not
> there, nothing else we can do, either.  If the fault-around code is destined to
> be helpless for userfault-missing vmas, then ideally we can skip it.
> 
> For wr-protected mode uffds, errornously fault in those pages around could lead
> to threads accessing the pages without uffd server's awareness.  For example,
> when punching holes on uffd-wp registered shmem regions, we'll first try to
> unmap all the pages before evicting the page cache but without locking the
> page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> before shmem_truncate_range()).  When fault-around happens near a hole being
> punched, we might errornously fault in the "holes" right before it will be
> punched.  Then there's a small window before the page cache was finally
> dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> page can be writable within the small window).  That's severe data loss.
> 
> Let's grant the userspace full control of the uffd-registered ranges, rather
> than trying to do the tricks.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

One nit below, except that

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> Note that since no file-backed uffd-wp support is there yet upstream, so the
> uffd-wp check is actually not really functioning.  However since we have all
> the necessary uffd-wp concepts already upstream, maybe it's better to do it
> once and for all.
> 
> This patch comes from debugging a data loss issue when working on the uffd-wp
> support on shmem/hugetlbfs.  I posted this out for early review and comments,
> but also because it should already start to benefit missing mode userfaultfd to
> avoid trying to fault around on reads.
> ---
>  include/linux/userfaultfd_k.h |  5 +++++
>  mm/memory.c                   | 17 +++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a8e5f3ea9bb2..451d99bb3a1a 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -62,6 +62,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_WP;
>  }
> 
> +static inline bool vma_registered_userfaultfd(struct vm_area_struct *vma)
> +{
> +	return userfaultfd_missing(vma) || userfaultfd_wp(vma);
> +}

We have userfaultfd_armed() that does exectly this, don't we?

> +
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
>  				      pte_t pte)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index eeae590e526a..ca58ada94c96 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3933,6 +3933,23 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
>  	int off;
>  	vm_fault_t ret = 0;
> 
> +	/*
> +	 * Be extremely careful with uffd-armed regions.
> +	 *
> +	 * For missing mode uffds, fault around does not help because if the
> +	 * page cache existed, then the page should be there already.  If the
> +	 * page cache is not there, nothing else we can do either.
> +	 *
> +	 * For wr-protected mode uffds, errornously fault in those pages around
> +	 * could lead to threads accessing the pages without uffd server's
> +	 * awareness, finally it could cause ghostly data corruption.
> +	 *
> +	 * The idea is that, every single page of uffd regions should be
> +	 * governed by the userspace on which page to fault in.
> +	 */
> +	if (unlikely(vma_registered_userfaultfd(vmf->vma)))
> +		return 0;
> +
>  	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
>  	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
> 
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
