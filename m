Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3212EE7CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbhAGVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:47:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbhAGVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610055949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcJL8OlxSjz4TBCig/UyiENXqAQ6EHQn1x2f94cS2Zg=;
        b=LSYElK3J4AYGgPTNW0d+HKXe0LlhDojE6fKPiqbaUrRHFgKHBmj98AKp2cFt9ixQDgyq0Y
        1Eq7QLHWvorEDWVFlkeFYzWZl+FkjSPLyfZE6khyn0pIcUNmM4rjo+m+wRtKxSku/AJP+Z
        BZBTdGVAraxxfUegTOJj7Ze3q/4dNzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-IMtl4d1nMGaGfPYUkVRjOA-1; Thu, 07 Jan 2021 16:45:47 -0500
X-MC-Unique: IMtl4d1nMGaGfPYUkVRjOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4405190A7A0;
        Thu,  7 Jan 2021 21:45:44 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0CD60CC4;
        Thu,  7 Jan 2021 21:45:33 +0000 (UTC)
Date:   Thu, 7 Jan 2021 16:45:33 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <X/eA/f1r5GXvcRWH@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107202525.GD504133@ziepe.ca>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:25:25PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 07, 2021 at 03:04:00PM -0500, Andrea Arcangeli wrote:
> 
> > vmsplice syscall API is insecure allowing long term GUP PINs without
> > privilege.
> 
> Lots of places are relying on pin_user_pages long term pins of memory,
> and cannot be converted to notifiers.
> 
> I don't think it is reasonable to just declare that insecure and
> requires privileges, it is a huge ABI break.

Where's that ABI? Are there specs or a code example in kernel besides
vmsplice itself?

I don't see how it's possible to consider long term GUP pins
completely unprivileged if not using mmu notifier. vmsplice doesn't
even account them in rlimit (it cannot because it cannot identify all
put_pages either).

Long term GUP pins not using mmu notifier and not accounted in rlimit
are an order of magnitude more VM-intrusive than mlock.

The reason it's worse than mlock, even if ignore all performance
feature that they break including numa bindings and that mlock doesn't
risk to break, come because you can unmap the memory after taking
those rlimit unaccounted GUP pins. So the OOM killer won't even have a
chance to see the GUP pins coming.

So it can't be that mlock has to be privileged but unconstrainted
unaccounted long term GUP pins as in vmsplice are ok to stay
unprivileged.

Now io_uring does account the GPU pins in the mlock rlimit, but after
the vma is unmapped it'd still cause the same confusion to OOM killer
and in addition the assumption that each GUP pin cost 4k is also
flawed. However io_uring model can use the mmu notifier without
slowdown to the fast paths, so it's not going to cause any ABI break
to fix it.

Or to see it another way, it'd be fine to declare all mlock rlimits
are obsolete and memcg is the only way to constrain RAM usage, but
then mlock should stop being privileged, because mlock is a lesser
concern and it won't risk to confuse the OOM killer at least.

The good thing is the GUP pins won't escape memcg accounting but that
accounting also doesn't come entirely free.

> FWIW, vhost tries to use notifiers as a replacement for GUP, and I
> think it ended up quite strange and complicated. It is hard to
> maintain performance when every access to the pages needs to hold some
> protection against parallel invalidation.

And that's fine, this is all about if it should require a one liner
change to add the username in the realtime group in /etc/group or not.

You're focusing on your use case, but we've to put things in
prospective of all these changes started.

The whole zygote issue wouldn't even register if the child had the
exact same credentials of the parent. Problem is the child dropped
privileges and went with a luser id, that clearly cannot ptrace the
parent, and so if long term unprivileged GUP pins are gone from the
equation, what remains that the child can do is purely theoretical
even before commit 17839856fd588f4ab6b789f482ed3ffd7c403e1f.

NOTE: I'm all for fixing the COW for good, but vmsplice or any long
term GUP pin that is absolutely required to make such attack
practical, looks the real low hanging fruit here to fix.

However fixing it so clear_refs becomes fundamentally incompatible
with mmu notifier users unless they all convert to pure !FOLL_GET
GUPs, let alone long term GUP pins not using mmu notifier, doesn't
look great. For vmsplice that new break-COW is the fix because it
happens in the other process.

For every legit long term GUP, where the break-COW happens in the
single and only process, it's silent MM corruption.

Thanks,
Andrea

