Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873BD2EC15F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAFQoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:44:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727205AbhAFQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:44:36 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106GdvVV006626;
        Wed, 6 Jan 2021 08:42:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ModmJb8VK0WuJ6tvKskhKaKEbPExW2DbSvWqm3IOwLA=;
 b=Ij/HORUPHxK7hVaFUiM4xXoWGg+vyD3/Oxnvm+9rc6NIlGrg9IEdtKCbLv/kg4jRyvj5
 6j5ug7TSGHnToMYsKrmDbismG5Tt9Q3U9u+rIh1C42ZWf02DfWLYmUKC6qXH0h6zi/90
 SsqJMG422+gilrIdDPnOUYuNyX/+ETjggcs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35w3y9u5j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 08:42:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 08:42:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWxh0Cl3mR48Q4rMalC3gntOsuMoSg+RzGAEaTL/Vx/qsgUXRIhPtAXN9NtVUGymHQVsLsVIHHLBtc4DFJt0ugiXFBKP12SR2+DxrUeuOTjP3/GXI3kzkcy/WuBypBBPOOvN3X9znl3Cgr8epz3l2PgfHrJ4n4O6yKyCmMSHGqmxlvDpgs52ARC+QU/xPZea3By/sXsp0pLz1EfDuENCqnwvxSA4VhHdczQ2bl5cXJcRUbzuE/CUjwb63d/QO9GGBNP52AjXvfw7748WOMWOswuWvY2jyMKo+RdBchiBriX2fUx2cYlOigJ8DQBog1xumGdNyukMO2KiBAreg/tW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ModmJb8VK0WuJ6tvKskhKaKEbPExW2DbSvWqm3IOwLA=;
 b=gSyJkMCN2q3gyyHs2zL8mVENb9XEZHXNXeiPv0RGWHm9VtbEN4K8L6PK/hdAU8yNzLfgcuZWDOGNYHYTKGOr8KGSP4PPjghk29TPL+jINxcmW2zNgbNIvgfiuHYjFcYGG3NLPGw66RMzlZRaaUc4iw5ZlHEbqLTh4V4tXryob9DHYlXJnS+8jRJk7zgG3BNiIYjKS7nMS84J2qcT/YAxUoFI2PJ0zS5jds89v1HeaMPh07Xez5PVP0E9SFDZhEC9kzr7fWu1DZK+wxx4iuIfv/M3opxcVhi0HW/hBbyJu+8jFbxltaJqmqfXlY78lrc6J8O/L4srtJWVx5nu96Q3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ModmJb8VK0WuJ6tvKskhKaKEbPExW2DbSvWqm3IOwLA=;
 b=iKU7FdxBt6/pxUtHWi00VAk8CD74CSFYcquIMnaiNVqBMQWwtD0nO5iyzUmoTOvW0X1SUhRl4XsaFeCzVI+Fn3tfS3+Fv7FAcfHkbgldJP79dS8YWQfks01Un8wVktEJi7NSG8I7CylW70GHohxSD4VBXG/EZ5tZGU5BRZyODWU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 16:42:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 16:42:47 +0000
Date:   Wed, 6 Jan 2021 08:42:42 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
Message-ID: <20210106164242.GB1110904@carbon.dhcp.thefacebook.com>
References: <20210106042239.2860107-1-guro@fb.com>
 <CALvZod6CyDvSe0aGXt=eLfREF4Gte76oVfy+-egR99iUqNVMJA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6CyDvSe0aGXt=eLfREF4Gte76oVfy+-egR99iUqNVMJA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:e3d5]
