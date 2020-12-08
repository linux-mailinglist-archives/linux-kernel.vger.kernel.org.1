Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74732D3233
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgLHS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:29:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730454AbgLHS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:29:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8I1M6l180887;
        Tue, 8 Dec 2020 13:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=dCWMN9LSCY8KccMhTXdAKysM9baWfzMNIMM2kI9/EMA=;
 b=q8ohGRdj0AfgJnoJ094XpzezQfcbMZDeTGEoi8zlwHQDa7Xi/bXtIGIDlRUL7EhcdxjF
 qDx1aLcE6VMhKHs6EDzTxHv5TojShJ95WZrLwDTwiIHjbcERkzooiHUEtx3AWLaN6hjV
 KesJxMxKao92UslqAIID3vrmbMHdJLMKQQMcAvTNKtpBA2BgKr1XT1QLyjPprGcz1kzs
 Qhia0dISrOVDLJRpddo8g/eQpF2I7yLwrAVaul/YyYGMCUgOT9xyRlEr7bdO+9eKxX4N
 NmGiE+pn41shTW8R3iltZDuVrW4UTWq+jn1SHPvqqIoj/he71a8PaXpPclOdcwdzjb3D Yg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35adg3an7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 13:28:52 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8ICkGp001331;
        Tue, 8 Dec 2020 18:28:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3581fhhy8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 18:28:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8ISl4A47186260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 18:28:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D410AE058;
        Tue,  8 Dec 2020 18:28:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F4A2AE053;
        Tue,  8 Dec 2020 18:28:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 18:28:47 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [RFC PATCH 1/1] mm/hugetlb: clear compound_nr before freeing gigantic pages
Date:   Tue,  8 Dec 2020 19:28:13 +0100
Message-Id: <20201208182813.66391-2-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208182813.66391-1-gerald.schaefer@linux.ibm.com>
References: <20201208182813.66391-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=2 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1378a5ee451a ("mm: store compound_nr as well as compound_order")
added compound_nr counter to first tail struct page, overlaying with
page->mapping. The overlay itself is fine, but while freeing gigantic
hugepages via free_contig_range(), a "bad page" check will trigger for
non-NULL page->mapping on the first tail page:

[  276.681603] BUG: Bad page state in process bash  pfn:380001
[  276.681614] page:00000000c35f0856 refcount:0 mapcount:0 mapping:00000000126b68aa index:0x0 pfn:0x380001
[  276.681620] aops:0x0
[  276.681622] flags: 0x3ffff00000000000()
[  276.681626] raw: 3ffff00000000000 0000000000000100 0000000000000122 0000000100000000
[  276.681628] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
[  276.681630] page dumped because: non-NULL mapping
[  276.681632] Modules linked in:
[  276.681637] CPU: 6 PID: 616 Comm: bash Not tainted 5.10.0-rc7-next-20201208 #1
[  276.681639] Hardware name: IBM 3906 M03 703 (LPAR)
[  276.681641] Call Trace:
[  276.681648]  [<0000000458c252b6>] show_stack+0x6e/0xe8
[  276.681652]  [<000000045971cf60>] dump_stack+0x90/0xc8
[  276.681656]  [<0000000458e8b186>] bad_page+0xd6/0x130
[  276.681658]  [<0000000458e8cdea>] free_pcppages_bulk+0x26a/0x800
[  276.681661]  [<0000000458e8e67e>] free_unref_page+0x6e/0x90
[  276.681663]  [<0000000458e8ea6c>] free_contig_range+0x94/0xe8
[  276.681666]  [<0000000458ea5e54>] update_and_free_page+0x1c4/0x2c8
[  276.681669]  [<0000000458ea784e>] free_pool_huge_page+0x11e/0x138
[  276.681671]  [<0000000458ea8530>] set_max_huge_pages+0x228/0x300
[  276.681673]  [<0000000458ea86c0>] nr_hugepages_store_common+0xb8/0x130
[  276.681678]  [<0000000458fd5b6a>] kernfs_fop_write+0xd2/0x218
[  276.681681]  [<0000000458ef9da0>] vfs_write+0xb0/0x2b8
[  276.681684]  [<0000000458efa15c>] ksys_write+0xac/0xe0
[  276.681687]  [<000000045972c5ca>] system_call+0xe6/0x288
[  276.681730] Disabling lock debugging due to kernel taint

This is because only the compound_order is cleared in
destroy_compound_gigantic_page(), and compound_nr is set to 1U << order == 1
for order 0 in set_compound_order(page, 0).

Fix this by explicitly clearing compound_nr for first tail page after calling
set_compound_order(page, 0).

Cc: <stable@vger.kernel.org> # 5.9+
Fixes: 1378a5ee451a ("mm: store compound_nr as well as compound_order")
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f3bf1710b66..3bcc0bc7e02a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1216,6 +1216,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 	}
 
 	set_compound_order(page, 0);
+	page[1].compound_nr = 0;
 	__ClearPageHead(page);
 }
 
-- 
2.17.1

