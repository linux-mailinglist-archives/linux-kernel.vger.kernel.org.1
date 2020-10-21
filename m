Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26B29531A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440524AbgJUTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:47:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10153 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410023AbgJUTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:47:55 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f90905e0000>; Wed, 21 Oct 2020 12:47:42 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 19:47:49 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Oct 2020 19:47:50 +0000
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm: handle zone device pages in release_pages()
Date:   Wed, 21 Oct 2020 12:47:33 -0700
Message-ID: <20201021194733.11530-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603309662; bh=MGJaH6/SdFv7VRZFRXj5UhNs695KbTQVGDqZPM15c4s=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=XoOqKyzLq98jjDNdrPZ2nieuS/tliQh+Vsm58Wq2Xh2ARaWytegEKizBYwn07xFiY
         xZRlQHUYYJ8YCsUdPd+cxh4D9JBOcWI7qsop5+C8oEVgElo15ct+ymYnUTTENrflvO
         bzrx5shdvT+mQGPvmM4Ad2Xs+1/YEIH9b5nXwr0bcw1xIVBLjrHUBSHDjjEOW9dKTQ
         5EZYObcyGvKaCtKUshtgIwT98fXaF5YVevnQ9+HnvKGJYEAtTr1anuLhPAkR9UZd8D
         JNefzmwVGyHeYisnKV6zPKUDyUJuSPsSsw7L3IkZ/IdnT+S4rrsln1ftziF4wwBM4A
         pEzXmT11x1pqw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release_pages() is an optimized, inlined version of __put_pages() except
that zone device struct pages that are not page_is_devmap_managed()
(i.e., memory_type MEMORY_DEVICE_GENERIC and MEMORY_DEVICE_PCI_P2PDMA),
fall through to the code that could return the zone device page to the
page allocator instead of adjusting the pgmap reference count.
Clearly these type of pages are not having the reference count decremented
to zero via release_pages() or page allocation problems would be seen.
Just to be safe, handle the 1 to zero case in release_pages() like
__put_page() does.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

I found this by code inspection while working on converting ZONE_DEVICE
struct pages to have zero based reference counts. I don't think there is
an actual problem that this fixes, it's more to future proof new uses of
release_pages().

This is for Andrew Morton's mm tree after the merge window.

 mm/swap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 0eb057141a04..106f519c45ac 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -907,6 +907,9 @@ void release_pages(struct page **pages, int nr)
 				put_devmap_managed_page(page);
 				continue;
 			}
+			if (put_page_testzero(page))
+				put_dev_pagemap(page->pgmap);
+			continue;
 		}
=20
 		if (!put_page_testzero(page))
--=20
2.20.1

