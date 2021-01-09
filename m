Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9882EFC09
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbhAIAOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbhAIAOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610151162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jKnh5xCWvdcIBiM80ZPoOS0n6cGnYUS+u8z0WaCqbyk=;
        b=Z/YhO7lzlv2PYBY5jtKJkLgdH/+JdewRqKrep9SaAkIJn/2nlOrLQx3isqNLmo5GJXGpJr
        cgbeXjklPtI6YUkmPTzIOEl576G4OwwyHwibocs3jTzKC5mPNIom7Q0143k+DbLCs6I3I1
        PNg6iCOFKhndea7dYa2xrmJVnpGXZAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-uWXeXsrgMhaIdF5vSYJ15Q-1; Fri, 08 Jan 2021 19:12:39 -0500
X-MC-Unique: uWXeXsrgMhaIdF5vSYJ15Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B236A10054FF;
        Sat,  9 Jan 2021 00:12:35 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94AE360BF3;
        Sat,  9 Jan 2021 00:12:29 +0000 (UTC)
Date:   Fri, 8 Jan 2021 19:12:28 -0500
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
Message-ID: <X/j07P9d1g5vMAJa@redhat.com>
References: <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com>
 <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck>
 <X/iEyk0ijxhSvs9T@redhat.com>
 <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com>
 <X/icBLF59bREm97b@redhat.com>
 <CAHk-=wjf-GwbXgDm8RDkW1ctajzDst4dp2LOZSd3+m7Ojo5vDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjf-GwbXgDm8RDkW1ctajzDst4dp2LOZSd3+m7Ojo5vDA@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:25:21AM -0800, Linus Torvalds wrote:
> On Fri, Jan 8, 2021 at 9:53 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > Do you intend to eventually fix the zygote vmsplice case or not?
> > Because in current upstream it's not fixed currently using the
> > enterprise default config.
> 
> Is this the hugepage case? Neither of your patches actually touched
> that, so I've forgotten the details.

The two patches only fixed the TLB flushing deferral in clear_refs and
uffd-wp.

So I didn't actually try to fix the hugepage case by adding the
page_count checks there too. I could try to do that at least it'd be
consistent but I still would try to find an alternate solution later.

> > Irrelevant special case as in: long term GUP pin on the memory?
> 
> Irrelevant special case in that
> 
>  (a) an extra COW shouldn't be a correctness issue unless somebody
> does something horribly wrong (and obviously the code that hasn't
> taken the mmap_lock for writing are then examples of that)
> 
> and
> 
>  (b) it's not a performance issue either unless you can find a real
> load that does it.
> 
> Hmm?

For b) I don't have an hard time to imagine `ps` hanging for seconds,
if clear_refs is touched on a 4T mm, but b) is not the main
concern.

Having to rely on a) is the main concern and it's not about tlb
flushes but the long term GUP pins.

Thanks,
Andrea

