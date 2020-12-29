Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952122E71BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgL2PUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgL2PUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:20:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xLMIthYL2Moj7S22JZC3kYzACmfCDhYMvd4FNRf+Y5g=; b=u9jp5uidl9OFE7aCkObe9hp5pE
        +3t85eqnumPsw8Itiig813l4H8FbMDr8AB3FsQ3aGflZ4y1LWngwZTpC18ULCj7WjiL4oFyWzSnV/
        T83wdFX0xpUfzoKThAEewAT6fWdIx4uABtIZ2kE1npaPbtNtCMRaG9nEDKRm+ocFuZDtmwmRkJCTu
        5VssaG1acx+twykk7iaTIip2PdVqbhd67tl+wZIUvZl4yD6TQOMmQ/emoSOf+KXuAAZHalpZ/Puws
        MOAt8LUcun9ENkXyMeviWVznuZZx6+ruszTg0v2X0TaKUKLE6Mznmi/nK63Zu2490TWXR3beqi0fN
        Wz7IMSUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kuGm6-0004xb-NO; Tue, 29 Dec 2020 15:19:03 +0000
Date:   Tue, 29 Dec 2020 15:19:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
Message-ID: <20201229151902.GC28221@casper.infradead.org>
References: <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box>
 <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
 <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
 <CAHk-=whwJcJubrP8ELH=UvEHX146_Jdmfn992W55KJgPvUx_Uw@mail.gmail.com>
 <20201229132819.najtavneutnf7ajp@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229132819.najtavneutnf7ajp@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 04:28:19PM +0300, Kirill A. Shutemov wrote:
> > At that point, there would no longer be any need to update the
> > address/pte fields in the vmf struct, and in fact I think it could be
> > made a "const" pointer in this cal chain.
> 
> Unfortunately, we would still need to NULLify vmf->prealloc_pte once it's
> consumed. It kills idea with const.

We could abstract out a refcount for pgtable_t (usually it's a struct
page, but sometimes it's a portion of a struct page, or sometimes
it's multiple struct pages) and always put it instead of freeing it.
There'd be some details to sort out, and I'm not sure it's worth it just
to constify the vmf on this path, but something that might be worth it
for a future case.

> +++ b/fs/xfs/xfs_file.c
> @@ -1319,17 +1319,19 @@ xfs_filemap_pfn_mkwrite(
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
>  }
>  
> -static void
> +static vm_fault_t
>  xfs_filemap_map_pages(

Can we just ditch the ->map_pages callback and make the rule "if you've put
uptodate pages in the page cache, they can be mapped without informing
the filesystem"?

> +++ b/include/linux/mm.h
> @@ -534,8 +534,8 @@ struct vm_fault {
>  					 * is not NULL, otherwise pmd.
>  					 */
>  	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
> -					 * vm_ops->map_pages() calls
> -					 * alloc_set_pte() from atomic context.
> +					 * vm_ops->map_pages() sets up a page
> +					 * table from from atomic context.

Doubled word "from" here.

