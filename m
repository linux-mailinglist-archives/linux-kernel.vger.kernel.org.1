Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651D2FBFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbhASTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:12:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbhASSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:42:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIZwLe185011;
        Tue, 19 Jan 2021 18:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3FfXZe10lmRh4s/JRan9dCqQKMLOmGR/D7Xo28OFy50=;
 b=EYCuiQlai8lmqaUAd6Bps1oqz/eS3nBtJQMNdn6O3W9+0yvryiPqp6/6JkCQoAr8x+HW
 8PH8YMm0gnVX25uGJ+lHdDMn0K7LWiv8rI/p9E1z1zvOjngk1lI2uBxtHuQp0D3rceqX
 daXUQDugoZGSfjUCw8l3AXJ1pThHTN+Em6z2vcTSzBM57SGrVO3UZn6nJ60pOUsAu582
 Jv/HeMCJKemHoqED4rVIw4ykMZYjRysRhRDMnyDgd98rp3jqVk5vaj2jJwIKIOp4+bdr
 QRQ0T+2ue0NalotVK9dMJs8AwuspAym/1iq6uwOEbFwuNSmsJ8cuFW3QrCuCH+5rwQd3 jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 363xyhsv8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:42:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIYbkG131073;
        Tue, 19 Jan 2021 18:42:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3020.oracle.com with ESMTP id 3661khnu0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGsiGt8c4SqwfVBjXrbUwkhK3/0aIKCSsjjwO62K10u3ETV7jFgKMbOnIYoy1/N0Y3k08BeGHkve7MtbDlGPm+S5TUWkVYN50EQd9LuMEKfbqeI0K1CMUoXI8+R0pk27VRcEL5xB1e9o4V17+VeOuYaK8/NflnqNLYeHMqX950SqwxoH0weWBK0DecdR6dDQD2caAIKXJdl10rKqGBcwybA/4ghFGa11HUgLe9jHi3U/emxVGcEm23vHAnc4DKP3kY2bCDgSpMi6Pcc3LNYZYBc6JbGs7VAUtjhI2t+btzO3yd7LBSYs8aPtNOBE21TtGtvHGwsUo7vHX22ir4XkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FfXZe10lmRh4s/JRan9dCqQKMLOmGR/D7Xo28OFy50=;
 b=UMw0OSoDJxI58BdF1j9Apzuxy9xRuj4/8qXIMRXA8Z3ngCDEL2/3VDNQ9Abr4A3by0Dwjyq73OrrxnlFuUbvDhV4oLsP0Yw794z+hLNYdzzAFGOX/GUwzsKHyEhstrXb1fuQhkQGIngUf9hBZwG4imfmq5lHOdvMx78wk8cC8aivRRWJRM5SllUJTTKAThEJy0YwF2p199tIWaS4YoAEbnWPGC/o1pFfCo0hgcu0CaOQG4GsCWOApd3bwm4EHCdhErSbBmJI/kFZh2CZreNgHegN3504fabMjjM9zL8N68RmiOPd1bzJLmL9dGWEePXXVbJBK1pWgumEWG3E8gj6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FfXZe10lmRh4s/JRan9dCqQKMLOmGR/D7Xo28OFy50=;
 b=V1iTLBV8aSDg5YlapkmSFvyCVbZeVCZHJDkGaLjX+z/lpjHsifjngOD4PhM5OMjorzCgXILAUtbZaFK/mlj8drr2CuCOHNKwm8xceSM+PF2spxmz4uPkrnVobjSpny42oUdNLwOh9rXjmpoCblqydujEJ6OABWxZLCdrMxvnXYQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 18:41:59 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 18:41:59 +0000
