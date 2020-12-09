Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D42D4BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgLIUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgLIUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:32:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E17C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bGzrld7wr84RrSgEszhR+wmk08YFGa6cLi6pnZc4i/0=; b=QaMIoLxvrAk+bVYa5OQVotE5Fc
        Z1ucapu5XB9I19/2+q9oJ/oXw2s4AAf+/aFypyM5ukgfHHzhsxu6bhWSLEJMll9S65wTjSLPtvU4Q
        e3xF3Y+A/Oef0602EVYxB4cYNjv1IUBbj8FSla0mNhJ217jHOFm/NgN3bjRhaqxtxxC45shK4lpYo
        rDnhULs6H5LISfoOOlofa/K5CiZBMyRux/qMHXB5I/9VkXhZKIpLHBs1Lp07P/Do1fCzf/jq9hRUY
        vQL3G487WOceGg6FvaaVdigeo4TmuwPaKnajJY6ROPQz3AzNouMSTE2HOQYguKRofkVBoJvrWdRCq
        vjhcjcxg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn683-0007vi-5V; Wed, 09 Dec 2020 20:32:03 +0000
Date:   Wed, 9 Dec 2020 20:32:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201209203203.GU7338@casper.infradead.org>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck>
 <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:04:13AM -0800, Linus Torvalds wrote:
> In particular, it made it a nightmare to read what do_fault_around()
> does: it does that odd
> 
>         if (pmd_none(*vmf->pmd)) {
>                 vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
> 
> and then it calls ->map_pages() (which is always filemap_map_pages(),
> except for xfs, where it is also always filemap_map_pages but it takes
> a lock first).

... which is wrong.  Dave's paranoia around other people
introducing bugs into XFS made him do this, but we should revert
cd647d5651c0b0deaa26c1acb9e1789437ba9bc7.  Those operations he's
worried about are protected by the page lock.

If a filesystem has put an Uptodate page into the page cache, the
rest of the kernel can read it without telling the filesystem.

