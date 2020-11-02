Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AEB2A3762
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgKBX6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:58:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD18C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:58:34 -0800 (PST)
Date:   Tue, 3 Nov 2020 00:58:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604361512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=EUc8ouU+wBbKL35b1Wz4H1oFm1iThH4UiokAYDkphtI=;
        b=mUjJO30zHIraTb9wkx4VJj8y4oSR6Q5RciQVCCSg/3nHP9zRU6cX8hE29ULf8MyV9miP1z
        Z631a4hPVaBBxRxXnvsTFH4bIRIZ4K/rfD0Q5TDvB4vrBBhtHOgWszuZHNSdB+9DSpq/cb
        APTLh3dMUUwDHH0irMGnfnxYGu3zf4CYL0ESe1+DxKgwWqsWy7zWwk92rWLdrPIYdnvyw7
        86RR0dlXh4wxsW70k0dr1yWc7bvqDhZLl/tj4knWJ0G42jhvY1BalIqSPxBbmXk5mvnbPp
        1ZnicxPBHRL+9Abof6uK7XOhifXeV+7BJCUXmEi4X7vGBHYt/9xJXIpp89IkXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604361512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=EUc8ouU+wBbKL35b1Wz4H1oFm1iThH4UiokAYDkphtI=;
        b=myFbIB/Rg7QAUo0gPSmUmACCtS8QYcTO2Hfc4GSxOC9/ctr4bUEMxBvtKoyZbIP1UVxw9V
        9D2mOHVkrEAgJUAA==
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
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201102235831.GA52235@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:46:21AM -0300, Jason Gunthorpe wrote:

...

> diff --git a/mm/memory.c b/mm/memory.c
> index c48f8df6e50268..294c2c3c4fe00d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1171,6 +1171,12 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
>  					0, src_vma, src_mm, addr, end);
>  		mmu_notifier_invalidate_range_start(&range);

> +		/*
> +		 * The read side doesn't spin, it goes to the mmap_lock, so the
> +		 * raw version is used to avoid disabling preemption here
> +		 */
> +		mmap_assert_write_locked(src_mm);
> +		raw_write_seqcount_t_begin(&src_mm->write_protect_seq);
>  	}
>

Please, s/raw_write_seqcount_t_begin()/raw_write_seqcount_begin()/g. For
plain seqcount_t, it's the same, while still respecting the seqlock.h
API boundaries.

Let's make the comment also a bit more clear (IMHO, "lockdep" needs to
be mentioned somewhere):

		/*
		 * Disabling preemption is not needed for the write side, as
		 * the read side doesn't spin, but goes to the mmap_lock.
		 *
		 * Use the raw variant of the seqcount_t write API to avoid
		 * lockdep complaining about preemptibility.
		 */
		mmap_assert_write_locked(src_mm);
		raw_write_seqcount_t_begin(&src_mm->write_protect_seq);

>  	ret = 0;
> @@ -1187,8 +1193,10 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  		}
>  	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
>
> -	if (is_cow)
> +	if (is_cow) {
> +		raw_write_seqcount_t_end(&src_mm->write_protect_seq);

ditto.

s/raw_write_seqcount_t_end()/raw_write_seqcount_end()/g

>  		mmu_notifier_invalidate_range_end(&range);
> +	}
>  	return ret;
>  }
>

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
