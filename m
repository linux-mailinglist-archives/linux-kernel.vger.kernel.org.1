Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F862B6FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgKQUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:16:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgKQUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:16:07 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKF3mJ019882;
        Tue, 17 Nov 2020 12:15:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PXM72kbTPOzcDRxilc4ZDcgK8HVWiWfO2nfaLdhm4uE=;
 b=RWOTAMVWK+rsIu4IfC57SX0Pscbg/kSneiMsEAe9to/W37uZcyunAv2FedFFP3xvRFzq
 tiDXvWnQz2Q+AExi2Ie9BpbDMWpVSYUaaX9teG8LvJc7VIcVDPmsimzKtiMSW/3SQbV8
 +ruje8DYniqpI6ztu+9m3oKRVIYY3F/Azrw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34vhqj9k6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Nov 2020 12:15:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 17 Nov 2020 12:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erD6RiruZDfCJ3P+tdiscyuLcs/YJ+hdQ9Shpwpv0gB7wGO0vCTH/NAqLurpbxkaIgctVX2UA0t7KFiH1yPZgdAMnXz4iRnGVosJEpnWffKi4UhD2RtgKFfJGg6ZOfSEsHZEW40gdllxeGrodpVNJc77BywFqrYLNkRM5WjT7IYHDPt9emxOqZFWPuigafr8cgVHUJ90HEhhXwco1G45iZSd45ruxnXCpvIw5X8H+/p9DE6uxdAWfOx69ElGljA/0fQIlguBo+BGtbhZg5dZQQP/CwlifTlD5Zrqrszs/3PN25pICI6BnaP3LclJqY2vdNSTVhGOEyn4furTUAF2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXM72kbTPOzcDRxilc4ZDcgK8HVWiWfO2nfaLdhm4uE=;
 b=njzDU7SFmpIcRMM+/7M1j7IM+MrF6laTbzB0yKWxOI69uLWHgErH8u8vIxlpq/PfMeAf3VJ6J0w4eMv+HpTsQzaKL+bPLBJ4EWyrfXlEyByhVeB4HyWk9fGwd47/Crc5B5mAe6Rp20cT1UTatTa/FsHuBgx6+czLLermfvHU/Bc8DXOKKFeKov+FBhOL2WjQVoD/3OchXEA015EVh0b62/RwRoWO0+IFmNRogAsTexS1omo5/pW8cN9mnQ40xtDRAcWJJK9ANtCE4Ot0146jAl9osQOGZ+hZ7Ct82SFVDh7iwm36DZY7e0SAT3rNGZUO4eioIyuArUbbM5+X4eFw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXM72kbTPOzcDRxilc4ZDcgK8HVWiWfO2nfaLdhm4uE=;
 b=dcd9trhWntaW7WgDyiOvYnRfjeco1r9GbAtTtcilwhK55xWpXrG1IbtOJUaiT7FS7DiBNMqCJTyFHIFbX07XDl2alcgWMMatNr19XAXcFcTpBLNHsnfgHD2G9XIGgh1xpADWlXTfk21gTzwgBwMdts77p7t5NsXnINgY+k2SBA4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2869.namprd15.prod.outlook.com (2603:10b6:a03:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 20:15:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.031; Tue, 17 Nov 2020
 20:15:52 +0000
Date:   Tue, 17 Nov 2020 12:15:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
 caches with SLAB_ACCOUNT
Message-ID: <20201117201547.GA156448@carbon.DHCP.thefacebook.com>
References: <20201110195753.530157-1-guro@fb.com>
 <20201110195753.530157-2-guro@fb.com>
 <20201112162303.GB873621@cmpxchg.org>
 <20201113001926.GA2934489@carbon.dhcp.thefacebook.com>
 <CALvZod7gMyasoXgaGJ9hKJO98Cick07gdLabKLqrrPXyXonCrw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7gMyasoXgaGJ9hKJO98Cick07gdLabKLqrrPXyXonCrw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4f92]
