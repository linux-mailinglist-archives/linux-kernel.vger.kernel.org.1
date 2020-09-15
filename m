Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17A26B30E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgIOW7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbgIOPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600182349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efBNWTa9y7/FOXTfe7lL5eY9jKBFY/REZvNQ5CeJVhk=;
        b=Q3qp7HroIcuytHWGxU2RjqP7EhFf1pyNkWB7fnmsQBz6+J0nHsvTZWpX8P0R5/SGXlRiKl
        IQvdUWfUTMs3tJyZOf7aagvBmew5e8qNkkdRvfK3q65C/XOrO3B57ErRGIAMJFi3GyIS0B
        +Px6maEQTh92Co8To0ObLGiyF5TMHGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-BOTlNFqZOl-FFHGdBO-jKA-1; Tue, 15 Sep 2020 11:05:47 -0400
X-MC-Unique: BOTlNFqZOl-FFHGdBO-jKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4AFCD042;
        Tue, 15 Sep 2020 15:03:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id 72F995DC08;
        Tue, 15 Sep 2020 15:03:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Sep 2020 17:03:54 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:03:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200915150349.GA22415@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821234958.7896-2-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21, Peter Xu wrote:
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2927,50 +2927,25 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	 * not dirty accountable.
>  	 */
>  	if (PageAnon(vmf->page)) {
> -		int total_map_swapcount;
> -		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
> -					   page_count(vmf->page) != 1))
> +		struct page *page = vmf->page;
> +
> +		/* PageKsm() doesn't necessarily raise the page refcount */
> +		if (PageKsm(page) || page_count(page) != 1)
> +			goto copy;
> +		if (!trylock_page(page))
> +			goto copy;
> +		if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +			unlock_page(page);
>  			goto copy;
> -		if (!trylock_page(vmf->page)) {
> -			get_page(vmf->page);
> -			pte_unmap_unlock(vmf->pte, vmf->ptl);
> -			lock_page(vmf->page);
> -			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -					vmf->address, &vmf->ptl);
> -			if (!pte_same(*vmf->pte, vmf->orig_pte)) {
> -				update_mmu_tlb(vma, vmf->address, vmf->pte);
> -				unlock_page(vmf->page);
> -				pte_unmap_unlock(vmf->pte, vmf->ptl);
> -				put_page(vmf->page);
> -				return 0;
> -			}
> -			put_page(vmf->page);
> -		}
> -		if (PageKsm(vmf->page)) {
> -			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
> -						     vmf->address);
> -			unlock_page(vmf->page);
> -			if (!reused)
> -				goto copy;
> -			wp_page_reuse(vmf);
> -			return VM_FAULT_WRITE;
> -		}
> -		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {

It seems that nobody else calls reuse_swap_page() with total_map_swapcount != NULL.

Oleg.

