Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305CD3010C7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbhAVXPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:15:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbhAVXNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:13:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MNA5lI188765;
        Fri, 22 Jan 2021 23:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZZvBQ3Vsr5eJ2+pqqHWg2/wF5BHZmRT6kZsoRhbA3kA=;
 b=eMuvN+g+LX5pBOsJ4t2P6r5b5+xew4Q1RGapwCuXsvjtX6E3B2PaK+cB/LFOAzo69w0V
 JeN5Y8aKROxZaF2gztGu98/F7y6fqAx+0XuoaWJD5FWVz+9Znk6ekeYwjMwwkN0niPco
 eAeGzL1Bei28hxD7oM6MBBV1IWVvfLq+ir0kIqGpUC8o7VR2L/TvTIDm72Xb/CrZ/7nI
 RBkwcNXHKF+olkoa0kJzxR84DYr/PQh114QoUmECjgbhpPa4Gi71dTU1zIIVrSGo9kKb
 gQJI4UJUoB4E2c21hgmtpZgoV5d2mS2EOPSOkmUjKNMdlCPIkU967UkLv49dWmXygibu zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qapke8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 23:12:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10MN9qZS130752;
        Fri, 22 Jan 2021 23:12:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3668rhk8m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jan 2021 23:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JILauIhtucG6qHfvCm51GP4/hRmcOPJk+NJq54V+7XX+P+69roZcTXmR024i0l6fhX5IceoU7h7clq0s/tGr6QyEDvQ/j97VnWRGDp2Jtsr6iZKddWDT8jq8XfASNpzumnKxPCFhsWvJQQlwWStMbO9n5Fjs9chKbX76y+eGJ/BqBKMSttfC2m3oQDAl6Lzb2HRxEZZA52OeBKWqLy3/CPCH+a3ygcZn8w5IWSnbfmgMtd7RejwqJaykcQdPsJSN948Kka9a+PrCZxVpanYTxLNZbuo9xDWrQBDlq4fIq//Ut6g7HyI/VVVZrKUmhpNtqzwcDvtjktmEZVAhGd6qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZvBQ3Vsr5eJ2+pqqHWg2/wF5BHZmRT6kZsoRhbA3kA=;
 b=imfxc9oP3zCSbbfVVWQ5wLwLHWIx8IRpezlgEGi69hkG7r+3yCl838nqFBVNRpsMzDha+IXmRRddoYCBKpQfntT+kSu7ZSS6+cjI1o9S9iTsqrpnLDirNsRxbYOc9po0PrT6rNq3RFryJT7p8I+/gr0/hW1nlDSmg8Jt6DIYPrTBrSzkIm5vZXbYTo1yFToyPvnDrVp3P9CqR4+h/T/DtZFB6wVxPtEE7aRSz1Oqlxu0ABcvpVMLNyYyzkjIJuEGN+k7QTa/CtrbjYZHO329/sivJm6rYoFBB/MA+/YWfzuo34M3r8HNZc3lXVmBdjQfU3GMI3kk6JAHjA6Ao6bx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZvBQ3Vsr5eJ2+pqqHWg2/wF5BHZmRT6kZsoRhbA3kA=;
 b=d0hXeRFhzkxf7OWe7OyQvCVOF7HX1xaV6Ms6EcYpvrsU+hmM3RdbzpUqzacmDF+HKhyvxKSL9/83xx2nVaN63biy5vk7fnFRPQL0ubt8HyhAHFmbzIgrdEovFLEq1fOxuudquww5POMRLIFYnu+rIMfjsmF1hyw/VTgHUhFih3Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1520.namprd10.prod.outlook.com (2603:10b6:300:26::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 23:12:21 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 23:12:21 +0000
Subject: Re: [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
 <0159cbc4-6d98-fefe-2288-5ba28b3f519f@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <634f94d9-5d81-f7a3-4201-53d48e4a9a27@oracle.com>
Date:   Fri, 22 Jan 2021 15:12:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <0159cbc4-6d98-fefe-2288-5ba28b3f519f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0441.namprd04.prod.outlook.com
 (2603:10b6:303:8b::26) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0441.namprd04.prod.outlook.com (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 23:12:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd3c5d0-2053-41b6-069c-08d8bf2b2b85
X-MS-TrafficTypeDiagnostic: MWHPR10MB1520:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1520CA6F51C5CB125376F4E1E2A00@MWHPR10MB1520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KesllpR6sFKTgZJGb2UjQ7AKgO66a/z+tZLegWLeRl4AsCynNSCyxKMakv6aOpco3O1jT80MpsDHIbPc6O8Ydznxuwvabq+jNQt+D/RnMQGoCDliAimb3+cs5hct0XyePLiT3qEQaTSt1eXL8yksKUJepPjyGPho9IA63OXTMkLuzGv2NGdarlKmem95YDTt2dQDNh+tAmjvJZIUFuHGZZ7iyiYvpb0ZHBIMUoGDagi4hdn5hVmwhvXFEGASJUSTkhYZ3HVdqvyEh18mpc5ZxnKq+4wWbGE8UZQrCPVVWNEQ0v04OFg3fr1T0CVt07ca27+QhiByW41oXIX36rO2cMcEjSRwE5sFsU5Wcf+CIZtGXwzlBDb3mwtoiB20lb+xFqDZwaj5QmFBLqv3mE7fkRZuNSV+Th3ITy5w08kmuwh4ZF04skvvIU8+5gOYphsDpvnTjMzFiEiHNpW6T0pta82OHeMaYAfxQef3Berz9vTUtBcFtmSUmp/4ham4y5aP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(2616005)(52116002)(16576012)(316002)(8676002)(4326008)(8936002)(53546011)(31686004)(44832011)(16526019)(956004)(5660300002)(2906002)(26005)(186003)(66556008)(66946007)(83380400001)(31696002)(66476007)(478600001)(6916009)(36756003)(54906003)(86362001)(7416002)(6486002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TTVyQzFBWU5jeEF3SnlXY21LQ0NINDZPY3R2dEJnN21MSVp2N2o5c0F3SGVz?=
 =?utf-8?B?UkRqa3BpRHFzYXpYVFMzMWlLVS9NVjdzdGpBb2llUFZhdjBTaWdkVzhtcE9n?=
 =?utf-8?B?eWxQb0xjeGF6T1dRdys0WjRkMmJPdC9mdjVCamM2T2E0Y0kxOEUvamY3SUdq?=
 =?utf-8?B?RlRRbHZQYlp6aVRTeVlHUUUySW9FbGY2T2tXbTNjQS9mQk92UnA4QlprdCs2?=
 =?utf-8?B?UnovRmJaK1cxTk96bnRoaGlQbHBpQnpsN1h4R2hvMzdsbGxEWGpFMmlXWlI5?=
 =?utf-8?B?ZkJJTUs1MXBrTVFWN3NVMkNqNzd1Y2h6dDlYaFNObVh6Skk1NkRrNFBqUktu?=
 =?utf-8?B?dFZ1S09CQkg3eFdWckxxOEJLelB2aWQxdmRWaWtESjJwZTM1WFB1N1MvVXpj?=
 =?utf-8?B?K0xKRkd1Y0tCeHlVbG82aDQ3Uk1IWXp3SE9zaktoMlRRNnRiVVFsa3VyU1ZH?=
 =?utf-8?B?bDBuNTVMcXJWWTZiUmN4M1p5Yk1xUVFPYytZTmtQUllOUldHTnFVa2RBN2Yy?=
 =?utf-8?B?SkpxMkJBd1RMRXpTWXZBVzQxUVZKSjhSTlVVaTVkR0tXdGtuRXlFUXBkMXFV?=
 =?utf-8?B?YlRlV1JIL1pQL2VKZkN5R2lSaUdyc1BlU0J1SnBMZnIxN0RDMVRWQkNZNnAy?=
 =?utf-8?B?dXhZK1BLSmcxRUpsbGJOMDJXbFh3U2E3YTRxRkZjczRSUHJvUjFPSkhrZGNH?=
 =?utf-8?B?c1creWNIZUtFNGNZZjFpYmFuUGI2aUFFOWFyQmVUdE1yVUJGam5HaWpoejZT?=
 =?utf-8?B?WVJkYkM2NERJVnFUN3NRdnNoclhyTHdhVmtadkpNbmdZbE1oYUEzOGFxaUdu?=
 =?utf-8?B?Wm40QXVHTTZaWEFSMEc3ZVQ4QnhPc2VnS0hRMkNBbFN4M20xZzZOcGE2a25w?=
 =?utf-8?B?S3RycGo4QVM5TktGb0ZFajEvRVVOb3Z5Sjc3akZNVnA3SkdRdS9INjBUOHFZ?=
 =?utf-8?B?V0taS1ZMRUlsMHcxOFN5MVRXY215Rnh0bWdON2gvd2FMVWFON0loSm1Na1ZH?=
 =?utf-8?B?dXZ0VzJ2eEZSNzdZNjMxV3pXR1IwQXhFM2xXSVdxc2FJM2NCay9wR1pUQ1Jw?=
 =?utf-8?B?aG1CVjA5dG1FM2hKTnB6L0Fkc1FURE13dGZYdHpOcnhTTkRGVUNKUkZyczVz?=
 =?utf-8?B?WUo0V1dtZ1BHb2tqTmovNHRGeFB5TkM1VDloZ3UyMzd6cGlxUktMY3g4UTcy?=
 =?utf-8?B?Mis0aEQ0YWF4RENMUlU2WHVBS1MwenA2ajJmdFlQc3dNenJ4SjVWVW5yRVor?=
 =?utf-8?B?VXZSaUsxNHFHaEN5b1JUK1lRbDZKNzYxU3dwb2lTV0hvWkJLMyt1a1d6bDM2?=
 =?utf-8?B?ZGVWZ0xQSmtTallzdWxzK1ZHUXdXeXRGbUswaGpLdkE4WVp3Q1NQT0hxVlBh?=
 =?utf-8?B?WVNrZTUzMGhJaTVFVWNpcEM1c05vQjZ4Q0IzdkFLVkRpM2RvRXROV0NKbko5?=
 =?utf-8?Q?8KDWAymB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd3c5d0-2053-41b6-069c-08d8bf2b2b85
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 23:12:21.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvws+RwJz/RdPEKpzkPsmwnI04/f+mSvSKydp3UMJ1KqvFbct9eQSTyf1jNtNj/hBmwk5iNWwoYEKyrYZs2DUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1520
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9872 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 10:53 PM, Miaohe Lin wrote:
> Hi:
> On 2021/1/20 9:30, Mike Kravetz wrote:
>> Use the new hugetlb page specific flag HPageMigratable to replace the
>> page_huge_active interfaces.  By it's name, page_huge_active implied
>> that a huge page was on the active list.  However, that is not really
>> what code checking the flag wanted to know.  It really wanted to determine
>> if the huge page could be migrated.  This happens when the page is actually
>> added the page cache and/or task page table.  This is the reasoning behind
> 
> s/added/added to/

Thanks

> 
>> the name change.
>>
...
>> @@ -1260,7 +1260,13 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>>  		if (!PageHuge(page))
>>  			continue;
>>  		head = compound_head(page);
>> -		if (page_huge_active(head))
>> +		/*
>> +		 * This test is racy as we hold no reference or lock.  The
>> +		 * hugetlb page could have been free'ed and head is no longer
>> +		 * a hugetlb page before the following check.  In such unlikely
>> +		 * cases false positives and negatives are possible.
>> +		 */
> 
> Is it necessary to mention that: "offline_pages() could handle these racy cases." in the comment ?
> 

I will enhance the comment to say that calling code must deal with these
possible scenarios.
-- 
Mike Kravetz

>> +		if (HPageMigratable(head))
>>  			goto found;
>>  		skip = compound_nr(head) - (page - head);
>>  		pfn += skip - 1;
>>
> 
> Looks good to me. Thanks.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
