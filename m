Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29EF2E6B24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgL1W4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgL1WNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 17:13:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B510C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 14:12:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x20so26883306lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tveTiSW3kXI18qkd/ZaB+nQ0L/9zQTBwJzflX/XFRO4=;
        b=zArwFJCb5RJFbnwqQOcGRmO9THjhSHIcad6u0iuLaWRPbpzDkqfwNGoJrsxucPcimm
         jwI/yVKRYRBMnwUpQ2zQyOfYjlraEt7alLh8N1hmGiQB+MkzgL7kCkzi6KM8tYMnXTaR
         AC1tLDiH8chACCfWto4A/LsOZvqlWRSEZlLSaOjzYCWXt0r3+QtuEWvUJ2sP4jsPkRXI
         TiZJS0EavQZPgg80200E0VCRSE0tFLTRNrgBobsi0TgfdXhrhOlPOjnfw8h3RUS/96F3
         qEYGSwlzUpvdIKwvYtvigqclnGrTxAUroQ9X1rnqoDVaa6CL4MBqc5ef+1i+D7ilblZl
         AAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tveTiSW3kXI18qkd/ZaB+nQ0L/9zQTBwJzflX/XFRO4=;
        b=On6QvKtUNc3L/lvXXkv41s5NUOgTWuPy97PrPFt3RzVeRnEILVOpgPKRF61D9FA8HU
         arSJR5X9VmjC+IpWjhUAb9QGz7RQHRnoX/dcriXuWEqV37CBM8ixcEf/mGVvzRiJxKML
         e35dp9IkwWpTU11bhzUW1greXG+FuFZhmYdjNsrYn4RC2pV/KlrZ1GrVSgAllmI44SDn
         ruuMLE8fMZ9t6WBu18ikm6h1xsNG1/KMySK6YPgqh5nmHmo+UYssKrpDumhbZsTUr8UE
         eR5B9i/lKlebeeMi22onabtRvnrzkLRGP7NOBN7onFk64wfQp22tvNIwqk900Z4Be//g
         hNHg==
X-Gm-Message-State: AOAM5302SE175Tblzx/aCgq/C2JBIplSQWBKCtVSrcHrh4u3n54io3Q8
        elMJsplcgLMv2Y4qd+D/pDmFsA==
X-Google-Smtp-Source: ABdhPJySQycOonv7NhIpwPNHFfA/dnUsLfdgmjGLC7V51EjW7hZO8cBlM/z70OqkOOFQUJSip5xYLg==
X-Received: by 2002:a19:6c7:: with SMTP id 190mr21005693lfg.614.1609193557628;
        Mon, 28 Dec 2020 14:12:37 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a15sm6433563lji.105.2020.12.28.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 14:12:36 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 15841100F3B; Tue, 29 Dec 2020 01:12:37 +0300 (+03)
Date:   Tue, 29 Dec 2020 01:12:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
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
Message-ID: <20201228221237.6nu75kgxq7ikxn2a@box>
References: <20201226224016.dxjmordcfj75xgte@box>
 <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box>
 <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
 <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
 <20201228220548.57hl32mmrvvefj6q@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228220548.57hl32mmrvvefj6q@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 01:05:48AM +0300, Kirill A. Shutemov wrote:
> On Mon, Dec 28, 2020 at 10:47:36AM -0800, Linus Torvalds wrote:
> > On Mon, Dec 28, 2020 at 4:53 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > So far I only found one more pin leak and always-true check. I don't see
> > > how can it lead to crash or corruption. Keep looking.
> > 
> > Well, I noticed that the nommu.c version of filemap_map_pages() needs
> > fixing, but that's obviously not the case Hugh sees.
> > 
> > No,m I think the problem is the
> > 
> >         pte_unmap_unlock(vmf->pte, vmf->ptl);
> > 
> > at the end of filemap_map_pages().
> > 
> > Why?
> > 
> > Because we've been updating vmf->pte as we go along:
> > 
> >                 vmf->pte += xas.xa_index - last_pgoff;
> > 
> > and I think that by the time we get to that "pte_unmap_unlock()",
> > vmf->pte potentially points to past the edge of the page directory.
> 
> Well, if it's true we have bigger problem: we set up an pte entry without
> relevant PTL.
> 
> But I *think* we should be fine here: do_fault_around() limits start_pgoff
> and end_pgoff to stay within the page table.
> 
> It made mw looking at the code around pte_unmap_unlock() and I think that
> the bug is that we have to reset vmf->address and NULLify vmf->pte once we
> are done with faultaround:
> 
> diff --git a/mm/memory.c b/mm/memory.c

Ugh.. Wrong place. Need to sleep.

I'll look into your idea tomorrow.

diff --git a/mm/filemap.c b/mm/filemap.c
index 87671284de62..e4daab80ed81 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2987,6 +2987,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf, unsigned long address,
 	} while ((head = next_map_page(vmf, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	rcu_read_unlock();
+	vmf->address = address;
+	vmf->pte = NULL;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 
 	return ret;
-- 
 Kirill A. Shutemov
