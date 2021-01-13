Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFC2F4D02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAMOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:21:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbhAMOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:21:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DEE8GH053740;
        Wed, 13 Jan 2021 14:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RGPaz4Vdqhcc8GSVVDndXOs8WP2TTNK2O88OMjMKQv0=;
 b=brf1g+KAH5ynOn8pP+LojSm7qwjLkF+NjFH6iXj5FAKt8Np214Q5EuVsJ36HrV53/Ou1
 3iJc82UkVE1eZKCWsBUleXkArD3TTtpsQBHo4mfimPIWd3egNMWxZj9W9hDqF75G6RHe
 tOS3XTH7//4XI5DODFKDjvJaZLMu2xYRVN4c1mUOrtuGooKfpA23W6QwmjHHVaQ9uDjV
 ReAlWaNzXFxzVENlubk/SarWyFOp+1ZALXLqwpOe84W2BRclzRnBadeiyKxiQvg5dHLU
 GbbdMGTsp/y56OWLXztRIGhjA2AeYPRlIghJuhBUN8DX29vdfI/ICA8BK1h/XMakCL5s jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyun6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 14:20:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DEK9xH113899;
        Wed, 13 Jan 2021 14:20:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kf0p05r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 14:20:46 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10DEKbXb014068;
        Wed, 13 Jan 2021 14:20:37 GMT
Received: from revolver (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 06:20:37 -0800
Date:   Wed, 13 Jan 2021 09:20:33 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 14/70] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-ID: <20210113142022.rbxbb77saxioednq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
 <20210112161240.2024684-15-Liam.Howlett@Oracle.com>
 <c02c31eb-7063-510f-2c2d-8d18a6bb5eee@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02c31eb-7063-510f-2c2d-8d18a6bb5eee@infradead.org>
User-Agent: NeoMutt/20200320
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [210112 16:23]:
> Hi--
> 
> On 1/12/21 8:11 AM, Liam R. Howlett wrote:
> > Avoid allocating a new VMA when it is not necessary.  Expand or contract
> > the existing VMA instead.  This avoids unnecessary tree manipulations
> > and allocations.
> > 
> > Once the VMA is known, use it directly when populating to avoid
> > unnecessary lookup work.
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 299 +++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 237 insertions(+), 62 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index a2b32202191d6..f500d5e490f1c 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> 
> 
> 
> > @@ -2022,8 +2068,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> >  EXPORT_SYMBOL(get_unmapped_area);
> >  
> >  /**
> > - * find_vma() - Find the VMA for a given address, or the next vma.  May return
> > - * NULL in the case of no vma at addr or above
> > + * find_vma() - Find the VMA for a given address, or the next vma.
> >   * @mm The mm_struct to check
> 
>     * @mm: ...

Ack

> 
> >   * @addr: The address
> >   *
> > @@ -2777,16 +2825,102 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> >  }
> >  
> >  /*
> > - *  this is really a simplified "do_mmap".  it only handles
> > - *  anonymous maps.  eventually we may be able to do some
> > - *  brk-specific accounting here.
> > + * bkr_munmap() - Unmap a parital vma.
> > + * @mas: The maple tree state.
> > + * @vma: The vma to be modified
> > + * @newbrk: the start of the address to unmap
> > + * @oldbrk: The end of the address to unmap
> 
> missing:
>  * @uf: ...

Thanks, yes.  I will add the user fault.

> 
> > + *
> > + * Returns: 0 on success.
> > + * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
> > + * possible.
> >   */
> > -static int do_brk_flags(unsigned long addr, unsigned long len,
> > -			unsigned long flags, struct list_head *uf)
> > +static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> > +			 unsigned long newbrk, unsigned long oldbrk,
> > +			 struct list_head *uf)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct vm_area_struct unmap;
> > +	unsigned long unmap_pages;
> > +	int ret = 1;
> > +
> > +	arch_unmap(mm, newbrk, oldbrk);
> > +
> > +	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
> > +		mas_set(mas, newbrk);
> > +		if (vma->vm_start != newbrk)
> > +			mas_reset(mas); // cause a re-walk for the first overlap.
> > +		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
> > +		goto munmap_full_vma;
> > +	}
> > +
> > +	vma_init(&unmap, mm);
> > +	unmap.vm_start = newbrk;
> > +	unmap.vm_end = oldbrk;
> > +	ret = userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
> > +	if (ret)
> > +		return ret;
> > +	ret = 1;
> > +
> > +	// Change the oldbrk of vma to the newbrk of the munmap area
> > +	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
> > +	if (vma->anon_vma) {
> > +		anon_vma_lock_write(vma->anon_vma);
> > +		anon_vma_interval_tree_pre_update_vma(vma);
> > +	}
> > +
> > +	vma->vm_end = newbrk;
> > +	if (vma_mas_remove(&unmap, mas))
> > +		goto mas_store_fail;
> > +
> > +	vmacache_invalidate(vma->vm_mm);
> > +	if (vma->anon_vma) {
> > +		anon_vma_interval_tree_post_update_vma(vma);
> > +		anon_vma_unlock_write(vma->anon_vma);
> > +	}
> > +
> > +	unmap_pages = vma_pages(&unmap);
> > +	if (unmap.vm_flags & VM_LOCKED) {
> > +		mm->locked_vm -= unmap_pages;
> > +		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
> > +	}
> > +
> > +	mmap_write_downgrade(mm);
> > +	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
> > +	/* Statistics */
> > +	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
> > +	if (unmap.vm_flags & VM_ACCOUNT)
> > +		vm_unacct_memory(unmap_pages);
> > +
> > +munmap_full_vma:
> > +	validate_mm_mt(mm);
> > +	return ret;
> > +
> > +mas_store_fail:
> > +	vma->vm_end = oldbrk;
> > +	anon_vma_interval_tree_post_update_vma(vma);
> > +	anon_vma_unlock_write(vma->anon_vma);
> > +	return -ENOMEM;
> > +}
> > +
> > +/*
> > + * do_brk_flags() - Increase the brk vma if the flags match.
> > + * @mas: The maple tree state.
> > + * @addr: The start address
> > + * @len: The length of the increase
> > + * @vma: The vma,
> 
> s/@vma/@brkvma/ ??

yes, sorry.  I tried to clarify the name in a later revision.


> 
> > + * @flags: The VMA Flags
> > + *
> > + * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
> > + * do not match then create a new anonymous VMA.  Eventually we may be able to
> > + * do some brk-specific accounting here.
> > + */
> > +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
> > +			unsigned long addr, unsigned long len,
> > +			unsigned long flags)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > -	struct vm_area_struct *vma, *prev;
> > -	pgoff_t pgoff = addr >> PAGE_SHIFT;
> > +	struct vm_area_struct *prev = NULL, *vma;
> >  	int error;
> >  	unsigned long mapped_addr;
> >  	validate_mm_mt(mm);
> 
> 
> 
> 

Thank you for looking at this.  I will fix all the issues you have
pointed out across the three emails.

Thanks,
Liam

