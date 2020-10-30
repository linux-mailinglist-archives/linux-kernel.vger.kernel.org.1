Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239E62A0860
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgJ3Oso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:44 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1174 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ3OrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c27440000>; Fri, 30 Oct 2020 07:46:28 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 14:46:25 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 14:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHccT7vEsawlbEYcmxFpEmRTtRaCTmwalWT7aNqHnFqPBenXxsRiyt8Af29drXg3prkYYIjtGdmkDETSeuZHUAhEK9il4DRP6wX4VhQo8oVU53NOMSpK5u1phsrNJVYzdYWaAw4FJbHXHeRmXXgIDYb0Pjw7EsrLtxG2AQ8FS6Ok0YdQDVBBnqcJL2YJsz1fJnzcdBKejxjEpDqYa0pPoVRWfUtEzfksMLgwM9OgPcDEb4X5r4FVVW25NdQ60CNAi06SBJRNhleWWhU9OSz8Prtm2stCR//SS8B9GEDGJbp6Zn6rZrXfltVDTJ0mgoiNVYhgydmh1cywrnZgcQ17hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cPrVOW4yrEyx9eJTI24vwpcxCawqTA4/HeSik+aePY=;
 b=LBIQlvXMi9shJ+Ewbf2RisNwLKxs4rkTgXeA9PyVdDYTdmG9pT5Or5JljKbQ5gwfJVnEC0Eqz9oKFeDJWtSiQMVeZIoo7QSN8xGGrlKTzm4qO2I352O7khJaSDW8xcI9yVWh5kOulYZfhvzc9Y+0z3SUKFGG0oFjLkAJGvBj5vEbjxzQhXGmzM+evrzYCMhCQ+AUaJGeM1ddPL/bg+Nt8NwzkWGE5JpfDRI0jTgwX11IT4jezEV3uhFN5XTZsYEIQgD1c2rxtjR4f0hXoiZF47SwmVBHTgPzBAAM/h9uxvAUzUHYANX2a0Or64R1dU5nSj+sQzWlc/EbW82JOMVFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Fri, 30 Oct
 2020 14:46:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 14:46:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 1/2] mm: reorganize internal_get_user_pages_fast()
Date:   Fri, 30 Oct 2020 11:46:20 -0300
Message-ID: <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
In-Reply-To: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.7 via Frontend Transport; Fri, 30 Oct 2020 14:46:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYVfa-00DEpy-1H; Fri, 30 Oct 2020 11:46:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604069188; bh=2hjHbGDaNuupRQ/GjnzPzZ4B4MhwL4BaV/QvhQr7EkI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=Hw+BaCrahvrDoCs1MSdUhSnvR0ziTaYbFkrGfQ5NwBArLogvSyTXF1UE2a/SUAVBN
         YZoh9O9PRtqCilShuGTapooB4mptsnHLTgWC65ZqPwxb0YPulx88Hj/NnEN9CWzYZK
         ksp2irwE5GFnDlAxquBCdJfHyze0lfJ4z9ZU6IsItqWQgj77QWrKsa/wACXnoINnAs
         IZrvIeHHUE2Psj/y2naD+Iaew8AelQRUZM861ExH4W8kEW2bRgMrT8qagXIY6tApSP
         z8F3utlqw8hV++0Ym6emO0vKFCeRMsFS2qkYpBNb++YXAuR0Hu+KIw2K/DzR3TZ9D6
         ckC4Ak6GThxoQ==
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 99 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4b4..150cc962c99201 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2671,13 +2671,43 @@ static int __gup_longterm_unlocked(unsigned long st=
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
@@ -2691,54 +2721,33 @@ static int internal_get_user_pages_fast(unsigned lo=
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
+	nr_pinned =3D lockless_pages_from_mm(start, end, gup_flags, pages);
+	if (nr_pinned =3D=3D nr_pages || gup_flags & FOLL_FAST_ONLY)
+		return nr_pinned;
=20
-	if (nr_pinned < nr_pages && !(gup_flags & FOLL_FAST_ONLY)) {
-		/* Try to get the remaining pages with get_user_pages */
-		start +=3D nr_pinned << PAGE_SHIFT;
-		pages +=3D nr_pinned;
-
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
2.28.0

