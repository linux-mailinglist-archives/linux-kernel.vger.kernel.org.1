Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BB302D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbhAYVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:02:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34274 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbhAYU6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:58:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKsdXR028323;
        Mon, 25 Jan 2021 20:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=bZjWbGztV/0YWz1QtWoHL7sLDSva1bPnvDGbGIu6DGk=;
 b=qA1SHORnVFY2QPflQesRmUCu1GIf1J8UkfzQooit9bsQ4pelOGbviooYoCIsn3w9Z4Np
 0OSaJf0jR8u6QjQ9JyI9x301SVjenf7J4QtZBxChUCyHuU8HxlRdTCZsm7okdnmm8ACL
 CHa53KOFlmoLjVGiHWc/L34MsDrLIxXOHxr9WN5fVvoXcjYMFJfuNtGh5+kwYpOrxSGG
 cXWaPhn31DYlIQu+uRIIy4nhFjXy9B+J2V6bMY+Gp6AEnRzGgHJqFyHvqhMEfnkc/1oN
 gwD5DB8x6ygcn1DOaZhEdQ62c0jVsa6/F7tfSQ1OvQR15NWQIxYUYF/i+NlfiYYGaUrs JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 368b7qqb4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 20:58:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKuTv2136398;
        Mon, 25 Jan 2021 20:58:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 368wpx4rwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 20:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMJqvUWqCr0cTrNtGawMuD3DK+Yzqy1rf3+cI29w+Nrn3oXq/LNw3iqgrw2rotOpYdA75EcNRBoSgOU9yHwygDOihb62iX1bDQ0TngPmKpxQsGebhiVr6SygbcgnHrDIClwkdv/c59Cm/A3rtVB79eeRtFA+MIR+LKabcwy/NFRXVtHzVlrH8b2V4MsvEu1d3lCLR3GI5jnAzGvTnT+nzrsnzRM86duiZwyOWAI4RE8W0X24geqt3tCVdACOGt7pCBk4m1UtAuWTwJfzngb9dQ7YiROWoB6fuWq6NnkC8q9W5ivRWmK5lkqxktGLeEwS3nSQ6hUSlwUO6H2jy6aAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZjWbGztV/0YWz1QtWoHL7sLDSva1bPnvDGbGIu6DGk=;
 b=dlA5y9I3xI0XVHlkvWFV5neM/XhA/WYgJjTZp2/JpTYvvqMy3WfK8u080D4WvgbE7BR3LciW+mm9N5gLVkvITQQmyjVXSA6nyG47RdtYM310FfSd+noCUFD+WhopmYR0hekyvhC2BqkugRHfkR+5scsqcbPNu1LmPoioQk1xoNjqSrk5cCKiu3gISDyetG5LO+PFUK+TI1bUHJ+4tuzHlvVLR9oHJh+zrpcC6Qm+uqpAA6rfxF26Zji1akjxiaeS+wY6k1/SxSZ1lvvPfxKqlcaOsP4GFMx7fhs4Fy1cjIGU57Hl3PkPFrFDqqI4o5mhvyZqlqUjsoFGGxOgP9p8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZjWbGztV/0YWz1QtWoHL7sLDSva1bPnvDGbGIu6DGk=;
 b=kYVfj0bDA6dcYO/7arx7Iq9EVw0SRt6teqRNtiIF9T/sCLLVZYsP+TbTt6GHx2TMTuBLPsOBWQoKEKjguSXN7AcyAyU8HoNAKKEVx+6ojOHpAnVZmS0hwFkEJPpxgIJB+BUnacBMpoYuDRlpe3ynkgvahMyDbXHQtLrMKKrpluw=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2776.namprd10.prod.outlook.com (2603:10b6:a03:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 20:57:59 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 20:57:59 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 0/2] mm/hugetlb: follow_hugetlb_page() improvements
