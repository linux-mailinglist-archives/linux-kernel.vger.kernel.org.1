Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B512E21A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgLWUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:40:42 -0500
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com ([40.107.93.102]:24609
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728924AbgLWUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:40:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzSDou/AOvXulFbPp8qceKm0hw2RLpxzcCxdtGFJK/G4AYTMME07T73dDocS5mQbShRiezzdpyLYMaDdvG5G3NSJoUuweyth3+dw2+96FsNGymzk+y/n4L5COa6JS/QhBX0JeK8dixw5j+pT0qan07FpBcljbpfYbH8Kzgu0sSfYUFoDXW0+LKwcAFXVB3EeCZoX3gBXuJuPLUeUnPAlJ6lSGYRrqu+ZOpbwCJxHxhJ1TMafao8G2MljLhKF+/PKudr8wNycwNauLtw9ykdWX2H0GeogsT1ZveuZi4QTVXSDdyeuAa1F0bP/anaDhWXP5VRhjJ1knYf+Y4KTXW4wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr2Jo+Uw73T9NhjqlTng31akn3z/f1Ur7HuDmWmvi84=;
 b=jHWmgzX5H9mhmTVeQLrtbd39ukJaiA2SMF6NaHkExZm+tRl5ar21xhnvugISCwb4/ezExNDh530s9RHOWV8ciIcO+68gd8rnm4g7sDRg78k/5IWg6vlANtnXVobQKqB6XDMOFGQnRn9Yki5xiaPCcHVP9r/OLoWbCtIb4CYlyT13y2OIaZLFdcBetc2gAlML0b1+O7i+5DvwKmBERV11cj5PzllVk6DCcoruGiwasglFcY1BegkZQzIEFr4cy/GPL2Nb+E/3hNBNWO57F9vs0lZC+4n2oBdML5tKLzxHh/S0ro4tcLW0tWPAr2EZ1vvKOeFfo7VOa/bNm1Mmt/VhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr2Jo+Uw73T9NhjqlTng31akn3z/f1Ur7HuDmWmvi84=;
 b=Xdkvql9Ezkhmu7XAfPJPFo8J8I9SaRt0QippsZshYSP6Lut/j3qDOvnBRizvecg7a0VX3O7MduWru/EWzA18iU/Ona8FBGKSMHqaLgelF2k59pUQmiLWHqb1AsUfZCWrs9mf+lw5xQ7rhJ22tlsHld72RR8B3yB0xCg+ltJIMgk=
Received: from (2603:10b6:a03:297::10) by
 SJ0PR21MB1888.namprd21.prod.outlook.com (2603:10b6:a03:29d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.6; Wed, 23 Dec 2020 20:39:53 +0000
Received: from SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7]) by SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7%6]) with mapi id 15.20.3721.012; Wed, 23 Dec 2020
 20:39:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Lai Jiangshan' <jiangshanlai@gmail.com>,
        'Dexuan-Linux Cui' <dexuan.linux@gmail.com>
CC:     'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
        'Valentin Schneider' <valentin.schneider@arm.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Qian Cai' <cai@redhat.com>,
        'Vincent Donnefort' <vincent.donnefort@arm.com>,
        'Lai Jiangshan' <laijs@linux.alibaba.com>,
        'Hillf Danton' <hdanton@sina.com>, 'Tejun Heo' <tj@kernel.org>
Subject: RE: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Thread-Topic: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Thread-Index: AQHW2TyUnmhUGRTSLkunH7k6Vv5Aj6oFEKTQgAATXJA=
Date:   Wed, 23 Dec 2020 20:39:53 +0000
Message-ID: <SJ0PR21MB1872CFBAFEA8152CE3B362BDBFDE9@SJ0PR21MB1872.namprd21.prod.outlook.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
 <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
 <CAJhGHyDWswu4gzT0qJzR3vBC6ESm1yui+JHFHfueXan95i0NUg@mail.gmail.com>
 <SJ0PR21MB1872C6BB2800A55BD1CDE6B8BFDE9@SJ0PR21MB1872.namprd21.prod.outlook.com>
