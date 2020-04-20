Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7E1B15D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgDTTXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:23:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F38C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1YuFJrpCywKX/ru6CgGT4p1ibPU8mCdoRQpUpGvC5RA=; b=K6dzNYEyCQ5AWIZMkQIgE40HQm
        dh/BiL/NzvNmSSvYu4w1srUOpf8aGShDFt8H3PM80RSoRI9VljkJlE76nSyoMsn8AL8cCvjHEI5Yc
        6+bUnusFAmulLXvCXiH4xp7ce7H/AbSBSdiqi0lBPDg7Aqc/7J5z8rUWYKTGL0wpiADgkl0OlxNGW
        mziyiqMMKZ0zFgL9YJOmg5h3AgNqHFBKXXS7LG4qKXVly3BjtSblFHdgDADXoPklfm3QBkigEXTzV
        dMqWlSUsQnJK6J/q0EsAP5OjISyJ4xifvqF3hpkgekoC7ANT70F+ktqDj5qY8RdBBCs1Rh6N8v+6v
        v8EYWfMg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQc0o-0003T9-7A; Mon, 20 Apr 2020 19:23:22 +0000
Date:   Mon, 20 Apr 2020 12:23:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 07/10] mmap locking API: add
 mmap_read_trylock_non_owner()
Message-ID: <20200420192322.GD5820@bombadil.infradead.org>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-8-walken@google.com>
 <20200420182211.exrzkszefraeylv2@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420182211.exrzkszefraeylv2@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:22:11PM -0400, Daniel Jordan wrote:
> On Tue, Apr 14, 2020 at 05:43:50PM -0700, Michel Lespinasse wrote:
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 11d41f0c7005..998968659892 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -317,7 +316,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> >  	 * with build_id.
> >  	 */
> >  	if (!user || !current || !current->mm || irq_work_busy ||
> > -	    mmap_read_trylock(current->mm) == 0) {
> > +	    !mmap_read_trylock_non_owner(current->mm)) {
> >  		/* cannot access current->mm, fall back to ips */
> >  		for (i = 0; i < trace_nr; i++) {
> >  			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> > @@ -342,16 +341,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
> >  	}
> >  
> >  	if (!work) {
> > -		mmap_read_unlock(current->mm);
> > +		mmap_read_unlock_non_owner(current->mm);
> 
> These 'non_owner' calls are not intuitive because current _is the owner, so the
> v3 version seems better, even if it adds a special wrapper for rwsem_release.
> 
> Though it makes some sense if you think, "we're consistently using the
> non_owner APIs because there's a legitimate use somewhere else," so I'm fine
> either way.

I'm not really a big fan of v3 nor v4.  What I'd like to see is a
'transfer of ownership' API.  This could be to a different task, IRQ work,
RCU, softirq, timer, ...

That would let us track locking dependencies across complex flows, eg this
wouldn't be warned about right now:

rcu_work():
	lock(C)
	kfree(B)
	unlock(A)
	unlock(C)

thread 1:
	lock(A)
	call_rcu(B)

thread 2:
	lock(C)
	synchronize_rcu()
	unlock(C)

but if we had an API that transferred ownership of A to RCU, then we'd
see the C->RCU->A->C cycle.

This is perhaps a bit much work to require of Laurent in order to get
this patchset merged, but something to think about.
