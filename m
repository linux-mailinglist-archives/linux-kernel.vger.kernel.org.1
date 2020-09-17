Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66226E2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIQRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:41:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13171 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIQRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:40:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f639f130006>; Thu, 17 Sep 2020 10:38:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 10:39:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 10:39:56 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 17:39:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Sep 2020 17:39:53 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f639f680002>; Thu, 17 Sep 2020 10:39:53 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Yu Zhao <yuzhao@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm: move call to compound_head() in release_pages()
Date:   Thu, 17 Sep 2020 10:39:38 -0700
Message-ID: <20200917173938.16420-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600364307; bh=Oa+LacQu7IjzncAKrybq1ytsDP5qw2OwCrK9wyjMjk4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=AsxuTQXPq60UZALfi7MqrgZdLHn8bXGiss8zyd7yZNEE60C8cR3UInAEGEz3rqKq1
         HVgSk3Bblal8eFnFMu0ThbT8LXdVFN0/g8TANz+OAdn+IRWH78iJVXUXJYUQ2lBUpa
         ZyNxzDm0d0M8l32ICgtyFWbrhZWuSShp3ivkYkoTee5QEJ0PDLEKqeL72/1wzUrYKu
         sXw+rZtOir8kmBcoFnyGVwOBvwctWv3LF54oAVCcwPgASowvm7z4Lh7E362LSnAQaF
         NiDct6PwxXM+kECjb0yUKGs/SDMHfh3TU4+h6wQhMtm0bhSWQ5QA30fzfLqR2KchYF
         SJtiHR5GhYqKA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is_huge_zero_page() doesn't call compound_head() to make sure
the page pointer is a head page. The call to is_huge_zero_page() in
release_pages() is made before compound_head() is called so the test would
fail if release_pages() was called with a tail page of the huge_zero_page
and put_page_testzero() would be called releasing the page.
This is unlikely to be happening in normal use or we would be seeing all
sorts of process data corruption when accessing a THP zero page.

Looking at other places where is_huge_zero_page() is called, all seem to
only pass a head page so I think the right solution is to move the call
to compound_head() in release_pages() to a point before calling
is_huge_zero_page().

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

I found this by code inspection while working on my patch
("mm: remove extra ZONE_DEVICE struct page refcount").

This applies cleanly on the latest linux-mm and is for Andrew Morton's
tree.

 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index eca95afe7ad4..7e79829a2e73 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -889,6 +889,7 @@ void release_pages(struct page **pages, int nr)
 			locked_pgdat =3D NULL;
 		}
=20
+		page =3D compound_head(page);
 		if (is_huge_zero_page(page))
 			continue;
=20
@@ -910,7 +911,6 @@ void release_pages(struct page **pages, int nr)
 			}
 		}
=20
-		page =3D compound_head(page);
 		if (!put_page_testzero(page))
 			continue;
=20
--=20
2.20.1

