Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CC2C91A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgK3Wxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:53:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54836 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbgK3Wxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:53:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUMdA0i017118;
        Mon, 30 Nov 2020 14:53:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DSJJbH7tn47AvL2xtzme4Qc4/9FaOTZ8Yr5Um2dyHsk=;
 b=OvEAwhlVvvYIGKz/t9FItj3qGqvM2tGdpyvxne+1fMVnF/GCNCVy8OizPBDv1p71kH09
 zZkFdMu+tufGIvhWyI+873L/qa9qeVhXz976iYoCfF0XqptwhuXQwAiNmDlPWIM+M/7c
 uqLHJQG6Bi8oHFoR8oTejrwPGoJEZwI57KI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 353uh4sn2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 14:53:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 14:53:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbQ1G25MZOBcWIOIsklnyMZifqAnZbWMJmFlFIHod2IVPLHR4jxA/5WjR1F60NzD/hfRCX8OEC+FiODDg86HvMzAVhScGHPp1bOQPUd49x0U02nT/rWjq/2Qo5yHNdtF2yOpdX/ycMnrw5DNI8U6gMZ7ecqWrvHOA5+iJBRCnEiU2V4fRu9c1npxUl95pI3VW0wC6pqMP2boOcDo93knrl4zOxbwu5XOU2pRe/HtaoJiHGsAhNS4yuP1lnCfECxI1Y6PuCcdK1H6XuttVZ05C3kRI/N1nUAll/ddlBujTTQxZxHyhWqy87+bAmhDdH22LYdMNRHI3oOSall9zpJv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSJJbH7tn47AvL2xtzme4Qc4/9FaOTZ8Yr5Um2dyHsk=;
 b=Bw48sftJbDuWOCE8D2EN3oKJLQUjeMMNkGKraxJSaxJfjMqvDfzv8sxR+eMZYcrCuBrIj0Dhqa967Xi/qkNuH3RBQNoipzpRIYheqzJN/D3iguF/oYg9T95sQI92KA4CN3qIzovMhbjvMvS+IxFvCS44p4S93YpeQVdT2ZZgLU93QJ6aDFbyDsjL68Mp5xgZnW4aMiirzd4iHXT9bmqq7M9W04e1zsATqn3kIEA+TNgr6zylEM7Tj2sW7sDVYAimOLy/JHSd5ZsgfxLAin9pgBLHPE7gGEvJhkocWeKP7DfF6GT3fdwZuKgs4jCirS9cXgX685nGtMZgVUZx+/1/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSJJbH7tn47AvL2xtzme4Qc4/9FaOTZ8Yr5Um2dyHsk=;
 b=gxsnP37UybJYO5+Wzz9oIsX/e9XfUppPp2pvp8raaLIRCNCugwG+Gn1FEaFjfu4zXuNkZHIiuyq5Dm7SHl2dIrCZa3FBoj6cG9NqvFzoDG1hX5v8AZsuH6n2zjbPOVX3JvXhObbL8C8SiQ/PZT8DsEk49eFKD+hfc+c7jnsgzFI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3603.namprd15.prod.outlook.com (2603:10b6:a03:1f7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 22:53:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 22:53:00 +0000
Date:   Mon, 30 Nov 2020 14:52:55 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
Message-ID: <20201130225255.GF840171@carbon.dhcp.thefacebook.com>
References: <20201130184514.551950-1-shy828301@gmail.com>
 <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:3b80]
