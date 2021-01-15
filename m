Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32E2F81B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbhAORKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727792AbhAORKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610730555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cPqCXNEeMtBIj5xHIV1oWmjdBmRx8arNxD9d1ED2IE8=;
        b=Ei+Q5Eo6jJeQJb3gg3sBAGt//cm6l/e5YU0ysVCCsgv+FNbQlLbUOX/TobHByKhqzGcymV
        mIam716BRnKVfDDv1IqMSxhhvn9dshpHbxJQBoxmFrcpBK9z4MF6+s1SM9tekjYnJW5GtG
        4kF2kXz6rt+EJefL7J1R+pRBsEH9xGA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-mw9u_u-2Pi6Q1qYeIjSHCQ-1; Fri, 15 Jan 2021 12:09:11 -0500
X-MC-Unique: mw9u_u-2Pi6Q1qYeIjSHCQ-1
Received: by mail-qv1-f72.google.com with SMTP id bp20so8240950qvb.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPqCXNEeMtBIj5xHIV1oWmjdBmRx8arNxD9d1ED2IE8=;
        b=kipuvhRkhGZveBnvObHXIkdfhFLcdye6XkC0NWEcBiNjrzUGuMnpCWAtPuoYy6/QO1
         mv7hBHZZSbY+mRmTXl6cHDOhPmAYq+/6WF6OF0Lp3TnuY1n3TUfN1mgUD5kZCkIgvvn+
         WewERRz65PUgwaZzlPNQvUfXXZ9Hacw2TpkVeJxx6qSRP610CK86ssmnwR1q1j+3bueE
         EiwEo3EWsDgKtgthFa4VvhEqyLlEzZbnCGzotcKhav53LmvfrGZJNVRT7LRsk0INGBS3
         5EN7VvqF6LRq2CqYW9PWcbIaMg/0E7k2m0spiyfAsMzveQV5W3b/Jq7k3xBpNzf75G9E
         LIvg==
X-Gm-Message-State: AOAM533PZ8k84SvOsU/uV9IxFiZkeRuE9WeJzav48abhM1AYuQV3HU6a
        7+i3AuSXTaGya5UsBb51hnnxebwxqbCLwdJMXHtNVsONpdMp+WljPkgLAiFgA0yvg41rcHWes8X
        ZIqG8dTqA+JDnHsC55k5MD9xqC0ydQGe64+099EbbV63dQuKOFs0nQt/1bb9AeFCb8PopyyoCBA
        ==
X-Received: by 2002:ac8:c8f:: with SMTP id n15mr6980969qti.351.1610730550072;
        Fri, 15 Jan 2021 09:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzybQesk3B3da8PXN4/3FxqwTqOECS4zFq+Apan4AUwGlZbSjRapq49qrEsd203bPYzJQz/w==
X-Received: by 2002:ac8:c8f:: with SMTP id n15mr6980919qti.351.1610730549542;
        Fri, 15 Jan 2021 09:09:09 -0800 (PST)
Received: from localhost.localdomain ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id d123sm5187840qke.95.2021.01.15.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:09:08 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Fri, 15 Jan 2021 12:08:37 -0500
Message-Id: <20210115170907.24498-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RFC series to support userfaultfd upon shmem and hugetlbfs.=0D
=0D
PS. Note that there's a known issue [0] with tlb against uffd-wp/soft-dirty=
 in=0D
general and Nadav is working on it.  It may or may not directly affect=0D
shmem/hugetlbfs since there're no COW on shared mappings normally.  Private=
=0D
shmem could hit, but still that's another problem to solve in general, and =
this=0D
RFC is majorly to see whether there's any objection on the concept of the i=
dea=0D
specific to uffd-wp on shmem/hugetlbfs.=0D
=0D
The whole series can also be found online [1].=0D
=0D
The major comment I'd like to get is on the new idea of swap special pte.  =
That=0D
comes from suggestions from both Hugh and Andrea and I appreciated a lot fo=
r=0D
those discussions.=0D
=0D
In short, it's a new type of pte that doesn't exist in the past, while used=
 in=0D
file-backed memories to persist information across ptes being erased (but t=
he=0D
page cache could still exist, for example, so in the next page fault we can=
=0D
reload the page cache with that specific information when necessary).=0D
=0D
I'm copy-pasting some commit message from the patch "mm/swap: Introduce the=
=0D
idea of special swap ptes", where uffd-wp becomes the first user of it:=0D
=0D
    We used to have special swap entries, like migration entries, hw-poison=
