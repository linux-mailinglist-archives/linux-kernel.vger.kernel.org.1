Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCD2CB395
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 04:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgLBDnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 22:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgLBDnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 22:43:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20C1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 19:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aT5KzyuPDKMSMYtpVyIWQldGFFFBfyXRI8bueOHPf48=; b=NBvGc24lR65L3NgxDT6K9RJAas
        rhl9/7C1rv3++q2GuGtZMZU6uNUXc7Im/IPsmPh/7SIS4Xor6I1WuzoPIi7NRnsuXxKDv3RiWnTnZ
        tGGv39U0IgZ4HZIWflu5qJbi7dwnc20FLeh3qlBmyZJnOLPwY6HFHoyBppBpABInBYF6K0la5o6KJ
        Z3rLnE6EnhafyABx1fpCelF0YEzc8lOX9zgEQjm8yc8lTNtGOrw2e1dVb/61g4TKgxn6spVVFpq+B
        p1nBUCxMXdUjj5sJ6AI4FeWwvYkWJ4qFPxNG1gNdTHcftPUJHLZmTLUiMk7ueIs9AS1l2to4yffTW
        SW93Vrsg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkJ2q-0007t4-M0; Wed, 02 Dec 2020 03:43:08 +0000
Date:   Wed, 2 Dec 2020 03:43:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: mapcount corruption regression
Message-ID: <20201202034308.GD11935@casper.infradead.org>
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org>
 <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org>
 <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:28:45PM -0800, Dan Williams wrote:
> On Tue, Dec 1, 2020 at 12:49 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> > > On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > > > Kirill, Willy, compound page experts,
> > > > >
> > > > > I am seeking some debug ideas about the following splat:
> > > > >
> > > > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> > > >
> > > > Mapcount of -1024 is the signature of:
> > > >
> > > > #define PG_guard        0x00000400
> > >
> > > Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> > > in v5.10-rc4 that value is:
> > >
> > > #define PG_table        0x00000400
> >
> > Ah, I was looking at -next, where Roman renumbered it.
> >
> > I know UML had a problem where it was not clearing PG_table, but you
> > seem to be running on bare metal.  SuperH did too, but again, you're
> > not using SuperH.
> >
> > > >
> > > > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > > > as -1024)
> > > >
> > > > I assume you have debug_pagealloc enabled?
> > >
> > > Added it, but no extra spew. I'll dig a bit more on how PG_table is
> > > not being cleared in this case.
> >
> > I only asked about debug_pagealloc because that sets PG_guard.  Since
> > the problem is actually PG_table, it's not relevant.
> 
> As a shot in the dark I reverted:
> 
>     b2b29d6d0119 mm: account PMD tables like PTE tables
> 
> ...and the test passed.

That's not really surprising ... you're still freeing PMD tables without
calling the destructor, which means that you're leaking ptlocks on
configs that can't embed the ptlock in the struct page.

I suppose it shows that you're leaking a PMD table rather than a PTE
table, so that might help track it down.  Checking for PG_table in
free_unref_page() and calling show_stack() will probably help more.
