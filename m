Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1672AE44B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbgKJXoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:44:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35326 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731558AbgKJXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:44:22 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fab25d00000>; Wed, 11 Nov 2020 07:44:16 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov
 2020 23:44:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 10 Nov 2020 23:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMpxVpCGszWb7x4PwQvQJ2547WQcb3GMo1lbz+EwZlS1ZxajpoMPsG0esNHZjlli4fM16YR+tdkF+rzafPTcEIm7GPLt/2gt4/vMGGzMqakU4oDwD5wOwzJC2WbXHTrKjq49NUIbbwVY1x4QZS9Hw02nfjYmu2YgLPGdI7Amg/7ESMMMmZaZVzWKvHOXjSAYmLxY3sJqGaidCx5gZi+3FkhQ5uw5WjBHMbBslWA1rs+JVWVL04ekmrMjbTKD+QwE0h3OUMqV81ogf3LB+sMvGh8xFkHt7XYoamVo3eY4w/JanImqYhKsfkO3EYWmg2ivuY1nJaciaAF40pbPiBrksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16KnzsKUgcK5HQc6CkO77EkFqJ9Cf4jaoof4yrWubRc=;
 b=n6KjULqZDFLNCPK5T87JkHwCJjP1SFTOPfdNTjgM0mKI5W8vcCvB+vK5Llk/agi6BDC10AHv5EZZkGVhztJ918ruSkeS4oYynDusZMRZOSj7hKhaIsK12mObPM9YutKNT3dfPiHr3F5XjDPrakJeUMhgZwKI+pP4tKvVson2s6SzJbTYFsxFcg8mH1jihLQZ/TadZUWduJgtZ9MytrYx2CJEDoG84JB4Up5GCka+lyKug5p8JzTvEgDGHMPYJzlFblOqPJt2P0kBY55ymfDX9z9RqMXtBMFRPH3svGu3bdV+t0UB8yyDeGGp+b8Ja3LAKKD0tKkFE3spgld0fQ/96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Tue, 10 Nov
 2020 23:44:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 23:44:11 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v4 1/2] mm: reorganize internal_get_user_pages_fast()
Date:   Tue, 10 Nov 2020 19:44:08 -0400
Message-ID: <1-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
In-Reply-To: <0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Tue, 10 Nov 2020 23:44:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kcdJ3-0036MI-DK; Tue, 10 Nov 2020 19:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605051856; bh=8vfCpzh0Dz7yx0tdFAZh1nokwVWioFMWryE1oM5j7GE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=gogLLacECClb1Mcflu5u1ZebePQOt/CXsRt0DmP+DiA1jppVJPBBQ3QeFjDhTdc7k
         xNSIC6KRsMiQdg1zpioH1v/NdRkvdQXsp4y2/SrFnYHbE7zacg3Uo7oeHImfaKcMCj
         ia09OACh10jCVZte73QWafP4mlpgRffljWvfCIDEA8czNsl6O6PpoSonFjn/PyLvVT
         y1IsheqqzfPUfyVSgq5urQ+qJK0q/D3Gq67jwCjY7k7VGoaF2iTFuBK9H5zXEVOmIv
         NTLHWSQ6RvU0Njd7e43tsYdwrynF4YezMf+S6LMG9sR/ngeoZtaF+37C7nCSvyOcQg
         Te7GDto/ocSWg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch in this series makes the lockless flow a little more
complex, so move the entire block into a new function and remove a level
of indention. Tidy a bit of cruft:

 - addr is always the same as start, so use start

 - Use the modern check_add_overflow() for computing end =3D start + len

 - nr_pinned/pages << PAGE_SHIFT needs the LHS to be unsigned long to
   avoid shift overflow, make the variables unsigned long to avoid coding
   casts in both places. nr_pinned was missing its cast

 - The handling of ret and nr_pinned can be streamlined a bit

No functional change.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 99 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 98eb8e6d2609c3..c7e24301860abb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2677,13 +2677,43 @@ static int __gup_longterm_unlocked(unsigned long st=
art, int nr_pages,
 	return ret;
 }
