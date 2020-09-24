Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4307277A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIXU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:29:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12188 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXU3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:29:32 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OKNfQ7017983;
        Thu, 24 Sep 2020 13:29:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ofwuVF3O5PIxYLIaT/g/eH3flTatzqVgfE5g5p6OUFs=;
 b=MD2IqgGqiCzhXu8SoBYRyIZPEGdwPmgT5VUx5xsLG6F06aLdtAijBldwz1DzsxbNpagu
 ONLabnSolkLpmueJKHKhJb1FGk1+OcJlICdT9MD/gdcCSWEJwMHJDcPmutL0J42/j/98
 lsu8IdWG0SSqsVrzdl8LxGSSsb4GIFjNiCs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp43xqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 13:29:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 13:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxA4pLpplFyC3TIiR/PLAMNRyXSkqmDderfasoDTWS/OL6C+y9R+Imxl0eWaycWJAvxmbVIzpV95MCH2crxpHwz/5DR0TUBIt+ve/f2DiRkMz9ip9I1apdaY7tO3NBGfVVzGOQmbP71pcSZQsy+jJHdk4bPCBKkIJV5HK2CZC6Wv6HHfQhyfBy2KOnFuEwYe69PWRhhJ+XRtkwsl4ivm2UZKdJuG6p6q95Pl8GdOVeqpA+t96wNIsuQDf+9oV+t+YunlFkNa4KkSx3f2Zp4ws0exORWGr0st18+t/9ctooN2ZAZjkot9DKNDSMjEZI4xE7GlAAxHFev+uGio1KdVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofwuVF3O5PIxYLIaT/g/eH3flTatzqVgfE5g5p6OUFs=;
 b=SdW1N6L/5J8BSL0hpbReQwR5RCAZ+ltXdqltW+88O+yP+fIB2SQ6dnk9ArKWaV7MMOfn8y9VxBgXEj5Uzb6TYeJFJMraol+JzjxbYD5zlokEn5WeIVuq+WDGnyTigDJh1hdS1kpEsbMKufnj9jqdzbGklQ/npy6yTiKcRcIg2Hze/Bz8of8nSea3VzrTJGBAliCx6e59vP58foKd53UmDLwTJs1Jcrtwn58zzh9k3AGKVeQTaFHKFJO29iRxwM/UhT7epJZzeCyru/e4ddWI06xod9kP9Z0UYqT/wWaSFoYrXjk7mJhGsp30q0ISSfNA+o4rRkMdGb8QNo3P+tvV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofwuVF3O5PIxYLIaT/g/eH3flTatzqVgfE5g5p6OUFs=;
 b=SYvBmOdFgeX/3IGLW3+H4sXtkxz+n19387nEX3oMK+8ZQtS3mAwpfMtD43q9hz7plRScQO6I1dVy5zdFJGKajy45kzRJR8mlLSTD75Lr2MsZ7Plp26gAiJ8kfgBdvqN3jT0rX4aVgh0jxs5d9iQzOnsSFBDffb00OWq8bvFfWzc=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2518.namprd15.prod.outlook.com (2603:10b6:a03:157::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 20:29:15 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 20:29:15 +0000
Date:   Thu, 24 Sep 2020 13:29:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v1 2/4] mm: memcontrol/slab: use helpers to access slab
 page's memcg_data
Message-ID: <20200924202911.GC1899519@carbon.dhcp.thefacebook.com>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-3-guro@fb.com>
 <20200924195356.GB329853@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924195356.GB329853@cmpxchg.org>
