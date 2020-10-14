Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE228E7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgJNUJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:09:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59848 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgJNUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:09:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EK47xS010648;
        Wed, 14 Oct 2020 13:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : content-type :
 mime-version; s=facebook; bh=XD1nMSC5mNBYfp/QSW4ghZ7iBQ9rhl7FYc2F+e8bGvs=;
 b=L64wFbgZ0ouhJ0z8lGT6abSvn/hVoOZj2rF4crduzxtXS5MRrpBwQ22DNIeM8B2991eS
 /q4BdC+btHGUrTN3ruW11wy6kyujijZbiMdO5NLHPK2sfj/FjXfjdwqNCxJDl6mr5QqN
 Y4o43vjGzK8Aqrx/B5KGiqJuSW5sv7uW9YI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 345p2cw8u7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Oct 2020 13:08:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 14 Oct 2020 13:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRZeRb0Lx/wBk/1WQu4e9uL1MLzkN79XEHt4KgbmMpJB+UIemT8EPkdiXiCptGZ4auvs10NgyWGcf8MEc/ZrcONNKj5gbtcPPAbpknc9vxxaGVyAFg5ygawFeN2q+FS8S+YykZ3zx/oH/zFXThyRBkdkzK7+JoSYOjzI0hVffbIDTMjOehgXtliEJTW3Q2KOo72imK6W4sJWW9kl/dliBa8PPc1gVg7zA4XTkHEcS2zROKScWFYYSfX3vsXSyDaTpXhNKxSPM5tpJMgeKxgyNub2nb6N/CtVPrriqylPKEq18rh5rlamFQAkVUw7kAzPRbZ6s8Z6TBxNIqAvJD5D6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD1nMSC5mNBYfp/QSW4ghZ7iBQ9rhl7FYc2F+e8bGvs=;
 b=ltu0WLTAvw4fFROGwT80QtOgBopC68jK2YkJIAwheCXxpOK2ct1dPSigA9KdXTMWrJA6t8m6xMRyFAjAt49jFDdAkYwlyHFtewQBzDQv1Sz6f9LY3RQPtNjqdR8+ztu9I8wF5zf1YtqhqeTlflSbew7xQFraXzK3r3///KYnZjmagH3AgqdFFbQD0BP6kRykYKwl8sxfoAyCKzgF1dYL3n6qfZIRi9psyZa0mJnBZhXJYtskkHFxDz3cGGWJpT8PzkCe0Y7VCDsYhx/MwgRD699QsPlTt0ndz+HZUPuCTOZOwW5w+ed3c69pwg3wMP+2iuXMqJ7KHhJkU5NNOnFOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD1nMSC5mNBYfp/QSW4ghZ7iBQ9rhl7FYc2F+e8bGvs=;
 b=B1LD/va9ZWYLq/8iiScqfiCtMqM67Pyn8+E+QzHBQmNV/yR9tJfKX9OVcr+iYltU1u0FkIdhfPUf/lBHR6bX8PFx4xvU/0WJKpWXqEWqVWq5X1xeY2V4wEpJHd3XFSwQX9APJMzi2q9z7bAEznyGuDouONdVpET2OoeNlOkGjWg=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 20:08:41 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 20:08:41 +0000
