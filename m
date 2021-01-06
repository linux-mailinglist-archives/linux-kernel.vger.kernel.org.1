Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F92EC46D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhAFUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:05:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbhAFUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:05:39 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106K1SXq020097;
        Wed, 6 Jan 2021 12:04:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=byyWW5EjJ5JP8YAPUP7I3603V15sHg9WrQ0YJy3sn4U=;
 b=ee6f5eYivxyCp+zi0tvro1sQ0XI1pIhHL39+nAPXYES6SpCsUd3S4mqzz8kc/+w2CBra
 w9oPUpobNxiYDjMUCW727BBR3Oql1WA0HdtXb3OQm5hi6x/kz4cpcTUYzUyERFy7bP1d
 txq6SY/GovsK3IdRt7Ei62ue5MmhX6n+SHc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35wjb0rjke-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Jan 2021 12:04:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 6 Jan 2021 12:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSgz3PcV1Ym7PIcbUK++81reisbBymE7rcUg5xMNleOMrHF1c7kaQ2fKvI8VPnYIgRclii9IMJdOFlFg7IMY+Lchf7Qg/jdh3W5svJ6aV/o6o7mhMVT+/HeiwHa4LMFzbaQi+yidbsYU82ki1+EZNQt1kIOyIaBV5QG1QwvSsypBZ6r9mqg/3kt5ZygtV4Dj5KV+NkZ+cTFun2OqkjPxrp6gFfxDpF96y9VMPuon5RstcgciBEL3wPA/hD+L0RuJb3mTR7K5USCRz4KLMzz+baXqJWcPO1ol8c4JPeuIl/qMq1FRBJMDgpLzTTvQ2omy8KhpQRzeIWtdXVYJoMNhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byyWW5EjJ5JP8YAPUP7I3603V15sHg9WrQ0YJy3sn4U=;
 b=IiSSPAWB48+TmXIjo2U9oFrbftg8O2jlkI9vV8NXWb/kdOhYu3TCRrTvTnx3AO+uUPQviFG08J/uogjQCKinkxpQm0UQIP6jm04VSZWuzf4RIlEYqqmlWueyoCQkpMriJXDumNNGhLR/4nzTL/q764OCLKYqsD6H2aV3qL3uEyEsk7OUgMAxwLzj17KjyjNhTGZ0LGgUIeo0p6+BenxG1fnAGBITiDxHCxFvCVHyjWd/VKu2IXA4f0gjLuYKYZYnyxQly8vPJjUelPiNNDOKxxAM1MyDgPtdDuu5evWQQ+oTIEIkR/RCrgmhvJwoyrtloRUqKakRL4TjX5MPhKmxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byyWW5EjJ5JP8YAPUP7I3603V15sHg9WrQ0YJy3sn4U=;
 b=EEQkoRcooeQLD+UfLwJtZcLdgGKaVuiDJK+Sq74qnxWO8DDRDSY//RJ16Lih12Uqp0iuurKxGIp6QBcYgsK2irlefJ6/G7ab48QWZFnzZLBrPyrIgFbxQ/MTrrOpVkry9lcQ70VW+qujyVvIwvs0rrQG7dEsIFoCMc1/S7/9Nqw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Wed, 6 Jan
 2021 20:04:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 20:04:45 +0000
Date:   Wed, 6 Jan 2021 12:04:40 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
Message-ID: <20210106200440.GC1110904@carbon.dhcp.thefacebook.com>
References: <20210106042239.2860107-1-guro@fb.com>
 <20210106115044.c4393afa1ad61ef3f8db1d94@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106115044.c4393afa1ad61ef3f8db1d94@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:e8fe]
