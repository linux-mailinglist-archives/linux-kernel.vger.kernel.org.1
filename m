Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7D297885
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbgJWU4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:56:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S463290AbgJWU4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:56:03 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09NKtePh019065;
        Fri, 23 Oct 2020 13:55:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yk9iy4txK4c8UrCbVIc016qSbTX5lj9UckK9qmj9kss=;
 b=q9oeR8kh/uIyyGTm8Ysnb+339/jptVym0d4EEVufCY8aXbLzXx9IBrLIEf0EUFu7J5R9
 I57w9XhUT+iFCyEJAoMec4z2h6WfB5cQaN1mkj9UKgeDE9QEMFaKNuIOQVmlmJmB9DBg
 cCc8E2thGAPn8l5PEbF1IzveRW5hIo7eNNM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34c2pa9eya-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Oct 2020 13:55:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 23 Oct 2020 13:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzxc+wMmRodiPLejL1xCC6igqXwXlO/QR/hd5fSHWB559NhwkcYJLuxKu60iqoT752nbSdcY/3iJdJ6ofpwW4s32CsuKvWI0z+j++dRqMt68Xx7k8ouxNoeaQ2lIy5+MZvmmjxzxhdX+CKT6wV6KIYtq3WELsSiDGot4n1Oe1JcLeShwhFx+9lQSu/4djx4apBFPcgmCM4EJhkUOGJKBmI5fHq1RCodd2vdOUtUY6UBhm1b6c2ucKzyLBd4SXtJis2XUrzpAnrBgMq+wkleEukyN0B+OU8cVLDq4woq6wchNwkxhZV2EVpaa1L0HtiItw/o1BRE9/AtlYXLJ1Vwt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk9iy4txK4c8UrCbVIc016qSbTX5lj9UckK9qmj9kss=;
 b=EYMwg/dhT5Dk3y71U4V4g/AeqWUtdIOPZyZJi09a5Seb2cH+RU+fwThcklcMkl89Va9tYJ5Ogc0XRVgHpkMrSYQcagZl6ReIq29c+546eKvEcNjOjnjGLMHcQ70j+xgZuVbjSi5+wQhHr51Kd1PqZzxAZOiMV1mdhC+OnDng5SEUpBKd2SqsTUuFuV8IiIACRc+PKyNJ/ZJepm+Yvtd1tudcu7XVY51i4n+/7oD0lxrh3OCpjHo2niS5uwX/WX+Pc+UdcMtegXbalZBXoW//7aeo69BsoBo/OjlgBMdxgJNJxMo0WH4eR5z7AFb/M1kJRR/LYv2Cw5Dyx4TZ5VDKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk9iy4txK4c8UrCbVIc016qSbTX5lj9UckK9qmj9kss=;
 b=MVb681TYk4UhDb9Q1xEc80bV1Q+ObAuxinkm+g9blS0y9jB6Qc1zAKLAKGsY0jYz3bOZW6Pb9wb8064p841xfcWLyA4burvR9Fck022yBHJLt6R+jjYTACR835L1ZzjzQ5y9Qs17euNCVMDpJFzbp7Xc/9MEHaM1C0DUvmigORk=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2517.namprd15.prod.outlook.com (2603:10b6:a03:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Fri, 23 Oct
 2020 20:55:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 20:55:06 +0000
Date:   Fri, 23 Oct 2020 13:55:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <saberlily.xia@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v1 0/2] mm: cma: introduce a non-blocking version of
 cma_release()
Message-ID: <20201023205501.GI300658@carbon.dhcp.thefacebook.com>
References: <20201022225308.2927890-1-guro@fb.com>
 <F8551A10-E254-44FC-B28E-9E7F8AC14B57@nvidia.com>
 <20201023004739.GH300658@carbon.dhcp.thefacebook.com>
 <09C785FF-8FEA-4178-9172-4E41C173E82A@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09C785FF-8FEA-4178-9172-4E41C173E82A@nvidia.com>
