Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900D02ADC38
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgKJQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:34:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbgKJQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:34:42 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AAGYYOn007015;
        Tue, 10 Nov 2020 08:34:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hkgja81qV4mQd05IJPpu1QG91h0Z2lYPCjO50YuXbnQ=;
 b=B2v27ilEQG8pW337lctH9IbE5jLbPisEahoue/9ZOFYS/kFUSKWguwQNqrG6nC9LZPzc
 2RHZQg7by95MuZh6GKamBJEthZ5gN5TFZY7MbuehtgUb6WvJRoM6uSEWA1SBz5m+r/7r
 lulcanI4x1lXioBeaOCr7gAjAGoIlGSIprU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34nqy2empa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Nov 2020 08:34:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 08:34:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVryitJNMonQ98LKHwmtSo5SobVm/b3LuBC3lUO+43jsiBEg+Ty66qEKPyqgJsJLqtmKRMDcvvyDPtXhqsaaVm3TDqQPC9YYewNrAEi4X5rbgHvDySY1keI+UxqDSYtm7rrrdp+DIHuVsHXtl3u4ugMrz0u+fCtUTvdtj82QQs6Rb5Ok5H+0JVdHyL9yufN0OSo/Gkc9T0wPmNtp3oBm4M8WP961sPaeccKItHKxxRT32yjUkI22KRxJJ6799Rhh4nlBWK34DtD2Krc0FU0l/Xs4Jt/S92+D3OQDYtsCCckSRYVjoXI1A1+dXKQLElTgthHPxQcaAqLgmG1KLiDDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkgja81qV4mQd05IJPpu1QG91h0Z2lYPCjO50YuXbnQ=;
 b=gc/usjhdbDj+LYfU2Qw88EIgYAjXOaqypFKwVX74U2c7lnCDu7w5K6aC3k39K4azh0OPp8ZF0hrFeyjiRm3atlFQp9IKKapoinElJlRhZgEiTbTnbp8eG+G+56DpmtRGU66fXjYyIEUlPjkeUKBDzIEWL4FBOUKg1YAhKB8Ue4PNCzMIR/hpmTLkFrHkzjHUDae2z9ksCcLZDVfu76iKSkIXrYuJtIWuca6yKdFBVwb3x+225c2tqcyGhWyx7OSqtll+oSWnJgA6womkUZs+YQkRAFR8UgGlpS05y/sQ3Nev1Wu8TVFTW9s6obC9+c+rzDajxSYt30Wlm0o/kibQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkgja81qV4mQd05IJPpu1QG91h0Z2lYPCjO50YuXbnQ=;
 b=ifZs52TMHyrsgSs/95gWFKdEHtnJn6vvvNVC1Q31NFbVNueP/mWWSIIxb3D2zRyZbnA9ECtvCqLhiGsqnUA4ZuUjaOsrz7bzVk1RgJEnBzhyWRjpyAXtEJmiMm16ea4bfbXrzT+eDjg3DyARraJemb5PA2xNgUku5nY9lR0BS9E=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3125.namprd15.prod.outlook.com (2603:10b6:a03:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Tue, 10 Nov
 2020 16:34:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 16:34:10 +0000
Date:   Tue, 10 Nov 2020 08:34:02 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcg/slab: enable slab memory accounting atomically
Message-ID: <20201110163402.GC2612097@carbon.dhcp.thefacebook.com>
References: <20201110010615.1273043-1-guro@fb.com>
 <20201110152143.GA842337@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110152143.GA842337@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:a643]
