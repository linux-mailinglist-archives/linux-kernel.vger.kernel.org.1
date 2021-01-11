Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCD2F1ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbhAKQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:16:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbhAKQQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:16:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610381748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MLcYm9FTPYiWOWaeOX0MRtpZVUJ/LO/iqAkq7nU3CY=;
        b=sXOlN3lud62xh6d8BigmuKb+9U0y2dD+yQr4Q+H8DbazOec28y1mgWHeYDR0W5mzLVgghE
        kMsg2m8cmZStxuq63nDLzg3IjBwQzHWfGwhsoJTlMknXKSyEzEoC6VRM51ZnHqYo4uHmVA
        wfI/iL+JAeYDGdUPFnKMRYktUhyyhDQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE32EAE89;
        Mon, 11 Jan 2021 16:15:48 +0000 (UTC)
Date:   Mon, 11 Jan 2021 17:15:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111161547.GD22493@dhcp22.suse.cz>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
 <20210111160549.GN504133@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111160549.GN504133@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-01-21 12:05:49, Jason Gunthorpe wrote:
> On Sun, Jan 10, 2021 at 11:26:57PM -0800, John Hubbard wrote:
> 
> > So:
> > 
> > FOLL_PIN: would use DMA_PIN_COUNTING_BIAS to increment page refcount.
> > These are long term pins for dma.
> > 
> > FOLL_GET: would use GUP_PIN_COUNTING_BIAS to increment page refcount.
> > These are not long term pins.
> 
> Do we have any places yet that care about the long-term-ness?

I was hoping to use that information to distinguish ephemeral migration
failures due to page reference from long term pins. The later would be a
hard failure for the migration.

-- 
Michal Hocko
SUSE Labs