=0D
    entries, device private entries, etc.=0D
=0D
    Those "special swap entries" reside in the range that they need to be a=
t least=0D
    swap entries first, and their types are decided by swp_type(entry).=0D
=0D
    This patch introduces another idea called "special swap ptes".=0D
=0D
    It's very easy to get confused against "special swap entries", but a sp=
eical=0D
    swap pte should never contain a swap entry at all.  It means, it's ille=
gal to=0D
    call pte_to_swp_entry() upon a special swap pte.=0D
=0D
    Make the uffd-wp special pte to be the first special swap pte.=0D
=0D
    Before this patch, is_swap_pte()=3D=3Dtrue means one of the below:=0D
=0D
       (a.1) The pte has a normal swap entry (non_swap_entry()=3D=3Dfalse).=
  For=0D
             example, when an anonymous page got swapped out.=0D
=0D
       (a.2) The pte has a special swap entry (non_swap_entry()=3D=3Dtrue).=
  For=0D
             example, a migration entry, a hw-poison entry, etc.=0D
=0D
    After this patch, is_swap_pte()=3D=3Dtrue means one of the below, where=
 case (b) is=0D
    added:=0D
=0D
     (a) The pte contains a swap entry.=0D
=0D
       (a.1) The pte has a normal swap entry (non_swap_entry()=3D=3Dfalse).=
  For=0D
             example, when an anonymous page got swapped out.=0D
=0D
       (a.2) The pte has a special swap entry (non_swap_entry()=3D=3Dtrue).=
  For=0D
             example, a migration entry, a hw-poison entry, etc.=0D
=0D
     (b) The pte does not contain a swap entry at all (so it cannot be pass=
ed=0D
         into pte_to_swp_entry()).  For example, uffd-wp special swap pte.=
=0D
=0D
Hugetlbfs needs similar thing because it's also file-backed.  I directly re=
used=0D
the same special pte there, though the shmem/hugetlb change on supporting t=
his=0D
new pte is different since they don't share code path a lot.=0D
=0D
Patch layout=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
Part (1): some fixes that I observed when working on this; feel free to ski=
p=0D
them for now becuase I think they're corner cases and irrelevant of the maj=
or=0D
change:=0D
=0D
  mm/thp: Simplify copying of huge zero page pmd when fork=0D
  mm/userfaultfd: Fix uffd-wp special cases for fork()=0D
  mm/userfaultfd: Fix a few thp pmd missing uffd-wp bit=0D
=0D
Part (2): Shmem support, this is where the special swap pte is introduced.=
=0D
Some zap rework is needed within the process:=0D
=0D
  shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  mm: Clear vmf->pte after pte_unmap_same() returns=0D
  mm/userfaultfd: Introduce special pte for unmapped file-backed mem=0D
  mm/swap: Introduce the idea of special swap ptes=0D
  shmem/userfaultfd: Handle uffd-wp special pte in page fault handler=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
  mm: Pass zap_flags into unmap_mapping_pages()=0D
  shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed=0D
  shmem/userfaultfd: Allow wr-protect none pte for file-backed mem=0D
  shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps=0D
  shmem/userfaultfd: Handle the left-overed special swap ptes=0D
  shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()=0D
=0D
Part (3): Hugetlb support, we need to disable huge pmd sharing for uffd-wp=
=0D
because not compatible just like uffd minor mode.  The rest is the changes=
=0D
required to teach hugetlbfs understand the special swap pte too that introd=
uced=0D
with the uffd-wp change:=0D
=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  hugetlb: Pass vma into huge_pte_alloc()=0D
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h=0D
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
=0D
Part (4): Enable both features in code and test=0D
=0D
  userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
