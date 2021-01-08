Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE442EFBBE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAHXfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAHXfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610148866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfbPHvrLKXuKE5/saUOXhlx+4Jqlj3bL/XQQqTvjtLQ=;
        b=W9+RcB4TYw6q7kIOLm+Zr4CoJiUuna1BP1VPGscpW46OMJ9mazcYyh4PE9QCy1JpMyyxNl
        ZE7CCqvFSboL+gVIvmRxpPr1VG54lh+8tjy+3l5P5VCYsUXpu5WAJLEBfcZjuMkW22YKTr
        Axv7ntETmSyHNvbYSQaFoesWS7moHoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-9MPMCzH3OU6eo5HVF7JNMA-1; Fri, 08 Jan 2021 18:34:24 -0500
X-MC-Unique: 9MPMCzH3OU6eo5HVF7JNMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF690B8100;
        Fri,  8 Jan 2021 23:34:21 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725D6722DC;
        Fri,  8 Jan 2021 23:34:10 +0000 (UTC)
Date:   Fri, 8 Jan 2021 18:34:09 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
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
Message-ID: <X/jr8QfeolQwn39f@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVWGZ5MkN6S+o_h5isOHKVpjwSz-jyXSsp9VJjVOYOyyg@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:31:24AM -0800, Andy Lutomirski wrote:
> Can we just remove vmsplice() support?  We could make it do a normal

The single case I've seen vmsplice used so far, that was really cool
is localhost live migration of qemu. However despite really cool, it
wasn't merged in the end, and I don't recall exactly why.

There are even more efficient (but slightly more complex) ways to do
that than vmsplice: using MAP_SHARED gigapages or MAP_SHARED tmpfs
with THP opted-in in the tmpfs mount, as guest physical memory instead
of anon memory and finding a way not having it cleared by kexec, so
you can also upgrade the host kernel and not just qemu... is a way
more optimal way to PIN and move all pages through the pipe and still
having to pay a superfluous copy on destination.

My guess why it's not popular, and I may be completely wrong on this
since I basically never used vmsplice (other than to proof of concept
DoS my phone to verify the long term GUP pin exploit works), is that
vmsplice is a more efficient, but not the most efficient option.

Exactly like in the live migration in place, it's always more
efficient to share a tmpfs THP backed region and have true zero copy,
than going through a pipe that still does one copy at the receiving
end. It may also be simpler and it's not dependent on F_SETPIPE_SIZE
obscure tunings. So in the end it's still too slow for apps that
requires maximum performance, and not worth the extra work for those
that don't.

I love vmsplice conceptually, just I'd rather prefer an luser cannot
run it.

> copy, thereby getting rid of a fair amount of nastiness and potential
> attacks.  Even ignoring issues relating to the length of time that the
> vmsplice reference is alive, we also have whatever problems could be
> caused by a malicious or misguided user vmsplice()ing some memory and
> then modifying it.

Sorry to ask but I'm curious, what also goes wrong if the user
modifies memory under GUP pin from vmsplice? That's not obvious to
see.

Thanks,
Andrea

