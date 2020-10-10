Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3328A1DC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgJJWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbgJJSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:54:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5DC0613BD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Msw6fpgRxYN9+n0XAq2tl/9+x3JBz7DH4RT1m5W6lM=; b=gG7YhX2LzOY8pM12PPGk/xQmO/
        og4fso+Qlgg4PN0Zy7fwqAf+Rj4Zbxchp0FUeQGdF/qoo7yy+IURApu7dMgcPSYgITDFiyjRLODFF
        zzKs91mJ0Z5MCmMqBfCXYZNFhdods9yliMOlrSSR3577CWhDwa8LloF7I7Tig0p4mp42m9uYHkE/8
        0TDAZUeRtT1t+nGGrqJG4a0iGl+nRHdjzQ+P8oDVkhaJsNYU04f634Zosq072OOFBN32IJ6XR3QiK
        V0Y+1eDWaLgLz5h2fB4kLycTxRqssK6A6bj8zG4vAPRHGiABADmuIAU8HGanwOx2w5ahiZP08urgo
        z/XldW+A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRGUX-0004oC-Kf; Sat, 10 Oct 2020 15:09:01 +0000
Date:   Sat, 10 Oct 2020 16:09:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Denis Lisov <dennis.lissov@gmail.com>, Qian Cai <cai@lca.pw>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/khugepaged: fix filemap page_to_pgoff(page) != offset
Message-ID: <20201010150901.GX20115@casper.infradead.org>
References: <alpine.LSU.2.11.2010091943300.13335@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2010091943300.13335@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 08:07:59PM -0700, Hugh Dickins wrote:
> There have been elusive reports of filemap_fault() hitting its
> VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page) on kernels built
> with CONFIG_READ_ONLY_THP_FOR_FS=y.
> 
> Suren has hit it on a kernel with CONFIG_READ_ONLY_THP_FOR_FS=y and
> CONFIG_NUMA is not set: and he has analyzed it down to how khugepaged
> without NUMA reuses the same huge page after collapse_file() failed
> (whereas NUMA targets its allocation to the respective node each time).
> And most of us were usually testing with CONFIG_NUMA=y kernels.

Good catch.  There have been at least three bugs in recent times which
can cause this VM_BUG_ON_PAGE() to trigger.  This one, one where swapping
out a THP led to all 512 entries pointing to the same non-huge page on
swapin (fixed in -mm) and one that I introduced for a few weeks in -mm
where failing to split a THP would lead to random tree corruption due
to a non-zeroed node being freed to the slab cache.

There may yet be a fourth.  I've seen it occasionally in recent testing
so I'll add this patch and see if it disappears.

> Instead, non-NUMA khugepaged_prealloc_page() release the old page
> if anyone else has a reference to it (1% of cases when I tested).

I think this is a good way to fix the problem.  We could also change
khugepaged to insert a frozen page, ensuring that find_get_entry()
would spin until the collapse has succeeded or the page was removed
from the cache again.  But I have no problem with this approach.

I want to note that this is a silent data corruption for reads.
generic_file_buffered_read() has a reference to the page, so this
patch will fix it, but before it could be copying the wrong data
to userspace.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
