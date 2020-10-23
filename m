Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310A296826
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373960AbgJWAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:40:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11280 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2899044AbgJWAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:40:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N0eXb0004260;
        Thu, 22 Oct 2020 17:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=85KEhDH5NpoRziHuqvzUTSBCsIgrP21qnzypygEhUbE=;
 b=hat9oXt827sR0Z0b4/ZlRWsB9V4IYoDBcO4rjvL7Zd0kRVOkXzypSDUfXjFDiwlX0LSn
 Szx5nlSvuUb3fKwPeTRd+81tYDjW20iYYAVyvCqMPqxEejIUBBiArgbPD4K2UaZ5R8r8
 PBL+No9pWUzd3/2+4euSd8NSWQQRhZwFqv0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34b07seett-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 17:40:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 17:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViC+X/zA7vGungZ1O7hzGdqiW+JHvOJdJKZYp4gAqnd87Kh1vSpgJCCXtCv7niGd/K0qqNw4ZTCD3Qp78AFEzCfQ7kJEIAY3FrBeOsONOjZfDCS+6c5rVXqCUkHPQqbWNa/S5GN40FL8A7aA98ScsxwS7+TsQBvs97bZkFkVW/hCjBEdWZPKPSE2EhibCjbP3YOZBFKgA+U8NOFxV0HgR2uZ62dY7q+kmi7rary3+EQtax8ErQRDpbgNbrEHDNIAn25/7ogoRqhXXxKeIULRioYTfWNtQzmTxRE8BFIY86Xh8h9NSol5uMoos+T73PqCCLnFEG7MQVRcn+0y8Sa9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85KEhDH5NpoRziHuqvzUTSBCsIgrP21qnzypygEhUbE=;
 b=lArS1Ssi4c7p3CJm8GtKVVX4m7YW8fFeDeW5gBiJjCWqGPSsoOgv09ZFfah3brPnpMfbdsEQkYY221Fofa6AzVpvsHxIVegw/k/mUQqbWZ0uaony7TtFs7CV5MUoIgssLsvCmaWpPqfh+bAJf8srSRV2zdNM685IZTpfkQwVC5K03XLnF7vevwBl7eAOatVg4bdHye/TBYJjHy01b7ZJSXZgFiJotN3cIgJNlzWuMYz6871SOoJo+MIprf3FbPWZLNVjVtHZhoHmUH/KBN9vivzf5/9Vhv8D7u+qeYEkmc1WYy6f0AmrV6Oq/yuKj6yWjqoNJ57CmpiH2vQXUNC5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85KEhDH5NpoRziHuqvzUTSBCsIgrP21qnzypygEhUbE=;
 b=bBJG+ivOJ2rst1RTY+m2sYe4lT7or95wJlnM8w0wLAv72UrwAERAHI3kJt3AoJAuKIWS6owCHSxPvH5Hh/mY2sob9/ozXmP2qvOUfyiZ9VysAqc05HFlYpkSMsOZNYjQcjZWjPDwus80QMQaJXpYA92y/3+hfF2uFQXkv3T7hu4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2597.namprd15.prod.outlook.com (2603:10b6:a03:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 23 Oct
 2020 00:40:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 00:40:31 +0000
Date:   Thu, 22 Oct 2020 17:40:26 -0700
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
Message-ID: <20201023004026.GG300658@carbon.dhcp.thefacebook.com>
References: <87sga6vizp.fsf@suse.de>
 <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
 <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
 <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::4:3243]