X-ClientProxiedBy: CO2PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:102:1::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3b80) by CO2PR04CA0063.namprd04.prod.outlook.com (2603:10b6:102:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Mon, 30 Nov 2020 22:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b085afe-4d32-426a-3b0e-08d89582aff8
X-MS-TrafficTypeDiagnostic: BY5PR15MB3603:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36038C2C2F90740B1411A623BEF50@BY5PR15MB3603.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCCAaDKldzPqm2rqbRKjdZeoX6v/ALvXkZf8EvXaJysero+pk1IwlqQDZNrPmYPizn/rEvL9Rjb3Vd2p101DhMD3PsxO3Zalu95xaT3EzXT8ZkDok6Lwd1jY0wXS7w9nbrCC7YYAIr+DIt7cammC0NLhfYNkXF2NISakoA9uHUFut8kEe3LWzn6jOapofg4bn+x71F+G0/BIp8vyGvvBgM6pcgK2SSwoo4CU1grE69PF22Nr0lubbrymnSo/HDFJN8PMFj0hzszocfGnVw41oVx9zhv56XUvXe9M/+uwQAuJFzPvuKYkRw1deSOtA4/x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(346002)(136003)(55016002)(6506007)(66946007)(33656002)(54906003)(53546011)(6666004)(8676002)(66476007)(2906002)(478600001)(8936002)(66556008)(4326008)(316002)(1076003)(86362001)(6916009)(16526019)(186003)(9686003)(5660300002)(7696005)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iD1FRXcxtGA1GNTJ3xi6ORIfXIZ0DostEGbuKSQaxMIcrsCwmNoC4sUTJKMf?=
 =?us-ascii?Q?jBUmVsdwIcSCpsiH2b2sYaUWMSjBfHxO31T/HI7YltswNJCh1/mpZLPF8xk6?=
 =?us-ascii?Q?CUEMkMzryJbV480WxUhUlpWgN//f6qdqWLGnB7/29tj42QZFY+Npdp+jDarE?=
 =?us-ascii?Q?zUZgju6OFFdFJoQ4TAk3lhIckJ+m7CcHx8dBMIC7G72u6CSYJZ42gB3j8njR?=
 =?us-ascii?Q?mBt7Pj3u7vyr/bzSgslrjU54xa+tp3WZo3Tyqk4sWA9CUrz3lahWcRZcs23c?=
 =?us-ascii?Q?n0uKGYQf+udMmWmiqfRts4gJ6JmqSyAmUJ+otmQz7GFRuqr684xZ4GIW4Bke?=
 =?us-ascii?Q?3+Iijh+q/035+IJfs0xhmozcI1OromSSbcukNtocabhKMI9J9bSUS/vFQjI4?=
 =?us-ascii?Q?nj0q7h3Ydui0TgHoKHBhnqgw2mSb4cMCBULS2FZhjLAKt6ugfJQP+hGXipW1?=
 =?us-ascii?Q?t2t+rd0CoJcrlFxxty7AqyacK0miawPa4zPp2Fs+ME0IfpDL3lLndVNZx4XM?=
 =?us-ascii?Q?6XCeeZrh01eAcBXU2EkX7DTQu3ZpDbWFjFomf54i7NyO1X7baRvt4q8PIdpp?=
 =?us-ascii?Q?th6My6iHwYjxbLDSswFX0Q/09qm8ny7Zq1pLKi7kv4WQ5gTSUyW3/dJMM13E?=
 =?us-ascii?Q?Lhn0izzQlWlYYFtl+DuX71WWnbbkQ52oKC0GNoLiGKhPOh8cad2RVQPazipb?=
 =?us-ascii?Q?i3l9WxILG/nVI2hpRqtRnFPmAmivtuXhCHbnzOCQjqaEmK3xUH8VopRxrCah?=
 =?us-ascii?Q?6YWV8t3xf5dCm3zaesaeJeGqmbjAutDjWf9lapC2UOr4h5lvlG3IpK99hwCi?=
 =?us-ascii?Q?JvLwyaagg7Aay4jU10bd0wxt5Ot+s5ALY4bNlC6L7loSEy7DkTW4pRhztkEw?=
 =?us-ascii?Q?qGDV3cc1VoxwDaGTby01H2ATvHqKeCyISMEkvUfT4EOSaoC6+sySSmNpuIBx?=
 =?us-ascii?Q?1rzOp/LKlXx4UaobyxZC1VJd3UsuKU/mASxzztipFV6WLpUp0yjZ0I/jbAnw?=
 =?us-ascii?Q?Hxm0dB0Rbi1jJwPoU8JOgCBjjQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b085afe-4d32-426a-3b0e-08d89582aff8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 22:53:00.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsAymlp0JtG8QYgZZepiMheZ6ycF1Vs2rRcFNtlYSZ5AqcAd14qKmDrBK5Amu4ib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3603
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:57:47PM -0800, Yang Shi wrote:
> On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> > > When investigating a slab cache bloat problem, significant amount of
> > > negative dentry cache was seen, but confusingly they neither got shrunk
> > > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > > but tracing result shows they were even not scanned at all.  The further
> > > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > > to reboot the hosts to get the memory back.
> > >
> > > I didn't manage to come up with a reproducer in test environment, and the
> > > problem can't be reproduced after rebooting.  But it seems there is race
> > > between shrinker map bit clear and reparenting by code inspection.  The
> > > hypothesis is elaborated as below.
> > >
> > > The memcg hierarchy on our production environment looks like:
> > >                 root
> > >                /    \
> > >           system   user
> > >
> > > The main workloads are running under user slice's children, and it creates
> > > and removes memcg frequently.  So reparenting happens very often under user
> > > slice, but no task is under user slice directly.
> > >
> > > So with the frequent reparenting and tight memory pressure, the below
> > > hypothetical race condition may happen:
> > >
> > >     CPU A                            CPU B                         CPU C
> > > reparent
> > >     dst->nr_items == 0
> > >                                  shrinker:
> > >                                      total_objects == 0
> > >     add src->nr_items to dst
> > >     set_bit
> > >                                      retrun SHRINK_EMPTY
> > >                                      clear_bit
> > >                                                                   list_lru_del()
> > > reparent again
> > >     dst->nr_items may go negative
> > >     due to current list_lru_del()
> > >     on CPU C
> > >                                  The second run of shrinker:
> > >                                      read nr_items without any
> > >                                      synchronization, so it may
> > >                                      see intermediate negative
> > >                                      nr_items then total_objects
> > >                                      may return 0 conincidently
> > >
> > >                                      keep the bit cleared
> > >     dst->nr_items != 0
> > >     skip set_bit
> > >     add scr->nr_item to dst

Btw, I think I have a simpler explanation:

A (0 objects)
|
B (N objects)

Let's say the reparenting races with the deletion of a single slab object.
list_lru_del() can see parent's lru list and substract 1 from nr_items == 0,
setting A's nr_items to -1 (the item is actually still in B's list).

memcg_drain_list_lru_node() will check !dst->nr_items && src->nr_items
!-1 && N => 0 and not set the bit. But now we have (N-1) objects in A's list
and the shrinker bit not set.

My proposed fix should resolve it. Alternatively, we maybe can check if
dst->nr_items <= 0 and only then set the bit, but it seems to be an unnecessary
optimization.

Thanks!
