Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A62FBEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbhASSOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:14:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38462 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392553AbhASSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:13:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIAE7o064415;
        Tue, 19 Jan 2021 18:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PPT/RnVu5j5a3dtK8YVjDgDfQnb/3bsAA8kYB1uISOw=;
 b=ZL/XZMFk7gjtnix/GXhTt4S4plb4+RRWFoLjFzZlkbTU6uRBMft3ApG9tP8T6iMLxmuK
 GQLMdz53iQDQVFiSwlI7L5l0DvW7UQ8vnXtpZz1Qsys2ptbRVyeYRxeN/YMjqo4b2V4i
 fcrnU1UHBtzAHYoQZmjMEXPfp+AjYNo9aS7LxXtV3IqwuKh0IDhr5zqk5/elE9ObKje3
 qISRwObMuslPTniSj9hww2llvBqewHpc8FFdNSCm2PawbamPe6mBR009xYZH1w3Ywe/i
 8Bc2Af9YO019mXQ/TMg1eom9eyINZWHBocdUV/6pogLF+BfSqmm9RwIW9eQ7q+BdQ3RY Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 363r3ktc7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:11:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JHndca193482;
        Tue, 19 Jan 2021 18:09:58 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by userp3030.oracle.com with ESMTP id 3661njmd0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvpRudbr9cCorKuWBxRiiBd+IETQPtuHnzM8NfqQvpsSz2/GQ15fxGa05OgKOxJ0V8uh3Wkbi3fP3wPlsiBJsFQaOXXtROKC83wq8+6FzbGjcENeIrfeYZBPBStSuNRYcLeLJkbYE8w20CQA+2FRSvLstMeG0D0k+08VmX/1p5L9ZnTPPGTp/c7MP0nIGSIoV3cMnxDrOTE2MeGWse3iQ3vUmc82EhzyaWJkszK5yPmhM461fUCaKSmXEmX98B+xxTfF6x6GvGXPphXGbKlkOfD30HyvZeT9g9C8e3waiFipu4KQ+rs45NFW8mrwilx/m31R0EYP3XnFDRiEQBBzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPT/RnVu5j5a3dtK8YVjDgDfQnb/3bsAA8kYB1uISOw=;
 b=NJ/sXYXntf8QQ9O2SpAmE1on47sQXOFIxhcMqDXzkCLhfgfiX8l3RspJpxwV3BJhW3Q+de1CDUhFSVH6I5JY2kRpZDbA9BhN/HpM0WepuuGvOLQR9N9sAX5JjDfmcfdj1CMkyhM0/WSji4CoxiDpS8U83FLtXW7xrh/xPPi5c+iLNqq8OWUJF6xySxafpa9EYRGlEIWL/iBteQOn6CHFaXzq1fKh+kVE8SuqOhC9m3gQpzEV8oaZE/q/PcWpXSiTTIPxFVh5R6EAzdYj4HX5T+9GTHXakVtSdbK+LKpLWbfVwahDUMjqElwSIC8yYgMOWzpcmGvGeRA9XlWfp3CwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPT/RnVu5j5a3dtK8YVjDgDfQnb/3bsAA8kYB1uISOw=;
 b=RPviUES3GDrmMhrVReseyWpdkmJ/8R3HL9LwhfNksWTDIgfZ9BsEvCb+IaNGuCacwiPXZ0Y/jY9YG8C+tAjnxQ3CLw2YWSD5XVBYbBsRBBz0T8ABvDFv/gaPT/P+60+t+Xccda67+Q52NIwkfot8ttyZtBVsEbfQmUW47TpZ2ZI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1853.namprd10.prod.outlook.com (2603:10b6:300:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 18:09:56 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 18:09:56 +0000
Subject: Re: [PATCH v2] hugetlbfs: correct obsolete function name in
 hugetlbfs_read_iter()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210118063210.47118-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2d4184ab-1c8c-5d67-2367-bd07f1d7217e@oracle.com>
Date:   Tue, 19 Jan 2021 10:09:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210118063210.47118-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0149.namprd04.prod.outlook.com (2603:10b6:104::27)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0149.namprd04.prod.outlook.com (2603:10b6:104::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 18:09:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc3666b-56c7-4334-5959-08d8bca56d34
X-MS-TrafficTypeDiagnostic: MWHPR10MB1853:
X-Microsoft-Antispam-PRVS: <MWHPR10MB18534C6E42ABCBC6209497DDE2A30@MWHPR10MB1853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXo4LA3R8MqN5BX+psGetV0rCwWnDpgJ3EINUIfZbhbXAzNvTN8lRPiIAtw5JDKiuV+RlT4y9Pn8XjsMef5G2sEUp9Y1n+6NX167tjg7fx9oClx3I3S72kQMN4wpHYd30X1wojwO9EMFNehEDNDEdWLZeX4joUfbzVQaswLkbClH0P1IeQ4Thc0AOXh6KQZHIZKOUubzOUlMPrvWddGCkRX+XSRs7V/Vt6XeSzYPt/K7Tp0UuBE99DQDbqmYxd6FauH9UTE0iZYOBxGmYmgljtbMywTPvR1qa2MbZ+VFAx0sCA+yFGOT1xHlt2cFrFHrVlt5r2m4C7+FdWOqpieQCdn260O+Too3VezVg52WgFx5RLjAkdD9/ksahWk8L/k2blb8B/1vYLiB0wZbrmDVkG6wyWCSvN3VGnOryI9Muh2qH8aOeMhivXnMpeF1Mf7cGofDRqtfjpjkVeyZ64sFa5s55eVNeyM0zfhbutmRzp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(16576012)(478600001)(16526019)(2906002)(8676002)(6916009)(53546011)(4326008)(186003)(26005)(6486002)(44832011)(36756003)(52116002)(66476007)(31686004)(66556008)(956004)(86362001)(31696002)(83380400001)(2616005)(66946007)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dUpuTDN3NUdzTElwLzVzbkNzT0wzMkxwZ29pQ0FvN29OTFJUZjNaTjlleTA5?=
 =?utf-8?B?U01KTmdDRmwrbFowUjIvR2FQS01udXdCc1FOcDBPTXh0Sm9nWnJod1R4WVZv?=
 =?utf-8?B?RnplbUFzOW9mMVdnWjZTYUR3SkEvVWkrSVNBOXYxcEIvMFV6Y2JCYnJueXAv?=
 =?utf-8?B?bjEwSllXQkhiejdmWWszS3h1VXRsMlVla2JNN3VwMmc1NXZXa21xVVZUa1FI?=
 =?utf-8?B?cEcwU3ZBQll1SWJsMUZySktJZDI5OGI3bWpRai9KNEtTNk9TVDlhQjViaUt4?=
 =?utf-8?B?R01XR0lNRjNRQytlcXFYcklMd2xoOEkwZHpUSmo1a3g3M0UrOGJqL3JJRTk3?=
 =?utf-8?B?K3lQbnJTL3VYSEVpQ3llRUVUTUM5TWRuTVJBQlNIRlptamJIS2FQWDQ5M1da?=
 =?utf-8?B?ZkM3VjZRZ3BkZW5hcXJCcUtNNVBiVjFZZFc1bFBiTDVaeTdzMGtSLzE1RUph?=
 =?utf-8?B?b2drOVEyV2dCekM2SUZLQ2xPSUxSU09NWWgvRVJyWXNNSnFXd1VGUE5OVnJ5?=
 =?utf-8?B?NXBxakVIbXZLZmVVZ3ZWaURJZlRkMCtvUVVBdHN4aGlyUzVaZUN1UDhlY1BY?=
 =?utf-8?B?bERVeVE3ZnZnd1YwTXJ2RVpEYmVhQ1Rmdzk3SjJHUEZ2bFZNd0xBWExINUJY?=
 =?utf-8?B?MmJIUi9OT0M5Z3QzQTQ3S1FqeDYrTG50emQ4Sk0zWWJaSTlaZ2UyMERnYktL?=
 =?utf-8?B?S0tTT3JRMWxPdnplVm01M1lncG85ZHJFTUFDc0hXNkh1NWVqTnUwN2w3RHBv?=
 =?utf-8?B?L0ZVdEtpM2JDYUp3Z21ER3Z5Yjc3NzZMMWJLVXJEdk5PWXgxWEp2ejF5MWxz?=
 =?utf-8?B?NDNMNlFudjhOOC9hZkdhLytYeVRXdHJsb1FZb0VXUU9oUURycm9RMzI4a0dK?=
 =?utf-8?B?T1o5L2djMDVPcml0dzNHWGp6UU9EcFgrVm4vLzE5bWlXUFdCWlphREJqMy9G?=
 =?utf-8?B?VFYzTlF4T0FadmQrWW5BMEFvMjNXRUFLV0N5S21ldUtHaE5vWTVvblhIYVQr?=
 =?utf-8?B?WEpJWTJOakZJUUh1RXloL1NGem50SndORWxBTmF6ck15Q0FjR3pDLzhSSlNZ?=
 =?utf-8?B?NDdrLzNnT3lpOWd2OEhEUDB3QllON0JERElGQzQrRkducWk3REp1YlNZNzB6?=
 =?utf-8?B?OW1kL0VwMkltL1JBS3ozaHpudEZweUhvQzU1YjdXTkVUcXdOa2dQZitqNk1Q?=
 =?utf-8?B?S2xmYUpLMXFzU1o0L0YrRC9mU1NnSWJvOFNncHdKZ3QwQlRDUTNUbnFkMDFP?=
 =?utf-8?B?S0pSOTBwbHZrQ29TNVp2Y0w2NmZJdlBrYWZyTStmTWplOWJIOTBrNVZZWlRG?=
 =?utf-8?B?SFdwK2V4ZGxYZ0ptMXBXN1U1dThGbDVWbTByU01uZStZV2UvR3psR2NwQW05?=
 =?utf-8?B?cndUYTdFUmZVc2xETFlTR3hSa29RRS81TkRYK1dBNGRWek10cTVlMmV6ekQ1?=
 =?utf-8?Q?Xr/Qaufp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc3666b-56c7-4334-5959-08d8bca56d34
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 18:09:56.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej8cX8H/Krr8JTifDN//l4FIPlg1rcxq8SFq9hM7EjUZvuT/gXOyH40RGXOq2CANFvZSqxhOCOn+R7bEij/y8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1853
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/21 10:32 PM, Miaohe Lin wrote:
> Since commit 36e789144267 ("kill do_generic_mapping_read"), the function
> do_generic_mapping_read() is renamed to do_generic_file_read(). And then
> commit 47c27bc46946 ("fs: pass iocb to do_generic_file_read") renamed it
> to generic_file_buffered_read(). So replace do_generic_mapping_read() with
> generic_file_buffered_read() to keep comment uptodate.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 23ad6ed8b75f..d02616513b43 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -310,7 +310,7 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
>  
>  /*
>   * Support for read() - Find the page attached to f_mapping and copy out the
> - * data. Its *very* similar to do_generic_mapping_read(), we can't use that
> + * data. Its *very* similar to generic_file_buffered_read(), we can't use that
>   * since it has PAGE_SIZE assumptions.
>   */
>  static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> 
