Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB4300FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbhAVWU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:20:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53078 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbhAVT4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:56:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJnfpR170843;
        Fri, 22 Jan 2021 19:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9bio8XDi/HV+BSeNlORd+d34NpApKwFw/6dtVTSVukU=;
 b=Hsckgoxv798CFI0PlqunloyYAVDg19A+FET+uTV7Yw8tbHZztuGD8mopUwZPTcNbEWx6
 cwaN9Vp/DiVs4GOd9JmLqnYfrRVTxVbvkZ1IULUPZgu2ZrHwuEqF0YLjnIf/1xGpPtYB
 MaR17MtlxqPDn77/vmIJT+9NaFjjQy93kYGTeprgE0uO5GkNie6FBf97blDPa29B5gck
 6WZ+zwFe1kPobgsk+LNiU4cIVrECxymjn8OuMZLP0e80DutD+Nn4z7BE9EeSbSijZwbr
 AMrA3ptWbKRhdmuEi5YyCyWHb7AbE9NbySR41R2P/PsQUsfZSyWZCnH8qPdfqMIriyw+ vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrnvn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:55:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MJoA25135354;
        Fri, 22 Jan 2021 19:53:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3668rj2stg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 19:53:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9oC36rIlaBfrVYpRmHP0nTO9itgXxJFL22VwUjslF9j2qoQM/uAswgkA135C1ydz4jIR1m419MjOB7BLQyUQ08sY78BpywY/K5AVQmQRO2ONYzak6eAism4wqy4bzkq2d9EDhqbBEIMKqUkmjYJn8Ku8me80aXBfj4GH4pcNf2TaLcF5NpRjcdFRNErcfH5r0JZa04MUjo2dJJi99XxLE7h1rir5ZDMCicZWDgD4kM9yunb+DwrD40B3Q//6Jq5bm9roROTorzhe69vkt5MgqS3GgfhwcOX7o8qI8botuS2689SG1UG6aoe+aSYfzMot76LARqsHeyXjit025WCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bio8XDi/HV+BSeNlORd+d34NpApKwFw/6dtVTSVukU=;
 b=LvEZl/vZk2FsuxSnJl7WEai1sAeMhlwWS5lm36QXWu+SBMxITPbKryilXz2+b5eHhsN5aSth+oO0VIfKZSOj3XYTFoXyohUFIm1xguCY6GpME6V9kGZ64Iq7wfLHKVyyZp1Xui+E/hzusAtiYma/KEgfGJVvKAO/0YghuXGpkC4KtcQ0/qtJzk1v8FgLLwCRzYmZEFMNImlxTDiNtnVQDxxKsF2QPxEPVj9LlN5tjGK35K/gtyF13x3dZ1SB2+h9UloAJSCUQGt8mGR/A+yqdXt1Tx5pmPErcK90QDE5dwXDPfpHJhAGmbdHPbaySIIvi9c7ifGNwRhmju9tXQ0TtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bio8XDi/HV+BSeNlORd+d34NpApKwFw/6dtVTSVukU=;
 b=r1QOTyGjUqvvilM4VcnfvxOP9QUdnjSqHxcy1682tYnzaJi6OdWBraNtJMS30q/fSWj5yVDjbJxduyMWY4zSbDYehMFIfwiXb8dBDf0UqrjJY3jZ2SpG6MPbnY1FJ70Al2Ie8hzzdAwGtGCqVYW2UB+nJ8uyZPM0ahalldFb4GE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:53:00 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 19:53:00 +0000
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
Subject: [PATCH v3 0/5] create hugetlb flags to consolidate state
Date:   Fri, 22 Jan 2021 11:52:26 -0800
Message-Id: <20210122195231.324857-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:300:94::33) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR19CA0071.namprd19.prod.outlook.com (2603:10b6:300:94::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Fri, 22 Jan 2021 19:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544608cd-7a33-4cca-4595-08d8bf0f5228
X-MS-TrafficTypeDiagnostic: CO1PR10MB4723:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4723062193F7DB0A7AAAD052E2A09@CO1PR10MB4723.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akv3sADkaoDyOBz2txMdNANZ5iaoKwo9bRFe+jjq0iHWbOek/FyGCE9TuwNRxBN3cC/sEYdBcDAaYimv2Z2pzgYjxwtPiMhcDD8epnHWRe66ILNvGvd6sgxfuyg59Awejem91Nh0JXgl0PXNmp+EH1jaT2JAGYLnyFEPQBSiMyL92VXHpQaxjoiFi85AbxC6Nec2/QvsqpSgCMcKBLXP0u4FvDjRtfxlTsUlaeTs6jXqPq6Dckjs9S72AkuxBB2fjWTu2BEXKZp28FuiqCaC3FibUezItYri5oecsQQyMeQC5y/+kBILlqF97HLSUZf2nXA37UPNRM3DzTkzCJMs0jDnWAQ6H1nco3jGW3U+3f+jLKvS3fwTNR7SZ/X5gKNCIUFH1qmWOb4GzmwNC73w6mgHESU7GzpHBFag45sqEn2ZuPekoYBCUotwL+cIX33vHIrIbrXQEifPB1Rez1+loQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(956004)(16526019)(966005)(186003)(2906002)(8676002)(2616005)(6486002)(8936002)(36756003)(44832011)(52116002)(478600001)(86362001)(26005)(66946007)(107886003)(7416002)(1076003)(83380400001)(66556008)(66476007)(6666004)(7696005)(316002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dE74xyVdF6rojvTqJUzFgsIDXGn8oGNYf0Qo9BgOAOjirl9TV89RBTnalk4C?=
 =?us-ascii?Q?1LwlmMi4HqhpC/akLFQqySMK28vwMwMJnBSn8OBMe+nNDbvBfhUS6Iwvbcdy?=
 =?us-ascii?Q?QtBhomAdHEcG+QqvRKJc4UWdIC6pCcxeoFW15uqeTTWcJPiycWvsQglY99FE?=
 =?us-ascii?Q?YBRFYn66RayHWUA1nk9PoY7KKZ0F+6urn/aWSf9+YldBTctXKX/otVdCZXY9?=
 =?us-ascii?Q?rWozSNPz/NNEdu6qjb+6LlZAPLsjbUWJf2oDQpYRkZmXU2v1M0oppxxIvOHM?=
 =?us-ascii?Q?WYJRXk5j/xXnyS2nJVEBYJjbNbw4qQODbyzPVdd3ulh8mCXfb2lHKCcXlTqj?=
 =?us-ascii?Q?dnto2p9D8RLtguJtln8m9I0DgIu+yhDXwjKmn8Er+sliGJfe+YsnIRNhxxhe?=
 =?us-ascii?Q?ldsW7vNw6iSEGckyBr8aI/Lmnw+F4v7aEWPY+ox5qdSGEfRarNx3qqGntKBa?=
 =?us-ascii?Q?/5vbsL756hM5NEh1cP702a1cTuhzn+gUSegCIzhWrkTXYVr9i1gx+Omy88K7?=
 =?us-ascii?Q?NVd20Hlhbdhue0i4xyABr6nQneejYbmTBz8KwMIVYcJp/UyuMrMM3+AZDis7?=
 =?us-ascii?Q?h/l7ZUFKuJh7ZLR2TjxI3d8twIxUcNuHs7+WV28mmVj9DwxuDralggNJ7NjJ?=
 =?us-ascii?Q?f4LD4fv5jz7/UJPcOvnY5D3ZLsXAW3gXQS/ykvD2fjKW+Ey9gDD3n2C6GA3R?=
 =?us-ascii?Q?UoT+XhisxonUkVcusBTWKCJhqh0+JMRnZGYyEFDbnB1e/v2/4s2s8eLfFw6J?=
 =?us-ascii?Q?q13hJGtuf3yw0LCY8xQMhH5yI1Iq34lPRpmAxle+H9cJoDIc/wAx4SKoc2ag?=
 =?us-ascii?Q?Oi6+SPxoBiCAVIiEvoUuKwerRAiAw+a5LV+LJrSrwUJFOHXSYxEyWs9D9m4a?=
 =?us-ascii?Q?RwSKsEb2UkSma395M8LoSAthtWX/7G+YZqwtICl2XQ7J+hdgTsrb6PKiw4+e?=
 =?us-ascii?Q?pzAXA1iNyfVp9qI8gOdUKqA20Gho/QRs2aTuY/GIIuDgMW+sR9XTeAjXQ4jf?=
 =?us-ascii?Q?8hSnVfykpYDEWkc6Yt3Y3dQGn/lc1ALkVdmiR3qlRRWxN2Vn2YirA2e/s+kO?=
 =?us-ascii?Q?vBr1vhOX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544608cd-7a33-4cca-4595-08d8bf0f5228
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:53:00.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uUqZ8mFDiX4j5Q8PS5dI0sPZfBMRJ3Clh1GhDddtVtmCY93P7lRcjiEpW0KAdau6MHsur6+7Lkdkj1ogParYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=782 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=933 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220101
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

v2 -> v3
  Fixed !CONFIG_HUGETLB_PAGE build bug and moved BUILD_BUG_ON to
  hugetlb_init (Oscar)
  Enhanced patch 3 (HPageTemporary flag) commit message (Oscar)
  Fixed typo enhanced coment in scan_movable_pages (Miaohe)
Patch -> v2
  Went back to functions similar to 'normal' page flags (Matthew/Muchun)
  Decided to leave check in unmap_and_move_huge_page and print warning
RFC -> PATCH
  Simplified to use a single set of flag manipulation routines (Oscar)
  Moved flags and routines to hugetlb.h (Muchun)
  Changed format of page flag names (Muchun)
  Changed subpool routine names (Matthew)
  More comments in code (Oscar)

Based on v5.11-rc4-mmotm-2021-01-21-20-07

Mike Kravetz (5):
  hugetlb: use page.private for hugetlb specific page flags
  hugetlb: convert page_huge_active() HPageMigratable flag
  hugetlb: only set HPageMigratable for migratable hstates
  hugetlb: convert PageHugeTemporary() to HPageTemporary flag
  hugetlb: convert PageHugeFreed to HPageFreed flag

 fs/hugetlbfs/inode.c       |  14 +---
 include/linux/hugetlb.h    |  91 ++++++++++++++++++++++
 include/linux/page-flags.h |   6 --
 mm/hugetlb.c               | 152 ++++++++++++-------------------------
 mm/memory_hotplug.c        |   9 ++-
 mm/migrate.c               |   9 +--
 6 files changed, 154 insertions(+), 127 deletions(-)

-- 
2.29.2

