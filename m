Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120972FC6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbhATBlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:41:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51582 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbhATBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:32:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1T2iq121989;
        Wed, 20 Jan 2021 01:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=4I8bD2X+OCNGj+GK60AB6yoKWGbZEuFoevEpPY7o/gQ=;
 b=pEW4g1Q+tBKR+gK1pgvMlGqrrw2NGdLSvrwVNymxYkDDEpOEcf0+wYlV7Fwuj+LtSjLW
 vA5tlNXk2qfkxtuM0CRqk4JKhKzyRbPla2loYUkWNO9E2LSOKO0KD8XTsK31GNMmLHRx
 Ku4ryYW/L+Vfeq0rlYsp1LXtsXIRDMRWmxrgTYq9jDGu6Pq/xYme5CZAdvlookxHWuCO
 LonfxIZpVyy8Ttt3wcdT6M+WSyzgQsXqQ48tq5d8tXZJ3x4b3990M28FagIa7g01jiKj
 gooK/tSa5iCM+kuxBCLn6Jwh7K6PdIbNlnj91GdHrkXf/LsL8qqMng0WyZLyxZFlp6At zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qr8ad6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K1Tie1037024;
        Wed, 20 Jan 2021 01:31:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3668rc5qfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 01:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjOqLWaZg7SASsnxxU4Q3d0IOXSqnpefWtDYUkFayBj+vNB/COqo0Ey6M1m+2TFc3EoET9fff5JrGUSfa4BYFWUT34MLD9871EfDIz0aavtX6gAuIigt7ZyMldYzm89MkYAGT35h+/GmoLHBm0H4cBInJXNw8/hiZX4skJyfmhKbNWfOGqPMF8vI6SckHO2z9TgGZXmhPye8dd8V49jjv+UwM9KKluA3MOWUY76w/b6tSC9nQFnev/WN1LElkNqCF/dmdP3JA0DULT9XsEphIsKgMfILdm1ZczjjB2FpQq1xZbg5ULXjLIYIwu8fUUgU3MDXcYLSQulXdSX3ZTFaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I8bD2X+OCNGj+GK60AB6yoKWGbZEuFoevEpPY7o/gQ=;
 b=c4ZKa8GwxbyLj8JVniipClh9so2eqIwxFEZWL39XUzu66SXrWDRXOE9bCqc+JYongIGSco4xuhN8t4Ei5hDFEDA4JpCK8eXCS0EafKthlek66WsMHpFEGBgIYfHl/hvARosqInzMsXiDcdIFaNRxyPKZ0MyEvzyUPleSPl3yXgGoZkpLmxH+/MuxWkWq4nWJAjBUBW4tB0QmCA1Brb1uNcUJRLySceyWPA3YoRIaFG57q7WXMGezNUWUIQ2bMZ2RtLFTnO6+Tiq5iG2G/0zp2TbDI0xDz8lPstbucT+QDbSSj+P6e2aQhsdVs09mO/TlwZigjT5ixc+UBmp33HuYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I8bD2X+OCNGj+GK60AB6yoKWGbZEuFoevEpPY7o/gQ=;
 b=SWDfM5i1YaEuCyvoSP1KA8KZH8YZ72vk0KHPCZs4KIERKKuNidcOj3JZhwSADDv63rwglmeUAuu5df8qg/z60IKG9KNl+byxBsIpfndLbdZFgx+mrFKhPbjBHaxC7kW+6Y7LhChzN77ZdX7YKosag/3AgIf9yuxU5mb+eliBVQk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2384.namprd10.prod.outlook.com (2603:10b6:301:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 01:31:06 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:31:06 +0000
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
Subject: [PATCH v2 0/5] create hugetlb flags to consolidate state
Date:   Tue, 19 Jan 2021 17:30:44 -0800
Message-Id: <20210120013049.311822-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:104:4::32) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO2PR04CA0178.namprd04.prod.outlook.com (2603:10b6:104:4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 01:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcf0029-25f4-49dd-4080-08d8bce30e4c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2384DA758D08635E09FFB393E2A20@MWHPR1001MB2384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgqxm6rK01zoc39sW/tSd2jQrCqTSbe0F5lzTOrj3b61+JhxHRTWdMBUnTjfcxzAodT1C3f//y7vBbLb6xBPFxAGxtEwmJhasm1wIgAi1PFIDUrdrJftYywzI6HkoJiHMXdTmVR/nFQzgnJQBsew+dYBzFqaFsASkKjRwSK7xh3f9TWh4mlYjeAoPWOODibcfj2PqsIY3rF78+ZT4kghxSCKRthS0Pmk7jdXGtNwUikOfHfTwClOokO5/e05GLxoGNnmpb5jPjtdzgyakmrJs6fGN7hLNioHXv08BPbNOu3B6YBJWLZvH7xclhVlFeWZ2AVl9v4XVrz3oxkZcYgG6/CO6L9Tzt3dQ/UnST2moMbEFyngDaNCmKLW+72WbhsOzdmsmB+ubWGF+TVhYG4m2+Qd+2hx86aSQK5+eN37NzsKEGQdTeub8PIfdn/u5HiNzXA6/FR3mytip8F0mh3SKOCNtm6+bNThfU9/V8s9mMfUubeHkCuaUhO2ZGpuiVOq7iHJT4nX4EZvINGeZsSWtNNYo3vlISyA1fkpgQFWheKKGmJuZNprVtzGR/a3tokejVEo+rFY0tKpOLjnNTkhKXD8I9xwc/sGeIXOJ09ozUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(1076003)(8676002)(186003)(36756003)(107886003)(8936002)(966005)(478600001)(16526019)(4326008)(956004)(316002)(86362001)(5660300002)(54906003)(6486002)(2616005)(7696005)(66946007)(66476007)(66556008)(83380400001)(44832011)(2906002)(52116002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+bzNcLBSP1orL8DUIxAlS/hDAuk4vNggzQvzudVeBlYmBYrvWSmpWt7b6xxo?=
 =?us-ascii?Q?uMe8aJBasbZ9rNVxfAe3Ir2TJiwB7vKrf2cK+3U2KGn+E3jwxUgCzhTz9au1?=
 =?us-ascii?Q?RHU5VN3FcsH4K63ppH4ZqOlAByVqRK/x1eKcapr+0/VMBGpRaTTHPVjlow0F?=
 =?us-ascii?Q?5aDO2lkbzWKoNx/UHrDXL6K8Y1wApexFNwkOm+oUbQIQUfe1rWgZf95jBH57?=
 =?us-ascii?Q?qcL8jIxb2sZmktqnhluv3LvaAL3Ws9QwphdwRr7uC/3ONc3tumU6kd3afn6m?=
 =?us-ascii?Q?2TK0bjRbred0LttaqcaulEyE9eBNql7nntUw6Z9xfX/ZlniO0yOUli/JH/fR?=
 =?us-ascii?Q?I0i55XuPQmQJZQw7V6D3eZbGvhbJs67q/IFOuAkcedFQMUzX8wvM8pRUZ/nJ?=
 =?us-ascii?Q?OyXb2Gs9TOTxIZQrFfDJeB+0A3taZGG4L1GTrb/mlBftC8GcBccTD3DckwQh?=
 =?us-ascii?Q?AIciIwCthnEv8UkLBtBNKbsyZ18p/lpldtIOirvF3T6YJiSynidk+/QJHe5l?=
 =?us-ascii?Q?8QM3lKNP4RVRjL1mHUQuS6gxLn2ZJ5BtRbX5vq5zy0bj4l5kQc2YQZoUI71X?=
 =?us-ascii?Q?WEYknLqNCXqJ4rlv5cS1a+EGp2XK6abJIgdBC7K4C+qjzEdhtutn3u8KqMh1?=
 =?us-ascii?Q?GRFMOKdmp24lFkboMRGY3moeuzd8mCyrbwey/xAag8JrudRbNjGLmMTl94iw?=
 =?us-ascii?Q?q8aIDPsoMqPQKYcMBQyw4/M/RmVVUEQyzp7XlSsAipmbJc2QuDX3PcZkLf6Y?=
 =?us-ascii?Q?VTVxa9ze/g5TyFURrPO/ExBkcMxjyThHSu5iVbMmVPq6DD6i0yUd2e7BOg71?=
 =?us-ascii?Q?0303W9fFyLlJNpuMKMvHjrUMIi/MRv0OetO3tNY0TplbzhwakXYRPakVPmvc?=
 =?us-ascii?Q?+PnBCA1xNIRENizQqbDRCfXsJZY/riNwGPF7QHt+EKcaP8U65x3vBd6osDPM?=
 =?us-ascii?Q?CJ+ayWcJnasS8mv7PXDfX5hvPE+QoXRq01jIP+7ZXe23DEHqyoDEZsNjRsBf?=
 =?us-ascii?Q?4KLXURuJYEFvV3U+tWyx42Yz8HDPFB4IurwDS242Bi+cEQwmCzoEAsRgE6AR?=
 =?us-ascii?Q?PV5PUUkE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf0029-25f4-49dd-4080-08d8bce30e4c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:31:05.8910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znGaa6ToyDiBkk/JZrctVtJ5Vmz0+9ifFw/9bFHbzfqv/TFO5vOqvCJzaBTwl1IJpWOJAQ/BAP1sQnnyKr22iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2384
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=496 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=646 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200005
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

Patch -> v2
  Went back to functions similar to 'normal' page flags (Matthew/Muchun)
  Decided to leave check in unmap_and_move_huge_page and print warning

RFC -> PATCH
  Simplified to use a single set of flag manipulation routines (Oscar)
  Moved flags and routines to hugetlb.h (Muchun)
  Changed format of page flag names (Muchun)
  Changed subpool routine names (Matthew)
  More comments in code (Oscar)

Based on v5.11-rc3-mmotm-2021-01-12-01-57

Mike Kravetz (5):
  hugetlb: use page.private for hugetlb specific page flags
  hugetlb: convert page_huge_active() HPageMigratable flag
  hugetlb: only set HPageMigratable for migratable hstates
  hugetlb: convert PageHugeTemporary() to HPageTemporary flag
  hugetlb: convert PageHugeFreed to HPageFreed flag

 fs/hugetlbfs/inode.c       |  14 +---
 include/linux/hugetlb.h    |  95 +++++++++++++++++++++++
 include/linux/page-flags.h |   6 --
 mm/hugetlb.c               | 149 +++++++++++--------------------------
 mm/memory_hotplug.c        |   8 +-
 mm/migrate.c               |   9 +--
 6 files changed, 154 insertions(+), 127 deletions(-)

-- 
2.29.2

