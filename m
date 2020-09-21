Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC82734B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgIUVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgIUVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600723071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gWLsY05lICNle2YhUQzZEkQ3xwxCbs5IFMyW9iOIK7U=;
        b=cWzSK4Z1svVr/53IHI3nWRmxT6clDMU99WnwIYnOwzTcy2jcIqselApw76TT06wDLrr+Hd
        2J0LBXMeVzzm4JSs9kCQGRkIKL5SwBV0/yOXFnWTCr8DrVzmbhWRYsuN3CSJ3z9Ete1NOL
        5jqWIRcxT8TLqUvW579kH9xAEgaBFp4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-DY73P4UeNTqMxbH9ByI0cg-1; Mon, 21 Sep 2020 17:17:49 -0400
X-MC-Unique: DY73P4UeNTqMxbH9ByI0cg-1
Received: by mail-qk1-f198.google.com with SMTP id h191so12056998qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWLsY05lICNle2YhUQzZEkQ3xwxCbs5IFMyW9iOIK7U=;
        b=slEwNOH2UNPWkWEsB3AZYcQ3+YNQnEtOmxcjXmeEo7uZxIxE4+GUdr3q5exdYmAIaH
         He1paAnIXCUVziYTOU3gP7iVfjRBfdAO6CIgElYPDQLi6iSmIa9Q0XTCXSij0nsM52VT
         OoWDdbWBKC48Tsk9VneDaCHuDaW4OStArlYqm6IbuJDvHhW5bvBRElL2Y4dCn1PHiX73
         0xeGBlC3sLtK80gfjTjB2WgVTpR+gM3UkE6KYpsctNVyPikCu/fDdD4Gq6W2hHEMCtqm
         QP1ZUexSTufWkzuieGPFaowVRHg4okVtSvpi6/0/mP/UVzUfvE3KdQnEhy1ZpGtDxYtc
         rcMA==
X-Gm-Message-State: AOAM533A3LqlrhUrnIRhRFLDIilqm9Enepyu2yCTOstjY0nuuq2dFEvj
        VMR4uhRM2D1dGfk4zYQu174ui22+VZmIkjd5tYVOIC+BP3XWa4vvHlXBMSQbaoHYqbWPivO5V65
        HaDMiy+0LO9O1LytTX8YzHEgE
X-Received: by 2002:a05:620a:4107:: with SMTP id j7mr1630456qko.469.1600723067848;
        Mon, 21 Sep 2020 14:17:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcCX64AP4qp062+menLvZbLoudv80PWmwgaiADPDH4CiNhTKhFK/aUzRdlX4z70KkQqClrbw==
X-Received: by 2002:a05:620a:4107:: with SMTP id j7mr1630433qko.469.1600723067537;
        Mon, 21 Sep 2020 14:17:47 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h68sm10225108qkf.30.2020.09.21.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:17:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 0/5] mm: Break COW for pinned pages during fork()
Date:   Mon, 21 Sep 2020 17:17:39 -0400
Message-Id: <20200921211744.24758-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally I start to post formal patches because it's growing.  And also sinc=
e=0D
we've discussed quite some issues already, so I feel like it's clearer on w=
hat=0D
we need to do, and how.=0D
=0D
This series is majorly inspired by the previous discussion on the list [1],=
=0D
starting from the report from Jason on the rdma test failure.  Linus propos=
ed=0D
the solution, which seems to be a very nice approach to avoid the breakage =
of=0D
userspace apps that didn't use MADV_DONTFORK properly before.  More informa=
tion=0D
can be found in that thread too.=0D
=0D
I believe the initial plan was to consider merging something like this for=
=0D
rc7/rc8.  However now I'm not sure due to the fact that the code change in=
=0D
copy_pte_range() is probably more than expected, so it can be with some ris=
k.=0D
I'll leave this question to the reviewers...=0D
=0D
I tested it myself with fork() after vfio pinning a bunch of device pages, =
and=0D
I verified that the new copy pte logic worked as expected at least in the m=
ost=0D
general path.  However I didn't test thp case yet because afaict vfio does =
not=0D
support thp backed dma pages.  Luckily, the pmd/pud thp patch is much more=
=0D
straightforward than the pte one, so hopefully it can be directly verified =
by=0D
some code review plus some more heavy-weight rdma tests.=0D
=0D
Patch 1:      Introduce mm.has_pinned (as single patch as suggested by Jaso=
n)=0D
Patch 2-3:    Some slight rework on copy_page_range() path as preparation=0D
Patch 4:      Early cow solution for pte copy for pinned pages=0D
Patch 5:      Same as above, but for thp (pmd/pud).=0D
=0D
Hugetlbfs fix is still missing, but as planned, that's not urgent so we can=
=0D
work upon.  Comments greatly welcomed.=0D
=0D
Thanks.=0D
=0D
Peter Xu (5):=0D
  mm: Introduce mm_struct.has_pinned=0D
  mm/fork: Pass new vma pointer into copy_page_range()=0D
  mm: Rework return value for copy_one_pte()=0D
  mm: Do early cow for pinned pages during fork() for ptes=0D
  mm/thp: Split huge pmds/puds if they're pinned when fork()=0D
=0D
 include/linux/mm.h       |   2 +-=0D
 include/linux/mm_types.h |  10 ++=0D
 kernel/fork.c            |   3 +-=0D
 mm/gup.c                 |   6 ++=0D
 mm/huge_memory.c         |  26 +++++=0D
 mm/memory.c              | 226 +++++++++++++++++++++++++++++++++++----=0D
 6 files changed, 248 insertions(+), 25 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

