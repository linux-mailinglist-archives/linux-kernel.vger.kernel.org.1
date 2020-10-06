Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810E2852CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgJFUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbgJFUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602014503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7NLuxXdQeQQY7stz0aLibMIgf9SUDLzEKLNrU4cSWE=;
        b=A3Xbm5T8d4Pk5b7iiSyA8VY/kjWiRm8RExEpyCnvoUU4B74+JuPCkyV7YPetf7MSgf/Xyr
        Sar8fuRGDdamRmyIgT7v0nAwOYzrCCJ8+pjq5DQ207eIuOooFAcvJ16cxOCmUckHYweTcM
        3XCdFcW0n7DYNmDxUo1eanC5ldDEzBc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ywddheaVNM69Bbz937a1dA-1; Tue, 06 Oct 2020 16:01:41 -0400
X-MC-Unique: ywddheaVNM69Bbz937a1dA-1
Received: by mail-qk1-f200.google.com with SMTP id r128so10102463qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7NLuxXdQeQQY7stz0aLibMIgf9SUDLzEKLNrU4cSWE=;
        b=ulExRrh8fLbJLf41KPgtKm0Wn8QtpTpQlZ47rFe2p0cEYnViNmM3UkmggMxlvxV0eY
         B9xv4ye2tCq93gvwVcw8nqc0Ga9O3OdimDY5p3kv4vtPUtKC5UZ2AaDNQC+knmzkKceb
         uTe5URolM8gVz3CPOfRDB57VhCKU9dzPS1lk4a6wzJzGkBXJIoMaPYehetqTMOVda1ul
         Rfda26V2w6A5TWlQf9eUe3cZViVavrmfBz/kfbd7QC4gzHzZolOU0eLbWAPgcHXCgwVv
         8f3fVqhk/RcIWM+tkpuNtC+KzA6DdGgHhjoiTRFvhiGBkJBuJwSNFIn+kGKSGci9dPds
         hLaA==
X-Gm-Message-State: AOAM533aC2XMyj7RWIYOqumA3+X/rJoqzNPhN/vf/6ccLDdXHTR4c2Qu
        M4yh7iftuWs/MnnUjIxPToHD926+WdVHCiTZKfRCjRcBr/wLEh8QQA7KBjObEiS1v6w3v+VQn5S
        zMM+14/EV0jme/7sGR1RvdH0k
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr7112013qtv.236.1602014501062;
        Tue, 06 Oct 2020 13:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMZEDi/lS32ur2gphW1U6vX5ouVhu9SJ6z4d3TFoTXExgFknAz59jMazvy+qKDR9hLk+JcHA==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr7111977qtv.236.1602014500686;
        Tue, 06 Oct 2020 13:01:40 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id g7sm3144991qtc.19.2020.10.06.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:01:39 -0700 (PDT)
Date:   Tue, 6 Oct 2020 16:01:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the akpm-current tree
Message-ID: <20201006200138.GA6026@xz-x1>
References: <20201006230516.64f7b17f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006230516.64f7b17f@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 11:05:16PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (sparc
> defconfig) produced this warning:
> 
> mm/memory.c: In function 'copy_present_page':
> mm/memory.c:800:20: warning: unused variable 'dst_mm' [-Wunused-variable]
>   struct mm_struct *dst_mm = dst_vma->vm_mm;
>                     ^~~~~~
> mm/memory.c: In function 'copy_present_pte':
> mm/memory.c:889:20: warning: unused variable 'dst_mm' [-Wunused-variable]
>   struct mm_struct *dst_mm = dst_vma->vm_mm;
>                     ^~~~~~
> 
> Maybe introduced by commit
> 
>   7e6cdccef3df ("mm-remove-src-dst-mm-parameter-in-copy_page_range-v2")

Yes it is.  The mm pointer is only used by set_pte_at(), while I just noticed
that some of the archs do not use the mm pointer at all, hence this warning.

The required change attached; this is quite special that we only referenced the
mm once in each of the function, so that temp variable can actually be avoided.
Ideally there should be some way to only define the variable on archs that need
this mm pointer (e.g., when set_pte_at() or some similar function is called
multiple times in some function, it should still be helpful to introduce a
local variable to keep dst_vma->vm_mm).  However I don't know a good way to do
this...

Thanks,

------------8<------------
diff --git a/mm/memory.c b/mm/memory.c
index 8ade87e8600a..d9b16136014c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -798,7 +798,6 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
                  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
                  struct page **prealloc, pte_t pte, struct page *page)
 {
-       struct mm_struct *dst_mm = dst_vma->vm_mm;
        struct mm_struct *src_mm = src_vma->vm_mm;
        struct page *new_page;

@@ -874,7 +873,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
        /* All done, just insert the new page copy in the child */
        pte = mk_pte(new_page, dst_vma->vm_page_prot);
        pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
-       set_pte_at(dst_mm, addr, dst_pte, pte);
+       set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
        return 0;
 }

@@ -887,7 +886,6 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
                 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
                 struct page **prealloc)
 {
-       struct mm_struct *dst_mm = dst_vma->vm_mm;
        struct mm_struct *src_mm = src_vma->vm_mm;
        unsigned long vm_flags = src_vma->vm_flags;
        pte_t pte = *src_pte;
@@ -932,7 +930,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
        if (!(vm_flags & VM_UFFD_WP))
                pte = pte_clear_uffd_wp(pte);

-       set_pte_at(dst_mm, addr, dst_pte, pte);
+       set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
        return 0;
 }
------------8<------------

-- 
Peter Xu

