Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9E27B90B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgI2Awj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgI2Awi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:52:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A171B20773;
        Tue, 29 Sep 2020 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601340758;
        bh=0mD0MAsSQmXLf32VYY8kxZxsnPJYB0TcFxo5l/cuL70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Efa/bidOdurmZfr9p+9R/k4FZ7AS6e2cwywwVg2KEz3zX8Kk9Ee89Ldc4Zt+Hl2mQ
         i1lo46/fajIIrxhMyxijl2kIdyCKiH3Mz1xoWdnOYB2Lku5aN3Kk75rii1PbeSHZ4R
         o5qg6sRE9NF20GUG7peQ7fQkJrWdy2p+fcgTmTDc=
Date:   Mon, 28 Sep 2020 17:52:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] mm/hmm/test: use after free in
 dmirror_allocate_chunk()
Message-Id: <20200928175237.6b3024fe6ad96d70c75d5de1@linux-foundation.org>
In-Reply-To: <20200926221720.GK9916@ziepe.ca>
References: <d1b31586-426a-e0b1-803e-3eff30196c05@web.de>
        <20200926121402.GA7467@kadam>
        <20200926221720.GK9916@ziepe.ca>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 19:17:20 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Sat, Sep 26, 2020 at 03:14:02PM +0300, Dan Carpenter wrote:
> > The error handling code does this:
> > 
> > err_free:
> > 	kfree(devmem);
> >         ^^^^^^^^^^^^^
> > err_release:
> > 	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
> >                            ^^^^^^^^
> > The problem is that when we use "devmem->pagemap.range.start" the
> > "devmem" pointer is either NULL or freed.
> > 
> > Neither the allocation nor the call to request_free_mem_region() has to
> > be done under the lock so I moved those to the start of the function.
> > 
> > Fixes: 1f9c4bb986d9 ("mm/memremap_pages: convert to 'struct range'")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> > ---
> > v2: The first version introduced a locking bug
> > v3: Markus Elfring pointed out that the Fixes tag was wrong.  This bug
> > was in the original commit and then fixed and then re-introduced.  I was
> > quite bothered by how this bug lasted so long in the source code, but
> > now we know.  As soon as it is introduced we fixed it.
> > 
> > One problem with the kernel QC process is that I think everyone marks
> > the bug as "old/dealt with" so it was only because I was added a new
> > check for resource leaks that it was found when it was re-introduced.
> > 
> >  lib/test_hmm.c | 44 ++++++++++++++++++++++----------------------
> >  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> Hi Andrew, 
> 
> I don't have have any hmm related patches this cycle, can you take
> this into your tree?
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks.

It's actually a fix against Dan Williams' -mm patch "mm/memremap_pages:
convert to 'struct range'"