X-ClientProxiedBy: MWHPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:300:115::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e3d5) by MWHPR11CA0044.namprd11.prod.outlook.com (2603:10b6:300:115::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 16:42:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d37182-fcc9-4c96-429a-08d8b2621927
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB250127AF53E0CD9F66F2DDB3BED00@BYAPR15MB2501.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfOPLW8ZU/69qOR2ikZ2fUAjhq4JLrDEjC7HkmrVCutcTY7YQYxJwFeP8sjO4sRsX3ow6mNXDe5FiXMChzzGoGXgO0CSV0g6kcfA8kiFMeMn//mjF8pAiZMnCF8tuvQ6YTP4TqV6BpVWv6qlfiKMm9dxm2sW4R5j6LoPxfEFW0dHczZ1FGlK5t77ZLLShPnrDLzw/hxDCjBYwiXSvXX8OOuhBGsykF3YwPljpgmTb2G4y5dozl68Ameipm9dmZL5wvShe2y5Xro8lcp5idp0nXZUeR545/cW8NNLaHRXtl+H1iR4Ca+iUeb2UDGpVysmQFupiONgxQsN93ZbSmzJHwxBWTDTPiuJPMq0UAh9zG2CU5mhTzLw4ls0+53zO54CTZ4jZorPnCLazB66+xT+XZ9fZvKzqyXbajGz74jbiUCXDFcKHhD/P3FWG7SgPKtG+1geaIDU4Pzye25C7JAejA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(66946007)(66556008)(66476007)(55016002)(6506007)(1076003)(54906003)(52116002)(7696005)(316002)(53546011)(6916009)(4326008)(2906002)(86362001)(478600001)(966005)(9686003)(8936002)(5660300002)(83380400001)(186003)(6666004)(33656002)(8676002)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tg/nAe5sSEiN10XMneLWGSQ3IogL3ocd73l2w0UZk1LWI+fMFOWwhpIH/QJ7?=
 =?us-ascii?Q?EDeRolpwvFYRv7Du9shrZAjFswmJrWYngNbvQj0VtceYEc17hD8nONbTVA2a?=
 =?us-ascii?Q?HamnJ027LfxHJigmWF6+r8jiD9S6APMAxXwmwwQAmAXSEQqt7yr6qlz8yM2b?=
 =?us-ascii?Q?wbQOEYKOUyxsAR7ZlYmC3Z9Ti4668Piawbtfpg7uJbY/fRo5U3RQxGzOx34n?=
 =?us-ascii?Q?DHEvB5g9hwyrar4gclgEg7AvRnbfdNnqSS3a9u+cDfvZY71cisVCBGoktrnR?=
 =?us-ascii?Q?p7E0S5+vWES6bD9hw5wjWPZiTLm4rRApJTJZozaPEFkTo0OMblbiaw1dHMdj?=
 =?us-ascii?Q?dolmydRFcRyB6DwhgLMAgLnSQa5we/W3Yga9HEU28YWolSr3V664+TevFRRD?=
 =?us-ascii?Q?EOX5WV6WazYGFKkNZSn1DZ3ytX/WaqncVk2tk1m/EkjCXGZUVhSN8JTWvjlE?=
 =?us-ascii?Q?frH5svw6OfJ+VDIidk/j78LUzksX/1RhEF52gmYL3YmwQtnNk9d9mX+p66Vf?=
 =?us-ascii?Q?7w757NvkBveaWFZ4RFuzuH1Bgx7esg9FCIFA+7S5SRyvAgdBaMSA/DsG/Vc4?=
 =?us-ascii?Q?5xNoZOLfLucjPsbql0SUxba7iC+mlVWv0nUS0NiBZ88RleBqGlCJGoyGJNq4?=
 =?us-ascii?Q?ubiAzpoR/pNMgtR/PrfHuHTKQfbrUSTcVI5HVqm/cOlaKAT+GF+Q/jkyPzVO?=
 =?us-ascii?Q?9o5Ick316JWz2ytMFTIDAskfpAfM4SMDqef9PNLxir/lvP2GfRdX0imVCwQZ?=
 =?us-ascii?Q?bvtQkjjpjf7zTwogYz4udWE61ErprYbEUw0+C8sLNV9CcCoZHBFQDftYKZxD?=
 =?us-ascii?Q?UYU0bYCU58ZbA9+k/ODooQMLP92iAB+fiXKzZaKnDVk0EsOyOGVWTixXKG39?=
 =?us-ascii?Q?BTS6vuRc0ZnaWaonPS26JVRNWAqDUaAxKOLykNwU5iFlGc4yRawr2lNS8gZ0?=
 =?us-ascii?Q?ivKu2bu9WHMbN7wu1JM69UiInZdBzsBWA2dvZz9wFvbTqJDL0UX5AzMh0lNk?=
 =?us-ascii?Q?TkQPDtuHTFEFYvHbKzUwIiZxEQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 16:42:47.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d37182-fcc9-4c96-429a-08d8b2621927
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PONW/Jwe98l5nsM/8dRqzL1OHM/5Uy7tLvmLZESU42HSM3KSgV5x1G7FatJ69hB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_10:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:05:20PM -0800, Shakeel Butt wrote:
> On Tue, Jan 5, 2021 at 8:22 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Imran Khan reported a regression in hackbench results caused by the
> > commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > instead of pages"). The regression is noticeable in the case of
> > a consequent allocation of several relatively large slab objects,
> > e.g. skb's. As soon as the amount of stocked bytes exceeds PAGE_SIZE,
> > drain_obj_stock() and __memcg_kmem_uncharge() are called, and it leads
> > to a number of atomic operations in page_counter_uncharge().
> >
> > The corresponding call graph is below (provided by Imran Khan):
> >   |__alloc_skb
> >   |    |
> >   |    |__kmalloc_reserve.isra.61
> >   |    |    |
> >   |    |    |__kmalloc_node_track_caller
> >   |    |    |    |
> >   |    |    |    |slab_pre_alloc_hook.constprop.88
> >   |    |    |     obj_cgroup_charge
> >   |    |    |    |    |
> >   |    |    |    |    |__memcg_kmem_charge
> >   |    |    |    |    |    |
> >   |    |    |    |    |    |page_counter_try_charge
> >   |    |    |    |    |
> >   |    |    |    |    |refill_obj_stock
> >   |    |    |    |    |    |
> >   |    |    |    |    |    |drain_obj_stock.isra.68
> >   |    |    |    |    |    |    |
> >   |    |    |    |    |    |    |__memcg_kmem_uncharge
> >   |    |    |    |    |    |    |    |
> >   |    |    |    |    |    |    |    |page_counter_uncharge
> >   |    |    |    |    |    |    |    |    |
> >   |    |    |    |    |    |    |    |    |page_counter_cancel
> >   |    |    |    |
> >   |    |    |    |
> >   |    |    |    |__slab_alloc
> >   |    |    |    |    |
> >   |    |    |    |    |___slab_alloc
> >   |    |    |    |    |
> >   |    |    |    |slab_post_alloc_hook
> >
> > Instead of directly uncharging the accounted kernel memory, it's
> > possible to refill the generic page-sized per-cpu stock instead.
> > It's a much faster operation, especially on a default hierarchy.
> > As a bonus, __memcg_kmem_uncharge_page() will also get faster,
> > so the freeing of page-sized kernel allocations (e.g. large kmallocs)
> > will become faster.
> >
> > A similar change has been done earlier for the socket memory by
> > the commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for
> > socket memory uncharging").
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Imran Khan <imran.f.khan@oracle.com>
> 
> I remember seeing this somewhere
> https://lore.kernel.org/linux-mm/20190423154405.259178-1-shakeelb@google.com/

Yes, we've discussed it a couple of times, as I remember. Looks like now
we finally have a good reasoning/benchmark, thanks to Imran.

> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you for the review!
