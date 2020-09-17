Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6026E6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIQUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:52:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:52:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HKmtHN151903;
        Thu, 17 Sep 2020 20:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=uOKO1pP9/ZwDHCxQcxy7oY3YRsKr+joiAte8FN0yJSU=;
 b=n3qNSeWHZJQ8zlMKsYTyH5W0Z3l7jS7FkkT7kMpTntJbI/OgBC3GnYUvtJuSoxemBTGL
 7ur+7CPRPAFPPasbX/dySX1ErzsPfMLr+8ZdccPBW2B3MzeHrVwa2Xrz/pJsBmEiho1L
 i4g7yEhRKf7vOVqAXVhyNUwTjCcxgkh6WJGPuU3Pw06ctKw6obfu+J4r6qOlA7BE04tq
 vHVxFM/HB48c26nWDXygah8/F5trhaoEtWjq0CrwTMyG1q9Lst3EG6iaVpwf19m/z7u0
 lTY3D147OdhYuADvhnYV3azXfg21NUBUfdXaX5KQtrGB1ekhW/QrS+JoE1ftWu6Nr6lI XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9mkqeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 20:52:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HKnYE0036918;
        Thu, 17 Sep 2020 20:50:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h88ce99j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 20:50:10 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HKo890024374;
        Thu, 17 Sep 2020 20:50:09 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 20:50:08 +0000
Date:   Thu, 17 Sep 2020 16:59:12 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/migrate: correct thp migration stats.
Message-ID: <20200917205912.fljcyldna6bg7m4l@ca-dmjordan1.us.oracle.com>
References: <20200917202729.1460743-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917202729.1460743-1-zi.yan@sent.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:27:29PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> PageTransHuge returns true for both thp and hugetlb, so thp stats was
> counting both thp and hugetlb migrations. Exclude hugetlb migration by
> setting is_thp variable right.

Yeah, shoot.

> Fixes: 1a5bae25e3cf ("mm/vmstat: add events for THP migration without split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

If you wanted, you could also do this.

diff --git a/mm/migrate.c b/mm/migrate.c
index d1ad964165e5..6bc9559afc70 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1471,7 +1471,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * we encounter them after the rest of the list
 				 * is processed.
 				 */
-				if (PageTransHuge(page) && !PageHuge(page)) {
+				if (is_thp) {
 					lock_page(page);
 					rc = split_huge_page_to_list(page, from);
 					unlock_page(page);
@@ -1480,8 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						nr_thp_split++;
 						goto retry;
 					}
-				}
-				if (is_thp) {
+
 					nr_thp_failed++;
 					nr_failed += nr_subpages;
 					goto out;
