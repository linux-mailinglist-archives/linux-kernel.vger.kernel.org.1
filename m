Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518729DBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390691AbgJ2AJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:09:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18948 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgJ2AIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:08:48 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09T00Swl024749;
        Wed, 28 Oct 2020 17:08:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hZkRcOJBenEEjq0n8hXWPT8hSk+Mra9aXENbw2n1iSY=;
 b=FBoC+OiciGQyyhQ8spAonSd3VsM05n5YKYJlF4QTscaYGFAsb8iLmHIVqSIB8+wPrDt0
 3tBzDbzeGou/Se+/m5OrvnL6P6sAypXx1V92j3MTkqVAorpXupDxiueBXXXumkLWomGU
 VlkgvU9qPcNjdO0SXDDuNJbXekKTl9nwm6I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34ejk2aj07-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Oct 2020 17:08:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 17:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihBHOvI80E5ZLthgahIjrUHoTsFV42KBUOYXYCX7FUISj5PKxtDRdfgjZG3ntq4W1dvz4PRg1BI41E36fRc1i3HujsjwO4A5pLwfIKM78rvm/8BXmyzayIw3M85fHT6kwrXkndx6anORx1M55Ma2MVq9Sz0hzhJVkh7F+y9igQcEQOoS7WwLN5JNojwtqm73S/GdIe2kOGNPjT3m5t5zfmJZ0OtuMaROtbXKn2tKnymSHJ556I9Y4sNNjyT90Fqbr0uJTq1oTn8XT3lb8oFjLo1JkwF4G6Ii27SxPLHKMwvKZfXL3ozni3akmS1TxcQ/uvd398OZlu3fcc0WSw67Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZkRcOJBenEEjq0n8hXWPT8hSk+Mra9aXENbw2n1iSY=;
 b=dYN2J39a/iAB8BKVuh3R2BtEESoa3XugviBXt7Z/sDZRFsGMAHVFnWLm+5HTLUbAN5Y+e3HrouKpvZxUydaVdCUOIw6pjKL8aK7VTEfPyoy5MnDY7F6kT18Exwd0meB6iDp9HXcMn0BCfQ0xJAH3SitXqAqyfAuPIBPhM1vgG8YfctZ0IIig4u6iw8SudLhAs/ICGDrvlhfKatj2JpXxq/O5xjvOa0S9CfVhOrk0wZaXKQRigXYeFLRx6sB/d7zVl0ASYVFcumjlh0PERciiZpUS8Fb8jjo4NAmg2lDfDgsNu+tge3reZcOKVhY7BkS575mxP5mwxDQhx4/DpRS4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZkRcOJBenEEjq0n8hXWPT8hSk+Mra9aXENbw2n1iSY=;
 b=Zft6RZZgJbo83UHy2AYYFJzMB85wZ6mXRIXDxgBQepStLTemCfOG0k75MkQ2/EKgBNLIcVp1UVzAtnhUqTX244Nn9h7Pc1Jcvu1LmQRZtI5mdLdyYTcpR2gMKrQ3sKEbIVuJsx6hAlFr95hdSltA9u0yH7qL9Iuwee5ahrRSvCo=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 00:08:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 00:08:02 +0000
