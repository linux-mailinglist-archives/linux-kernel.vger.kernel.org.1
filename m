Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1E204376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbgFVWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:20:26 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11272 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgFVWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:20:25 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef12e7c0001>; Mon, 22 Jun 2020 15:19:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 15:20:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jun 2020 15:20:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 22:20:18 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 22 Jun 2020 22:20:18 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef12ea20001>; Mon, 22 Jun 2020 15:20:18 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [RESEND PATCH] mm: fix migrate_vma_setup() src_owner and normal pages
Date:   Mon, 22 Jun 2020 15:20:08 -0700
Message-ID: <20200622222008.9971-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592864380; bh=ySmyg12ZvnX4sON6UJTDpZrJIeJKTXH2UZeIMBkOFh8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=JxJcBBvujeFk6CmyTc7FOCIAh0CEb3Tkllm/M6lhjXEWpvIXr3LbCH7+4VeCgmxYX
         w+zDJCSFAjsjBNGVqAixxnp9C30xqNvMtC1a/IMBep1BceLsN4bV8ft0CJTvPeCTHl
         BJJfU7l0TSUMsl/cFDBNTDyMI9waxcPUPSF4Sk7aiCT8OPV+FKN/A6DYUBOaN+kN7P
         o2Q/bIW39koLi/7ZZoOdpjc8XKTQyBct68HE1CT9cgV/H/zTFCzFQFlfMGbHF8mj9c
         i79N6Be5FqjJ+/LR7uyMaV66yVuSGEN37GyY2LRYJpEChbRPNJSl8eIEj0EOpRYwtY
         lnmPACycThJJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of migrate_vma_setup() does not know what type of page is
stored in the CPU's page tables. Pages within the specified range are
free to be swapped out, migrated, or freed until after migrate_vma_setup()
returns. The caller needs to set struct migrate_vma.src_owner in case a
page is a ZONE device private page that the device owns and might want to
migrate. However, the current code skips normal anonymous pages if
src_owner is set, thus preventing those pages from being migrated.
Remove the src_owner check for normal pages since src_owner only applies
to device private pages and allow a range of normal and device private
pages to be migrated.

Fixes: 800bb1c8dc80 ("mm: handle multiple owners of device private pages in=
 migrate_vma")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This is based on 5.8.0-rc2 for Andrew Morton's mm tree.
I believe it can be queued for 5.8-rcX after being reviewed.
This was part of a larger series but I'm resending it separately as
suggested by Jason Gunthorpe.
https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.co=
m/

 mm/migrate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..24535281cea3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2295,8 +2295,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (is_write_device_private_entry(entry))
 				mpfn |=3D MIGRATE_PFN_WRITE;
 		} else {
-			if (migrate->src_owner)
-				goto next;
 			pfn =3D pte_pfn(pte);
 			if (is_zero_pfn(pfn)) {
 				mpfn =3D MIGRATE_PFN_MIGRATE;
--=20
2.20.1

