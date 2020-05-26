Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411451D8C20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 02:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgESAVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 20:21:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8406 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgESAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:21:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec3267e0000>; Mon, 18 May 2020 17:21:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 17:21:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 17:21:30 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 00:21:27 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 May 2020 00:21:27 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.55.90]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec326860005>; Mon, 18 May 2020 17:21:27 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/4] mm/gup: refactor and de-duplicate gup_fast() code
Date:   Mon, 18 May 2020 17:21:22 -0700
Message-ID: <20200519002124.2025955-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519002124.2025955-1-jhubbard@nvidia.com>
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589847678; bh=eKEEE/Y/vrnjqqbzDXfpG1tDQCyxBc2uk5PwdO7UHPs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=roJzug6FRflfc5QOO84Nkmt/6yLm+3EdG5LWcwiimEiXJEmmGzLwiOsKBkg64BP1R
         yInCML2+VZTK3BiC3zBszmooskpy/aCsUaSDWsyDyd0g9TgCxJWBcEALOLx2b3IbPW
         zHq6A6OFlGYF2J/822ehCPooN1GK9t489gBEm/opQfMuUILvA4D05VVg1uvhWaeiub
         KGcDCDjk+KZZ6yH1Ahq4zouqWldX5K6E3aV2UnFVQKQctZf8e+fqGP9DU+SCF71ATe
         e5eaCHWXKtp3eVsNY+MaBe5hWwlSnTxBRrLO70c96RT1jp3pQsYa8wDK/fa3ij6kxa
         96mAjLKM6Jizg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were two nearly identical sets of code for gup_fast()
style of walking the page tables with interrupts disabled.
This has lead to the usual maintenance problems that arise from
having duplicated code.

There is already a core internal routine in gup.c for gup_fast(),
so just enhance it very slightly: allow skipping the fall-back
to "slow" (regular) get_user_pages(), via the new FOLL_FAST_ONLY
flag. Then, just call internal_get_user_pages_fast() from
__get_user_pages_fast(), and adjust the API to match pre-existing
API behavior.

There is a change in behavior from this refactoring: the nested
form of interrupt disabling is used in all gup_fast() variants
now. That's because there is only one place that interrupt disabling
for page walking is done, and so the safer form is required. This
should, if anything, eliminate possible (rare) bugs, because the
non-nested form of enabling interrupts was fragile at best.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 60 ++++++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a5594ac9ebe3..84b601cab699 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2782,6 +2782,7 @@ struct page *follow_page(struct vm_area_struct *vma, =
unsigned long address,
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below=
 */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
+#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup =
*/
=20
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with eac=
h
diff --git a/mm/gup.c b/mm/gup.c
index 4502846d57f9..bb3e2c4288c3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2694,6 +2694,7 @@ static int internal_get_user_pages_fast(unsigned long=
 start, int nr_pages,
 					struct page **pages)
 {
 	unsigned long addr, len, end;
+	unsigned long flags;
 	int nr_pinned =3D 0, ret =3D 0;
=20
 	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
@@ -2710,15 +2711,26 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
=20
+	/*
+	 * Disable interrupts. The nested form is used, in order to allow full,
+	 * general purpose use of this routine.
+	 *
+	 * With interrupts disabled, we block page table pages from being
+	 * freed from under us. See struct mmu_table_batch comments in
+	 * include/asm-generic/tlb.h for more details.
+	 *
+	 * We do not adopt an rcu_read_lock(.) here as we also want to
+	 * block IPIs that come from THPs splitting.
+	 */
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_disable();
+		local_irq_save(flags);
 		gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
-		local_irq_enable();
+		local_irq_restore(flags);
 		ret =3D nr_pinned;
 	}
=20
-	if (nr_pinned < nr_pages) {
+	if (nr_pinned < nr_pages && !(gup_flags & FOLL_FAST_ONLY)) {
 		/* Try to get the remaining pages with get_user_pages */
 		start +=3D nr_pinned << PAGE_SHIFT;
 		pages +=3D nr_pinned;
@@ -2750,45 +2762,29 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
-	unsigned long len, end;
-	unsigned long flags;
-	int nr_pinned =3D 0;
+	int nr_pinned;
 	/*
 	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
 	 * because gup fast is always a "pin with a +1 page refcount" request.
+	 *
+	 * FOLL_FAST_ONLY is required in order to match the API description of
+	 * this routine: no fall back to regular ("slow") GUP.
 	 */
-	unsigned int gup_flags =3D FOLL_GET;
+	unsigned int gup_flags =3D FOLL_GET | FOLL_FAST_ONLY;
=20
 	if (write)
 		gup_flags |=3D FOLL_WRITE;
=20
-	start =3D untagged_addr(start) & PAGE_MASK;
-	len =3D (unsigned long) nr_pages << PAGE_SHIFT;
-	end =3D start + len;
-
-	if (end <=3D start)
-		return 0;
-	if (unlikely(!access_ok((void __user *)start, len)))
-		return 0;
-
+	nr_pinned =3D internal_get_user_pages_fast(start, nr_pages, gup_flags,
+						 pages);
 	/*
-	 * Disable interrupts.  We use the nested form as we can already have
-	 * interrupts disabled by get_futex_key.
-	 *
-	 * With interrupts disabled, we block page table pages from being
-	 * freed from under us. See struct mmu_table_batch comments in
-	 * include/asm-generic/tlb.h for more details.
-	 *
-	 * We do not adopt an rcu_read_lock(.) here as we also want to
-	 * block IPIs that come from THPs splitting.
+	 * As specified in the API description above, this routine is not
+	 * allowed to return negative values. However, the common core
+	 * routine internal_get_user_pages_fast() *can* return -errno.
+	 * Therefore, correct for that here:
 	 */
-
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
-	    gup_fast_permitted(start, end)) {
-		local_irq_save(flags);
-		gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
-		local_irq_restore(flags);
-	}
+	if (nr_pinned < 0)
+		nr_pinned =3D 0;
=20
 	return nr_pinned;
 }
--=20
2.26.2

