Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815F300FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbhAVW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:26:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbhAVTyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:54:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJoOWA060610;
        Fri, 22 Jan 2021 19:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=hL8wQ67fCnGWMS7fCZuNZYpKCyQILeittN5nqzpGUbU=;
 b=EA7WToie8IRtc+Yb+WUN+/SCGHrmvrJKR2z4EYAjjZ5TD2Gf8olNrxH4GzKFNtv82rQj
 PiIhIXT4QxTAHeiaU6KnnvkRKO3AVLrzMlj102pis+/EupPxTGVMoGu2PNMkbBbWqOcq
 tY2tVdms8k3BzFIgMmxrjVFboTeAuy6dfqn3Cjh7r1R05DFauYrieyff93XbICqoPJa3
 OvVjS7PklcpvzJw1eEXvdlDT6Jw5VvIOl7wiqZXkrv8HmNLXBI992TL4c3bEeniB3hXA
 r0/bQb9HeEFji80KoKoCo2vOqIz+vJLvfBfWkFOgiQ2kbYhrTMWG8mwT9YcwauPhJk0h ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3668qn5ufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJnq61074517;
        Fri, 22 Jan 2021 19:53:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3668rhd7un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwqOg0eiV95ZvUfUYXmSMV2pKC5iNKAMbaFaLt+OBZeLzbqd/W0G72UCJmq2SLT3tgi/Apr8QCfNWzRo5CYTAVpEdKp93Ug9FMqTioKGSISwcyfRHBjku7LUO8RoZ5c9FFHxiGma7SvNSSmO06iDksq1VZeE/oKtdN2tzPK9+s8kUiTZOers++W0GQDsZ6rWTetKX9ZxHTKVMeMQznIE6zbpEbsKsKzawwUusBCBFY3Kw9AAftsmgYYLE73I4KkXZot9WtlXExrXFa6mQb+rRKXRjPZEtOQTVp660bgp5iqexSTKTLT6kXyMrRTn2rn/Nrh6sxWmCfpr2GZl1lAR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL8wQ67fCnGWMS7fCZuNZYpKCyQILeittN5nqzpGUbU=;
 b=CGwrD5EI2QbtYTKDCq+aNt+R4juZDFxmWyjwLumwlj4BPsbrR+ds0sY3U+L9+1dO8WCQNRbzWxcjbuiOH26Jlp1775OhwGp4zCx4p+APOk5KeCfUsBPXVlXSekZSTpRI8mZTqkZI9w34T+3uHZP/ZgjeYN3Y0Yydn4VryDFOSP77Wt034lUz3h7xFNS6QK/oSoFeoQpULCSxe+WeIlXq91CcPyct3XeZvEU66xSDZccdpJmzRe4iwvLWRmT1bdxTjIlCuLITpX3GCwOewzfS7s7R/h9AGzAfhBl/2LkNE5GhuT+JOqiuuv7NmwkHLpx70y9zElAgnUY9oAyEhT6Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL8wQ67fCnGWMS7fCZuNZYpKCyQILeittN5nqzpGUbU=;
 b=N8rjaKrU0dCEaOH2OBCnMWKZiWlffRVN8cXmy1uGgAf9vFZb9N15IZwiHklduk3sO30VGYn2WeGmJ6fIHscp1Bqm2lq4VQkrrgDfhMUOZGiAvc+lSDlkel2FvU/p4KfY8q4I3ZKLjmNEOgECTvlwcaERJVmKdp5U3+5hhoh079w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:15 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:15 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 5/5] hugetlb: convert PageHugeFreed to HPageFreed flag
