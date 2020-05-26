Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289861A8B39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505059AbgDNTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 15:40:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:59971 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505034AbgDNTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:39:53 -0400
IronPort-SDR: 9udZDNIetMdTLDgz92JTZohTV9yhzUFIF+4Nhm+xer3tMBOnifQQ7riCGJ2P8cRNbMY+KL2a3V
 nQXRO/cMtRqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:39:53 -0700
IronPort-SDR: jwBrX7DN0JzzBuuEtGDysHoEvsUWmL3iCQ9lRJ3paKFP8WejhWaNT7aV8D+b7r6QtnNSTXCBDR
 1utJOvtdJe3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="245503305"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2020 12:39:53 -0700
Date:   Tue, 14 Apr 2020 12:39:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/gup: dereference page table entry using helper
Message-ID: <20200414193952.GC1853609@iweiny-DESK2.sc.intel.com>
References: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
 <20200414163234.GG5100@ziepe.ca>
 <20200414185829.GB1853609@iweiny-DESK2.sc.intel.com>
 <20200414190620.GJ5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414190620.GJ5100@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:06:20PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 14, 2020 at 11:58:29AM -0700, Ira Weiny wrote:
> > On Tue, Apr 14, 2020 at 01:32:34PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 14, 2020 at 05:10:01PM +0200, Alexander Gordeev wrote:
> > > > Commit 0005d20 ("mm/gup: Move page table entry dereference
> > > > into helper function") wrapped access to page table entries
> > > > larger than sizeof(long) into a race-aware accessor. One of
> > > > the two dereferences in gup_fast path was however overlooked.
> > > > 
> > > > CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > CC: linux-mm@kvack.org
> > > > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > > >  mm/gup.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index d53f7dd..eceb98b 100644
> > > > +++ b/mm/gup.c
> > > > @@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > > >  		if (!head)
> > > >  			goto pte_unmap;
> > > >  
> > > > -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > > +		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {
> > > 
> > > It doesn't seem like this needs the special helper as it is just
> > > checking that the pte hasn't changed, it doesn't need to be read
> > > exactly.
> > > 
> > > But it probably should technically still be a READ_ONCE. Although I
> > > think the atomic inside try_grab_compound_head prevents any real
> > > problems.
> > 
> > I think we should go for consistency here and use the helper function.
> 
> It seems quite expensive to do two more unncessary barriers..

But won't a failure to read the 'real' pte result in falling back to GUP slow?

Not sure which is worse?

And most arch's don't suffer from this...

Ira

