Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091DC29639E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899059AbgJVRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:16:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2899036AbgJVRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:16:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MHDapR027945;
        Thu, 22 Oct 2020 10:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kLyuz1xrAyviEDF1HOHo/TiqTDsjfU5+ATOBaxGLjNw=;
 b=i51y0cYgrQEQos/1UqOmDoUffOtzLJCJEXCF1oiX5K92/FijeK+w1LvjcHAV70Lk32jb
 sgEFA1IPu7WBiozGt/W3DaIE75l+dWfAVVj2mtXQP+AG+84Xo/+DXsrcAQ4dnTjA920U
 XurrpXAUjgsSAsX/5/wDg7oIdHoL4/Emrm0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34aspde70q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 10:16:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 10:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grg6wd2f7are7WbfDGkF1jpUUQSBgVaaKT64jVwqEFqHnj1blCx9+NyZ5b0ADFblsqu5dvHXSOpGTs3E3AIwKeUCTgOIG6gwtso82+apnSSzUQ0Rvs5wbJ5rBIdHFARVod06dnh3+m7qApJJWiZpTE/NMBd4R+si5Yo5HK9rrospCEA+2LugNnDBSwLs8aaqg5E2+QoXs3jBiJ65EHFlolTyst/sncqUde34OBymssxYnkQEY6cSucSZoIi/WPOljo/6JJkt+Qfz9a1y5Ql+yvN7NqvSHNnjWbMYKuyL3o8wEx2OCyqpeYbs0Ig+K3OuTlZKOYbJXseq/SlVeJt8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLyuz1xrAyviEDF1HOHo/TiqTDsjfU5+ATOBaxGLjNw=;
 b=eV082r/IYHVWNRpGSzC/HY+toEZBB/orJ7sUVbvOfvF8TGsbLyHjxNHtE92sILRIg6ZqK0UxcY+S6bYuAoXqBf3nzdimwr7on+4oXIe1F/4yoUU2HHbO1DGRfmS4Y8ANCw8F3NdJeMRa0VdgSgHRe/Rdd8RkfZCnhLxyVInSIkAlPOGbsV6IJYKhCU7VVa/dKheShzy+88RtbPJ9kPbLqqkC3WkPJ/s+LkahTNDTxKgHEUBR34+0rI9fHEWKe4kgeCZUx15Q+Mfj/jpuFubz9hxyC+9QghRyWk88nWmAKApEoXMgiJW+4rejie+AHmW6e3wRCQH7oMHOvAMVjLmQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLyuz1xrAyviEDF1HOHo/TiqTDsjfU5+ATOBaxGLjNw=;
 b=QigWRAy90eu4HWpgTAnaY78tZXvA8uOfRuMplX0+WL1YRrauc26Bo20daU4wrbku0U0Zg44cPxVZUcLlRnGSVw5bieLHFrHAWXwzfb+OU0hdzWluka7LcGgL4ueCDYrPQxQaL/FEiedCRS5Y7LJW5abt6wCdV/YM8GixVE1Bs24=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3601.namprd15.prod.outlook.com (2603:10b6:a03:1fb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 17:16:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 17:16:38 +0000
Date:   Thu, 22 Oct 2020 10:16:28 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
Message-ID: <20201022171628.GE300658@carbon.dhcp.thefacebook.com>
References: <20201016225254.3853109-1-guro@fb.com>
 <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
 <20201022023352.GC300658@carbon.dhcp.thefacebook.com>
 <91779b4c-378d-66ee-2df0-edb270dd4d04@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91779b4c-378d-66ee-2df0-edb270dd4d04@oracle.com>
X-Originating-IP: [2620:10d:c090:400::4:a3a2]
X-ClientProxiedBy: MWHPR14CA0061.namprd14.prod.outlook.com
 (2603:10b6:300:81::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:a3a2) by MWHPR14CA0061.namprd14.prod.outlook.com (2603:10b6:300:81::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 17:16:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3439b24-8ff8-47f3-7eb3-08d876ae3c1d
X-MS-TrafficTypeDiagnostic: BY5PR15MB3601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3601D4EB466238FBF21CA33CBE1D0@BY5PR15MB3601.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx5xfdKcDmOdaCle5nuSFeP1jKgx6rp75PDqu+D+2+1t6oYjmtMUEyXJ9FF36XD1L7SfcPoyxNnAVDDfMtMJETanXcDvJ+grqqdjqvAxBD+CKTJKGoB7oO9paGu6tra+y7wIcjPR6YXh7nF1n3OJ0IB4AcPiGLge93YC8d0fk4QG9k+cSYSUj2mOCekUpBNbwPl1ltQ80BP7ukVb/FKg3drYFudTc2czqmB6FXOjqX6rb1XztQ0S0dbeG5gkypHXBK1Mz0vfAPy+6I2MjSOt0t4Y8en8JjB5gUx7J/n/gUsq23VV4cEoohre81VbuaiPcWyR6wie9ebRq1JzO+SAPVuPRXaQKTfAxkx+TpCq4x7xYF3rEltRuTt5nzoy+gqOm20wtxKEGjpJ8JVvWnZwMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(8676002)(83380400001)(7696005)(16526019)(53546011)(6506007)(6916009)(86362001)(52116002)(9686003)(2906002)(316002)(478600001)(8936002)(55016002)(4326008)(186003)(33656002)(5660300002)(66556008)(1076003)(966005)(66946007)(66476007)(54906003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UTvSuogj26a/SQmPTP1WMTUPqfILkKVq5hfw8uyhn9KAA0Yl+gkIh+1IzkO7OK5oiFCeOOGDHnpD+upu4dvM37KuQHKTrkLd9U7TctD1i4rYp/Ua4h1Fu34+jdM3HuRk5c1gjRTaA8aA3a4Vsik76ba50hnUrlowadyGX63c+wUM6LaDWMLBcYdlAaG0tDvCYDdDHqYvMUXHK16o55U2SdIRc79axGnzRNKd74e1n7gwlfKdwHDj48Y70jgCQxJb8+A6mJFY5dfTYTou/0nkBPCADQoy4+quA5jyWnpFrYfzmAL3NckoYb3qVml1R53fwMOesV4FUk8LOgekSTWaIpgI+a+kYrHlL2swgXF+NAP0rU1yrL952OoyfALsSiCmhARk/KI3YShjFaZGUOuCSd5Fspn5ANg7z37UffiAA/pyJiOB0C0p7BrnDtOnAGoG1CAsBGAfSiEs1KtXwgUgJhW02Jen+tdly66xAEAjnJSud+qLGLLk4VRxWRTrSY7wVF5CanUsot+2UqhsVPglZsylz+b5fFnU+0shvuFMkHCfLajkX+zziJBk4QNXXv3g0tRaLDQGldY3MBx6DmzIF5g+HUmhpkjbF2SuhplHnnD0TVuCAWRhy+MN6+ME6AEYipAA0gGsSgiLWuqp0YLyG52YD3KTuWeDWBTqETD6YtHRbkgCpvYyzvCG5ZKwFMcl
X-MS-Exchange-CrossTenant-Network-Message-Id: f3439b24-8ff8-47f3-7eb3-08d876ae3c1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 17:16:37.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 611coTQ4CX6aWZvRYT650uBGNtVqpeWoJRWxaeyLHIl82bNN+lyVkTNfJjSYUH1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3601
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_12:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010220112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:42:11AM -0700, Mike Kravetz wrote:
> On 10/21/20 7:33 PM, Roman Gushchin wrote:
> > On Wed, Oct 21, 2020 at 05:15:53PM -0700, Mike Kravetz wrote:
> >> On 10/16/20 3:52 PM, Roman Gushchin wrote:
> >>> This small patchset makes cma_release() non-blocking and simplifies
> >>> the code in hugetlbfs, where previously we had to temporarily drop
> >>> hugetlb_lock around the cma_release() call.
> >>>
> >>> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> >>> THP under a memory pressure requires a cma_release() call. If it's
> >>> a blocking function, it complicates the already complicated code.
> >>> Because there are at least two use cases like this (hugetlbfs is
> >>> another example), I believe it's just better to make cma_release()
> >>> non-blocking.
> >>>
> >>> It also makes it more consistent with other memory releasing functions
> >>> in the kernel: most of them are non-blocking.
> >>
> >> Thanks for looking into this Roman.
> > 
> > Hi Mike,
> > 
> >>
> >> I may be missing something, but why does cma_release have to be blocking
> >> today?  Certainly, it takes the bitmap in cma_clear_bitmap and could
> >> block.  However, I do not see why cma->lock has to be a mutex.  I may be
> >> missing something, but I do not see any code protected by the mutex doing
> >> anything that could sleep?
> >>
> >> Could we simply change that mutex to a spinlock?
> > 
> > I actually have suggested it few months ago, but the idea was
> > opposed by Joonsoo: https://lkml.org/lkml/2020/4/3/12 .
> > 
> > The time of a bitmap operation is definitely not an issue in my context,
> > but I can't speak for something like an embedded/rt case.
> > 
> 
> I wonder if it may be time to look into replacing the cma area bitmap
> with some other data structure?  Joonsoo was concerned about the time
> required to traverse the bitmap for an 8GB area.  With new support for
> allocating 1GB hugetlb pages from cma, I can imagine someone setting
> up a cma area that is hundreds of GB if not TB in size.  It is going
> take some time to traverse a bitmap describing such a huge area.

If the cma area is used exclusively for 1 GB allocations, the bitmap can
have only 1 bit per GB, so it shouldn't be a big problem.

Long-term I have some hopes to be able to allocate 1 GB pages without
a need to reserve a cma area: we can try to group pages based on their mobility
on a 1 GB scale, so that all non-movable pages will reside in few 1 GB blocks.
I'm looking into that direction, but don't have any results yet.

If this idea fails and we'll end up allocating a large cma area unconditionally
and shrink it on demand (I think Rik suggested something like this),
replacing the bitmap with something else sounds like a good idea to me.

As now, I want to unblock Zi Yan on his work on 1 GB THPs, so maybe
we can go with introducing cma_release_nowait(), as I suggested in
the other e-mail in this thread? Do you have any objections?

Thanks!
