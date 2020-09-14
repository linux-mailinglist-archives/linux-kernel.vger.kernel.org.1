Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586702697CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:38:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14783 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:38:05 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5fe2300000>; Mon, 14 Sep 2020 14:35:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 14:38:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 14:38:04 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 21:38:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 14 Sep 2020 21:38:04 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f5fe2bc0001>; Mon, 14 Sep 2020 14:38:04 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] hmm/test: remove unused dmirror_zero_page
Date:   Mon, 14 Sep 2020 14:38:01 -0700
Message-ID: <20200914213801.16520-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600119344; bh=/ehxgyAd0to++qcy0nw+lw74+CJwaK3eELXvYHOH04U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=BNGhvkUhGaPzR2Su8Yf85FP0WTC4Ex3+dP1SQBuUhsLIlziIr7iW6XmP7QQAaV33C
         OVeibN5Dc2drX1yhsalabrjJhDd9R5EiriPw5QnueLqqGQm+b+KZ19LycAdNhNbMm6
         eLyzD6uFxQSLToXH2zIqn5EIUrQ6HAJDPwicKbQR6GC5rnBwgx+4aos7f9+G2yJ5nI
         DKJrJjZKt0nkyvNne0INe3ZI3vdnJffT/tWkrHhgb7pqDsOozWCDSRaRvN5ll5hI3v
         VELlwhMC6y9A3iOyHdI8XcEXUDpPwjY9N01v6Ju/6f4OY/ejtFbpWmPYq+Rqxee+dy
         OOdt1cfd6+tww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dmirror_zero_page is unused in the HMM self test driver
which was probably intended to demonstrate how a driver could use
migrate_vma_setup() to share a single read-only device private zero page
similar to how the CPU does. However, this isn't needed for the self tests
so remove it.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This applies to linux-mm and is intended for Andrew Morton's git tree.

 lib/test_hmm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index e3065d6123f0..c8133f50160b 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -36,7 +36,6 @@
 static const struct dev_pagemap_ops dmirror_devmem_ops;
 static const struct mmu_interval_notifier_ops dmirror_min_ops;
 static dev_t dmirror_dev;
-static struct page *dmirror_zero_page;
=20
 struct dmirror_device;
=20
@@ -1127,17 +1126,6 @@ static int __init hmm_dmirror_init(void)
 			goto err_chrdev;
 	}
=20
-	/*
-	 * Allocate a zero page to simulate a reserved page of device private
-	 * memory which is always zero. The zero_pfn page isn't used just to
-	 * make the code here simpler (i.e., we need a struct page for it).
-	 */
-	dmirror_zero_page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);
-	if (!dmirror_zero_page) {
-		ret =3D -ENOMEM;
-		goto err_chrdev;
-	}
-
 	pr_info("HMM test module loaded. This is only for testing HMM.\n");
 	return 0;
=20
@@ -1153,8 +1141,6 @@ static void __exit hmm_dmirror_exit(void)
 {
 	int id;
=20
-	if (dmirror_zero_page)
-		__free_page(dmirror_zero_page);
 	for (id =3D 0; id < DMIRROR_NDEVICES; id++)
 		dmirror_device_remove(dmirror_devices + id);
 	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
--=20
2.20.1

