Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75E2FF7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAUWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:12:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:12:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LIxZ3M117776;
        Thu, 21 Jan 2021 19:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/qAh6DDnHy/cBe5pE5iB+rH8qMEJYEfD7mX1DPMCZ4E=;
 b=K+vs5h1xy5nrK1kIvT9GgY7dxsRSBDmnyj58oKEjiu3bMei9hfSXxGcuD/pIetslK1Y+
 IYXmu6GRACpriD434iESGBtZVnWe7n7qIxTsEZWok6keG7NpfJs65Br/W+8vGSUahg41
 tit7uGYay9fW299Fz4EepIW/MqdMI8Y9pNiP/WgH/ZGwUEYHEZD/PeEEcMsEZhmtUJSH
 mC5QUIirbVANL5WwMjf7D6YtfC3baDBmPAI5btOLDDs3tYNGJku4Pu7yRda8yuCV4aTR
 +SiZbGcUf1DS1WYbAabnYtmdzxlQUk/YA6HsG/NXFuJjveRfWxW6f9n4BUhrYar7iXyO fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qagwjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:02:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LItlLO194032;
        Thu, 21 Jan 2021 19:02:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3668rfgeec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHduyWI/ne4AQU0ej6NSV8PSKkRZBZPvWrHpDM6Y+V4ayWKhj4McnPr8In7a6ZWuwUpETxcjDpIxILn4mnsfI8OZRdM2dQYSq88ZeFT7gI8b3IvMPMUohMI2KeNWP3q4kHI766908gSUiqeGXEFBWBmGD1t4/RtE5uFx7zJw4xfIXiORqXHGcWgYqAa6KADkp5RYCG9fUBQ7iPrkj67myR139a4+M+e27xqav6fqfWVzV80oaA3OlLSRxBYpMUle6dAHpp8LRodhh7E8Gz++1Zl2P5ilUgKjFI0nOxRq/pe2kNbUghd7VKDvhSFwVuO0bfUgQt8qfnju0hoazVV83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qAh6DDnHy/cBe5pE5iB+rH8qMEJYEfD7mX1DPMCZ4E=;
 b=aDW0NnB/bD720O11NEWp09kHPh9V+hDQ/nlcQUPUG/zGwF7aSjyZ/eW1+zQCvTnZxDFSVv06n3TlIgXgH7cP5gUe98H/mmw89yKg8BW1TW3ZFrfw5KUOenozmrdlXCCnJKrBy9/N+g+IHDqgoU5qkTv2CbUTZP4bI1me/5wAfbyrlXztOwaIcEN6bKZYyKp0KaI2tFefyCmW9kZCdn/Oat3KBlYgojX/GtRkvg/ET8taenOmIBCmZqzZN8UyQjOQHl0wRd1syqlK459TAzRzg+vueWCWr2J/nBZM3OZd2+PZwnewHa0ORsQgeQrbeiEruYblIufrhaIGEKRSZBmrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qAh6DDnHy/cBe5pE5iB+rH8qMEJYEfD7mX1DPMCZ4E=;
 b=K8NqJgAYA7oaX/JF6ipDeJd9kymijFyijUCbbUDByb4esqqKAUCEBYC26Acw3htZyIH9t+JapcBIJ8ppMRwcrTRj4ZkLefNropT3VevKlqQJPCal50Vp7eY7zTIvHVhmdq0joTMZ7ky8nnDxzBUOKaqIpyY9+9eFWLfT++2BWdU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2112.namprd10.prod.outlook.com (2603:10b6:301:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Thu, 21 Jan
 2021 19:02:41 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 19:02:41 +0000
Subject: Re: [PATCH v2] hugetlbfs: remove meaningless variable avoid_reserve
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210120071508.9078-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9d129083-e273-3278-b188-b55bfa2b08d1@oracle.com>
Date:   Thu, 21 Jan 2021 11:02:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210120071508.9078-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 19:02:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bc7e6fd-0574-4341-0b0c-08d8be3f20a0
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2112:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2112844E2EFADEAC3DF4CA4AE2A10@MWHPR1001MB2112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4aL0m2pcftMSSe4io09mguOavq4eNm65JEnTrkFtauprrcKkeqDFfEmDQvjUYcy5Bl0mEcLbG171T4Fzr+sQnhID3ZbgB29g3G+pxQiWwjJCBkyJOYgEC/UDn80kzg6u9XPs1TIzp1YqOOw+P8scFrhiURTeJTY94FUuvOYftXXtQmaH8cF09YuE5ZUlcD5IBdXJ6wreK8XgVVvO977gYjrt5YWIAHkw0ZqTSxYf38r1ateBVQEYpLtZPbZCLipV4xkL9ihPWSt/0vvu1uha6LqO4/u2sYprPS1hVua2WR7EARk8L+euB+94W4Lq6HDAzLRVr5rdiLvJ3ZF6phpsPg+ls1c/29HtYUtNQ853UiNsimE6n624YAeJDQvOq9te7MF7T0zAyXSly2hcngMn7d5r+fUx1IJ9SkN3yCiGsqfnlk7yE+01739wGKWIc7ATUEjMq3f13rBOG9Kw42qvPEjvAWOO5uLkf1yee0fAY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39860400002)(2906002)(508600001)(66556008)(66476007)(16576012)(5660300002)(31696002)(6486002)(52116002)(2616005)(66946007)(44832011)(956004)(86362001)(316002)(8936002)(4326008)(36756003)(8676002)(83380400001)(16526019)(26005)(186003)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?allHSmM5YVZqYm9MWkFQREpEWmFnb2tJQVJvVjVaYXloSVdia3YzVnNKK0or?=
 =?utf-8?B?UkNVVTJMY1Y3NlM0ZXl3dzZzazFZU1ZZVGl4TDcxWm9INWFqUjljOTMxYmg0?=
 =?utf-8?B?eVhJYmhtWC9neWNlMFM5bWZRSmE3bVZqanR3dGtLVUkyN1ZGdWtlL3ZiMUNS?=
 =?utf-8?B?ekpBZk9KejJ2Y3UybnNUSXk5OE92ME1ITHZDU0JveEJFMTZ0NzFUaGx2Wkd0?=
 =?utf-8?B?VUpVaGQ0TktQQzcyZ0tabnNubS9TQVhydW9DcGtjbk15QjdtZUJTVEZXbmpt?=
 =?utf-8?B?amlyb0oyWHN6V2V0bk9TeXU5ZUNEMlBJWEdKTm9yUVR4b1NxMEttVDhkem9E?=
 =?utf-8?B?U0M4ckVlcmhzK3IxbWZ3WVlRNU1YOERYOC9NU0l2MnhEeTVrUGg2WGtaOFMz?=
 =?utf-8?B?UzI4UWtvdjBaTnNOTThxUUk1UnFHeUZPL1FzemNQc2MvU01WcTdpM01DckY5?=
 =?utf-8?B?RnR5U0lzb0hOSGs2eFdJckoxQS9xbmMyTjVhL2ZJTmZWanVFZm42VzlSbTJj?=
 =?utf-8?B?UTBmOGs4V25STlExYzUvRWJNVGsyOW94YUhzTXlwRVRwTlVxSEtZRjJFSk5a?=
 =?utf-8?B?cFgzWHQ2c1JWbFpZcFcrSWJzTngzNEl0SmwxRDJSelphMUErbkJoaVZCVVFL?=
 =?utf-8?B?ckltZGZTaFZZQVFxaWNrdkllOGp4WkpxL0drQ1hQUllnZE01aStGWFJwMC9M?=
 =?utf-8?B?KytWM0JESDExVVhkTDhPL3hwRm9TcU1BYzVDdExqRS9nK2VTbnJxQ21wSldo?=
 =?utf-8?B?dHlIZ3k5cm1RUUwzVDdxU281NlNicnB0N0hDUlpMcXdHT2xqdmszQW1UQ2RI?=
 =?utf-8?B?b00yOEVQdUNkSjZEbHFFc1R6WDNtenpMSk9wUGhsMjNCVW1TaHFsMDZwQ2No?=
 =?utf-8?B?Q0RpUjdEMnZ1NXh4QXBNdG5nM2J4dXRXRU0yVktNVTBJQWhBZ0lnNlJqNXR0?=
 =?utf-8?B?S2ZNV08yQVdXTk5zbW1kcjJMamtoRHI0Mm0wKzBRSSszR0RUTzlweGlLQ3g2?=
 =?utf-8?B?eURiMVBVK2tVWi90VlNWZkE1LzZ2VG42SVJpbEMvaDN6Z3RaNCtPbmVzL1VV?=
 =?utf-8?B?RERVMUVwNjcvbEhtckNQWFkrUkdDUHFHa0kyazJWQTFOa1NLSUlSWHgvMitt?=
 =?utf-8?B?QklZUnRQUDlPN3cvZE9oUEkwNzRiWHdlK01sT2pmZzBReC80YStma29VNWpl?=
 =?utf-8?B?eVpkY0daRHFyYTNxMWdFVlIzSm9HRis2MWMzUnpTOG5LUUFZdGNnRnVSQ0Zv?=
 =?utf-8?B?cUZaRHBsRGVIckZsazhZQ21weEtRT3Jwd0txL2dxcUxZV1Q3UjlCd1Y5Yi9z?=
 =?utf-8?B?VzhXWHA1MFRLd0hBcVhxLzM3dy9aL0YydjlGOFdWd0FmaGxMZ2hUMzZ1Qklt?=
 =?utf-8?B?WVFsbzlKS2JhUzlFWTZjOUp6Wmx6c1FHbEhQRGRaY0FyOVF2ayswa055UXNa?=
 =?utf-8?Q?5zC9YCC8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc7e6fd-0574-4341-0b0c-08d8be3f20a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 19:02:41.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvh9PcTNyIUTAP3gi1FGosaK72cJminUUJGwFlTV9I8GZXjYaT6VWgi974fxBW05WU4pSHTRhmLgtozeUTQVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 11:15 PM, Miaohe Lin wrote:
> The variable avoid_reserve is meaningless because we never changed its
> value and just passed it to alloc_huge_page(). So remove it to make code
> more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
> hugepage yet. Also add a comment offered by Mike Kravetz to explain this.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 4bbfd78a7ccb..14df2f73b8ef 100644
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
> @@ -716,8 +715,15 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  			continue;
>  		}
>  
> -		/* Allocate page and add to page cache */
> -		page = alloc_huge_page(&pseudo_vma, addr, avoid_reserve);
> +		/*
> +		 * Allocate page without setting the avoid_reserve argument.
> +		 * There certainly are no reserves associated with the
> +		 * pseudo_vma.  However, there could be shared mappings with
> +		 * reserves for the file at the inode level.  If we fallocate
> +		 * pages in these areas, we need to consume the reserves
> +		 * to keep reservation accounting consistent.
> +		 */
> +		page = alloc_huge_page(&pseudo_vma, addr, 0);
>  		hugetlb_drop_vma_policy(&pseudo_vma);
>  		if (IS_ERR(page)) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> 


-- 
Mike Kravetz