X-ClientProxiedBy: CO2PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:102:2::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4f92) by CO2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:102:2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Tue, 17 Nov 2020 20:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db634ffc-a95c-4662-601a-08d88b3594b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2869CFFD6F6C13030AD91E5ABEE20@BYAPR15MB2869.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Imf89yIvRPj1DMb3MQ/nYMrMPB9PVx2b92EWUZoLAlmylx/gbqjruen+aqJeq7lot5ZlnC3XbHbS0p3HR1++Ex0MDAPim0eGd81EHz4NbHYm1KzhWyNQT0zQt+fOEg4kK8s5Vbodwb6O4QSaAgDsv14+E2DHxXHnHE//Hn8B6Od5a2Ih3ffepDTSFN5IuHPSgCdo/4KvbzOV3ZFF6NGCL5jEC+g9PQLIEv++l+P1g++xLCJk2HpSprj/pUQorf9kqEWvNwCgQ2FZGoABVV2KBdcUNjXGmpDQBR3rZmxsKxwJ2O75TC/FqM9DHJJr6QpkUznrnxRyYi9h+SdVBWGvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(9686003)(55016002)(316002)(4326008)(6666004)(16526019)(54906003)(8676002)(83380400001)(8936002)(478600001)(86362001)(186003)(66946007)(1076003)(5660300002)(7696005)(2906002)(66556008)(53546011)(6506007)(66476007)(52116002)(33656002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WzVxMDtAz55GuD1otdTANKg297G3pOSpdGBxZG9H8lUuVn8tfvX7PQYPbNAiPNMNhELIPURHblGvIpXdtc++gOOnT1tX60UB545XJkTn8//b/3t9jyLc6snkJW7Z5rqilOj7y+btCMaFIYmtVIs18VwfGqbp6+bM7xju0f9+JxR3Rac3ar8EWkN4+tGW1+aTdDBSNXUgTvSToH92hCODwZIcuoy89uu40QPo1yQlJYfwY1GxY92/PJFkgUIQJ+1o/Qg3dqZczbEe6lrh81XlaBgbWo4fafg6sDhI6uBT1rYtrsKnUMsT1kbFG6X91hGDkx3QYqzBApWs/rrt9gZoQcSPzZQLGnp69HiJ6+7nB0syDkIFxrR+mL7qYLDOOSbDQXZQvuwJahHxSGg05j0cJhq/7R15X9Jo6oX11hBvQuRtdTdWS4dD3TeD0o5dizuPJXjvNCB8h1Sr/XX/RLQpZvESmBmvEEJIwaHwW2JIl5a5plqx+phvLVXwLCN11DPUo2agZdxERfoj5WRNKFSSwLuOKp5v8w4yypLLCIFcHD/u9qNirs7zfAtKoS1o1atSp0s/UV1pc4Mw1t1rER044lxsVzgJL0Di4iMt12httTBUkuHobjlhqlb7rdFDVV9I92IGn56Oz7/+4jXFO0HMOLIpowM58wVYZ8esAtK9AWU=
X-MS-Exchange-CrossTenant-Network-Message-Id: db634ffc-a95c-4662-601a-08d88b3594b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 20:15:51.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mep2UJBMXx+3dyjMnA/Fw06U7WbQcejeQ8kAO9726+IYjJA/0RRH8k95RhCWOXK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_09:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=1
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011170148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 09:42:53AM -0800, Shakeel Butt wrote:
> On Thu, Nov 12, 2020 at 4:19 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [snip]
> >
> > From 8b28d91475d54c552e503e66f169e1e00475c856 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Wed, 16 Sep 2020 15:43:48 -0700
> > Subject: [PATCH v2 2/2] mm: memcg/slab: pre-allocate obj_cgroups for slab
> >  caches with SLAB_ACCOUNT
> >
> > In general it's unknown in advance if a slab page will contain
> > accounted objects or not. In order to avoid memory waste, an
> > obj_cgroup vector is allocated dynamically when a need to account
> > of a new object arises. Such approach is memory efficient, but
> > requires an expensive cmpxchg() to set up the memcg/objcgs pointer,
> > because an allocation can race with a different allocation on another
> > cpu.
> >
> > But in some common cases it's known for sure that a slab page will
> > contain accounted objects: if the page belongs to a slab cache with a
> > SLAB_ACCOUNT flag set. It includes such popular objects like
> > vm_area_struct, anon_vma, task_struct, etc.
> >
> > In such cases we can pre-allocate the objcgs vector and simple assign
> > it to the page without any atomic operations, because at this early
> > stage the page is not visible to anyone else.
> >
> > v2: inline set_page_objcgs() and add some comments, by Johannes
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> [snip]
> >
> >  static __always_inline void account_slab_page(struct page *page, int order,
> > -                                             struct kmem_cache *s)
> > +                                             struct kmem_cache *s,
> > +                                             gfp_t gfp)
> >  {
> > +       if (memcg_kmem_enabled() && (s->flags & SLAB_ACCOUNT))
> > +               memcg_alloc_page_obj_cgroups(page, s, gfp, true);
> > +
> 
> I was wondering why not add (gfp & __GFP_ACCOUNT) check as well but it
> seems like for that some additional plumbing is required.

Yes, it's doable, but requires passing another argument through the whole stack.

> 
> Anyways:
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you!
