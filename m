Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0212526E640
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIQUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgIQUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:07:59 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EFC0612F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:38:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so1598594qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CNJ7oZi6THpUP7nc6TfqkOyCuXcwBs1RipCXw7bsPco=;
        b=oewQ2hrEulpRw7YaRRH5ghfbNO15TIBrln0DMCA24xlcwOVILWgR7Hl6wrIO0+J6qN
         m69YQpqnJr2vssE1sbElucVqSkbQFz7I6/JTIRZCFGKJ0eC3gFnI/K7hANSzKUNPT1OK
         NEGRQibR+PiRlMNEs+ebj/Fn5J5EOg+z87uze7feR0fVMbDWoQ1YrCgrTou9j+QeIZ29
         dNcvyiJDxts1AKxqRHmM5MlKKjc/81USbABQPZ6mrnYnn/o9kAIG4F0rTCU6uJn6aIos
         4AO13xx2PwZajKVLyHhAJh0uhgfx/9mSotZJLJU2nFHiSC7xQmmH3sGhz9dAwp3MgZOG
         ZJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CNJ7oZi6THpUP7nc6TfqkOyCuXcwBs1RipCXw7bsPco=;
        b=QcSLPOJtkRrBwc3RYA9TvfW2fcTVOQ6LY28Myr3fSxZP+Hif0RoyeVZtk2rwohWhq+
         4bnnnskTt8U49O5ot8yiHQcSBr8SOfoefWjiW0OHVi3KOD+HrdgAR809EUdgVZdVVF/d
         ojwuG/GzQXUMbQTlsLUw61rXgFf1UdfkXLEdZ7ikhYlOsa9JzUQHgiT5Pzc+aV05Jjlf
         P8m0BuQEBoINuD3x/be6NNU49ZGvdfoK6OJ0Dwy5DDHd6RFpdmogBwqm3n7EV8lfowoQ
         /Qir8oaqgp5bfFZkTZcVqXznO/j5ayPRKFC0RinruQbVP+4H+nkJdqBOS5nHoc085fGF
         Nhsg==
X-Gm-Message-State: AOAM532CkfVYGnWg6dbx+c1NKQslP+SmualkfQpTi4JYHQG1aTfi6IVs
        4fot1e7pGRbqsE2fR3OaEoCI2A==
X-Google-Smtp-Source: ABdhPJw9U+NS9ntsDfqB6L/1hA5PlAxaX3iFnzngGbMRUd7jg/svBVEQ+IZQB6SwuKB/NSVp1a+t5g==
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr30485931qvb.13.1600371506151;
        Thu, 17 Sep 2020 12:38:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e7sm532752qtk.17.2020.09.17.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 12:38:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kIzjc-000kpq-Ig; Thu, 17 Sep 2020 16:38:24 -0300
Date:   Thu, 17 Sep 2020 16:38:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200917193824.GL8409@ziepe.ca>
References: <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1>
 <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1>
 <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com>
 <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:11:06AM -0700, Linus Torvalds wrote:
>  (a) if the pinner is going to change the page, it will have to get
> the pin with FOLL_WRITE in addition to FOLL_PIN
> 
>  (b) that means it will do the COW and mark the page writable and dirty

Yep
 
>  (c) the whole _point_ of the FOLL_PIN is that subsequent operations
> shouldn't make it non-writable any more (ie it can't be unmapped, and
> we should synchronize on fork etc)

It is the ideal, but FOLL_PIN has been troubled for a long time:
https://lwn.net/Articles/753027/

ie writeprotect is known to happen due to writeback. I had understood
that fork() will also cause write protect. Eg

copy_process()
 copy_mm()
  dup_mm()
   dup_mmap()
    copy_page_range()
     [..]
      copy_one_pte()

Gets to:

	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
		ptep_set_wrprotect(src_mm, addr, src_pte);
		pte = pte_wrprotect(pte);
	}

Which blindly write protects a FOLL_PIN page. Here src_pte will be
under a pin.

I *think* the failing test is basically:

 1) pin_user_pages(mem, FOLL_FORCE | FOLL_WRITE)
 2) pid = fork()
 3) child: does a bit, then exec
 4) parent: waitpid(pid)
 5) *mem = 0

Here #5 is the WP triggered COW. We know a WP triggered COW is
happening from the bisect and success result with MADV_DONTFORK.

#2 triggers the dup_mmap() and the ptep_set_wrprotect() (From
inspection, at least)

This "Trial do_wp_page() simplification" patch means that when #5 goes
to do COW it gets a copy instead of a re-use because the
reuse_swap_page() was aborting the copy before.

So, to your point, yes ideally FOLL_PIN would never write-protect
pages!

Looking for awhile, this now looks reasonable and
doable. page_maybe_dma_pinned() was created for exactly this kind of
case.

I've attached a dumb sketch for the pte level (surely wrong! I have
never looked at this part of the mm before!) at the end of this
message. 

Peter, do you know this better? Does this inspire you to make a patch? :)

Would really love to see this. We have such a huge expensive mess with
MADV_DONTFORK, this would eliminate all that overhead.

Thanks,
Jason

diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76e1..6bc19a43da1391 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -689,6 +689,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 #endif
 
+static int duplicate_page(pte_t *newpte, struct vm_area_struct *vma,
+			  unsigned long address, struct page *page)
+{
+	struct page *new_page;
+
+	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
+	if (!new_page)
+		return -ENOMEM;
+	copy_user_highpage(new_page, page, address, vma);
+
+	/* FIXME: surely more than this */
+	*newpte = mk_pte(new_page, vma->vm_page_prot);
+	return 0;
+}
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
@@ -703,6 +718,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
+	bool do_src_wp;
 
 	/* pte contains position in swap or file, so copy. */
 	if (unlikely(!pte_present(pte))) {
@@ -775,15 +791,6 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto out_set_pte;
 	}
 
-	/*
-	 * If it's a COW mapping, write protect it both
-	 * in the parent and the child
-	 */
-	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
-		pte = pte_wrprotect(pte);
-	}
-
 	/*
 	 * If it's a shared mapping, mark it clean in
 	 * the child
@@ -800,11 +807,34 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!(vm_flags & VM_UFFD_WP))
 		pte = pte_clear_uffd_wp(pte);
 
+	do_src_wp = is_cow_mapping(vm_flags) && pte_write(pte);
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
 		get_page(page);
 		page_dup_rmap(page, false);
 		rss[mm_counter(page)]++;
+
+		/*
+		 * If a page is DMA pinned we never want to write protect it,
+		 * copy it now.
+		 */
+		if (do_src_wp && page_maybe_dma_pinned(page)) {
+			do_src_wp = false;
+			ret = duplicate_page(&pte, vma, addr, page);
+			if (ret)
+			     /* FIXME: need to restructure a bit to handle this */
+			     return ret;
+		}
+	}
+
+	/*
+	 * If it's a COW mapping, write protect it both
+	 * in the parent and the child
+	 * FIXME check carefully this is new order is OK
+	 */
+	if (do_src_wp) {
+		ptep_set_wrprotect(src_mm, addr, src_pte);
+		pte = pte_wrprotect(pte);
 	}
 
 out_set_pte:

