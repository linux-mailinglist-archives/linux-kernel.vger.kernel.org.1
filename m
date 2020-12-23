Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68B2E2150
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgLWU2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:28:07 -0500
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:27105
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbgLWU2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:28:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3FNEy6G/7QY5X9ofdWTsUQ/uNc0QJGU3swjTLH7Ujg1n8nJnAs0zx4JH4p+1aN8UfsTQ0EbHakMsZopk006Bo+3O4l3gX+WFeFK0Vm0WPjBrl2KTYKfwWVSTnT8GKnkFuoyaSa61t1mMJ/tFIQPSO211Pazz+aJx6f50SEBOCpFS0U3KURq++zMsuOdNhNwEngwHxBDWCCYheaRUM0tO7fASOdEuge2FrZe1g/mMej1SWdltC9W0/cFpo2IxT099dNIMCafmOCMB9aCLVYqmNT1mwF5RQGVtw0usAZP9D4hympMxITUd6Q1MxGR0enizxgyLxmar7+GJMagaa8CxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu8VBXA1JKLyGkfeF2nkCL5cz+2Zqci0tfGnDeOTiK4=;
 b=D6SeC4xl3QRrb0npu7CRNsOHNYREdcLl8wxnVERkDZozRumjTGRRWp2QUFesYAhrO7Zzu/lS4RlPS30FaRS4fsZkw9khQQ8s7nWGv7Mfi466Xyo7Yn97iOC9SjlUeOxNRsPY0U8nzrUIFJij6DdccB4UPkFcMfbHXCaMJP7yRBNubqhrsSF4A4hO/pOBcjCcNs/GB9LlzMOTHNsAAvq6iGanCy1FUMrutptkadM7LCCPSrtdeGiRrJXrtLN7vLXfnTtFj5qmVQGxmJjTI1dlqR7C/Cfzc4Aj2agrKUcQcZAW9C77Y4M2zZrp1/YBNXp8tFUgbBDncZNd2UIDKTbUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu8VBXA1JKLyGkfeF2nkCL5cz+2Zqci0tfGnDeOTiK4=;
 b=aSl6FituAuM61dFewIDvoFHQKCv1rhMjfZFR5/ddN+Ua1SXN4W+eXoideAM6dJ2qjpziaydR9aoZouVrXIiXnNQuH0cqyTxfmrrLvxFizY0dUSSGp97BlzM5KZ6kuZkVRWrm5Vc+yj2JEhB1Y1Vqe0ciygDqfjcZJ1Q8dMh6CRk=
Received: from (2603:10b6:a03:297::10) by
 BYAPR21MB1253.namprd21.prod.outlook.com (2603:10b6:a03:108::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.8; Wed, 23 Dec
 2020 20:27:18 +0000
Received: from SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7]) by SJ0PR21MB1872.namprd21.prod.outlook.com
 ([fe80::6c27:2cfb:ebc8:aaf7%6]) with mapi id 15.20.3721.012; Wed, 23 Dec 2020
 20:27:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
Subject: RE: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Thread-Topic: [PATCH -tip V2 00/10] workqueue: break affinity initiatively
Thread-Index: AQHW2TyUnmhUGRTSLkunH7k6Vv5Aj6oFEKTQ
Date:   Wed, 23 Dec 2020 20:27:18 +0000
Message-ID: <SJ0PR21MB1872C6BB2800A55BD1CDE6B8BFDE9@SJ0PR21MB1872.namprd21.prod.outlook.com>
References: <20201218170919.2950-1-jiangshanlai@gmail.com>
 <CAA42JLa=r5c7_D5K1rHr5Tx5Enrib3rAdFZzajXumCq7-i-Q+g@mail.gmail.com>
 <CAJhGHyDWswu4gzT0qJzR3vBC6ESm1yui+JHFHfueXan95i0NUg@mail.gmail.com>
