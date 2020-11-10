Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791082ADF22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgKJTOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:14:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42214 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgKJTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:14:24 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJ5G2W011637;
        Tue, 10 Nov 2020 11:14:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=d/QA/QcVaxVj358vjKA24EPjTKYv2IPCBFDf+qbxUM0=;
 b=P3xSrquaXnRBJcW8iPde9W+lctN60DGUItdjcX+eSPrq3mO8yZ2ONhZ16WZ7Z1HCGNeC
 3StMisvwzf0cXx+8VabO5eZUhZkF7LEo69P0LBwD6qcRv5rZpNXjko2nv6jDvo+OWaTD
 b6PpRpZpCC0thVcaDdlzOk46gE76gudhhnc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34qye8gjkj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Nov 2020 11:14:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 11:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1PrcP1nW3TFu7l+ssjPodgpAJN9taxkPqgRJ3o1vVcKeGxF1Ew2lmeB4VsmXzjEdJ6Ioj+xPYGcA7vKToC+0XLAMoisLWzyRPYv0zPt5BxqTriVrdRFh+W2BgyKirgNDrHwHXunCqe5enwwUdzcnRuosATD5fTNCthhP9nH0SIlq0tqvqV1pcDHjo8yhh6EBpFtt3lQDBki4ulyef422aQ4dc6O4VaHtLhSSZN6hVED3XXoeeAzmMABD16cpCtXh5HGbfhNKbI4cK2y8y8BP5HyHzPD9oxp48sLdQP/t4XK+BxpiAmyvWBL8Fzy1d40axVjYy040wRtwTMZDdYxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/QA/QcVaxVj358vjKA24EPjTKYv2IPCBFDf+qbxUM0=;
 b=jnUHjvLJ0QZ1ITF7Qsjn74h3S1cDBbcQKkqq6d9FGGvrwrsmgAuMUl4sWiHVHhXYW6+jIIaJ1gPXc2W1GKjiqgN6NlV+xNfetmowgIyShjdLvi1R77go6xKjVPaAjpKfnImKwVNIZA6vVIfwfh3zSsOSMpi6USMXVrJAjk2A8H77kfHElwsAgz0F2PTaxDJ0kcUcD52hZ/MugnTlZq7mghgh5bBhuEYVNA7skXTRqBYSHvRx4+YiRcp5aay8Ar+Ri2CV+l4K4+cr9feBjnwQB0PixGsv0pATkbGN0TX2B4mOmaZA2IXe/Humu7Kz3LS+vzVAtBV/d35KZBptoIcuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/QA/QcVaxVj358vjKA24EPjTKYv2IPCBFDf+qbxUM0=;
 b=jyLPqhTw6ZOGbOIZ4vSL+SjkDqmXsyQKslPDRdoTbZjQ6oTNIsbZEZv76AeC1V+INt9wxy9bHm/WbLl+4zP+fXMvy+zmZGuo28awy/2YKAd/BW+FuW56Jvs33dreoVBHyvkh+8ooCfR8vf+Oy3zGZf/oz5E/YX5YGL3Qzgosgxk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2389.namprd15.prod.outlook.com (2603:10b6:a02:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 19:13:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 19:13:29 +0000
Date:   Tue, 10 Nov 2020 11:13:23 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201110191323.GA2695341@carbon.dhcp.thefacebook.com>
References: <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <20201020162714.GC46039@blackbook>
 <20201020170717.GA153102@carbon.DHCP.thefacebook.com>
 <20201020181822.GA397401@cmpxchg.org>
 <20201021193322.GA300658@carbon.dhcp.thefacebook.com>
 <20201023163053.GB535375@cmpxchg.org>
 <20201110012758.GA2612097@carbon.dhcp.thefacebook.com>
 <CALvZod7GrYayHjYsqtF2AfcvkbTHCyWQJW4oXoO3fSGJeotDpQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7GrYayHjYsqtF2AfcvkbTHCyWQJW4oXoO3fSGJeotDpQ@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4d8f]
