Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1452F89F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbhAPAcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:32:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35376 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbhAPAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:32:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0UnKL160205;
        Sat, 16 Jan 2021 00:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=U9MCdQB1uUR6Oa5upkJkKkOf9bLofSyZk6D883uy1PM=;
 b=I10kiruZ9yE2nyOs28CYurBJInIHNB2ZoHSS8HdIyPoauXkw3w8UFljk/Kgr9mtdRIJ3
 7i8PJMwrRvXoxRWFtpeIAsWavnnDHaOMP16adxu3TFlUAI8b277v21Hv1CA/qhSGzma8
 JK7veEiVtaMsFSPZmppSZ07GV3mwBXjcLmiR51w422wzreL/GqTq6vA5iQsa96oamLS7
 rc8jqY75WeKpaCnJOaSzoBXzxzjvvGyu4JcsIjXAMyOUp4DMK4WuLLilG+yxZaasd1CS
 G1P1npnunGN0+N+j5ukDoSFgaVYbMgsCHZH228dx4iqk48col4jproDpb2x5yZkBtyGm 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 363nna801w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0V38U035166;
        Sat, 16 Jan 2021 00:31:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 363n8qs8r3-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkeXN4QWFdbq5nW+YNHH8upktAWMw4fRS0N9Z/+OZugnV6PcVyQMEXddouNq7xo2r6wB3QuUN7K69TiSKAS4C4PDBr4oPUR+rncUJear/loGmolzDWnbrxiK0hhEeO80uAAKjsivZ74D6GhyHTQLspwZGuwbAW23Zzgl0Y7wWV526rqx0xs04Btuwf4PaK5Roh5dH5bmu6+PQ8Yfjxmvl65Kz91nlJ++J5TXZYnmLbA0F/4jCzZcjZe+FIVrNgP7GU6KxgJyEL0xfvRMwLeGTo82vQm7+tvmQVXNtG8dv/zRua7vO2gyAOXen6CAYzjt8KVzF07BM5E1hKfjZKz70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9MCdQB1uUR6Oa5upkJkKkOf9bLofSyZk6D883uy1PM=;
 b=G8oivlko+Ot5wQ+xqOfcYtQlrO/npOaxYBL56Cr4XgdfP83KMeWB44Ci8inivy9D5IVQwP2u3t6rfP/43XIjJJWWvogi9F3zrcygP0KsBG1OHLjcsUahwHACa1qwA59tpksqqwiOTbfbLib8mwa/QaVKR4OLHxRgZteszM31R1+Nac+pWcoRoMJ0m6JHJ+GoC9B0avD4Cd81k3otr9vbEBTmjVohS7iYS1TdABfLuNPMNfKbebL8bvWjoZe/d78z37WUIKTgbzaI6AyQp7brvBiQ2WHit+kfMyrvRT2XCfL5rFdzB3/uD9puDKLtCYZffelEskAacHM+gOV/pCRbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9MCdQB1uUR6Oa5upkJkKkOf9bLofSyZk6D883uy1PM=;
 b=M1nF9CzCQ/ylR5LXd2S+GfL+kJrwfbFuyr4jWB+LvDS4ymCmrcJpvQ3MRfaTAe0hIpZyZg5FT6KT7eoeHp1IqaM6ZP3k0QSCMgp+SHfvawGUagMCRp/exSmqIc9AqbLO54Muzs2ldrIxyRSbQb516wnn9fCuSJ/Kr+DyiSdxz2g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:33 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:33 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 5/5] hugetlb: convert PageHugeFreed to HP_Freed flag
