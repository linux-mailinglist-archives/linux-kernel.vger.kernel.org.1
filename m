Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D02F54B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbhAMWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729205AbhAMV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610575022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3AL2hFTE8XLIenXG1MWNstHJ1MIfu4paLFzoc+bKbA=;
        b=ffheJ3AocN8b5gQ30oXpjy8M/w+X2cIr/W18yM/ZV6ScDtwwbFkUT8s3wpw8LxKrdAJmcs
        VEM33QoDCmUwrUPwTalnGl91cNUEqYHKxC8BFAwK6g3xMHCv3ZpinB/d2Lpkj7fLep75Zg
        +q7/kNBd6XJKFliNPUbRGVmD6MYruG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-IJ3mGltiN4qt4DxWlhHPig-1; Wed, 13 Jan 2021 16:57:00 -0500
X-MC-Unique: IJ3mGltiN4qt4DxWlhHPig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03137107ACF7;
        Wed, 13 Jan 2021 21:56:58 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 720DC1F401;
        Wed, 13 Jan 2021 21:56:40 +0000 (UTC)
Date:   Wed, 13 Jan 2021 16:56:38 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20210113215638.GA528828@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <X/jgLGPgPb+Xms1t@redhat.com>
 <20210109004255.GG504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210109004255.GG504133@ziepe.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 08:42:55PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 08, 2021 at 05:43:56PM -0500, Andrea Arcangeli wrote:
> > On Fri, Jan 08, 2021 at 02:19:45PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Jan 08, 2021 at 12:00:36PM -0500, Andrea Arcangeli wrote:
> > > > > The majority cannot be converted to notifiers because they are DMA
> > > > > based. Every one of those is an ABI for something, and does not expect
> > > > > extra privilege to function. It would be a major breaking change to
> > > > > have pin_user_pages require some cap.
> > > > 
> > > > ... what makes them safe is to be transient GUP pin and not long
> > > > term.
> > > > 
> > > > Please note the "long term" in the underlined line.
> > > 
> > > Many of them are long term, though only 50 or so have been marked
> > > specifically with FOLL_LONGTERM. I don't see how we can make such a
> > > major ABI break.
> > 
> > io_uring is one of those indeed and I already flagged it.
> > 
> > This isn't a black and white issue, kernel memory is also pinned but
> > it's not in movable pageblocks... How do you tell the VM in GUP to
> > migrate memory to a non movable pageblock before pinning it? Because
> > that's what it should do to create less breakage.
> 
> There is already a patch series floating about to do exactly that for
> FOLL_LONGTERM pins based on the existing code in GUP for CMA migration
> 
> > For example iommu obviously need to be privileged, if your argument
> > that it's enough to use the right API to take long term pins
> > unconstrained, that's not the case. Pins are pins and prevent moving
> > or freeing the memory, their effect is the same and again worse than
> > mlock on many levels.
> 
> The ship sailed on this a decade ago, it is completely infeasible to
> go back now, it would completely break widely used things like GPU,
> RDMA and more.
> 

I am late to this but GPU should not be use as an excuse for GUP. GUP
is a broken model and the way GPU use GUP is less broken then RDMA. In
GPU driver GUP contract with userspace is that the data the GPU can
access is a snapshot of what the process memory was at the time you
asked for the GUP. Process can start using different pages right after.
There is no constant coherency contract (ie CPU and GPU can be working
on different pages).

If you want coherency ie always have CPU and GPU work on the same page
then you need to use mmu notifier and avoid pinning pages. Anything that
does not abide by mmu notifier is broken and can not be fix.

Cheers,
Jérôme

