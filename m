Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC1300EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbhAVV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:27:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbhAVV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:26:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MLDpDJ157077;
        Fri, 22 Jan 2021 21:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pe35CVnWXpjBlhs/MbMM756x2cywR5bno86aN077z0M=;
 b=JSf36ETf7EWBwCqVZGzRI0mSN4dY8o4wW9AKB7OHOQd0ktmdwZ7QAI/AaQ9REauJmLec
 7bm+nw0R+PnDf/ouP1YSzt+h+ciILErt0CUBSmxZ29a0pBZCl8ut0jdx4rX7PZwuY/5L
 84eQ+VUUoX4uKJzOHQdo0EXPZhIwznIr8RMv6PyUsHx/Jf9mMz1tN2y1uaBcdlifyfhf
 /lFdnQ6jvWWY2KIXI+CmPeqm9BUfzwVyGqBUvw1owXxMBLHoitj7dZCeii+T1S5FVX7k
 xeXcvEDEOdFWii+21GUNdBEB07cAfJQ5beNyBljrzNok2x89tCPx36sOxu96217nCsqj rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3668qap82b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 21:25:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MLEno5129482;
        Fri, 22 Jan 2021 21:25:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3668r0em56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 21:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JODdgVAPgJ6RBz5vP9Ud6Imykp2viDsLKYqs9wlqJZY8yQmmy9dURBoNJkBeFslFOVZo6BV2gOw8MotAKfO/+wegGnCjHSzz5ZuJ8CN5b9lvHRLHDg/q7p2f29Vy3tNsO2l1Odzou7diQIfFdM9all4iw45F3dkYIaOd4vLxEL0RXH73a0ew0GgacYWT/KR9ZOGhDPs1GcWf7d4Qdr5VOW8ENmttWsdLEo8dLVo5Rm6NyvrOMnjOOQX3cDe/tu9I+UuDWFIeR8R/KyShX0298F1N3x0QnTSX/BvXgZ3UbDVSz2gjK1/ML+dKg2DHlnmDh4ktI3tF6V7wvP37NIaH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe35CVnWXpjBlhs/MbMM756x2cywR5bno86aN077z0M=;
 b=Qq4Ax9C21JV3OPPtJgbR6P4NTViOa3xkRpVI0yPxMN/v6k3d5c25wjOB/C48xUE6dPUzGSAuqL6q4TeDe1Uo8AkRnpXcvRKaD0MI2nG5jpAq54ZTz/8TRTkXfxtC/mPw8W2ouVZFGHiueMe3NN6oFhCeRLC/Ow03fISqxpZTqk6Kdd/gibuCjgfx6NjdnTx1Xf7XS4Ew9HitR5oFRupeuDjEADIbGAA+pHUSGz7C3loKCVyFShzJOoG6F7uGUGJlB42DuZBmdfmlHVBV/ZqHVvesVS+v0FlBVuJeN4lJMyQnNTc5rgY/9pL7K7mnKfYoZf/LtqC7er6oVPdAjnodPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe35CVnWXpjBlhs/MbMM756x2cywR5bno86aN077z0M=;
 b=XbDwD6+dBXwEJC/lUmF+cuQlH2uOdkpZxmutGN1TElaNJlv1aiDuIv+riCqTNjf0qBqpr7997pCNEilF4YsHU+T1jLlT0+SNlM3kaYdbJlvLaY6G2nzAlRT58DORDxvqGgQVOW2XRKfWvUSE1kMirqVpYAvwaslRe1Wx/UWpQnQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2303.namprd10.prod.outlook.com (2603:10b6:301:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 21:25:03 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 21:25:03 +0000
Subject: Re: [PATCH v2] hugetlbfs: make hugepage size conversion more readable
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210122083141.24548-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0809e556-f96b-cacd-466e-5d9fb5417f3e@oracle.com>
Date:   Fri, 22 Jan 2021 13:25:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210122083141.24548-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:104:3::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR06CA0056.namprd06.prod.outlook.com (2603:10b6:104:3::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 21:25:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7820cf1-bad7-43b4-2e92-08d8bf1c2e94
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2303:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2303EF72A5A0C79A2817D579E2A00@MWHPR1001MB2303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUyTINiaZdpzQjwJfzKo1RcIFM+q1K9WScl2oVZ39hdlCZkzxS2uT5PBxi5He0D32FnGjH75OZaj+i2T7lek5C2fmVWX2EBs2eKM/5LvR5qpT92ZwhDnpuCUzshFZMjNfPFHixDJce2JUQRy5fZCSFNRBdrW50Tw3qJ3oXWm+Leo7N1NKSICkm11eezy6KViXNZCaOX6rt2YZrcq9aQYqcy5ZOwcymxzf+CnO3g+H70WRdxtBLWN5LpgGAyax3UGn7a48MOIlADyY+VYYzvjEVfQrxhzluimgy3fYNMtrLxzxz7SrX/c9x7S1wIgGyahooIX4ZDBQtqsHly1Rvp74MDjInc4aPv8BtU5uC5yzCBH4dtQOdKr1zTe2bKNzkOcwwKwKxjd8/oFUb40FdT2L2T7gDKt93VV4Vzy1nEVfUV41miExeumiGyPHS1uulng/QTXXCChpAFqgJgR8D8UD+eOcsWkc7tDQOEc3D1862I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(83380400001)(66476007)(66946007)(66556008)(4326008)(44832011)(5660300002)(316002)(86362001)(31696002)(6486002)(31686004)(16526019)(53546011)(16576012)(478600001)(2906002)(2616005)(36756003)(956004)(8936002)(26005)(4744005)(186003)(8676002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzJ1aFNOQnRxTldxL3NCNTFnSGpTS2hlY2phVFphaTFiK1hBbXNuSHJYa29X?=
 =?utf-8?B?MG9CQi9wLzFNSjVwSVlpWGMwODZ0Mjd3VlYyZGdmaG9UUmZLbHVrU0ZBMGdt?=
 =?utf-8?B?bmFPKzZJV2xHQWh4b28reUZJbTZlUngwOXB5MWhVS2k0VkZtM2Q4MEpTNnZQ?=
 =?utf-8?B?c1VRbE9DdnQ0WHluTWpmREJTcm84Rk9iSmJKYlFtOVhXTUZoQ3AzUzFmTDQr?=
 =?utf-8?B?ZVNoamtwb0VPc0NxSDdMSDV0bGZzZC9FU0puUnI1dGltTXNydG91OGY3RHV0?=
 =?utf-8?B?ZHdtVnRIMFpiNkZtUXZvbDBRbituVGxxaFN1QlIyanNjdjFVKy9iYmorZFdh?=
 =?utf-8?B?SlVpUVd2ZGg2N1VIQkorY2lXVDFYdk5hZHRMZHJiM3ZFTHV2Y2o1elFoTE5y?=
 =?utf-8?B?aXFjWm12UWlJV01KdXlsUXlheTJkdHN1NStweWNySGhRRTNkZ2h6OStTL0l6?=
 =?utf-8?B?WU44VWdIa2xwT3pnTmFJeHBzb05RSlFTb3FjUlFsbms4SENJQW5PQ3V4ZDdY?=
 =?utf-8?B?cTBEN3JkZDZmQmZPRXFObHNIRFdTVmUyZ1FYR0RBUjVQQlZxUFMzNkVqY2FF?=
 =?utf-8?B?U2FCTFRwUkFiZDh0RzRQVHpOK3lQaXRSQWd4OXVRUDdHZ0VraXVDRmFqemZZ?=
 =?utf-8?B?cWluSStDSXY4Y2JCS0JwSzZVRGdNL3ozOWhqSHYzNWRDOWJCOExwbUt5Mk1P?=
 =?utf-8?B?akw4RmR4UEpRL2ovYk1vRVBqajNzdlIxamMyQnNxbTQyY3NDQjA0ZTZqNVM2?=
 =?utf-8?B?UVJ0T0JJYXZOMlEzOWNPRURqOGRqbnpTbFJQcHJhZDkrRDBqZEVuRXZmMXhq?=
 =?utf-8?B?NFRWeVVhZjROL0pIUVBwOUpwd0hYVXlpaS9TdnU2QVpMeHd4SFpPT3ZpTm90?=
 =?utf-8?B?SXBlbmQzM2hRWHBkeU5wVlk5TWptdk9qc2xVc3JvdzF1UFdVMDNueHJvU3Rx?=
 =?utf-8?B?TjVJeVVDVHBFMzROVHV3VkVJdCsrM0tpL2dsRXhEQlJPTWJLWWNwWlFzbUMv?=
 =?utf-8?B?cWo4dUE3emhoWVV3VHltY0lUNTZsRWx5dG11UFZrcThDdzVLZEM2ekFsNGlY?=
 =?utf-8?B?MVhWNHpYbkFKYis3alBQM2piRkowZFlVSnVyZFFQaGtBdUZQQk1iZGhGU21N?=
 =?utf-8?B?QmU5NlBRVHB2czdaVEo1eElvOFFKakFpWnRCaUtDdXhCN3M5WkR2NHNidUhw?=
 =?utf-8?B?QVBTUm1LSC9NNFg1YkRYbkVxOTY0NlUvZFVxanFDRW1Rd0pmUG1OSW9SRFM0?=
 =?utf-8?B?M3NIVlA0NzkrejRpQzhTOWFGbFBBN1IvdXIyQ3hmVEF0dmxQRVJHQVZPd1NL?=
 =?utf-8?B?V2wzMWNzWnk3Si9tZlkzeUJrdzBMeFd6c1FiQlYrOG1jYk5ZZFhOTm8rdXpZ?=
 =?utf-8?B?aVh1a2FYL0hmdGFEQm9BOHlyQ2huWnJXUW1rUEhWTThZZW0vd3Ziek1JN1VZ?=
 =?utf-8?Q?HlIbYCk6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7820cf1-bad7-43b4-2e92-08d8bf1c2e94
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 21:25:03.7676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XJKDBhVHM0SL9zReJKuOjMBTD0KiEpvMNW3A896L6QXNXpiGPRgZn96fyb84YLnyqD5qDary6E8XNqRzYIS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 12:31 AM, Miaohe Lin wrote:
> The calculation 1U << (h->order + PAGE_SHIFT - 10) is actually equal to
> (PAGE_SHIFT << (h->order)) >> 10. So we can make it more readable by
> replace it with huge_page_size(h) >> 10.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 25c1857ff45d..c87894b221da 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
>  		put_fs_context(fc);
>  	}
>  	if (IS_ERR(mnt))
> -		pr_err("Cannot mount internal hugetlbfs for page size %uK",
> -		       1U << (h->order + PAGE_SHIFT - 10));
> +		pr_err("Cannot mount internal hugetlbfs for page size %luK",
> +		       huge_page_size(h) >> 10);
>  	return mnt;
>  }
>  
> 
