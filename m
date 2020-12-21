Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1512E00F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgLUT2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:28:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51310 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLUT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:28:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BLJJwq4044563;
        Mon, 21 Dec 2020 19:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5OKZyzCuTe8zgdBdEZA917bn9uZ0vrKeyWLL0CY+Yq4=;
 b=fyEu9ObSUy2aRGiqCrUZSBf5aWIc8TSDgKgVoe7/j7KOHlHr5BCJ9oSp1BUz8g1cwbtC
 Tf3LHMhEEUfa/Y5JSJF0dwxc7JaMb7U9jG4tZcGcUIHrmYg989TFjMc3UEx0SOaimisl
 +9nYIEnLUcmK1Wx3aXlR8YuWa5sg3/5yFulJu+uwcKR4S/6zVaItk5kJV0/yGsW5MQxA
 b8XMYIaJpqqPMvN5FFubalBVMWRQOwyYxpQJrCjvfRw1GX8qN1DZUpxNoqj5+rJ1cAmU
 WthavInLjC/f+PBgZcVrFlzBod7UTcUASMxKjMEVGNrdWv0DeVwqXz7LXGDd4cIv7cd5 dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35k0d10da9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 19:27:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BLJPqO2033184;
        Mon, 21 Dec 2020 19:25:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35k0e8jqym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 19:25:53 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BLJPoaG010561;
        Mon, 21 Dec 2020 19:25:50 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Dec 2020 11:25:50 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlbfs: remove special hugetlbfs_set_page_dirty()
Date:   Mon, 21 Dec 2020 11:25:42 -0800
Message-Id: <20201221192542.15732-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221192542.15732-1-mike.kravetz@oracle.com>
References: <20201221192542.15732-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox noticed that hugetlbfs_set_page_dirty always returns 0.
Instead, it should return 1 or 0 depending on the previous state of
the dirty bit.  In addition, the call to compound_head is redundant as
it is also performed in calling routine set_page_dirty.

Replace the hugetlbfs specific routine hugetlbfs_set_page_dirty with
__set_page_dirty_no_writeback as it addresses both of these issues.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 07d21391759c..e02548f608e4 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -944,17 +944,6 @@ static int hugetlbfs_symlink(struct inode *dir,
 	return error;
 }
 
-/*
- * mark the head page dirty
- */
-static int hugetlbfs_set_page_dirty(struct page *page)
-{
-	struct page *head = compound_head(page);
-
-	SetPageDirty(head);
-	return 0;
-}
-
 static int hugetlbfs_migrate_page(struct address_space *mapping,
 				struct page *newpage, struct page *page,
 				enum migrate_mode mode)
@@ -1148,7 +1137,7 @@ static void hugetlbfs_destroy_inode(struct inode *inode)
 static const struct address_space_operations hugetlbfs_aops = {
 	.write_begin	= hugetlbfs_write_begin,
 	.write_end	= hugetlbfs_write_end,
-	.set_page_dirty	= hugetlbfs_set_page_dirty,
+	.set_page_dirty	=  __set_page_dirty_no_writeback,
 	.migratepage    = hugetlbfs_migrate_page,
 	.error_remove_page	= hugetlbfs_error_remove_page,
 };
-- 
2.29.2

