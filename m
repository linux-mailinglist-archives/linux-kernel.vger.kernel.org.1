Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2491E2E1150
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgLWBUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLWBUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:20:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F05C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 17:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MnZyNILS6l5MC6SCKKdknnUI+WIaEBFHFU2GBSzA3Es=; b=FBS3pJfWQF12z+EX3KHG8aoQVX
        R/fXYqdbxqe5si4/Npt0AXMjcusmScxnnoOJqcTBAFh2b0Utbjkv7lWq0MzWWwGNF9rpWpiRbgy8V
        lbx4Z6BG0o3V/9Rm77EC74VcEYiAcLVzYeMsnm1Jn2ejKt5N6d0vzKNd4T3OHx0dlqFk3XhTv4VER
        vclW3gZ4h87BH5o1n57yj3nZz/CgXxoNNosN6MC9otwjVwPH16WzU+kSu7nhJMv0FLlpEonG6sgoy
        VGF3IYzzEOK4ZMEkn25HWGfBo79ltj4KpSrvcPU71jzPIdEdh/RMX7XVe+ve+ix/OnT9KLpyZNv7W
        mhOyBLPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krsob-0004Xi-Um; Wed, 23 Dec 2020 01:19:46 +0000
Date:   Wed, 23 Dec 2020 01:19:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-ID: <20201223011945.GO874@casper.infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
 <20201222204000.GN874@casper.infradead.org>
 <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 03:53:45PM -0800, Andrew Morton wrote:
> : A previous attempt to make this function static led to compilation
> : errors for a few architectures, because __add_to_page_cache_locked() is
> : referred to by BPF code.

Yes, but it's wrong, because it's not architecture dependent.  It
depends on CONFIG_DEBUG_INFO_BTF

> > > +/*
> > > + * Any attempt to mark this function as static leads to build failure
> > > + * for few architectures. Adding a prototype to silence gcc warning.
> > > + */
> > 
> > We don't need a comment here for this.  The commit log is enough.
> 
> I think it's OK - people do send patches which remove a prototype and
> also make the function static.  A tree-wide grep would catch the bpf
> reference but I suspect people tend to grep for "foo(" rather then
> "foo".

... and the same wrong information is present here.  If there's going to
be a comment here at least make it something informative like

/* Must be visible for error injection */

> > > +int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> > > +		pgoff_t offset, gfp_t gfp, void **shadowp);
> > 
> > Please name that 'index', not 'offset'.
> 
> I too prefer index over offset.  
> 
> X1:/usr/src/linux-5.10> grep -r "pgoff_t offset" . | wc -l
> 52
> X1:/usr/src/linux-5.10> grep -r "pgoff_t index" . | wc -l 
> 250
> 
> But renaming this arg should be a separate patch.

... but this is a new prototype.  Prototype names don't have to match
the function name (and often don't ...)

> And I don't think we should be preparing large "rename offset to index"
> patches, please.  The value/noise ratio is too low.

I'm only fixing them as I change those functions.  I just object to
introducing new wrong ones.