X-ClientProxiedBy: MWHPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:300:116::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a643) by MWHPR07CA0017.namprd07.prod.outlook.com (2603:10b6:300:116::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 16:34:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5677ec9-a8c7-45a9-f6ed-08d885967335
X-MS-TrafficTypeDiagnostic: BYAPR15MB3125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3125B33A0BA4AB65A0737B52BEE90@BYAPR15MB3125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96a7Au+HBki/aVSyfRAPX1vmQl2MFkjZWq3lNu7qWyKo7RyY7f7elAupBunG8nP6jqvS71MefsHUFevjMoXZ0yHGUx0Ygetcsxa5xjXoLvNIRr8uEeGc8ksso/JY6NqAo9GMvG+9hnh81R4796+XS1qn021IkyKmHBBypB9XLVYsALXQbWqxeaWp6RgbgmgPAmzVdelZY4I9sxIZ1qiivG9d1wM3yCqvH96j+A6oXG5mk0gghC/Yg9PdU+QQV1RfaytncsFG9IwpMR/M6xMmr8V4N+DRpocKrj6cSaglyd22sEJ6KeP5B2D76AQ40HOPYaLdbaZXeTFr2UhfA+0jEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(54906003)(1076003)(6916009)(316002)(9686003)(7696005)(6506007)(55016002)(83380400001)(15650500001)(86362001)(8676002)(5660300002)(4326008)(52116002)(66476007)(2906002)(16526019)(6666004)(186003)(33656002)(66946007)(8936002)(66556008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yNNKNDxfYp9upMMl5qXqzX7Np2bdGjBj4rkHIsxF/cZarVs/7T5Smm5lmgkIYsiSCRWazUZEthtnmxN1Jyb3ICQZUX8PCbDGOHH/OYsI957z6feKTP2nvkuykbxoAKl5DmoeKkarEoQauDa0HAkewgC7H+IIhCOmtCT+UhKNsHJbWS/o+vDh1Lbch3nZVMTES71PQWmLSf20poJYjgjfq1Z2/2YmDVBiiSu0RlBi/SY+3i1WzY8fOResrsgc0f9ZvMROFgvmIYeywSBnA9p2RIZ2JkMAX2Jxg10QdsJmXhWbkzGaX+GWK9Tdx9cTkm2SgN/87RjUMr9dnuUFsLsnkini2sBB1KwncbF+C+Z/KiFlqTBcXNDLlhAYRaCVV8wRtqF9Qmu3w2FfhL0rfOtYKtdr01iU5gxTqwUaD+MIiFg0czXlDMZFONYmztZldsOHlxxUJit8+WGhCwTAE+azvjQARCTywpKRaBsDAhvYaFNqmPKCmjdfcNCj7jbvFDtyF3kjFGkpP2pRRTcpxXA8FtrzX1tox9N8Iy4GKJNfpnvSALcXuzKjL8K0tHtuxIh8Z7R/i9sRUsjpDknhnaKuGwVPRkvT5s1AdAka6iQXU6ussLIPREah7M0ZozxTcof1ufsAjSUyQmq8GHEXz/6lOes5UZF1hfOcKEKhaeAj/KI=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5677ec9-a8c7-45a9-f6ed-08d885967335
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 16:34:10.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgNOYQQxSAoDz79tBLjlvym1aYVhHh2Hp99qAp33SQpG04YAyDP+r+gnzBbNVf/B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3125
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_06:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=718 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=1 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:21:43AM -0500, Johannes Weiner wrote:
> On Mon, Nov 09, 2020 at 05:06:15PM -0800, Roman Gushchin wrote:
> > Many kernel memory accounting paths are guarded by the
> > memcg_kmem_enabled_key static key. It changes it's state during
> > the onlining of the first non-root cgroup. However is doesn't
> > happen atomically: before all call sites will become patched
> > some charges/uncharges can be skipped, resulting in an unbalanced
> > charge. The problem is mostly a theoretical issue, unlikely
> > having a noticeable impact ion the real life.
> 
> memcg_online_kmem() is called from .css_alloc rather than .css_online,
> at a time where memcg is brandnew and the css hasn't been set up and
> published yet (the refcount isn't even initialized for css_tryget()).
> 
> I don't really see how charges could race with that.

You're right. I was thinking of it in the context of a patchset causing
the root memory cgroup to be charged as any other cgroup. In that case,
the root memory cgroup can be accessed and charged as soon as we set
root_mem_cgroup, and it happens exactly in mem_cgroup_css_alloc().
As in the current state, it's indeed not a problem.

> 
> We may want to rename memcg_online_kmem() to memcg_alloc_kmem() or
> something.
> 
> > Before the rework of the slab controller we relied at setting
> > kmemcg_id after enabling the memcg_kmem_enabled_key static key.
> > Now we can use the setting of memcg->objcg to enable the slab
> > memory accounting atomically.
> 
> I suspect that code comment has been out of date since commit
> 0b8f73e104285a4badf9d768d1c39b06d77d1f97.

I'll send a patch to cleanup these obsolete comments.

Thanks!
