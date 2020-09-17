Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872F26D419
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIQHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:02:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11781 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:02:27 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:02:21 EDT
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63086e0003>; Wed, 16 Sep 2020 23:55:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 23:57:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 23:57:11 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 06:57:08 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Sep 2020 06:57:07 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.57.133]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6308c30000>; Wed, 16 Sep 2020 23:57:07 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     <dan.carpenter@oracle.com>
CC:     <akpm@linux-foundation.org>, <alex.bou9@gmail.com>,
        <gustavoars@kernel.org>, <ira.weiny@intel.com>,
        <jhubbard@nvidia.com>, <jrdr.linux@gmail.com>,
        <linux-kernel@vger.kernel.org>, <madhuparnabhowmik10@gmail.com>,
        <mporter@kernel.crashing.org>, <willy@infradead.org>
Subject: [PATCH] mm/gup: protect unpin_user_pages() against npages==-ERRNO
Date:   Wed, 16 Sep 2020 23:57:06 -0700
Message-ID: <20200917065706.409079-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916100232.GF18329@kadam>
References: <20200916100232.GF18329@kadam>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600325742; bh=Sw6GoMTE1Ahsx/O0nTGxzqX6p0IVyTasU273plPnv7w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Q5jaHL5otDVB6AESLJeXZ/lSuNkAGz0Pdp0LnGdDVpGwaS8H+mWxD/RsHTXLVOvnb
         xWCTUzxZr5OEKh5nNSy/Ix0QSLWESAWLKZAjI/gc+fQEYC8pfWbBbAgNj126beLw6v
         DfvcHWJlYeBABHkzkBkv5ihX+ezky4AhytiXMXQn3AFjUQii3/ORVeIFg4BOsTudlA
         3f4Njq2/mmXhxzrXbauQuAk1Jw2BI6MJgN9OE53D7PBRUURb6ZHpaoiJ3TJzj/FLhB
         zAbJcICq5wTHl72es3ZEg68gMPs3joevtRblC+P+SdQjXxKL8UUUEAQWegmM5vFokv
         ZZ/9DbDD+meDw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Dan Carpenter, fortify unpin_user_pages() just a bit,
against a typical caller mistake: check if the npages arg is really a
-ERRNO value, which would blow up the unpinning loop: WARN and return.

If this new WARN_ON() fires, then the system *might* be leaking pages
(by leaving them pinned), but probably not. More likely, gup/pup
returned a hard -ERRNO error to the caller, who erroneously passed it
here.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi Dan,

Is is OK to use your signed-off-by here? Since you came up with this.

thanks,
John Hubbard
NVIDIA

 mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..41d082707016 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -328,6 +328,13 @@ void unpin_user_pages(struct page **pages, unsigned lo=
ng npages)
 {
 	unsigned long index;
=20
+	/*
+	 * If this WARN_ON() fires, then the system *might* be leaking pages (by
+	 * leaving them pinned), but probably not. More likely, gup/pup returned
+	 * a hard -ERRNO error to the caller, who erroneously passed it here.
+	 */
+	if (WARN_ON(IS_ERR_VALUE(npages)))
+		return;
 	/*
 	 * TODO: this can be optimized for huge pages: if a series of pages is
 	 * physically contiguous and part of the same compound page, then a
--=20
2.28.0

