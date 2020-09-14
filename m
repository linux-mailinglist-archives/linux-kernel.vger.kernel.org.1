Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4240269746
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgINVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:01:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:25663 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgINVBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:01:44 -0400
IronPort-SDR: dkrt5YU187XNYfPwEfJn8QrbJzzPJ8oDQTtGhlWez0ifvz/vgbqsJoY3j5+L/BEpvz2+LuTiFC
 1flX/j6fRbrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="138665623"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="138665623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 14:01:42 -0700
IronPort-SDR: 2rUzirZ1BOdNHVS6tlDkjvSF5d4fx/aukTADPMK1gZLD0zuUV43HzP4jCck6plmzioPoypXg2y
 eI12kdtC8QTA==
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="451032932"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 14:01:42 -0700
Date:   Mon, 14 Sep 2020 14:01:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
Message-ID: <20200914210141.GD878166@iweiny-DESK2.sc.intel.com>
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com>
 <20200913145520.GH6583@casper.infradead.org>
 <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
 <20200914140814.GE1221970@ziepe.ca>
 <CAFqt6zasxyAc9heAFuQ0xXuwpk8s7RThordModvLVDNDfFYvkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zasxyAc9heAFuQ0xXuwpk8s7RThordModvLVDNDfFYvkA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:22:33AM +0530, Souptick Joarder wrote:
> On Mon, Sep 14, 2020 at 7:38 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 14, 2020 at 07:20:34AM +0530, Souptick Joarder wrote:
> > > On Sun, Sep 13, 2020 at 8:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
> > > > > It is possible that a buggy caller of unpin_user_pages()
> > > > > (specially in error handling path) may end up calling it with
> > > > > npages < 0 which is unnecessary.
> > > > > @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
> > > > >  {
> > > > >       unsigned long index;
> > > > >
> > > > > +     if (WARN_ON_ONCE(npages < 0))
> > > > > +             return;
> > > >
> > > > But npages is unsigned long.  So it can't be less than zero.
> > >
> > > Sorry, I missed it.
> > >
> > > Then, it means if npages is assigned with -ERRNO by caller, unpin_user_pages()
> > > may end up calling a big loop, which is unnecessary.
> >
> > How will a caller allocate memory of the right size and still manage
> > to call with the wrong npages? Do you have an example of a broken caller?
> 
> These are two broken callers which might end up calling unpin_user_pages()
> with -ERRNO.
> drivers/rapidio/devices/rio_mport_cdev.c#L952

The error here is that nr_pages should not be set to pinned if pinned is < 0.

Why not fix the logic there?  Because it is inherently dangerous to set an
unsigned from a signed variable like that.

> drivers/misc/mic/scif/scif_rma.c#L1399

Again this is a caller who is not properly checking error conditions.

> 
> They both are in error handling paths, so might not have any serious impact.
> But theoretically possible.

Actually I think they might have serious problems so they both should be fixed.

In the end this patch just can't work because npages can't be < 0 like Matthew
said.

Ira

