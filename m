Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3522DC866
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 22:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLPVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 16:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgLPVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:34:44 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D010BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 13:34:03 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x13so24822500oto.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 13:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=o88KyPTynQ/M7gHaSYlWVXP8ys/ZwMsEiw9/lGbHE+w=;
        b=EzKIjzY5CkBDpqjT3dg+1yeGZCtWF3U8uZkV/FBXjciz426YTa+65rMQmPuhnDauBr
         SHh6bRRGt76r5pZMw9VIxmPfttMTSKvjBxQwbDpoHNKTV7SWqeTB0t3n7NwYnSqZylnq
         eyqn7OVFEHUy9e3MOxC4M2fghF1F1bdQMFzk+AHMdtn+lAYUITEKbONrTCjXDLSL+iG3
         gI7CdmaEx9zSsbw7PnKCLDd0IXHBKUxuLkoJHAtMNe4ZNoSR/cOVNwN7Ig3aKaqfMyrX
         aVyekVUIhijDrlb+tMtJQZBaN4fz24D+xgZ/8Pz/G7i1j+qkW08LcCAGDMf01eUfyPu2
         rEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=o88KyPTynQ/M7gHaSYlWVXP8ys/ZwMsEiw9/lGbHE+w=;
        b=lgIb+1spmGhD1hQSbYoTwCTZopzpkUeE0FIyXhA0IENhTZcQtd1lY1jj0B4MTFoWe1
         vb8Ct9Aiz4yoVsP42U9+onND7TxVcTaLB63einl0yifOIY0RAxywNvxwogp9u/OdwyMs
         2Z/K/svs71D5vi50VlxRtdVv6BeiCwdfwd/c9S/vCp9TP0hkYDCxjzfn86I6Z7wrQ0h+
         O9+W2HRL7XPeOcrzpgtTxmbj/yKNyEJ5c/CCaMb7DuS30AWQAu5OOf78vQi0av1e7zTj
         q5/gWPDJK+mFLxSVnjGdoVG4l6ErQg4icU4g0SYFUxyq6ZjqbcP+AAV9vZVdfBeGRoWh
         gAZg==
X-Gm-Message-State: AOAM530OJoDczXrwuk56czJvNJlTbe2ZRJfYbmxr7Wd2mv+ABGrBxnx6
        zDIMBq7pXKXe09ju8E0SQzUxsA==
X-Google-Smtp-Source: ABdhPJxG1g59vv1553Sfvemmzx5/y/khG7e8nzE+jqwQv4/iy1uUqR/rX6bTMO2O411XV8TnZx82Hw==
X-Received: by 2002:a05:6830:2371:: with SMTP id r17mr27682534oth.236.1608154443016;
        Wed, 16 Dec 2020 13:34:03 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g200sm685161oib.19.2020.12.16.13.34.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2020 13:34:02 -0800 (PST)
Date:   Wed, 16 Dec 2020 13:33:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Salman Qazi <sqazi@google.com>
Subject: Re: [PATCH v2] mm/mmap: Don't unlock VMAs in remap_file_pages()
In-Reply-To: <20201216204252.vh3zadk4ghbzufqz@revolver>
Message-ID: <alpine.LSU.2.11.2012161330470.1455@eggly.anvils>
References: <20201215155441.1497432-1-Liam.Howlett@Oracle.com> <413ffbe0-959d-c2ad-95d8-80104adac089@redhat.com> <20201216204252.vh3zadk4ghbzufqz@revolver>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020, Liam R. Howlett wrote:
> 
> Thank you for looking at this.  I appreciate the scrutiny.
> 
> * David Hildenbrand <david@redhat.com> [201216 09:58]:
> > On 15.12.20 16:54, Liam R. Howlett wrote:
> > > do_mmap() will unlock the necessary VMAs.  There is also a bug in the
> > > loop which will evaluate as false and not unlock any VMAs anyways.
> > 
> > If there is a BUG, do we have a Fixes: tag? Also
> 
> The bug would never show up as it is masked by do_mmap() unlocking the
> necessary range.  Although there is a bug in this code, the code does
> not cause an issue as it won't execute so should I have a Fixes tag?
> The code works and what I've done is remove a chunk of code that never
> runs.
> 
> > 
> > 1. Can we fix the bug separately first?
> 
> I think it is safer to remove unexecuted code than enable it and then
> remove it.