=20
-static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
+static unsigned long lockless_pages_from_mm(unsigned long start,
+					    unsigned long end,
+					    unsigned int gup_flags,
+					    struct page **pages)
+{
+	unsigned long flags;
+	int nr_pinned =3D 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) ||
+	    !gup_fast_permitted(start, end))
+		return 0;
+
+	/*
+	 * Disable interrupts. The nested form is used, in order to allow full,
+	 * general purpose use of this routine.
+	 *
+	 * With interrupts disabled, we block page table pages from being freed
+	 * from under us. See struct mmu_table_batch comments in
+	 * include/asm-generic/tlb.h for more details.
+	 *
+	 * We do not adopt an rcu_read_lock() here as we also want to block IPIs
+	 * that come from THPs splitting.
+	 */
+	local_irq_save(flags);
+	gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
+	local_irq_restore(flags);
+	return nr_pinned;
+}
+
+static int internal_get_user_pages_fast(unsigned long start,
+					unsigned long nr_pages,
 					unsigned int gup_flags,
 					struct page **pages)
 {
-	unsigned long addr, len, end;
-	unsigned long flags;
-	int nr_pinned =3D 0, ret =3D 0;
+	unsigned long len, end;
+	unsigned long nr_pinned;
+	int ret;
=20
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
@@ -2697,54 +2727,33 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
 		might_lock_read(&current->mm->mmap_lock);
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
-	addr =3D start;
-	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
-	end =3D start + len;
-
-	if (end <=3D start)
+	len =3D nr_pages << PAGE_SHIFT;
+	if (check_add_overflow(start, len, &end))
 		return 0;
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
=20
-	/*
-	 * Disable interrupts. The nested form is used, in order to allow
-	 * full, general purpose use of this routine.
-	 *
-	 * With interrupts disabled, we block page table pages from being
-	 * freed from under us. See struct mmu_table_batch comments in
-	 * include/asm-generic/tlb.h for more details.
-	 *
-	 * We do not adopt an rcu_read_lock(.) here as we also want to
-	 * block IPIs that come from THPs splitting.
-	 */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && gup_fast_permitted(start, end)) {
-		unsigned long fast_flags =3D gup_flags;
-
-		local_irq_save(flags);
-		gup_pgd_range(addr, end, fast_flags, pages, &nr_pinned);
-		local_irq_restore(flags);
-		ret =3D nr_pinned;
-	}
-
-	if (nr_pinned < nr_pages && !(gup_flags & FOLL_FAST_ONLY)) {
-		/* Try to get the remaining pages with get_user_pages */
-		start +=3D nr_pinned << PAGE_SHIFT;
-		pages +=3D nr_pinned;
+	nr_pinned =3D lockless_pages_from_mm(start, end, gup_flags, pages);
+	if (nr_pinned =3D=3D nr_pages || gup_flags & FOLL_FAST_ONLY)
+		return nr_pinned;
=20
-		ret =3D __gup_longterm_unlocked(start, nr_pages - nr_pinned,
-					      gup_flags, pages);
-
-		/* Have to be a bit careful with return values */
-		if (nr_pinned > 0) {
-			if (ret < 0)
-				ret =3D nr_pinned;
-			else
-				ret +=3D nr_pinned;
-		}
+	/* Slow path: try to get the remaining pages with get_user_pages */
+	start +=3D nr_pinned << PAGE_SHIFT;
+	pages +=3D nr_pinned;
+	ret =3D __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
+				      pages);
+	if (ret < 0) {
+		/*
+		 * The caller has to unpin the pages we already pinned so
+		 * returning -errno is not an option
+		 */
+		if (nr_pinned)
+			return nr_pinned;
+		return ret;
 	}
-
-	return ret;
+	return ret + nr_pinned;
 }
+
 /**
  * get_user_pages_fast_only() - pin user pages in memory
  * @start:      starting user address
--=20
2.29.2

