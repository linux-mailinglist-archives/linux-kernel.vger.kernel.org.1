Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB27E27F621
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgI3XpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:45:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731882AbgI3XpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:45:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UNisPr006537;
        Wed, 30 Sep 2020 16:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=L09J4ey/cxEK3u5InQkq8/Wued4nLTmqNZX5eCh0Rf0=;
 b=IwZf8BqUc5m0Hk07T9aK3UumPL/7tdRdPAeGxgFK993Wq3YyTumbppCb+r+aY57K+qEd
 3Og4OPnH+p6q5KnnBe5D0yTpEoI+ALAnL68A36fPz/GwZmzug46Lr2pb37kEyL6tw7zK
 JKn4in6hNwGq+tj7pa6Kd1gR8BHv3qdQOt8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33v6jxh8ep-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Sep 2020 16:44:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 16:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9aIB1P/R9xKfhdAHnYCfD7RdIELrstJFBbUt974pfAGF+FEnwuHjWCiNXWGpzfUiHRU9/gn5QGhfpXj8guiF4o+FA3TfHt1Bgnq59npE6DBWjhkbemRJq7sgsOFav6jP7b31k50RWGViZNjx73gCclOuoqvc9BlPf/IqmKBpQPieM7xMPGSUaQAo2qewHOJurr4QDNyLMCwM0TKolUUVbFw4fIv9ZxX/0SubUQijewqDY7UvWLl8v3h517gpgwtoZfBQnMOhjJ1M1JhcRg98/ob2pafKQpZNNSCPaq8MkloKqubaoCM2pwFEnLD//ohZEGayGrM2zfIoBaQX1gYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L09J4ey/cxEK3u5InQkq8/Wued4nLTmqNZX5eCh0Rf0=;
 b=HHAVp7NfTys1Tq0LD83IvXpw5EdzFtkOjvx0P724ZYD72mwvrX2jz/shaTJaY6ilHHGQ4gBn4Sd01VmX6hAE4Oq5s11Gb8ksRDwc7CRIptqEQutgKEMHJAQ8HFMMyQ8x7oPBox+HXlA52hQnP1XnUmk8bJWR2uKZRMEkPWtI7QbAzQ2OO0hTbZNJccHiAnnqpGPSfgGVSawxZeqlDF17VKgWrhukGbpJmkfJ/SZyJjJliS3tA7YwwPIKPykstac63MmEw9E11x4mxQrqjdsL1wChffa5nLNDhj5EkTKF/JLbDV8Ab/FZ6d4PAD4vzcWLSMn0i0wRGgfuWxP5jz03FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L09J4ey/cxEK3u5InQkq8/Wued4nLTmqNZX5eCh0Rf0=;
 b=QKGuPvIUkxZHrk29UHc6QK/er5TsBqnzc8k5IBvgTwN2NYj/21m5XObBl0I0QyYwUPH9Fp0gdND8lfUp4ha2EsrUq5tZuxE6xdC2mq0sVIGglS2XFHh/Glm3YwLwAjvDFHIgT3szfWVJiJ5JjCtU3thB3UR0ljKGUu7bLh0W1e8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB4127.namprd15.prod.outlook.com
 (2603:10b6:805:63::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 23:44:49 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 23:44:49 +0000
Date:   Wed, 30 Sep 2020 16:44:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 3/4] mm: introduce page memcg flags
Message-ID: <20200930234445.GA2700710@carbon.dhcp.thefacebook.com>
References: <20200929235920.537849-1-guro@fb.com>
 <20200929235920.537849-4-guro@fb.com>
 <CALvZod5gMu1OaAspWPQnhCXOmT7U9-cbwBvK83efSYreaNWKNw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5gMu1OaAspWPQnhCXOmT7U9-cbwBvK83efSYreaNWKNw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:59ab]
