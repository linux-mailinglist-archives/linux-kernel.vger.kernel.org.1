Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12882F89F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbhAPAcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:32:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbhAPAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:32:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0UOwt140194;
        Sat, 16 Jan 2021 00:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fLFZlJKB73ggWSUtIHsj4EWpsN6eIRM3PQlQM0oiwBE=;
 b=uQzAOlRvqJEN/qUSSvEFst96W0XlEHUsN/wem9tGYEbhxO5olxbhgm9Gcu+XcOUmyPIG
 /v4L9p8Z/t0459WQ4EjaG6ARag7aojg6eHTopeEp5kpKD14PQwjiKI5XazJUyz1uqU5b
 G5fWRuVp5/CNXSY/LHcfqXizIX25MrF8PV0AznhBcvcPm57qMrWAe+3TvS41V22Nd+Ay
 G3mJLBtEH06fIyurW0vzkmNT4g4XeFWRChSAzlKgrMlIXDXx/zuGv8wIz9lslhssayA9
 tJ74SDT7m4rtTYdJ+w2bX3/QzR01xVFgsjIZwWL3shsl+wbUC4g+JuM3QmoxhYxVB5t4 xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvkf5ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0V38T035166;
        Sat, 16 Jan 2021 00:31:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 363n8qs8r3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmXSGfa2ceDjuojeQ1un+xTnFO3ByZWiCsk6v7PGJfsfckgolMTeyr3WAqQtM6RatIRmMyId1LmZz8azhwUA5eNSc/KiZIF4ybi3nOyOR0OnA0FHCG9uilTYDMRLSlfT0SVReIZIsdNBaLEYIA5SP4uWSyzckoiUIZYMgawPLwjT5NgddJxwVjS5z6PHV81kSKsc6TQvAQQALSTgtdAG4Z/5VHV+M4dfgcenMHKrclY/J8+Zk/BMRaeYodOO7Dry3hHs68suqoErvNt4fWDN5PXR6xdvRPcbjHB+H42vVfUfrCKQ8C1p6I0+vUUxufHwruvMXJW1jxwnUAytrIuXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLFZlJKB73ggWSUtIHsj4EWpsN6eIRM3PQlQM0oiwBE=;
 b=CZ1+uDLw0FScOkRxlKE1+aDYMpm8rHHBxiIGChK3NnLXBLOlNCSGSaW46Bm1wDCpfp19HpwPkfEnCtqE7nYnCPDPfBqPciejaF/BGJtVhqY2TlZGJ37TZs7AVW+IqhhgQ9SGMn3vYphX2cNUBjA91rWXvhB8zUglxNS/5DU7JBpuSp+wH/FYMo5/WKPhMTHdS8pEjGr3D4JuwVojMQGUa9Rt6SPZYGNjyzCBNeKO2dTVJSBCryk1ZaoxpEUrePUWXW+oDtfURZJFqr2EiAXCUiSqLaGlQIWwmaw28X1T/anfgMhvzdi8RyGR8WxmWsTZO9NPzuepPA50Hx0YN8sB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLFZlJKB73ggWSUtIHsj4EWpsN6eIRM3PQlQM0oiwBE=;
 b=gF8Q7155zucrPUzbR7SefULVxOgUtgbM4ArbpABRzKhf+9jISVlBS0DujbyY5JOFF1Sc3ufkW4NmItY2eHSoIPslgIPHp8kBxQn8GPYcDAXQS4CEwmaci4/rox1cd+3YxpA/ehZSfvOr1eMlizbWnlB68RxnSpZyvQHBAy1UQUc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:31 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:31 +0000
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
Subject: [PATCH 4/5] hugetlb: convert PageHugeTemporary() to HP_Temporary flag
Date:   Fri, 15 Jan 2021 16:31:04 -0800
Message-Id: <20210116003105.182918-5-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642954ef-001d-4a3d-d2c5-08d8b9b61251
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44504628B4029DD5911CB39DE2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZNBgdkLhYbeFq5O3TAiG3SrO9SMF0EF3isYxTI8PhtwRgL9NEVxmxuMgtkha25vYTUgOOb+Pqqs6iQI1BZh1uIXYXQPQXZEOKqkxDrMYfKA5yVmDw6s2FZ5s/Fz1kpwK+TWX8vHyrc75ZPxJ+e5KwiBqJMXdd8Fr13w0E8ZSPE/jRvSHvyPNSFZDSp/vVfW2A4yX+mz68T+2/0ssjMfv9smC7zSd54ukqnUTlZ+kKZVsqn6nw4rpGK2z7C4wm1u9wBiQ1bwdQS6AcYyuInBK9v1aSSv/ZNGLymglIRV8wvBok9u0nvg5WvOM+18T5F6YzwDmtzEnzF4pOz8f0ga+i3YTGb51j47wP0Ty04tTpwJcc1ks78aEGppDd7haJuGY3A9Z5Vha+mkrtD0ZKF+bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(6666004)(86362001)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aXcq/MvvmSWgVL4slxHfUOJ98KLiqqAUythmDi55as3d4MLIHQUmZpmbyzd8?=
 =?us-ascii?Q?/YMPrq6Et/wasuWFlP+vjItDe+G/0MNZap5/Ae5QCUUKISCwht2je2/EgVlP?=
 =?us-ascii?Q?yf/QHReYPlmhFZHVZRo3WUvMhlJBC/GkETKlqUVoSkaD+J/haPU2ZFqdFa4p?=
 =?us-ascii?Q?pqnSD7fIVyX2zHNeQ/m5hYU3XoHq1WFcYaKiKjNrFRk8reQ+RVwMBKzguSLQ?=
 =?us-ascii?Q?YPD2/vL5Q9B9aRQl5Ca2lfJgQy0ECfQpsTXnE7V8l8LXfOK41inSVHb6Ge0J?=
 =?us-ascii?Q?IntOifiqburDo+Fi0/MtiQ9e5HN4SM+EfOk71JW10rWIb17ay6+YU86aqFeg?=
 =?us-ascii?Q?9DAwnp2GlZ6CBjAYtpox+Mn0FUFMyicDdSFTsnRXNMKCotRpXEBA1QPl/ABy?=
 =?us-ascii?Q?2CGe5PpZDYr9i8CUyzkx/eb/9gFE6iXdR+fo7PBZwgg/jUEedhLWiR8zyZi2?=
 =?us-ascii?Q?8IWmCO3IsHAGI50x3AjGfMksFdCq12+Kend2AIoKaIvjjuTtkPfikmH1rr0O?=
 =?us-ascii?Q?Z5AxQIPwmmC0LUX8tW/CxiEEDNuRhNGVeGy92uPmMrUrs+X6a3wIviijBr2M?=
 =?us-ascii?Q?dXm3zMK0G8i1M+T2aBK/3UnIOdm75+Sb6NhWmO+5HuyeP8VwHnxEpI8+B3L8?=
 =?us-ascii?Q?nLk4jNHjRX+HN+KJlragNW2fSKd1lWaZIwoR1EdGUHlni6LNbhJCNV4CYEaT?=
 =?us-ascii?Q?ycUOWevx0rncVf/q74VLNghprVWfABMlg7myIPZi53ijTdEIcyR5DXa6cfWP?=
 =?us-ascii?Q?KOiU88LUGa6YYJmealC5H9Id+klEYewXhAmaOeCENjx3jTo82G+yy87nFxyP?=
 =?us-ascii?Q?jvBGm+C0QOkvhai8sjfpZuUlkFC/nhQcMDLpApK3o3RAlG4t1nLTe0CM2EBT?=
 =?us-ascii?Q?cSAhZrt8HcNAb6cL54oRTQ7auvUY/dBUlZyCePh6K6YwQIrh5IpJddKnh+Ek?=
 =?us-ascii?Q?7Zoky2PnloP7mCLOwW/ZyFL8UEhZUlhQ3yxV9BDqZ5k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642954ef-001d-4a3d-d2c5-08d8b9b61251
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:31.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRV/jIxW8JJk1l+pIe6G+Bk0uL+0A7i138TTNYT9zGvpFfA8sfWcmld0MXCtlpq/wKIctJqOh6FW4QvbaD0E5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new hugetlb specific flag HP_Temporary flag to replace the
PageHugeTemporary() interfaces.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            | 36 +++++++-----------------------------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e7157cf9967f..166825c85875 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -483,10 +483,15 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
  * HP_Migratable - Set after a newly allocated page is added to the page
  *	cache and/or page tables.  Indicates the page is a candidate for
  *	migration.