Date:   Wed, 28 Oct 2020 17:07:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cl@linux.com>, <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <shakeelb@google.com>, <hannes@cmpxchg.org>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: Higher slub memory consumption on 64K page-size systems?
Message-ID: <20201029000757.GE827280@carbon.dhcp.thefacebook.com>
References: <20201028055030.GA362097@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028055030.GA362097@in.ibm.com>
X-Originating-IP: [2620:10d:c090:400::4:c122]
X-ClientProxiedBy: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:c122) by MWHPR1201CA0002.namprd12.prod.outlook.com (2603:10b6:301:4a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 00:08:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f07874a-b5f7-48cb-afc8-08d87b9eb3d1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2710821A0CE708B5472F2730BE140@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Etnibm/FojEsfXUYb5dZPF7V7iyK/HeCskMkrLqo7MYa3FFq0p2stEqQgeUrSdZIsyAa2kfcjmVV16tbLS2IiZ0gf+vCwW+VK7tGFWSSp/LRpKf5O9ymRLxtgMOv2BKDKXMDBiY+2sRfgt9e+KaV/4JAyys1VZWgFcXZrbgmX+7eGYXdRrEEGhlk5p49JdviaVXqOdDsEoNslGWbjgcpeek3OHspdsIWURo9lRx93drJICbJvJQ0JpMaZ3/RuZTTmFjNnY8YrKziazE1DxflsUyedFmf0Fr7i16T3TEs4LU4AzZ+1yHocgQim1ufFMCyeoVuYeEEZ7IFxwcKchdz0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(55016002)(316002)(1076003)(6666004)(66476007)(6506007)(478600001)(86362001)(8936002)(7416002)(186003)(16526019)(66556008)(52116002)(6916009)(8676002)(4326008)(66946007)(7696005)(83380400001)(33656002)(5660300002)(9686003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UHbIcKrIH55dCWm3ocBFUdK4+04kW6Q6bT4GPW5dwtYD+GcKAoWOeksFiZrtspPoymfUDBzwHULZmonq9vxac9AGmrYmTAZn24BI1YXuUMO5s4qDq9zbbIgcDCraiX2OgrGQ9ZK1fAE3AeHjnwwQEgm7hY+GeCwpsO1p7m7tM0fdAlkAw4fTkDOgu4O3xntGo5sZM/OWT90NBwLo13ecFIJiEJICW3Ojlm8XCuv6fmRCVImItNX8OMgkFAeLkSrTcjd5m++y6Q9MDnmEY+Xfd9ZtipPpgxY168K2b8N7YTeToPyPeBs4ewGA/uWQwj0XWa78Gbni0JX57ObcpsjnrtCNguk9JqTazRJoQRICBB8yBvbQTRR6bMQS4kbE7+YZoqMYkllmS0Uwaltn9XBzLuDGpvmukhryVcW+XUXLB/OrS8rM1ELUO/qWNyvcdtZi4B/ZVWM5VuXztRHyB0h46NA7ZGWo9+/JdiL/jzS1mnmYCrGoK6o7OtrnPBkA7wairs1FRtZ00rILg+G2v8JFdAFMJYHX9spRJb2ZmKev92UviXktGl1JmTBCqNJE8xcw8+2pvWx4GplEc+/w+kBeM2YFE0JBBnx4sYZezYzh6ZfV4degMcyj4I89oVHjM62L6iQ6pC7HSOijwor57ImLP6P0jSAg95VPtMVvWcGwsW4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f07874a-b5f7-48cb-afc8-08d87b9eb3d1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 00:08:02.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgWVt5K7d1qjq1dsdOBmfemM5GD/opp91r6UMLm0rUqmWz3//RUfDEV9Jw430z6z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_09:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 suspectscore=1 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:20:30AM +0530, Bharata B Rao wrote:
> Hi,
> 
> On POWER systems, where 64K PAGE_SIZE is default, I see that slub
> consumes higher amount of memory compared to any 4K page-size system.
> While slub is obviously going to consume more memory on 64K page-size
> systems compared to 4K as slabs are allocated in page-size granularity,
> I want to check if there are any obvious tuning (via existing tunables
> or via some code change) that we can do to reduce the amount of memory
> consumed by slub.
> 
> Here is a comparision of the slab memory consumption between 4K and
> 64K page-size pseries hash KVM guest with 16 cores and 16G memory
> configuration immediately after boot:
> 
> 64K	209280 kB
> 4K	67636 kB
> 
> 64K configuration may never be able to consume as less as a 4K configuration,
> but it certainly shows that the slub can be optimized for 64K page-size better.
> 
> slub_max_order
> --------------
> The most promising tunable that shows consistent reduction in slab memory
> is slub_max_order. Here is a table that shows the number of slabs that
> end up with different orders and the total slab consumption at boot
> for different values of slub_max_order:
> -------------------------------------------
> slub_max_order	Order	NrSlabs	Slab memory
> -------------------------------------------
> 		0	276
> 	3	1	16	207488 kB
>     (default)	2	4
> 		3	11
> -------------------------------------------
> 		0	276
> 	2	1	16	166656 kB
> 		2	4
> -------------------------------------------
> 		0	276	144128 kB
> 	1	1	31
> -------------------------------------------
> 
> Though only a few bigger sized caches fall into order-2 or order-3, they
> seem to make a considerable difference to the overall slab consumption.
> If we take task_struct cache as an example, this is how it ends up when
> slub_max_order is varied:
> 
> task_struct, objsize=9856
> --------------------------------------------
> slub_max_order	objperslab	pagesperslab
> --------------------------------------------
> 3		53		8
> 2		26		4
> 1		13		2
> --------------------------------------------
> 
> The slab page-order and hence the number of objects in a slab has a
> bearing on the performance, but I wonder if some caches like task_struct
> above can be auto-tuned to fall into a conservative order and do good
> both wrt both memory and performance?
> 
> mm/slub.c:calulate_order() has the logic which determines the the
> page-order for the slab. It starts with min_objects and attempts
> to arrive at the best configuration for the slab. The min_objects
> is starts like this:
> 
> min_objects = 4 * (fls(nr_cpu_ids) + 1);
> 
> Here nr_cpu_ids depends on the maxcpus and hence this can have a
> significant effect on those systems which define maxcpus. Slab numbers
> post-boot for a KVM pseries guest that has 16 boottime CPUs and varying
> number of maxcpus look like this:
> -------------------------------
> maxcpus		Slab memory(kB)
> -------------------------------
> 64		209280
> 256		253824
> 512		293824
> -------------------------------
> 
> Page-order is a one time setting and obviously can't be tweaked dynamically
> on CPU hotplug, but just wanted to bring out the effect of the same.
> 
> And that constant multiplicative factor of 4 was infact added by the commit
> 9b2cd506e5f2 - "slub: Calculate min_objects based on number of processors."
> 
> Reducing that to say 2, does give some reduction in the slab memory
> and also same hackbench performance with reduced slab memory, but I am not
> sure if that could be assumed to be beneficial for all scenarios.
> 
> MIN_PARTIAL
> -----------
> This determines the number of slabs left on the partial list even if they
> are empty. My initial thought was that the default MIN_PARTIAL value of 5
> is on the higher side and we are accumulating MIN_PARTIAL number of
> empty slabs in all caches without freeing them. However I hardly find
> the case where an empty slab is retained during freeing on account of
> partial slabs being lesser than MIN_PARTIAL.
> 
> However what I find in practice is that we are accumulating a lot of partial
> slabs with just one in-use object in the whole slab. High number of such
> partial slabs is indeed contributing to the increased slab memory consumption.
> 
> For example, after a hackbench run, I find the distribution of objects
> like this for kmalloc-2k cache:
> 
> total_objects		3168
> objects			1611
> Nr partial slabs	54
> Nr parital slabs with
> just 1 inuse object	38
> 
> With 64K page-size, so many partial slabs with just 1 inuse object can
> result in high memory usage. Is there any workaround possible prevent this
> kind of situation?
> 
> cpu_partial
> -----------
> Here is how the slab consumption post-boot varies when all the slab
> caches are forced with the fixed cpu_partial value:
> ---------------------------
> cpu_partial	Slab Memory
> ---------------------------
> 0		175872 kB
> 2		187136 kB
> 4		191616 kB
> default		204864 kB
> ---------------------------
> 
> It has been suggested earlier that reducing cpu_partial and/or making
> cpu_partial 64K page-size aware will benefit. In set_cpu_partial(),
> for bigger sized slabs (size > PAGE_SIZE), cpu_partial is already set
> to 2. A bit of tweaking there to introduce cpu_partial=1 for certain
> slabs does give some benefit.
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a28ed9b8fc61..e09eff1199bf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3626,7 +3626,9 @@ static void set_cpu_partial(struct kmem_cache *s)
>          */
>         if (!kmem_cache_has_cpu_partial(s))
>                 slub_set_cpu_partial(s, 0);
> -       else if (s->size >= PAGE_SIZE)
> +       else if (s->size >= 8192)
> +               slub_set_cpu_partial(s, 1);
> +       else if (s->size >= 4096)
>                 slub_set_cpu_partial(s, 2);
>         else if (s->size >= 1024)
>                 slub_set_cpu_partial(s, 6);
> 
> With the above change, the slab consumption post-boot reduces to 186048 kB.
> Also, here are the hackbench numbers with and w/o the above change:
> 
> Average of 10 runs of 'hackbench -s 1024 -l 200 -g 200 -f 25 -P'
> Slab consumption captured at the end of each run
> --------------------------------------------------------------
> 		Time		Slab memory
> --------------------------------------------------------------
> Default		11.124s		645580 kB
> Patched		11.032s		584352 kB
> --------------------------------------------------------------
> 
> I have mostly looked at reducing the slab memory consumption here.
> But I do understand that default tunable values have been arrived
> at based on some benchmark numbers. Are there ways or possibilities
> to reduce the slub memory consumption with the existing level of
> performance is what I would like to understand and explore.

Hi Bharata!

I wonder how the distribution of the consumed memory by slab_caches
differs between 4k and 64k pages. In particular, I wonder if
page-sized and larger kmallocs make the difference (or a big part of it)?
There are many places in the kernel which are doing something like
kmalloc(PAGE_SIZE).

Re slub tuning: in general we do care about the number of objects
in a partial list, less about the number of pages. If we can have the
same amount of objects but on fewer pages, it's even better.
So I don't see any reasons why we shouldn't scale down these tunables
if the PAGE_SIZE > 4K.
Idk if it makes sense to switch to byte-sized tunables or just to hardcode
custom default values for the 64k page case. The latter is probably
is easier.

Thanks!
