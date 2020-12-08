Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607F12D3232
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgLHS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:29:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730490AbgLHS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:29:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8I2Xkw108436;
        Tue, 8 Dec 2020 13:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=2sprkH7X6430iSy8aZKUJoSEt3ENoaaXC2DRCVltC70=;
 b=UnGkJ9nF0jDwgQoQ62ovn7nll8uw4MM7KHiE3ACkguJTs3mPRPf0iXvPhMsR6EcMXX49
 RedQt1x1lmgoGrQ5umUFo+qRgmGlsNPm+S35QpfbXjD5VcaUKMvC8FRFkSG5lo7O8lJG
 yjHDq8dcUO0ML4FN1j3sSJkQKn2hR6uFkYVzstuN1gXowsTtlpoL37KF86qcVb4dSyiI
 hLiDl5GxjZWspv2PQbGfB8NV3rYfeOr4746kbIvHZMpkSJqrv9OfuCy+cnlhR9SXMX6g
 OkGCpoiUAWh0uTAwW7LDPrjwyZIXWj8jcrspSUjVby9m1l1OkQeK55UAWwf8VJKzah3e Xw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35acbkwbkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 13:28:51 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8ICh4I010994;
        Tue, 8 Dec 2020 18:28:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhktxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 18:28:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8ISkXf24248580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 18:28:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3F0AE04D;
        Tue,  8 Dec 2020 18:28:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1437FAE053;
        Tue,  8 Dec 2020 18:28:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 18:28:46 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [RFC PATCH 0/1] "Bad page state" while freeing gigantic pages
Date:   Tue,  8 Dec 2020 19:28:12 +0100
Message-Id: <20201208182813.66391-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=2 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following "Bad page state" occurs on s390 when freeing gigantic pages:

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

I bisected it to commit 1378a5ee451a ("mm: store compound_nr as well as
compound_order"), and it seems that the new compound_nr overlaying
page->mapping is not properly cleared, which then triggers the non-NULL
mapping warning.

This is because only the compound_order is cleared in
destroy_compound_gigantic_page(), and compound_nr is set to 1U << order == 1
for order 0 in set_compound_order(page, 0).

For some reason, I can not reproduce this on x86, but I do not see where
this could be an arch-sepcific issue. Still, I might be missing something,
and my proposed patch also looks a bit ugly (at least to me), hence this
RFC. Any comments?

BTW, for "normal sized" hugepages, this is not an issue, as page->mapping
seems to be cleared explicitly in this case, in free_tail_pages_check(),
but the freeing path for normal hugepages is quite different from that for
gigantic pages using free_contig_range(). So a "page[1].mapping = NULL"
might also be an option, instead of the "page[1].compound_nr = 0" in my
patch, but that looks even more ugly, since it would clear more than
needed.

Gerald Schaefer (1):
  mm/hugetlb: clear compound_nr before freeing gigantic pages

 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1