In-Reply-To: <SJ0PR21MB1872C6BB2800A55BD1CDE6B8BFDE9@SJ0PR21MB1872.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3af1871-4761-4b62-a3cb-11e939700eac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-23T19:26:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:f58b:1960:7f38:83b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fedeace-7d21-496d-9272-08d8a782e6f0
x-ms-traffictypediagnostic: SJ0PR21MB1888:
x-microsoft-antispam-prvs: <SJ0PR21MB188889B783072E9FB998EA35BFDE9@SJ0PR21MB1888.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NI8lbFWcw1lUR3KkLXyyAYrDFxjjbKigKrvn1uM9q4U16mXIdblq7RQjBf5yS90id4v8I9QGIpYWrd6AjRfRLmARb/qNsitFNAbEjJDpUgykP8HmaFMaa1uLil93ZdiIuEcKMPuEAZcNaPcX3Bx64PNe2Der+XCKOMezlXsIm74PEzeIqDDjd3/bhVrGZP1w3ci9ios1GnXNP0VSou3w6L6ByL26OWWZnYGQx8e+oaCWHOAyGiWZwhc7GbIt9Ygl/myJMrF6TWAXh7099q9ngSzMk9Ag6tTkwXnZQmSINV2NHAivz5XQLeZqQ1rgH9MWKwRydzUbrKCprVvKFTQihPB3xRdo5sitZpngtvqSyJmHgB/rY3NP06eA04r1enab9zXJjk6A2TIL1xFh9Kwyfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1872.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(66476007)(2940100002)(64756008)(54906003)(66446008)(186003)(4326008)(66556008)(7416002)(33656002)(5660300002)(66946007)(76116006)(316002)(71200400001)(8936002)(478600001)(82960400001)(8676002)(10290500003)(82950400001)(2906002)(55016002)(6506007)(9686003)(52536014)(8990500004)(110136005)(7696005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sf6wQaHCll4HFrL9D1/LwiqIgSqstM72PtPEhbYTSiYv7NcFa2UJ0lBEt2AF?=
 =?us-ascii?Q?Q7DaYMQd8WbyM/nUpb9k2Fd7TCmgUskkkWbaiDMs1WpHYUZV8H8Dm7zp7P2u?=
 =?us-ascii?Q?GEBXFRJWGbi3gXpxYw0HYYOV6QVsJo+PuXLkeLKg4jIqsO/IsYZLafJV3Gnb?=
 =?us-ascii?Q?wBHiTrGsB7AUkWPZY/u7/j5cZj+oGENlg6d3uAhsEQDFipWO4lwK1Wt3vj4y?=
 =?us-ascii?Q?GvKqRaxTszqAbzZcsIAEKxjL4ii9k8lKpIwg4leezrflM9Xzw0FULcnDoFFn?=
 =?us-ascii?Q?fgD7JQQThdKAPEyCqibYJCLSf8UWLgcZQwN2cg8QILqcI/nQ4RCyj07i1SGu?=
 =?us-ascii?Q?DRi+Xawn+rbEEdhTh39cCjrCwUy8AqQqllXm15FnfiZcto+Mmzve46t/KkNh?=
 =?us-ascii?Q?zb5eF9Idyrz/FKv+HaN7IL03EWATjBWvm2JrwTD6MLFM4ePH2580ip3lyu/X?=
 =?us-ascii?Q?T9H9Z1QyTp+hh14WPuKP5a9kDc7ePzOq/q+OwmsCackZwquQFzZA3rgnZ7cY?=
 =?us-ascii?Q?M1Q0p3ap/6t8vcW4IgTKBbgFW4+IsmBBHpS/9POQFauytbrhOXNJvZqnkXBa?=
 =?us-ascii?Q?FYtK5q6B5qPCxuZmQ+/vIGTg7XWxYco5SGi5uwaCrMS5qIWUvoQsxV+ktjwr?=
 =?us-ascii?Q?oF2R+qeca/lw7NEZyf/eeiAVWjk/BwDgjApA9nCMbXNJGS92+YMUN9mMbiU0?=
 =?us-ascii?Q?54cIP60CSnnRlDQcQlqAEtUp9QGeUXHB/IM0DFTSt969SV8BqBp+3MurZ5hL?=
 =?us-ascii?Q?QZ3P101/C9dPHjl1vexKPy/XDwK5qtX1hAPBPdHAxavhXohm/BCttpOUFxSu?=
 =?us-ascii?Q?PKZ3NYTbbOzN+/T1MhJKhyuDgRzip2knDSdbIV54LSA9muiIvDbVf78+Gcj3?=
 =?us-ascii?Q?tkCZ/AGuzNX0NwSDbudXDBn5qoYuW1FJN7k1ckHceINrC0rK0jZvsIGHPkGj?=
 =?us-ascii?Q?p5EaK9bYtReeJWmwhygz8e72Ktxrk81uupG09LgIGTyQsZPPgE092v17PZa5?=
 =?us-ascii?Q?cbXlFZLW4jS+5uYQD1fajQOI91OZocCM3OqlAqBbd0ptiTM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1872.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fedeace-7d21-496d-9272-08d8a782e6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 20:39:53.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSelkzRCPftQDdUyCSd+AufU8T6JQ0uZKLKHCBk6MRX5HMbvcxEVTGKHp/s0HlD1YUwu5aGUiNbbHZZkE6jrSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1888
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dexuan Cui
> Sent: Wednesday, December 23, 2020 12:27 PM
> ...
> The warning only repros if there are more than 1 node, and it only prints=
 once
> for the first vCPU of the second node (i.e. node #1).

A correction: if I configure the 32 vCPUs evenly into 4 nodes, I get the wa=
rning
once for node #1~#3, respectively.

Thanks,
-- Dexuan

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2376,9 +2376,14 @@ static int __set_cpus_allowed_ptr(struct task_struct=
 *p,
                 * For kernel threads that do indeed end up on online &&
                 * !active we want to ensure they are strict per-CPU thread=
s.
                 */
-               WARN_ON(cpumask_intersects(new_mask, cpu_online_mask) &&
+               WARN(cpumask_intersects(new_mask, cpu_online_mask) &&
                        !cpumask_intersects(new_mask, cpu_active_mask) &&
-                       p->nr_cpus_allowed !=3D 1);
+                       p->nr_cpus_allowed !=3D 1, "%*pbl, %*pbl, %*pbl, %d=
\n",
+                       cpumask_pr_args(new_mask),
+                       cpumask_pr_args(cpu_online_mask),
+                       cpumask_pr_args(cpu_active_mask),
+                       p->nr_cpus_allowed
+                       );
        }

[    1.791611] smp: Bringing up secondary CPUs ...
[    1.795225] x86: Booting SMP configuration:
[    1.798964] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    1.807068] .... node  #1, CPUs:    #8
[    1.094226] smpboot: CPU 8 Converting physical 0 to logical die 1
[    1.895211] ------------[ cut here ]------------
[    1.899058] 8-15, 0-8, 0-7, 8
[    1.899058] WARNING: CPU: 8 PID: 50 at kernel/sched/core.c:2386 __set_cp=
us_allowed_ptr+0x1c7/0x1e0
[    1.899058] CPU: 8 PID: 50 Comm: cpuhp/8 Not tainted 5.10.0+ #4
[    1.899058] RIP: 0010:__set_cpus_allowed_ptr+0x1c7/0x1e0
[    1.899058] Call Trace:
[    1.899058]  worker_attach_to_pool+0x53/0xd0
[    1.899058]  create_worker+0xf9/0x190
[    1.899058]  alloc_unbound_pwq+0x3a5/0x3b0
[    1.899058]  wq_update_unbound_numa+0x112/0x1c0
[    1.899058]  workqueue_online_cpu+0x1d0/0x220
[    1.899058]  cpuhp_invoke_callback+0x82/0x4a0
[    1.899058]  cpuhp_thread_fun+0xb8/0x120
[    1.899058]  smpboot_thread_fn+0x198/0x230
[    1.899058]  kthread+0x13d/0x160
[    1.899058]  ret_from_fork+0x22/0x30
[    1.903058]   #9 #10 #11 #12 #13 #14 #15
[    1.907092] .... node  #2, CPUs:   #16
[    1.094226] smpboot: CPU 16 Converting physical 0 to logical die 2
[    1.995205] ------------[ cut here ]------------
[    1.999058] 16-23, 0-16, 0-15, 8
[    1.999058] WARNING: CPU: 16 PID: 91 at kernel/sched/core.c:2386 __set_c=
pus_allowed_ptr+0x1c7/0x1e0
[    1.999058] CPU: 16 PID: 91 Comm: cpuhp/16 Tainted: G        W         5=
.10.0+ #4
[    1.999058] RIP: 0010:__set_cpus_allowed_ptr+0x1c7/0x1e0
[    1.999058] Call Trace:
[    1.999058]  worker_attach_to_pool+0x53/0xd0
[    1.999058]  create_worker+0xf9/0x190
[    1.999058]  alloc_unbound_pwq+0x3a5/0x3b0
[    1.999058]  wq_update_unbound_numa+0x112/0x1c0
[    1.999058]  workqueue_online_cpu+0x1d0/0x220
[    1.999058]  cpuhp_invoke_callback+0x82/0x4a0
[    1.999058]  cpuhp_thread_fun+0xb8/0x120
[    1.999058]  smpboot_thread_fn+0x198/0x230
[    1.999058]  kthread+0x13d/0x160
[    1.999058]  ret_from_fork+0x22/0x30
[    2.003058]  #17 #18 #19 #20 #21 #22 #23
[    2.007092] .... node  #3, CPUs:   #24
[    1.094226] smpboot: CPU 24 Converting physical 0 to logical die 3
[    2.095220] ------------[ cut here ]------------
[    2.099058] 24-31, 0-24, 0-23, 8
[    2.099058] WARNING: CPU: 24 PID: 132 at kernel/sched/core.c:2386 __set_=
cpus_allowed_ptr+0x1c7/0x1e0
[    2.099058] CPU: 24 PID: 132 Comm: cpuhp/24 Tainted: G        W         =
5.10.0+ #4
[    2.099058] Call Trace:
[    2.099058]  worker_attach_to_pool+0x53/0xd0
[    2.099058]  create_worker+0xf9/0x190
[    2.099058]  alloc_unbound_pwq+0x3a5/0x3b0
[    2.099058]  wq_update_unbound_numa+0x112/0x1c0
[    2.099058]  workqueue_online_cpu+0x1d0/0x220
[    2.099058]  cpuhp_invoke_callback+0x82/0x4a0
[    2.099058]  cpuhp_thread_fun+0xb8/0x120
[    2.099058]  smpboot_thread_fn+0x198/0x230
[    2.099058]  kthread+0x13d/0x160
[    2.099058]  ret_from_fork+0x22/0x30
[    2.103058]  #25 #26 #27 #28 #29 #30 #31
[    2.108091] smp: Brought up 4 nodes, 32 CPUs
[    2.115065] smpboot: Max logical packages: 4
[    2.119067] smpboot: Total of 32 processors activated (146992.31 BogoMIP=
S)
