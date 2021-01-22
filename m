Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD12FFBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhAVFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:03:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55372 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbhAVFDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:03:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M4soCv154235;
        Fri, 22 Jan 2021 05:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R2+UmoVaLHht8d4GAAM1hQsMwPS66TtLKFHwl3892Uk=;
 b=hR9UOU1o9y17Ib/uMnAShYKUpvmAgS4ZEJBqcfDNOMK5wt+iezniyIoGwWGD5WjL1o90
 y8CE3+mIYWYSxpe4isS0oEE9S5fTYLPt45CvIiD/SFDM7Mh7p8sgi4x+D6VNwio6IRNc
 7+GkYyoiwxjZs9KTBqA7y+xln7Sc0Kg5ZCyLlik2zvvUFraYXmOMQS2IoYrN69n9R+Co
 HhvGxr2P+nYg6jGZUvQqFh9oAyeLWDHywj0RbvbQkNBOoYFOjA1EJ6VrNssFgTGDBGFx
 w+iKg9llhXSi2RzMWfO+fX/5DKvz2ujjKH0XX3yzffMYcIVN+ENDozgSXQSWVBMdMMD+ Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrjdge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 05:02:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10M4u2tv032649;
        Fri, 22 Jan 2021 05:02:13 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by aserp3020.oracle.com with ESMTP id 3668rgxdyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 05:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krn0LbneEQd/cpVVbzgnhTfh62cGikRSf6eRLsLiiEbJWFWTUM62VEu1HCyoK1na64XLXxayTwCqWpo5rkz05+TCltEJJhU24wftMxNEyFD4FypnO/Bi2rGNhitBdljJs3scXg18PoH+nLyrM7nvnw8hj9zb1CKGotFc+0ehnWZcmypH6Kb4pZtlH6J9fpa88fskRu20O8QPzVdIxLjno7z1b1a5ZHTazUKvbdiNNEcYcLxmxC+RWfUX28cjvEEhZK+kLW3b9rx2ASEKXJx8sGYt4INJI5u2lo79/5cpmUYPp0bUk0J1VlvzNpsMeyRm6edzwKEvjMimOgiBaw4/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2+UmoVaLHht8d4GAAM1hQsMwPS66TtLKFHwl3892Uk=;
 b=J6JUMr1b2hG9ID5owZAaXatim985EuqdFQNLPTbTICGY8H/5TO1bXauYyEZ/YXk/qc6qzKfVOByrEsy8rnLmWmhaFk/iHUqU4icEy/4upC1oO7Ows5qmWHKp38wOe8BkxeVKaui4JY3VRSQaYC6XhcvOsfPovmvmFVb2Dh4V1bvM3grUQyXUa3F8oR+zkf1rUoCfSEjhmyQxhicc1fRe6vxo3raMv9IhLc6PPU3t5/EEcsalVZLt4NTHHC8BKo6KO9GzkVzjSYUpsOhC45rhnO0jYtNfv31hSm4kX4q7c5qaC4ssXAPsDNqvWhzExuQ3CTYC7Urj1T/ycztgwAETXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2+UmoVaLHht8d4GAAM1hQsMwPS66TtLKFHwl3892Uk=;
 b=wvT/tFNqTO9JanrqHKQpYy33ds1uKFJsI62Uv8NZ3ve79BEg9wVEcR+Rx5XHkCm5Rkv9YWhD9sZI/UGClSf8f/Pe9fCy64LzIg2y+zJnYj/WU5i/zRvz3ZyMObV6XVIwYTyaFql5nDo095X90/GGfVm6ZSJ2W7sR6Zp7bR/rHZE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 05:02:11 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 05:02:11 +0000
Subject: Re: [PATCH] hugetlbfs: make hugepage size conversion more readable
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210120092348.13811-1-linmiaohe@huawei.com>
 <668845df-e654-ecdc-c32a-b50a22098333@oracle.com>
 <65c34b40-7c0f-6102-da3b-586551b50453@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9696d9e0-48d7-871c-6ec0-ba6a31c346bd@oracle.com>
