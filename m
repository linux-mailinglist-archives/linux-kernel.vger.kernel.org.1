Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0802952C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504788AbgJUTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:13:57 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13029 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgJUTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:13:57 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9088450000>; Wed, 21 Oct 2020 12:13:09 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 19:13:56 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Oct 2020 19:13:56 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH] mm: optimize migrate_vma_pages() mmu notifier
Date:   Wed, 21 Oct 2020 12:13:35 -0700
Message-ID: <20201021191335.10916-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603307589; bh=LZRrQCf0szPeaP51dA4nPF1DXPPmj4P4e5jvIgcuuGQ=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=bw248tYI3ov/44qIiE8IwH+jK3e3SrXX/V3qYHCCe4HB5i2E0due5+0mACcwjGc+T
         zm0l7jC9H2cyzU4iVOrte2DNoOTfxtA0DjayM0mIS90UxWFVPtE2ZNHd1Ev2+lmH1G
         APcO+QZchzRPz+anuCtt0v7l8HbvSUCA0dAh3MEQhB3y4JkGxyc5lRFHtxKdfThoWw
         w8Bbxz9bVDEkZTlWK/98LQ3Qyhs8/vQFIQkkTNpJfuKYFhy/0gUFrZT+Hd6qh47DiG
         DK93VSG5KwZhi2jJajZjWfcnx2MWko0RgXo6+kH8BDXWmBaDxlQvqgkUmsKHtX6xwd
         k7VPIXmdeZgOw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migrating a zero page or pte_none() anonymous page to device private
memory, migrate_vma_setup() will initialize the src[] array with a NULL
PFN. This lets the device driver allocate device private memory and clear
it instead of DMAing a page of zeros over the device bus. Since the source
page didn't exist at the time, no struct page was locked nor a migration
PTE inserted into the CPU page tables. The actual PTE insertion happens
in migrate_vma_pages() when it tries to insert the device private struct
page PTE into the CPU page tables. migrate_vma_pages() has to call the
mmu notifiers again since another device could fault on the same page
before the page table locks are acquired. Allow device drivers to optimize
the invalidation similar to migrate_vma_setup() by calling
mmu_notifier_range_init() which sets struct mmu_notifier_range event type
to MMU_NOTIFY_MIGRATE and the migrate_pgmap_owner field.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This is for Andrew Morton's mm tree after the merge window.

 mm/migrate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..560b57dde960 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2999,11 +2999,10 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 			if (!notified) {
 				notified =3D true;
=20
-				mmu_notifier_range_init(&range,
-							MMU_NOTIFY_CLEAR, 0,
-							NULL,
-							migrate->vma->vm_mm,
-							addr, migrate->end);
+				mmu_notifier_range_init_migrate(&range, 0,
+					migrate->vma, migrate->vma->vm_mm,
+					addr, migrate->end,
+					migrate->pgmap_owner);
 				mmu_notifier_invalidate_range_start(&range);
 			}
 			migrate_vma_insert_page(migrate, addr, newpage,
--=20
2.20.1