Tests=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
=0D
I've tested it using either userfaultfd kselftest program, but also with=0D
umapsort [2] which should be even stricter.  No complicated mm setup is tes=
ted=0D
yet besides page swapping in/out, but in all cases we need to have more tes=
ts=0D
when it becomes non-RFC.=0D
=0D
If anyone would like to try umapsort, need to use an extremely hacked versi=
on=0D
of umap library [3], because by default umap only supports anonymous.  So t=
o=0D
test it we need to build [3] then [2].=0D
=0D
Any comment would be greatly welcomed.  Thanks,=0D
=0D
[0] https://lore.kernel.org/lkml/20201225092529.3228466-1-namit@vmware.com/=
=0D
[1] https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs=0D
[2] https://github.com/LLNL/umap-apps=0D
[3] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs=0D
=0D
Peter Xu (30):=0D
  mm/thp: Simplify copying of huge zero page pmd when fork=0D
  mm/userfaultfd: Fix uffd-wp special cases for fork()=0D
  mm/userfaultfd: Fix a few thp pmd missing uffd-wp bit=0D
  shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  mm: Clear vmf->pte after pte_unmap_same() returns=0D
  mm/userfaultfd: Introduce special pte for unmapped file-backed mem=0D
  mm/swap: Introduce the idea of special swap ptes=0D
  shmem/userfaultfd: Handle uffd-wp special pte in page fault handler=0D
  mm: Drop first_index/last_index in zap_details=0D
  mm: Introduce zap_details.zap_flags=0D
  mm: Introduce ZAP_FLAG_SKIP_SWAP=0D
  mm: Pass zap_flags into unmap_mapping_pages()=0D
  shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed=0D
  shmem/userfaultfd: Allow wr-protect none pte for file-backed mem=0D
  shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on=0D
    thps=0D
  shmem/userfaultfd: Handle the left-overed special swap ptes=0D
  shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()=0D
  hugetlb/userfaultfd: Hook page faults for uffd write protection=0D
  hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP=0D
  hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT=0D
  hugetlb: Pass vma into huge_pte_alloc()=0D
  hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled=0D
  mm/hugetlb: Introduce huge version of special swap pte helpers=0D
  mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h=0D
  hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp=0D
  hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler=0D
  hugetlb/userfaultfd: Allow wr-protect none ptes=0D
  hugetlb/userfaultfd: Only drop uffd-wp special pte if required=0D
  userfaultfd: Enable write protection for shmem & hugetlbfs=0D
  userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs=0D
=0D
 arch/arm64/mm/hugetlbpage.c              |   5 +-=0D
 arch/ia64/mm/hugetlbpage.c               |   3 +-=0D
 arch/mips/mm/hugetlbpage.c               |   4 +-=0D
 arch/parisc/mm/hugetlbpage.c             |   2 +-=0D
 arch/powerpc/mm/hugetlbpage.c            |   3 +-=0D
 arch/s390/mm/hugetlbpage.c               |   2 +-=0D
 arch/sh/mm/hugetlbpage.c                 |   2 +-=0D
 arch/sparc/mm/hugetlbpage.c              |   2 +-=0D
 arch/x86/include/asm/pgtable.h           |  28 +++=0D
 fs/dax.c                                 |  10 +-=0D
 fs/hugetlbfs/inode.c                     |  15 +-=0D
 fs/proc/task_mmu.c                       |  14 +-=0D
 fs/userfaultfd.c                         |  80 +++++--=0D
 include/asm-generic/hugetlb.h            |  10 +=0D
 include/asm-generic/pgtable_uffd.h       |   3 +=0D
 include/linux/huge_mm.h                  |   3 +-=0D
 include/linux/hugetlb.h                  |  47 +++-=0D
 include/linux/mm.h                       |  50 +++-=0D
 include/linux/mm_inline.h                |  43 ++++=0D
 include/linux/mmu_notifier.h             |   1 +=0D
 include/linux/shmem_fs.h                 |   5 +-=0D
 include/linux/swapops.h                  |  41 +++-=0D
 include/linux/userfaultfd_k.h            |  37 +++=0D
 include/uapi/linux/userfaultfd.h         |   3 +-=0D
 mm/huge_memory.c                         |  36 ++-=0D
 mm/hugetlb.c                             | 174 +++++++++++---=0D
 mm/khugepaged.c                          |  14 +-=0D
 mm/memcontrol.c                          |   2 +-=0D
 mm/memory.c                              | 277 ++++++++++++++++++-----=0D
 mm/migrate.c                             |   2 +-=0D
 mm/mprotect.c                            |  63 +++++-=0D
 mm/mremap.c                              |   2 +-=0D
 mm/page_vma_mapped.c                     |   6 +-=0D
 mm/rmap.c                                |   8 +=0D
 mm/shmem.c                               |  39 +++-=0D
 mm/truncate.c                            |  17 +-=0D
 mm/userfaultfd.c                         |  37 +--=0D
 tools/testing/selftests/vm/userfaultfd.c |  14 +-=0D
 38 files changed, 881 insertions(+), 223 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