X-ClientProxiedBy: MWHPR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:300:ed::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:3243) by MWHPR20CA0035.namprd20.prod.outlook.com (2603:10b6:300:ed::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 23 Oct 2020 00:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e43200cb-6b18-422c-e52c-08d876ec3f0d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2597:
X-Microsoft-Antispam-PRVS: <BYAPR15MB259760F66298B22EDD431D55BE1A0@BYAPR15MB2597.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pj3kysMK5PL+Ai84CQwkeJWkHXU4766geUSz1ODInioqL0qdJPsApI1Y/wwf2J2pEFzslSkCv69vZoUYoF+2Dbf9elncunDddo8H0baPHZXCC5x0eai89XPlTV2W8fFFTQ6PuePF4aq8kuoRJoYWKSmC4OhyNU63B+CZqBg709HHm799rf15iGbL0swtR4BfGV2tJ5nQlS5cDoA4VJ98ThNy0ULN38p3MR+8Xgv477U6bh2xoDUQoeBf9aZ0Yb1Ik53X0KIMY3rn8ip1XYNKeJcflfoFQ7oJNY19aoI7CjSEv8sjTfPqwJN6XMWmo9VR/bl7el0DUFaF3doiF7hv+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(55016002)(5660300002)(8676002)(45080400002)(54906003)(186003)(16526019)(316002)(33656002)(2906002)(6916009)(478600001)(4326008)(66556008)(6506007)(83380400001)(6666004)(86362001)(66946007)(1076003)(9686003)(53546011)(7696005)(52116002)(66476007)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fnexTp0rWgAOFHQCQlE+SEzK29Wzo2Qfod1Tg38XAvXQC1v59nRG5kzFw93YApoISK9Mgq1oWAsdnAhlwH1G5GmvBwmUArAHcO9ic4PtICj5q1vvIbbn4Z8Hx7JZpHl9uzbT7Mmpf4W47GJ29Jr8XmQLg5ZckeXIZPPAtT66Ev29PYw+TYmD4ZPqctkF/z6m/LVrC7+2hmb5IyS+eVPDpAgKamHyWeV7Z3Y20U3lce9k8eZveXZQYmGFr7vfekJ3AevPdyNXoYbYehpR/LfhCESzUshrh2UVXQLQIwMJTdOeghmymASyPpfuflqmnAjrIZJvthhtdIGWSNDuro0BGEu186v2LyJGA1q8GInA94kXbD1U1dBDtrpLJp3BPTRvHxhMLVU2bDD4WA/3vNY7NCZVRSZ3t398QlR6BRaCdbLTKiKdhlXqsq9hWAxPOUlj8FJrS81F5Tvl8DMeS6xoocHkPLIiJayL08I8AwzqsEJXC70c4DuDAubx/Dm8mCoI2g7QlQDOe80/N7UPs5csP36fCbzfXK/9BxbG1AzC5V+ibu2kognH4YC3YBUQR4JtTkP4qeDyitqb26rSohS5K/i1miTbzzf9jrhEVnBMIm1f8U05UG5wvuhGsEENAH/66r1Hb8gxY1ooJ5RVHOqCoCm0Obod8bdgZFWAxp8y9a1ZCp5ETFNZjqtfl2vk6GwC
X-MS-Exchange-CrossTenant-Network-Message-Id: e43200cb-6b18-422c-e52c-08d876ec3f0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 00:40:31.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpK2SVqxpIuyDxhFPregywslhW7z+rSFkFpV3TSuGVjVtWUpQsZOvpyIoTTDjIPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_17:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=2
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010230003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:59:56PM -0700, Shakeel Butt wrote:
> On Thu, Oct 22, 2020 at 10:25 AM Roman Gushchin <guro@fb.com> wrote:
> >
> [snip]
> > >
> > > Since bf4f059954dc ("mm: memcg/slab: obj_cgroup API") is in 5.9, I
> > > think we can take this patch for 5.9 and 5.10 but keep Roman's cleanup
> > > for 5.11.
> > >
> > > What does everyone think?
> >
> > I think we should use the link to the root approach both for stable backports
> > and for 5.11+, to keep them in sync. The cleanup (always charging the root cgroup)
> > is not directly related to this problem, and we can keep it for 5.11+ only.
> >
> > Thanks!
> 
> Roman, can you send the signed-off patch for the root linking for
> use_hierarchy=0?

Sure, here we are.

Thanks!

--

From 19d66695f0ef1bf1ef7c51073ab91d67daa91362 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 22 Oct 2020 17:12:32 -0700
Subject: [PATCH] mm: memcg: link page counters to root if use_hierarchy is false

Richard reported a warning which can be reproduced by running the LTP
madvise6 test (cgroup v1 in the non-hierarchical mode should be used):

[    9.841552] ------------[ cut here ]------------
[    9.841788] WARNING: CPU: 0 PID: 12 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[    9.841982] Modules linked in:
[    9.842072] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.9.0-rc7-22-default #77
[    9.842266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[    9.842571] Workqueue: events drain_local_stock
[    9.842750] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[ 9.842894] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 4b f9 88 2a 48 8b 17 48 39 d6 72 41 41 54 49 89
[    9.843438] RSP: 0018:ffffb1c18006be28 EFLAGS: 00010086
[    9.843585] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: ffff94803bc2cae0
[    9.843806] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff948007d2b248
[    9.844026] RBP: ffff948007d2b248 R08: ffff948007c58eb0 R09: ffff948007da05ac
[    9.844248] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000001
[    9.844477] R13: ffffffffffffffff R14: 0000000000000000 R15: ffff94803bc2cac0
[    9.844696] FS:  0000000000000000(0000) GS:ffff94803bc00000(0000) knlGS:0000000000000000
[    9.844915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.845096] CR2: 00007f0579ee0384 CR3: 000000002cc0a000 CR4: 00000000000006f0
[    9.845319] Call Trace:
[    9.845429] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
[    9.845582] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
[    9.845684] drain_local_stock (mm/memcontrol.c:2255)
[    9.845789] process_one_work (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2274)
[    9.845898] worker_thread (./include/linux/list.h:282 kernel/workqueue.c:2416)
[    9.846034] ? process_one_work (kernel/workqueue.c:2358)
[    9.846162] kthread (kernel/kthread.c:292)
[    9.846271] ? __kthread_bind_mask (kernel/kthread.c:245)
[    9.846420] ret_from_fork (arch/x86/entry/entry_64.S:300)
[    9.846531] ---[ end trace 8b5647c1eba9d18a ]---

The problem occurs because in the non-hierarchical mode non-root page
counters are not linked to root page counters, so the charge is not
propagated to the root memory cgroup.

After the removal of the original memory cgroup and reparenting of the
object cgroup, the root cgroup might be uncharged by draining a objcg
stock, for example. It leads to an eventual underflow of the charge
and triggers a warning.

Fix it by linking all page counters to corresponding root page
counters in the non-hierarchical mode.

The patch doesn't affect how the hierarchical mode is working,
which is the only sane and truly supported mode now.

Thanks to Richard for reporting, debugging and providing an
alternative version of the fix!

Reported-by: ltp@lists.linux.it
Debugged-by: Richard Palethorpe <rpalethorpe@suse.com>
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: stable@vger.kernel.org
---
 mm/memcontrol.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..009297017c87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5339,17 +5339,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
 	}
-	if (parent && parent->use_hierarchy) {
+	if (!parent) {
+		page_counter_init(&memcg->memory, NULL);
+		page_counter_init(&memcg->swap, NULL);
+		page_counter_init(&memcg->kmem, NULL);
+		page_counter_init(&memcg->tcpmem, NULL);
+	} else if (parent->use_hierarchy) {
 		memcg->use_hierarchy = true;
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
-		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
+		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
+		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
+		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
+		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
 		/*
 		 * Deeper hierachy with use_hierarchy == false doesn't make
 		 * much sense so let cgroup subsystem know about this
-- 
2.26.2
