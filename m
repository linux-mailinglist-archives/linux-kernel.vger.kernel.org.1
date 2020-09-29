Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0327CD54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbgI2MnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgI2MnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:43:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D443C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Zy06oRgcIcAQqe4Oh9nWNgW5XxynFsjn7qUS76GnM0=; b=FFQTzNV9FLJWoPmNhxe5yL1W+Q
        tDkiItvKjFTET2X9o+OiiUO/NvmheEO+m5yLMVhFHhfebG1nbpZ6X034hcT2/wVo1ixij5+dxwvqN
        s71s/67K+KnNkPIMUFTHdqAqiLkInwtvZZJpDTQog6HZvYypcOTmFUhLiGTrvDrh0Fw76AJufwe3e
        pmSQqEclL6qF3fKcedWFu7/rp3eyIsS4U57xPU1gR+juL/YY7uhq1XdJ8eNJYa4pMfeROaFN21sl+
        yJhcF8jHc7L0EdAqlkZPerM0uMCm4mi20gNAIwsil3v7pjo9XW5wTSGFKP7OZD2O56GV6HX1Qk+oL
        oqYOxVPA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNEy4-00066L-2U; Tue, 29 Sep 2020 12:42:52 +0000
Date:   Tue, 29 Sep 2020 13:42:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20200929124251.GB20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-5-willy@infradead.org>
 <20200929084653.GC10896@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084653.GC10896@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:46:53AM +0200, Jan Kara wrote:
> On Mon 14-09-20 14:00:34, Matthew Wilcox (Oracle) wrote:
> > Rewrite shmem_seek_hole_data() and move it to filemap.c.
> > 
> > +	rcu_read_lock();
> > +	while ((page = xas_find_get_entry(&xas, max, XA_PRESENT))) {
> > +		loff_t pos = xas.xa_index * PAGE_SIZE;
> 
> OK, but for ordinary filesystems this could be problematic because of
> exceptional entries?

For ordinary filesystems, I have this queued up on top:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/02c740b215bab901f95a560759b3bd906648da08

which handles exceptional entries.  It treats shadow/swap/DAX entries
the same -- there's definitely data there, it's just not in a struct
page right now.

> Also for shmem you've dropped the PageUptodate check which I'm not sure is
> safe?

That was unintentional.  I did run xfstests against this patch (just did
it again ... it passes), so I suspect it doesn't create a !Uptodate page.
I'll see if I can enhance the existing xfstests to catch this case.

The patch I link to above also doesn't handle !Uptodate pages on shmem
filesystems the same way that the current code does.  So ... on top of
this patch, I propose doing this:

@@ -2416,6 +2416,14 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_ite
r *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
+static inline loff_t page_seek_hole_data(struct page *page,
+               loff_t start, loff_t end, bool seek_data)
+{
+       if (xa_is_value(page) || PageUptodate(page))
+               return seek_data ? start : end;
+       return seek_data ? end : start;
+}
+
 static inline
 unsigned int seek_page_size(struct xa_state *xas, struct page *page)
 {
@@ -2463,10 +2471,10 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
                        start = pos;
                }
 
-               if (seek_data)
+               pos += seek_page_size(&xas, page);
+               start = page_seek_hole_data(page, start, pos, seek_data);
+               if (start < pos)
                        goto unlock;
-
-               start = pos + seek_page_size(&xas, page);
        }
        rcu_read_unlock();
 

... and then rebasing the other patch on top of this works out nicely.

Here's the result:
http://git.infradead.org/users/willy/pagecache.git/commitdiff/9eb3f496b7cdcdcae83026e861e148f46921c367
http://git.infradead.org/users/willy/pagecache.git/commitdiff/7d93274088f0872d849a906d783dc260bee106b9
