Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21128DBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgJNIfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:35:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgJNIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:35:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8XneR028323;
        Wed, 14 Oct 2020 08:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0xUha+Rzm7ppN9x+U34PLFU2iK8SLsjWF7MTNSZhBNE=;
 b=NxwER1YWmV2kX6CBdgiAEQgDNGSfrkpQYdBrEH3wyCit/fWJpVdgFYHi0f57Kux/i2aD
 3b6K+/otQuOjkv2a1WVQ7JgFBFbc1y2mRdQgnEi5AqbWog3z+iCRP/j1K94QkGWe2Ufj
 Y6gBlxq9e3kTy7wDN6i0q3wj24u5ZDh18qkYbzbamRsKHQ+vbA0uRbUzRD+2E7WuFWpw
 SgcDwQMCSLIg9Gm6UN58sPDOGSADB42R1ghl5/hjR09Zzs5c0VA/hnJB+lz9HlgUr+yo
 hlrMwgv7gPif5io4VbXCEHgfIZaye8olgBmxugGXACqPv7gqutIuHw79iNefSwONXY8c Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 343vaecgc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 08:35:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09E8TYYn005651;
        Wed, 14 Oct 2020 08:33:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by3a4ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 08:33:20 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09E8XKRQ029207;
        Wed, 14 Oct 2020 08:33:20 GMT
Received: from monad.ca.oracle.com (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 01:33:19 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/8] mm, clear_huge_page: use clear_page_uncached() for gigantic pages
Date:   Wed, 14 Oct 2020 01:32:57 -0700
Message-Id: <20201014083300.19077-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014083300.19077-1-ankur.a.arora@oracle.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uncached writes are suitable for circumstances where the region written to
is not expected to be read again soon, or the region written to is large
enough that there's no expectation that we will find the writes in the
cache.

Accordingly switch to using clear_page_uncached() for gigantic pages.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index eeae590e526a..4d2c58f83ab1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5092,7 +5092,7 @@ static void clear_gigantic_page(struct page *page,
 	for (i = 0; i < pages_per_huge_page;
 	     i++, p = mem_map_next(p, page, i)) {
 		cond_resched();
-		clear_user_highpage(p, addr + i * PAGE_SIZE);
+		clear_user_highpage_uncached(p, addr + i * PAGE_SIZE);
 	}
 }
 
@@ -5111,6 +5111,7 @@ void clear_huge_page(struct page *page,
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
 		clear_gigantic_page(page, addr, pages_per_huge_page);
+		clear_page_uncached_flush();
 		return;
 	}
 
-- 
2.9.3