X-ClientProxiedBy: MWHPR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:301:14::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a448) by MWHPR1701CA0006.namprd17.prod.outlook.com (2603:10b6:301:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 20:29:14 +0000
X-Originating-IP: [2620:10d:c090:400::5:a448]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c01261e-82d9-4329-0944-08d860c88184
X-MS-TrafficTypeDiagnostic: BYAPR15MB2518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2518E68FEAE5C61264B2F14CBE390@BYAPR15MB2518.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mE2lERs8od1Dr7pepUdKi0d8bg7cUiL4fqqQDVRDxDlSdHJrj4SmYp3W4MCqD7fidDBkO83XTpvJamsuPHtrKo1biLmqeKQ/Phno26gwadckelHzLRwmMjuEtR396HqydjN0y40KuUISqpL1Og3FyUnlzpCPBTsDSXr72uTP4IHu31/7EcIIHKisWg56E5AgmpFKcYuT9SxSYAPTN8ATECloe2SWME/Cd6rjSSRaung5MOVpTcKloCvaPgpWe5H+L3hDN6R+IuXOchZilLS/OFFiKXu2AD4Q9Mu7+etpnXBRcBkXkmXb6HcyAGCo8+pwCjbLTqWe6vsFVlSIBgbzZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(9686003)(316002)(83380400001)(8676002)(7696005)(55016002)(186003)(16526019)(6506007)(5660300002)(66946007)(86362001)(66476007)(6666004)(52116002)(2906002)(1076003)(66556008)(8936002)(33656002)(6916009)(54906003)(478600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wBYHt9S07RhuMekBsaeH0Pxx+rEY7wFHjiKj36Ym36U+FJTnf5uBomgdaJpRk6IDk1EEvTafiLKSXRmo/dMuO9imGxhD8WNhRo3XseHbCAHp56FjkShOjZ8iugMnbg68OfCKQOx2oRri5vFfpOu4CjNv7Sb5p/ZeFQiQjt71rwHJGYCpfjJ/ocLP7qPf7gHFMWFZoDqegBpFtUfp+UarjqVY0epTXFElHvwDP3xygrTYP4c3m96H2slXHMzBwMfY4tp9GGjSRamZNofAoS10FT0znwtxlDMSbsh+0LBoo2fvdG78IJWCSYoaxB5mvI1YICmwtmvVlADAKvFAFJYRMIXJL29I0yfmYZNlUS7Xno1XiEoxX4WdWKRTVigP89AYDLfmwplvhlE6dxgr20wuwP0+Xkjw1LI3x5euE5M2Fa20iDmltkJXNGV66PG7bZ8Z/tI5SPv+OnNOPQkkeV8Gr1q4G9EFWsgWsqGsaZ3wtJYCbq8p2tqi46m+YDq8gBqmRecyKo3clKMmAwpGmifS26WmImpuIr00XS/082UQ3hwDcNetfhgZn3jeBvtLd3EFiqeMYVcy4931i80Q0nwZ3v3+dZha1pBuiN3YKVvmJfXVg3tl7N8GjeltXH8FkgEzqMpfgrcJxf9556NIgAjFMHy68mKFjkEaUMg91R4G/oCKeGT5gyDxhY55xK1mv9m2
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01261e-82d9-4329-0944-08d860c88184
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 20:29:15.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7Fxt3/zH1edlO2QeYfDLzZX75R8SP3SDCU+2xSV5stZwmuH9WyBjCqMK5raazKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2518
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_15:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 suspectscore=1 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240149
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:53:56PM -0400, Johannes Weiner wrote:
> On Tue, Sep 22, 2020 at 01:36:58PM -0700, Roman Gushchin wrote:
> > To gather all direct accesses to struct page's memcg_data field
> > in one place, let's introduce 4 new helper functions to use in
> > the slab accounting code:
> >   struct obj_cgroup **page_obj_cgroups(struct page *page);
> >   struct obj_cgroup **page_obj_cgroups_check(struct page *page);
> >   bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs);
> >   void clear_page_obj_cgroups(struct page *page);
> > 
> > They are similar to the corresponding API for generic pages, except
> > that the setter can return false, indicating that the value has been
> > already set from a different thread.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  include/linux/memcontrol.h | 80 ++++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c            |  4 +-
> >  mm/slab.h                  | 27 ++-----------
> >  3 files changed, 85 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 3313e7c21534..ab3ea3e90583 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -409,6 +409,86 @@ static inline void clear_page_mem_cgroup(struct page *page)
> >  	page->memcg_data = 0;
> >  }
> >  
> > +#ifdef CONFIG_MEMCG_KMEM
> > +/*
> > + * page_obj_cgroups - get the object cgroups vector associated with a page
> > + * @page: a pointer to the page struct
> > + *
> > + * Returns a pointer to the object cgroups vector associated with the page,
> > + * or NULL. This function assumes that the page is known to have an
> > + * associated object cgroups vector. It's not safe to call this function
> > + * against pages, which might have an associated memory cgroup: e.g.
> > + * kernel stack pages.
> > + */
> > +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> > +{
> > +	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> 
> page_mem_cgroup() has a VM_BUG_ON() if the page is in fact a slab
> type. Should this also check that if memcg_data is set, it MUST have
> the lower bit set?

Absolutely, patch 3 does this after the formalization of the bit as a flag.

> 
> In line with page_memcg(), I think page_objcgs() would be nicer.

Ok to me.

Thanks!