X-Originating-IP: [2620:10d:c090:400::4:3346]
X-ClientProxiedBy: MWHPR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:300:6c::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:3346) by MWHPR04CA0065.namprd04.prod.outlook.com (2603:10b6:300:6c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 23 Oct 2020 20:55:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3809874-68e7-4e5e-932b-08d87795eba1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2517:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25170AF94D40BC9E20FBD06DBE1A0@BYAPR15MB2517.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UtZt/uQmLHv1pZ9330IT6ZCCOwuK470eMVw0WgCC6+4zbtAVWcCv2y/+89VWWsL3tyCjynujt09YtsKmlQqG1PGM8BAyaq2kR5eSSLTwkiRtop5lPx+tr4W0NU2K7ROaEsulzQEuj0CtIR41ZAXCp6miPf0MjlTncHOIQlNsT4oLr3bxUGSgJVFy+zMJ3UYheXqw86vZYFROdKaGnnuS7jpZTSptFWoqEY+SlgybxAgm2l84v5T6rMGut6IhfXhaSS34V6CyKEtzxVQZcSeGzQdDfOJbnwBx2EoWagT1oKZwr2G6aiZnFh2UwdYMh7TU+9/pJarcXcOB4tJ7IPqNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(6666004)(5660300002)(186003)(8676002)(8936002)(55016002)(1076003)(2906002)(9686003)(33656002)(4326008)(478600001)(6916009)(16526019)(86362001)(52116002)(7696005)(6506007)(54906003)(83380400001)(53546011)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RNvr6dabIlE3IwhT9SvtIKh4WYh489+HU9dd0x70fSPA9gJEYBDe3blOyQYTer2f90YioL0LlwS8fBrP/CkH3mw4FMG2bCWlK1YX0hD0osuLSTImCeYtbwb8jfvp76FzLEBZ+AdBxMjEnuwkyw+Jk71RF1QZhQoPar1aJNpj3YztcwaoUwX1IZuz/sdC547WWVxFjY68BxfkUGME3fcRhwgLiG9birksDlX8WF4LOa2jjviwJZv4LzZtR1Y3y9AfTWo2EpTsedPuNLsUd7lTOBo3x5+ccGwxmDQH3iMNF+9KNSLzwiNV+q5N+0v+snzbyJ04jnhckQHrDtT4fiaWUDFsawiYgjP/K9IFUfcKIrjiDIBCtPpQXRn22Ag+YnPCrb+p8zFkw86D3lpoLFwRHq2rxdDqbJIMyR2CBLTRThmYz7pCwYFM+bptJpRdmJEbiqm43W3RB62LV1RokZhv/bM3xJZS1MPvTde0NRIXboUvUXO3xFktT6Uqv2wbQU2Eube/FFqe7Y1cpX6Qe4WRtie+yaQspi+ea3wAEcMZi8t4UcNwVIsfqGAnpOgrTubrUHA/yaYAejfmLJA2RBuRxMxBJyP170dhPxwWXCJA605VbqXcLy1Lx1SCykip1BYODMi7RWmEBQYXula8yPUypRJglhdXG9x43GrrsFAOZWwHSJxYZ1AXd+L64k0L/ueW
X-MS-Exchange-CrossTenant-Network-Message-Id: b3809874-68e7-4e5e-932b-08d87795eba1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 20:55:06.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAH1JJnAI0mPo0v/hqzVk8air89rTown/Gj4NMyE7lIvZLUZ/WPVKiczh9lBABqp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_16:2020-10-23,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=1 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010230128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 08:58:10PM -0400, Zi Yan wrote:
> On 22 Oct 2020, at 20:47, Roman Gushchin wrote:
> 
> > On Thu, Oct 22, 2020 at 07:42:45PM -0400, Zi Yan wrote:
> >> On 22 Oct 2020, at 18:53, Roman Gushchin wrote:
> >>
> >>> This small patchset introduces a non-blocking version of cma_release()
> >>> and simplifies the code in hugetlbfs, where previously we had to
> >>> temporarily drop hugetlb_lock around the cma_release() call.
> >>>
> >>> It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> >>> THP under a memory pressure requires a cma_release() call. If it's
> >>
> >> Thanks for the patch. But during 1GB THP split, we only clear
> >> the bitmaps without releasing the pages. Also in cma_release_nowait(),
> >> the first page in the allocated CMA region is reused to store
> >> struct cma_clear_bitmap_work, but the same method cannot be used
> >> during THP split, since the first page is still in-use. We might
> >> need to allocate some new memory for struct cma_clear_bitmap_work,
> >> which might not be successful under memory pressure. Any suggestion
> >> on where to store struct cma_clear_bitmap_work when I only want to
> >> clear bitmap without releasing the pages?
> >
> > It means we can't use cma_release() there either, because it does clear
> > individual pages. We need to clear the cma bitmap without touching pages.
> >
> > Can you handle an error there?
> >
> > If so, we can introduce something like int cma_schedule_bitmap_clearance(),
> > which will allocate a work structure and will be able to return -ENOMEM
> > in the unlikely case of error.
> >
> > Will it work for you?
> 
> Yes, it works. Thanks.

Nice!

It means we can keep these two patches as they are (they do makes sense
even without THP, because they simplify the hugetlbfs code).

I'll send a patch implementing cma_schedule_bitmap_clearance() to you,
so you'll be able to use it in the patchset.

Thanks!
