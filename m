Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320672DF09B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 18:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgLSRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 12:06:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37062 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgLSRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 12:06:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BJH2Me9013302;
        Sat, 19 Dec 2020 09:05:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=B63BunmT/xLj2GMpePyTg8eAiEncvUb2R7YuSANXp54=;
 b=q0wZMOXjJfKrGVYRwhl9VFrR7V89iCxQkG4dzgZtDk54fNTVmDxpphCw4+zTZvwObCN2
 BI40SeUjGn7bKbYTlaU3NiZj8yeBddyHCMmH6U/8GIybsXlSYYAxDn31sE1NWrh6tr4P
 FeAqEqTS+rf79d/JyyFAwqQ/2ek5dSvRayA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 35he2ws46u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 19 Dec 2020 09:05:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 19 Dec 2020 09:05:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPJuGF5yQWepYzQCLXgHJB0gmubS3w5n/4gjFjm+VPAryQXyZeNUOIcOn1ELiEQJCQFSvUjzu47udtybB2pSmplyzaujZ6/OwJe5/N5faJst1L3GiWdwIBxX3YYbjy9JE4SxEkDpINEqNbZv1ULGaXs1cnjAgJHUpqkosYNIyHEUsqGya3yWfMAwbdBahjRJoiSoSxN7rjg9gvpA/Mbp7tuV9UOWmF6Pr9VgOamBsZFstM3yIOPTys8/Pt4v2L3chxEMJXeVAVziu0u3jpjITK+zfN8LN+pKANrj/+63qysLcp9fSUkc+qHIvEe3pDwnSshrPWQPzTVgd34NCUbAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B63BunmT/xLj2GMpePyTg8eAiEncvUb2R7YuSANXp54=;
 b=kG69nyIWANWD6EtlfCGrVGox9VmT+BVj0V6gJB5yxKmNYgMbOmHqaoCGooglRH//eljkvf4qciPO4/PE82lznRE1Xn/nXO0g6gUEEMhcsMo6fGZ9oVe+zTH3ZmgGopgBa2MZ+BdVXdPYSIocJKwuKc+egyxb3qBQXIpCyJKaVtEm8Z5IHS8G3DrtsIuUgh3eGag2j8QK9bGY0bbGtrcsNkp4uJbvYVHCPPqlQOznTFk0GLJwWvs/07mOh1s28lOv3yzmY8Hfp1e/7neKy0GN2yL7VUzNDAjQSSpn6E4KbOQ92kV3K1Hvg39kUkZK0bv57IT0Go2FxlgbveozEl9SEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B63BunmT/xLj2GMpePyTg8eAiEncvUb2R7YuSANXp54=;
 b=FbllVz5YBhwwBbhutAiGic3KbvrXiNy0iQdpOtRvXtvOBrhG1pPDKBWJoHrZm8t+azNXaKBAhUN/4FQUnc5UlCL7vjrEyh1dhGMrAq3VPKV7bES0aqf5RCgSa5VjxS41P54x8q8uDuWkdqOOZsnd5o7O2r5YWZ8ytS/nc+DGKgs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Sat, 19 Dec
 2020 17:05:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3676.025; Sat, 19 Dec 2020
 17:05:40 +0000
Date:   Sat, 19 Dec 2020 09:05:35 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with
 kernel_end
Message-ID: <20201219170535.GA3428478@carbon.DHCP.thefacebook.com>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201217201214.3414100-2-guro@fb.com>
 <CAEcHRTqcrEdXcr02OZnSTgxwQ0Por7y4gAXn6uM=Dp=TVq_5kA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEcHRTqcrEdXcr02OZnSTgxwQ0Por7y4gAXn6uM=Dp=TVq_5kA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:88ba]
