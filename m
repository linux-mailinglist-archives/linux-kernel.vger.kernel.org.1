Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B42FC35D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbhASWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:25:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52448 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbhASRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:46:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JHebdf021495;
        Tue, 19 Jan 2021 17:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RATlFO8zCyK2ZLT4WxyuaQeyed/Oiin6e9yP+F4lGCU=;
 b=w+yl4LepcIufyb8J/bXrXhCa1mUu7HGzQIkPm17Y0QDkidruU8p8TnPri8y7t8HH6W/T
 gaPHAyh2Fo8CNSrhSJzAmM0E7u2MtLocaU0a5x0QGXC9CcMqLZ1GIqbjrfd2AWd4xuko
 RS1/tseLfPP/kaK6E6kHpff1cg+OxzNT151c+UBHnBEhbCm1eyrOjHTEExvk6/Yd70MZ
 uTRFZSoKy/fH0VLTYDAF2odxZhNbO5k1Ao7rP0L1YrTuaHhVWyzANFr4FU+dc+ur4bg0
 znEInr8AtcBVByXzGchHuNlP2ldEHuGqm4Tvu1rnSuDnHwV8bn84sUdD3UbVnsdFU66c tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 363nnajema-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 17:44:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JHdkUm017297;
        Tue, 19 Jan 2021 17:44:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3661er2r5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 17:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exwz1kFW8UJKgLzRvEuWJFFdqnxEE50zGkn++OaTxiTkiyyCXcv1Jlnmmf4sG3pHmmZvhxfspKv+TnE2HtoDbvNFn435B4W70LH5oTfF2xJGWJ10UYHPlWvhCEYEEo1upx8m398ABUZLEkc0v5G2NWw1xVmgfFmGSsOyBLbEaXVjammox/54p3ALC/giE08yUvko29ePYK9S9tHK4FiIUDNNzmFX4W/9vMnUqg2LbayWLLtMQ7dh37ao9Dmqr7IKiwjNr1gT+n71luN7sMd9NU3SP6Fbl6TRxGl7jUaKZmlfU4yWfpeYbvjXxTWuhONo5MGBRKeysYoJ+La8ix3tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RATlFO8zCyK2ZLT4WxyuaQeyed/Oiin6e9yP+F4lGCU=;
 b=IaXW3/paS+fjNiZZBiF3ss78XnXEktveLf5v2fE+DfYi0E2PcL5wsqv4Xm04VvIDNqYPiMnELVEgQCFAIdA0RkXzN5+0wBF+wHjEu5zRZL0t+ZRF2BYUZwQj7KAwcVWfPViUa0q3Ix4f5G/HqY8FqAKFOh7VqIHnNHz1BOS/SNyx4CA0L8VILiA7TpurrAOq6T5QyixfJlg4X3PgkExAnQ9Pwyj9Z5um+knJnJJVYOMisOpqm0n9WxekVSYRTyoUATDgyWTGegPAIHUQIqZzTvsfrA7lR/BxqTusMqYwxT8xN4T1+x2Zvj1/ozE9BaNGCeaIgKZrYNzaMCYsY/9pXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RATlFO8zCyK2ZLT4WxyuaQeyed/Oiin6e9yP+F4lGCU=;
 b=J5mBkiwlwwK6HkRjZuUjHkffgSIFey/kpkJOYc46Sp/lfAHN6CILRteVGxqdV7ajWcLx3TWMawyyNaLOznCdjpuc63Af/s+JGBO1kzGnNwgBfOTSykfQjE7i+u1Za2KKHsQH8Ky/J8yCObudpI/ctqnEeqZUYqQJhTVEUhnT2k0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2176.namprd10.prod.outlook.com (2603:10b6:301:30::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 17:44:27 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 17:44:27 +0000
Subject: Re: [PATCH v2] mm/hugetlb: avoid unnecessary hugetlb_acct_memory()
 call
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210115092013.61012-1-linmiaohe@huawei.com>
 <20210115092849.GC4092@linux>
 <8f7b7e94-f803-11e4-6fc8-f510e01d2305@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <aed126f4-e78e-1e6e-8fbf-ab5131b27f14@oracle.com>
Date:   Tue, 19 Jan 2021 09:44:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <8f7b7e94-f803-11e4-6fc8-f510e01d2305@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:300:69::14) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0028.namprd22.prod.outlook.com (2603:10b6:300:69::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 17:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99261f4f-ca3f-4818-b948-08d8bca1dda4
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2176:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2176DFFC873BB1394B36A8B5E2A30@MWHPR1001MB2176.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODqEeVDIA++9+RvbLH6BTQGF4bMUOjxipCN+VvfwScfJi8KY9f5kIsDta3Po3oTGxt8w7awU3ZYy5x+qgjP0tozjDjfushsPqmO5H/LT6UQ7Hig/vwZmZbzLoDc2cVmKfVkXPoqD+wFdWv/4KJvV+w82H4auGEfJE1NtearZN2tul8vqVdRUU7ALqDfaN8cMKYy/3bSnuEpy1wGnLi2tP6VHtDtIYRG3/SRxNtRW+V8yuvLmaA/bquFWImo3J6gFKJNSF9snpkfc0fm6miX4PwtRejWEb/PuIg7bvYeYCdQpuha/nhEQTVY8wgj2pLStoepWHqXVrzVRvTaSdwZ+2ongKbzZCltARk73AF5PZnHWDpYQ5SurjO/kg8HxZXWNVAibBGYo/Yx7isAazNOncUrZ1M4b5wYSneKbbhRO8JpeWT/+FZJOygde+EekXwsDIR7VODAo8qb09epeSGcySXWaFHLeDwThBAR6sa0iVJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(396003)(376002)(4326008)(53546011)(66556008)(2616005)(44832011)(6486002)(956004)(478600001)(4744005)(316002)(110136005)(66476007)(36756003)(66946007)(2906002)(83380400001)(86362001)(8676002)(186003)(52116002)(5660300002)(26005)(31686004)(8936002)(16576012)(31696002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Uk1DcEJ0ekJ0bjNTRDNuWmFZR29UYlNET0JDUmkydVZYL2RJRlRMV3c1b0xt?=
 =?utf-8?B?OHJaUlhIa25BU1E3M3Z6NDY3U0JTOG5udWI2a3VyUVh2djFmM2NMUTA4R2x0?=
 =?utf-8?B?Y05VK3NLRlZQV1lIQy90V3B4dDYvZlRxMUsxZWVjKzhsM0NOV3VLaENFcHVs?=
 =?utf-8?B?RTFRaVhVdWlNUE1BaWorVmtva3hZK01FbkdpUjRJdlFBODBWV0xRK2lBZHpp?=
 =?utf-8?B?bzNNTmZFZzhXZENqai9QL3hCQ1BSaGlsV3lyU2hNZlloS0tpT1BDZXZLbFY1?=
 =?utf-8?B?TVhpUy9jTEoxZ0Q0dWtrVU9yeGJYbUEwUUpTZ0FzUGdQZXY3VG1MSTkvenFy?=
 =?utf-8?B?RGw2Z3Q4c2xzZ1ZDblVuTUlMVStiWHJFSkRYZVFrSWY2a3RyQWxsRnJ3NnlY?=
 =?utf-8?B?MU5zS2o2SGkvWG9ZZU9CSG9KWjBaYkNOYms5eUIrQUFoblFzWU83R25tQ2hh?=
 =?utf-8?B?N1U4Y1ZDenBLYkduOERGNVlZV2NsMldGT3huUUV4WEhtS0ZDSGUzck82dWtx?=
 =?utf-8?B?OW9aSkdBeEoyWkZ4U1BCSFAwWE9FWlM4MU1ETXliZEZxdmh2RXF0L1VLRHdP?=
 =?utf-8?B?bCs3RExkQlFHSEM3UXE5Rml5MXl4RjJ1UGF5M2dXajk4OGVjYWVFMDdXaWZU?=
 =?utf-8?B?QThhVElod0tkWDVqaVFrdUlLZnFSQkltdE5BdktXTTU2V2FWMzF3Kzk5RzhO?=
 =?utf-8?B?dnNWZ2o3bHgwNHZtbmhwb0N5UHluaHhvalFEKzdFUlRlTWlHNWVwNDl0U1lq?=
 =?utf-8?B?MFVhVXFzVXpMZ1o1VldmQStpZ3BibXE3UUdaaXl6MENmZGxuTXlvdElkOXMr?=
 =?utf-8?B?cDBBZDVwaEhCN3ZlczRWNmZzeFVQOER5WEpXcDRvRjM1cStsNVdZb0hUMTV1?=
 =?utf-8?B?NHVUU0NnUEYrTlp0dXhFOUc3RmpuaWtEUHFKL1FvZ04vWlhoek4zbnJMVXZl?=
 =?utf-8?B?dW1xZVlvZExXcC9Sa1pFb2E1Q1lEUjhkaXpPVGIvL2xCd1FZOHlkNFBaWWhT?=
 =?utf-8?B?WEFTN044R1NGVmRzN3BhQTdkNUM3K3hjQndjQmNYd1hZZEEwckxiTlRtcXdC?=
 =?utf-8?B?RHpneDBNa3hlNXJRaTJmQmVZUjgxYzdPZ1JYcENhUVNjekFhbVd0UTZKQUVI?=
 =?utf-8?B?ZHMvZy8vU0VTWGtoSi9GSHN6c0V1cVk2aUJGT3MxZHZ6L05hRFE2MjRLYzAy?=
 =?utf-8?B?WDJac3JYenFHREpjQ2czWmpGeXRWN1NMSEJmNGk2OXBnazVNcHJQMnY3MmtC?=
 =?utf-8?B?NFpGTVFVQk1RNnRjNmNrWkFtZXRMSURxZDZvM1o1TXBxcWNZNHN5RDNXdkI0?=
 =?utf-8?B?TklJVFNQN1pCRmduVVJwY2lieVF1czV4VEx2UnVGYWxmUHd6Rmw3aEVjZVdt?=
 =?utf-8?B?dEhGNzJKUGl1cDQ2UDRqZVpEbEw0a0xRNkQyWFhWOXhIWXpRekVIZGd6VWli?=
 =?utf-8?Q?s+H5Qxvs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99261f4f-ca3f-4818-b948-08d8bca1dda4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 17:44:27.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRu6lKY53uWQ8OM+wxRcida44wtKnIY5kW/O1aS4Q+Mfq1IT62OMecQjH7dHG/LG3yCG4COdg8dOU/9LmKANIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 1:44 AM, Miaohe Lin wrote:
> Hi:
> 
> On 2021/1/15 17:28, Oscar Salvador wrote:
>> On Fri, Jan 15, 2021 at 04:20:13AM -0500, Miaohe Lin wrote:
>>> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
>>> and releasing hugetlb_lock. We should avoid this unnecessary hugetlb_lock
>>> lock/unlock cycle which is happening on 'most' hugetlb munmap operations by
>>> check delta against 0 at the beginning of hugetlb_acct_memory.
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> I would avoid mentioning gbl_reserve as not all callers use it, and focus
>> on what delta means:
>>
>> "When reservation accounting remains unchanged..", but anyway:
> 
> Sounds good. Maybe Andrew could kindly do this if this patch is picked up ?

Thank you and Andrew.

Looks like Andrew updated the commit message and added to his tree.

-- 
Mike Kravetz
