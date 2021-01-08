Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862D52EF599
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbhAHQPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbhAHQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610122454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRRH40D7PJf5ztj9RQY9dDwF0hprU1QWQ/fBVT1LZ/Q=;
        b=cM+oRbZYriWeA/Mi3AYGJxo6JWOXseWeFWYN6M4xJ3wMSnRQRjFCG6oATm0zB3WmUfgF+1
        y+ZHNu8I1aqiBHa9oMGVACEULkAVhseEYZJpVOm87BO2j1vpxTR5w6/OzLK8N8Zduz83eF
        56X6Z58Whu4TTJSPd1zjsrzXzS95eas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-B75ffJ1IPjqUHfGGO9Hvig-1; Fri, 08 Jan 2021 11:14:12 -0500
X-MC-Unique: B75ffJ1IPjqUHfGGO9Hvig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF035801817;
        Fri,  8 Jan 2021 16:14:09 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1BA160D11;
        Fri,  8 Jan 2021 16:14:02 +0000 (UTC)
Date:   Fri, 8 Jan 2021 11:14:02 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <X/iEyk0ijxhSvs9T@redhat.com>
References: <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com>
 <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108124815.GA4512@willie-the-truck>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Fri, Jan 08, 2021 at 12:48:16PM +0000, Will Deacon wrote:
> On Thu, Jan 07, 2021 at 04:25:54PM -0800, Linus Torvalds wrote:
> > Please. Why is the correct patch not the attached one (apart from the
> > obvious fact that I haven't tested it and maybe just screwed up
> > completely - but you get the idea)?
> 
> It certainly looks simple and correct to me, although it means we're now
> taking the mmap sem for write in the case where we only want to clear the
> access flag, which should be fine with the thing only held for read, no?

I'm curious, would you also suggest that fixing just the TLB flushing
symptom is enough and we can forget about the ABI break coming from
page_count used in do_wp_page?

One random example: clear_refs will still break all long term GUP
pins, are you ok with that too?

page_count in do_wp_page is a fix for the original security issue from
vmsplice (where the child is fooling the parent in taking the
exclusive page in do_wp_page), that appears worse than the bug itself.

page_count in do_wp_page, instead of isolating as malicious when the
parent is reusing the page queued in the vmsplice pipe, is treating as
malicious also all legit cases that had to reliably reuse the page to
avoid the secondary MMUs to go out of sync.

page_count in do_wp_page is like a credit card provider blocking all
credit cards of all customers, because one credit card may have been
cloned (by vmsplice), but nobody can know which one was it. Of course
this technique will work perfectly as security fix because it will
treat all credit card users as malicious and it'll block them all
("block as in preventing re-use of the anon page").

The problem are those other credit card users that weren't malicious
that get their COW broken too. Those are the very long term GUP pins
if any anon page can be still wrprotected anywhere in the VM.

At the same time the real hanging fruit (vmsplice) that, if taken care
of, would have rendered the bug purely theoretical in security terms
hasn't been fixed yet, despite those unprivileged long term GUP pins
causes more reproducible security issues than just the COW, since they
can still DoS the OOM killer and they bypass at least the mlock
enforcement, even for non compound pages.

Of course just fixing vmsplice to require some privilege won't fix the
bug in full, so it's not suitable long term solution, but it has to
happen orthogonality for other reason, and it'd at least remove the
short term security concern.

In addition you're not experiencing the full fallout of the side
effects of page_count used to decide if to re-use all anon COW pages
because the bug is still there (with enterprise default config options
at least). Not all credit cards are blocked yet with only
09854ba94c6aad7886996bfbee2530b3d8a7f4f4 applied. Only after you will
block them all, you will experience all the side effects of replacing
the per-subpage finegrined mapcount with the compound-wide page count.

The two statements above combined, result in my recommendation at this
point to resolve this in userland by rendering the security issue
theoretical by removing vmsplice from the OCI schema allowlist or by
enforcing it fixing in userland by always using execve after drop
privs (as crun always does when it starts the container of course).

For the long term, I can't see how using page_count in do_wp_page is a
tenable proposition, unless we either drop all secondary MMUs from the
kernel or VM features like clear_refs are dropped or unless the
page_count is magically stabilized and the speculative pagecache
lookups are also dropped.

If trying to manage the fallout by enforcing no anon page can ever be
wrprotected in place (i.e. dropping clear_refs feature or rendering it
unreliable by skipping elevated counts caused by spurious pagecache
lookups), it'd still sounds a too fragile design and too prone to
break to rely on that. There's random arch stuff even wrprotecting
memory, even very vm86 does it under the hood (vm86 is unlikely it has
a long term GUP pin on it of course, but still who knows?). I mean the
VM core cannot make assumptions like: "this vm86 case can still
wrprotect without worry because probably vm86 isn't used anymore with
any advanced secondary MMU, so if there's a GUP pin it probably is a
malicious vmsplice and not a RDMA or GPU or Virtualization secondary
MMU".

Then there's the secondary concern of the inefficiency it introduces
with extra unnecessary copies when a single GUP pin will prevent reuse
of 512 or 262144 subpages, in the 512 case also potentially mapped in
different processes. The TLB flushing discussions registers as the
last concern in my view.

Thanks,
Andrea

