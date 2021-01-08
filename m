Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0F2EF6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbhAHRy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728480AbhAHRy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610128410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nxq9Vs4PPNDPrpqL+JjGyYANEQaSFuCmNckkWvxfyR0=;
        b=d5Jew1ijpEqOLTsGfc9o1KHs2GmDqAlQ9eaS20AgG3iA7fQerbg6NoJMSRZp0FxjR8+TdY
        +/pu1N0DewMBM3QJNrvVbL2Y95yBxx/4ekARR45oG6LJEM7onv0EJ+zC6xkJYrXPaG8emX
        0uxZppunnqTwKFBFxAXUtRO7nRx10Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-W5TVzRJbOum_izCrlNcgXQ-1; Fri, 08 Jan 2021 12:53:25 -0500
X-MC-Unique: W5TVzRJbOum_izCrlNcgXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D0EE107ACE4;
        Fri,  8 Jan 2021 17:53:21 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD21A19C48;
        Fri,  8 Jan 2021 17:53:08 +0000 (UTC)
Date:   Fri, 8 Jan 2021 12:53:08 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <X/icBLF59bREm97b@redhat.com>
References: <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com>
 <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck>
 <X/iEyk0ijxhSvs9T@redhat.com>
 <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:39:56AM -0800, Linus Torvalds wrote:
> page_count() is simply the right and efficient thing to do.
> 
> You talk about all these theoretical inefficiencies for cases like
> zygote and page pinning, which have never ever been seen except as a
> possible attack vector.

Do you intend to eventually fix the zygote vmsplice case or not?
Because in current upstream it's not fixed currently using the
enterprise default config.

> Stop talking about irrelevant things. Stop trying to "optimize" things
> that never happen and don't matter.
> 
> Instead, what matters is the *NORMAL* VM flow.
> 
> Things like COW.
> 
> Things like "oh, now that we check just the page count, we don't even
> need the page lock for the common case any more".
> 
> > For the long term, I can't see how using page_count in do_wp_page is a
> > tenable proposition,
> 
> I think you should re-calibrate your expectations, and accept that
> page_count() is the right thing to do, and live with it.
> 
> And instead of worrying about irrelevant special-case code, start

Irrelevant special case as in: long term GUP pin on the memory?

Or irrelevant special case as in: causing secondary MMU to hit silent
data loss if a pte is ever wrprotected (arch code, vm86, whatever, all
under mmap_write_lock of course).

> worrying about the code that gets triggered tens of thousands of times
> a second, on regular loads, without anybody doing anything odd or
> special at all, just running plain and normal shell scripts or any
> other normal traditional load.
> 
> Those irrelevant special cases should be simple and work, not badly
> optimized to the point where they are buggy. And they are MUCH LESS
> IMPORTANT than the normal VM code, so if somebody does something odd,
> and it's slow, then that is the problem for the _odd_ case, not for
> the normal codepaths.
> 
> This is why I refuse to add crazy new special cases to core code. Make
> the rules simple and straightforward, and make the code VM work well.

New special cases? which new cases?

There's nothing new here besides the zygote that wasn't fully fixed
with 09854ba94c6aad7886996bfbee2530b3d8a7f4f4 and is actually the only
new case I can imagine where page_count actually isn't a regression.

All old cases that you seem to refer as irrelevant and are in
production in v4.18, I don't see anything new here.

Even for the pure COW case with zero GUP involvement an hugepage with
cows happening in different processes, would forever hit wp_copy_page
since count is always > 1 despite mapcount can be 1 for all
subpages. A simple app doing fork/exec would forever copy all memory
in the parent even after the exec is finished.

Thanks,
Andrea

