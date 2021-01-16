Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E142F89F7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbhAPAcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:32:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47792 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAPAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:32:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0TIwe139352;
        Sat, 16 Jan 2021 00:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=Pex/uPAMbaGLWr+GH0t7IsuQ8V0vZVhyQQ9TNY71Cgw=;
 b=YrZGAdpMpqYY2Q9wPrHZfIIV+kZv+kTUOtIuuiSanaOdOeXO7ycwgCXfrNwOdZ7Jk8iv
 SnsDw8YpJa/FbHAw9vxZvzqwmVPb0m/wlPoFuNaD6jTEAP+mKf9jPHnl28tqlfhG7zQP
 I3KEPN+fDgz9IWzgaLVX2qZZjE+SybQD0mrcU8DPT4Wh7i/aQRPAkF1Ja6B+qm7+qaqJ
 ESh+SYg3Gy/1pR5bFO+ZQQcikcAK4VDZHgQlkO49Qbvp+TsyhvS2IHoPz+DMV9jErKJQ
 qIqWvXtTsdGsn1Dw2ultAirz26UbM8sXx1Ug7wzTYJB1zLYAXe8D92O6uDXqjYg8iIMl 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvkf5yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0V38R035166;
        Sat, 16 Jan 2021 00:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 363n8qs8r3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+sbQs7lrnR6EVpWblXSLt6RWJg43m8HFWOZtFT0rN2q/HZuYgIfX+HIoGPQGvjAkuGJco0+a4BO4gHOuDq/+HWCDmD4BrDwDFkahzGPVLIlRfazd/EdJ5BPF9EFkrCFWj2gEBn3poeJols8Y7hRrgVDxJvNE3Sq9irHbblY8MJzNwZo28Se9JAVrqglisBx1SEB0TbMq1f+ImoiDa5JijYi6TeSXdO5oW1Yt6mvCiThv9lgBMQ5CFPY6e6FIusGusO7DCpReI8FLlrYxv0cMg6hAkhgR9tcjF1hSLomRtNETSfcVJYNFAES1e8B6k3XCqn7Iv2K6IMEMlpKmGQUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pex/uPAMbaGLWr+GH0t7IsuQ8V0vZVhyQQ9TNY71Cgw=;
 b=C5ypaY52CfR5KSyphW48AZvSshIl2jix+ilj682fF3HZPSmJjPrQuBUfOJNzhZ8vWotKpsYI/eiNGdsXJLgVzezt8485Sw5++p75v384htWelw9GPRPPDJfLQVmi97fHsG0OYx4aK2fqDE+xW5AuLrd+nNHtUMdqLs2EwdiLoOYRzIf5H9DdEMmr7xwKsjh097gv2uF8h/zOo661YjO0twfQJYprViBDsJoMsj0LEiONL6cxoUYApInUP/E1SDJ/srinnNnPT9fsgaNuT0lMO8ddS1+VyOICjgRm4QtRU5OzKrKyY3wKRE1SuwMGgLbQ5vL+C/sFBPVG2m7lNq4e3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pex/uPAMbaGLWr+GH0t7IsuQ8V0vZVhyQQ9TNY71Cgw=;
 b=MRXq34/cYm1KK/eiCFFB5uHstMbtuUquA+2XnlfhDW2rB9pAPXkZQUTSIhklaQAzEvkZ3scvBLIoYzRflKc2XvfEmOfYKjVCuTZDjdHDm9CpljoEWBgSCAilpjXaUs2vMq/PWmqEM4Ets5EdQbueL0ZRhmuUQDdIehFFpVfhyaM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:30 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:30 +0000
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
Subject: [PATCH 3/5] hugetlb: only set HP_Migratable for migratable hstates
Date:   Fri, 15 Jan 2021 16:31:03 -0800
Message-Id: <20210116003105.182918-4-mike.kravetz@oracle.com>
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
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 441bc66f-792e-450c-a244-08d8b9b61181
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB445095EC3D21F355CFE51B77E2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW/PymAOwrWk4F3wHOMuu3ZmewO9tmYTZLVN8TqeRrES1skeJGMM4ka0fpw1iLwfzbJsvIor5JeTlOK2MO3yMc17ZtyQLHNXcHwVNVr4dJfDiGiZlGgXrwuQoZ5VixBaaak4Nb2byy6LTt6bgSIKEkPiev/eHBkNv5eS4LV6lEohVzZp1jpm2Mi3KWbNg4S6VxhGiVx1tLC7bGbTtCuYhq80eu5TeYcHtmDxF7W54qeTnkLvcT4cxdFzFSeEdJgHoUHtXRFXBOq7b+fG5UdUF6BdKlGVzCb0SSg2LhrX/4UA2+BljI75gUSYLNgkhQv9ubWfAf0QRMdHmAwjuB5GDC05HfrFQDe6/Sj0zB1etmm72AxrpqztU2NYi1q9gI+v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(6666004)(86362001)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7x891Zl9Gv1pWtI17FlfCTcMGR1q+q7doHaB+f1fLZNyqLSxQrHaHY7BzJX+?=
 =?us-ascii?Q?lcM4HYhBLB2qoAbC3WyhTWKdLD8ehFKfOpMj1UN1TqVgmB3ZyFO2EqqiWq+/?=
 =?us-ascii?Q?jxIuyB0uQF3m22OwRCFwSaiIG7Rn/rFHN1FAY0kFu4d9pMzuY+mG+DXR6I64?=
 =?us-ascii?Q?msKPBX62hR3J8B1RqFiKvCyTmAYjUb+3uM/+Rv8BBnwmYSC/FtD9/RTr2C+9?=
 =?us-ascii?Q?I4glWzG/ogVeL2qZVK3f95DWe8BSJqCLo6yQSa4T07o0NlS3KH4etpwtfYl5?=
 =?us-ascii?Q?9HQdKVPYm8qpNDmARbtgAfPL9iy2b9054ZFhxxekvXd2+utXbRblCc5IYLfE?=
 =?us-ascii?Q?LxDf+mdo3HRJeM/1gMj46SNzn+c0nU75NbFMUmivcTrXJsrT47ikIgXGtV4O?=
 =?us-ascii?Q?iIVrkxsGIbuCiuDBKvAkW1C+whdl5gCSlpSd4ieaCUefdkaQptrRi19tPlS9?=
 =?us-ascii?Q?y7liDf51AtMuMKcboHQYVDAG0/U2ikVZ7ugGaoP+2YovTfHJ5fOMXhAPH5cc?=
 =?us-ascii?Q?b1ct8VDK5nkBdk1HwY7dSCFtBPM4HJm/o+mTIQRtjZ3HVkPzkI3LbXOZBIos?=
 =?us-ascii?Q?m5tgZDk/tdTv/ZLT1Q4kFC8q6NokPwGFNNRE209FiBkGy2KIL5wW3WkN6vxK?=
 =?us-ascii?Q?fHOKB6Q1spdwLE2TM9Fdv0rDrviv30BndcwpHTHDe7tLnXWidvfN8SfGSqLE?=
 =?us-ascii?Q?ub3WHzrnSjnHeSqIZm+kLbmUdcGqPy+okEN6tlrxGbhKzW+Abkm5CTYn3q3L?=
 =?us-ascii?Q?N04Y6TlVNZOmq3Pupfdml+NWAZAh61bQUx3pW2D/T71QJ6sn0PBxCKQMxvyD?=
 =?us-ascii?Q?PEPDc1NGtPZZCSXLS0tlq3o+WWejzLPm37b0ZwCWUBLqRMV2DAsyGOjfEjJN?=
 =?us-ascii?Q?11AV8xJBvipabmOTy4f1MuFfhynynmWZyARArlwfvVchFoJAS7n4ntf/UMYz?=
 =?us-ascii?Q?xwsnXKsohWdx5B+Orw38dEFDqU6aOkjuLT6TFp4XSh4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441bc66f-792e-450c-a244-08d8b9b61181
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:30.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smAfUlJDqVrozUXKW0uCUmQou099ZEB62dl6+yGDHdLICO+ScAREL+kWscVpPe0D2aNvqJ8fXvoSjPTC2t/86w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=633 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=683 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP_Migratable flag indicates a page is a candidate for migration.
Only set the flag if the page's hstate supports migration.  This allows
the migration paths to detect non-migratable pages earlier.  The check
in unmap_and_move_huge_page for migration support can be removed as it
is no longer necessary.  If migration is not supported for the hstate,
HP_Migratable will not be set, the page will not be isolated and no
attempt will be made to migrate.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  2 +-
 include/linux/hugetlb.h |  9 +++++++++
 mm/hugetlb.c            |  8 ++++----
 mm/migrate.c            | 12 ------------
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 89bc9062b4f6..14d77d01e38d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		hugetlb_set_page_flag(page, HP_Migratable);
+		hugetlb_set_HP_Migratable(page);
 		/*
 		 * unlock_page because locked by add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 353d81913cc7..e7157cf9967f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -716,6 +716,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
 	return arch_hugetlb_migration_supported(h);
 }
 
+/*
+ * Only set flag if hstate supports migration
+ */
+static inline void hugetlb_set_HP_Migratable(struct page *page)
+{
+	if (hugepage_migration_supported(page_hstate(page)))
+		hugetlb_set_page_flag(page, HP_Migratable);
+}
+
 /*
  * Movability check is different as compared to migration check.
  * It determines whether or not a huge page should be placed on
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c43cebf2f278..31e896c70ba0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4197,7 +4197,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
-		hugetlb_set_page_flag(new_page, HP_Migratable);
+		hugetlb_set_HP_Migratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
 	}
@@ -4439,7 +4439,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * been isolated for migration.
 	 */
 	if (new_page)
