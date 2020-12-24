Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBE2E2422
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgLXEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLXEFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:05:54 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:05:13 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b24so954833otj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=794qtNLBV01wH3kQUA1H50hyCeBN4AhD4eZP1owPmp4=;
        b=j1iWYJ4OoWkTSKGPyvK/vgdTSKX1fAMT3ed1oGlj0mNTY+Mdfoi+Jv3ez6lQwjqZKu
         k+0mnVBsW3gUfQGs3JEdL9vf3JSCAW8Tst41xH9w5DtQsmLhuhe5/OhVyjTesZmc63er
         OlYRS7B3glkt+fkOrspC2/M+BMiKSKhjnbOM38n4jZv2cxQA3C6wznsnuFR5mro4JOSm
         D0jWu9EG2UkQue4rxOEpBLfIAuXkUMRuWKL6fTmVlwVCnZ9i1FcTshST+OuDmfkCDtbZ
         X2LJYxeUtIEAVEk571Q+/YBUOHKN02nPPCKpZAiSojkl7OFGXZSmWkBjbonTJZ1hMcaF
         GbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=794qtNLBV01wH3kQUA1H50hyCeBN4AhD4eZP1owPmp4=;
        b=cx2Ph+m50rgLuozrYPCvDSP3g3mFkRquZ2lsjzVN0Tr2mFQFwOOlMlH5qeY458wl1v
         eGRuJDU2EMe20qIbWBhY9r+sVRK99M4nZv8uIpIaxCp0KcPY3iQCEc126/JnvaIsmOkO
         hSiQP9WdEOGdgyiMN73NrwLcT1Ue3NgQDS5rTO/PCCIPuq/9HzNmCnXh1lAJroJtyNr/
         YDtZAIaQFBLkTycOQL45MDagjVK7Rmh70HV1tyI59PJovxNanFbOJflWfURo7HZou+mV
         ML9yndA7NjIGRovviG1aXwPcD5nNA2gYD/Pb6v8CJnoHaK5FHCuYYmWlmoWjCYwSet5Q
         7D4Q==
X-Gm-Message-State: AOAM530iZEHDtl6y6pipiyPSNRKcRqLlol+FqYDmDF0JveMWL9nNoUFO
        uvmmgVjf3YLBo1Mu2wcmi/YpFQ==
X-Google-Smtp-Source: ABdhPJzgNgkJw45qnykrLy8Ni/F5/+cU+fKpbDKpXRyEFgvhAXYmMwR7eRVUvoJVv84wfVfHFXfSWg==
X-Received: by 2002:a9d:650f:: with SMTP id i15mr20667065otl.347.1608782713166;
        Wed, 23 Dec 2020 20:05:13 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u141sm6325608oie.46.2020.12.23.20.05.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2020 20:05:12 -0800 (PST)
Date:   Wed, 23 Dec 2020 20:04:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
In-Reply-To: <20201222100047.p5zdb4ghagncq2oe@box>
Message-ID: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
References: <20201214160724.ewhjqoi32chheone@box> <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com> <20201216170703.o5lpsnjfmoj7f3ml@box> <CAHk-=wiVRMADHC0qjTFAVx2Pp0DN-fT-VPC10boDdX0O4=h01w@mail.gmail.com> <20201217105409.2gacwgg7rco2ft3m@box>
 <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com> <20201218110400.yve45r3zsv7qgfa3@box> <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com> <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020, Kirill A. Shutemov wrote:
> 
> Updated patch is below.
> 
> From 0ec1bc1fe95587350ac4f4c866d6482383740b36 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Sat, 19 Dec 2020 15:19:23 +0300
> Subject: [PATCH] mm: Cleanup faultaround and finish_fault() codepaths
> 
> alloc_set_pte() has two users with different requirements: in the
> faultaround code, it called from an atomic context and PTE page table
> has to be preallocated. finish_fault() can sleep and allocate page table
> as needed.
> 
> PTL locking rules are also strange, hard to follow and overkill for
> finish_fault().
> 
> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> explicit.
> 
> The price is some code duplication to handle huge pages in faultaround
> path, but it should be fine, having overall improvement in readability.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

