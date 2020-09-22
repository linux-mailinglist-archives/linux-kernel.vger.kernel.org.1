Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868B2745B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVPs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgIVPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600789738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5WSEXBgGTOxpyvYjGWGStBPmhuahuiY9FhGyjHnpfvI=;
        b=CUeeEnbi6mVUD7vC3zZiO/s42ZHAbgFhRw1hy6btzKa+E68GUf+FMkuBwrrgUykjt+iBWh
        QerUQyepbDKx87LkOrHacIG/jn5KVKz16AiHuqViIkUm4BkkYTRRcmE6NwSXnIj2Fc8unz
        b4ytNcDwcsIWaE6x8wE09g6bjZM7FCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-i7QyB6gzMpGIsuboqX56xg-1; Tue, 22 Sep 2020 11:48:54 -0400
X-MC-Unique: i7QyB6gzMpGIsuboqX56xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 556A88064BA;
        Tue, 22 Sep 2020 15:48:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4DA6981C41;
        Tue, 22 Sep 2020 15:48:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 17:48:52 +0200 (CEST)
Date:   Tue, 22 Sep 2020 17:48:46 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922154845.GE11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153612.GF19098@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Peter Xu wrote:
>
> On Tue, Sep 22, 2020 at 12:18:16PM +0200, Oleg Nesterov wrote:
> > On 09/22, Oleg Nesterov wrote:
> > >
> > > On 09/21, Peter Xu wrote:
> > > >
> > > > @@ -866,13 +877,18 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >  	pte_unmap_unlock(orig_dst_pte, dst_ptl);
> > > >  	cond_resched();
> > > >
> > > > -	if (entry.val) {
> > > > -		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0)
> > > > +	switch (copy_ret) {
> > > > +	case COPY_MM_SWAP_CONT:
> > > > +		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
> > > >  			return -ENOMEM;
> > > > -		progress = 0;
> > > > +		break;
> > >
> > > Note that you didn't clear copy_ret, it is still COPY_MM_SWAP_CONT,
> > >
> > > > +	default:
> > > > +		break;
> > > >  	}
> > > > +
> > > >  	if (addr != end)
> > > >  		goto again;
> > >
> > > After that the main loop can stop again because of need_resched(), and
> > > in this case add_swap_count_continuation(data.entry) will be called again?
> >
> > No, this is not possible, copy_one_pte() should be called at least once,
> > progress = 0 before restart. Sorry for noise.
>
> Oh wait, I think you're right... when we get a COPY_MM_SWAP_CONT, goto "again",
> then if there're 32 pte_none() ptes _plus_ an need_resched(), then we might
> reach again at the same add_swap_count_continuation() with the same swp entry.

Yes, please see my reply to 4/5 ;)

> However since I didn't change this logic in this patch, it probably means this
> bug is also in the original code before this series...  I'm thinking maybe I
> should prepare a standalone patch to clear the swp_entry_t and cc stable.

Well, if copy_one_pte(src_pte) hits a swap entry and returns entry.val != 0, then
pte_none(*src_pte) is not possible after restart? This means that copy_one_pte()
will be called at least once.

So _think_ that the current code is fine, but I can be easily wrong and I agree
this doesn't look clean.

Oleg.

