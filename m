Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6E277766
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgIXRGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:06:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48352 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbgIXRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:06:21 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OH5qc1008408;
        Thu, 24 Sep 2020 10:06:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3jmQK/Ry5WYctUo0PXl8gqiCbAHawLfocnFaVnfMyRQ=;
 b=dF3GJ/0t82vFo5xWqX/EJxQ7467qD3GB3XXT9vwjPBLPF9nNQQhwwckOup3cjZeKy4pO
 hoUwu2xg9gW2L732pzZf60Fh83YpMTpvjw9baZ39UaxN1j/W6AUbPpBvD7Et03n6rxfQ
 JmPgFqJ5J46U3cnY6mjkN322r5YXtNsBnio= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp4js55-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 10:06:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 10:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCUa/Aq6FiBDMZUFfNet14GA1uq7WWzHPMtA8cl1C1lNkZA4uXq48F2iquePej+FlV+4Yb5uYMgj2XULIuwVF9orI6zC9HstHpRUdeKgLzKakMf2FRo5G2fNd1NVtc/Oh4DF5ZxImGttNQFi3YtDXE/pDPqUM/WBdlB4ik6Vkgm2RWNO9kxUKKud5f4rt0ss/MjsuDJLEZD9LA/lKMKyMBEMa/RSzKB4v4dGS2VTZ3EsJBLdgYaiPblmKrCtQI4LGdBbZcYh0pXO7VbZyN25f6koLc1x2i8Vrmq0/yjVx7JJzjw43xRhGE+KPinJAM+rgmsWOkWtHAMN72x2VyyVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jmQK/Ry5WYctUo0PXl8gqiCbAHawLfocnFaVnfMyRQ=;
 b=W3kQoLTb1f7a50fnZkygnVm5oOf2FctaZl/WsjN257j0kofq4zlyPPeauQMWnZ8FGJcIKaXOogt+IxgZgh21g1CUvfTG3dOtXjPe1tSwmnUt090YTVh+x/TDPx6y9Sqt4E6unrJavtR167SNtH4dhr1qtmt61fHWd5Jp4j263rh2NLKRQzeW/5z2CREn14BxL8zfoO0DG/oBjaSS0+cv/rhKgke85RI9E/efpxeP+w7pF+23zfbxRVFpLnORLk4kXmJg+hgLaRunlS5OyTI1ml0KggcOal7sShaFXiOUvnrakhj3jGYblwxTAMh+8vAP8wGjZ0pGksdgoq9kus91iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jmQK/Ry5WYctUo0PXl8gqiCbAHawLfocnFaVnfMyRQ=;
 b=HETGXCwI0EWir9COWUap9y19NaAvSZobx2GjKBU/rjwxd182GvpbvrkCxS5dgb1ty6CcNIMXgChz3gNcMBifCjsI6omknoAd9fYHdWEqiEpzqoo7ldW/56Q+O69Z6/oJJTuEhAoFufJJrvQmQ7N5gZsI6vuO4VK5OAsDxop/Ukg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3603.namprd15.prod.outlook.com (2603:10b6:a03:1f7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 17:05:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 17:05:47 +0000
Date:   Thu, 24 Sep 2020 10:05:43 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        SeongJae Park <sjpark@amazon.com>
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
Message-ID: <20200924170543.GA1899519@carbon.dhcp.thefacebook.com>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-4-guro@fb.com>
 <CALvZod7RrmVG4d2XeJJnphG0rkv+iR7e3=S0AtppE7SW4zb20A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7RrmVG4d2XeJJnphG0rkv+iR7e3=S0AtppE7SW4zb20A@mail.gmail.com>
X-ClientProxiedBy: MWHPR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:300:ed::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a448) by MWHPR20CA0028.namprd20.prod.outlook.com (2603:10b6:300:ed::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 17:05:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:a448]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929d252a-7140-4b42-104a-08d860ac14c7
X-MS-TrafficTypeDiagnostic: BY5PR15MB3603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3603A8D1EE6DF9B63DDD3BE1BE390@BY5PR15MB3603.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7YI/COVUJmRYHEeNnRNLPwM7ggtkpdN9UMwMjUn9tY8MDiKF+CMto3QOWVbiqN9HrndHueOV6nBCdO+2BFw11akNUMklR4sf2rULDrpDIvQT0MExTCvf8e8+UzubJC4bH0oT8fbA82Xx57U4tPmZ30FqJLtNQ5WFOhZkf0Ced1sI6WrVyv37wiJB1ViQ7pKO4/DtyugoHMoo6tGih9yqGzQAnVo2FA/RtyyR29pXCmAwnYJlFRqkdtK9RNPwSmZ9pbZ5OrNpYbXBIu/Elb7yFxdZPhvOL2SqRJUgj+Jp+2IvvsMDvQeCMUTr3gR+FZdwLV3R2M0GlMUdkvi6O9umA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(1076003)(6916009)(66556008)(8936002)(66946007)(6666004)(5660300002)(8676002)(66476007)(86362001)(9686003)(2906002)(478600001)(52116002)(4326008)(316002)(186003)(33656002)(7696005)(6506007)(83380400001)(55016002)(53546011)(54906003)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6mNQOyk02ZvVisJRIWG8lPxmkYAPrqrzjwU2pJU6dfamVQrQIWS+DGJWboxF6N0aSgrpm7yGEsoWesL7CZpPtDY6v1rsXynSKz1rpzqWVxsWfFRC1kXlr3c5zDE2Qg4IrqvAkfxlqg6DOZFNoj6+ri1n96HCHs9Hkx3etVX47+90Bl+4K/f+qUSIEXE/f2rJxv23bng5Wn47aP3IY/zkfdlGnnTsedchT1UFcRCBdCMEguYUpWQsyiwdPi0SmpTmD6fOgLmDG4c93WUXVbeEm+ezj8du9LyeRVyNnNhcPvpdo6Q23r1IuocqoDbZh0jpgBEP5Z2VKgluDF+q39eL1GYrTpu2m2Sl9lK6mZO9gkgHQm65Y360yu0xa2wJwyLUEyD6dUfLw/Z9+ixB/j9gg0iJN4WVD4yMgE1XqrNVz1zoevb1m0diZYQkhVKcVntRrDCziS+2ozOyHhpAyG76/wCs1aGagfHkpAMunX8T5gTRm6wcB0z0x5+VFOWTIR/YRqq782f1VJxd0vhTthQTVSr5MNC1+cvNYSRk+uca1+287pamuHO5+2JL+ItAulXXKxAw7ABwUyUdWdrnOCn7JqwONhxuECv/ZljCP5R3sMZvZUbQpikAboBfQeboYXYeYSa1S4CF4mXFscze7myECJ524oA3R5UPNPi8aZv26Tw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 929d252a-7140-4b42-104a-08d860ac14c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 17:05:47.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIImYYOjyisX0V23E6RpS5R1+uBGPIn4zkdrdQjYY6Hh0A1XV8Ya+7wOPE77dFRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3603
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_10:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=747
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:03:35AM -0700, Shakeel Butt wrote:
> On Tue, Sep 22, 2020 at 1:38 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > The lowest bit in page->memcg_data is used to distinguish between
> > struct memory_cgroup pointer and a pointer to a objcgs array.
> > All checks and modifications of this bit are open-coded.
> >
> > Let's formalize it using page memcg flags, defined in page_memcg_flags
> > enum and replace all open-coded accesses with test_bit()/__set_bit().
> >
> > Few additional flags might be added later. Flags are intended to be
> > mutually exclusive.
> 
> Why mutually exclusive? I understand mutual exclusion between non-slab
> kernel memory and objcgs vector but future feature might not need to
> be mutually exclusive.
> 
> One use-case I am thinking of is actually using a couple of bits here
> to store more idle (or hot) age by future extension of DAMON. That
> would be for user memory (anon or file and not slab or kmem) but
> multiple bits can set.

