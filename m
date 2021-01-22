Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3862FF992
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbhAVAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:50:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbhAVAuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:50:08 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10M0UdY2028153;
        Thu, 21 Jan 2021 16:49:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=db6EBGakzIzBZ8AEUGAPK7AfcbbTgRX/iTgax/PEWcM=;
 b=RGyGNzaL+ApCrp7Lthj64di/PoU3cmtO0SGkKg0SC4339jXDtY3hBwvjzcauuPDCkGPY
 /VnKXErGK6zkxO+KtAkHzOb1Mswq8s6i7QxBJmzFK+ZNxJvOw1yRwV12VCnym9LlwIv0
 Fohjlfqx6JRMbc7vcklpaJzrf8Lk39QdJ5E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 367f0129uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 16:49:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 16:48:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na0V/oHH2QIYFAWQzmHEu1Q5hjnm1bkL0ckrXKdi8cnA1BLygdayaNCgYHD4sdY2skTqRm5yBhqvhPWKTd0apoYSY+YSmMCMYZg9B8gapit1Y7Xwr5DxrOLH5mrcYykccwDyw8qcz0ZjkR9Y7i1nK7/VwdERNJXQfXTuhCiXuJIgWvhSQyY0PTdgf42eQj6LbL/fnXyusAMH+9SvdNUoEzlzMnHetk8JM4Aod9n+bV8bMTsRfk83rK6QOZQc/Oi+KOhCzKfojUWZ20iG29qNtWjZehKhgRzwV4XmXl7cD0Cy7V8mIhQfhD2/M+KxHkzGoQYYo65+Hfl9LmLqRMyh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db6EBGakzIzBZ8AEUGAPK7AfcbbTgRX/iTgax/PEWcM=;
 b=i3cdhRb8WWMDLO9lLQr8qAyfxQYsNToXNQiEKacpQbNk8imABa8uIX8tEnUgiR8ohoNkRBlchrsksJwW8jY2z85fg71Y9Q2HTBXmgfyygNGOz17jd1ZM48w5Q8I4N2ABabHmMy1sh0PXz0y7wjHU53GfbEpLgF3V0xHtOjZzywi6VAE9sFKYcRktrv779oLGUWNedbjBf5DeCfXQ2SIzhPetxnM3H2AcBqVnAI5L6XeHGjE2F8m0gM8n/YjkGoDxJsQPMwsf3RrD41hcQ42WopfLIIbHbHSx1veK4LF/e76RDByRthakwPB7mM1nWpBOAkmiTdQeFBZaJOsUMSrFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db6EBGakzIzBZ8AEUGAPK7AfcbbTgRX/iTgax/PEWcM=;
 b=jCVWyMbgPmeWx9RL/40CuZm+BKvOF6fi3peXQKLLW5n9EYSiiCHJ7cipCV+zU8/tm3dEpmaCgnQwcovLdxV5ouz7v3KLgkNEAW4Ptk3Xn1iccJ7MYeDayOnB3HeukqtnKB0KB2vH6LF+/nnTnStvieR4h89IPDu0VoqdLw0kO2A=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 00:48:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 00:48:53 +0000
Date:   Thu, 21 Jan 2021 16:48:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <akpm@linux-foundation.org>, <bigeasy@linutronix.de>,
        <cl@linux.com>, <hannes@cmpxchg.org>, <iamjoonsoo.kim@lge.com>,
        <jannh@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mhocko@kernel.org>, <minchan@kernel.org>,
        <penberg@kernel.org>, <rientjes@google.com>, <shakeelb@google.com>,
        <surenb@google.com>, <tglx@linutronix.de>
