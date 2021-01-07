Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC632EE962
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbhAGW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbhAGW6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610060223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPUZOdAgAnopTQ0zbSHS4o/BBc0ukOCx70tRQ8Xa+7Q=;
        b=YKNz7XOExzhTobSj/MBHhdorz8rN8imz/mmCTFM1Q8qtB3O5sZ9Kd2cVi92qasCofsWtis
        uZeLltbhSiWp+CSG7L29MaUZRlv3ANXuHFR1FVDUOCi0MDL9p+E41VTzVa/4BnhFUz0l0a
        9xf9X8YhB49c/mzWLOTBbjeD5/ruF8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-Gqqj4m45NqWg1gGSD8Q3Nw-1; Thu, 07 Jan 2021 17:57:00 -0500
X-MC-Unique: Gqqj4m45NqWg1gGSD8Q3Nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5568800D53;
        Thu,  7 Jan 2021 22:56:57 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B22F36062F;
        Thu,  7 Jan 2021 22:56:49 +0000 (UTC)
Date:   Thu, 7 Jan 2021 17:56:49 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <X/eRsbAU7bt9nvFD@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
 <X/eFCt/lxRKgoPXu@redhat.com>
 <CAHk-=wjhpTa616YdTfincMV1LqqRWqokKtd1ARdMOPd1Wra8Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhpTa616YdTfincMV1LqqRWqokKtd1ARdMOPd1Wra8Pg@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:17:50PM -0800, Linus Torvalds wrote:
> So I think we can agree that even that softdirty case we can just
> handle by "don't do that then".

Absolutely. The question is if somebody was happily running clear_refs
with a RDMA attached to the process, by the time they update and
reboot they'll find it the hard way with silent mm corruption
currently.

So I was obliged to report this issue and the fact there was very
strong reason why page_count was not used there and it's even
documented explicitly in the source:

 * [..] however we only use
 * page_trans_huge_mapcount() in the copy-on-write faults where we
 * need full accuracy to avoid breaking page pinning, [..]

I didn't entirely forget the comment when I reiterated it in fact also
in Message-ID: <20200527212005.GC31990@redhat.com> on May 27 2020
since I recalled there was a very explicit reason why we had to use
page_mapcount in do_wp_page and deliver full accuracy.

Now I cannot proof there's any such user that will break, but we'll
find those with a 1 year or more of delay.

Even the tlb flushing deferral that caused clear_refs_write to also
corrupt userland memory and literally lose userland writes even
without any special secondary MMU hardware being attached to the
memory, took 6 months to find.

> if a page is pinned, the dirty bit of it makes no sense, because it
> might be dirtied complately asynchronously by the pinner.
>
> So I think none of the softdirty stuff should touch pinned pages. I
> think it falls solidly under that "don't do it then".
> 
> Just skipping over them in clear_soft_dirty[_pmd]() doesn't look that
> hard, does it?

1) How do you know again if it's not speculative lookup or an O_DIRECT
   that made them look pinned?

2) it's a hugepage 1, a 4k pin will make soft dirty then skip 511
   dirty bits by mistake including those pages that weren't pinned and
   that userland is still writing through the transhuge pmd.

   Until v4.x we had a page pin counter for each subpage so the above
   wouldn't have happened, but not anymore since it was simplified and
   improved but now the page_count is pretty inefficient there, even
   if it'd be possible to make safe.

3) the GUP(write=0) may be just reading from RAM and sending to the
   other end so clear_refs may have currently very much tracked CPU
   writes fine, with no interference whatsoever from the secondary MMU
   working in readonly on the memory.

Thanks,
Andrea

