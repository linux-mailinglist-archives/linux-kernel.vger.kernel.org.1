Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBEA2744F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIVPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIVPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:06:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426DDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pNa1Xk8X0S/o0XcV8ZzSziz1T35+mr1/P3jDsDxbxTg=; b=PveBM4gYCSnMMhKvJ58NnflkxB
        WTxYSSN6ly35Ngsz1Fk/WgcMXUEvGOnUcMo/ov8f0X54L6pQygSattXaLdbob2KmhIu9YZ6aPVguh
        gJnN3SIREDE4DB8P58xt9H+h6AHKWiZfdLZ9BvErZ0cotJnM7vD/B3Azf6R6V4AuNBwQzajAOzEeH
        Cff0QZlZ+paANqXnZVsxkmNP6IyMMMSA5gbuXDxuu62ne8XD+EGe1oU6n7akKCqIdkAGAHvueW6rO
        +Je+0t7+y8DjSf+mpobFsNrWscvmVd7qsJjJ5bqNjhh1wAVvvXsF8bCYrIQgMSqQgBuiVQGYqpO6A
        nF0NcDPw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKjrn-0002sC-Vm; Tue, 22 Sep 2020 15:06:04 +0000
Date:   Tue, 22 Sep 2020 16:06:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 2/2] vfree: Update documentation
Message-ID: <20200922150603.GH32101@casper.infradead.org>
References: <20200921224628.20704-1-willy@infradead.org>
 <20200921224628.20704-2-willy@infradead.org>
 <20200922143506.GA26664@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143506.GA26664@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 04:35:06PM +0200, Christoph Hellwig wrote:
> >  /**
> > - * vfree - release memory allocated by vmalloc()
> > - * @addr:  memory base address
> > + * vfree - Release memory allocated by vmalloc()
> > + * @addr:  Memory base address
> >   *
> >   * Free the virtually continuous memory area starting at @addr, as
> > + * obtained from vmalloc(), vmalloc_32() or __vmalloc().  If called
> > + * on an @addr obtained from vmap(), it will put one refcount on each
> > + * mapped page, which will free the page if this is the last refcount
> > + * on the page.  If @addr is NULL, no operation is performed.
> 
> This reads a little confusing.  First it only allows vmalloc* and
> then it mentions vmap in the next sentence.  And what about
> vmalloc_32_user, vzalloc_node, vmalloc_node, vmalloc_user, vzalloc and
> __vmalloc_node?

In my defence, I didn't write that sentence; you snipped:

- * obtained from vmalloc(), vmalloc_32() or __vmalloc(). If @addr is
- * NULL, no operation is performed.

I don't think it makes sense to list all vmalloc-style allocators here.
It won't be updated by people who add new variations.  How about this?

 * Free the virtually continuous memory area starting at @addr, as
 * obtained from one of the vmalloc() family of APIs.  This will
 * usually also free the physical memory underlying the virtual
 * allocation, but that memory is reference counted, so it will not
 * be freed until the last user goes away.
 *
 * If @addr is NULL, no operation is performed.

I'm trying to strike a balance between being accurate and not requiring
device driver authors to learn all about struct page.  I may be too
close to the implementation to write good documentation for it.