Date:   Wed, 14 Oct 2020 13:08:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Richard Palethorpe <rpalethorpe@suse.com>
CC:     <ltp@lists.linux.it>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201014200833.GA19363@carbon.lan>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
In-Reply-To: <20201014190749.24607-1-rpalethorpe@suse.com>
X-Originating-IP: [2620:10d:c091:480::1:23]
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c091:480::1:23) by MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 20:08:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20597a80-9c86-4ff7-e003-08d8707cf1d5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30793B31A58FC65CB84614E1BE050@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Wv5epdLUqIsswmNr4chT92g7546rKoVT9c28Rc41RiWEc7YOOhvHL+rfHXERQdytDiGo7uIDkcM56S6WqunihLPUX0pFzDnFU6CUvXglpbC5yycVvYT99fFPIMMFHk714/8HkL51P+29gVp01Ie3rD37lfFvGG3iXSmSgNPMhdPYwI/LX+OWqIvxvYv5RoEztThwy42c6mgjtvu2RQ3S0RZEWKBENfQPyl3p75X/qd2qzoEywdUlrEkEWVu4EybyDBqqRa33OF9F9V4koDYEqH5idCrZYqbZGgOsa7b86yJDcpQ8++ifIR0FZJ2vT9ZNQ67CBcm5NDckegmPUXNARpGNh/IHcL0o4waUu5RKv756eQqjjQDK69p69FceFVZ9xEhM7KN2Hstvnm4lh3osQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(9686003)(966005)(8936002)(45080400002)(55016002)(2906002)(5660300002)(478600001)(6916009)(4326008)(6506007)(186003)(52116002)(7696005)(83380400001)(16526019)(7416002)(66556008)(316002)(83080400001)(66476007)(1076003)(33656002)(8676002)(54906003)(66946007)(6666004)(8886007)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SDzHVZNlau5eDFmDZn6bZSphSHHpVLIhEEfOFoorKOxrZzljqhcamAyFdTnxrZc2l4Teh86Df/ucvkcYTnAn5AgyCzDUgdHv038P2p6H+b6GN7VYSlHMQiNFWw0FEOabE1sJTK1udoL89PKO5MKUjUJosXs8Zk9wm+eYjbvNmiobPSGrTWdGh+4QdGAwWGB+gsm6mTVq8qv36teljs+ze0FPGYX5+0mV8X3DvsZvIa/NEv5hNaHwcmfmOw2MjHB/iX9RwI30EIxBGiRQTFPapFQVzLtUsbtOWAlE0kVU7O+KltC6e+RYbyzyMaJdp0VcXy3zJZqizMDOXgwFzli7J+vIgcLuCqeCPgpYZdSJT1Nzwh3d+yv4DR+0ZDwXoGtFZCqM85zpDQNUNUvNTXegZ8pNAqDg/w7lWE/65CP2MYVxfCwXvqt4CM8MkczJWnFMjCYp8gYxzLyzSjbsCY3Vbl0qD7mK2ElRTBvAYqShOIxQXFHVAoAoyTF5H4m3+wllT/fXrsBhxjr8fZoWnJhY38K4tDJWJx2yRIQl/YFnvpHn4ICny6sFYA3XYVoFES2SXLERFU8nglSt9KwKYfMq2WaocnFmx55AR/eyk1APHFio80oFP9TTc3kzlYzf+sjIlWTlaw3YKy3iPBWzNDhStIAgAlDk2CgIpakrHg1x0h0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20597a80-9c86-4ff7-e003-08d8707cf1d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 20:08:41.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K66nZFhcCZ9iisHUKZqveaTwnkRsVNL1zgATevBf5ZEmmaXpJ+Sf8JcMRpmXftYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_11:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010140140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard!

> SLAB objects which outlive their memcg are moved to their parent
> memcg where they may be uncharged. However if they are moved to the
> root memcg, uncharging will result in negative page counter values as
> root has no page counters.
> 
> To prevent this, we check whether we are about to uncharge the root
> memcg and skip it if we are. Possibly instead; the obj_cgroups should
> be removed from their slabs and any per cpu stocks instead of
> reparenting them to root?

It would be really complex. I think your fix is totally fine.
We have similar checks in cancel_charge(), uncharge_batch(),
mem_cgroup_swapout(), mem_cgroup_uncharge_swap() etc.

> 
> The warning can be, unreliably, reproduced with the LTP test
> madvise06 if the entire patch series
> https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/
> is present. Although the listed commit in 'fixes' appears to introduce
> the bug, I can not reproduce it with just that commit and bisecting
> runs into other bugs.
> 
> [   12.029417] WARNING: CPU: 2 PID: 21 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [   12.029539] Modules linked in:
> [   12.029611] CPU: 2 PID: 21 Comm: ksoftirqd/2 Not tainted 5.9.0-rc7-22-default #76
> [   12.029729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> [   12.029908] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [ 12.029991] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 db 47 36 27 48 8b 17 48 39 d6 72 41 41 54 49 89
> [   12.030258] RSP: 0018:ffffa5d8000efd08 EFLAGS: 00010086
> [   12.030344] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000000009
> [   12.030455] RDX: 000000000000000b RSI: ffffffffffffffff RDI: ffff8ef8c7d2b248
> [   12.030561] RBP: ffff8ef8c7d2b248 R08: ffff8ef8c78b19c8 R09: 0000000000000001
> [   12.030672] R10: 0000000000000000 R11: ffff8ef8c780e0d0 R12: 0000000000000001
> [   12.030784] R13: ffffffffffffffff R14: ffff8ef9478b19c8 R15: 0000000000000000
> [   12.030895] FS:  0000000000000000(0000) GS:ffff8ef8fbc80000(0000) knlGS:0000000000000000
> [   12.031017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.031104] CR2: 00007f72c0af93ec CR3: 000000005c40a000 CR4: 00000000000006e0
> [   12.031209] Call Trace:
> [   12.031267] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
> [   12.031470] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
> [   12.031594] refill_obj_stock (mm/memcontrol.c:3166)
> [   12.031733] ? rcu_do_batch (kernel/rcu/tree.c:2438)
> [   12.032075] memcg_slab_free_hook (./include/linux/mm.h:1294 ./include/linux/mm.h:1441 mm/slab.h:368 mm/slab.h:348)
> [   12.032339] kmem_cache_free (mm/slub.c:3107 mm/slub.c:3143 mm/slub.c:3158)
> [   12.032464] rcu_do_batch (kernel/rcu/tree.c:2438)
> [   12.032567] rcu_core (kernel/rcu/tree_plugin.h:2122 kernel/rcu/tree_plugin.h:2157 kernel/rcu/tree.c:2661)
> ...
> Reported-By: ltp@lists.linux.it
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