Subject: Re: [PATCH] hugetlbfs: remove meaningless variable avoid_reserve
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210116092644.42697-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2900fea0-e77c-8c6a-1529-c95ded5319e6@oracle.com>
Date:   Tue, 19 Jan 2021 10:41:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210116092644.42697-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:303:115::35) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0420.namprd03.prod.outlook.com (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12 via Frontend Transport; Tue, 19 Jan 2021 18:41:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 177a0edd-9d07-40d7-7b3e-08d8bca9e7a5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4435:
X-Microsoft-Antispam-PRVS: <CO1PR10MB44359991D852D632CA5254E5E2A30@CO1PR10MB4435.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RU5fNGNTb01tD+IDA+e200V3T9H7TnuB52QTZ/ou6edOGkT5PFhPNvlh3KXjxvRxR2JFKNi4VQHBVVenyHDGDdfuiwB14EF6IgzfYjCxvnT/DmL3enqlt9TWi0y1i+62kBbNjE2hlvJ1tyI5RKLrQgZhdS52ss6tns48of0B+C3tXU5BrEHrNDIdfqyDb/+1WsqqO1iIjG2utIdD8/odxHw5sPdFLpjCPG80IYPZUHoBCrzw6iIU8KwjmCAgsQOxW7qCk4uu0YVyWoLWXbdM7BeG37v1hZi3yVqUjtwO2bcuUTMql7JcjKQCPNQOY8Z4s8dnbywryPR9nF/LJ6pwTkMwiEMvcuT1bY+uxss/NjI1NpxFtVnaDWZpM30DpcNH4cvdFZyZDRS3/vHt4Di7boij3brovjcIlsPzaqM6hq3jS/+1OE2cZwxjIq86MQ5Hv11T+wKgxLkhHVLOo2YmrDMQ9PnzfeKlqefJWFu6D2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(16526019)(186003)(478600001)(53546011)(66476007)(36756003)(26005)(44832011)(83380400001)(66946007)(66556008)(6916009)(8936002)(31696002)(31686004)(16576012)(2616005)(6486002)(2906002)(956004)(316002)(5660300002)(86362001)(52116002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QU9xMXZQcFliYlYxdHFlbXkvQ3BjelkzUlJ0RDA1cTNLTVUyUU1Wc2lrYnpC?=
 =?utf-8?B?d2txQ3h3MFJkN3Z5NDVKMmZnUGt1V1dROTB0K29sb1ltbGx6WkUvTWVocXAz?=
 =?utf-8?B?UFpBVHRwQkdGQ0EzTCtZOHBwTVF0ME4zVExjWS9yQ2NPbjd0YjJVRjQvMGQw?=
 =?utf-8?B?SlNJbE5sTnJWT3ZsQzlLbU1HUVZMbmtNSE5nTWZ4enk4Sjk2STVmd2Ztd1Uy?=
 =?utf-8?B?YWJNSEp4TnFCb2ppODZtWFVxV21zeW81WnVjM3ZzakNPZmJ0U3FrWlVqMG9V?=
 =?utf-8?B?MzFpLzIzbUdDcDk0ZktTOHNCYmk5N0x3Qk5LR3dwQ1N4NXk3dS80Sm9TdHY5?=
 =?utf-8?B?cFdWR2VMMk94UDFpdnZUNzE2L3FsUEhCbldXbFhzWnJPazlCNnBKd1lUWkxn?=
 =?utf-8?B?WS9FbmRRTUFFNHM5bStZUWtHUkFlMXpqUndML0dCNFh5dTZ6ZGQreSt6K1Zo?=
 =?utf-8?B?bzhJOWtQLzRURXNJMlBCUTVIc2ZIK1RWOUVBYStmb3F3OXJCZFJjbmswRVdJ?=
 =?utf-8?B?SFpUcWI1c1RRaXFsN1VlVGxWZ1g1dDBOMkxIUEIwbExMdzEzc21tNW5rVjBX?=
 =?utf-8?B?aUZyYVBYNC83RXBucldFU2pha2c3SmRHeGtPUmFveGlJMDFKTlh2dW8vUGdi?=
 =?utf-8?B?WWpMUlgzRE9uYkZSVDR4a1dmT0FGbkZySW1kcDRwK2ZKWU4yUnZXM05XajN4?=
 =?utf-8?B?ejVyMWNyN1gxL0N4WkJjdjllYi90YmVyQ0c4bjY3RFdKdzFacGhPMnVLVDhY?=
 =?utf-8?B?bW81bi9RbkpJSWhaSkZyZjc2YXQ1dlcySEFWSXk0MW8xc2dFUElDVTZFME5s?=
 =?utf-8?B?cmFBdVdOOENVT3ZqYnI4cXRKVHF3NUdiWnhJWldYcjFxVTA0VXd6amY2VjVY?=
 =?utf-8?B?dVlCNzZ4SFFqWkcyc3M5ZWI5UFBYRExHMmx6eW1sbThsRFVUbXgwQUJEbjlj?=
 =?utf-8?B?MUs4TWxnbENuUkhKUU40ZFlnM3pDYVlyb0M1RDdpRTBsVWdPdmFWa0VVemFk?=
 =?utf-8?B?elJONGQ0YThYeFRGOEg0R2NXc0ZYbzFyVndmRDgrZ0ZBbEZ1bFg2NjZBZTkw?=
 =?utf-8?B?ZEZRbDdtNVpMMVpVOVJSdEhLcGJFZG9ITlFpYkRFN1pUZEJQR1ZWK09IV3Js?=
 =?utf-8?B?OUs3RlZnVXZEZkN1OFhFVy9BMEU0cTFSa2dGUnZDRjF1MUx1STRQaWdYOVh1?=
 =?utf-8?B?KzlhbEZFWTROL052ZnpFZW5pVHBvRkJTOXZOK0NHR0hyMmxjQ2o4bzcyTFho?=
 =?utf-8?B?YitxUEFDdWZrM2Y4NXdUbTVlZVlielZSM1dySVhZSS9wV0tjaFdhelRSQnB6?=
 =?utf-8?B?YklJdXFBN0I4cnZRSTc4aWtOUkprQkxZeXJxVkxXcm9VY1YrNmR2ckVKK0Rw?=
 =?utf-8?B?TXVVMkZuQlh2UVdYT2VBQU05ZEtMVzUrTXVoZ2kvZ0dHUm5yMFZZWitoaXpV?=
 =?utf-8?Q?2nzijciS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a0edd-9d07-40d7-7b3e-08d8bca9e7a5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 18:41:59.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkbbFXe/pCeZ8tn3R2Yk2Y02AixatwYD972TLnkoWlee7Z50SU56z3VPBq1EKYPgnYkgbgw1SIFkmRZEZrTd5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC Andrew on hugetlb patches as they need to go through his tree.

On 1/16/21 1:26 AM, Miaohe Lin wrote:
> The variable avoid_reserve is meaningless because we never changed its
> value and just passed it to alloc_huge_page(). So remove it to make code
> more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
> hugepage yet.

One might argue that using a named variable makes the call to alloc_huge_page
more clear.  I do not disagree with the change,  However, there are some
subtle reasons why alloc_huge_page is called with 'avoid_reserve = 0' from
fallocate.  Therefore, I would prefer that a comment be added above the call
in addition to this change.  See below.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 88751e35e69d..23ad6ed8b75f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -680,7 +680,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 */
>  		struct page *page;
>  		unsigned long addr;
> -		int avoid_reserve = 0;
>  
>  		cond_resched();
>  
> @@ -717,7 +716,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		}
>  
>  		/* Allocate page and add to page cache */

Perhaps, change comment to read:

		/*
		 * Allocate page without setting the avoid_reserve argument.
		 * There certainly are no reserves associated with the
		 * pseudo_vma.  However, there could be shared mappings with
		 * reserves for the file at the inode level.  If we fallocate
		 * pages in these areas, we need to consume the reserves
		 * to keep reservation accounting consistent.
		 */

-- 
Mike Kravetz

> -		page = alloc_huge_page(&pseudo_vma, addr, avoid_reserve);
> +		page = alloc_huge_page(&pseudo_vma, addr, 0);
>  		hugetlb_drop_vma_policy(&pseudo_vma);
>  		if (IS_ERR(page)) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> 
