Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578EF2FDD98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbhAUAFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:05:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46184 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbhATVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:49:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KLfO1e170561;
        Wed, 20 Jan 2021 21:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9sbfDRYHECKjgUs4DdFJjnVXlelXW1p9+Q3+/pKb4cg=;
 b=kWQHkuke0QFhGb96ypy3Sbp40HHH+BCkDaWH6FNcDQbCcDZPnu1fOqTYgSww3IXWKVoz
 edk5YnqgRYp78au52tIkGPMSTkWJ7AIAdqMORlhisG0QB4J+JxGgpBImBrCVxK2Kib8h
 KSbGmaeb7zGvTRjOxxp1rHHGEDFbdPeg6M3ZjDoE6MMV3OXsZrKv3jy8yRL6e5Rdlgb5
 jm+L9bR4Y/LdEBJR3/wRGbHAy9YuMP4riB8NlBhrcp2iZ/8zmygpOvqmBU7VV8AfCpjr
 w9xdMd3KHoCxDapixnG67VUXi4d7VPn3azCm3mugD6gZnR80Exzlq0jqAz7SxFaOq0i6 Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3668qrcmmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:48:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KLUvIs073780;
        Wed, 20 Jan 2021 21:48:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3668qvyrq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPTQzEUl4vM1F9n74Qi9jDxDyou4L1bpWjkTQL8yQhPdW8CnjuAVd5tJ7nuEkLF2xkWGaUuFdcXWj05mzfBr9kMYA0kmHzbV2ZaREsFLJWRuaCozpUGZgewO7tNWp2w53/OFCnUuUpi28xO4imGr84IvyrlDyudHwDdcAJxU4ssdGihkYSdUfSJJozN/ugrGKqZReQ5KHH+Zbbpb0OfHmCx9BM0ZY/NCdd0ZIpZmdI6jxmIzYaDhI/ImlvzGkNjsrxtwdTfCxDQgy8nscounV5OCEdKihkHxowY/L++pAylnpun1PKT47JCvVtuwZXegQdz/GE1K+D/g/mIPNaKAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sbfDRYHECKjgUs4DdFJjnVXlelXW1p9+Q3+/pKb4cg=;
 b=eUIXGPtGxqHn4fy6rdMEFg0BJTOneS3Jx7I0h+aF4eYFVed2LmgT4AJmxw9ywMDSCJ7J/0ajxupYZCQ7zbKd7gAMMzkOWrQnS8Su7uNiEiiPeAwQ6bje6VVkkkRufZ43INzkDGNHPkHXBfXHzQXmbBlzUWG1hrkcs/gM1GK2vJczWqBOqjFtwA93iZDMTaN8Lj5ERmhtp6w7tN7xm2m9Tp8KHrOp1yHrLB7aMiu79+hL23reAh5KbHzmZXMZufaYHzgeYc2GJK7gJHjyFepkog+uEJqLfkqqrBCkjs33wMhjVDrBn8kP5W44/x5G86chSbul/nZJFEzioWgqCgywzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sbfDRYHECKjgUs4DdFJjnVXlelXW1p9+Q3+/pKb4cg=;
 b=novg1Gb/KIld+0o+gU9gIBf7i/LEy8ivjaaObx173PCQWqDlBpze+dxJMjmAuPaykbodCdt9pITJhOPIvYz6WE4u5UIToqam9+L1wHKTARGD/71l+gtoaOZIQ78xWsvqAeMKCrztTxzy9F6yyHm5KO2FzOdTBGWkxw6S0hh1Mhk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 20 Jan
 2021 21:48:07 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 21:48:07 +0000
