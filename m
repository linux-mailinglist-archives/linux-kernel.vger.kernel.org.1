Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10020299A43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbgJZXOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:14:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395529AbgJZXOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:14:40 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QN5f1F028509;
        Mon, 26 Oct 2020 16:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aExG5Y76xb3Kv7OBbVnLCueDHcEvNGt9njWmX4qdGtc=;
 b=YD3oUw7B4/hxnE8FiEVRgzMEC0qWsb/sD0TQXoTRpFKmajqlJTgkkceHEYMjOtI7aziD
 0FuxMAh+054UwYpSH5WOoROnpsXeUBfKa0YuK5DHkAjBFkZxLq7gwdZYN/X6c/8onbBW
 TQjh44d+/JOnYD4HR8MW+xnr02RwwUoPBMc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d3ru00ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 16:14:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 16:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw9K4WOTKMZe5Mjf0I0e1oqP0QcJVfdwo6Vgd6TZLODH7bCJl075iwOjXSUN6Lzhr4/aJ0fPgWyxKgn+JXHAWus7eCeaFV6tQAMIVrjSbY9eCPklKAvKu+rElu7d+ljbaJc+KLEDB7F63NB9iJ21V3MMHIvcM43BI9LPiD9RakN/PgC3KrSJ/m3oPOCgdg/RBIFZ1ATzHxBSYv/BuHJ5unsc2H95evPEtKEAbQi1v+nQe+s2/VkiALcnyHNwWV8g4SP/QA/NertAvgoNUzW5WVBPxna2gY+YuzVTVG1332FWgA5Tcx1as1HDTy8drclZ3EUQfprwbV4Ji4YOC1ND8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aExG5Y76xb3Kv7OBbVnLCueDHcEvNGt9njWmX4qdGtc=;
 b=UPTsvp2cvmfywnhJG065rCQA5YKiUlZa97QMZu+V+o4IPfAone1YeRDLYve2zMdcwvgLblLITsEp3XZbf50oOQSNSJRt25seEz6AiA9FRWhkDk506GBeJ1KZYAqIZW9yC/bVQfkDKaUqXrwaOFvdRTf99KbGWOvBV9HgY5pPm6uO3nFMiUNYCIjamjiuajgoxhsBHyunN74YMbNFLKLpiyCNVK+e54i/uFxT2j+npMDx9mumXNHJOhlAT5vPTqarwtXMiAY0JZzYyRS74B6vB9kHB3dBscGwLe+Pb/d+esHvRF6m/ftRDTFrB+NTqsPe4Z/QOBDWV3zEuuWLTeFodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aExG5Y76xb3Kv7OBbVnLCueDHcEvNGt9njWmX4qdGtc=;
 b=jzF/kFMn/bGhgpG+ewZxzxmeWxOmcj77SX8E0sIGvPyP4YmOXQcsARE6mxwvxw0/xzIi4I+lcTJhzoQ3Bl9Bl3hHPsjEabT0bllBmPnr4Db7fBgh3seUXWg+WzlGgeyFF57fiFXXfqlyWhJIPl1ylfM4L+dJwXY40RG4Q+qogeY=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 26 Oct
 2020 23:14:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 23:14:17 +0000
Date:   Mon, 26 Oct 2020 16:14:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Richard Palethorpe <rpalethorpe@suse.de>
CC:     Shakeel Butt <shakeelb@google.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201026231411.GB685018@carbon.DHCP.thefacebook.com>
References: <87sga6vizp.fsf@suse.de>
 <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
 <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
 <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
 <20201023004026.GG300658@carbon.dhcp.thefacebook.com>
 <87d015v3vs.fsf@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d015v3vs.fsf@suse.de>
