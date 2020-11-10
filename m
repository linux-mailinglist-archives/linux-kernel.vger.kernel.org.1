Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED22ACA76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgKJB2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:28:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57362 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKJB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:28:34 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA1R9tq025239;
        Mon, 9 Nov 2020 17:28:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e6HRoyaKPfXwBc0aMQ17wq8BhI98P4zkPjZXb9QBcGU=;
 b=WGkilvqKJXHKA5zcXvCofHW5O/6jQz40AqiUM/6wg6wF0BcuidtBhi36LoQ8z6KeJEhK
 rketpCxcl480zZ1TANiJojfzurEz64aH2wDmROs3CpWHdzHHwTMP7K4xk5I7rQzwGAd6
 hbL6+M2doDNWs9mD1TP474/Jm3nW5J4NSNw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34pch9r04f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Nov 2020 17:28:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 17:28:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfv1/lqK8QwMXaGAmAS3HA9H+gkkDrD9GOCHNwGswdQiKLj7k4t0UeUV3swt0TWFYQlshWYnRCPT0d99jI/L1c5Mk+m1+WzVzcvozYV7EWSwM0cK7+NRfWD3z0Jkqz33+SAjWFrruqm+nYrHpMV0Quu02y13XhNvvDzAxGIlfteAFOBXUfwFaQhisz1lWZ4KiC+fk1Hl0l40FoUcvrWVo463gWXE/Oh3iNdRggm9rRS4ne8fTGeS5ZaZWitScYB6WCw/JQfG6Tz51icyV/hCz27Q6c32F31L4Pg6zO+0tiK3d9h6gLy6nF241JlKqjQUCvfuLpgQT0j1kZOX5JN5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6HRoyaKPfXwBc0aMQ17wq8BhI98P4zkPjZXb9QBcGU=;
 b=BQx4MKl6AiA0323ERavV+nClF51Btu4SpUrZsagUi4QGvnccxC2ZdNnzUjU1gULZGXhInFlLijqmRsZmA4Yy52IuR/5z3CkVp//oyngJu+MJQ/BUXJkvUlTMkhgyBa2ztJrgZ700MF1G8MAy9mUTSPSFWCVGVH29pFNf7JIUE3yISriEMvRHuZdGcafBdmJ4cv1ldL1eKcDf0jDKv0VpVity5OKibEQ2mcgFtbRIkIEsyniuK+aJULLBNjha5ww5XAgpLUZZrRHE9F8WRYKKM1kDCES9kEgtohEJ1aBW71imu0JYW3PycqYa4nq1xEkPfcaMtxRepzQN2iCGUmfxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6HRoyaKPfXwBc0aMQ17wq8BhI98P4zkPjZXb9QBcGU=;
 b=bTML3rItJqcvT5vPnZuYcBLZuaWzOzQKE3/vn1JJn1UOskjK2LVgoVA2Vd4L/Woo1Zpl3QorQGlnOQ1OmDSd32EG2JjslNY+XxPC1mnWpH61bcRMnt7rktQcUY2AXC8nLBL7b/Kkq1/7kvzlc5fVfEdUWiSG6QANqrwbqda1yMI=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3682.namprd15.prod.outlook.com (2603:10b6:a03:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 01:28:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 01:28:09 +0000
Date:   Mon, 9 Nov 2020 17:27:58 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        <ltp@lists.linux.it>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201110012758.GA2612097@carbon.dhcp.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
 <20201023163053.GB535375@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023163053.GB535375@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:10aa]