X-ClientProxiedBy: CO2PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:104:7::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:88ba) by CO2PR04CA0127.namprd04.prod.outlook.com (2603:10b6:104:7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 17:05:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3fd09c7-67a8-4bc8-128e-08d8a4405087
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3144192900B5CAD1359896D1BEC20@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zazr4NS04KX0wktBaO36qlHHqvA4ZcRQlAMS5SRWgwicCrjeh4gPj/hShnD9itZ3AAfCwl9tTolmBjZvXOoMw4Z+A1n7kWtgKsQVONDvuWaDcLZ3Q7Wa0xiGXaG96EguXL42Ko4KN9nr2dQDiZhJWC5m17fM6tHNHmKmZFuNtECIFGfDeQxVOoBdgyz/qEqHrRYdOrhfSTrxgcYeZWkbNsTKq1TKG9tkiMK/DkP8Jk58XSIzivG7GcvyaA7mIhVc7ikrDbv7MQ6OwRMY4L3kwMPQs63dRbgqbkMUbMpx/oXf9oo6RajGVE32t3HgA7D0bt1WkXZGrMHF8Kf+ggQaEiFLZP7T4j+lYasFt9LTAWUdkxKLUE3MFuWRrycmtZqcPLkayXCbR97motZy+yJHTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(39860400002)(396003)(54906003)(6916009)(186003)(8936002)(66946007)(316002)(4326008)(55016002)(16526019)(5660300002)(66556008)(66476007)(6666004)(33656002)(7696005)(52116002)(6506007)(86362001)(478600001)(53546011)(83380400001)(9686003)(1076003)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Fjd/wBDDJclhgI5Yn5O9zdYyF7Sb+HeHIpoj2+IZqlNv8+wN55FtbgnjzLaY?=
 =?us-ascii?Q?r0UnLk8ETv3QMNN1nh8LqJeef0gXJJ8ZuwVgCdi18BpwMxeeFEnF70LNw1YQ?=
 =?us-ascii?Q?EpZqTiPtYFVDBSB/9nChu9k+zDjhfG23SDGLDpOjbYz8QPGLYcALbYNRV2Mi?=
 =?us-ascii?Q?fbCiikUORIxALn4Ucw7asNUwhFBivO4n+IRp8mdBoTvBKmvb43XSCkhDoGgq?=
 =?us-ascii?Q?AUx8gZGcps04p0wa7bfJVBBdc0sUk8Q84Ej8g/bcXC+Ova5TyYkLTQiVNKlp?=
 =?us-ascii?Q?6X7xrCvF0+eDKnvceaRbZnxYpEBtn4etp+b2aqIey9VQhjKF1bzk995LIyD9?=
 =?us-ascii?Q?Fxr9GjcZeozVzT06QPkUkV47qhTn9Rmdlr9pciOf/QoJQVgX5AGz2FPLFwup?=
 =?us-ascii?Q?W0gGyOCccfAFPXdsYX6h3FYvy67p5qmElmSQ/PI+C1NayljBz5iMbKZMOYV+?=
 =?us-ascii?Q?ObfAuxdkzblKdlB3jKjZlDP5rs3gqha/OWTH6pRfD8cMwhnOjtD/sexgC2zQ?=
 =?us-ascii?Q?M2vxB/59zlSiAxeXOEqqgq/lEUEurqlA03+TZ9peUFntpc41FXa7UcTnlti6?=
 =?us-ascii?Q?5ujvZGHd6qT1HuERxc1QWbDWyskQynonIW227t4jaqJcT74Jmb/dRr7f8Cw7?=
 =?us-ascii?Q?GStOqBhuY1NlRnKXHBAVhUl3vEWhUZ82NPBxbbN1+OUcruyuTepK90658N1R?=
 =?us-ascii?Q?I3BQ7gthRiCroge4DrqlmxobVk6xj6CZd/+fiDNuXmUEcQEoD3ciTEVBL644?=
 =?us-ascii?Q?i4BHqBjvPHSgCJeOGcChJ3TimmsImezIRHT89/wAtYQ8pqYFwuUOxBLG6fwf?=
 =?us-ascii?Q?TsASu48IxJXclrunQYzb33dQRx8RPl77Ojnf1JHzJ48f8hEyDXQUjC3f5+TT?=
 =?us-ascii?Q?qH6hrStGmyEv8YTDNQGMaEMqcAJBOcGdhE+ZZ/khuRx+I7cQUc8Dc22BoWLO?=
 =?us-ascii?Q?/+Z5Uu/13BDM5sAYzKcRQ1yOZHOYBu+dwxByfAgjyEShPInitE2VZOLMHmQR?=
 =?us-ascii?Q?8RSBNk5A7/VfBundBOGJcHEeTA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 17:05:40.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fd09c7-67a8-4bc8-128e-08d8a4405087
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RafhneYbA4FnUDNP4qSbfCBCmHiIQLVN9K18c13SweiDrGjxQW5iHK/ftcdAanZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-19_10:2020-12-19,2020-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=965 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012190128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 11:52:19PM +0900, Wonhyuk Yang wrote:
> Hi Roman,
> 
> On Fri, Dec 18, 2020 at 5:12 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > With kaslr the kernel image is placed at a random place, so starting
> > the bottom-up allocation with the kernel_end can result in an
> > allocation failure and a warning like this one:
> >
> > [    0.002920] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node
> > [    0.002921] ------------[ cut here ]------------
> > [    0.002922] memblock: bottom-up allocation failed, memory hotremove may be affected
> > [    0.002937] WARNING: CPU: 0 PID: 0 at mm/memblock.c:332 memblock_find_in_range_node+0x178/0x25a
> > [    0.002956] Call Trace:
> > [    0.002961]  ? memblock_alloc_range_nid+0x8d/0x11e
> > [    0.002963]  ? cma_declare_contiguous_nid+0x2c4/0x38c
> > [    0.002964]  ? hugetlb_cma_reserve+0xdc/0x128
> > [    0.002968]  ? flush_tlb_one_kernel+0xc/0x20
> > [    0.002969]  ? native_set_fixmap+0x82/0xd0
> > [    0.002971]  ? flat_get_apic_id+0x5/0x10
> > [    0.002973]  ? register_lapic_address+0x8e/0x97
> > [    0.002975]  ? setup_arch+0x8a5/0xc3f
> > [    0.002978]  ? start_kernel+0x66/0x547
> > [    0.002980]  ? load_ucode_bsp+0x4c/0xcd
> > [    0.002982]  ? secondary_startup_64_no_verify+0xb0/0xbb
> > [    0.002986] random: get_random_bytes called from __warn+0xab/0x110 with crng_init=0
> >
> > At the same time, the kernel image is protected with memblock_reserve(),
> > so we can just start searching at PAGE_SIZE. In this case the
> > bottom-up allocation has the same chances to success as a top-down
> > allocation, so there is no reason to fallback in the case of a
> > failure. All together it simplifies the logic.
> 
> I figure out that it was introduced by
> commit 79442ed189acb ("memblock.c: introduce bottom-up allocation mode")
> 
> According to this commit, The purpose of bottom up allocation is to
> allocate memory from the unhotpluggable node.

Hi Wonhyuk,

correct! And it remains this way, we just don't need to skip
all the memory before the kernel_end.

Thanks!