X-Originating-IP: [2620:10d:c090:400::4:3e72]
X-ClientProxiedBy: MWHPR14CA0062.namprd14.prod.outlook.com
 (2603:10b6:300:81::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::4:3e72) by MWHPR14CA0062.namprd14.prod.outlook.com (2603:10b6:300:81::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Mon, 26 Oct 2020 23:14:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b379df4a-4601-41e5-ef65-08d87a04dc84
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32856D43412193B731B2E2EFBE190@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDqtvlaht87QThdoZhM3mHUf6W0Q04w5b+ApXVDOEdICtm2KOL1AOoSre/MRbzB+wsumU8LyIP6e2PcKI7ZMi9y7TEUB30A3NU8EhgEJk4EgQDIJ6p9IiFro5OJZxhDcIaTie9ehEQYcUjkqG8bW3yKmnDLMBFZ2Bww3OGDGvvmB4IteQNo5madLDRxkoSrFGW2OsbST3PIwQgFmYPRg9MMP0DRWY/xNryJgLxR09NBwdHiEy50mQisxRZIUoUbcz05XE1VAgsp9RH6A0K6Vl8qULeGqD/kiJwya9zaEZHVhN6ixG1jRrCDw7ZAcjyM1yEH3MIbw4dIP7HcMdlt7WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(33656002)(66556008)(53546011)(4326008)(1076003)(83380400001)(86362001)(66476007)(5660300002)(2906002)(7416002)(66946007)(54906003)(186003)(478600001)(6506007)(6916009)(9686003)(7696005)(8676002)(52116002)(6666004)(45080400002)(16526019)(8936002)(55016002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: LAWnRJSnH8AwG9uDmilvIn+QWiDUS13vYTopvvhDNPoMK0sd66Gd1pWgbmUFNKuSagqMjeH0cOiQKbRa6IRrKDOQxI2qpWo28zZUTr2+h/9zeUwuE9coqaQ1JqsE9t9YFbzM354zEXFGznkf2lxk56HFVpfgh+hPJnp1pu6eyqc78kEJuUCBc1Dy8OGH5ehxCQ1VVQgjvoAOgB08lZhaiPzAJYgp50CrOTzqcmiEOBOD31kAyXm2FiiuEtkYXpWTG3SsVmWOnSiXMCpPqXK7syLUocWv19o/fKJMSyairPjKR18LJMToAnFwV1SJrr4ThSM6mNi8nDsVSyURl0Gh1uD71sd1S7kmu8Nq+1uNXLe+GCeoiQrAjOqfV3OMJ4DLlywmkz+gyHHVxzUsvzsiKYNcGwZZtJhrmoJny1ugkr350bqXHj1GsM2MSravyDPw6xjlTKcQ88X2GP4CTOTRX2mZUQGac7m2mSKqiKr3oeF1n9XURM5MTn0+s/JA6YiSTgkcmdvmz96iasWliuNtpcBSkyK0WNO7iCzn+ZIPY6vONiO8lB8giFMIX8qfiYn0BQW2KrhCL7d8Hzjnrxp8t63Cgl2seVD4eQEMCyZaUPcjI8YliM9l6bkaQNwMVJ+ntbXSN9CEee7eTyFER1LTkv1b9OU4a5jdB38tNsW4ABY7hI/LNdRSSTa0IxxpcfjZ
X-MS-Exchange-CrossTenant-Network-Message-Id: b379df4a-4601-41e5-ef65-08d87a04dc84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 23:14:17.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/DBr/jxgyqcSdN9zt4UDy4nhj1exavOzjKZ6b7sWZsBc/gs9WVASobzzV+RJkWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_17:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=2 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 07:32:39AM +0000, Richard Palethorpe wrote:
> Hello Roman,
> 
> Roman Gushchin <guro@fb.com> writes:
> 
> > On Thu, Oct 22, 2020 at 04:59:56PM -0700, Shakeel Butt wrote:
> >> On Thu, Oct 22, 2020 at 10:25 AM Roman Gushchin <guro@fb.com> wrote:
> >> >
> >> [snip]
> >> > >
> >> > > Since bf4f059954dc ("mm: memcg/slab: obj_cgroup API") is in 5.9, I
> >> > > think we can take this patch for 5.9 and 5.10 but keep Roman's cleanup
> >> > > for 5.11.
> >> > >
> >> > > What does everyone think?
> >> >
> >> > I think we should use the link to the root approach both for stable backports
> >> > and for 5.11+, to keep them in sync. The cleanup (always charging the root cgroup)
> >> > is not directly related to this problem, and we can keep it for 5.11+ only.
> >> >
> >> > Thanks!
> >> 
> >> Roman, can you send the signed-off patch for the root linking for
> >> use_hierarchy=0?
> >
> > Sure, here we are.
> >
> > Thanks!
> >
> > --
> >
> > From 19d66695f0ef1bf1ef7c51073ab91d67daa91362 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Thu, 22 Oct 2020 17:12:32 -0700
> > Subject: [PATCH] mm: memcg: link page counters to root if use_hierarchy is false
> >
> > Richard reported a warning which can be reproduced by running the LTP
> > madvise6 test (cgroup v1 in the non-hierarchical mode should be used):
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
> > The problem occurs because in the non-hierarchical mode non-root page
> > counters are not linked to root page counters, so the charge is not
> > propagated to the root memory cgroup.
> >
> > After the removal of the original memory cgroup and reparenting of the
> > object cgroup, the root cgroup might be uncharged by draining a objcg
> 
> I think it is worth mentioning that reparenting will always be to root
> to avoid any confusion about what may happen with deeper, broken,
> hierarchies.

I agree. Added and sent v2.

> 
> > stock, for example. It leads to an eventual underflow of the charge
> > and triggers a warning.
> >
> > Fix it by linking all page counters to corresponding root page
> > counters in the non-hierarchical mode.
> >
> > The patch doesn't affect how the hierarchical mode is working,
> > which is the only sane and truly supported mode now.
> >
> > Thanks to Richard for reporting, debugging and providing an
> > alternative version of the fix!
> >
> > Reported-by: ltp@lists.linux.it
> > Debugged-by: Richard Palethorpe <rpalethorpe@suse.com>
> 
> Much appreciated, thanks!

You did most of the work. Thank you!

Roman