Subject: Re: [RFC 2/2] mm, slub: add shrinker to reclaim cached slabs
Message-ID: <20210122004847.GA25567@carbon.dhcp.thefacebook.com>
References: <aa02cf86-3a83-2e55-3bb6-3ec1c0f71b11@suse.cz>
 <20210121172154.27580-1-vbabka@suse.cz>
 <20210121172154.27580-2-vbabka@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121172154.27580-2-vbabka@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:a743]
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a743) by MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 00:48:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94af4573-f5fe-4cf2-cadd-08d8be6f7da3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2598FAAEB9A6BD0AC92BC2B6BEA00@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLCF21HxfXWC1HipN0SwQFWLTpWt54WE6hr9ztoX1xddZ0HJaTQpzVJy9KVBxrVD2W1+1vLl50HUm/aKqL1xqJ9RRgKcyVZFRzlUqMoPtG5OkPLMdtY8q9GX51mREXosAL+fckH/SUKpde8BYt0P2jRmWZb363nC9sFJHpHh17NsMRDNAub/s5eWVhBRkJ72zedWkVszCNRTgus8EtNO9sFmfJAkmPi8XWJ9zqnTp5LmzTeYPSs88esZX5PBaywDnuPZGXhFVlpkpPQIVXyu9B+WJYsdpPRS1xhrzgh7gRMEoQ/UEYy6D1m6AOkTfjoHiOrX8BWKymKNMvrlpzgV2C2hLcz/8wE9whl1hQKP9r3FwMHXuyR5lfJwujP6HMDls1MIpy7lRa9FvJ6fu41hpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(6666004)(33656002)(6916009)(66946007)(52116002)(5660300002)(55016002)(8676002)(8936002)(86362001)(9686003)(7416002)(2906002)(83380400001)(1076003)(6506007)(4326008)(498600001)(186003)(66476007)(66556008)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PaleHyYf3/rDfr/GCKIVDcFTTN0jc0Mph7NrBQ7pHmI3xw/ev94lYhC2Nr2v?=
 =?us-ascii?Q?lYSstVa5l4KxK6bG7oQMlll4+n+R3qYGS29JHGmVk15sAUCHXho6ndQXBvWS?=
 =?us-ascii?Q?5Z6LKLS8+pAR3NtOGn7476C2MfyErx+iWZLWZnmQr7S39L2ERSM+SLoGrMlI?=
 =?us-ascii?Q?SMqr3RfFYmhfuGAG1S80dg6AIxd0Z0EBgthQuurMeC1WD8C8LjPgBAdnVX6Z?=
 =?us-ascii?Q?8ASfd3D5Kfqywiv76qFXF397rx7QVGTGFpwzO4O1aIUiIPvN/SELbFCdOtlF?=
 =?us-ascii?Q?YUBtiVvW6UYItEYlHPeQS9Elo3BNMDb/PSWH9bamgFVWZAKrDPkWlZuckZma?=
 =?us-ascii?Q?EWVvuqfiEz/VzcWqIZFaPBSAG+r2yUmF66mT5jx+0tg26V9B41D/qkb0GDeZ?=
 =?us-ascii?Q?CL5P9WTJFtuyoHN1nybXi6MQjreuey8nmrDCsTxJ/KF/wJKBuHBRpDVrJfN1?=
 =?us-ascii?Q?5tAD5dNGLDnKvEIUXY1wUrjpJxUp62FpFQYNYMe/93ZZcOA7aGhYOfQGXryK?=
 =?us-ascii?Q?luKvRjboebQ5LUVISAwe+hKw6LBoG4+mLvCAs4WqG30F8tUJnBhxQb3biRzd?=
 =?us-ascii?Q?/jYhQjd4+cJTWl4nTh69B0D/wEgsV/C7v+ShvwUidsAb7qlV7Ueyqfw0uxXL?=
 =?us-ascii?Q?Syemp1B0ZeqzyK+80S3tITR1K6F+mcytsJbYbYsCmW+/6AQ2YLjyfVZ7EZqF?=
 =?us-ascii?Q?YYvwzldqpsg935EOmFbsE0AKI26fwU7f1Y6fkMpnGiEmJ42ehMP2B97swr5E?=
 =?us-ascii?Q?tk0jtmdMV6nEBi/1Hshw5HItNT4Xsly0aphEk1CRmCPvrdh6B/kXn271tmMb?=
 =?us-ascii?Q?v4ziK4oNhc/Xvb1RmhB7oPsGc86HBiCN9XUjdIe+JtSv0A6u4a0qrXClNEOI?=
 =?us-ascii?Q?7qhcjJdPzaJz7YTQX/e2YuaVkSj58ainNIDpjVAeFcK4fpApQiVpg5lkSqXi?=
 =?us-ascii?Q?gNE73xu+U2oLn56Js4lMsctf4zXnARVtYEa0ULqyg6xclpxo9s/tRoG9sESi?=
 =?us-ascii?Q?EtonO7738UX7opTT5me0VRZ+2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94af4573-f5fe-4cf2-cadd-08d8be6f7da3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 00:48:53.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQstZMCTgkBq/LPdGy4M/a7fLSBC0eGZp7OUntqi2GmSwNh/94l0Tmbf+NntcuDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_11:2021-01-21,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101220000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 06:21:54PM +0100, Vlastimil Babka wrote:
