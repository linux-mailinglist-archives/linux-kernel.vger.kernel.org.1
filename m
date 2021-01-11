Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4662F2164
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbhAKVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:03:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45846 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbhAKVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:03:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BKx2a9130805;
        Mon, 11 Jan 2021 21:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=fgYW706R1XrUDL4RadC0ldxjTbBaKDEcBIEZOoZSrOw=;
 b=vie6GbEapn9hODmsY3M6p5RRQoaejhbei6/HvwaFVZGK8evw52xQS9KSbdOEy4l0t4Qu
 MN/LelmxV1sGHFkdzFQ1PK5mwAh5lTElMiAakWgc7/NumeN2RnBjArQEYllI9aJt+NOz
 WKaJuYV3jsOqfLdHR03nwLt21RfsuirbytZB1Oc7Ct1YHws8POtlT20kvRTyoQ9vTli6
 QklVm0PMoY66SEBk6KeXCrHs4WNyByFJA0kVBF3+q4klQSVhoGtmedzuGcmlnS6iZ2FI
 t+tVK1fX99H76QW/Fx0G7uCbOgRDY6QPd6KfccvMq1Tio6gEJD31r9CeQcvY3xFi1m5b aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 360kvju7vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 21:02:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BL0SuL141458;
        Mon, 11 Jan 2021 21:02:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 360kf471d5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 21:02:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlN3OvJZks/FY56z1fvVK3da5ZCOiJuQVp46Rv38JKLOGNnXIsYodLAb80hG6MPOChmdRNBaBcoU3UI2L5Ph+q92RjhGgdp1u1xdogdff0s+zjB8Lp/xBr8bPrxJf9oqEv76mwfC3vIHi9FEp5syZ2c6LYMuG6LQbhzKkQAk6oLdL9H4gmCnny68GAvZYAPSezgOhTxMBOGuEiqrAVRKvrnpMt4lJn8caPj4DFMMJT9gmmS4aYSEzHJBmsxhy0DEoGx047PcFKS+lv54nCCVZFRLNWm0JWKnCdDBzQ2Ct0f2lB8A/XIDMZIhvOSAbVjjwz1MlDxs/S+8OAJtLagVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgYW706R1XrUDL4RadC0ldxjTbBaKDEcBIEZOoZSrOw=;
 b=eVZgX6uO43oAMLWsaU6dJWdGyUPoJe4N9ftjdHCJUfIpJ1nyQLPxJLb/zEzK3yO0+uRXPYVtywDLUTWhJoi8uOliMM24/0bA/GyrQc/wh44/asIGBsp2feeg2VfbV+yHfEmpwTDjPeUkPa3BfEKYElH1zd+L1N+E8diFPQzvkIlrTyCcbVxVRH9+hOAvIGn5Ye3WvrPH/s8ZCdHq42PDFmbQucPiFONfMREbFVWw5lsI1Y6KckEh3toyKpLBJSje6sL4JsJVEOd3qCd/fSgn1Tio79CK6Cgjn6b3XJiiYfu0vc0M4uhotUjtTSpRdA66FUHWxZZ/dx/ZGy1zkAceCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgYW706R1XrUDL4RadC0ldxjTbBaKDEcBIEZOoZSrOw=;
 b=Sx8+WjjdXBjdVYucvzo2OGvF1ffqM/41jWqPuMgkzzE1P3f4Cfi+0eCLGUvDCh5OATLZ7p6lZOdZdZy3VPYZ+IA7Ixqgx5forcs+jhjQXa26381u3bdoK0THA7seFTYKvg4NMVQWsqi7vqUxWToEvObQoIAg+vrshdjigiVbrgo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1711.namprd10.prod.outlook.com (2603:10b6:301:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 21:02:07 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 21:02:07 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] create hugetlb flags to consolidate state
