Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3830D2C9E19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgLAJcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727744AbgLAJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606815052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxAP0pseEc/fzAjf0tBaAneqtXVx1hiX6RUzZ9uBk5E=;
        b=C4Dl4fq1UUeDEO0i7gAPhfxVWL2vIyQRpmWs5Phn4pQs2mmR9ntBnrdpHRR1Ova+N93vgm
        iPSjcWBS2wK9GY02nGZkUQWQ6TtH21WB7vsxOK9jcyZ9H0lPWs5wOdg+hcviDQ1hxLGumu
        kO0jmmemfvFWOH3GLnlswymtzT0Aja4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-STe-exarPCWFEk57_JlpZg-1; Tue, 01 Dec 2020 04:30:50 -0500
X-MC-Unique: STe-exarPCWFEk57_JlpZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04251100F341;
        Tue,  1 Dec 2020 09:30:49 +0000 (UTC)
Received: from [10.36.114.206] (ovpn-114-206.ams2.redhat.com [10.36.114.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8CF60BE5;
        Tue,  1 Dec 2020 09:30:43 +0000 (UTC)
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20201130230603.46187-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <956a2acb-7272-bcf8-dc88-dcd1856b28f2@redhat.com>
Date:   Tue, 1 Dec 2020 10:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130230603.46187-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.20 00:06, Peter Xu wrote:
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
> Cc: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> v2:
> - use userfaultfd_armed() directly [Mike]
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
>  mm/memory.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eeae590e526a..59b2be22565e 100644
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
> +	if (unlikely(userfaultfd_armed(vmf->vma)))
> +		return 0;
> +
>  	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
>  	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
>  
> 

Thanks for the clarifying comment.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

