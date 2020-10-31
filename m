Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C052B2A1888
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 16:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgJaP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 11:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgJaP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 11:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604157971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2me1usE7VKXvzg0IlI6joURwpFOQQz4rUA3U1mcAV6o=;
        b=KXjP4LmxKcC4/eGd2q3pUaLLmSQB2tcdiRYPSCe60GzaHUAdXmi8iVVeLWdbMW/AkAWcbV
        BUhu9ax+zOfBSkzHF9mU0XiJD/A6XZfsj20vdQyXMa7NMPtgOEU2N0uu+r/WGMksXp2R4E
        5Gxlik6Q2QwoR7P/IPD30rbLTBwx3YQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-YO4cK8stOJOqF5Vwq4btqw-1; Sat, 31 Oct 2020 11:26:09 -0400
X-MC-Unique: YO4cK8stOJOqF5Vwq4btqw-1
Received: by mail-qt1-f199.google.com with SMTP id d22so5836381qtn.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 08:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2me1usE7VKXvzg0IlI6joURwpFOQQz4rUA3U1mcAV6o=;
        b=WiV3nfRRrRxYU5Gan7gAGRaRAjUWNZsKUaD3BGvQSFJ87OsFXR2+oiGry7LIEHhpRJ
         Veg66F656TKgUuIopydrPcW5Skwe3eaxds+hunEbOk17QtLvYy0WsBwOCrzileEK1+iy
         dTtLPVzDn3VGqOtYcyzk8YnH7dV0JzktwrvbFSt5dgcL5jzQU/RzkI9Hdi0Ec9KZDUSW
         XXBUu9SHxbmi7QNuxirKIjutNTACnZAlThoW+fyw5nNdV1YG9zUVc7x0agKQN/BjG6r6
         WolQ6UcuEKOzY2y2ue7kRSIVgVaZ7KRI91+yH2H3nMvS5qWzNSox/3ghT5UbCLSc82jA
         dttQ==
X-Gm-Message-State: AOAM530lpY0va6/f9aiPohxG9aqZSYLcIkX2Wwrpk77XxFwPQPsGF1xs
        59WH/Sp0J7IwThedmE43ItBM13ycFR/jyLN/pleLL3Bz7qq5937BZGVGOd/HX+dFbbPjnhHKdlU
        t2X6xcF1Z2U9WST/4fN6ybtc8
X-Received: by 2002:ae9:e711:: with SMTP id m17mr7155571qka.255.1604157968604;
        Sat, 31 Oct 2020 08:26:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCNP6aXReDRn+4PUsPoOzm3NjKyM0k0HzGJLLM64juaTSwUG90bum5wxrzK87OXGNddsqUtA==
X-Received: by 2002:ae9:e711:: with SMTP id m17mr7155547qka.255.1604157968249;
        Sat, 31 Oct 2020 08:26:08 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id n3sm4352106qta.10.2020.10.31.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:26:07 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:26:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-kernel@vger.kernel.org,
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
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201031152605.GD6357@xz-x1>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030235121.GQ2620339@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:51:21PM -0300, Jason Gunthorpe wrote:
> > Another pure question: I'm just curious how you find all the statically
> > definied mm_structs, and to make sure all of them are covered (just in case
> > un-initialized seqcount could fail strangely).
> 
> I searched for all MMAP_LOCK_INITIALIZER() places and assumed that
> Michel got them all when he added it :)

Hmm, I should have noticed that before I ask.. :)

> 
> > Actually I'm thinking whether we should have one place to keep all the init
> > vars for all the statically definied mm_structs, so we don't need to find them
> > everytime, but only change that one place.
> 
> I was thinking that as well, most of the places are all the same

Yes, we can work on top.

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
> However, no idea what the intention of the '*_seqcount_t_*' family is
> - it only seems to be used to implement the seqlock..
> 
> Lets add Amhed, perhaps he can give some guidance (see next section)?

IMHO we shouldn't directly use these helpers since they seem to only be used by
lock-associated versions of seqcount types.  But yeah, Amhed would be the best
one to answer...

> 
> > My understanding is that we used raw_write_seqcount_t_begin() because we're
> > with spin lock so assuming we disabled preemption already.
> 
> Here we rely on the exclusive mmap_lock, not a spinlock. This ensures
> only one write side is running concurrently as required by seqcount.

So imho here we have these things to consider during one thread updating the
seqcount_t:

  0. Concurrent read is perfectly welcomed, for sure.

  1. Concurrent writes on seqcount_t: mm sem protects it.

  2. Preempted write (if possible, maybe on RT?): I think it's also protected
     by mm sem, so looks ok too to me.

  3. Preempted/interrupted read on seqcount_t.  Seems to be the one discussed
     below.  Looks safe to me now with below explanation.  However...

> 
> The concern about preemption disable is that it wasn't held for fork()
> before, and we don't need it.. I understand preemption disable regions
> must be short or the RT people will not be happy, holding one across
> all of copy_page_range() sounds bad.
> 
> Ahmed explained in commit 8117ab508f the reason the seqcount_t write
> side has preemption disabled is because it can livelock RT kernels if
> the read side is spinning after preempting the write side. eg look at
> how __read_seqcount_begin() is implemented:
> 
> 	while ((seq = __seqcount_sequence(s)) & 1)			\
> 		cpu_relax();						\
> 
> However, in this patch, we don't spin on the read side.

... Shall we document this explicitly (if this patch still needs a repost)?
Seems not straightforward since that seems not the usual way to use seqcount,
not sure whether I'm the only one that feels this way, though.

> 
> If the read side collides with a writer it immediately goes to the
> mmap_lock, which is sleeping, and so it will sort itself out properly,
> even if it was preempted.
> 
> > An even further pure question on __seqcount_preemptible() (feel free to ignore
> > this question!): I saw that __seqcount_preemptible() seems to have been
> > constantly defined as "return false".  Not sure what happened there..
> 
> The new code has a range of seqcount_t types see
> Documentation/locking/seqlock.rst 'Sequence counters with associated
> locks'
> 
> It uses _Generic to do a bit of meta-programming and creates a compile
> time table of lock properties:
> 
> SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
> SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
> SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
> SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
> SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
> 
> As well as as default set of properties for normal seqcount_t. The
> __seqcount_preemptible() is selected by the _Generic for seqcount_t:
> 
> #define __seqprop(s, prop) _Generic(*(s),				\
> 	seqcount_t:		__seqprop_##prop((void *)(s)),		\
> 
> And it says preemption must be disabled before using the lock:
> 
> static inline void __seqprop_assert(const seqcount_t *s)
> {
> 	lockdep_assert_preemption_disabled();
> }
> 
> And thus no need to have an automatic disable preemption:
> 
> static inline bool __seqprop_preemptible(const seqcount_t *s)
> {
> 	return false;
> }
> 
> Other lock subtypes are different, eg the codegen for mutex will use
> lockdep_assert_held(s->lock) for _assert and true for _preemptible()
> 
> So if we map the 'write begin' entry points:
> 
>  write_seqcount_begin - Enforces preemption off
>  raw_write_seqcount_begin - Auto disable preemption if required (false)
>  raw_write_seqcount_t_begin - No preemption stuff
>  write_seqcount_t_begin - No preemption stuff

Thanks for listing these details.

As a summary, I think I'm convinced maybe we can have this work without disable
preemtion.  It's just that some more comment might be even better.

The other thing is, considering this use of seqcount seems to be quite special
as explained below, I'm just not sure whether this would confuse lockdep or
kcsan, etc., if we decide to use write_seqcount_t_begin().

Thanks,

-- 
Peter Xu