X-ClientProxiedBy: CO2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:104:2::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4d8f) by CO2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:104:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Tue, 10 Nov 2020 19:13:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d379b560-7a5f-4498-0006-08d885acb4c2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2389:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2389C393EE193DD4335B28F8BEE90@BYAPR15MB2389.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDrp+WuijixLDAQpbLU4qatODK0fIGaWaT2gYqkckeCfZbeckEjD0hZC+yRsW9+XwYe2ylm66jS7IldR7bVxyG9/dA7r5dnQlVSOjeM28kHIVh/k01UpfK3TyZEaGAouTce/PRKc5+oRRa9EOWT/uFTSjOYvWKyTOio6zLxCPQmj67djQcaBMwuxwePRQy5cP99sVrlJFe4O0HXzQeAFyEWIzZ6RbfmSo5adQX+u9F66VZZqvTli99NeaAVSesuXeoavqulVb0Qxg6pxy/iiBP69AIB5yZNXNTdTL/CQiBVtHcXi2JCYPmM6Abk7+W6r8Qg6H/7vsypeSlkYFzMSrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(366004)(346002)(396003)(8936002)(83380400001)(478600001)(6666004)(7416002)(2906002)(8676002)(316002)(186003)(1076003)(9686003)(6916009)(66556008)(66476007)(7696005)(66946007)(52116002)(6506007)(33656002)(55016002)(54906003)(4326008)(86362001)(16526019)(5660300002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fNMP09uLqQ/IUD4Y+3J2Qt49nTysO/3iUxgD/Fu3O8NWLQplfzQexv0ligVsqbSuFEVTeDVD1qs2mm0BNyHVTE01r9NRPWZ+vzvNGGgyjKNsBy34kqCckmIYfwFNtsprCQPi73o3/hcvg/S5nJJcNcSS9AY7jIvp6UCqeS//VHy98BaiVVTfSkzmCTmtihtx6cZViMyzaukBaxBR24cTVPUbsfXzpyHlSWNq0TOzY7chSntznPLvnJWf2fOQujkcAYlEje91afSCK7BNve4xIpMrAguIVeWEbhriHRfZ77X/WWCw+zK5NOcCJEK1LsUtt2mGgj47QeaR0or7YI6h+ILJermSN0AWe9nX0YEoe+NOqbxh6VDS7qTEg9u9APSE+dHpv9/HTGIUVVRIPt278emmBVnBEPBYtRJMOedTtdaN1qhHmqfce0KqGqT8x1pfNSwgOOsGO7jDBLae1z6QbR1l+1O/HZ00hCL/L4dIGkCG0ijkGM1UAkkssBAWYuI/QbpZe2+hr8gMUqFmwXgZI/jg+NVhWH2NMZUFdnNFihEAvvWjwVqlHUI9na9D6eEx+wwGRm+KC6ZM2b+iBd/d9D7lAJJMPf82/WIVTQPvf7i8kvcuXugOztJTjJJRG4ru8h5fGoVMd52oikV8Onik5yeWZ72yrILrROQj2hPUK9v05+FH2HqGshEwafximhPe
X-MS-Exchange-CrossTenant-Network-Message-Id: d379b560-7a5f-4498-0006-08d885acb4c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 19:13:29.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3HJpbnP2ldth6WKV5U01kvtXEBLR6r/MoeXd1z1rRnpMYverxjB4+wTka6Savi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=1 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:11:28AM -0800, Shakeel Butt wrote:
> On Mon, Nov 9, 2020 at 5:28 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 12:30:53PM -0400, Johannes Weiner wrote:
> > > On Wed, Oct 21, 2020 at 12:33:22PM -0700, Roman Gushchin wrote:
> > > > On Tue, Oct 20, 2020 at 02:18:22PM -0400, Johannes Weiner wrote:
> > > > > On Tue, Oct 20, 2020 at 10:07:17AM -0700, Roman Gushchin wrote:
> > > > > > If we want these counter to function properly, then we should go into the opposite
> > > > > > direction and remove the special handling of the root memory cgroup in many places.
> > > > >
> > > > > I suspect this is also by far the most robust solution from a code and
> > > > > maintenance POV.
> > > > >
> > > > > I don't recall the page counter at the root level having been a
> > > > > concern in recent years, even though it's widely used in production
> > > > > environments. It's lockless and cache compact. It's also per-cpu
> > > > > batched, which means it isn't actually part of the memcg hotpath.
> > > >
> > > >
> > > > I agree.
> > > >
> > > > Here is my first attempt. Comments are welcome!
> > > >
> > > > It doesn't solve the original problem though (use_hierarchy == false and
> > > > objcg reparenting), I'll send a separate patch for that.
> > > >
> > > > Thanks!
> > > >
> > > > --
> > > >
> > > > From 9c7d94a3f999447417b02a7100527ce1922bc252 Mon Sep 17 00:00:00 2001
> > > > From: Roman Gushchin <guro@fb.com>
> > > > Date: Tue, 20 Oct 2020 18:05:43 -0700
> > > > Subject: [PATCH RFC] mm: memcontrol: do not treat the root memory cgroup
> > > >  specially
> > > >
> > > > Currently the root memory cgroup is treated in a special way:
> > > > it's not charged and uncharged directly (only indirectly with their
> > > > descendants), processes belonging to the root memory cgroup are exempt
> > > > from the kernel- and the socket memory accounting.
> > > >
> > > > At the same time some of root level statistics and data are available
> > > > to a user:
> > > >   - cgroup v2: memory.stat
> > > >   - cgroup v1: memory.stat, memory.usage_in_bytes, memory.memsw.usage_in_bytes,
> > > >                memory.kmem.usage_in_bytes and memory.kmem.tcp.usage_in_bytes
> > > >
> > > > Historically the reason for a special treatment was an avoidance
> > > > of extra performance cost, however now it's unlikely a good reason:
> > > > over years there was a significant improvement in the performance
> > > > of the memory cgroup code. Also on a modern system actively using
> > > > cgroups (e.g. managed by systemd) there are usually no (significant)
> > > > processes in the root memory cgroup.
> > > >
> > > > The special treatment of the root memory cgroups creates a number of
> > > > issues visible to a user:
> > > > 1) slab stats on the root level do not include the slab memory
> > > >    consumed by processes in the root memory cgroup
> > > > 2) non-slab kernel memory consumed by processes in the root memory cgroup
> > > >    is not included into memory.kmem.usage_in_bytes
> > > > 3) socket memory consumed by processes in the root memory cgroup
> > > >    is not included into memory.kmem.tcp.usage_in_bytes
> > > >
> > > > It complicates the code and increases a risk of new bugs.
> > > >
> > > > This patch removes a number of exceptions related to the handling of
> > > > the root memory cgroup. With this patch applied the root memory cgroup
> > > > is treated uniformly to other cgroups in the following cases:
> > > > 1) root memory cgroup is charged and uncharged directly, try_charge()
> > > >    and cancel_charge() do not return immediately if the root memory
> > > >    cgroups is passed. uncharge_batch() and __mem_cgroup_clear_mc()
> > > >    do not handle the root memory cgroup specially.
> > > > 2) per-memcg slab statistics is gathered for the root memory cgroup
> > > > 3) shrinkers infra treats the root memory cgroup as any other memory
> > > >    cgroup
> > > > 4) non-slab kernel memory accounting doesn't exclude pages allocated
> > > >    by processes belonging to the root memory cgroup
> > > > 5) if a socket is opened by a process in the root memory cgroup,
> > > >    the socket memory is accounted
> > > > 6) root cgroup is charged for the used swap memory.
> > > >
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > This looks great.
> > >
> > > The try_charge(), cancel_charge() etc. paths are relatively
> > > straight-forward and look correct to me.
> > >
> > > The swap counters too.
> > >
> > > Slab is a bit trickier, but it also looks correct to me.
> > >
> > > I'm having some trouble with the shrinkers. Currently, tracked objects
> > > allocated in non-root cgroups live in that cgroup. Tracked objects in
> > > the root cgroup, as well as untracked objects, live in a global pool.
> > > When reclaim iterates all memcgs and calls shrink_slab(), we special
> > > case the root_mem_cgroup and redirect to the global pool.
> > >
> > > After your patch we have tracked objects allocated in the root cgroup
> > > actually live in the root cgroup. Removing the shrinker special case
> > > is correct in order to shrink those - but it removes the call to
> > > shrink the global pool of untracked allocation classes.
> > >
> > > I think we need to restore the double call to shrink_slab() we had
> > > prior to this:
> > >
> > > commit aeed1d325d429ac9699c4bf62d17156d60905519
> > > Author: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > Date:   Fri Aug 17 15:48:17 2018 -0700
> > >
> > >     mm/vmscan.c: generalize shrink_slab() calls in shrink_node()
> > >
> > >     The patch makes shrink_slab() be called for root_mem_cgroup in the same
> > >     way as it's called for the rest of cgroups.  This simplifies the logic
> > >     and improves the readability.
> > >
> > > where we iterate through all cgroups, including the root, to reclaim
> > > objects accounted to those respective groups; and then a call to scan
> > > the global pool of untracked objects in that numa node.
> >
> > I agree, thank you for pointing at this commit.
> >
> > >
> > > For ease of review/verification, it could be helpful to split the
> > > patch and remove the root exception case-by-case (not callsite by
> > > callsite, but e.g. the swap counter, the memory counter etc.).
> >
> > Sorry for a long pause, here's an update. I've split the patch,
> > fixed a couple of issues and was almost ready to send it upstream,
> > but then I've noticed that on cgroup v1 kmem and memsw counters
> > are sometimes heading into a negative territory and generating a warning
> > in dmesg. It happens for a short amount of time at early stages
> > of the system uptime. I haven't seen it happening with the memory counter.
> >
> > My investigation showed that the reason is that the result of a
> > cgroup_subsys_on_dfl(memory_cgrp_subsys) call can be misleading at
> > early stages. Depending on the return value we charge or skip the kmem
> > counter and also handle the swap/memsw counter differently.
> >
> > The problem is that cgroup_subsys_on_dfl(memory_cgrp_subsys)'s return value
> > can change at any particular moment. So I don't see how to make all root's
> > counters consistent without tracking them all no matter which cgroup version
> > is used. Which is obviously an overkill and will lead to an overhead, which
> > unlikely can be justified.
> >
> > I'll appreciate any ideas, but I don't see a good path forward here
> > (except fixing a particular issue with root's slab stats with the
> > Muchun's patch).
> >
> 
> Since the commit 0158115f702b0 ("memcg, kmem: deprecate
> kmem.limit_in_bytes"), we are in the process of deprecating the limit
> on kmem. If we decide that now is the time to deprecate it, we can
> convert the kmem page counter to a memcg stat, update it for both v1
> and v2 and serve v1's kmem.usage_in_bytes from that memcg stat. The
> memcg stat is more efficient than the page counter, so I don't think
> overhead should be an issue. This new memcg stat represents all types
> of kmem memory for a memcg like slab, stack and no-type. What do you
> think?

Hm, I don't see why it can't work, but it will not solve the memsw problem,
right?

Correct handling of root's kmem and tcpmem counters was the main reason
to select "always charge the root memory cgroup" over "never charge the
root memory cgroup". If we'll not use these counters directly, than it's
probably better to never charge the root memory cgroup, at least from
the performance point of view.

Thanks!
