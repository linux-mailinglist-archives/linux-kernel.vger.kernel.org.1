Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4427036A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIRRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:32:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52542C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:32:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so5735166qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4SHX8ZGuaYD1hlaYnDwv8nOImxVEtLmZ4RlTLJzVllI=;
        b=DXyd84b9tLaGrB4gNv577QgaA2UEGN9f76+VBoioPCpqFZrA1vtmpasfNBrIwyIpPR
         +xTH+Fncct+vo09n0IoGNR7h6M1DnxAU/5ubdCirRudrXixSm394W565PEnCzvqdClQP
         PQVFRHjfBenbmiO5Oci48HhWnK25c71eE8lvOdEc0GUtUVkEay6RU7kcmZd2SnIuFW0u
         Uc9QdFnkZRKMvhViKC5b+dsb0/PSPaG/jdotVCTE8k3pLbSwCUtNmO4ub6ty/RKbbkwO
         DUsfTKrpyEZpE/8gbcWFSqHuhbDj64q7zp/tPtMOnKnNO33iDlqkx4VtTBcXvjWizx7F
         y79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SHX8ZGuaYD1hlaYnDwv8nOImxVEtLmZ4RlTLJzVllI=;
        b=YBiIUOKq8ebXRFFAIBydaxVAqTLEyj+22qD4AQf0J/MCUwJZ0BCy0tgtkwW7vu4XNB
         jCwluz5taYy4ueIIHx3ksI0HIhEajWZKEG++v9wLRW6t00QEEnc8D2aEAJ52Knuzjc7w
         YTazODOe1yZ+PrkOuqupuKWlox0mN78MwOCj6UQB9Ac3JB8ksaT5fOchz9q8PiNHYLfM
         8O9uifM+NYP5oF8FMXSgWs9QYsfEhlPgUNiucIUsLMnkY2o6UC6+bNj1UnNRlVYOwOjH
         yJJ/pjGEFuMKYk1XPhTNCv9cxD6+RL277iis7kW7G7tUT0/IgOOXmG4GhtrNuCPotFNZ
         Mw4w==
X-Gm-Message-State: AOAM5336j1VD+GZdfxZe0DRIEjoZvdrbOVChfFuzMc9dKg769x68L+Ni
        jGDoypzmtcbG2TsmWFr1FfxjFQ==
X-Google-Smtp-Source: ABdhPJy1EghOjmGTy4zwKfrhXOoAlnPZeyZoQg0CO2kHuuN4l8luV+ouemaxqX22fG23hXRIgRBzZQ==
X-Received: by 2002:ac8:4e24:: with SMTP id d4mr32426996qtw.28.1600450361361;
        Fri, 18 Sep 2020 10:32:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v2sm2480550qkv.26.2020.09.18.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:32:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJKFU-001VZl-2n; Fri, 18 Sep 2020 14:32:40 -0300
Date:   Fri, 18 Sep 2020 14:32:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200918173240.GY8409@ziepe.ca>
References: <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918164032.GA5962@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:40:32PM -0400, Peter Xu wrote:

> Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
> as long as FOLL_GUP is called once.  It's never reset after set.

Worth thinking about also adding FOLL_LONGTERM here, at last as long
as it is not a counter. That further limits the impact.

> One more thing (I think) we need to do is to pass the new vma from
> copy_page_range() down into the end because if we want to start cow during
> fork() then we need to operate on that new vma too when new page linked to it
> rather than the parent's.

Makes sense to me

> One issue is when we charge for cgroup we probably can't do that onto the new
> mm/task, since copy_namespaces() is called after copy_mm().  I don't know
> enough about cgroup, I thought the child will inherit the parent's, but I'm not
> sure.  Or, can we change that order of copy_namespaces() && copy_mm()?  I don't
> see a problem so far but I'd like to ask first..

Know nothing about cgroups, but I would have guessed that the page
table allocations would want to be in the cgroup too, is the struct
page a different bucket?

> The other thing is on how to fail.  E.g., when COW failed due to either
> charging of cgroup or ENOMEM, ideally we should fail fork() too.  Though that
> might need more changes - current patch silently kept the shared page for
> simplicity.

I didn't notice anything tricky here.. Something a bit gross but
simple seemed workable:

@@ -852,7 +852,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			continue;
 		}
 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-							vma, addr, rss);
+							vma, addr, rss, &err);
 		if (entry.val)
 			break;
 		progress += 8;
@@ -865,6 +865,9 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
 	cond_resched();
 
+	if (err)
+		return err;
+
 	if (entry.val) {
 		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
 			return -ENOMEM;

It is not really any different from add_swap_count_continuation()
failure, which already works..

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 496c3ff97cce..b3812fa6383f 100644
> +++ b/include/linux/mm_types.h
> @@ -458,6 +458,7 @@ struct mm_struct {
>  
>  		unsigned long total_vm;	   /* Total pages mapped */
>  		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
> +		unsigned long has_pinned;  /* Whether this mm has pinned any page */

Can be unsigned int or smaller, if there is a better hole in mm_struct

> diff --git a/mm/gup.c b/mm/gup.c
> index e5739a1974d5..cab10cefefe4 100644
> +++ b/mm/gup.c
> @@ -1255,6 +1255,17 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>  		BUG_ON(*locked != 1);
>  	}
>  
> +	/*
> +	 * Mark the mm struct if there's any page pinning attempt.  We're
> +	 * aggresive on this bit since even if the pinned pages were unpinned
> +	 * later on, we'll still keep this bit set for this address space just
> +	 * to make everything easy.
> +	 *
> +	 * TODO: Ideally we can use mm->pinned_vm but only until it's stable.
> +	 */
> +	if (flags & FOLL_PIN)
> +		WRITE_ONCE(mm->has_pinned, 1);

This should probably be its own commit, here is a stab at a commit
message:

Reduce the chance of false positive from page_maybe_dma_pinned() by
keeping track if the mm_struct has ever been used with
pin_user_pages(). mm_structs that have never been passed to
pin_user_pages() cannot have a positive page_maybe_dma_pinned() by
definition. This allows cases that might drive up the page ref_count
to avoid any penalty from handling dma_pinned pages.

Due to complexities with unpining this trivial version is a permanent
sticky bit, future work will be needed to make this a counter.

> +/*
> + * Do early cow for the page and the pte. Return true if page duplicate
> + * succeeded, false otherwise.
> + */
> +static bool duplicate_page(struct mm_struct *mm, struct vm_area_struct *vma,

Suggest calling 'vma' 'new' here for consistency

> +			   unsigned long address, struct page *page,
> +			   pte_t *newpte)
> +{
> +       struct page *new_page;
> +       pte_t entry;
> +
> +       new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
> +       if (!new_page)
> +               return false;
> +
> +       copy_user_highpage(new_page, page, address, vma);
> +       if (mem_cgroup_charge(new_page, mm, GFP_KERNEL)) {
> +	       put_page(new_page);
> +	       return false;
> +       }
> +       cgroup_throttle_swaprate(new_page, GFP_KERNEL);
> +       __SetPageUptodate(new_page);

It looks like these GFP flags can't be GFP_KERNEL, this is called
inside the pte_alloc_map_lock() which is a spinlock

One thought is to lift this logic out to around
add_swap_count_continuation()? Would need some serious rework to be
able to store the dst_pte though.

Can't help about the cgroup question

Jason
