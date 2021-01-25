Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96627302EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbhAYWFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:05:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733108AbhAYWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:02:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PLiWX6083670;
        Mon, 25 Jan 2021 22:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rEEMj17bKvN35bAZr7dj1m7ZqsTacmWlyeShvBoqqsM=;
 b=xR4lqaeRMeE5rydtdFRdhBdUhzvoZlyWk59yM9mXt5LxmkBChza9UlcO+7C2ay1rbzR6
 lwkUBVTDfQc6x9Ib/yHHpu9KrQpkUCAXijLMwMVH9Guj8fiMzy3UTr+jcIt0xg10sCel
 vdrqDKubTTMpSXWiORiEs2EtGSgN0KcRgDJbvpFOYLbgWjwrNGOyIjgy2zh7AWwgArkI
 iIXPBJRx/x4sU9s+KGccD7TNYah0skrhSEr6H1hWOTi8SAA8hJbHqzOIyLXwprodSHVz
 sRE7U6rhErYERad4WSrByJr+VJGoWC+xn9WATR34+t2FZ2fyyEsUgyPJIYrRzX1H0y8Q ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 368brkfgvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 22:01:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PLixPX061642;
        Mon, 25 Jan 2021 21:59:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 368wcm6s0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 21:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLDlcDLMcEmXBnEX7act0aORAreMNm76lXYf3KCWux4noSOXkZJa8yVqxVav5hESmdxbNSaxeoO7ZV5B5pnVNTnsLnyJTcFAGMZFjlYlt345NMCkmIXrPGa5GTbcWgWX5LeZYkubPFueFq3P8WJWUqhUzkFnPegH/5uD841EcRcIw69rH9p8NcMzRtoampAcl5m9iSNLOceSSTNQHZHVW/aSVlNzZod5kuASsKq/y2VFd+/x1L4XO0+nVNJc8bhuoE/0zMRpd8dQ+LiY1+qT0KrPfhKUD9xKOLHGKutPYpMXHRkVtYeILN19Q6G4spb3rPwTUGWNkbpTcfWnJQqL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEEMj17bKvN35bAZr7dj1m7ZqsTacmWlyeShvBoqqsM=;
 b=MCZIHLAAFySnOnZf8hvmpD2ElL2pS5VTxkuBxH+IQXIri0qOl2P3z+dKogAFE3iXkS7cfW4fOWpIpiOgxfRtDZagDlCCYfeYZQuPevsTjS83UKL9wiM68VQP0dc6JJRP8c3/+jcMYZ0sV21xVsLRSHUlF0FedJYBdAEvEo0IUKaR1qnDdpmC1LqEVtwJfsdV73iqW07HCfpp6/eYmPtgF5h2c8Ze/Tl6uJ0iXaP8OFyG+83yyi6eiO2lp/Iyw4nyHHzzR4OVUwUMw4wWCnzuQAGvxUanJQUDuCmHJmPbK5qurEKExpXp3Tmwp1fdGUF5+kVpltA9LxoOWfVWOUvziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEEMj17bKvN35bAZr7dj1m7ZqsTacmWlyeShvBoqqsM=;
 b=yBxVJPhCrBjele3Xzld229faeyL2VMTk6btzvqed9/fPA048s9o7Mv2cUQ7LJzcpxkysU5KvjoptR+2X+L+N4qTiwtpKwLvbFR3dRy3cwQuAsFGSy5Q8mpVCsTUj6/Ggx5oaelYfhLTRK+HfjpgyqCbynq+r9gFRJKjUVIP3zGY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2110.namprd10.prod.outlook.com (2603:10b6:301:35::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 25 Jan
 2021 21:59:23 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 21:59:23 +0000
Subject: Re: [PATCH v2] Documentation/admin-guide: kernel-parameters: update
 CMA entries
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20210125043202.22399-1-rdunlap@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1f116bc8-ce32-c746-3e7d-4fbd1ab33d3c@oracle.com>
Date:   Mon, 25 Jan 2021 13:59:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210125043202.22399-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR22CA0036.namprd22.prod.outlook.com
 (2603:10b6:300:69::22) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR22CA0036.namprd22.prod.outlook.com (2603:10b6:300:69::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Mon, 25 Jan 2021 21:59:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d44f5d-b4a4-4ee2-5da2-08d8c17c7964
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2110:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB211091791D35450652D02C75E2BD0@MWHPR1001MB2110.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UstApjLcf/LCMnIEekYgYi2vj3WiTpTHRYMYk9nG6oRGl5psuUAbYqnGINXcPxhleab278XIdjKNLjRYYSZJMSDl0kJP797L7ZcRiMfxwBePfdt80e+qazxiEVgTIwWkafVg7d5VVCQF1sp3GnLOPl/0Xt0QuUVNnieso/8F69/7Hgk2i/mG7B8O0mcAfqMzGi/qG6KedSuFS9u3brygIbkBykhPpuQ7S0wJCTnjcacVUU6d0DAmIa2rAx3sgMm/R88yBEmTSqD6uIBbiTEos1Ebsme2uOIgBFekB38nvv+lrdvPr5T8s/SU29pohM82Xb/qO52257hXMWDXEmgFszqHkwYxZ1arxjvHyPBUjJX5mRh4IElA/hGYsu94P0oOP4jPNOCOWHn+g/mRa4028FcleDqz7d5LqTN8ImEdpmOVA8liwcqgnuu/ZN+BboLfd/7CNyK1VSUIcC3aLBwISWGV38JFOg+yNsV7hQwCNIduuVzP3cnxGdxKmf7/gCahN8DcE/S6RtsIF4KWS6UbcYmS9iQTbNp7lpnCxsENDSLm7iEs+cLqlEVh3BmIsqRfjw5pffCT8E51LGTtOD9oQbttH3QK2ka4O2ZgWEBNfgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(66476007)(66946007)(66556008)(8936002)(2906002)(52116002)(8676002)(31686004)(478600001)(16576012)(54906003)(316002)(956004)(2616005)(31696002)(53546011)(5660300002)(83380400001)(44832011)(16526019)(86362001)(186003)(36756003)(26005)(6486002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QktQUnM1VXRqY3BGMWJxcHBrUHpKYmcvWWRMQ3JBb0s0NEgyckJVSzZxRGZm?=
 =?utf-8?B?NndPeU5tYWorM1lwSWczQmc3SlFpQjVJSGVOWmY5K0pEb1h6YU5hdmpoUUsz?=
 =?utf-8?B?YkxZeGl5SnRScjlJQXlpV3ZKZzExN2tXQmVaVjFjZkNkR1R4cDdSdmpxek05?=
 =?utf-8?B?RWUxUmluUGRISEtQZ0NpMVJvbU85YkUvVkJ5R1pRdEt0TkJBK0VhYW9ISElM?=
 =?utf-8?B?U2NNZERrdDFrbDNSMlpQNlBHRlZOUzBBTHZjd2FyOTBVZEU3WC8vcTdUOEVQ?=
 =?utf-8?B?RDVLTWMxL0ZDQWVFOFdtWERkWUxSbVZ6dHZUZm1GRzNLd1hPT0lGNXY4UkF3?=
 =?utf-8?B?RDU4VERyS1pHdFBlT0tFRmdJZXlZZHFZa3Z0RmZETGphT1pTeUE1dkNhWW1N?=
 =?utf-8?B?b0QzV3RzL2J1TnZuY0hHVnFmQmFCdUJHWldOVnRoUGh4N3VXQnFXMUxTblVm?=
 =?utf-8?B?Q2tmQ2hvcitabW5SODNpQ2l3cGdFdnRaZHM3L2dxOUFncGhBWTkrTjFpY3ZC?=
 =?utf-8?B?V0puZWY4UmZtVno1YzlPczQzMWNQZ0ZZc2JsTXRtdm9iMzJsVEpub3BpMjZu?=
 =?utf-8?B?SEd3WU9SQzZPNndnWEtWakdlL3ZRaUE1TWY2dzUxWXpkTTdqYytLTmR6ZnFI?=
 =?utf-8?B?citSa2poTEUrQUsrYmVmNzJnMkFZckJZYy9Nd05BTUkxSUR5MDdDZS9MN3Zz?=
 =?utf-8?B?QmNocTY5eGdubWxiK0JYSUZqa3dNRkVvV2hwVkJOR2NlMXNWVXdCODk3QnpH?=
 =?utf-8?B?MCtUWmZsRitXU1ZPWlJZbWo5MXplSGlqY1l5eHA2NGVtdUFaU3UzOTNjV0Nm?=
 =?utf-8?B?NUxjVXZKV3dWcklnbjhHM28wMEsxcGF2QkNDOTB5WEt2a2V1ZGZXQlhqY2Y0?=
 =?utf-8?B?eUN2TmlPeWtOdWwwSzg3dDNKSTQ5N0R0bFV5TnBDYWVTV2xUQjVxUndrclJZ?=
 =?utf-8?B?KzhJMklIZ20ra0dpcnEyYkIzUHE3cjhkeUlrZHpiMU9Gdk12MWZGODlDYkow?=
 =?utf-8?B?MEtFU2hTclNCdDFhcWYyZEFMN29uRExROC9ZYlJEejE1alp5QTlpaFJ1dHcv?=
 =?utf-8?B?eHJjT1VwY0pDell4SVFZN2ttUnhsNzBhMzZveVMxaUdrQUhNbFFLYkVHOWF5?=
 =?utf-8?B?QXpLOCtONml5SFY2cWlvRWNNem1uUzAxUnNidGdoL1dZc3hWdW8zZDUxdk56?=
 =?utf-8?B?UFVsWXlaUmU5NE9rdzlJa1BPaTA5K0FzQ3JZdXJNNEhMcHJIRHZHNVkvVGNp?=
 =?utf-8?B?cW9SVllZYlpxUWpxWDN1MXpKTGR1VU9pbFl1cHFUSlVWRngrMmlSVnBDSmp6?=
 =?utf-8?B?YUtXSEw2dk9ubWVuWjV5QUVLZHVjS1hPUys5NytNd29mRTkzYldyVk92ajNY?=
 =?utf-8?B?bEpUV2VwU2t5NzNUdUkrL3g3YllHN3owNXg1VldvSk9lcVgzUHd1TDU2ZXdC?=
 =?utf-8?Q?pXFrwG0K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d44f5d-b4a4-4ee2-5da2-08d8c17c7964
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 21:59:23.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBa4dBHgsvdkgRW1HXFlhtZebMK9uyYb7B9AwBs07sxVs6jc7t4mPM1uw6uVCkeYaZQrMz/ZZ/Sqhhd8SP6TbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/21 8:32 PM, Randy Dunlap wrote:
> Add qualifying build option legend [CMA] to kernel boot options
> that requirce CMA support to be enabled for them to be usable.
> 
> Also capitalize 'CMA' when it is used as an acronym.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> v2: rebase & resend
> 
>  Documentation/admin-guide/kernel-parameters.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks,

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> --- linux-next-20210122.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20210122/Documentation/admin-guide/kernel-parameters.txt
> @@ -631,7 +631,7 @@
>  			kernel/dma/contiguous.c
>  
>  	cma_pernuma=nn[MG]
> -			[ARM64,KNL]
> +			[ARM64,KNL,CMA]
>  			Sets the size of kernel per-numa memory area for
>  			contiguous memory allocations. A value of 0 disables
>  			per-numa CMA altogether. And If this option is not
> @@ -1556,12 +1556,12 @@
>  	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
>  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>  
> -	hugetlb_cma=	[HW] The size of a cma area used for allocation
> +	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
>  			of gigantic hugepages.
>  			Format: nn[KMGTPE]
>  
> -			Reserve a cma area of given size and allocate gigantic
> -			hugepages using the cma allocator. If enabled, the
> +			Reserve a CMA area of given size and allocate gigantic
> +			hugepages using the CMA allocator. If enabled, the
>  			boot-time allocation of gigantic hugepages is skipped.
>  
>  	hugepages=	[HW] Number of HugeTLB pages to allocate at boot.
> 
