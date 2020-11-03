Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4992A3D06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKCGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgKCGw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:52:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F03C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 22:52:28 -0800 (PST)
Date:   Tue, 3 Nov 2020 07:52:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604386347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/Cg7gELMzS7/FP4DlaM4mCIkHjMZOQ5NVP/5BMfjis=;
        b=HJveoUgDl8SjSD3w/jn8yikeAX1ydnR7Vfz+2ZFXt0j+VaBPcvg4vka5ZQY98nLbbqVKDy
        19Wonz+AYgAsHiexZPt9EJGY0rWzfFMLM27SV1MOfvHVK1AQ5NNRKNtuSgqXb+fp28X2X6
        8FtFMAHnjg74meDW0VxTsinqCh4iti3jYg0h9h/0hggtdVqb/wsJ/x9wiZcFoYYfmar++Q
        7XDhJO2Q5GSyxn68+n12punHrHBtfr5Kl7oNO7v7gu4WXqwpwgQoH6jBA3fdsYf/yXfM6P
        PF+i94YyWQb+f5wErcY9ItFp9EiZX2vVnKS5nMSxkGAXTFlm8HmDEQdzQoo2Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604386347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/Cg7gELMzS7/FP4DlaM4mCIkHjMZOQ5NVP/5BMfjis=;
        b=F4hKjsgLXyfQhgMhIbM7JHGHVdQ1PvHGX8WQJiT1RM9hd5QeSabL5hDt+DyK8xM9V4S22G
        gUHESrBbLNaQU9BA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20201103065225.GA63301@lx-t490>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <20201030225250.GB6357@xz-x1>
 <20201030235121.GQ2620339@nvidia.com>
 <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:20:45PM -0800, John Hubbard wrote:
> On 11/2/20 4:41 PM, Ahmed S. Darwish wrote:
> > On Mon, Nov 02, 2020 at 08:25:32PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 03, 2020 at 01:17:12AM +0100, Ahmed S. Darwish wrote:
> > >
> > > > Please stick with the official exported API: raw_write_seqcount_begin().
> > >
> > > How did you know this was 'offical exported API' ??
> > >
> >
> > All the official exported seqlock.h APIs are marked with verbose
> > kernel-doc annotations on top. The rest are internal...
> >
>
> OK, but no one here was able to deduce that, probably because there is not
> enough consistency throughout the kernel to be able to assume such things--even
> though your seqlock project is internally consistent. It's just not *quite*
> enough communication.
>
> I think if we added the following it would be very nice:
>

The problem is, I've already documented seqlock.h to death.... There are
more comments than code in there, and there is "seqlock.rst" under
Documentation/ to further describe the big picture.

There comes a point where you decide what level of documentation to add,
and what level to skip.

Because in the end, you don't want to confuse "Joe, the general driver
developer" with too much details that's not relevant to their task at
hand.  (I work in the Embedded domain, and I've seen so much ugly code
from embedded drivers/SoC developers already, sorry)

See for example my reply to Linus, where any talk about the lockdep-free
and barrier-free parts of the API was explicitly not mentioned in
seqlock.rst. This was done on purpose: 1) you want to keep the generic
case simple, but the special case do-able, 2) you want to encourage
people to use the standard entry/exit points as much as possible.

> a) Short comments to the "unofficial and internal" routines, identifying them as
> such, and
>
> b) Short comments to the "official API for general use", also identifying
> those as such.
>

I really think the already added kernel-doc is sufficient...

See for example __read_seqcount_begin() and __read_seqcount_retry().
They begin with "__", but they are semi-external seqlock.h API that are
used by VFS to avoid barriers. And these APIs are then polymorphised
according to the write serialization lock type, and so on.

So the most consistent way for seqlock.h was to use kernel-doc as *the*
marker for exported functions.

This is not unique to seqlock.h by the way. The same pattern is heavily
used by the DRM folks.

Yes, of course, we can add even more comments to seqlock.h, but then, I
honestly think it would be too much that maybe people will just skip
reading the whole thing altogether...

> c) A comment about what makes "raw" actually raw, for seqlock.
>

That's already documented.

What more can really be written than what's in seqlock.h below??

  /**
   * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep

  /**
   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
   *                        lockdep and w/o counter stabilization

  /**
   * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep

  /**
   * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep

>
> Since I'm proposing new work, I'll also offer to help, perhaps by putting together
> a small patch to get it kicked off, if you approve of the idea.
>

Patches are always welcome of course, and please put me in Cc. I don't
approve or deny anything though, that's the locking maintainers job :)

Kind regards,

> John Hubbard
> NVIDIA

--
Ahmed S. Darwish
Linutronix GmbH