X-ClientProxiedBy: CO1PR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:101:20::12) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e8fe) by CO1PR15CA0068.namprd15.prod.outlook.com (2603:10b6:101:20::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 20:04:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b353ebb-6dd2-4033-32bb-08d8b27e5005
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159DEEDDF05C19B047E90C2BED00@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWdeu2NXWL9zgGduuTe+NX7x3Uo0bsGVGqLYqmtsyMaTk0CED8pjxfOH+EinCHtedXkVeEyyTie4pbIg6MmBFsurDrPYTUx+F1P57Q8Np519fUOa/iRY+EqDLnPRArUPLUwMYeoxF+k+v31HtxwPRo7U8TvIqk9VV4DfSg5qvYyc8Mm9+Y69cNEkSV3IpXmPwGMpE+NkgJ9Pyjsk9+4GVKrfPKPy0RKI+PQwMLVdgxEHGHsWoZWGQ6Btsmj351n7pP21Pv4JMJ9CYvfr12GkcslRLOQNP1TDjyiJOhQfXgPe7zgKAa2OAI0pFwUqXDgwF2HCEU2zaQWG6YRzLpYvHOufgm7W9UYcDsG/wxFyWW86Ji3r6GqK8A8ay9TKMn7Tk3erDi1ucMMd4B7pAdtfNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(366004)(346002)(54906003)(9686003)(4744005)(52116002)(4326008)(8936002)(7696005)(316002)(55016002)(478600001)(33656002)(5660300002)(1076003)(83380400001)(6916009)(6506007)(66946007)(186003)(16526019)(66476007)(66556008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PSGrpqEPIukLAyo357U0F9aX0wTlpQiQBT3hiQimIA1KQYFKrYNHWllbQ9nd?=
 =?us-ascii?Q?tSQsd6dNlMbq+8AHeEMdvhlDRJHL/yuXZUxwHcfB0ojDiLdqrHhaUBW9oBBb?=
 =?us-ascii?Q?+Nr+Pd/R6wjG3hxxgGmWSfXkSURCd6niotYUHpaG4eMmBsJ7A4o9/nUYAVHe?=
 =?us-ascii?Q?UCOYZmq7+Q9dSSVlSKiBMVrO0DFIfcxiTGpoKpPVKE3XCPMKzjL2BJ6X3igY?=
 =?us-ascii?Q?NZW+5mMfpLr9idYp3t1pvW826Ye3aJ0tt9iW0o0Fut60iIkIXD1bLGHve1qW?=
 =?us-ascii?Q?HPJGx5I7jxJDL/aOvI2DtacXB04OAat701rAMTvSzqokZUVWB0WMnw3uTCj0?=
 =?us-ascii?Q?ioMxyN2g1pUhkBa7umhKyAx5T9rzbHGr4vTVcY1F/uZzV1zqSMPLJvSNOVyG?=
 =?us-ascii?Q?quwkJUyuYn4ZPGqfIHmMEkDFnUFBkD+eFe3oeUZY0lYXLwJNbCAHx4Z64G+e?=
 =?us-ascii?Q?EgPunzaB+OBxCwt4relyltpuJzWIAnhhysBhy9KySs2koNzns7a+1BMJhzNb?=
 =?us-ascii?Q?S5OW+lvTX1w8eMNWrzTali5idaKqLF/GzLszzUPaU3QLhzQYmQELEC2ZnFmG?=
 =?us-ascii?Q?5ftVscYNaREVA2u3tD9jSVDm8YJmHwmmUNIfXxu/iPALRoxgNA0Vfe3PgVMc?=
 =?us-ascii?Q?2dkpaiToT9G8PvRqJJdhPVMw8x63bGksxgpezCtk2Gqr6l+CFF6h8noNPdFy?=
 =?us-ascii?Q?O7ku1C4Xf/mlD0+YrrHRhVrctxP1Vx/7pTcdJiMHNVuSzuMSIcXJvPqHmlI5?=
 =?us-ascii?Q?jZ9yO68DYloLGPsfj5doMXu9xs1sSNvlfgnh0aRl7A9Wz2wpKPFGEKEtkgNo?=
 =?us-ascii?Q?8fI4/LYsSGhYLDOCnXCHHOz4PY9ytSkkFz6dJws2lKt71HpECU5L+wsxBsav?=
 =?us-ascii?Q?UviHLtBhIYAggUopC/SJE6lKNEK/IAp1mUpplu00ztQ/zYVx5zsnzsqqHbE1?=
 =?us-ascii?Q?EYkYWD9KArGzTyhAAjfm7s2bpfyjdSbWBEgJbkv57y+7ULPWC8tovQb+TEV1?=
 =?us-ascii?Q?amwnGRp6/dEXM5+qpX/QjFAbcw=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 20:04:45.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b353ebb-6dd2-4033-32bb-08d8b27e5005
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpKvpiifjS7kEjdznvmG6uXEZKLqZJ9pTUKYbv4sjao7zo+rB8hj1AJyAcGR88su
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_11:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 mlxlogscore=639 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:50:44AM -0800, Andrew Morton wrote:
> On Tue, 5 Jan 2021 20:22:39 -0800 Roman Gushchin <guro@fb.com> wrote:
> 
> > Imran Khan reported a regression in hackbench results caused by the
> > commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> > instead of pages").
> 
> How large was the regression?

~16% according to Imran's data.

> 
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3122,9 +3122,7 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >  		page_counter_uncharge(&memcg->kmem, nr_pages);
> >  
> > -	page_counter_uncharge(&memcg->memory, nr_pages);
> > -	if (do_memsw_account())
> > -		page_counter_uncharge(&memcg->memsw, nr_pages);
> > +	refill_stock(memcg, nr_pages);
> >  }
> 
> IOW, which kernel version(s) should we be patching?

5.9+

Thanks!