Date:   Mon, 11 Jan 2021 13:01:49 -0800
Message-Id: <20210111210152.118394-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:300:115::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR11CA0028.namprd11.prod.outlook.com (2603:10b6:300:115::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 21:02:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efc788c-08b3-43b1-5517-08d8b67427dc
X-MS-TrafficTypeDiagnostic: MWHPR10MB1711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB17116AE9D5BE3F98A8AD6A88E2AB0@MWHPR10MB1711.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1wP6RSAqIzAt31ON9YytwW0eeUw/efdOLy37wvIfRfjgU3IVw/4ivSEON9qDRGEzU7HGIGT0+8FtZZsSGEHQPtGAQ9+hxytlnJnSGzj3F13J4/onsEcT8hhnlj+zUmGpxivOrkRD7MoSw0chN7/R8eKXZsK4CgqkgjMlp5eLGxcVMMLwpJ6eyifRx5h23nFkurABwzBD6I4EIWWowWRyLsSroM3PlQz/OgS6tt6sivdrm4JeHrrAd+MEhyX3KkCyDZIEES3jej2QcvBTxUKnW/mmZdyHxkK+LHk+OnB2v918cnofLvzrYC8yg/ft/WbU0UXRSIioqawkZlvtK6mhncNVGSRMJcnNASX2GOfbalJLIi5FGZvrPFWF5Aim2aNFWsZqFjVttFYYpHolGEwBZlTAC/UBp8MdqP7L4R52/toml7yny3acycDdqSCYqpAWxcOHCMD1hWti0Fq7Bh5Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39850400004)(396003)(186003)(966005)(16526019)(4326008)(1076003)(8676002)(6666004)(2616005)(54906003)(478600001)(107886003)(956004)(26005)(316002)(83380400001)(8936002)(5660300002)(2906002)(6486002)(86362001)(66556008)(52116002)(66946007)(7696005)(36756003)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LBc4E7KaXXNLpUztT8SR46o+R3j1NbOz43+eJsQaQ1hVXIPj+4veCq+gauF1?=
 =?us-ascii?Q?NK7leIKPeEJh+LZV9yOcKbluwzJjP9nbOUeIm8LWsA8Io5gW2pZIFqeocS5p?=
 =?us-ascii?Q?vhoHXOQIGFphZu3pU2TVeBoBN9PltfJDy6A24WCe2rL4eL/+nj7dkE9dO4ma?=
 =?us-ascii?Q?PIScy2WX+2y3TLACit9QTFaWczDamZCSLYfeI8CP8yLUYgwZsgtR4dJWVkgx?=
 =?us-ascii?Q?Aca1b5cPXljCqNVhZ0Gd8yIPRbXpl2+MRC0Vzq0elqlIwG3NndocZD568Zbq?=
 =?us-ascii?Q?+SA62WCvlRmqKnQ0PYvI3gMQG64aRS33H407TOav4mlTnY8j9VrAE2df01oa?=
 =?us-ascii?Q?/C7TQ3Je4NB+HDIpxvGD7dfCigaymLr9WZmtWT3b+e3pSYdv1DIv0Z9/dA8f?=
 =?us-ascii?Q?nwErF4KdQ0ZqYMDXwxTY6bm6CWGsym6TJ34S2CDGQlRMLa8Pa2aWZhBmlCgc?=
 =?us-ascii?Q?IwiiYjmMGciWS9g2zi94hkzo/BqXmDnRBeVX8RlUrm4yTcTsUXNy/O+WskIQ?=
 =?us-ascii?Q?jGjlgvN4Xyi9q8Qu30GJkCSG7jKIqLJ0T6R8PGU2a/EwCso0s7v2l7YSusaV?=
 =?us-ascii?Q?yl9pDuzekwfoG8D7ByalQm7fpEQh4NQ5Aq0GcTUMm5NVx8L8DXGkPKzwdEse?=
 =?us-ascii?Q?mABsmxl50hOoQGokvvWgugrK/VTxZLe5p3BPAPoPCxqDUFRU9ZwEHWY6eVy3?=
 =?us-ascii?Q?9d0cqcmEqMzxAgFc++hcW8OXRal/bwDJh1ArVpkuddYSFmgnYSHMWku0g4kC?=
 =?us-ascii?Q?SWTVswNvnyGfXS9LZ+EoYuR+E/rbJ0gj3AeFlTzk4S3VW5gLmVNlmvZk02xY?=
 =?us-ascii?Q?Sna2woXvWOPv5TnPBSP0CFArBjM+WoNPMO1XPlAtaq7HNa5qce/+sgnd6XzF?=
 =?us-ascii?Q?mA4C7uW2E8G8ffLyDZpHoWbFKI3WJl/sAg8rpznwhdr24Oms8ujw5HpqgNpJ?=
 =?us-ascii?Q?dqqgm+Dj6rMf6jiJ4ojjtnDnIFN5sCS2Mrv7WG7uhBo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 21:02:07.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efc788c-08b3-43b1-5517-08d8b67427dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPvTJ8zftDn2OvDDqTtR3lwsbAhBbE3U12JBBxidg6QJEfd/BWmwkUeRaqVtJ+Gd7e6ClSkWFcXZMnIIpbzuPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1711
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=793 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=955 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing a series of hugetlb fixes in [1], it became evident
that the hugetlb specific page state information is stored in a somewhat
haphazard manner.  Code dealing with state information would be easier
to read, understand and maintain if this information was stored in a
consistent manner.

This RFC series uses page.private of the hugetlb head page for storing a
set of hugetlb specific page flags.  Routines to manipulate the flags
are copied from normal page flag manipulation code and use atomic
operations.  This is likely overkill for the uses in hugetlb code, and
can be changed after additional auditing of code.

For now, only 3 state flags are added as part of this series.  However,
the suggested fix in [2] could use another flag.  In addition, a flag
could be used to track whether or not a huge page has been cleared to
optimize code paths if the init_on_alloc security feature is enabled.

[1] https://lore.kernel.org/r/20210106084739.63318-1-songmuchun@bytedance.com
[2] https://lore.kernel.org/r/20210110124017.86750-4-songmuchun@bytedance.com

Mike Kravetz (3):
  hugetlb: use page.private for hugetlb specific page flags
  hugetlb: convert page_huge_active() to HPageMigratable flag
  hugetlb: convert PageHugeTemporary() to HPageTempSurplus

 fs/hugetlbfs/inode.c       |  11 +--
 include/linux/hugetlb.h    |  19 ++++
 include/linux/page-flags.h |   6 --
 mm/hugetlb.c               | 178 ++++++++++++++++++++-----------------
 mm/memory_hotplug.c        |   2 +-
 5 files changed, 121 insertions(+), 95 deletions(-)

-- 
2.29.2