In-Reply-To: <CAJhGHyDWswu4gzT0qJzR3vBC6ESm1yui+JHFHfueXan95i0NUg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 0176d57e-a6f9-4e3e-bd51-08d8a78124db
x-ms-traffictypediagnostic: BYAPR21MB1253:
x-microsoft-antispam-prvs: <BYAPR21MB12533B900C4A6746B948BC53BFDE9@BYAPR21MB1253.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyJ568E8Lnfg3kHeXel3JQOIpgy5pnb+FnvbmpJL7SSJhNV8gDG2ATt3as71MWCqebtLal5mWzxZJj9P25FoQZN/G3dK/v2tfy7osctW8Y3ht1tF3tnyDcvMkhLsv77TJ3blU157UeY4FM61iVerFwlGLriKZCvjeQvPf2gFOvF1JD0xdaITvfGI+WV/Z5GpxCfNlvcG8A0cU2+vpTfe2f1THcNHBU56IcpEnqIPy/hKsOLx3q2ZbtxZeZ6dA1EezOCc0BQGMVb8zHDCasLZmt3nCCGXwMuLyW9Z3JbPJV0uojqxGoFkoXqR1ujgM425HeHF3Fj1LFO8/DK9PC3yhPiD6d998H8KvwEQjV0L6uHcn/Vs5ydaSqxI6poi+fta
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1872.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(66556008)(66446008)(82950400001)(71200400001)(76116006)(8936002)(316002)(86362001)(82960400001)(64756008)(6506007)(7416002)(9686003)(478600001)(54906003)(186003)(55016002)(10290500003)(4326008)(52536014)(33656002)(66946007)(110136005)(5660300002)(66476007)(2906002)(8990500004)(7696005)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c0PFJz9FsJ3B+qQd9Bd+5sqJR41XJj6rgoW+pwRFcSl+9+fEdk1pFLxWHlrV?=
 =?us-ascii?Q?XJkzXvrB7i76eAOu2gp9bjn7Y8iu5ACNe1bBOAIwsiYunVFa+ShoPDZEFspx?=
 =?us-ascii?Q?JM8cTlwmnnP3FmO0femHvih2zqeM+8qJ4hoZWFVbByRmjBt79ofhq+O3WTau?=
 =?us-ascii?Q?eFuJCWQEjaBte7ovRoymtPNP1MyKpfrY/kDGv/2l5jOsYAT7xf6z3gTiUhDR?=
 =?us-ascii?Q?CxeZHptSJxbxWWDQegULShi25a0tswP6tUswh/T8kBOw+8ZEGw7I7dum3yWU?=
 =?us-ascii?Q?bLxs2/GgchMTFfC+qwWa2iM+hu8jVbZPUSXCFIXj+xFgLW6OncabA/YAtTYQ?=
 =?us-ascii?Q?lmdehx5X3Tku6D6hK+bQ+O/2UWGkTGZ8+9M1nb+JRUE/BTPKbEY2DqOpHf4z?=
 =?us-ascii?Q?/WurGac4/npPc+BfxUWFqn3ZosU8zqQXSE4tGz29z1feHnM4x8i/gL/V1drd?=
 =?us-ascii?Q?D0xGfHp9abyFSClKlX5Q1UKfifuXZXyWY5MlJaPo0d5T7AA7OcjU0WyBINJR?=
 =?us-ascii?Q?uPrj30zfV74VDr0hRH4UUQiSHXFt43jhIoxoJVUOs6CRFY/or/errnl5V6Ol?=
 =?us-ascii?Q?+Mcz3wj1+V1ptQdvJkez8+/28HllNytVDjBdh3f7pP3kyS12AWWtZOlgNfwa?=
 =?us-ascii?Q?179C7uZO941q3fqstyfIR7LkRR0BbSLgmGEJ8gff7+Ot1mzS+G26LsUUfzj5?=
 =?us-ascii?Q?xuCnyMPikz6TLipx/Hg2mkDMlKxqxiufqCy+DY/PZbhAZxBBaurUibw8tFID?=
 =?us-ascii?Q?vjaKyeftC9YTZOG1VD0+BPyFwispAZOkB/1ntQ2nkm7WUK84V/HVqTLrsa/C?=
 =?us-ascii?Q?TLDA8uD31J0L6RhYy315CsQ96cEw82csOG+frX6fYXNSPXa0l+bzZaFq/uKZ?=
 =?us-ascii?Q?hEhml3Z075eeZ4ccbTTjEjsmg+cATEvldzMvE8tm9CsDXhA7Z+bDXElTdlFl?=
 =?us-ascii?Q?W/s3qwOhgGmfINkbECb6THj1MTJHPwUyUMnp5ySzUlLL8xN5U8MrFkyju8Eu?=
 =?us-ascii?Q?NORuUmohlI+wYsMXonBVOK0jtfkJOzjIGaspnvguWQsKf+g=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1872.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0176d57e-a6f9-4e3e-bd51-08d8a78124db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 20:27:18.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUji5pOInEmhjrVv5ai8Mw3aek0glV9KJzdHtVoyiQF7VLuzPDEoDasprD5zROAswLqfHs0fjOEGIJFkFKQYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1253
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lai Jiangshan <jiangshanlai@gmail.com>
> Sent: Wednesday, December 23, 2020 7:02 AM
> >
> > Hi,
> > I tested this patchset on today's tip.git's master branch
> > (981316394e35 ("Merge branch 'locking/urgent'")).
> >
> > Every time the kernel boots with 32 CPUs (I'm running the Linux VM on
> > Hyper-V), I get the below warning.
> > (BTW, with 8 or 16 CPUs, I don't see the warning).
> > By printing the cpumasks with "%*pbl", I know the warning happens
> > because:
> > new_mask =3D 16-31
> > cpu_online_mask=3D 0-16
> > cpu_active_mask=3D 0-15
> > p->nr_cpus_allowed=3D16
> >
>=20
> Hello, Dexuan
>=20
> Could you omit patch4 of the patchset and test it again, please?
> ("workqueue: don't set the worker's cpumask when kthread_bind_mask()")
>=20
> kthread_bind_mask() set the worker task to the pool's cpumask without
> any check. And set_cpus_allowed_ptr() finds that the task's cpumask
> is unchanged (already set by kthread_bind_mask()) and skips all the check=
s.
>=20
> And I found that numa=3Dfake=3D2U seems broken on cpumask_of_node() in my
> box.
>=20
> Thanks,
> Lai

Looks like your analysis is correct: the warning can't repro if I configure=
 all
the 32 vCPUs into 1 virtual NUMA node (and I don't see the message
"smpboot: CPU 16 Converting physical 0 to logical die 1"):

[    1.495440] smp: Bringing up secondary CPUs ...
[    1.499207] x86: Booting SMP configuration:
[    1.503038] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7=20
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26
#27 #28 #29 #30 #31
[    1.531930] smp: Brought up 1 node, 32 CPUs
[    1.538779] smpboot: Max logical packages: 1
[    1.539041] smpboot: Total of 32 processors activated (146859.90 BogoMIP=
S)

The warning only repros if there are more than 1 node, and it only prints o=
nce
for the first vCPU of the second node (i.e. node #1).

With more than 1 node, if I don't use patch4, the warning does not repro.

Thanks,
-- Dexuan