-		hugetlb_set_page_flag(page, HP_Migratable);
+		hugetlb_set_HP_Migratable(page);
 
 	unlock_page(page);
 out:
@@ -4750,7 +4750,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
 
 	spin_unlock(ptl);
-	hugetlb_set_page_flag(page, HP_Migratable);
+	hugetlb_set_HP_Migratable(page);
 	if (vm_shared)
 		unlock_page(page);
 	ret = 0;
@@ -5585,7 +5585,7 @@ void putback_active_hugepage(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 	spin_lock(&hugetlb_lock);
-	hugetlb_set_page_flag(page, HP_Migratable);
+	hugetlb_set_HP_Migratable(page);
 	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
 	spin_unlock(&hugetlb_lock);
 	put_page(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 0339f3874d7c..296d61613abc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1272,18 +1272,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 
-	/*
-	 * Migratability of hugepages depends on architectures and their size.
-	 * This check is necessary because some callers of hugepage migration
-	 * like soft offline and memory hotremove don't walk through page
-	 * tables or check whether the hugepage is pmd-based or not before
-	 * kicking migration.
-	 */
-	if (!hugepage_migration_supported(page_hstate(hpage))) {
-		list_move_tail(&hpage->lru, ret);
-		return -ENOSYS;
-	}
-
 	if (page_count(hpage) == 1) {
 		/* page was freed from under us. So we are done. */
 		putback_active_hugepage(hpage);
-- 
2.29.2

