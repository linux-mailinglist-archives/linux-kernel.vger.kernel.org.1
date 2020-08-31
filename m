Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F87D25836B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 23:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgHaVWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 17:22:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5013 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgHaVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:22:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d6a070000>; Mon, 31 Aug 2020 14:22:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 14:22:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 14:22:29 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 21:22:29 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 21:22:29 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4d6a140006>; Mon, 31 Aug 2020 14:22:28 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/2] mm/migrate: preserve soft dirty in remove_migration_pte()
Date:   Mon, 31 Aug 2020 14:22:20 -0700
Message-ID: <20200831212222.22409-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598908935; bh=UqSaEjVKRDigAnXTaZv87UbB5BQqSljjNFR50VCCUhE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=nEGcuCD1tZz6OO0AOlAhzyjH9z6VAJWFDGM896f2W0HVOHAzTUIAGKJ3by6UtSz7R
         pkf0mHBID16ptTpPp/6fDrNV+o+KMQk5d8SaGQGaEUFHMWlf067qbM+9C74KTKCeKh
         rTvueh0eHHUgFaGqPZmpvtNviN/vON3LrvBbDgF8khwGABdlZAerKGyLD1KQeuNfgC
         lzZUjEOIaJBI74yOiqOT42mxPtApwULdNYXwinhJnUQGsRuonZeX1+pHp9LqEPxumN
         LvbwPP/t0aJKJUGehDwD/4f7PR9cx6on6idDsxpy+VgFRO0IbjD33v2jDt8GsUxqCY
         ap+f/t2O4x9PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two small patches for Andrew Morton's mm tree.
I happened to notice this from code inspection after seeing Alistair
Popple's patch ("mm/rmap: Fixup copying of soft dirty and uffd ptes").

Ralph Campbell (2):
  mm/migrate: remove unnecessary is_zone_device_page() check
  mm/migrate: preserve soft dirty in remove_migration_pte()

 mm/migrate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--=20
2.20.1

