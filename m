Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDFE2A3790
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgKCARR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:17:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCARQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:17:16 -0500
Date:   Tue, 3 Nov 2020 01:17:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604362634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MByvycUX+rn60Vq2M21WP4xK2GmTKyADM01aIsR7iQU=;
        b=GP7dznI9z6LRZT6wgbHKVocpu2MqqLHkQBq5MI6Ao32VwjpYLBWttOdvkYqXKu6H0sfUY6
        A+izxSs9gBfEX3xDUXVRefkNu9BSc0A4UyKg6KIBhR4nr/RHT7brjb65o3wuo8nVJ+CqRX
        quVSL8JMQEl2EieF/ThIPPgpiNOYvredmOZ01Zx69bHtL37SjTGQNdmMrn0wEBReI14BOx
        qfrM3eWDJkuoP9VU+Yhm9YlPIGWzYQIzzydaBOsLAej4WBJCZPZPsNpfC2K5SzkROhRFiB
        HYJ9NLGVpHr8yAUY05ou3uDRotclr17GvLU0DB1bkBdj76UcwAUMo+BbFfaxeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604362634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MByvycUX+rn60Vq2M21WP4xK2GmTKyADM01aIsR7iQU=;
        b=47Sa4dnZdc4cdcAGn1otUqMq1Eeu10KAf8Kx3rrLhXH/EqPxkJMQhQ9hf6hFrvNxUbaSOf
        aY/zSGYgVQdj4LBA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201103001712.GB52235@lx-t490>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030235121.GQ2620339@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:51:21PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 30, 2020 at 06:52:50PM -0400, Peter Xu wrote:

...

>
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index c48f8df6e50268..294c2c3c4fe00d 100644
> > > +++ b/mm/memory.c
> > > @@ -1171,6 +1171,12 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > >  		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
> > >  					0, src_vma, src_mm, addr, end);
> > >  		mmu_notifier_invalidate_range_start(&range);
> > > +		/*
> > > +		 * The read side doesn't spin, it goes to the mmap_lock, so the
> > > +		 * raw version is used to avoid disabling preemption here
> > > +		 */
> > > +		mmap_assert_write_locked(src_mm);
> > > +		raw_write_seqcount_t_begin(&src_mm->write_protect_seq);
> >
> > Would raw_write_seqcount_begin() be better here?
>
> Hum..
>
> I felt no because it had the preempt stuff added into it, however it
> would work - __seqcount_lock_preemptible() == false for the seqcount_t
> case (see below)
>
> Looking more closely, maybe the right API to pick is
> write_seqcount_t_begin() and write_seqcount_t_end() ??
>

No, that's not the right API: it is also internal to seqlock.h.

Please stick with the official exported API: raw_write_seqcount_begin().

It should satisfy your needs, and the raw_*() variant is created exactly
for contexts wishing to avoid the lockdep checks (e.g. NMI handlers
cannot invoke lockdep, etc.)

> However, no idea what the intention of the '*_seqcount_t_*' family is
> - it only seems to be used to implement the seqlock..
>

Exactly. '*_seqcount_t_*' is a seqlock.h implementation detail, and it
has _zero_ relevance to what is discussed in this thread actually.

...

> Ahmed explained in commit 8117ab508f the reason the seqcount_t write
> side has preemption disabled is because it can livelock RT kernels if
> the read side is spinning after preempting the write side. eg look at
> how __read_seqcount_begin() is implemented:
>
> 	while ((seq = __seqcount_sequence(s)) & 1)			\
> 		cpu_relax();						\
>
> However, in this patch, we don't spin on the read side.
>
> If the read side collides with a writer it immediately goes to the
> mmap_lock, which is sleeping, and so it will sort itself out properly,
> even if it was preempted.
>

Correct.

Thanks,

--
Ahmed Darwish
Linutronix GmbH