> For performance reasons, SLUB doesn't keep all slabs on shared lists and
> doesn't always free slabs immediately after all objects are freed. Namely:
> 
> - for each cache and cpu, there might be a "CPU slab" page, partially or fully
>   free
> - with SLUB_CPU_PARTIAL enabled (default y), there might be a number of "percpu
>   partial slabs" for each cache and cpu, also partially or fully free
> - for each cache and numa node, there are caches on per-node partial list, up
>   to 10 of those may be empty
> 
> As Jann reports [1], the number of percpu partial slabs should be limited by
> number of free objects (up to 30), but due to imprecise accounting, this can
> deterioriate so that there are up to 30 free slabs. He notes:
> 
> > Even on an old-ish Android phone (Pixel 2), with normal-ish usage, I
> > see something like 1.5MiB of pages with zero inuse objects stuck in
> > percpu lists.
> 
> My observations match Jann's, and we've seen e.g. cases with 10 free slabs per
> cpu. We can also confirm Jann's theory that on kernels pre-kmemcg rewrite (in
> v5.9), this issue is amplified as there are separate sets of kmem caches with
> cpu caches, per-cpu partial and per-node partial lists for each memcg and cache
> that deals with kmemcg-accounted objects.
> 
> The cached free slabs can therefore become a memory waste, making memory
> pressure higher, causing more reclaim of actually used LRU pages, and even
> cause OOM (global, or memcg on older kernels).
> 
> SLUB provides __kmem_cache_shrink() that can flush all the abovementioned
> slabs, but is currently called only in rare situations, or from a sysfs
> handler. The standard way to cooperate with reclaim is to provide a shrinker,
> and so this patch adds such shrinker to call __kmem_cache_shrink()
> systematically.
> 
> The shrinker design is however atypical. The usual design assumes that a
> shrinker can easily count how many objects can be reclaimed, and then reclaim
> given number of objects. For SLUB, determining the number of the various cached
> slabs would be a lot of work, and controlling how many to shrink precisely
> would be impractical. Instead, the shrinker is based on reclaim priority, and
> on lowest priority shrinks a single kmem cache, while on highest it shrinks all
> of them. To do that effectively, there's a new list caches_to_shrink where
> caches are taken from its head and then moved to tail. Existing slab_caches
> list is unaffected so that e.g. /proc/slabinfo order is not disrupted.
> 
> This approach should not cause excessive shrinking and IPI storms:
> 
> - If there are multiple reclaimers in parallel, only one can proceed, thanks to
>   mutex_trylock(&slab_mutex). After unlocking, caches that were just shrinked
>   are at the tail of the list.
> - in flush_all(), we actually check if there's anything to flush by a CPU
>   (has_cpu_slab()) before sending an IPI
> - CPU slab deactivation became more efficient with "mm, slub: splice cpu and
>   page freelists in deactivate_slab()
> 
> The result is that SLUB's per-cpu and per-node caches are trimmed of free
> pages, and partially used pages have higher chance of being either reused of
> freed. The trimming effort is controlled by reclaim activity and thus memory
> pressure. Before an OOM, a reclaim attempt at highest priority ensures
> shrinking all caches. Also being a proper slab shrinker, the shrinking is
> now also called as part of the drop_caches sysctl operation.

Hi Vlastimil!

This makes a lot of sense, however it looks a bit as an overkill to me (on 5.9+).
Isn't limiting a number of pages (instead of number of objects) sufficient on 5.9+?

If not, maybe we can limit the shrinking to the pre-OOM condition?
Do we really need to trip it constantly?

Thanks!