Date:   Mon, 25 Jan 2021 20:57:42 +0000
Message-Id: <20210125205744.10203-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 20:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f93713ac-987c-4114-6338-08d8c173e574
X-MS-TrafficTypeDiagnostic: BYAPR10MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB27765EF249FE98D8E290036ABBBD9@BYAPR10MB2776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ThosucUmeGxMXUx9p8QtLgSCduDN7ENC6rakWCsaOSqQnDn+oKbZ3uiMwBYUhL6fRvcy/uLNRZBIhenPBWY7nOAkCWSlG3o89k/ACLF2BuItNveyXgaUrP3bPdbKPgZe+Qxhz1Hy8qm7CXeEsO3oWHcd5oUvqeHVHXbiM38RHaIgxOdtwVynEXVV6Aq3/XqwQ+dCzrXcg8OICaNeAbpW64gfHdi4ca3qRw/KHZ06RaFNz4Zd6kaldzbjHHMVcrsx1GocLo0daZe9juw64RzFPexQqzCHLOWkUjMCSgm+N0OVhG6Fe9n1CUJ8ImxnDWeLdqQYCoMjiSyH879PaPCKWKSD7maxEZtJvxvzrgVx2Im0Mloio0X0jo/4G8Oo4+S/dXM08k8Mtowl6aRkKDyAUT66LqAf9wi3/1v6fip/vy0SLgr4UJfnnf1jmIxuoTMdq3sGnfMSJeebbDjnK73/BVMaCLVZAN/YP/i3/WYia2rDxXX6eVXv19Y+TiURuba3T67HoOvpKKn6vcTTS9hk4gbo5axxsIxVGbfs53nxlEvaoIPdHV1nrIDwPhHwvZMs4EYw6DXJVCNLx4lbb4p8oQSPkOdn8YDcXig2Jq0TZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(6916009)(478600001)(107886003)(2906002)(1076003)(103116003)(4326008)(52116002)(956004)(83380400001)(6486002)(8676002)(7696005)(316002)(54906003)(86362001)(66946007)(6666004)(4744005)(186003)(16526019)(66556008)(8936002)(36756003)(66476007)(26005)(5660300002)(2616005)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ja65Jc5c7ygEbZ749rx/Hf4eLCPjrUCN3YZJKFBWu8tdf64fLxeih2eH/j/N?=
 =?us-ascii?Q?O2gk7f3OZ5qyjs7zDtjczLTqIPAJSwwLn0I02GP+F53Bs6WnGHJ4RV16/dpY?=
 =?us-ascii?Q?u/39JKvU1int2A03NNM2U46NKnFEi3fzkclY78nfROj79dcKUcFCEnb/D5e5?=
 =?us-ascii?Q?Xv6/VyTXAeKPLg592omdr2S/AslHQy79sAdVdGJyeeAPt+WA9Pn6KC+9/c5E?=
 =?us-ascii?Q?OwXHi0k5iUEMl7UX7i4fxoAWIQt4XvcKzK8g8oWrKp0PIVbwYbvfCACpjvVg?=
 =?us-ascii?Q?oXVdRf4NBhZrK4oUl471Jg9EsIFcKKtD4lRBhkgJ+4kwdRVyuuGj4S1/8kY1?=
 =?us-ascii?Q?WfZq+q7RLLlcPayS/uPM7W7AQ3ODISzrU0kgbEflCx8q0gnepR2MAqLuGHTi?=
 =?us-ascii?Q?3am8nKAuIhBS30pgRn9VyqBpA1YLVr524hV87DRZZlTur3H1Eb8meb0x96T1?=
 =?us-ascii?Q?+9qp6sdGURb337CevLAN4U92X7jFJdwnx2XXiOARlP/wnzZU71hH/s51TDGk?=
 =?us-ascii?Q?AzOgrGYlCNQCXkLTVNzQHdBUFXfpoi5aHgVH72o4z3N4C1c5ccwP/Uy/xxYC?=
 =?us-ascii?Q?dCs6WrE9lj9IgbNG9BPyb6o5DmYN2LUw/ufnvRvt1kBc7JgPRyZwpps3TPzt?=
 =?us-ascii?Q?GKoLyacSDkWoskqm75fh0F/4vPtzkgdwA2hmy7K4Cf05zcxrYfxpoYtgYO3o?=
 =?us-ascii?Q?hdmx0DmDPl8Fl+KtsNOgcrhCa7K2TOtrEIzGqvEs0lkuGn3hdqLmF0RqtTFv?=
 =?us-ascii?Q?iKMgsQOvc3DwvZ+as/vf/94fmuH+2PGFJenWCVFtQG60WD295qBns8v2JAQh?=
 =?us-ascii?Q?BtuzlK9TeV65QHqiDNscpRsags8r8qPBvspVxhH8ZcGqYY0HGiXwXH9KbXyL?=
 =?us-ascii?Q?EzDDOjlLcjC/b3gTaT7sPypNzKiHXZQWkDmE66GkJvJQR5JGD9mFhN+q/60Q?=
 =?us-ascii?Q?GeG6Xb3BP5c69NWIXG71d4eHVc4Yhgbk192wIdju1j55mjv+BR2txYfnHePA?=
 =?us-ascii?Q?uUxIPtIVYk8v/EmaLd4SdcJ3EwfQpxwnmlEAzNueqRY1OpvLVdByWAYp4miZ?=
 =?us-ascii?Q?EZhUU3Kc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93713ac-987c-4114-6338-08d8c173e574
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 20:57:59.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVAuxbhkGjZPiepJ0ft+aOqc6CRmfqa6ngIe4p+KhUrwD4LIx7Q92VgxSqFyDzCKmK9OewoM2Ymv+n1mLYNmWDlrPBmZ6yUk6+sXw4cg1I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2776
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

While looking at ZONE_DEVICE struct page reuse particularly the last
patch[0], I found two possible improvements for follow_hugetlb_page()
which is solely used for get_user_pages()/pin_user_pages().

The first patch batches page refcount updates while the second tidies
up storing the subpages/vmas. Both together bring the cost of slow
variant of gup() cost from ~86k usecs to ~4.4k usecs.

libhugetlbfs tests seem to pass as well gup_test benchmarks
with hugetlbfs vmas.

[0] https://lore.kernel.org/linux-mm/20201208172901.17384-11-joao.m.martins@oracle.com/

Joao Martins (2):
  mm/hugetlb: grab head page refcount once per group of subpages
  mm/hugetlb: refactor subpage recording

 include/linux/mm.h |  3 +++
 mm/gup.c           |  5 ++--
 mm/hugetlb.c       | 66 +++++++++++++++++++++++++++-------------------
 3 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.17.1