Date:   Thu, 21 Jan 2021 21:02:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <65c34b40-7c0f-6102-da3b-586551b50453@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0035.namprd21.prod.outlook.com
 (2603:10b6:300:129::21) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0035.namprd21.prod.outlook.com (2603:10b6:300:129::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.0 via Frontend Transport; Fri, 22 Jan 2021 05:02:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cd539e-91c0-40e8-7494-08d8be92e037
X-MS-TrafficTypeDiagnostic: CO1PR10MB4740:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4740A92ECEB00D3999E27360E2A09@CO1PR10MB4740.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWpG9aCgSRgxzzpF/+ECGTFZpt7mP+F0ACTf0m7hfCRNscn98XyhGN8eGnQBNXqec6k21C/ErKDmXbOmxKHWKGU4+n8l7aLLePQ36AZc2qKPJ9RDxneZXWVAMPsVoYpB+ewt0VVd6wejPP9591tAQgaF+jLhkQtqF/BbhZ9fxAlNIFm3lVBkg8r8x2+KWKhQ1fZE/dP/AeTMfA4KpAlqZD/xi+8LsMssQ0VBFre9P1OEyu83CkBpzgLc0yRPWrRRwDtv6rdlCmcNwPq6e7TgDbiO5vPtjxf+CmxRQaQmHvcjI+T9UnPgMP1rjUZfqxWsC9yoGelQ/Jy1j6DiQgT0J0wmFSOnmN2FpBacqQ6KcKFpfd0kV9X/SOePbMG0Dvs6jr6WhdTNRBKMXDWJ0dyc6fWhn3ljhCPs+dniLVsCWAy+DqP4sgn/9QIsfOfRPlgCJ95Hr1ozuNdHzIE8YfeKMH6BRpG9h4PJ+lxECJGtuRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(2616005)(2906002)(6486002)(44832011)(956004)(26005)(53546011)(8936002)(31696002)(8676002)(5660300002)(508600001)(16526019)(31686004)(66556008)(36756003)(66946007)(86362001)(186003)(52116002)(83380400001)(6916009)(4326008)(316002)(16576012)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0pVdTk1N1JTMUJEdlZadGx3SGVseklJRS9rUzhWSTYyNEx2aE1maktrYzl3?=
 =?utf-8?B?U3QzRUFXU1VhVXhnOXhJQ1ZmdHZzUDljSkw0VnE1OWlqaEV5OGRMemNYeTNF?=
 =?utf-8?B?SktpTGd0cnh0WlV1bCtMajV5T25XT0FGTkxtWHNYUkh4dTRYWml4OU5nWkxF?=
 =?utf-8?B?azdLb0N4VVVIcUNlY1VLUTB2V3hjSFlLK1Z6TlZLcEJyUll3bm5uU0V6RER4?=
 =?utf-8?B?eGtOa1lwOG9ldGtOMjZzSzlkSmpxTTUzOU1qS2pyODhYRUlhSU8zRFNUdEts?=
 =?utf-8?B?UThaZklMTThmdlR4R1A2YmozejY0RFBnVWJkYW8xZ0l4WTRxcEsvUVhvSzhS?=
 =?utf-8?B?MTI1N3ZlSWdzZmFQTFhBSEJCZUVSMWwySHBmaVNrWi9iU2dXQmR5allac0V6?=
 =?utf-8?B?U0FKSC95Z3ljUFB3Sklzczk5WHNabGpud2pEQ1NoNHVDSzdrRHcrdHNXSzhT?=
 =?utf-8?B?T0RKKy85WWpROVNqeS93OTQwYW5OZzc3NkZ0ZW1WaXRaS2xvUGNObVpLb0xI?=
 =?utf-8?B?L3dUam1PeWFrK1NMc3FhWE5zL2ZVa2lubUl5YVBrSVlrUFNnb096Qzc4RTV1?=
 =?utf-8?B?R3VzS0xXeHE0QzU3eStEU3ltMFJpaVZrbzRoZWNmMXlOWkFBWHVicGs2bGJZ?=
 =?utf-8?B?WjRUanZqM1pVVmsvQUN1c21BcGl3T3NtZWkrcitkblFoZENGQVdZRWtUcjBu?=
 =?utf-8?B?TVprbFUwZGJ2alR0UWdLTUgzS2NHZHBxY29YVHpCd1ZkV1RVUDBYMXNjSW1H?=
 =?utf-8?B?OWFZUlJWOE11WVdGOXJhd01MREp5bVF6ZFFYd3ZIb2VMTjhiWlRoVTBTUjIz?=
 =?utf-8?B?MmNWSU0xVnhKRnVoM2cyTlJwVG1nUkw1TEU3LzNEMXdEdGFwaERKSDlGa3NI?=
 =?utf-8?B?MVBlZzVqUk1vSTRLM0s5eXRpbENwZXc1YzYzN2Vid0xaYlJHdWViN3lJaDh2?=
 =?utf-8?B?ZjdQNDVmOVp5cDZQamx4Tmt5SWxUOTFpOGxoOXUyVS9YT1RoQmprMTIyeWpN?=
 =?utf-8?B?OVlMRjdDV2RRVUJSNW0zV1g3djZNVDh1RzFWREdPS2Vhb1BlRzNWL3lidUdM?=
 =?utf-8?B?Vk1EbEtBNUNOYVNWR1o4VldxRmlrektvMHRrbE96UjhNWE9QbDh5cXRiYWkz?=
 =?utf-8?B?RWRWNi9CdjVDZXVqZ1lpd2FEdTl4aC9PTURNQW9kVzkzTWcxbmpraVZoRDJY?=
 =?utf-8?B?Z3M2a2xyMUVVaWtkWnkyUzRNUUM0dGtyVTBESUhtWWp1VkovcUNDNzJxdWFF?=
 =?utf-8?B?eTFxTTRyYWViMGpnVFJQOXhpVzhrS2tJV3lHS0craHM2M2diVDJzYk5TRkJi?=
 =?utf-8?B?K0pubFcvbC9Yd01rc2JxYTNIR0VFZHNjZFBJcUlURHJJTjQxYzN5ZzgyNjQ2?=
 =?utf-8?B?RW9rTFNQajhaaXBuNzZJampVOGxyeWVDdGZWTEtzbGp3QzVtRUNXT0lSRW9G?=
 =?utf-8?Q?lXEhznyA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cd539e-91c0-40e8-7494-08d8be92e037
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 05:02:11.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nENV3KDnGM45dBiflIMZYDglyb+lyR85hJ84J5ujqsjVgyCcGbqgWqjQDNpbs9riQb/xNZjFwmX0mPwOeC0vtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 5:42 PM, Miaohe Lin wrote:
> Hi:
> On 2021/1/22 3:00, Mike Kravetz wrote:
>> On 1/20/21 1:23 AM, Miaohe Lin wrote:
>>> The calculation 1U << (h->order + PAGE_SHIFT - 10) is actually equal to
>>> (PAGE_SHIFT << (h->order)) >> 10. So we can make it more readable by
>>> replace it with huge_page_size(h) / SZ_1K.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  fs/hugetlbfs/inode.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index 25c1857ff45d..f94b8f6553fa 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -1519,8 +1519,8 @@ static struct vfsmount *__init mount_one_hugetlbfs(struct hstate *h)
>>>  		put_fs_context(fc);
>>>  	}
>>>  	if (IS_ERR(mnt))
>>> -		pr_err("Cannot mount internal hugetlbfs for page size %uK",
>>> -		       1U << (h->order + PAGE_SHIFT - 10));
>>> +		pr_err("Cannot mount internal hugetlbfs for page size %luK",
>>> +		       huge_page_size(h) / SZ_1K);
>>
>> I appreciate the effort to make the code more readable.  The existing
>> calculation does take a minute to understand.  However, it is correct and
>> anyone modifying the code should be able to understand.
>>
>> With my compiler, your proposed change adds an additional instruction to
>> the routine mount_one_hugetlbfs.  I know this is not significant, but still
> 
> I thought compiler would generate the same code...
> 
>> it does increase the kernel size for a change that is of questionable value.
>>
>> In the kernel, size in KB is often calculated as (size << (PAGE_SHIFT - 10)).
>> If you change the calculation in the hugetlb code to be:
>>> 			huge_page_size(h) << (PAGE_SHIFT - 10)
> 
> I'am sorry but this looks not really correct. I think the calculation shoud be
> huge_page_size(h) >> 10. What do you think?

My bad!  I was looking at code that converts page counts to KB.  Sorry.

Yes, huge_page_size(h) >> 10 is correct.

-- 
Mike Kravetz
