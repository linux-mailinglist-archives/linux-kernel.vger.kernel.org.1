Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA62979E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 02:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756151AbgJXATr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 20:19:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57185 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756113AbgJXATr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 20:19:47 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9373210001>; Sat, 24 Oct 2020 08:19:45 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 00:19:45 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 24 Oct 2020 00:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAnP+KvE0ZTC1TJK9JFy0lCznW/lie6a8zeFvaE4yirirydFzz9iRdh+MEAv1d19iE+1yDxzTkP65fuiVwhK6QUHeh8A9Aheu58H2fCsaOus1aj6OB9Ga2l5TlQs2KA5qjxR99VSX8KWXFjLi9b7Mb2/EaIdJ7T7hPQFhEBFSMDSH3Qt6vJwy04gtZclqlCgMZX+9Pk4l+1/x+6gykyKY3i/auoA9WISNzlwfNC+pQgwzIHHg9aeAqXJ5BNPjuseoraUB8zOMOWazVgFQ3UBhKMQ/oHF5pBeizFNwDO/UWS2ukIPO3Ydtu7VrjHBtEAYNSWpLHKsrtIFN+xleFBpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6lvE5KFrGT2glk0IvplBQL/FjmOAQX1ki5GDQJKLTA=;
 b=BHBIsLrUYKj/5PJ3L2An3bW+7Gq9gThQmNroOlPot81g2tvOpbBH5t/csgyUs74/Lese4ZqNMiAp6KeHqwOTGNzKDf09f/FskD2kYhsO1VpBqpeApXt145j4UuMBRkVwaZNjTeRTpe9GnmwYGbQL5IBO2SKzyt8lajXTmbImjnpN8A7oTVqPVrqpRYBn1FQvILWfFrvp2fdbxQ9a5zVK8HOKFkAGipSzaNnOnNdCN5VTcl1qzKeyvF9jCQLGneDAn4asErYOlzX73CPjaQkggsuVX4jtfCLf3NOvRNP3Q2j/0I8JgB8NugtUPEMrxf81xKnJcZKenp9cAww9TECHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 24 Oct
 2020 00:19:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Sat, 24 Oct 2020
 00:19:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
Date:   Fri, 23 Oct 2020 21:19:19 -0300
Message-ID: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
In-Reply-To: <0-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:208:15e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Sat, 24 Oct 2020 00:19:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kW7HE-0076cu-AL; Fri, 23 Oct 2020 21:19:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603498785; bh=GVa84VnEegAdeEI4tI44shwwreAL+Tee7b7SZqf61uU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=n2RFXYAFb+yP+lbFB+3htfwpWnw9VaQ0Z3pHJDJU2jGAuIufel3gwT6wI6QxGOWEX
         KN1uroMbn73GHUx5cEqHoKWSImOTp2J3fdYSH6r9fjBRCGZohdqedq3aDg48Edr/J2
         kykABph/g7Kf7mUmk4TtLsqVY+D4YIC1KTiiB3TE0KwCUGr7pkYo1nFp7lcaA1XAEz
         JdgFPRd6rfCv5TkGrNb1PfsbdPSZOPeZeHgK5ndUfsH87I3oJ6lnsfDprh4k+p2NYi
         z2NzGyza4utQoeRGRzG4WkPCgPfXoEmbZnv7Q5rVIicaIHI776oVrPdvjH1lXsKzE2
         9p1HH1Rfutc5Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch in this series makes the lockless flow a little more
complex, so move the entire block into a new function and remove a level
of indention. Tidy a bit of cruft:

 - addr is always the same as start, so use start
 - Use the modern check_add_overflow() for computing end =3D start + len
 - nr_pinned << PAGE_SHIFT needs an unsigned long cast, like nr_pages
 - The handling of ret and nr_pinned can be streamlined a bit

No functional change.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 88 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 102877ed77a4b4..ecbe1639ea2af7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2671,13 +2671,42 @@ static int __gup_longterm_unlocked(unsigned long st=
art, int nr_pages,
 	return ret;
 }
=20
+static unsigned int lockless_pages_from_mm(unsigned long addr,
+					   unsigned long end,
+					   unsigned int gup_flags,
+					   struct page **pages)
+{
+	unsigned long flags;
+	int nr_pinned =3D 0;
+
+	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) ||
+	    !gup_fast_permitted(addr, end))
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
+	 * We do not adopt an rcu_read_lock(.) here as we also want to block
+	 * IPIs that come from THPs splitting.
+	 */
+	local_irq_save(flags);
+	gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
+	local_irq_restore(flags);
+	return nr_pinned;
+}
+
 static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 					unsigned int gup_flags,
 					struct page **pages)
 {
-	unsigned long addr, len, end;
-	unsigned long flags;
-	int nr_pinned =3D 0, ret =3D 0;
+	unsigned long len, end;
+	unsigned int nr_pinned;
+	int ret;
=20
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
 				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
@@ -2691,53 +2720,28 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
 		might_lock_read(&current->mm->mmap_lock);
=20
 	start =3D untagged_addr(start) & PAGE_MASK;
-	addr =3D start;
 	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
-	end =3D start + len;
-
-	if (end <=3D start)
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
-
-		ret =3D __gup_longterm_unlocked(start, nr_pages - nr_pinned,
-					      gup_flags, pages);
+	nr_pinned =3D lockless_pages_from_mm(start, end, gup_flags, pages);
+	if (nr_pinned =3D=3D nr_pages || gup_flags & FOLL_FAST_ONLY)
+		return nr_pinned;
=20
+	/* Try to get the remaining pages with get_user_pages */
+	start +=3D (unsigned long)nr_pinned << PAGE_SHIFT;
+	pages +=3D nr_pinned;
+	ret =3D __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
+				      pages);
+	if (ret < 0) {
 		/* Have to be a bit careful with return values */
-		if (nr_pinned > 0) {
-			if (ret < 0)
-				ret =3D nr_pinned;
-			else
-				ret +=3D nr_pinned;
-		}
+		if (nr_pinned)
+			return nr_pinned;
+		return ret;
 	}
-
-	return ret;
+	return ret + nr_pinned;
 }
 /**
  * get_user_pages_fast_only() - pin user pages in memory
--=20
2.28.0

