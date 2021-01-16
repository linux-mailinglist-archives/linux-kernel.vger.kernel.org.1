Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E392F89FB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbhAPAfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:35:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbhAPAfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:35:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0Tpno159448;
        Sat, 16 Jan 2021 00:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=1VSral5slTfnXXmuTxnnikW0TTbs3czo2gmUidK7An0=;
 b=jAGS5vZZJCMekYg1wvD+g9+dd9rbkCZGGca3F1AuG1zXXueNbLj214rj3kD9/uCLg5NI
 LwGHqpn4c+/OSezs3vMFi0XHEF+s8X0Qeq42kGCp8F2FW1hSzBpZrylL/e4Oe9nSzD5u
 9+Ii0Qer+Co/9lRc2LYtJxhwB1ViD43EeNKQe7piitGPunk4lowX8P4Azt1/lhEllrAb
 1qzMyAkXL4O1q9nu9doYaLX/0ECKrZ6sPz//nIyIoVLejGsBhB22ZaHsB0ME9Rdbxi0S
 i+zaSaZKWmPirhpWyNbewQI/PwT0aL5kJRwuMfq+4bUss1i3ko9E/RFg0zlS3bR04kh2 fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 363nna806q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:34:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10G0WliO099849;
        Sat, 16 Jan 2021 00:34:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 360kf3yqbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jan 2021 00:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyXPwbrOAzCZglzRvts8GOrH+XFAS/CaiftEocLhb6KLBa2zTlI+s+Zih850In8IKFxFAnaRfZqvqCq64GwSpaLGIekQjIgLD9DrmKbLEv6FjPVRP3UB3nKYqyiU0oEQjcA3pOnOCAdIY4NBhM6IB8KIvoLcp17BtAYRxaW3pjxRyC0A9AaMnXezHgdgxkHZOAlxUVF49OMTmNOGZd8QebYrB0lA/KbrFbje6p9ea/0dawxqIsqlT1xMpvqp0uRW+ig5KevlcqAUi+KAC+W3+0NSHwhREfo13WqxkOy2/WkLerFhwCV+qIbV/hLKuMVREzSU0zslog9vGxD4ig4K+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VSral5slTfnXXmuTxnnikW0TTbs3czo2gmUidK7An0=;
 b=Hre+GfIw42bZhcxKgn08NNO6cavrNmjerH8ug1jzLyOGxJZGwQd5mo7QZx5Vh2B85zYvXBpD/76lCbQiuTgg1zQE2SCJv4C8Ljez9T76uAjTL7Bl322ArzzhhUFornf1h0MA8hPBS/CQOK6S8iF1bR81szCycIDfiIqau8XWhHrjm41Iz5MvEBsVEyBv7fsSXb4b0N23vldbg7esQ7UT/Bor5DpgWUDFvFSgHegfkZOmkQB+24aT1VbyNdv3dLOxfA9TlBn0n8IliEBFGRKJbU5izN5ind0uf2IGx7LN8efxDxGaEQ/Sd17TwCNqaqLlk5dwTJTzChgi3YrKaWkeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VSral5slTfnXXmuTxnnikW0TTbs3czo2gmUidK7An0=;
 b=hT2QW+OSuN5ubR3HulVKqIA0xw6ASIp9+wQjLxBZluWDGSHXsW2a0BNCyL4FoPiegTUuo0P9eHyNMRIbBWAcnxg2psd9zByth26lKJmpc0AhMtvHzXwZ7zbj8Q11+p0PDiy5RHctPgpvKn6EJa2kgFIh2lNE9heEa2Y+gdqxA9g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sat, 16 Jan
 2021 00:31:20 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.012; Sat, 16 Jan 2021
 00:31:19 +0000
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
Subject: [PATCH 0/5] create hugetlb flags to consolidate state
Date:   Fri, 15 Jan 2021 16:31:00 -0800
Message-Id: <20210116003105.182918-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:101:1f::28) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0060.namprd15.prod.outlook.com (2603:10b6:101:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Sat, 16 Jan 2021 00:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16b1fa13-7e58-4833-872a-08d8b9b60aeb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4450B9B8960AC0F8F1C80741E2A60@CO1PR10MB4450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa3yJvHtjDXXJtOzTjPFyOW5P7jYhvztY6Ds5hR24fTIIGNe9PR+XiOG14CfPfVxADK9ZP2LERdi63u5ioZSF7mVylo/ECjfe0jjLajPpl9rc+l3MEos4CCN5O+mjJpnpNqw15Sy7rMMyTNqSgySpsl42iK6zMm1cFKqEqJeI4eUmqKjwoV8xJKxo8YcKPh+QkTREA+BlPwYOmmXmMjJ8S78cj3MUTUnY10tn4IQKmsFaZL4FQittbgO5PNarldlrggFUGmOaMnvThhAfjXLed0O/KFoyeAp6tmi2oRrGj7qYWeO24R1X0W+NB+d0K6KZIM0qbqjchFfjKaoUW+BIBhX7qwQxtxQB8fuQf7KVtHjtfqv5g2+R1csWxuMX5eo67oJ5hovo86yYfVY+yw1CpyiPSCSpFl0DBIAtexv7FHFqDeil0gRjm5+uwXBAesXcWFtddEkV+2lQ7ytZ5TBmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(6486002)(478600001)(1076003)(6666004)(86362001)(966005)(36756003)(2906002)(44832011)(316002)(5660300002)(956004)(8676002)(107886003)(16526019)(26005)(52116002)(4326008)(54906003)(8936002)(66946007)(66556008)(66476007)(2616005)(186003)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kgD3OB00sdO8fJ2l6hcY0s7jzD5e5R8RnuOxcSAO6Nrn3MM69meYC+lgpbEC?=
 =?us-ascii?Q?Y38pLmbaq2/EVG9et8KuewHTgsf9NrwRmNRm2m4NidhiRlfl9ThUTQrzQAWP?=
 =?us-ascii?Q?WKLJCEPZxQi9eS0L3BxXtQp0sV8DR05XIiJkbL50bOt6t+zs5Lq4AGyQ85MW?=
 =?us-ascii?Q?L8ZRjZXpy/RZvgyBGUSZhFT7mqPusdSXL6os+5mdJ+kWUjQhIOB5l2SNuOu+?=
 =?us-ascii?Q?vr/cARimwpiS63f3u0rcl8o9kyNVkga20WX4HuSRrYrmou58Dt9eiqLw4udF?=
 =?us-ascii?Q?4J0lICQQaUmLwnM/56LftyNp4s1rDFodcvLU/CGhHC7jRAhXAQ3o3bfsMYf/?=
 =?us-ascii?Q?20LjyjyrbJ48IjZhbF6GbauKJZP0uoCn/k4MpGwRmG0nemFBHXhQYz1LD/G1?=
 =?us-ascii?Q?CxfNsm4qCJqiskJa2RMTzKIyHI3A00i490plnzdqaqRAhuQf8JX/ek6m+/dZ?=
 =?us-ascii?Q?11OCZN2yJ31Owh++/l3Dmh2OCUVxfERi6LeWoQ3CWSobKzOmwiDmYUYUCFCo?=
 =?us-ascii?Q?Wzg6uP/OoVqui5DVMtIDuW/RNhy1V8ghPk/RFrZsYwOSREXH8KoVCaPCbTJT?=
 =?us-ascii?Q?6wEUZa+hlp18BFGSc6XkKY7mwGclDomb8Fk/YoN2ZpWfvRNbs7ljiOutoO43?=
 =?us-ascii?Q?in9k5kU7vLC//zyfpf3/CHq+fqc/QWM3qzklcF62t/Dk7nE63G/LC15yyLIn?=
 =?us-ascii?Q?IPcDoN8Papbz9sEXCGe91KamcEo+xwGBFeqozmChe8MEoHaCujyZCVKSHv8s?=
 =?us-ascii?Q?jq360Px8pZroXbrNJTVYamRvpLIgLbnW3Y01ENejxD7FoJ3gPNcOnfnn8Tge?=
 =?us-ascii?Q?KPt3hdD9dKmRirNMdWXRlPVaLhVMLaU7mAxJqbXwIfBLKTw0yNthB8U2rwyE?=
 =?us-ascii?Q?QHKrOxzv/G9nIfmeVGBEK2x3Yc7h28su7kqNTD8Ka+QFLzv6OyNdclJYhjtp?=
 =?us-ascii?Q?DQ6vogkDuGLM1meiWjHk3eFbV4nXlFihC1GUy6AHhRk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b1fa13-7e58-4833-872a-08d8b9b60aeb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 00:31:19.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EttWk788AePFSNdct/JbWJWljQGerL2EOu7FRhlUSZPWCFJbLOjEzVVKpQ3Bt3W2t+7sObIOx/8lc+JpphFexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=504 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9865 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=663 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101160002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing a series of hugetlb fixes in [1], it became evident
that the hugetlb specific page state information is stored in a somewhat
haphazard manner.  Code dealing with state information would be easier
to read, understand and maintain if this information was stored in a
consistent manner.

This series uses page.private of the hugetlb head page for storing a
set of hugetlb specific page flags.  Routines are priovided for test,
set and clear of the flags.

[1] https://lore.kernel.org/r/20210106084739.63318-1-songmuchun@bytedance.com

RFC -> PATCH
  Simplified to use a single set of flag manipulation routines (Oscar)
  Moved flags and routines to hugetlb.h (Muchun)
  Changed format of page flag names (Muchun)
  Changed subpool routine names (Matthew)
  More comments in code (Oscar)

Based on v5.11-rc3-mmotm-2021-01-12-01-57

Mike Kravetz (5):
  hugetlb: use page.private for hugetlb specific page flags
  hugetlb: convert page_huge_active() to HP_Migratable flag
  hugetlb: only set HP_Migratable for migratable hstates
  hugetlb: convert PageHugeTemporary() to HP_Temporary flag
  hugetlb: convert PageHugeFreed to HP_Freed flag

 fs/hugetlbfs/inode.c       |  14 +---
 include/linux/hugetlb.h    |  81 ++++++++++++++++++++
 include/linux/page-flags.h |   6 --
 mm/hugetlb.c               | 150 +++++++++++--------------------------
 mm/memory_hotplug.c        |   8 +-
 mm/migrate.c               |  12 ---
 6 files changed, 137 insertions(+), 134 deletions(-)

-- 
2.29.2

