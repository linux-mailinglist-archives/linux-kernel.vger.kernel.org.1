Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB9279EA5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgI0GX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbgI0GX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:23:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82878221E5;
        Sun, 27 Sep 2020 06:23:58 +0000 (UTC)
Date:   Sun, 27 Sep 2020 09:23:37 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200927062337.GE2280698@unreal>
References: <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca>
 <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 03:28:32PM -0700, Linus Torvalds wrote:
> On Fri, Sep 25, 2020 at 6:15 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think that over the weekend I'll do Peter's version but with the
> > "page_mapcount() == 1"  check, because I'm starting to like that
> > better than the mm->has_pinned.
>
> Actually, rafter the first read-through, I feel like I'll just apply
> the series as-is.
>
> But I'll look at it some more, and do another read-through and make
> the final decision tomorrow.
>
> If anybody has any concerns about the v2 patch series from Peter, holler.

We won't be able to test the series till Tuesday due to religious holidays.

Thanks

>
>               Linus
