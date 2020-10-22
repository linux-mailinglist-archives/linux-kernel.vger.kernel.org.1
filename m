Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC422963AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899733AbgJVRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:25:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgJVRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:25:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MHFD5Z008747;
        Thu, 22 Oct 2020 10:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wBlfZGRkExGZ6qr2A8LUmBmadG1G8fgGmkSdPJ6sfbk=;
 b=CJFeNtiUEZyN+Ffg6kNpEi+mxxW1Bl8r81m6QmAJeIcEb7iYoW42L9kVQjg8mV0q4Bab
 fDLHzRVqPcoLt7tD17cfDz+qJ3S/SBVqkuNB6+tTAhlk6VVX0WBR4JgpZ7pvDO1Fn0a7
 GcTIah+O9GVWiPMXs4ooEDRXP6d5/xvAqNs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34aa6utnp5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 10:25:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 10:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD7yXO52U+3jW1VQpYjEAWDADhjzNEfYoWL+yaaMo3hFjH3IvD+7I3etIPbfOk0lw6a2CBAL4fZvQJiD5ynKZuM3463t5f5z/Ixp0uwIuKTkNk0xBMGZ/+I/I29PscWcpK+L8LQvY4X4GKQ39y1tHj/RBv9XqVbCze9exEyZS9A6/2I8SVYjPd8w9Tvd+1xetxk8445STWUpLDfE3xdvKW6ErlUm9M2WNebJthyrlt2SuPt4iSKECoMJJazxctmy0BK6AjqeWqzrDV2YOzpNevxKLgHE++NJHeOQoblJfrrxCzxqtKRh01dXBeu7PDaiTF35eLZKgD67CpI4T2qHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBlfZGRkExGZ6qr2A8LUmBmadG1G8fgGmkSdPJ6sfbk=;
 b=Zfy90uXf5YJ9NoT/w7+If2sVDyAOVrcU1rdbI+iDmHcDe1UZxx2/hQy3SxnEh4ufxOH0J0tWtzbkHUU8s9nuxKY+gqa43kShJjPNAibnrhznEJQiOvMP+4QuEbqxu/MA2zFP6R4WXuO1mpP6JwusNlYMyn+lF4K/V9RekifcXWw/Y7CPqnXIkUKJsi8i5X1kGSxynRk2ELDHStiDEE19Zsow87UyEnb8zNxxB+SYrAtp201aupo/ciwBDheUCpvKYL8kCNRrYfWohx+cR84pA6G6lEHKHX5jw0ibMw3DJponu5bNGLtz8ry1c1WluBxz38K+/bumCQS+qd5+B4KEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBlfZGRkExGZ6qr2A8LUmBmadG1G8fgGmkSdPJ6sfbk=;
 b=fo2vdPuhlKyTh5e+0zGiMG04vQqBjSbv+iij+jUErN2fskVjyve5ba7/6EO3CozGCJdfDCZMrkN+0YDMToz4ivYL4xoU8O9Zb6Gc/jYiPlVxIsfUzjO8Y6rV51VSqTFBW7nKzS745OBCgsMcIpt5G8c6h85z9fKuOm0S5bGAFz4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3604.namprd15.prod.outlook.com (2603:10b6:a03:1b1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 17:25:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 17:25:13 +0000
Date:   Thu, 22 Oct 2020 10:25:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Richard Palethorpe <rpalethorpe@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
References: <87sga6vizp.fsf@suse.de>
 <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::4:79ce]
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:79ce) by MWHPR12CA0071.namprd12.prod.outlook.com (2603:10b6:300:103::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 17:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf61397-f185-43c9-d6ac-08d876af6f68
X-MS-TrafficTypeDiagnostic: BY5PR15MB3604:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36041E36705535FE908D0747BE1D0@BY5PR15MB3604.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT/4cz2QBM0efZ76/IkML4F3MHXaPalEjL4S6CAHm3g/yyu8nUd6tFHdQt4EZ6yjWF507ZGVcfete5tsDHxRQTTgLR3nxqfxdAW2F0w9XXu0AYF3i0Ht+4TtHD6RptUYFCjqksYAuX9P0ZkI2+u/gucH3GyzBL+GqNv+VHRl9lGSbjXN2pTXcXrvN33OXUY1Wdz9nn8cd8X57eoUprZ/S4BWshyphZVDfDbfEPUwmGOzvK8TLakZSty+FZ6v2ONuXsnmtL08fNHY+dq2y+/xe6VWoAyZdXebWEsfQEvV4gY17n7qUQ/q24hRlR9gT5Ko6mbJ76sniarLaI0czZhquoddbfwGvyNHDxYzIEavAd+uQWIHDVG9q86KjcXRkmPOKm2BaoEEQekKRbZlC8wUjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(6916009)(5660300002)(7416002)(33656002)(1076003)(86362001)(66476007)(9686003)(8676002)(66946007)(8936002)(6666004)(66556008)(2906002)(966005)(54906003)(478600001)(316002)(52116002)(45080400002)(55016002)(7696005)(83380400001)(53546011)(16526019)(4326008)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lkX8/tVm6pn4FeMysyXNQ14eETXBFZ6WoYDBYBdo18y6WaG6/M5xRs1MgRvo19LAx9Dl1fAigZ6BKHiy0mAxvY1C2XUg9reQptPE+AvRRXoX8vq+j910DUg1xM7+1Eth/bFDStlhw31DX5xRQyGA1DkrH2DfzCZxDhWvy9bkKe6Opq9WzokdrGpL0Bh1ADVpKZasOaofYIs17JsJe7mEpxVwCWm9AvnOPvmSQh7HWVzv5gCoNeal1oVvlSx8kpTz+K/E5Ke+MdETMFloE4d6aggEGmsUB/45Ks/4RwZ+NZCjkyFvp20Bnd0WnG3qb8yesQqYvClzDtis8PFZOJRid7SaiQvMfZ/aQe33CUmugLf77KXhAgG4FqT8cMCbLVZiK4R11JUzXUqiEDeEHsPlQm4XankN9IZHwnqjxCAbuUOg+YP0CQLmUcjVa/nvNFAxRFCOL0AEW3X8CkruwI/DGbvAzwWTgf/bwmIc4iYdyrel2CkZZ9mo6BzqrCTEl2vgy4C39sIs8ti2lkPS6MJwOxTXRslxcn8ltwaRub/dl2ckBxKXhlvLU/4k4EWbN5EKkAqjmX5tb4HawBVua9IxRjx6oxVrh4wfETJA1p3WChQXMws3szzOhciofEuPJhMXDzWb5ycC1EkkaFmHzx18TLfqbmyr8z1Q/I7BM8vPoMs=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf61397-f185-43c9-d6ac-08d876af6f68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 17:25:13.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr4FqwW/RanF7iXNSLKhey5Q9MAMsPPCoSqvFKOZ+JBozWw+Y3/DS4txyBACfua5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3604
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_12:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:37:02AM -0700, Shakeel Butt wrote:
> On Thu, Oct 22, 2020 at 5:29 AM Richard Palethorpe <rpalethorpe@suse.com> wrote:
> >
> > When use_hierarchy=1, SLAB objects which outlive their descendant
> > memcg are moved to their parent memcg where they may be uncharged
> > because charges are made recursively from leaf to root nodes.
> >
> > However when use_hierarchy=0, they are reparented directly to root and
> > charging is not made recursively. Therefor uncharging will result in a
> > counter underflow on the root memcg, but no other ancestors.
> >
> > To prevent this, we check whether we are about to uncharge the root
> > memcg and whether use_hierarchy=0. If this is the case then we skip
> > uncharging. The root memcg does not have its own objcg, so any objcg
> > which is uncharging to it must have been reparented.
> >
> > Note that on the default hierarchy (CGroupV2 now) root always has
> > use_hierarchy=1. So this only effects CGroupV1.
> >
> > The warning can be, unreliably, reproduced with the LTP test
> > madvise06 if the entire patch series
> > https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/
> > is present. Although the listed commit in 'fixes' appears to introduce
> > the bug, I can not reproduce it with just that commit and bisecting
> > runs into other bugs.
> >
> > [   12.029417] WARNING: CPU: 2 PID: 21 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> > [   12.029539] Modules linked in:
> > [   12.029611] CPU: 2 PID: 21 Comm: ksoftirqd/2 Not tainted 5.9.0-rc7-22-default #76
> > [   12.029729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> > [   12.029908] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> > [ 12.029991] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 db 47 36 27 48 8b 17 48 39 d6 72 41 41 54 49 89
> > [   12.030258] RSP: 0018:ffffa5d8000efd08 EFLAGS: 00010086
> > [   12.030344] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000000009
> > [   12.030455] RDX: 000000000000000b RSI: ffffffffffffffff RDI: ffff8ef8c7d2b248
> > [   12.030561] RBP: ffff8ef8c7d2b248 R08: ffff8ef8c78b19c8 R09: 0000000000000001
> > [   12.030672] R10: 0000000000000000 R11: ffff8ef8c780e0d0 R12: 0000000000000001
> > [   12.030784] R13: ffffffffffffffff R14: ffff8ef9478b19c8 R15: 0000000000000000
> > [   12.030895] FS:  0000000000000000(0000) GS:ffff8ef8fbc80000(0000) knlGS:0000000000000000
> > [   12.031017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   12.031104] CR2: 00007f72c0af93ec CR3: 000000005c40a000 CR4: 00000000000006e0
> > [   12.031209] Call Trace:
> > [   12.031267] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
> > [   12.031470] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
> > [   12.031594] refill_obj_stock (mm/memcontrol.c:3166)
> > [   12.031733] ? rcu_do_batch (kernel/rcu/tree.c:2438)
> > [   12.032075] memcg_slab_free_hook (./include/linux/mm.h:1294 ./include/linux/mm.h:1441 mm/slab.h:368 mm/slab.h:348)
> > [   12.032339] kmem_cache_free (mm/slub.c:3107 mm/slub.c:3143 mm/slub.c:3158)
> > [   12.032464] rcu_do_batch (kernel/rcu/tree.c:2438)
> > [   12.032567] rcu_core (kernel/rcu/tree_plugin.h:2122 kernel/rcu/tree_plugin.h:2157 kernel/rcu/tree.c:2661)
> > [   12.032664] __do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:299)
> > [   12.032766] run_ksoftirqd (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 kernel/softirq.c:653 kernel/softirq.c:644)
> > [   12.032852] smpboot_thread_fn (kernel/smpboot.c:165)
> > [   12.032940] ? smpboot_register_percpu_thread (kernel/smpboot.c:108)
> > [   12.033059] kthread (kernel/kthread.c:292)
> > [   12.033148] ? __kthread_bind_mask (kernel/kthread.c:245)
> > [   12.033269] ret_from_fork (arch/x86/entry/entry_64.S:300)
> > [   12.033357] ---[ end trace 961dbfc01c109d1f ]---
> >
> > [    9.841552] ------------[ cut here ]------------
> > [    9.841788] WARNING: CPU: 0 PID: 12 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> > [    9.841982] Modules linked in:
> > [    9.842072] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.9.0-rc7-22-default #77
> > [    9.842266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> > [    9.842571] Workqueue: events drain_local_stock
> > [    9.842750] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> > [ 9.842894] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 4b f9 88 2a 48 8b 17 48 39 d6 72 41 41 54 49 89
> > [    9.843438] RSP: 0018:ffffb1c18006be28 EFLAGS: 00010086
> > [    9.843585] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: ffff94803bc2cae0
> > [    9.843806] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff948007d2b248
> > [    9.844026] RBP: ffff948007d2b248 R08: ffff948007c58eb0 R09: ffff948007da05ac
> > [    9.844248] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000001
> > [    9.844477] R13: ffffffffffffffff R14: 0000000000000000 R15: ffff94803bc2cac0
> > [    9.844696] FS:  0000000000000000(0000) GS:ffff94803bc00000(0000) knlGS:0000000000000000
> > [    9.844915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    9.845096] CR2: 00007f0579ee0384 CR3: 000000002cc0a000 CR4: 00000000000006f0
> > [    9.845319] Call Trace:
> > [    9.845429] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
> > [    9.845582] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
> > [    9.845684] drain_local_stock (mm/memcontrol.c:2255)
> > [    9.845789] process_one_work (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2274)
> > [    9.845898] worker_thread (./include/linux/list.h:282 kernel/workqueue.c:2416)
> > [    9.846034] ? process_one_work (kernel/workqueue.c:2358)
> > [    9.846162] kthread (kernel/kthread.c:292)
> > [    9.846271] ? __kthread_bind_mask (kernel/kthread.c:245)
> > [    9.846420] ret_from_fork (arch/x86/entry/entry_64.S:300)
> > [    9.846531] ---[ end trace 8b5647c1eba9d18a ]---
> >
> > Reported-by: ltp@lists.linux.it
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> 
> This looks fine to me but I would prefer Roman's approach of charging
> to root and for use_hierarchy=0, linking them to root.

+1

I think it's safer because it has no effect on use_hierarchy == true case,
and this is what we should really care about. But the latest Richard's version
looks correct to me, so I'm fine with using it for stable too.

> 
> Since bf4f059954dc ("mm: memcg/slab: obj_cgroup API") is in 5.9, I
> think we can take this patch for 5.9 and 5.10 but keep Roman's cleanup
> for 5.11.
> 
> What does everyone think?

I think we should use the link to the root approach both for stable backports
and for 5.11+, to keep them in sync. The cleanup (always charging the root cgroup)
is not directly related to this problem, and we can keep it for 5.11+ only.

Thanks!
