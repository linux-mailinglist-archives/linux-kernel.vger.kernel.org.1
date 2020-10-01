Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53179280688
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgJAS16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:27:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32106 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729412AbgJAS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:27:55 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091IOgpu016494;
        Thu, 1 Oct 2020 11:27:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Djm01oBH5+Jx/5FB7BIlRz06NdjBzRGxc+1VWHCMax4=;
 b=G0fQeujWbtDZcSmAkqyuLgLzt06ReeTFNRdbCRowZvjZZYoLaE/X5fVcZwNp0axaLaU8
 C+tW/TRNeBdzF2RubSsRUCzHcUF29Cch7R0t4NINmlLeXl2bmbju/MNQdEwSfJk7A6b3
 ybHjUvl/DggvLLCjQj34lTrNGLi7Cx0Tq9s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33vpwcs6t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 11:27:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 11:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb0+QB3hnSFNAwWP2Um0zXP/jvLgm0z6k50hCnfkjGbfirtJInMXH20CE4YefKm5xwaRBNV4xxrSwZOqe2LVCBZG8y9cqhqNArAhuadg2oLK/HIAD5MDb4xD7fB7ve1NiWG28JZ1AhmEXkOsNWJIbaTuH/gp8gYu/JVFeirEOrhZdYgHfbFMXiqlFDXwOhUjoPejLzwgtljhjZL77cLDj1LInYtFbo1mEurgzGbkqx+29GJKu3+SbucUG6Jdbihmeb9zmWg038J3gsQnA/Giy3Nb0qvrzBKxBnxoQFUKAnvLG1DZ+joY1nBOHX0lnKes5qWZEtpEd4eCmiuNnPW4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Djm01oBH5+Jx/5FB7BIlRz06NdjBzRGxc+1VWHCMax4=;
 b=Ceh5LM/0XlNIn205rRaiG06FurbUfObL3RP7voDc+Clo91WckPgyWRvlSc41fie3ZOsFB8X2RRW9tS5QweXQPq6Z/mqqKeWL/PTVSSxXJ1wCnyJvbgX+NVBW6ASik34dDxdyMyU2zxt4aFfQv/x61IiAltMbvoPfGn27kfNOuS0kM6nC3BqjUaOxGTpt76CHG0KJNFuUzsB2IEPgn6o1+0HcETLQa6jgrhk4XcMGSF3f/+Ks/IXU27HZblmUxeT78Tp4Yzfdw0kH07umkDAvCSnxBEVAdG6aYkDSjtWz2dklYh29PU3Ma1BuAt4Sc5742mRi62hpmJgZxpbPflwtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Djm01oBH5+Jx/5FB7BIlRz06NdjBzRGxc+1VWHCMax4=;
 b=Hzgsw6JdWWjUD8yYjxbSyiyW9fkamdn5Ti3Hb3Ij/xDJ8eDcWD/vTJiYqhN4tvXpew3G2ch29CzMnSSUYZec5LQqldNDutpDu+I5gz30djQDa1Ok2aZRmDT/+Eu93otmn2S9ZnT4dfLtO6SO+dVDb1MwNNE0DvytJhsQ2kGXQmY=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3840.namprd15.prod.outlook.com
 (2603:10b6:806:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 18:27:45 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 18:27:45 +0000
Date:   Thu, 1 Oct 2020 11:27:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v4 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20201001182739.GA2706729@carbon.DHCP.thefacebook.com>
References: <20201001002710.748166-1-guro@fb.com>
 <20201001002710.748166-2-guro@fb.com>
 <20201001134638.GE469663@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001134638.GE469663@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:ad42]