Date:   Fri, 15 Jan 2021 16:31:05 -0800
Message-Id: <20210116003105.182918-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116003105.182918-1-mike.kravetz@oracle.com>
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:101:1f::28) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4212882-aafc-4aa8-4fa4-08d8b9b6134f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4450EA28F1FA38A087C413B9E2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBE9pFVoKiSD1osLNgJLqDvSzcZ+RnKbz7uHH6H0iydK00UbUPMGV+oUFEeffjjcbpNbQUpsb/ClR5KcdHH0qA/uyKLkYBZTL/skRu1XKkfxcEb7l1pFdaaKv8JGRd4L+x7u5Gs5cgsg+9WE0WXsHnlNbz1Bgvs1UAsZbccnKc3zkVYIaaLoY7wpYlD+CnzXs6vkkeNFHKnbu4KZOMabQq2lWV2Y8zyuYRvXUENnXd4JTzUOsbSt6Aa1CZXs+Wmq112uZpzUXXX9dCGCrmvUxM9hOriVDygDJwIZv1RhlSdEgvC4X+YjhmW6vJmJi1IpXGS31UbJdJerXJDld3ydiOh8Yx4cbLUd0jE5lpeZy/RJz/XGelCHEYAJDoLPZQLCPj9RcSshkmboU+DJ0D72EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(6666004)(86362001)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u3BW92mD/G0zI/AcRzKTiHGPFE0clgCCmUJ6S77qejCMsQS9H1EKdq/+8C4H?=
 =?us-ascii?Q?hDj4aXP/SAVSPMlWNqlRucGx2hcP+TJ2gLSgMzbsBtNs2TtC4DDo6lEv9Z5k?=
 =?us-ascii?Q?N7cn0bHVKermYb+S7m3BwroVkpY+prEkCVlCFwTm8JYqrnCDoN+rt0+OSNM1?=
 =?us-ascii?Q?/sW+J7SQ7h3VhWBBfGgTfyfwQEO6ai8Nx4z+nr7NNfnHCqoxwyiwGmEVe79W?=
 =?us-ascii?Q?sBZzhf7JQY30r80ZxpY5k7C5ciPI9ztf777Gb/TkWsJvnOFE/e5uBnAAQeJO?=
 =?us-ascii?Q?fJxe90L72mCJxRLlp8d1668YhAxp0GnS0IslbC5ri1+4T92bxoHkxD6BzUr2?=
 =?us-ascii?Q?kwoMehoJFWKAevyCQya5iW1SnEMUIePn/gAwwe2KHHTVzwy9O1z042Bh0COD?=
 =?us-ascii?Q?AMhMCYdjdowETG0sZLTfcJCixTCHtgzlFpBDEZ/zk5JcVP6r8B62v96YW5BC?=
 =?us-ascii?Q?+k0ADCQzzJadx995cXvA/QGwOq4NfNtHT8JMdbyJCvv0GnmgtMDedeVlL+dp?=
 =?us-ascii?Q?ceJV9IoGVFlmd0awibsS8sxk/e3rjWece9pJRbrUr4rTssCFyqacDHPVV86H?=
 =?us-ascii?Q?6THYTEHkvyGDha/f8IAcb5GJdyfG/CaqSsmrfu/+U/LQ3l9JTNQ7OguVYVJr?=
 =?us-ascii?Q?VhIiSfXWL7bTewrYmvFwpUVPfXLory4VmiDLs7IlWUNxUk9adxAJTME3C7wM?=
 =?us-ascii?Q?13JIK8tKiobi5rA06PqsT9EYnOS1Cvajos3+QGTdWz83wSh+Uw0L/I4Q81Ii?=
 =?us-ascii?Q?+xodxd4FXOmtlcV+xxoT7Uc/fPQ7gEBtw6N/TbEwcl9wEUT8fCRuJbj91n3c?=
 =?us-ascii?Q?3DsXL9W6B0knNfDDJjY4iGzsHIXfo0JF+KWySY3J7NaWuWra/weyzLZjZgCA?=
 =?us-ascii?Q?/78w6Ql39n9zLKMMgZtGA3nJZvi4iQWVZsjhmeEEQZnm0jpPzy248WLFcquW?=
 =?us-ascii?Q?apb16F27uTsJWneIxepZgtfVph6745RQ85rl20OnKUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4212882-aafc-4aa8-4fa4-08d8b9b6134f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:33.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX2KMIusMfvIifzJkBPWplUPBSBqycREPfkQh050TYlutt8gw5zJnyb2oIwTRyjMGAxVR6kizUIBdzss1AnebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hugetlb specific flag HP_Freed flag to replace the
PageHugeFreed interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 23 ++++-------------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 166825c85875..5c99969fbbd6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -487,11 +487,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  *	allocator.  Typically used for migration target pages when no pages
  *	are available in the pool.  The hugetlb free page path will
  *	immediately free pages with this flag set to the buddy allocator.
+ * HP_Freed - Set when page is on the free lists.
  */
 enum hugetlb_page_flags {
 	HP_Restore_Reserve = 0,
 	HP_Migratable,
 	HP_Temporary,
+	HP_Freed,
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 53e9168a97bd..073137b32657 100644
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
+	hugetlb_set_page_flag(page, HP_Freed);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1060,7 +1045,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
-		ClearPageHugeFreed(page);
+		hugetlb_clear_page_flag(page, HP_Freed);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		return page;
@@ -1474,7 +1459,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	spin_lock(&hugetlb_lock);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
-	ClearPageHugeFreed(page);
+	hugetlb_clear_page_flag(page, HP_Freed);
 	spin_unlock(&hugetlb_lock);
 }
 
@@ -1747,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!PageHugeFreed(head))) {
+		if (unlikely(!hugetlb_test_page_flag(head, HP_Freed))) {
 			rc = -EAGAIN;
 			goto out;
 		}
-- 
2.29.2

