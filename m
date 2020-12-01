Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD52CADBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgLAUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgLAUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:49:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dyBlRLPwKTQ0rIK/KfQyG6Ob+vSn1EgfGLIeGxV2yms=; b=JJv/jUDUAQHzh744cKMjYelWef
        QTIfn+k/elN1QSMiCosaURKxQ2fWjh8q5u2jiv6QfFKVvUpCoopn/ASQfT2etb0mpcaFppKzMYJXm
        Go2y9Rwev3yIt6lHEo1tzZH2Wx2Q6u9PRMkr63pL1mC/IMEd1XbOi4IkeJ+0HK/hwir/XDFgjgrEN
        cdhpbGfdToA0xP9TZ7gkSGag0nCbiIVH+0pdZciOchpvAvCRGfkDtBJxnzM40g2ajgf/GCFJ2W11C
        YBwt2vpgu5H8EUX4Boxoe/hCjSfDn7VgdY9T2yM55nPU61QYzgqXbURWXBFMxxDDvUGPOpG8UlTrn
        97JljK1A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkCa4-0002i8-S3; Tue, 01 Dec 2020 20:49:00 +0000
Date:   Tue, 1 Dec 2020 20:49:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: mapcount corruption regression
Message-ID: <20201201204900.GC11935@casper.infradead.org>
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org>
 <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > Kirill, Willy, compound page experts,
> > >
> > > I am seeking some debug ideas about the following splat:
> > >
> > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> >
> > Mapcount of -1024 is the signature of:
> >
> > #define PG_guard        0x00000400
> 
> Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> in v5.10-rc4 that value is:
> 
> #define PG_table        0x00000400

Ah, I was looking at -next, where Roman renumbered it.

I know UML had a problem where it was not clearing PG_table, but you
seem to be running on bare metal.  SuperH did too, but again, you're
not using SuperH.

> >
> > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > as -1024)
> >
> > I assume you have debug_pagealloc enabled?
> 
> Added it, but no extra spew. I'll dig a bit more on how PG_table is
> not being cleared in this case.

I only asked about debug_pagealloc because that sets PG_guard.  Since
the problem is actually PG_table, it's not relevant.