X-ClientProxiedBy: MWHPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:300:4b::14) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ad42) by MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 1 Oct 2020 18:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf6ebb3-6eac-4d90-fef0-08d86637b0e8
X-MS-TrafficTypeDiagnostic: SA0PR15MB3840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3840435AAA672FB3A78730E8BE300@SA0PR15MB3840.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWyF1eRDb7QwKMDm34RW2o+onKB5sCrmoeenAngvFiAZLzjVkq7yEtVcg3Qv1vRsbV2iDd6lJ6kWjpAzvO6X6vpnfqACF9XeoiQ8NuRWVqLfm77p1jCJLimwCQxosw4ZXijsxrtaccHEG8BVFNKC+HdwNlpvlrmCYxO3JDM+rkqhCphhkK3oiMY0pi+dkEWRCvLendEV8DEoZ5ZI+teEekqmfybuMt0z6KijZzLRZSJAghQkWmFHwk6NKPpZfle9L/KvtDMcTq9eT+Gqlp8iEfwAwP3DSCadxZ4lP0a3/gNPMRocU9h3iG+a92kBI47uiSQfVxX2nk0KVMB2ASDGlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(4326008)(8936002)(7696005)(6506007)(52116002)(83380400001)(5660300002)(6666004)(1076003)(478600001)(316002)(16526019)(186003)(86362001)(66946007)(33656002)(4744005)(2906002)(66476007)(66556008)(8676002)(54906003)(6916009)(55016002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8DCJC1fZ0CRagoUTyQC53FE9SuRemTGb1ayfsWi8vO1/wc6eOzo0OqwctFFY6P/J8Z3SKfvsk3Z3J7uhiGuHqooAeDqIf6cEr0dI4KG7oC+ZBnmBcersR4kCpjkdAQqDBBeSim0fTokx/eMOgG+V4j/LRAGFn2ObyCrPN/8gr+2hS8/tXyl+ABGCqkxExBIxSYJ9MU7926ocIib8fheeeTbu7TPw8RsjQuoJAnH8XKvWjlPjBaqJKVGoOYziPmXi8U30UFB6k0o9NPnd1QDTbIYO/rvpNDq59ZH1rkriqhwhtUcte3aVIfBe4Ofe8v1zBuS5uxYlM1WxarZBYw05D7zJi67EoH7s09Q0FEOcX5CTR/F3YTLQLMi0khkODzH3uIbV1lzyz2i9114aRxJzN/AoKkNS0BJvcipQHnvvbbIqykmTZ5YklECitXMFWJda+S0Kl0pF2xrIi9H3N3/z8CfbTnHrKG6pOs7QEyL0yIh2MOFKrCYsLhuQIlMBNqZQ792j7rHi5/P2bejYsr6Ivk+s7hiHK7wo8D1uJtMP6zuXmglnsAVtjRSrLiHlttR9ORJe/FwWR3E2eltmg7nz6hq7LOJ9vtPoI1sgWJhFq//qH/flVRRTKGDZcW/SboPe03vPgbcGISuciYOTdkkSGfAQAozpeU9FTZ0YqohQka0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf6ebb3-6eac-4d90-fef0-08d86637b0e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 18:27:45.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFgf0idAbn8KCkwJRG7VMxOvkNjETstnss+wwJ+2D550YzjdKh51MIsXg1C4dX0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3840
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_07:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=1
 clxscore=1015 malwarescore=0 mlxlogscore=746 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:46:38AM -0400, Johannes Weiner wrote:
> On Wed, Sep 30, 2020 at 05:27:07PM -0700, Roman Gushchin wrote:
> > +/*
> > + * set_page_memcg - associate a page with a memory cgroup
> > + * @page: a pointer to the page struct
> > + * @memcg: a pointer to the memory cgroup
> > + *
> > + * Associates a page with a memory cgroup.
> > + */
> > +static inline void set_page_memcg(struct page *page, struct mem_cgroup *memcg)
> > +{
> > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > +
> > +	/*
> > +	 * Please, refer to page_memcg()'s description for the page and memcg
> > +	 * binding stability requirements.
> > +	 */
> > +	page->memcg_data = (unsigned long)memcg;
> > +}
> 
> Please delete and inline this as per previous feedback, thanks.

Why it's better?
It's ok for set_page_memcg(), but obviously worse for set_page_objcgs():
it was nice to have all bit magic in one place, in few helper functions.
And now it spills into several places. What's the win?

Thanks.
