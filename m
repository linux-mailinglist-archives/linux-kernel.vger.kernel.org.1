Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9356825D337
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgIDIIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:08:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599206920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SO1+KNA9ZAbDAbragBawZT9Ig1IFiDJv5+VVeyfD9cA=;
        b=fxpeJ0Kk002XrhFJTls2z5wbf28lJzir51gkuZxmuRcyrBss0IkrmTcFf6BcV6VJk7+g+9
        3MApSfBkpg+NReoMV79r66DlcNCmHWHSZuzAZtfXfF4XPLslrHd2hJCRxBaPQT5k5IPd+F
        JtcwZnCmAN/E2zFrhKDiUz2RWGH1ZYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vmHYr-41PsCP_UiG7NElMA-1; Fri, 04 Sep 2020 04:08:36 -0400
X-MC-Unique: vmHYr-41PsCP_UiG7NElMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA7656BE3;
        Fri,  4 Sep 2020 08:08:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D0F01A4D6;
        Fri,  4 Sep 2020 08:08:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08488SAu016399;
        Fri, 4 Sep 2020 04:08:28 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08488Qmj016395;
        Fri, 4 Sep 2020 04:08:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 4 Sep 2020 04:08:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: a crash when running strace from persistent memory
In-Reply-To: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Sep 2020, Linus Torvalds wrote:

> On Thu, Sep 3, 2020 at 12:24 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > There's a bug when you run strace from dax-based filesystem.
> >
> > -- create real or emulated persistent memory device (/dev/pmem0)
> > mkfs.ext2 /dev/pmem0
> > -- mount it
> > mount -t ext2 -o dax /dev/pmem0 /mnt/test
> > -- copy the system to it (well, you can copy just a few files that are
> >    needed for running strace and ls)
> > cp -ax / /mnt/test
> > -- bind the system directories
> > mount --bind /dev /mnt/test/dev
> > mount --bind /proc /mnt/test/proc
> > mount --bind /sys /mnt/test/sys
> > -- run strace on the ls command
> > chroot /mnt/test/ strace /bin/ls
> >
> > You get this warning and ls is killed with SIGSEGV.
> >
> > I bisected the problem and it is caused by the commit
> > 17839856fd588f4ab6b789f482ed3ffd7c403e1f (gup: document and work around
> > "COW can break either way" issue). When I revert the patch (on the kernel
> > 5.9-rc3), the bug goes away.
> 
> Funky. I really don't see how it could cause that, but we have the
> UDDF issue too, so I'm guessing I will have to fix it the radical way
> with Peter Xu's series based on my "rip out COW special cases" patch.
> 
> Or maybe I'm just using that as an excuse for really wanting to apply
> that series.. Because we can't just revert that GUP commit due to
> security concerns.
> 
> > [   84.191504] WARNING: CPU: 6 PID: 1350 at mm/memory.c:2486 wp_page_copy.cold+0xdb/0xf6
> 
> I'm assuming this is the WARN_ON_ONCE(1) on line 2482, and you have
> some extra debug patch that causes that line to be off by 4? Because
> at least for me, line 2486 is actually an empty line in v5.9-rc3.

Yes, that's it. I added a few printk to look at the control flow.

> That said, I really think this is a pre-existing race, and all the
> "COW can break either way" patch does is change the timing (presumably
> due to the actual pattern of actually doing the COW changing).
> 
> See commit c3e5ea6ee574 ("mm: avoid data corruption on CoW fault into
> PFN-mapped VMA") for background.
> 
> Mikulas, can you check that everything works ok for that case if you
> apply Peter's series? See
> 
>     https://lore.kernel.org/lkml/20200821234958.7896-1-peterx@redhat.com/

I applied these four patches and strace works well. There is no longer any 
warning or crash.

Mikulas

> or if you have 'b4' installed, use
> 
>     b4 am 20200821234958.7896-1-peterx@redhat.com
> 
> to get the series..
> 
>                      Linus
> 