Subject: Re: [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
 <20210120095905.GA4752@localhost.localdomain>
 <20210120100023.GB4752@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0ef72fcf-7fd6-02f6-6fb5-69a2c5bcf7a4@oracle.com>
Date:   Wed, 20 Jan 2021 13:48:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210120100023.GB4752@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR12CA0039.namprd12.prod.outlook.com
 (2603:10b6:301:2::25) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR12CA0039.namprd12.prod.outlook.com (2603:10b6:301:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Wed, 20 Jan 2021 21:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69ee23d-1c15-4219-e323-08d8bd8d125b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:
X-Microsoft-Antispam-PRVS: <CO1PR10MB45146D2A997B01316017EF08E2A29@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VACk0YMhrqbptN9Exb9DgXYDtdPULWIJKilm+JaNsHcAO34Qy6JsQdYXgkMO/Bv7vAAYZJJl/JfivBBCj2TPaYBs6F9mPE+YriVQ7Sbh9JEfb+KnWvp2CDOX4u2/INDxsKQHkc8hSk8/LUidQ2Xf3ClAXAqAgjX9fOOv/NvMtmN46TG4pdkCLAc1pGahWMWHcL62YPE8JuIQDfEbEprk8GhEU3BAs7KxcQ2Y6MkzZLrNv29HxiJf/d7veT/SepG8+itEpNL2L4fhP8F8yIJR3SdFvyPU4cOgP/R+EYJ40+a7R3IFm0ADJK84OWj9uABVZJW9PBU4SDWFs8iysfjv5u8Wq+AhE9V8c95WjUSC3Ae1c8InjcJwIGV6QVgt2dU2zbnkUZx0ADH+OYpQO/LjcLfeRFq4LC8wcNzAyVoiUCtmeImn68ANPgij8/pm44S1qcMayBU+wfIc3BSBgb/6tukLkBGxw3Xq8sshF2kraNTivSZJdJyucF7bWh+1tynAyzlWVYXpH4FBUCKII2hz/k0xDCnbuGE9GvkingL0yXux/0caZzC/3svJOY35KfpJ2NEL58SAv8e9VN6kLxSD8WvpHOPWIOK4/FvQnPjnwMXHS71Ys8y2u6XnT9DcKzVFgAot7z4w0iM3ZRGKiyIhQmZP7ce3rlgP2VE+U0ydzs9P9V+ZzbpvoCkj1ieTIha88AWG5+DTGMvRsx2vhJMww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(53546011)(16576012)(31686004)(186003)(36756003)(44832011)(5660300002)(16526019)(2616005)(26005)(54906003)(6486002)(86362001)(956004)(66556008)(52116002)(66476007)(66946007)(316002)(8936002)(6916009)(8676002)(4326008)(2906002)(508600001)(83380400001)(31696002)(966005)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qk1vTnA3TWxVa2NDRXpHVzkvMGNxMVFzaEZ2dFVXclBpTStJNUVMNFl0UE1F?=
 =?utf-8?B?RzVnUFozRXZSZEZMNlA1U091MldwcmJMZFJORlR0c1doSzNpR2xnRmg0dk5j?=
 =?utf-8?B?ZG5nL3BmeGt0S3QyNS9FckovMG45eGVxZUY2cHlXQ1ZFbXlpb0U0cyttay9v?=
 =?utf-8?B?WFNQYmlLSDAzOGR3Q3I1VnJoRzdZaytsSVJwd3gwQWtydzVjN1RZNFNmU1Vp?=
 =?utf-8?B?NFA4Ly9jOVV3NDBidjdhdXVHTFRwT3pKV2s3MTZoWFowSDFsTHh0UXl6Y1pL?=
 =?utf-8?B?N2xNa1I5U2ZPZHpLUXllbDNXTHA4WDNaVjRXVTRqcmpLYzd0MlBFaXhZK1Rh?=
 =?utf-8?B?VEo5NWVHZDFERlZvendXblM1ZGtYWGovZ1Vod0NHNUpUcHFzWDhSZmpGZnhn?=
 =?utf-8?B?aGJIc0M0dkt3aGRYVGtwWUtQRzVnUk1aY1R0WldxdlBMUWZIbUZDRzV5QVR2?=
 =?utf-8?B?alZaMkVhbkdib1JLaTI2U0VLQkFBTFlRaEtEaUhSS1Noc2hUZnZSamdhTmxk?=
 =?utf-8?B?dXQvZ29UU2EyOXU2NkNlT1owZUJwejFKQk1SODhuaExBVW1ZOE1YQUVwM2c2?=
 =?utf-8?B?QUc0eC9xK3EwTEtMQWpzak5oZnRBTFRDck5XZzNNZ1BOZzBTbHBSaXc2eFBP?=
 =?utf-8?B?dFBLSHBSc1RUOG8zSjB0azdKNTllZE9FYlZ1a2RSRFZINjhqZEp1dXREbW9P?=
 =?utf-8?B?MXhTVTJwdDI4QkVDV1ltcmhiTG1KRHVRSWtWM3Z6d0hvTEJZNTNDZ0c0NzZU?=
 =?utf-8?B?Zzg5NWc4WDZhdW81UjVnNWhyZ1JwbzJZdWFobGYzVHNXUWVhL2RSbUgyTm4x?=
 =?utf-8?B?cS9KNE41RUhncUNaRmlPT1ZYZ1VKMU1EY1pWL2ZxMFUwblU5WWlndHdheGRp?=
 =?utf-8?B?cERJc0trZGxza1I1UnZreDNzbDEyR2JPNTJJRGpybmZGNmFwNlFHVkIzbjI2?=
 =?utf-8?B?V0RRZGNtRmdudWxDOG9lbldqR0R6a0t1T2lRUHR4Zk52cFNBS3A5OFJwbUow?=
 =?utf-8?B?aGxBRXdBN0NJWGJaemZRblJSODhDSEFlcVFVdk5EQUVnaUJpYnd6STBvZVk0?=
 =?utf-8?B?NG51c0tZM1dOZnpYWVdNZW83c1hhVlQwb1E2V3JmT3Q4TXZqUlZKU3JRV0hs?=
 =?utf-8?B?a0llM3kycWdheVoxcXM5VlhJRXVxdjg1bzZ2d0VPeWg0bjloNFcxNFIrNS9l?=
 =?utf-8?B?S0xBUGc0blJRd1dZb3B0OXJ1ZE5HUGRaTU9qZkVHejFndkpkV21VeU1sZy9h?=
 =?utf-8?B?SW0xSjFhbUFsOU9JSTk1ck1FcVFJcFMvTE0xc1AzU3doTHBQVEhVeWlPek5O?=
 =?utf-8?B?OVVLSmtlT3N2SEs0ekM3YjRoMmVyU0hYaS96d1B5NG9MOXlYSU1MczZ5bGFX?=
 =?utf-8?B?WTI1NVl6VlZ5L1JRKzVTbGtMU0s1VW5JUXRHZEt2WnQvazhVNVpZSDhaOHd3?=
 =?utf-8?Q?bdhnf9VA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69ee23d-1c15-4219-e323-08d8bd8d125b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 21:48:07.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdjs48M/zLLRe1hh5tfnzNBQJEBl2EX4uT5IOWh84TlJdlBi2J3hp0FaBfJRxP5q1YJYB0wSLz/XGb7sVRVPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 2:00 AM, Oscar Salvador wrote:
> On Wed, Jan 20, 2021 at 10:59:05AM +0100, Oscar Salvador wrote:
>> On Tue, Jan 19, 2021 at 05:30:46PM -0800, Mike Kravetz wrote:
>>> Use the new hugetlb page specific flag HPageMigratable to replace the
>>> page_huge_active interfaces.  By it's name, page_huge_active implied
>>> that a huge page was on the active list.  However, that is not really
>>> what code checking the flag wanted to know.  It really wanted to determine
>>> if the huge page could be migrated.  This happens when the page is actually
>>> added the page cache and/or task page table.  This is the reasoning behind
>>> the name change.
>>>
>>> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
>>> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
>>> are removed.
>>>
>>> The routine page_huge_active checked for PageHeadHuge before testing the
>>> active bit.  This is unnecessary in the case where we hold a reference or
>>> lock and know it is a hugetlb head page.  page_huge_active is also called
>>> without holding a reference or lock (scan_movable_pages), and can race with
>>> code freeing the page.  The extra check in page_huge_active shortened the
>>> race window, but did not prevent the race.  Offline code calling
>>> scan_movable_pages already deals with these races, so removing the check
>>> is acceptable.  Add comment to racy code.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> Hi Mike,
>>
>> This comment addresses both this patch and the next one.
>>
>> Instead of putting the SetHPageMigratable flag spread over the
>> allocation paths, would it make more sense to place it in
>> alloc_huge_page before returning the page?
>> Then we could opencode SetHPageMigratableIfSupported right there.
> 
> and in putback_active_hugepage.


Hi Oscar,

In Muchun's series of hugetlb bug fixes, Michal asked the same question.

https://lore.kernel.org/linux-mm/7e69a55c-d501-6b42-8225-a677f09fb829@oracle.com/

The 'short answer' is that the this would allow a page to be migrated
after allocation but before the page fault code adds it to the page
cache or page tables.  This actually caused bugs in the past.
-- 
Mike Kravetz
