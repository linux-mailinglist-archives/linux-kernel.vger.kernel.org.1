Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5627B304
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1RXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbgI1RXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:23:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601313780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LTS8PVfmK/f/9X7OPUUAt2g8tDoLOrDZ8lScUVnhFM=;
        b=iFnW1dOi+plTG7B2wmhHx3OK/GBln+I/rSNRzTic0N5amtRTeptJAgFz+oVjO/7ooPhxX/
        F9VWg0PwWImTMT1mwlbzpgV8LtSY4wRkTAXi/K3ORgBOeP18O7HikvKkFgDcgtJVH3DYC9
        TGHBQiTVr2W5mMY1cykVZz7tjes3Ltc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-bj9tSHNTNDy0mO8U3kDU_w-1; Mon, 28 Sep 2020 13:22:59 -0400
X-MC-Unique: bj9tSHNTNDy0mO8U3kDU_w-1
Received: by mail-qv1-f71.google.com with SMTP id t7so1033293qvz.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1LTS8PVfmK/f/9X7OPUUAt2g8tDoLOrDZ8lScUVnhFM=;
        b=mH7hfEOWX4nNCBfRDvZFbsg1/2voixslw0lXOsxUXcioKE+tbQy/cXitwsCrsBN8fi
         UlqsJwHXYD1zDDQD8T1Jp4ez0mP2dTC6ZjZnv9TTipA12ThERDksh6gzyR46FG7e8g3I
         dZsAjY8h6Ab8e6RVG9JNE+uQDQL/FE1K1K15buae0u6jGbWUsZqvIi/23uH0WNFOxB4a
         JqWtkpckhTg+zzpOaeJXPOkAbChInC4ol/XUDtF7ZeZ8Ql8RvpKHSpK2paCxmBY4/tTa
         Nk1a4v7XskXxXdoSCBkj2JmjMdDlTYNLWiLGL7JyfeM2D4LoI1iI6C9pZZUdmN4eoaId
         gSXw==
X-Gm-Message-State: AOAM531nIVKHNXKgdta5D5wOhC7nwJ52Em1646mXIDxgJwQ+5yufSn0G
        ch1rgictwYnEKE6XtEPG5RLfvS3w1hMTkY2OltjEt547xmkSOMZuCVWOMQF8Jqw8hDipKOA1LAM
        9gn7zEdPs6k5SvYLKpPw32c0R
X-Received: by 2002:a37:7687:: with SMTP id r129mr515675qkc.264.1601313778682;
        Mon, 28 Sep 2020 10:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuXmEuI87fdrdB0w8cRZk9cGfXhSuARqBzz4HNUwKmE2Gkx1CiZ+mjwn/YiJGYRY+wZCCNRw==
X-Received: by 2002:a37:7687:: with SMTP id r129mr515652qkc.264.1601313778371;
        Mon, 28 Sep 2020 10:22:58 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id e7sm2028873qtk.17.2020.09.28.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 10:22:57 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:22:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@nvidia.com>,
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
Message-ID: <20200928172256.GB59869@xz-x1>
References: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca>
 <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 09:17:09AM -0700, Linus Torvalds wrote:
> On Mon, Sep 28, 2020 at 5:49 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > Not seeing an obvious option besides adding a smp_mb() before
> > page_maybe_dma_pinned() as Peter once suggested.
> 
> That is going to be prohibitively expensive - needing it for each pte
> whether it's pinned or not.
> 
> I really think the better option is a "don't do that then". This has
> _never_ worked before either except by pure luck.

Yes...  Actually I am also thinking about the complete solution to cover
read-only fast-gups too, but now I start to doubt this, at least for the fork()
path.  E.g. if we'd finally like to use pte_protnone() to replace the current
pte_wrprotect(), we'll be able to also block the read gups, but we'll suffer
the same degradation on normal fork()s, or even more.  Seems unacceptable.

The other question is, whether we should emphasize and document somewhere that
MADV_DONTFORK is still (and should always be) the preferred way, because
changes like this series can potentially encourage the other way.

-- 
Peter Xu