Date:   Fri, 22 Jan 2021 11:52:31 -0800
Message-Id: <20210122195231.324857-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122195231.324857-1-mike.kravetz@oracle.com>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:300:94::33) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c1e2b78-c7ce-4636-aaa1-08d8bf0f5b45
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4723BA2F048736FA060696E2E2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfu0ZPSamDDd/8ke0V5poSM6wuvn60AkrC1ukguhjegGjpoZjiioyQ6UFOYCwZIX7105v+a14j6CkKbtMWFNMhJw/FcOMiCKqjDRq3H66VqBxEoPoT14dXhbCsX0EeYEdL/gJFsRucY7b+tr/SCXEheeAo5u8BW1/IF/oKBckO57hXWg01py4XqezBzIM7akGapzs/OROjkCLsO5ThrbTBr6Us3yOInOe6nO5N9C58kvn/m6aB5xaBku9KpQZZid9ybsNf0aCIadS3w0cPpbnsa1ZjMXK/2CK6K552kzT9qrfraRFFPFRTnZREo/FY244yq3F7q/BsFcmjTy9tFaL99tgBbcn3y7oLRa9wX/bZJDdiQuk7MUneN+fVHk1yBiAgpY/Q+4djpucLorInGU8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bEzzO8RsFlB5Yw/3S/kxgT0xPbVTlu8WJpqnURmWFIoyks/mcfVV7nd5IkpQ?=
 =?us-ascii?Q?EjaR4+cd5Upfe8i42k4akMJF51jxKXgMfQiNSziVTIILhM0QW1uOf6ryC4mj?=
 =?us-ascii?Q?pi1Wq7QSUW5bLDZvWaB9BsfLoJ6qe3cWGNqBHTDvFo+TP9p6jAsHPWXXTtob?=
 =?us-ascii?Q?5bNvyfwZJ2Vrgs60XG/B/DfOjOWRF60Dg7lhCYF85uohi2AImuiy8CzafCwS?=
 =?us-ascii?Q?LfCcB98JDsXreyFe0vYp+0KUsRkI3VXodFZvGNL9poXTXto86RsNIWLzQ9Ap?=
 =?us-ascii?Q?EWNzOtbeNNDFVvMl6h03a62I02Xg2EMR+AVG66HeWrUB75kGhw0GfOVOOnv5?=
 =?us-ascii?Q?xf+V3ckLJdpD8hGJ0QNkGXcPeS0TuaOyoFtixekL/dzNDbkkgfba4AY/UNom?=
 =?us-ascii?Q?4+oacAsMLrzubAXbLkB+04A8tEZ3m1QuAOcO26hPOMq4oFMMk2C/ahXyuFtr?=
 =?us-ascii?Q?uTJ5NOBtPgvyNG0Ucn0EGVFHzzgTtAtrc4CYNRVGZ6hPq+WT7oXYej45uV7Z?=
 =?us-ascii?Q?E0CPR5xRF8SIj5PWd0P5tye2EEJvCqueyoOu7Cz0x2Qa7ZEFaHWVun/1b49A?=
 =?us-ascii?Q?3BZTqrAV9zva+0JHnZDEpwMxEzUzod/aakXmZwTcwXEWZnaNm89BtYPVTIQh?=
 =?us-ascii?Q?EKJv4W+55z2APgq5Vudwy84WpGPU7fRu6skZF6fuQM/3druB/mzJaxVwd1LW?=
 =?us-ascii?Q?EFJUyxxL+FfFJoQRM1VR75GwfMbjI4OO+GlXKMCIaoiDrKadcl+IOpc4CgJq?=
 =?us-ascii?Q?xfAC0iXACLBzi91nDjy9J4QgK5ZSivBP14xiuEthOTw/s3nQgARmc6qhlNOL?=
 =?us-ascii?Q?fzRoMgC1HYquVgiOVGz56TrB3ktGU2qHa3z6uYygnZ2Zcl9OZUISvmameb/Y?=
 =?us-ascii?Q?gw1DaSg1P1wGiix3+WZJUpaAvzcxGlY8v7QNyMk5HmqWV35ALmZVPTKRlcom?=
 =?us-ascii?Q?K+PfMhzHiALKoGGGCL0zKFlU1gU3bUPqJLp23I+UbgYDjmMUgyApWuBuLtSz?=
 =?us-ascii?Q?ix2XCGjsBDVko/ArxF9Xj2gnxNPp4fqKrlFP0mlEdN7lB6naVb0m0Qca+GCp?=
 =?us-ascii?Q?RzonEYA2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1e2b78-c7ce-4636-aaa1-08d8bf0f5b45
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:15.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0Zvp3Swr1TOOj3Qu//TM/w462swGfncoZleSLJrkR3NfMnAoAC5+W6XMON2TCcUXgmkxZ87Eli1vtKkm3IW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hugetlb specific HPageFreed flag to replace the
PageHugeFreed interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 23 ++++-------------------
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3c86c3a0e144..f09085c0afea 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -487,11 +487,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	allocator.  Typically used for migration target pages when no pages
  *	are available in the pool.  The hugetlb free page path will
  *	immediately free pages with this flag set to the buddy allocator.
+ * HPG_freed - Set when page is on the free lists.
  */
 enum hugetlb_page_flags {
 	HPG_restore_reserve = 0,
 	HPG_migratable,
 	HPG_temporary,
+	HPG_freed,
 	__NR_HPAGEFLAGS,
 };
 
@@ -536,6 +538,7 @@ static inline void ClearHPage##uname(struct page *page)		\
 HPAGEFLAG(RestoreReserve, restore_reserve)
 HPAGEFLAG(Migratable, migratable)
 HPAGEFLAG(Temporary, temporary)
+HPAGEFLAG(Freed, freed)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 70ffa1027988..c1f283cee0a9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -79,21 +79,6 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
-static inline bool PageHugeFreed(struct page *head)
-{
-	return page_private(head + 4) == -1UL;
-}
-
-static inline void SetPageHugeFreed(struct page *head)
-{
-	set_page_private(head + 4, -1UL);
-}
-
-static inline void ClearPageHugeFreed(struct page *head)
-{
-	set_page_private(head + 4, 0);
-}
-
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
@@ -1043,7 +1028,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 	list_move(&page->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetPageHugeFreed(page);
+	SetHPageFreed(page);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1060,7 +1045,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
-		ClearPageHugeFreed(page);
+		ClearHPageFreed(page);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		return page;
@@ -1474,7 +1459,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	ClearPageHugeFreed(page);
+	ClearHPageFreed(page);
 	spin_unlock(&hugetlb_lock);
 }
 
@@ -1747,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head))) {
+		if (unlikely(!HPageFreed(head))) {
 			spin_unlock(&hugetlb_lock);
 			cond_resched();
 
-- 
2.29.2