X-ClientProxiedBy: CO2PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:104:3::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:10aa) by CO2PR06CA0053.namprd06.prod.outlook.com (2603:10b6:104:3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 01:28:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe3c332-c2c0-4ac8-8713-08d88517e1ef
X-MS-TrafficTypeDiagnostic: BY5PR15MB3682:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3682720EAE1977943B2437E9BEE90@BY5PR15MB3682.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IAbqTULEfsWcPwx8dNUtAMKiv+0g0i+hv1/jVjvzCwBM4cqsz8tg3OWw+aNxGi9zs6jctNXaXSpDjvhX6lJFNdVMTjoFpseumXcwDZZ3IBKz2d2RtJd50Z6GBM5Do0Et4OGYCkTcudXj6Qw0HI/wip5wKvwaQaTMDOP64hrlebRODqCCqs81QwN4cWUh/0ZHDEvqJaObOTuXIMY/tQr0g+WH+vJvnxf5PsTAd5s4Uyiv6hk4yw2SWBVCT9N2WXECu1hr1WwEerdHxDJ+eAhufZ/kBVQPifVKXmg8dmxPb8E2754FUEGwiICO+NMm8HACr6yS3cj+ZmFhRijwjNpyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(376002)(346002)(54906003)(316002)(7696005)(53546011)(52116002)(6506007)(6916009)(86362001)(4326008)(8936002)(7416002)(8676002)(2906002)(83380400001)(66946007)(5660300002)(33656002)(478600001)(55016002)(9686003)(1076003)(66556008)(66476007)(6666004)(186003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Sc1BbKoPZSAOx98seMdS13PXjD6G2UItNxIMed8L6wNbjkDULTokqaU/PbX5djBkoBQRvbiDBrCLmUHyJstElNxMSxqXqhKIz008YkU6bMgZ9Z3ACXZvswy8QYCtOl3EK7at9A0cB+2EwAk7oLVtS5Q34suazfOI0TSOwJek0viMD14OE90cdvDpNyNvf/DFg3WfOqXpM/oRFHftr0UGtTFja0Lgd4m9msng7CgzhDFIu+tAgyKAGGZvKzmAna0F74s69uGx6nZkYXfo+NkYafFmK6+61/FC2vOUZz5lzjd83FkvEHSQGkP0B1AfrB0dAcBv4frHWNeJhu2mmwXX2WgWIFMryh3/mjboPov2O/boI/hj3Z902PmAqGWrAR9hrnlWWNYGIcwmlfxf2rnjX8ugXMt0HryErX5/eNsCO65OoZP87mt46/80J0XlkIho7fSBFebuDMDC61BFqVBbBB+/Njm/PrMNxQEqLAbRQDfEQeERpPHn7vAHWd176g985g3qr7B7OPivi8hwb1doXUc79+DskNJ9IHU0UQFVyUF/fzhoBSIrqbZ5KJMjJy+b7pgsU0wsWmNm2jobHNV/w4zsP1Q3NaULchFQb9gBwJX+LdqCp6MgO+C4bfIq4o4GDbqw01clIvnYDffLM1omlpaZa/Xozupo74kopJYx4eU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe3c332-c2c0-4ac8-8713-08d88517e1ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 01:28:09.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kojzAPiAeJCPBl1gUA1s50/NThBiEbp7R2jC3+sIDjdkft2MocTXj1G6PyMWWL+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3682
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 suspectscore=1 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 12:30:53PM -0400, Johannes Weiner wrote:
> On Wed, Oct 21, 2020 at 12:33:22PM -0700, Roman Gushchin wrote:
> > On Tue, Oct 20, 2020 at 02:18:22PM -0400, Johannes Weiner wrote:
> > > On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> > > > If we want these counter to function properly, then we should go into the opposite
> > > > direction and remove the special handling of the root memory cgroup in many places.
> > > 
> > > I suspect this is also by far the most robust solution from a code and
> > > maintenance POV.
> > > 
> > > I don't recall the page counter at the root level having been a
> > > concern in recent years, even though it's widely used in production
> > > environments. It's lockless and cache compact. It's also per-cpu
> > > batched, which means it isn't actually part of the memcg hotpath.
> > 
> > 
> > I agree.
> > 
> > Here is my first attempt. Comments are welcome!
> > 
> > It doesn't solve the original problem though (use_hierarchy == false and
> > objcg reparenting), I'll send a separate patch for that.
> > 
> > Thanks!
> > 
> > --
> > 
> > From 9c7d94a3f999447417b02a7100527ce1922bc252 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Tue, 20 Oct 2020 18:05:43 -0700
> > Subject: [PATCH RFC] mm: memcontrol: do not treat the root memory cgroup
> >  specially
> > 
> > Currently the root memory cgroup is treated in a special way:
> > it's not charged and uncharged directly (only indirectly with their
> > descendants), processes belonging to the root memory cgroup are exempt
> > from the kernel- and the socket memory accounting.
> > 
> > At the same time some of root level statistics and data are available
> > to a user:
> >   - cgroup v2: memory.stat
> >   - cgroup v1: memory.stat, memory.usage_in_bytes, memory.memsw.usage_in_bytes,
> >                memory.kmem.usage_in_bytes and memory.kmem.tcp.usage_in_bytes
> > 
> > Historically the reason for a special treatment was an avoidance
> > of extra performance cost, however now it's unlikely a good reason:
> > over years there was a significant improvement in the performance
> > of the memory cgroup code. Also on a modern system actively using
> > cgroups (e.g. managed by systemd) there are usually no (significant)
> > processes in the root memory cgroup.
> > 
> > The special treatment of the root memory cgroups creates a number of
> > issues visible to a user:
> > 1) slab stats on the root level do not include the slab memory
> >    consumed by processes in the root memory cgroup
> > 2) non-slab kernel memory consumed by processes in the root memory cgroup
> >    is not included into memory.kmem.usage_in_bytes
> > 3) socket memory consumed by processes in the root memory cgroup
> >    is not included into memory.kmem.tcp.usage_in_bytes
> > 
> > It complicates the code and increases a risk of new bugs.
> > 
> > This patch removes a number of exceptions related to the handling of
> > the root memory cgroup. With this patch applied the root memory cgroup
> > is treated uniformly to other cgroups in the following cases:
> > 1) root memory cgroup is charged and uncharged directly, try_charge()
> >    and cancel_charge() do not return immediately if the root memory
> >    cgroups is passed. uncharge_batch() and __mem_cgroup_clear_mc()
> >    do not handle the root memory cgroup specially.
> > 2) per-memcg slab statistics is gathered for the root memory cgroup
> > 3) shrinkers infra treats the root memory cgroup as any other memory
> >    cgroup
> > 4) non-slab kernel memory accounting doesn't exclude pages allocated
> >    by processes belonging to the root memory cgroup
> > 5) if a socket is opened by a process in the root memory cgroup,
> >    the socket memory is accounted
> > 6) root cgroup is charged for the used swap memory.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> This looks great.
> 
> The try_charge(), cancel_charge() etc. paths are relatively
> straight-forward and look correct to me.
> 
> The swap counters too.
> 
> Slab is a bit trickier, but it also looks correct to me.
> 
> I'm having some trouble with the shrinkers. Currently, tracked objects
> allocated in non-root cgroups live in that cgroup. Tracked objects in
> the root cgroup, as well as untracked objects, live in a global pool.
> When reclaim iterates all memcgs and calls shrink_slab(), we special
> case the root_mem_cgroup and redirect to the global pool.
> 
> After your patch we have tracked objects allocated in the root cgroup
> actually live in the root cgroup. Removing the shrinker special case
> is correct in order to shrink those - but it removes the call to
> shrink the global pool of untracked allocation classes.
> 
> I think we need to restore the double call to shrink_slab() we had
> prior to this:
> 
> commit aeed1d325d429ac9699c4bf62d17156d60905519
> Author: Vladimir Davydov <vdavydov.dev@gmail.com>
> Date:   Fri Aug 17 15:48:17 2018 -0700
> 
>     mm/vmscan.c: generalize shrink_slab() calls in shrink_node()
>     
>     The patch makes shrink_slab() be called for root_mem_cgroup in the same
>     way as it's called for the rest of cgroups.  This simplifies the logic
>     and improves the readability.
> 
> where we iterate through all cgroups, including the root, to reclaim
> objects accounted to those respective groups; and then a call to scan
> the global pool of untracked objects in that numa node.

I agree, thank you for pointing at this commit.

> 
> For ease of review/verification, it could be helpful to split the
> patch and remove the root exception case-by-case (not callsite by
> callsite, but e.g. the swap counter, the memory counter etc.).

Sorry for a long pause, here's an update. I've split the patch,
fixed a couple of issues and was almost ready to send it upstream,
but then I've noticed that on cgroup v1 kmem and memsw counters
are sometimes heading into a negative territory and generating a warning
in dmesg. It happens for a short amount of time at early stages
of the system uptime. I haven't seen it happening with the memory counter.

My investigation showed that the reason is that the result of a
cgroup_subsys_on_dfl(memory_cgrp_subsys) call can be misleading at
early stages. Depending on the return value we charge or skip the kmem
counter and also handle the swap/memsw counter differently.

The problem is that cgroup_subsys_on_dfl(memory_cgrp_subsys)'s return value
can change at any particular moment. So I don't see how to make all root's
counters consistent without tracking them all no matter which cgroup version
is used. Which is obviously an overkill and will lead to an overhead, which
unlikely can be justified.

I'll appreciate any ideas, but I don't see a good path forward here
(except fixing a particular issue with root's slab stats with the
Muchun's patch).

Thanks!
