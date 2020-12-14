Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB87F2D9FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502370AbgLNS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502248AbgLNS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:57:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E9p2fQLU+kZ8mfKkC7toHhZ7VgcwGHnKqCLNvwn4P8k=; b=OcxiEbZrXxgCVxht7qvEu0hTvo
        KOWCihxnceuUesbzpigpQQDzZu57/6+67M09uB1UJw5q2wjhbsZFLKMUz6ciZVDjrJnd/2WQ8VJkC
        VAJmu+E+ZhJGCoIyKWkBWk7EyImlTy2oIb/TnmvnpKGKTI50hz7Bj0CeF8izMe6eaKkslFTcIYMxr
        dKpGe5eFZVuxE1UDB5YF9V7xfBr9mXbPPdWxEMUor/Oql/nzB0RKd8Xzlr69bbGH41lu/ysEMx8Aw
        sOH8DEpzUZA6HMhosyGEDG3m7/O4t0+uejJ4ZpnYsNfBlAoEjW4rQrzz/f4kpYzaQw70OqnL1GxLF
        VuZSeAzg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kot10-0008QV-90; Mon, 14 Dec 2020 18:56:10 +0000
Date:   Mon, 14 Dec 2020 18:56:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Message-ID: <20201214185610.GO2443@casper.infradead.org>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck>
 <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
 <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box>
 <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 09:54:06AM -0800, Linus Torvalds wrote:
> > I expected to hate it more, but it looks reasonable. Opencoded
> > xas_for_each() smells bad, but...
> 
> I think the open-coded xas_for_each() per se isn't a problem, but I
> agree that the startup condition is a bit ugly. And I'm actually
> personally more confused by why xas_retry() is needed here, bit not in
> many other places. That is perhaps more obvious now that it shows up
> twice.
> 
> Adding Willy to the cc in case he has comments on that, and can
> explain it to me in small words.
> 
> [ https://lore.kernel.org/lkml/20201214160724.ewhjqoi32chheone@box/
> for context ]

The xas_retry() is something I now regret, but haven't got annoyed enough
by it yet to fix (also, other projects).  It originated in the radix
tree where we would get a radix_tree_node and then iterate over it in
header macros.  If we're holding the rcu_read_lock() and somebody else
deletes an entry leaving the entry at index 0 as the only index in the
tree, we tell the RCU readers to rewalk the tree from the top by putting
a retry entry in place of the real entry.

It's not entirely clear to me now why we did that.  Just leave the entry
alone and the RCU-walkers will see it, then the rest of the node is empty.

As to why we need to do this in some places and not others; you can
only see a retry entry if you're only protected by the RCU lock.  If
you're protected by the spinlock, you can't see any nodes which
contain retry entries.

But I now think we should just get rid of retry entries.  Maybe I'm
missing a good reason to keep them.