It's not ready yet.

I won't pretend to have reviewed, but I did try applying and running
with it: mostly it seems to work fine, but turned out to be leaking
huge pages (with vmstat's thp_split_page_failed growing bigger and
bigger as page reclaim cannot get rid of them).

Aside from the actual bug, filemap_map_pmd() seems suboptimal at
present: comments below (plus one comment in do_anonymous_page()).

> diff --git a/mm/filemap.c b/mm/filemap.c
> index 0b2067b3c328..f8fdbe079375 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2831,10 +2832,74 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  }
>  EXPORT_SYMBOL(filemap_fault);
>  
> +static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page,
> +				  struct xa_state *xas)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +
> +	/* Huge page is mapped? No need to proceed. */
> +	if (pmd_trans_huge(*vmf->pmd))
> +		return true;
> +
> +	if (xa_is_value(page))
> +		goto nohuge;

I think it would be easier to follow if filemap_map_pages() never
passed this an xa_is_value(page): probably just skip them in its
initial xas_next_entry() loop.

> +
> +	if (!pmd_none(*vmf->pmd))
> +		goto nohuge;

Then at nohuge it unconditionally takes pmd_lock(), finds !pmd_none,
and unlocks again: unnecessary overhead I believe we did not have before.

> +
> +	if (!PageTransHuge(page) || PageLocked(page))
> +		goto nohuge;

So if PageTransHuge, but someone else temporarily holds PageLocked,
we insert a page table at nohuge, sadly preventing it from being
mapped here later by huge pmd.

> +
> +	if (!page_cache_get_speculative(page))
> +		goto nohuge;
> +
> +	if (page != xas_reload(xas))
> +		goto unref;
> +
> +	if (!PageTransHuge(page))
> +		goto unref;
> +
> +	if (!PageUptodate(page) || PageReadahead(page) || PageHWPoison(page))
> +		goto unref;
> +
> +	if (!trylock_page(page))
> +		goto unref;
> +
> +	if (page->mapping != mapping || !PageUptodate(page))
> +		goto unlock;
> +
> +	if (xas->xa_index >= DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE))
> +		goto unlock;
> +
> +	do_set_pmd(vmf, page);

Here is the source of the huge page leak: do_set_pmd() can fail
(and we would do better to have skipped most of its failure cases long
before getting this far).  It worked without leaking once I patched it:

-	do_set_pmd(vmf, page);
-	unlock_page(page);
-	return true;
+	if (do_set_pmd(vmf, page) == 0) {
+		unlock_page(page);
+		return true;
+	}

> +	unlock_page(page);
> +	return true;
> +unlock:
> +	unlock_page(page);
> +unref:
> +	put_page(page);
> +nohuge:
> +	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (likely(pmd_none(*vmf->pmd))) {
> +		mm_inc_nr_ptes(vma->vm_mm);
> +		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
> +		vmf->prealloc_pte = NULL;
> +	}
> +	spin_unlock(vmf->ptl);

I think it's a bit weird to hide this page table insertion inside
filemap_map_pmd() (I guess you're thinking that this function deals
with pmd level, but I'd find it easier to have a filemap_map_huge()
dealing with the huge mapping).  Better to do it on return into
filemap_map_pages(); maybe filemap_map_pmd() or filemap_map_huge()
would then need to return vm_fault_t rather than bool, I didn't try.

> +
> +	/* See comment in handle_pte_fault() */
> +	if (pmd_devmap_trans_unstable(vmf->pmd))
> +		return true;
> +
> +	return false;
> +}
...
> diff --git a/mm/memory.c b/mm/memory.c
> index c48f8df6e502..96d62774096a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3490,7 +3490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	if (pte_alloc(vma->vm_mm, vmf->pmd))
>  		return VM_FAULT_OOM;
>  
> -	/* See the comment in pte_alloc_one_map() */
> +	/* See the comment in map_set_pte() */

No, no such function: probably should be like the others and say
	/* See comment in handle_pte_fault() */

Hugh
