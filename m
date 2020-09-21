Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C0273179
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgIUSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:07:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45324 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:07:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LI70qZ095814;
        Mon, 21 Sep 2020 18:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=OunsT9Nc2XfTQN0xbAJbz9ZbMi/lfCNrPIhCBDM+lVY=;
 b=Zz/DRhmG1JeGmwcFD5IiJnGxzrkSgtWcelauThBR7rR8zs1bWPbIbsMtTOgQJpRBdeVz
 TJST6M7rtYC6NKhtWtQxZPN4fgXgdJcxgwuwL7CWRZSpCgwuy2A74ehTF1aRS/xKM+iF
 icxwZeoG+AaUMSXWOeigP85P25Vggxwe4j4KZFfgH6fVpoyD0jOjvhE0SUY3KAZtQrA0
 MC45cizkowH4dnM4MnE5HN0uPH2JwrxIITUxBk6PVsxPYWZDcYCDq5npjHhJqiOkZ1Ye
 EQSSnT+IxQHhGPgl6Uc8f3qNOB0tp6wOPgSvW4HH9cUgle+O/B4vtT86q++V09ajGpfu jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33ndnu7eyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 18:07:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LI6H7o066130;
        Mon, 21 Sep 2020 18:07:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33nujm2t1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 18:07:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08LI7Bg0030823;
        Mon, 21 Sep 2020 18:07:11 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 11:07:11 -0700
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liam.Howlett@Oracle.com
Subject: [RESEND PATCH] mm/mmap: Fix Add inline munmap_vma_range() for code readability
Date:   Mon, 21 Sep 2020 14:07:02 -0400
Message-Id: <20200921180702.1204591-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace after the function, and fix comment arguments to
match arguments.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b59b4e5889b5c..c64f4fc410312 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -584,8 +584,8 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
  * @start: The start of the range.
  * @len: The length of the range.
  * @pprev: pointer to the pointer that will be set to previous vm_area_struct
- * @rb_link: the rb_node
- * @rb_parent: the parent rb_node
+ * @link: the rb_node
+ * @parent: the parent rb_node
  *
  * Find all the vm_area_struct that overlap from @start to
  * @end and munmap them.  Set @pprev to the previous vm_area_struct.
@@ -604,6 +604,7 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
 
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-- 
2.28.0

