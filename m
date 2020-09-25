Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41AB279428
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgIYW0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbgIYW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:26:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Uo8gGRWpJjLrjEh3kZPQ0+a+t3L+ZpORnheEJIOtEYM=;
        b=LjrFKeOz23qp2X1No4kRChU83VBiq1KD8YUPazfqH2P/Z91BxAm1lk2UDepGr5+IT45YVp
        RV25KHc3gCRE2Eb+PVgbK0mBvZEnrxEYI8yCprxyVjShiMzni0sqQ495jXH2Qvuy/2CHGr
        QPFHJKOUurpeYpqHd+DbxPvWw6i+p60=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-2ScSQm5uMMCZwp3zIaXi3Q-1; Fri, 25 Sep 2020 18:25:57 -0400
X-MC-Unique: 2ScSQm5uMMCZwp3zIaXi3Q-1
Received: by mail-qt1-f199.google.com with SMTP id f12so3390701qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uo8gGRWpJjLrjEh3kZPQ0+a+t3L+ZpORnheEJIOtEYM=;
        b=SbZNBp9xMdNw+XJNyKtr+CdDD8P0764XBWb3KwBFhKVdysze98ZU+9/OcwlEhzIAvQ
         EfmuAPESAi0r07Y61CRGCeIfjYv6UUB4+aa8/AdUt8HCRMRw9knMbIxY3B+q8zhEIdqh
         JWO7u2cYAG0HlW+zR4JppxABCcS6fhHAR61/Rd+awPJ9KF54gCSgwBITmnFC7+M9e0Hh
         JsyCxOhcwrZHcZAPQdcEz58kY0MuC59WgOOv++AIPI8tPFikZQ050p9Zv1Ramtgs+e1L
         zY5txlthvj4xu2AFZXzJ6Em56o5CxvKvlqRaZ3Rk9yW761HW+6lhQ5YMeLcsHz47ktzX
         SOzg==
X-Gm-Message-State: AOAM532ATVH/WxCLtHPDO5yivY7CCkypWRHigqm9c4VWN9611DWLsWdj
        9NDO6P9L060UujoeqCcJo+Ghi2cmmpU9n83NQ28SnPAMDHy03xaybXBWo+5ssQWhz4G9JYlhEtF
        05apINdBdgoIg4e9zaNCn9c/t
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr2277804qkv.68.1601072756654;
        Fri, 25 Sep 2020 15:25:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxud43W52mkUiayJyz6fs8bzW3AvKTzd0bsDmScGL2fbyiqdiPNW70YHqtR360OXHRhUoTzzA==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr2277774qkv.68.1601072756331;
        Fri, 25 Sep 2020 15:25:56 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id w44sm3051471qth.9.2020.09.25.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:25:55 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v2 0/4] mm: Break COW for pinned pages during fork()
Date:   Fri, 25 Sep 2020 18:25:56 -0400
Message-Id: <20200925222600.6832-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the rebase to latest rc6, the major pte copy patch changed a lot.  S=
o=0D
maybe not that useful to write a changelog any more.  However all the comme=
nts=0D
should be addressed as long as discussed in previous thread.  Please shoot =
if I=0D
missed anything important.=0D
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
Patch 1:      Introduce mm.has_pinned=0D
Patch 2:      Preparation patch=0D
Patch 3:      Early cow solution for pte copy for pinned pages=0D
Patch 4:      Same as above, but for thp (pmd/pud).=0D
=0D
Hugetlbfs fix is still missing, but as planned, that's not urgent so we can=
=0D
work upon.  Comments greatly welcomed.=0D
=0D
[1] https://lore.kernel.org/lkml/20200914143829.GA1424636@nvidia.com/=0D
=0D
Thanks.=0D
=0D
Peter Xu (4):=0D
  mm: Introduce mm_struct.has_pinned=0D
  mm/fork: Pass new vma pointer into copy_page_range()=0D
  mm: Do early cow for pinned pages during fork() for ptes=0D
  mm/thp: Split huge pmds/puds if they're pinned when fork()=0D
=0D
 include/linux/mm.h       |   2 +-=0D
 include/linux/mm_types.h |  10 +++=0D
 kernel/fork.c            |   3 +-=0D
 mm/gup.c                 |   6 ++=0D
 mm/huge_memory.c         |  28 ++++++=0D
 mm/memory.c              | 186 ++++++++++++++++++++++++++++++++++-----=0D
 6 files changed, 212 insertions(+), 23 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