X-ClientProxiedBy: MWHPR1701CA0013.namprd17.prod.outlook.com
 (2603:10b6:301:14::23) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:59ab) by MWHPR1701CA0013.namprd17.prod.outlook.com (2603:10b6:301:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 30 Sep 2020 23:44:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e90ab8-832c-4467-21c1-08d8659ad1f7
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4127B4A8D53458B2366BDC6CBE330@SN6PR1501MB4127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNIYP/AhEVq59Kmn0G3vjSqtAWMaiiPu61mpijvTN7c7Dw2CluZcXOb38mqK4hk7fVXlly3okc+gOrqpsLWNQtRigw66NgSY4p0tgmVFDJdbLQkY/hJ1uIZyfVzhFQQCdWZ1jmwkgc/i9vWnVMRuM+ruUQK7n0hQgBzxmhMxBPuV+76Zj0EDr/lPxyNB54AQqOOnTxa8v5RVyU5cYZCogv4xGSJJT25VO77xugqBeMwMDf3iLpmYuhlDpypF49za112JHRqPipTOCsdWjDC+wcaqtjlS9xiOVpy1jZrDZsU4E5yrQUFFrfew0Vb/Ix2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(136003)(39860400002)(66476007)(66556008)(9686003)(8676002)(66946007)(316002)(478600001)(1076003)(7696005)(52116002)(16526019)(186003)(2906002)(54906003)(4326008)(8936002)(55016002)(83380400001)(86362001)(6506007)(53546011)(33656002)(6666004)(5660300002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: z8AZXZLl3Gs/l33ZTLA/FLltsNlzfk9dQkkKGszPztYXvyYPqVjdyXZj0RdswXnRQ8nCbsX49C0f6jOSuYYFCNx67+Gcu2edVfIh3fxoXLLbvMuydlGV6HX3Rne16MqfnMw8DK9J8aKe+RdDMRqexhR8f076i07zDwrE9/QE4hhEZKyGnr9vfUV716EkKeTA2PpwiF7C8gp7HNsPjL/UXyWYAwikteEbl4gTFnwIdVe6DbWONy0UCBwANhTDde1s60Bv3P6ZUpTHJUIDtrsr7g1Fqlsrq8+4wsILQS2TjmYUXpY828Wvh/CZG9aZUN0GhwxE9c0/eqoATJE73OW5z2rLwBOWotGw2h5X5tAe8jR1khrig6IP+2DdrItMPFQfGRwnSsgL0KGcF7BCLP5OOQlFrcXSC4iSuJwmB9iJem6WtLEOKkRkIq2pva68DNuLPQ2TReBiDx2n+VuoPL3oK4Js4OcfqbTgi8Odtcsh1+ho77yMOLIaCbwJw9/0s1DyBwhWb32+qfTTGrFYvJufg45Uw1qWrZhT+84N/cKMa+0+iNnxI+ts4IgZAFHILXxVdrb6lrsKi9QLDcjmgEzgLDwXi/S+AEru4EPJQUwyIVZ06HvEWkG9YE6z3TTeswxgCEiGIqIMFt+MmKkR2Qp3xujTuaEr8+RSX15MxMvzloI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e90ab8-832c-4467-21c1-08d8659ad1f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 23:44:49.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOehMhNyW3K9yd2ZdAFLz4JVF42eN30P28VMPZj7QhcIDrRjeT7d+0dfURcj/Bo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4127
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_13:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=1 lowpriorityscore=0 mlxlogscore=767 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300193
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:35:37PM -0700, Shakeel Butt wrote:
> On Tue, Sep 29, 2020 at 4:59 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > The lowest bit in page->memcg_data is used to distinguish between
> > struct memory_cgroup pointer and a pointer to a objcgs array.
> > All checks and modifications of this bit are open-coded.
> >
> > Let's formalize it using page memcg flags, defined in enum
> > page_memcg_data_flags.
> >
> > Additional flags might be added later.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> One nit below:
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you!

> 
> > ---
> >  include/linux/memcontrol.h | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index d4d15c04bbaf..35f846c6b89b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -343,6 +343,15 @@ struct mem_cgroup {
> >
> >  extern struct mem_cgroup *root_mem_cgroup;
> >
> > +enum page_memcg_data_flags {
> > +       /* page->memcg_data is a pointer to an objcgs vector */
> > +       MEMCG_DATA_OBJCGS,
> > +       /* the next bit after the last actual flag */
> > +       __NR_MEMCG_DATA_FLAGS,
> > +};
> > +
> > +#define MEMCG_DATA_FLAGS_MASK ((0x1UL << __NR_MEMCG_DATA_FLAGS) - 1)
> > +
> 
> Nit:
> 
> #define PG_MEMCG_OBJCGS (0x1UL << MEMCG_DATA_OBJCGS)
> 
> and use this macro below.

Johannes's pushing on defining flags as bit fields, so I'm sending v4 soon.

Thanks!
