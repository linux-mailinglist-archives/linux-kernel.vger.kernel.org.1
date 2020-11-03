Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43CC2A37CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgKCAdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:33:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKCAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:33:50 -0500
Date:   Tue, 3 Nov 2020 01:33:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604363628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Y77zxdoENlOcmN7TXezQoE5rEB/c1724Uvi6xgzFbN4=;
        b=IDtvJilpB3dhGEU4+MoaabkPWj1Pw3lho68xze8cDPoOjGCanGINaxHLOnPsudUqdb0Jse
        DA7zOfTnQEPSvoi53R96yAfkV/9Dack82pfFCyCi4/0C8U03uwsgHLP+QYRJvUQcskP9rF
        SOJpakh9HBuI1ghZWN7Ft6Ufw9p+gxRHcUE3yTjhLHSpSsL/jYQAfbdAQEfrvl/G5/xnfe
        TPEwRilkCPace4WIySmPjMbQW4Z5cWTClC4RzVK1Y4MBmwrNrKBp6/+jiH0iT/CuCYSVM9
        b7G9FWhgWVxoAqTsU1cpK5fZ9yhHs6kuRe90DfJeqOpUSJMjg81JqIYQhy7q7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604363628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=Y77zxdoENlOcmN7TXezQoE5rEB/c1724Uvi6xgzFbN4=;
        b=U66ioQL9OTKucJydCuw1jdnhEYPGbmmLfaUA0Fb4gCxBhyuOUz9tL7Mmu7qTyad8RuNFlE
        T+Q/RCXP7KOhSHBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20201103003346.GC52235@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031152605.GD6357@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:26:05AM -0400, Peter Xu wrote:

...

> Shall we document this explicitly (if this patch still needs a repost)?

Yes, this patch series needs a v3 :)

> Seems not straightforward since that seems not the usual way to use seqcount,
> not sure whether I'm the only one that feels this way, though.

Yes, this usage is correct but not common. I've proposed a more explicit
comment above the write section code, in my reply to patch #2.

...

> The other thing is, considering this use of seqcount seems to be quite special
> as explained below, I'm just not sure whether this would confuse lockdep or
> kcsan, etc., if we decide to use write_seqcount_t_begin().
>

Lockdep won't be confused as it's not used in the raw_*() variant of the
seqcount APIs.

AFAIK KCSAN also has some margin to protect itself from this: see
seqlock.h KCSAN_SEQLOCK_REGION_MAX.

Thanks,

> Peter Xu

Ahmed Darwish
Linutronix GmbH
