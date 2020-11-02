Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFD42A2622
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgKBIbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:31:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:46542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgKBIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:31:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DF84AAF1;
        Mon,  2 Nov 2020 08:31:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32EC01E12FB; Mon,  2 Nov 2020 09:31:22 +0100 (CET)
Date:   Mon, 2 Nov 2020 09:31:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201102083122.GA23988@quack2.suse.cz>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030165105.GH19757@quack2.suse.cz>
 <20201030170226.GF2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030170226.GF2620339@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-10-20 14:02:26, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 05:51:05PM +0100, Jan Kara wrote:
> > > @@ -446,6 +447,12 @@ struct mm_struct {
> > >  		 */
> > >  		atomic_t has_pinned;
> > >  
> > > +		/**
> > > +		 * @write_protect_seq: Odd when any thread is write protecting
> > > +		 * pages in this mm, for instance during fork().
> > > +		 */
> > > +		seqcount_t write_protect_seq;
> > > +
> > 
> > So this comment isn't quite true. We can be writeprotecting pages due to
> > many other reasons and not touch write_protect_seq. E.g. for shared
> > mappings or due to explicit mprotect() calls. So the write_protect_seq
> > protection has to be about something more than pure write protection. One
> > requirement certainly is that the VMA has to be is_cow_mapping(). What
> > about mprotect(2) calls? I guess the application would have only itself to
> > blame so we don't care?
> 
> Yes, that sounds right, How about
> 
> /**
>  * @write_protect_seq: Locked when any thread is write protecting
>  * pages for COW in this mm, for instance during page table copying
           ^^^ maybe I'd write a bit more explicitly "... write protecting
pages mapped by this mm to enforce later COW, ..."

>  * for fork().
>  */
> 
> mprotect and shared mappings cause faults on write access not COW?

Correct.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
