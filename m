Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6972271E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIUIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:35:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgIUIfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:35:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B050AB50F;
        Mon, 21 Sep 2020 08:35:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0ACAE1E12E1; Mon, 21 Sep 2020 10:35:05 +0200 (CEST)
Date:   Mon, 21 Sep 2020 10:35:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200921083505.GA5862@quack2.suse.cz>
References: <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
 <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919000153.GZ8409@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-09-20 21:01:53, Jason Gunthorpe wrote:
> On Fri, Sep 18, 2020 at 02:06:23PM -0700, John Hubbard wrote:
> > On 9/18/20 1:40 PM, Peter Xu wrote:
> > > On Fri, Sep 18, 2020 at 02:32:40PM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Sep 18, 2020 at 12:40:32PM -0400, Peter Xu wrote:
> > > > 
> > > > > Firstly in the draft patch mm->has_pinned is introduced and it's written to 1
> > > > > as long as FOLL_GUP is called once.  It's never reset after set.
> > > > 
> > > > Worth thinking about also adding FOLL_LONGTERM here, at last as long
> > > > as it is not a counter. That further limits the impact.
> > > 
> > > But theoritically we should also trigger COW here for pages even with PIN &&
> > > !LONGTERM, am I right?  Assuming that FOLL_PIN is already a corner case.
> > > 
> > 
> > This note, plus Linus' comment about "I'm a normal process, I've never
> > done any special rdma page pinning", has me a little worried. Because
> > page_maybe_dma_pinned() is counting both short- and long-term pins,
> > actually. And that includes O_DIRECT callers.
> > 
> > O_DIRECT pins are short-term, and RDMA systems are long-term (and should
> > be setting FOLL_LONGTERM). But there's no way right now to discern
> > between them, once the initial pin_user_pages*() call is complete. All
> > we can do today is to count the number of FOLL_PIN calls, not the number
> > of FOLL_PIN | FOLL_LONGTERM calls.
> 
> My thinking is to hit this issue you have to already be doing
> FOLL_LONGTERM, and if some driver hasn't been properly marked and
> regresses, the fix is to mark it.
> 
> Remember, this use case requires the pin to extend after a system
> call, past another fork() system call, and still have data-coherence.
> 
> IMHO that can only happen in the FOLL_LONGTERM case as it inhernetly
> means the lifetime of the pin is being controlled by userspace, not by
> the kernel. Otherwise userspace could not cause new DMA touches after
> fork.

I agree that the new aggressive COW behavior is probably causing issues
only for FOLL_LONGTERM users. That being said it would be nice if even
ordinary threaded FOLL_PIN users would not have to be that careful about
fork(2) and possible data loss due to COW - we had certainly reports of
O_DIRECT IO loosing data due to fork(2) and COW exactly because it is very
subtle how it behaves... But as I wrote above this is not urgent since that
problematic behavior exists since the beginning of O_DIRECT IO in Linux.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
