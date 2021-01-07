Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C142EE9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbhAGXa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbhAGXaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610062138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7eEumnZITt8LSMG+c5eHBTJyWBxx4LQFGtGACeYt0tw=;
        b=Ef1NL0shonOik7Vwtd3OfkjUgBlyVGJiZwFs/l9lEZP/do+mgTwScBnjyE0bqZzpoiy1VH
        qfVp1CS5wzZP+hZZ0FriXzJ6+29fezKiYOcl5/Wg3z/u3B7qD9kmYr81XSPd+LWqUtiwqe
        KdJr/IIT7WMgLIH7pvA/RAg0uIsy/vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-tre5Cf1FP2-6t6-_WPBalw-1; Thu, 07 Jan 2021 18:28:57 -0500
X-MC-Unique: tre5Cf1FP2-6t6-_WPBalw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F77810054FF;
        Thu,  7 Jan 2021 23:28:54 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E505D9DE;
        Thu,  7 Jan 2021 23:28:47 +0000 (UTC)
Date:   Thu, 7 Jan 2021 18:28:46 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <X/eZLvcNThSSO62C@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:42:17PM -0800, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 2:31 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > Random memory corruption will still silently materialize as result of
> > the speculative lookups in the above scenario.
> 
> Explain.
> 
> Yes, you'll get random memory corruption if you keep doing wrprotect()
> without mmap_sem held for writing.

I didn't meant that.

> But I thought we agreed earlier that that is a bug. And I thought the
> softdirty code already got it for writing.

softdirty used mmap_read_lock too but this again isn't relevant here
and for the sake of discussion we can safely assume mmap_read_lock
doesn't exist in the kernel, and everything takes the mmap_write_lock
whenever a mmap_lock is taken at all.

I mean something bad will happen if a write happens, but soft dirty
cannot register it because we didn't wrprotect the pte? Some dirty
page won't be transferred to destination and it will be assumed there
was no softy dirty event for such page? Otherwise it would mean that
wrprotecting is simply optional for all pages under clear_refs?

Not doing the final TLB flush in softdirty caused some issue even when
there was no COW and the deferred flush only would delay the wrprotect
fault:

       https://lore.kernel.org/linux-mm/CA+32v5zzFYJQ7eHfJP-2OHeR+6p5PZsX=RDJNU6vGF3hLO+j-g@mail.gmail.com/
       https://lore.kernel.org/linux-mm/20210105221628.GA12854@willie-the-truck/

Skipping the wrprotection of the pte because of a speculative
pagecache lookup elevating a random page_count, from the userland
point of view, I guessed would behave as missing the final TLB flush
before clear_refs returns to userland, just worse.

Thanks,
Andrea

