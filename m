Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E832FF5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAUUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:19:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47674 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbhAUUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:18:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LIwj6U014269;
        Thu, 21 Jan 2021 19:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QNBU65gmfBQoGvPM9Lfq7uOv7pwAPlni+8r4mg+Bwt0=;
 b=UhLkgXgiDMR9QL00NgS48zlS6RLJYrbp9JQMKiZ6rZ7vhaICBkh6fYA9FXRufOFRTznr
 yC2ETbmRIZxNeH325o61q5fesB/spR+nXmbaMAynBxjrakUSSMmtDu1THGt2+U08qa4F
 mYe34ex340UpJr/oDITkVZFdddlAqh4IxXVnSqn5FmmKxyQ1oSRndDd4RHlWfIVRpccX
 hsj/AByB0sLIHnu9IYAuQOTyfIi8CRy6wNM743Izz9OCzSoSoh+rPVqtsSt5w6PpOKp3
 hQ4IbMcIigVzRxzQK1fe9As+vBNkjlTSRvZxSRRFuH6Xn6VsewJzuQbxOVsHIxKfYXz4 Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3668qrgwaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:02:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LItkjf193905;
        Thu, 21 Jan 2021 19:00:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3668rfgajh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 19:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg+FH92CdskNlT05E8jiZc2HDkDuwegkLD77OqbyKvlVeSqmn1zEJt3mAI8z51CdETx2j988/K8cRqm4cl2BXiL/YObnkcRmtVwxcm0W3JSsbTGdfTlj7Je5dUdkTDiX0EQhJod2ZBQV8avZc0js62z8Ih9cIyQFK9LN49LXUvjkf1+W/ZBxoQVz8vc3iOmlEjWvonfovFKjaxnj/hxkTTCft+QO9BD1oYbjstUlztlKjspzrTyKDbOcxso8Ks4NWAlmiPDhSu8VBwxGNxfNhRFL4Y34nuQ6FhOmON/NR2+5j4Aje34fBmGtCzbj9R3/RzRI9gi7K2Lt0FEThTihgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNBU65gmfBQoGvPM9Lfq7uOv7pwAPlni+8r4mg+Bwt0=;
 b=GGm5VGss/+EaJ0DFLwth7Md34c1EzYd780iVESbi9HDq29DE+ONc14xKKE1PADvl9vKcBHKFY0a24KlqK4p1BDzFSz3mcZ41P7067297ZXO4FPcyTKsbPDJP8Qgc85HxmNOQjHKaW+sKA5lDewUgv0YbmeKjpFUAXkOdGM0l9OzRwiy2kWI1abXJ3CGtGqF0zWxP8klkrHsk/Jfdaja6kzWl6ow1L1pLkdLRPXKfuOXE0Gri28BwYyAvRv+bpigUzD8dcNXlBUxGVbqewFFp2zJ1fx1wZ/64f5iHiHhqedm4vQFe6tjpBXS+GIYVnHAd/Z9oXIwE6/xLV2bMhUzV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNBU65gmfBQoGvPM9Lfq7uOv7pwAPlni+8r4mg+Bwt0=;
 b=Tq/ucDkVU+X9MCl0vtIuWXTIRAg4Vtbmcabya/kZbY9JDJVDy05h6K1vrRCMFyeRuLc+SdrMQrAC60v2R2a6nW3ngWNnnrLF8b++G03ImCLIxwZYotZ51uh3kbV/C1XqJQI4236T/nOx0BTDO+0R6cUswz+74PsS0F9qtWBTCOI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2112.namprd10.prod.outlook.com (2603:10b6:301:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Thu, 21 Jan
 2021 19:00:19 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 19:00:19 +0000
Subject: Re: [PATCH] hugetlbfs: make hugepage size conversion more readable
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210120092348.13811-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <668845df-e654-ecdc-c32a-b50a22098333@oracle.com>
Date:   Thu, 21 Jan 2021 11:00:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210120092348.13811-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 19:00:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c619f4e-d200-4dda-ba4f-08d8be3ecbd7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2112:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2112CBB2AD0E115CFCDC3980E2A10@MWHPR1001MB2112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o17mb5fD1XZuZHPiXP7piqizMHOd6PLT6c8w1QWkoe2SkFWTEZQBU+MlaJWlUdcGsYxxrlvt7dFjOcBOKVNLzJQGnFHEEzvBiMO6BqCrHHM6ejk9yhyq8pk1t7buXIi6Z2+UHam+sSCOplHbOn2pgzo/R9QrSVKA8aQrVjjWagZA1NYm9nb2B7u8BgWylYgWIalkrRQ/Z+1AudSsxRIByaollsMQyW4ANGxW6p+qYUw6WRJiRz9iwREw3JNoHa6yD4cDBXNrXOhlcmyhnppBH+rbFl6y8ysrf5CvS77cY3/adhCjajKWmZViIvf94XgjndCB2qEgwTZEy40S/Xj8VvcwtoMPEfNJqC61jWnQSGRSfEniKewvvYuf3nfV92kD291TtWhK7URtrFCd870QPPoPKJC28t9jsrISNUj76fghOpuhQ/WBBZ3fQEoxeLtP78qkO7f+y700ZGEudAhXaDegd0a9f9aCoeQed3btkDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39860400002)(2906002)(66556008)(478600001)(66476007)(16576012)(5660300002)(31696002)(6486002)(52116002)(2616005)(66946007)(44832011)(956004)(86362001)(316002)(8936002)(4326008)(36756003)(8676002)(83380400001)(16526019)(26005)(186003)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1BaQ0ZXdzF2SnRQdHIxNTQ2cTFSalZJU1lJeTBkNjY3cFVKWGd3a2lyditY?=
 =?utf-8?B?dkNybUR3NzBFczlNbkJRVEh6T1VjVXp1RlhMKzAvL0hoMW1Pakh2TFZJemFR?=
 =?utf-8?B?elJQaXhqWUYrb3RJM0FRM2V0VXBJQmdjdGtxd1h6VVhrTDdER3F2QjYxYWdw?=
 =?utf-8?B?WUhJVGFwKzlrVUtJMnoyQlF3cExCbldKK2t5U29qQkV0NHc1NHRZSkVzeThn?=
 =?utf-8?B?dW1JbnNaY0pzajFBYVYrN2JWanJ5eC9VUDduQWxrQmJRM085YWpPUVhnOW5N?=
 =?utf-8?B?b0g1dUhCYjVQOGVpaEFsdXF2M3FEN3BobHBoeWRGNm9UYkx4UThZbWE1eCto?=
 =?utf-8?B?TWExc1B1V1RyWENHTTVmMlBTdG1IK3B5MnRCangzR05lTXBJaFFkNDVHdms3?=
 =?utf-8?B?d2hEM1lua0tkVEp2dTUvcHU3SlJRdnlnV1FIOFhuQXJ3QkFlRWdjcHpVRGVv?=
 =?utf-8?B?S21OQU5EaUttMGxCYnQ1WUg1eHFYTGRWTXp1WlBicUpjTGVXOVcxT0dUQjJL?=
 =?utf-8?B?bkQ5NDFtK2Y1QjY5TURmNHgwME11bTVEdFFiNUhaWHQ0cnlJdk0wSGJPUjRm?=
 =?utf-8?B?RWp4RmpVM0toeHdCL2xzN0FjaHY0UUloRWpxVTFDNkd3YnJjN2UwTW5TRUQz?=
 =?utf-8?B?bzlkQWdmN0lLbHNPWmJDaVpqdEtGQ3JMSnYvUVJNTkxKc3FBZHhhdWhFbEdY?=
 =?utf-8?B?QWVhQ2Q5cDB2c084a3FxSytvVVB3dklkcFYyZU5UZ0FYUHVFZVJPQzZiTUZY?=
 =?utf-8?B?R2UrYWFZdGRHbGgxL083Z1p1S1l2MnZ2VGRBNFNGd3dvZThnaGoyMHRES3p1?=
 =?utf-8?B?OXNVYUgxVFlaSk5vZkIzeVhnVmV0YWhjS1dTV2FsVkRxNU1RVXBOZks5bE9I?=
 =?utf-8?B?TTlyREZ4aTIvTnZSZ2E0d1lzcU9peWJ3ZzJGUFdtQml1L1NUSVhOd2I3UFR5?=
 =?utf-8?B?RFAyZ1pIbzFLTGZEWmJzeW51TE92VXN5ZzM4L3FEbDkrSTVTaDlWaThFVTNE?=
 =?utf-8?B?c2JVTG9IditoOWViejVXNDRzKzA0c25nRENLOWV0V0U3WTIxYTJoTzhnTVFK?=
 =?utf-8?B?TWFCKzBOcUJLM2RMTzJWQmJsdXNWRUZITVZvekxyRVBTM1d4ajhkL2Q0Q040?=
 =?utf-8?B?NFFnU2hOL3dJemxaOGVnWkQ3OURkblBEVm5ocStNekdlUitMTVpjM1hFbUdu?=
 =?utf-8?B?WXpaN1VYeGl2UCtvTy9aSVoxZXRVeUx5aTR0Q1Q3dmhUVjlick1yakIvTG0r?=
 =?utf-8?B?WXQvRC8zTkFadDR1RUt4dUNTRHBjL0FRaG5LeU45QTlaNC9QOHEyMFVtbWlH?=
 =?utf-8?B?clNSakFDN3gwOWVGNjFibW1BNGpvOThpZmtDcUxWZmxESGU1eUNJaG55NUx2?=
 =?utf-8?B?V1hlQnBsb1BTVWQ5N0hLVFU2d0kwODF3c0hGN2lBSUoxemwvOXVTcnJoRmpK?=
 =?utf-8?Q?f2x5uL5W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c619f4e-d200-4dda-ba4f-08d8be3ecbd7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 19:00:19.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0C/JkFAnu5ESlJtnccgtbCHjaCUjqdLXeM89ZzZ3N7E9YW6j8OjSAiWVp9L3IXdKa+INlvoVLBcjfp7tT7RPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 1:23 AM, Miaohe Lin wrote:
> The calculation 1U << (h->order + PAGE_SHIFT - 10) is actually equal to
> (PAGE_SHIFT << (h->order)) >> 10. So we can make it more readable by
> replace it with huge_page_size(h) / SZ_1K.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 25c1857ff45d..f94b8f6553fa 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
>  		put_fs_context(fc);
>  	}
>  	if (IS_ERR(mnt))
> -		pr_err("Cannot mount internal hugetlbfs for page size %uK",
> -		       1U << (h->order + PAGE_SHIFT - 10));
> +		pr_err("Cannot mount internal hugetlbfs for page size %luK",
> +		       huge_page_size(h) / SZ_1K);

I appreciate the effort to make the code more readable.  The existing
calculation does take a minute to understand.  However, it is correct and
anyone modifying the code should be able to understand.

With my compiler, your proposed change adds an additional instruction to
the routine mount_one_hugetlbfs.  I know this is not significant, but still
it does increase the kernel size for a change that is of questionable value.

In the kernel, size in KB is often calculated as (size << (PAGE_SHIFT - 10)).
If you change the calculation in the hugetlb code to be:

			huge_page_size(h) << (PAGE_SHIFT - 10)

my compiler will actually reduce the size of the routine by one instruction.
-- 
Mike Kravetz

>  	return mnt;
>  }
>  
> 
