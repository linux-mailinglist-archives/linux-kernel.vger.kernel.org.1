Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2884E2E10AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLVXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgLVXy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:54:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A40BC22B2D;
        Tue, 22 Dec 2020 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608681225;
        bh=HWarrS6CziBbBzyDxCxnKusJ4RarklBqybLYalWUSa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=synwhqm8/c7DFJaUZ7GKtJYIvYhcTKnqKRHDBtRLB1p4TFBL6s4LazB7x/xfX7i0E
         gPxTbPvfwlqkkoReusb8wwGRDsHi99Y/eq+Pg2Tr4o/R7j2hq7WClyv5+yR6lbcPRW
         cI2XxuOUJKI8LQgJFFo7RWPuSF9JP9Lf712ksIXg=
Date:   Tue, 22 Dec 2020 15:53:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-Id: <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
In-Reply-To: <20201222204000.GN874@casper.infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
        <20201222204000.GN874@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 20:40:00 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 22, 2020 at 07:49:52PM +0530, Souptick Joarder wrote:
> > Otherwise it cause gcc warning:
> >           ^~~~~~~~~~~~~~~
> 
> That line is just confusing.

I cleaned up the changelog.  It is presently

: Subject: include/linux/mm.h: add prototype for __add_to_page_cache_locked()
: 
: Otherwise it causes a gcc warning:
: 
: ../mm/filemap.c:830:14: warning: no previous prototype for
: `__add_to_page_cache_locked' [-Wmissing-prototypes]
: 
: A previous attempt to make this function static led to compilation
: errors for a few architectures, because __add_to_page_cache_locked() is
: referred to by BPF code.
: 
: Adding a prototype will silence the warning.

> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -216,6 +216,12 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
> >  		loff_t *);
> >  int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
> >  		loff_t *);
> > +/*
> > + * Any attempt to mark this function as static leads to build failure
> > + * for few architectures. Adding a prototype to silence gcc warning.
> > + */
> 
> We don't need a comment here for this.  The commit log is enough.

I think it's OK - people do send patches which remove a prototype and
also make the function static.  A tree-wide grep would catch the bpf
reference but I suspect people tend to grep for "foo(" rather then
"foo".

> > +int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> > +		pgoff_t offset, gfp_t gfp, void **shadowp);
> 
> Please name that 'index', not 'offset'.

I too prefer index over offset.  

X1:/usr/src/linux-5.10> grep -r "pgoff_t offset" . | wc -l
52
X1:/usr/src/linux-5.10> grep -r "pgoff_t index" . | wc -l 
250

But renaming this arg should be a separate patch.

And I don't think we should be preparing large "rename offset to index"
patches, please.  The value/noise ratio is too low.
