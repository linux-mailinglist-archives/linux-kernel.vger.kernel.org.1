Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB22E375F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgL1Myo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgL1Myg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:54:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:53:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b26so23631891lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e/ofUiCRRpB4u/ncszNNbx4yVQ41aGMLvWQFS35RvZk=;
        b=LtOrTYXJm5GCAEJmyygo6av6ilVjte7nrHfuv67gXDpKd+J+pPdTCcxYoIGp1dX2w5
         Ihd5Qc2FtGU3gkA9UCXFeBOVXtmF3FnWevd7p76cvCLgY3D+rXxSsU67PTKPx5J3a9zf
         uElwOP/OCHcUtHiAe6BZzxxUfgrYLg2Z7S38iArnEgsXBm7Vdj8wuG58GjfYodS8aTsq
         t0CWf/hY4H5bnuF+Baqp67r1D0d25zzn6kMkxzTUWCUgm15TmoKXiO8s6vvrzcjs5BmL
         56zSFKosBDPZB9Q+jEXFPoy/z3+8D1EQY1QWh/kndY66e3IQB0KG8w+ANVgwfrdXZJAC
         5ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e/ofUiCRRpB4u/ncszNNbx4yVQ41aGMLvWQFS35RvZk=;
        b=fK/EvP64NirrPlF1sZihUHmjJgohGubk2pD9uaqZdSCIq/l8mpH/hCJRTJZaySpC8X
         855vBmDaN/0gw5jyZ7ZAttHdCr4WR3h+Z47+nOo+mE9Tb2JBfZQxdAc9/qOTBb7Xq8TK
         Cf/jvSkUlVfdTHu3IeTQDKzMByHFBv8dDK8xwI/5GUui9oCpAWdHtWAFOl5bIEwxF25t
         VsrirYmYUCL+KUoSJRdIW3A4NYSC7l6pwUYUVDWTvNVK4HETlCzoDkHBy4F0Ycijcmp+
         UXUG1fyIlIl/qdxSp1bEdMBs9fgQoS/g8IPll3GhJ1opSRZoI3brx5m/jcGMT80p7IqU
         K74A==
X-Gm-Message-State: AOAM5331fjUCdkGwUnvxinq8L7i/OHRhGPaa3+Lz5FGFMjatccVRZJ8o
        vt6iUMO+6K1VhjMexMMItKAdhw==
X-Google-Smtp-Source: ABdhPJyF06z1uqFK1T0R7uip1K18Ag78t+cj6KkROGIX8ECc9cTa2pWQCwBOjCm+YlSORX87suNs5A==
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr22712768ljo.368.1609160033448;
        Mon, 28 Dec 2020 04:53:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j26sm200426lfh.251.2020.12.28.04.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 04:53:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 89D9A100F3B; Mon, 28 Dec 2020 15:53:52 +0300 (+03)
Date:   Mon, 28 Dec 2020 15:53:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20201228125352.phnj2x2ci3kwfld5@box>
References: <20201226204335.dikqkrkezqet6oqf@box>
 <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box>
 <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box>
 <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:43:44PM -0800, Hugh Dickins wrote:
> On Sun, 27 Dec 2020, Linus Torvalds wrote:
> > On Sun, Dec 27, 2020 at 3:48 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > I did what Hugh proposed and it got clear to my eyes. It gets somewhat
> > > large, but take a look.
> > 
> > Ok, it's not that much bigger, and the end result is certainly much
> > clearer wrt locking.
> > 
> > So that last version of yours with the fix for the uninitialized 'ret'
> > variable looks good to me.
> > 
> > Of course, I've said that before, and have been wrong. So ...
> 
> And guess what... it's broken.
> 
> I folded it into testing rc1: segfault on cc1, systemd
> "Journal file corrupted, rotating", seen on more than one machine.
> 
> I've backed it out, rc1 itself seems fine, I'll leave rc1 under
> load overnight, then come back to the faultaround patch tomorrow;
> won't glance at it tonight, but maybe Kirill will guess what's wrong.

So far I only found one more pin leak and always-true check. I don't see
how can it lead to crash or corruption. Keep looking.

diff --git a/mm/filemap.c b/mm/filemap.c
index c5da09f3f363..87671284de62 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2966,8 +2966,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf, unsigned long address,
 			mmap_miss--;
 
 		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
-		if (vmf->pte)
-			vmf->pte += xas.xa_index - last_pgoff;
+		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 
 		if (!pte_none(*vmf->pte))
diff --git a/mm/memory.c b/mm/memory.c
index e51638b92e7c..829f5056dd1c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3785,13 +3785,16 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				      vmf->address, &vmf->ptl);
+	ret = 0;
 	/* Re-check under ptl */
 	if (likely(pte_none(*vmf->pte)))
 		do_set_pte(vmf, page);
+	else
+		ret = VM_FAULT_NOPAGE;
 
 	update_mmu_tlb(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return 0;
+	return ret;
 }
 
 static unsigned long fault_around_bytes __read_mostly =
-- 
 Kirill A. Shutemov
