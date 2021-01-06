Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D382EB8EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAFE3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbhAFE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:29:10 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209BC06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 20:28:30 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d8so1941069otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 20:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4Ulto7IACe774gBNuczGwTihUbi+yuPraCvym31RVe8=;
        b=gX6JofwDkHCipBd39spQoCL9/NJ14gzc9NXfD28gi4VSZLWveYuYoKOMyT0em7wqyu
         Ijpz0GyUpffXmDwPDSUT9r0pOfsj6zgfNwMogdZBP//0HYyvle9+8vdpa+D8/GXzS90y
         NSYB3e96ziokmfiFnBD+tKoONflpfliLpUdecbmAGwj+r0LYRPnJCZH775kk9rfTybiv
         B1fhCu5QgOu84V62gJXzRQAQtPU58EU5F7j0RPEVxDGGFnOc0QLluYS8r62zkoGDLkHA
         Dtx4gJeEKGc60JVlehnc1igWeLQAmJ5OSvGWD4gjnnW75tsPO+8ta0PHWmVjbb5j6PXZ
         x1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4Ulto7IACe774gBNuczGwTihUbi+yuPraCvym31RVe8=;
        b=NaurY7GvXqQnT95unhPKiqXcb3KZ+g9JhDeUbepDaKaKcHca8XHJ1kuYd/3xOT5DhE
         SVmvqOhh4X3TSffuN0AAzRJaINSjIDtMwemLOJdGKuvLmvDLVrkOyme+8LSBRdW6FiCr
         naYSJwrz4kk/hBqukjQ5TbCfpdjt2X9yJf4ZxRVcLKToYbPwdta5P4oQG2mGM23hFW7/
         AHLzP6sY3RqJeDAvmbA6/6gReDrzFT3Yb3tqtC0bH99VIzaKEBmZKqEK2uc4SmhB2CME
         BK5RSW94A2ztT2WdS/3TWm6XbQgX1HNI3ix1zATm9c+6mqXgW7Vutm9yW66XI7zehB7U
         FHvA==
X-Gm-Message-State: AOAM530QVMpY6ptm0JhPLOzRsUE963Ia2nwyTCJstVNbZP4RZHg08eD8
        l6rKNwptCCJbk69nl6P80L1nZA==
X-Google-Smtp-Source: ABdhPJy5ZaA0P/AM1c69wv19F/rB6DPkUfmJ7D6WkDkc9RVzsiADZ+ek5AjKBOPuFVOdOhc3ZrC/RA==
X-Received: by 2002:a9d:7746:: with SMTP id t6mr2027385otl.349.1609907309517;
        Tue, 05 Jan 2021 20:28:29 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i126sm373843oif.22.2021.01.05.20.28.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2021 20:28:29 -0800 (PST)
Date:   Tue, 5 Jan 2021 20:28:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Minchan Kim <minchan@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
In-Reply-To: <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com> <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com> <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Dec 2020, Alex Shi wrote:
> 
> I'm very sorry, a typo here. the patch should be updated:
> 
> From ed4fa1c6d5bed5766c5f0c35af0c597855d7be06 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Fri, 11 Dec 2020 21:26:46 +0800
> Subject: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
> 
> coccinelle reports some warnings:
> WARNING: Use BUG_ON instead of if condition followed by BUG.
> 
> It could be fixed by BUG_ON().
> 
> Reported-by: abaci@linux.alibaba.com
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

When diffing mmotm just now, I was sorry to find this: NAK.

Alex, please consider why the authors of these lines (whom you
did not Cc) chose to write them without BUG_ON(): it has always
been preferred practice to use BUG_ON() on predicates, but not on
functionally effective statements (sorry, I've forgotten the proper
term: I'd say statements with side-effects, but here they are not
just side-effects: they are their main purpose).

We prefer not to hide those away inside BUG macros: please fix your
"abaci" to respect kernel style here - unless it turns out that the
kernel has moved away from that, and it's me who's behind the times.

Andrew, if you agree, please drop
mm-mmap-replace-if-cond-bug-with-bug_on.patch
from your stack.

(And did Minchan really Ack it? I see an Ack from Minchan to a
similar mm/zsmalloc patch: which surprises me, but is Minchan's
business not mine; but that patch is not in mmotm.)

On the whole, I think there are far too many patches submitted,
where Developer B chooses to rewrite a line to their own preference,
without respecting that Author A chose to write it in another way.
That's great when it really does improve readability, but often not.

Thanks,
Hugh

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/mmap.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8144fc3c5a78..107fa91bb59f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -712,9 +712,8 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  	struct vm_area_struct *prev;
>  	struct rb_node **rb_link, *rb_parent;
>  
> -	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
> -			   &prev, &rb_link, &rb_parent))
> -		BUG();
> +	BUG_ON(find_vma_links(mm, vma->vm_start, vma->vm_end,
> +			   &prev, &rb_link, &rb_parent));
>  	__vma_link(mm, vma, prev, rb_link, rb_parent);
>  	mm->map_count++;
>  }
> @@ -3585,9 +3584,8 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
>  		 * can't change from under us thanks to the
>  		 * anon_vma->root->rwsem.
>  		 */
> -		if (__test_and_set_bit(0, (unsigned long *)
> -				       &anon_vma->root->rb_root.rb_root.rb_node))
> -			BUG();
> +		BUG_ON(__test_and_set_bit(0, (unsigned long *)
> +			&anon_vma->root->rb_root.rb_root.rb_node));
>  	}
>  }
>  
> @@ -3603,8 +3601,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
>  		 * mm_all_locks_mutex, there may be other cpus
>  		 * changing other bitflags in parallel to us.
>  		 */
> -		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
> -			BUG();
> +		BUG_ON(test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags));
>  		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
>  	}
>  }
> @@ -3701,9 +3698,8 @@ static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
>  		 * can't change from under us until we release the
>  		 * anon_vma->root->rwsem.
>  		 */
> -		if (!__test_and_clear_bit(0, (unsigned long *)
> -					  &anon_vma->root->rb_root.rb_root.rb_node))
> -			BUG();
> +		BUG_ON(!__test_and_clear_bit(0, (unsigned long *)
> +				&anon_vma->root->rb_root.rb_root.rb_node));
>  		anon_vma_unlock_write(anon_vma);
>  	}
>  }
> @@ -3716,9 +3712,7 @@ static void vm_unlock_mapping(struct address_space *mapping)
>  		 * because we hold the mm_all_locks_mutex.
>  		 */
>  		i_mmap_unlock_write(mapping);
> -		if (!test_and_clear_bit(AS_MM_ALL_LOCKS,
> -					&mapping->flags))
> -			BUG();
> +		BUG_ON(!test_and_clear_bit(AS_MM_ALL_LOCKS, &mapping->flags));
>  	}
>  }
>  
> -- 
> 2.29.GIT