Yeah, I agree. There are no reasons to require a mutual exclusion.
I'll drop it.

> 
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  include/linux/memcontrol.h | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index ab3ea3e90583..9a49f1e1c0c7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -343,6 +343,11 @@ struct mem_cgroup {
> >
> >  extern struct mem_cgroup *root_mem_cgroup;
> >
> > +enum page_memcg_flags {
> > +       /* page->memcg_data is a pointer to an objcgs vector */
> > +       PG_MEMCG_OBJ_CGROUPS,
> > +};
> 
> If you agree with my next comment then I think PG_MEMCG_LAST_FLAG and
> MEMCG_FLAGS_MASK should be introduced in this patch instead of the
> next one.

Ok, agree.

> 
> > +
> >  /*
> >   * page_mem_cgroup - get the memory cgroup associated with a page
> >   * @page: a pointer to the page struct
> > @@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> >  {
> >         unsigned long memcg_data = page->memcg_data;
> >
> > -       /*
> > -        * The lowest bit set means that memcg isn't a valid
> > -        * memcg pointer, but a obj_cgroups pointer.
> > -        * In this case the page is shared and doesn't belong
> > -        * to any specific memory cgroup.
> > -        */
> > -       if (memcg_data & 0x1UL)
> > +       if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
> >                 return NULL;
> >
> >         return (struct mem_cgroup *)memcg_data;
> > @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
> >   */
> >  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> >  {
> > -       return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> > +       unsigned long memcg_data = page->memcg_data;
> > +
> > +       VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> > +                                              &memcg_data), page);
> > +       __clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
> > +
> > +       return (struct obj_cgroup **)memcg_data;
> 
> Wouldn't the following be more future proof?
> 
> return (struct obj_cgroup **)(memcg_data & ~MEMCG_FLAGS_MASK);

Agree. I'll send an updated version soon.

Thank you for looking into the patchset!

Roman
