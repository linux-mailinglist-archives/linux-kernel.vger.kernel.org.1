Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166C62F407D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbhAMAmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392010AbhALXwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610495482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxeFnrXFjCMeKRsHViqPHhs/5hTEiB1hQEf1cG4ANpU=;
        b=gNr2f5ZVnPw/Cs8jBkU2UcyH8jP+eGXt2369vUScQbeDHODLsPoUKbi5FEXz9JI6gGgxE5
        dkV8JVjlG9p50ytgfyiz6tMMitPgrlL+p8cANlv7njPxbH9KaAjYsm//knX6uuRCYYCOhG
        3tM865ERMi2wHoA4Y+NvUJyfV6Z5w+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-rYGW17kXMMe_7ukUMMYRzg-1; Tue, 12 Jan 2021 18:51:20 -0500
X-MC-Unique: rYGW17kXMMe_7ukUMMYRzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5669E1014E75;
        Tue, 12 Jan 2021 23:51:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9943A13470;
        Tue, 12 Jan 2021 23:51:06 +0000 (UTC)
Date:   Tue, 12 Jan 2021 18:51:04 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210112235104.GA490399@redhat.com>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
 <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:18:13PM -0800, Linus Torvalds wrote:
> On Mon, Jan 11, 2021 at 11:19 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Jan 10, 2021 at 11:27 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > > IMHO, a lot of the bits in page _refcount are still being wasted (even
> > > after GUP_PIN_COUNTING_BIAS overloading), because it's unlikely that
> > > there are many callers of gup/pup per page.
> >
> > It may be unlikely under real loads.
> >
> > But we've actually had overflow issues on this because rather than
> > real loads you can do attack loads (ie "lots of processes, lots of
> > pipe file descriptors, lots of vmsplice() operations on the same
> > page".
> >
> > We had to literally add that conditional "try_get_page()" that
> > protects against overflow..
> 
> Actually, what I think might be a better model is to actually
> strengthen the rules even more, and get rid of GUP_PIN_COUNTING_BIAS
> entirely.
> 
> What we could do is just make a few clear rules explicit (most of
> which we already basically hold to). Starting from that basic
> 
>  (a) Anonymous pages are made writable (ie COW) only when they have a
> page_count() of 1
> 
> That very simple rule then automatically results in the corollary
> 
>  (b) a writable page in a COW mapping always starts out reachable
> _only_ from the page tables
> 
> and now we could have a couple of really simple new rules:
> 
>  (c) we never ever make a writable page in a COW mapping read-only
> _unless_ it has a page_count() of 1

This breaks mprotect(R_ONLY) i do not think we want to do that. This
might break security scheme for user space application which expect
mprotect to make CPU mapping reads only.

Maybe an alternative would be to copy page on mprotect for pages that
do not have a page_count of 1 ? But that makes me uneasy toward short
lived GUP (direct IO racing with a mprotect or maybe simply even page
migration) versus unbound one (like RDMA).


Also I want to make sure i properly understand what happens on fork()
on a COW mapping for a page that has a page_count > 1 ? We copy the
page instead of write protecting the page ?

I believe better here would be to protect the page on the CPU but
forbid child to reuse the page ie if the child ever inherit the page
(parent unmapped the page for instance) it will have to make a copy
and the GUP reference (taken before the fork) might linger on a page
that is no longer associated with any VM. This way we keep fast fork.


Jérôme