+ * HP_Temporary - Set on a page that is temporarily allocated from the buddy
+ *	allocator.  Typically used for migration target pages when no pages
+ *	are available in the pool.  The hugetlb free page path will
+ *	immediately free pages with this flag set to the buddy allocator.
  */
 enum hugetlb_page_flags {
 	HP_Restore_Reserve = 0,
 	HP_Migratable,
+	HP_Temporary,
 };
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 31e896c70ba0..53e9168a97bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1353,28 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
 	return NULL;
 }
 
-/*
- * Internal hugetlb specific page flag. Do not use outside of the hugetlb
- * code
- */
-static inline bool PageHugeTemporary(struct page *page)
-{
-	if (!PageHuge(page))
-		return false;
-
-	return (unsigned long)page[2].mapping == -1U;
-}
-
-static inline void SetPageHugeTemporary(struct page *page)
-{
-	page[2].mapping = (void *)-1U;
-}
-
-static inline void ClearPageHugeTemporary(struct page *page)
-{
-	page[2].mapping = NULL;
-}
-
 static void __free_huge_page(struct page *page)
 {
 	/*
@@ -1422,9 +1400,9 @@ static void __free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (PageHugeTemporary(page)) {
+	if (hugetlb_test_page_flag(page, HP_Temporary)) {
 		list_del(&page->lru);
-		ClearPageHugeTemporary(page);
+		hugetlb_clear_page_flag(page, HP_Temporary);
 		update_and_free_page(h, page);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
@@ -1863,7 +1841,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * codeflow
 	 */
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetPageHugeTemporary(page);
+		hugetlb_set_page_flag(page, HP_Temporary);
 		spin_unlock(&hugetlb_lock);
 		put_page(page);
 		return NULL;
@@ -1894,7 +1872,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
 	 */
-	SetPageHugeTemporary(page);
+	hugetlb_set_page_flag(page, HP_Temporary);
 
 	return page;
 }
@@ -5608,12 +5586,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	 * here as well otherwise the global surplus count will not match
 	 * the per-node's.
 	 */
-	if (PageHugeTemporary(newpage)) {
+	if (hugetlb_test_page_flag(newpage, HP_Temporary)) {
 		int old_nid = page_to_nid(oldpage);
 		int new_nid = page_to_nid(newpage);
 
-		SetPageHugeTemporary(oldpage);
-		ClearPageHugeTemporary(newpage);
+		hugetlb_set_page_flag(oldpage, HP_Temporary);
+		hugetlb_clear_page_flag(newpage, HP_Temporary);
 
 		spin_lock(&hugetlb_lock);
 		if (h->surplus_huge_pages_node[old_nid]) {
-- 
2.29.2

