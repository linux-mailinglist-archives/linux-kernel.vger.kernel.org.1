Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A217D2FD87D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404566AbhATSXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:23:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404346AbhATSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:15:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KIEP0Y180827;
        Wed, 20 Jan 2021 18:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oznEcWaLEkhogFm/2NsNTrkNcbbLHH8tGy+s1xZcyBs=;
 b=Xd6WLMEnug5E2mvBj+7ckIDOL5g9BXwKd2HInykcSaU969lhAy6uj+ZUAGNi1pKtA1UC
 elnU1NcXzS265WDJTQhFVzdOHYLpi4Gnal4NX8zqJFKGr0RMhFK78sDNl8cdpij4g9Yj
 dOQjUb5mKVt2gLT4QXMyyfM2dDkqFkiV4/E/7aGkwwgNs7rljAvUfa8rLi6sLf/kowRn
 FW8QxHhB6DxVqE5ZFVsKDuBCGELqpcSkMODJc4R095jdxlQESGbGb5ThQef4W1YLhxtQ
 V1/bddFo7pc1EOFkCzWf2k2g9BBnD8xVuVGcxmP83GKdaSlkhCWbRJXfdu6EeQsvM9/a wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3668qmus0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 18:14:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KI5pQC142679;
        Wed, 20 Jan 2021 18:12:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3020.oracle.com with ESMTP id 3668red08f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 18:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpL7OpIFsR44Hv8jAVAA62J1N8vY8lDPFuJ9BQXKbRPMdfjTt+DEshE0UEKkiadvhRoPZppctrUbKB29UuBsgBKjJMsKTgtfsdX6yTB7l8mcTUJXQSf423KBCX5WLQatQyqo/gQia5V6l7QwtbnQVISWYzBQzJgs80s0/vp1dLjjc4ulH3EsWWU0K9Uhn6+PI4V4ixSWlW/exEQb5yWZ8+RVka0awqnGY6W2qtJuqc/ZhsFkd009pXzzGlAr+W2E4sKZap4eWwSaPdSLTtqk1ZIyUZ2hf0IV31zh4FTgxd8PK1ubOaxMKSOyueZyYVsPhyy3KCpZBzYb1pgeKTbZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oznEcWaLEkhogFm/2NsNTrkNcbbLHH8tGy+s1xZcyBs=;
 b=n8EiJmjj0+ftRmU3AJWsX2Xe+4rArzDrKYbo2RkznCc52YjtEaQOzEYQm6cJAJYazebgk05LOKwq74u8qk4UTHU4YvN9iyKa1njFQ/LJ0Q6RT5a6RmzizF/awLXHEa1OYSPyrMEUEtyskiVFfgcPvGdjKV6l4dT7pH1wayYOBcqJ44euS7yOyX7BqNqbEOlxST9Vo0hls6Su5rdlJmW5S/A3ZeQQ3n/vZD8zjey9DrLJvLr0jPTPKp2SWgrewL8KKVcGMhRE8S4u/5SGKwNHuYYq1b7+FwZogaZb/uZz0bdppkhSv1Ix74SrzcmbrYnC1Qt/0NEZJWbDSOBrrjSYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oznEcWaLEkhogFm/2NsNTrkNcbbLHH8tGy+s1xZcyBs=;
 b=MDLW9qd/Rk56qgFlPy+FekXV/vZRIkC894CSCqw2POEepcGhyDBjMBJIYdSSFlzW3Saqngs2GCnZYk+eP++J8HmGv3ZS4kWAo4P4aZNiYY0mgWyMhDf3ID4WKIfjaXvirGjMjBAW/cfUhTVm5ZdZvtU7CFJWdoUn4r0SoCJlOvg=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2286.namprd10.prod.outlook.com (2603:10b6:301:2d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 20 Jan
 2021 18:12:23 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 18:12:23 +0000
Subject: Re: [PATCH v2 1/5] hugetlb: use page.private for hugetlb specific
 page flags
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-2-mike.kravetz@oracle.com>
 <20210120093015.GA4194@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <01499168-dcd3-7302-b9b6-977bd4fd594f@oracle.com>
Date:   Wed, 20 Jan 2021 10:12:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210120093015.GA4194@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0339.namprd04.prod.outlook.com (2603:10b6:303:8a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 18:12:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71a81d0-66b5-4243-3ff1-08d8bd6eef1e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2286E982980F9566A06F1D33E2A20@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+nHSTNCBGliovAuHMcSc1aLzrdjz12AEfP/iK3CNpjxZLy1VZH4pIsDVll6BRI2jSVN5i31XPDE3C2njs1pQEaFNySfKfk0Grd3+nrXsfqSxizd93zPbRIidhBj15bQtX8+ToZVjpRa/FI1Qx04Uby5BhBSPtEkV2EAyRFlxtwfDHbhQNffphNkQwMu1srWxfrqg9Twj8/qBaisPoBPSVjUla8LQaHKIsIM6rb9nhErUd6MTtQRn1TM9HBgoTMNOkF/aCpEiNqzaixCBqABI5q2jbRiFhOZrQxXCKAKJriMCrnPGE6EsL9HHNsGYZMJRSlXKAGGMZbgAUR10s3qt3ZqEP8/L7k3gsRjn/Al6RflfJY+Z4esl4HoA96Sc+pH3XsNiFIBn5QGSDxIslK6DVoxhX+2zxZfKEn8v4hW+gEqzGk+Bizn9ED5+rvJDYXUhCWPIGGXqWbCetGTGIayk7Fdg22GWoRCYLd//GwXmK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6486002)(53546011)(2616005)(31686004)(86362001)(8936002)(54906003)(26005)(44832011)(36756003)(5660300002)(2906002)(498600001)(66946007)(52116002)(66556008)(6916009)(31696002)(66476007)(186003)(16526019)(4326008)(16576012)(8676002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YlFpaVZ4dUZwdGpTTk9qNUFIUjN4Y2FYcis2OVJpalhSYk95dTlVenFkZDZB?=
 =?utf-8?B?ZkxkTGxnTzVJSjZCRFBLQ3ZqZmV0anY0dVIxTCt3enRJeGZZSmZVLzF4anpi?=
 =?utf-8?B?NDVoZ2dLajJURXRaRjZGQlYzbVRibngybWFXSHI5Y1hYMmJjdHh0WGdMTSsr?=
 =?utf-8?B?UnZiSnliZjhUTE5GbWN4V2RuK3VOOStrS2xDRjFKRTA2UFlPVjJEcXVWdU4r?=
 =?utf-8?B?a3I5eEFRYVp6YU1ubnZ6WmdhN1RXbU44cE1RancvMzl3dE5SeTFtSTlCY0cz?=
 =?utf-8?B?NW5Sa1RlenJIbDFXenhiNDZPdXNEcHE1NVJEU0lxY1FxYWZveC93djgrcHY3?=
 =?utf-8?B?V29YYU1obWx3eER0cm1BQU9nWW4vS2V5NGVSdzhHNk9WdUw4bHVKVkJFNUlN?=
 =?utf-8?B?ZHFsTWpBQWx4TGF3YmtCR21TamVQNFB5UDA3M1p1WWJTY2huc05uTXFvcVpH?=
 =?utf-8?B?aHdjcnB6cDM5ZFNMMG9XSnlDS2tJQWVzK1czZzVja2NiRlRkNmlScDdBVzI0?=
 =?utf-8?B?OHhWeFd1cXlsTTlHcTZvSUZ6WnlVYnpTdS9sVE1vZlk2YnhJN3VEb0RsdkZJ?=
 =?utf-8?B?UENYZlhpRjdkMG9mYWdEeVBnWDhaQnJlVzhvUjF3bTk4THpJR1RjSE9UTmUw?=
 =?utf-8?B?UVl4SlRNeElpS21FNm8vNFY4d3dsdmppQ25wMjFGNWErbTE0N3NVRkd0VXda?=
 =?utf-8?B?dEkrSEtyRVJLV1dtUk5YM3RpVTRPTWhuTzlNcWQxVFBRL0FGc3FsTEZkWVdL?=
 =?utf-8?B?SjNyU1dITWQ1b0J4c3NMTWFSR0h6dDFNZVhMSlBVdnFMaDR0L01LMjdkT1A1?=
 =?utf-8?B?dldaOWlaYlE2cExqRXFVUWp5UzBueEZDODF0aHBkS1JHYnU1MXZ2eDZkZEh6?=
 =?utf-8?B?QUZVcWhDYnpkWE5uOVJQaUJtbnV6djh3QkdtVWxac3owSDRER283Z0dpQUVC?=
 =?utf-8?B?UTVPQkc2MWFwajZEVUxoSDAzT284R1NsL29WUllsM1ZxU3duK096eG1EZ2dM?=
 =?utf-8?B?TThkcEo2cnhKWDdVTUhpVldXd3lrR0lKS0VUa2VyaWFzK2E5RVdVTmZtemRh?=
 =?utf-8?B?MmlzMkVoN21ycTZoQXNNNW15UERUQ29IaTh0OFp3L1Awbk5PYjNIVGx1YVIx?=
 =?utf-8?B?VUJUU2dzNWg1TEZRMXZMNjVBdVk3YXBmaDB3eUVQN1Q1MFRVTFYvUWhRbWpa?=
 =?utf-8?B?UWMzUlFtUVh4TWpZS2VjRVBRUFRRNGxQK2VKMU5zWHh2UXlmRTQ0Y3pnWnE3?=
 =?utf-8?B?SHlPSXluRmtsaXo1bFpOTjN0KzRWbFZCcFFFOUltTzkxdVNZN2d1WEc1elNn?=
 =?utf-8?B?WU9FcnRBMEFZcG81MGhBdEhqM0MybjBRRzBTMEVRMitxSDRoSFdJbXdPZFVx?=
 =?utf-8?B?UGpSQVlaME5zUzZZMXpCRUxxQlE4d3dpSGNSMVl4MTQ4dmhlMytPRWZacmdQ?=
 =?utf-8?Q?oRhC9kkf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a81d0-66b5-4243-3ff1-08d8bd6eef1e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 18:12:23.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRdGUwvObwHY6qDvP5aJJA/gootu6yF83x7aPdeDBADi6bMGePl10NB4Fpk4CDYQsOewp4t9/TqH5d00eiMb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 1:30 AM, Oscar Salvador wrote:
> On Tue, Jan 19, 2021 at 05:30:45PM -0800, Mike Kravetz wrote:
>> + * Macros to create test, set and clear function definitions for
>> + * hugetlb specific page flags.
>> + */
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +#define TESTHPAGEFLAG(uname, flname)				\
>> +static inline int HPage##uname(struct page *page)		\
>> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
>> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
>> +	return test_bit(HPG_##flname, &(page->private)); }
>> +
>> +#define SETHPAGEFLAG(uname, flname)				\
>> +static inline void SetHPage##uname(struct page *page)		\
>> +	{ set_bit(HPG_##flname, &(page->private)); }
>> +
>> +#define CLEARHPAGEFLAG(uname, flname)				\
>> +static inline void ClearHPage##uname(struct page *page)		\
>> +	{ clear_bit(HPG_##flname, &(page->private)); }
>> +#else
>> +#define TESTHPAGEFLAG(uname, flname)				\
>> +static inline int HPage##uname(struct page *page)		\
>> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
>> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
>> +	return 0 }
> 
> You missed a ";" right there.

Thanks.  I made that typo when fixing up some trivial checkpatch warnings.
Lesson learned (again), nothing is too trivial not to introduce erros.

> I might be missing something, but I do not think we need a BUILD_BUG_ON there
> when CONFIG_HUGETLB_PAGE is not set?
> Actually, would make more sense to move the BUILD_BUG_ON from above to
> hugetlb_init?

Yes, hugetlb_init is a better location for the BUILD_BUG_ON.  I initially
put it there before creating the !CONFIG_HUGETLB_PAGE version of the macros.
With the !CONFIG_HUGETLB_PAGE versions, none of the flags are ever used so
it is OK if the BUILD_BUG_ON is not included if !CONFIG_HUGETLB_PAGE.

-- 
Mike Kravetz