Agreed.

> 
> > 2. Can we have a better description on what the bug actually is
> > "evaluate as false"? What is the result of the bug?
> 
> The bug is in the for loop test expression that I removed in the patch.
> Here is the long explaination of why the loop has never run.
> 
> 
> Line 2982: if (start + size <= start
> Line 2983: 	goto out;
> 
> size is positive.
> 
> Line 2992: vma = find_vma(mm, start);
> Look up the first VMA which satisfies start < vm_end
> 
> Line 2997: if (start < vma->vm_start)
> Line 2998: 	goto out;
> 
> So now vma->vm_start >= start.
> If vma->vm_start > start, then there are no VMAs in that area, otherwise
> it would have been returned by find_vma().
> So we can say that vma->vm_start == start.
> 
> Line 3033: for (tmp = vma; tmp->vm_start >= start + size;
> Line 3034:                 tmp = tmp->vm_next) {
> This is the for loop with the error in the test expression.
> 
> tmp->vm_start == start which cannot be >= (start + size).
> 
> I believe the intention was to loop through vmas in the range of start
> to (start + size) and unlock them.
> 
> 
> The result of the bug is no VMA is unlocked in this fuction.  But that
> doesn't matter as they are unlocked later in the call chain - which is
> why this code works as intended.

Yes.

> 
> 
> > 
> > CCing some people that might know if this is actually a sane change.
> > Skimming over do_mmap(), it's not immediately clear to me that
> > "do_mmap() will unlock the necessary VMAs".
> 
> Ah, yes.  That is understandable.
> 
> do_mmap() L1583 -> mmap_region() L1752 -> munmap_vma_range() ->
> do_munmap() -> __do_munmap() loop at 2891 to unlock the range.
> 
> Would you like me to add this call chain to the changelog?

I don't think you need to add that: do_mmap(MAP_FIXED) simply has to
be able to munlock the range, much else would be broken if it did not.

> 
> > 
> > > 
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Acked-by: Hugh Dickins <hughd@google.com>

This is indeed a sane change.  I stumbled over that mistaken code
back in the days of PageTeam shmem huge pages, when syzkaller hit
a VM_BUG_ON_PAGE because of it; deleted the block as you have in v2;
then it fell off our radar when updating to PageCompound huge pages -
when Salman noticed as you have that the loop was ineffectual anyway.
It's just good to delete this dead code and confusion.

Though, in the course of writing that paragraph, I have come to wonder:
how did syzkaller hit a VM_BUG_ON_PAGE in code that is never executed??
Was something else different back then, or are we overlooking a case?

But whatever, the block is redundant and your v2 patch is good.

> > > ---
> > >  mm/mmap.c | 18 +-----------------
> > >  1 file changed, 1 insertion(+), 17 deletions(-)
> > > 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 5c8b4485860de..f7fecb77f84fd 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> > >  
> > >  	flags &= MAP_NONBLOCK;
> > >  	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> > > -	if (vma->vm_flags & VM_LOCKED) {
> > > -		struct vm_area_struct *tmp;
> > > +	if (vma->vm_flags & VM_LOCKED)
> > >  		flags |= MAP_LOCKED;
> > >  
> > > -		/* drop PG_Mlocked flag for over-mapped range */
> > > -		for (tmp = vma; tmp->vm_start >= start + size;
>          This should probably be less than ---^
> 
> > > -				tmp = tmp->vm_next) {
> > > -			/*
> > > -			 * Split pmd and munlock page on the border
> > > -			 * of the range.
> > > -			 */
> > > -			vma_adjust_trans_huge(tmp, start, start + size, 0);
> > > -
> > > -			munlock_vma_pages_range(tmp,
> > > -					max(tmp->vm_start, start),
> > > -					min(tmp->vm_end, start + size));
> > > -		}
> > > -	}
> > > -
> > >  	file = get_file(vma->vm_file);
> > >  	ret = do_mmap(vma->vm_file, start, size,
> > >  			prot, flags, pgoff, &populate, NULL);
> > > 
> > 
> > 
> > -- 
> > Thanks,
> > 
> > David / dhildenb
