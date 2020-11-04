Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7264A2A5D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgKDDRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:17:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKDDRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:17:15 -0500
Date:   Wed, 4 Nov 2020 04:17:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604459833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bH5n5uofGlK83e8+oI2etgYM3sHhSJQ2RmcQs9aKcg=;
        b=DJnH97AXqvOcoZtXhyJWk/S7fnDW66YKb/wkCVoGdnriRevjBoy6Vf4q32UKeFDkkYuijp
        IZCBU/HM7eHsMsjnS6c99TQ74CH4k+fnSs8YGfvP5Ot3uyftqpYncG34N+Z28Dn/JZdlu0
        yeOeZBzAhGRFP4uRCVsggFhOlEDdVMtuLXYhVHmSJVoIOUoIJmzVKH95RbXEJDUtmdkYMh
        YlW8rIgPnNPQSS5/mCQUddLljHpmKLNaUnRrQrH2/uZp2Icv/KyLE7G5vq3EkprrDpW2v7
        gxDLkKh8eJLhQk0DGot18z+P4J/w+m9rUBtodY6bRm6oWta0J2T0WhkRJo2u8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604459833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bH5n5uofGlK83e8+oI2etgYM3sHhSJQ2RmcQs9aKcg=;
        b=fQ+G3bXHhsEC3Byj/uV3DZxxLN9/4FUOgt5WyqFKGn+44u+RKFgzxD+5qV0gwBEGONs9o7
        JKsixHNRyWFhWVAg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
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
Message-ID: <20201104031711.GA227990@lx-t490>
References: <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
 <20201103065225.GA63301@lx-t490>
 <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
 <20201104013212.GA82153@lx-t490>
 <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:01:30PM -0800, John Hubbard wrote:
> On 11/3/20 5:32 PM, Ahmed S. Darwish wrote:
...
> >   #define __read_seqcount_retry(s, start)					\
> > -	__read_seqcount_t_retry(__seqcount_ptr(s), start)
> > +	__do___read_seqcount_retry(__seqcount_ptr(s), start)
>
...
> A nit: while various numbers of leading underscores are sometimes used, it's a lot
> less common to use, say, 3 consecutive underscores (as above) *within* the name. And
> I don't think you need it for uniqueness, at least from a quick look around here.
>
...
> But again, either way, I think "do" is helping a *lot* here (as is getting rid
> of the _t_ idea).

The three underscores are needed because there's a do_ version for
read_seqcount_retry(), and another for __read_seqcount_retry().

Similarly for {__,}read_seqcount_begin(). You want to be very careful
with this, and never mistaknely mix the two, because it affects some VFS
hot paths.

Nonetheless, as you mentioned in the later (dropped) part of your
message, I think do_ is better than __do_, so the final result will be:

  do___read_seqcount_retry()
  do_read_seqcount_retry()
  do_raw_write_seqcount_begin()
  do_raw_write_seqcount_end()
  do_write_seqcount_begin()
  ...

and so on.

I'll wait for some further feedback on the two patches (possibly from
Linus or PeterZ), then send a mini patch series.

(This shouldn't block a v3 of Jason's mm patch series though, as it will
 be using the external seqlock.h APIs anyway...).

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
