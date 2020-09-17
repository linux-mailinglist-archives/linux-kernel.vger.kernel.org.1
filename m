Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5D26E925
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIQWtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:49:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:15217 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgIQWtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:49:03 -0400
IronPort-SDR: fTTBK0nT3ZT8Ol3hmpZ4b28YZ7AzajTHPZ+vooj94cq9fBkqyCJxA32Y/s8LlbhTPEbbfxXXl0
 GJMeWDIeh4mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139312774"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="139312774"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 15:48:58 -0700
IronPort-SDR: CqwYh17Q/1F8jKVzCm2bltk11mbTsSduNQ8JbkQ/9w68yIO/U16V+vAO1goEACHYyACaA0koLy
 /tDsNZ9vHsHg==
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="507920531"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 15:48:57 -0700
Date:   Thu, 17 Sep 2020 15:48:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200917224857.GF2540965@iweiny-DESK2.sc.intel.com>
References: <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <20200917181411.GA133226@xz-x1>
 <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
 <20200917190332.GB133226@xz-x1>
 <CAHk-=wgw3GNyF_6euymOFxM62Y3B=C=f2iUJn8Py-u5YELJ5JA@mail.gmail.com>
 <20200917200638.GM8409@ziepe.ca>
 <CAHk-=wh+qz0oOjyiQFXR_73RYSDUmJwHC8xd=KG0RzELnbS5OA@mail.gmail.com>
 <20200917214059.GA162800@xz-x1>
 <20200917220900.GO8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917220900.GO8409@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:09:00PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 17, 2020 at 05:40:59PM -0400, Peter Xu wrote:
> > On Thu, Sep 17, 2020 at 01:35:56PM -0700, Linus Torvalds wrote:
> > > For that to happen, we'd need to have the vma flag so that we wouldn't
> > > have any worry about non-pinners, but as you suggested, I think even
> > > just a mm-wide counter - or flag - to deal with the fast-bup case is
> > > likely perfectly sufficient.
> > 
> > Would mm_struct.pinned_vm suffice?
> 
> I think that could be a good long term goal
> 
> IIRC last time we dug into the locked_vm vs pinned_vm mess it didn't
> get fixed. There is a mix of both kinds, as you saw, and some
> resistance I don't clearly remember to changing it.
> 
> My advice for this -rc fix is to go with a single bit in the mm_struct
> set on any call to pin_user_pages*
> 
> Then only users using pin_user_pages and forking are the only ones who
> would ever do extra COW on fork. I think that is OK for -rc, this
> workload should be rare due to the various historical issues. Anyhow,
> a slow down regression is better than a it is broken regression.
> 
> This can be improved into a counter later. Due to the pinned_vm
> accounting all call sites should have the mm_struct at unpin, but I
> have a feeling it will take a alot of driver patches to sort it all
> out.

Agreed.  The HFI1 driver for example increments/decrements pinned_vm on it's
own.  I've kind of always felt dirty for that...

I think long term it would be better to move this accounting to
pin_user_pages() but Jason is correct that I think that is going to be too
complex for an rc.

Could we move pinned_vm out of the drivers/rdma subsystem?

Ira

> 
> Jason
> 
