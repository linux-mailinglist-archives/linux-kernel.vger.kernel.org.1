Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C721B589
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGJM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:56:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2CCC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:56:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9CA1B20C; Fri, 10 Jul 2020 14:56:24 +0200 (CEST)
Date:   Fri, 10 Jul 2020 14:56:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        iommu@lists.linux-foundation.org
Subject: Re: a question of split_huge_page
Message-ID: <20200710125623.GH27672@8bytes.org>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
 <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50113530-fae5-bb36-56c2-5b5c4f90426d@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Robin.

On Fri, Jul 10, 2020 at 05:34:52PM +0800, Alex Shi wrote:
> 在 2020/7/10 下午1:28, Mika Penttilä 写道:
> > 
> > 
> > On 10.7.2020 7.51, Alex Shi wrote:
> >>
> >> 在 2020/7/10 上午12:07, Kirill A. Shutemov 写道:
> >>> On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
> >>>> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
> >>>>> Hi Kirill & Matthew,
> >>>>>
> >>>>> In the func call chain, from split_huge_page() to lru_add_page_tail(),
> >>>>> Seems tail pages are added to lru list at line 963, but in this scenario
> >>>>> the head page has no lru bit and isn't set the bit later. Why we do this?
> >>>>> or do I miss sth?
> >>>> I don't understand how we get to split_huge_page() with a page that's
> >>>> not on an LRU list.  Both anonymous and page cache pages should be on
> >>>> an LRU list.  What am I missing?> 
> >>
> >> Thanks a lot for quick reply!
> >> What I am confusing is the call chain: __iommu_dma_alloc_pages()
> >> to split_huge_page(), in the func, splited page,
> >> 	page = alloc_pages_node(nid, alloc_flags, order);
> >> And if the pages were added into lru, they maybe reclaimed and lost,
> >> that would be a panic bug. But in fact, this never happened for long time.
> >> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vmtests
> > 
> > 
> > In  __iommu_dma_alloc_pages, after split_huge_page(),  who is taking a
> > reference on tail pages? Seems tail pages are freed and the function
> > errornously returns them in pages[] array for use?
> > 
> 
> CC Joerg and iommu list,
> 
> That's a good question. seems the split_huge_page was never triggered here,
> since the func would check the PageLock first. and have page->mapping and PageAnon
> check, any of them couldn't be matched for the alloced page.
> 
> Hi Joerg,
> would you like look into this? do we still need the split_huge_page() here?
> 
> Thanks
> Alex
> 
> int split_huge_page_to_list(struct page *page, struct list_head *list)
> {
>         struct page *head = compound_head(page);
>         struct deferred_split *ds_queue = get_deferred_split_queue(head);
>         struct anon_vma *anon_vma = NULL;
>         struct address_space *mapping = NULL;
>         int count, mapcount, extra_pins, ret;
>         pgoff_t end;
> 
>         VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
>         VM_BUG_ON_PAGE(!PageLocked(head), head);	<==
> > 
