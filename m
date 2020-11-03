Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBEE2A4C35
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgKCRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:03:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728228AbgKCRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604423013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zOnoIciI0nLpKfwERbfxFpmQzoaz6nBi64SrOrNElY=;
        b=TfN8GDJl0QZJwgCynhnRFRWqE0oiunkZ5B5wK4tpearlOtj1g7/wJFDy1BXO8AU7xyICtP
        zTe+SRXSs3ZDJv1gEBlipBMK6ZIxcOj4kFdgPfJP+EtkwonwZMRfYLKwTybbGpKpAeVoqP
        RM9od/2l35eqZ+ZldAeGOmDh15oDauw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ue_YWWrVNmmrr332psvJIA-1; Tue, 03 Nov 2020 12:03:31 -0500
X-MC-Unique: ue_YWWrVNmmrr332psvJIA-1
Received: by mail-qv1-f71.google.com with SMTP id d41so10558794qvc.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zOnoIciI0nLpKfwERbfxFpmQzoaz6nBi64SrOrNElY=;
        b=EY2QT5HxVm49sLBDaAkSyyPzCU67glusfidFJp6lG0KDiARKBChytuAEWhpQg5wNZN
         5nNhR/PmtLPexvtk7CCC+vXJQ7W8sCZfgqjE5fdlR1I8zXd3ZfUcqMGNM/Mc756ACxyO
         6uAKBxH5O/8QGe7osq7aimKgGa/2WdcOtQvo38JvoarSz/uhKyeK6V7ZYW6UyAn+A5eC
         UXEW6RWKREj1+AoiwhL3pTqNVPUNqsEa3p/GlcS3XLZ+RTtZCzgWweIyWH99t7d1ArJk
         qbGMgOYZxk55r584tS/qJDxyum7bLZuu/YuoiG4dMjjGtsnxDSJoFuGUuRgs9a8bOumB
         tTRw==
X-Gm-Message-State: AOAM533yrpPr46j+3wnR6FfJqz4Iau1Ca7B0UzTe1HeVA6w0rW7ODdg/
        boij2AhHpYQBGRnfiKxEmr1+/lAPQsvyhSRh12x/psYB+5Qqj3lCs1anmcVbS5Gy8bkRV6MM//T
        vLdaXBdLBNlRuwOTDdNItLKLl
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr19954724qka.175.1604423010410;
        Tue, 03 Nov 2020 09:03:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJz+xNdHIKTAISQMZrx5HscDgQ8KLSo0JFC9F0Nmsr/u3TxYevfSuB1UCc+ACiaHiL0EByXw==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr19954697qka.175.1604423010161;
        Tue, 03 Nov 2020 09:03:30 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id n201sm10861996qka.32.2020.11.03.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:03:29 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:03:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20201103170327.GJ20600@xz-x1>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103001712.GB52235@lx-t490>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 01:17:12AM +0100, Ahmed S. Darwish wrote:
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index c48f8df6e50268..294c2c3c4fe00d 100644
> > > > +++ b/mm/memory.c
> > > > @@ -1171,6 +1171,12 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > > >  		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
> > > >  					0, src_vma, src_mm, addr, end);
> > > >  		mmu_notifier_invalidate_range_start(&range);
> > > > +		/*
> > > > +		 * The read side doesn't spin, it goes to the mmap_lock, so the
> > > > +		 * raw version is used to avoid disabling preemption here
> > > > +		 */
> > > > +		mmap_assert_write_locked(src_mm);
> > > > +		raw_write_seqcount_t_begin(&src_mm->write_protect_seq);
> > >
> > > Would raw_write_seqcount_begin() be better here?
> >
> > Hum..
> >
> > I felt no because it had the preempt stuff added into it, however it
> > would work - __seqcount_lock_preemptible() == false for the seqcount_t
> > case (see below)
> >
> > Looking more closely, maybe the right API to pick is
> > write_seqcount_t_begin() and write_seqcount_t_end() ??
> >
> 
> No, that's not the right API: it is also internal to seqlock.h.
> 
> Please stick with the official exported API: raw_write_seqcount_begin().
> 
> It should satisfy your needs, and the raw_*() variant is created exactly
> for contexts wishing to avoid the lockdep checks (e.g. NMI handlers
> cannot invoke lockdep, etc.)

Ahmed, Jason, feel free to correct me - but I feel like what Jason wanted here
is indeed the version that does not require disabling of preemption, a.k.a.,
write_seqcount_t_begin() and write_seqcount_t_end(), since it's preempt-safe if
the read side does not retry.  Not sure whether there's no "*_t_*" version of it.

Another idea is that maybe we can use the raw_write_seqcount_begin() version,
instead of in copy_page_range() but move it to copy_pte_range().  That would
not affect normal Linux on preemption I think, since when reach pte level we
should have disabled preemption already after all (by taking the pgtable spin
lock).  But again there could be extra overhead since we'll need to take the
write seqcount very often (rather than once per fork(), so maybe there's some
perf influence), also that means it'll be an extra/real disable_preempt() for
the future RT code if it'll land some day (since again rt_spin_lock should not
need to disable preemption, iiuc, which is used here).  So seems it's still
better to do in copy_page_range() as Jason proposed.

Thanks,

-- 
Peter Xu

