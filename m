Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8122F2A365C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKBWTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:19:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:19:53 -0500
Date:   Mon, 2 Nov 2020 23:19:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604355592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=gqiPjScE5SdOJ0m0YaDRtOtnRuC/cXWpfBGliTbmIWA=;
        b=aWf+gXTCp80n+HKo7bnq7KVcNRhJg5jV6Mn1jzD6rqAOFg4jfeamDbshYhRaQJrqWA1Nfe
        +yw6XD2+GFvlbM/Yo2NyPo0latCJPJhPvdSn070cbBTvk8b/HNr5Tpnw8cHoorC8lIXnSM
        8cD8TPHyEMjmGPSJneV0F408rQOvIAgjsDBv5eYE8omhA2mtfxTh8s9esxZ2U8zCXCdNmi
        l+5BHuHVSA2FFHc8BM7mC/op3uxMO9WoTeTOJ4zeVkmssqIbldJFKgfBJiK1OfOLhd7Onu
        j//iNS947DFS2ogjviPGyWkNjkjvy93qCA0nQRdThDCbJCjKEMu1gBUsmr+fTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604355592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=gqiPjScE5SdOJ0m0YaDRtOtnRuC/cXWpfBGliTbmIWA=;
        b=93ql7T2QRhClLbpJIwM7Al1jkiMyWdZWc/BTBv31stUKAlEBHKpomzkxdb9PPsxAQ3Yk54
        1oK4EX69XnwrB9CA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
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
Subject: Re: [PATCH v2 0/2] Add a seqcount between gup_fast and
 copy_page_range()
Message-ID: <20201102221945.GA48454@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

Thanks for keeping me in the loop on this.

I've also added the locking maintainers in Cc. IMHO there are some
seqlock.h API violations in this series, and they should have the final
say on this.

On Fri, Oct 30, 2020 at 11:46:19AM -0300, Jason Gunthorpe wrote:
>
> As discussed and suggested by Linus use a seqcount to close the small race
> between gup_fast and copy_page_range().
>
> Unfortunately the good suggestion to just use write_seqcount_begin() blows
> up lockdep immediately due to the (new?) requirement that the write side
> of seqcount be in a preempt disabled region.

Disabling preemption for seqcount_t write-side critical sections was
never a new requirement. It has always been this way, for the reasons
explained at Documentation/locking/seqlock.rst, "Introduction" section.

The recent seqcount_t changes did not mandate any new rules. This was
done explicitly, and on-purpose, not to break any of the *large* set of
existing seqcount_t call sites. It added multiple lockdep asserts
though, to catch a number of (already) buggy users, and they were fixed
beforehand.

It seems you have a special case here, so I'll continue discussing this
at patch #2 where the code resides. Just wanted to answer the "(new?)"
part above.

>                                               For this application it does
> not seem like a good idea, nor is it necessary as we don't spin on retry.
> This is solved by being the first place to use raw_write_seqcount_t_begin()
>

Regardless of this series write side preemptibility requirements, the
"_write_seqcount_*t*_()" interfaces are internal to seqlock.h and should
_never_ be used outside of it.

For plain seqcount_t, raw_write_seqcount_begin() is equivalent to
raw_write_seqcount_*t*_begin() anyway, and should already satisfy your
needs.

/me jumps to patch #2 now...

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
