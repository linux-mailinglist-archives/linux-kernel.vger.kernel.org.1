Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA9295670
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895100AbgJVCeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:34:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2443334AbgJVCeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:34:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09M2R6Fc023974;
        Wed, 21 Oct 2020 19:34:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rdxFCVVj36WbO9yq75l1EqwaKShVzPdmQVqdvRES3gI=;
 b=dkpcdYllKAo6s3Se4pS2gQAg7/3334ZzVTN6Agbda0TjDiVpR6TwU+UxCf9N5wbRpMPU
 AlrNnJzfAhTYc5PA0SCYlgPjKOg6WVFg2kmISfoH/bFFbDt65IDZZEhlhDpDjKMRLTPa
 h0MC8+9FpobZbaMltlIAk+nPVyBVpZ7J9Ag= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34a41mru25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Oct 2020 19:34:01 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 21 Oct 2020 19:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTaHKR5zHFuJ5CzNL6CWBfTLoSGVtQrwOIizgtvcp2ZGq5uD7voA+ZLE1lYxs4d1MVOs8Td+Z9chnErZ/dFGMpKYQSnWX+X0REMq9vqWOQYFweiBlL56nCOzGSNyQOlTsI3q8okI8SdH+m7KnSky7KOOTzrzx+C+46sl7JRo5FOIQUK4OiZc0QEqwC7q+/iJTnhrqHjERSCKMyBh+jCiqnnfnH6EKVETlj4/Ew/CTjctfl3apLDSUUUcS7Gq1VARSpk/vYqZHA+X3Lh8STpMR84fiDn5LxeCthEyo2iNukjhtAcryVGN1o9vSRU9Gsdbb/S0x7dp5wOk9Vy5GScMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdxFCVVj36WbO9yq75l1EqwaKShVzPdmQVqdvRES3gI=;
 b=dGygO5eSfIBWuW5PtHrwHGQ24IlztkJPin+Vedp/ZhiLsU6x4l7iCV+Z8V2zmTmAetIllPjFMHazSyOKEWxwFzoOBsSRmjmEvegiFnEL2g/XogHeuXc3FVQnOtwoZl9OZD7pcIWoEqVHfE64KO6H5CzocC0/2HZ/hrzv2AjPXbU7OJ6JkmL0OgvKP8mHYvFYOmqMAAaIQBEY/a0rBXMrX8Czm+APFqpx3g6/Jdmvf7qqDZqChLOC31ZBDDgXgaTGaIdUSRjfFsDorIvLjBH01X637diZ8B6jgAVFflRK8vO+7xB9vRugNPhzcutK6CE2VmKQEb+Go0KlH8ijLWuPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdxFCVVj36WbO9yq75l1EqwaKShVzPdmQVqdvRES3gI=;
 b=Lw9WVkF/1qh/OOlJWkJb5/eVH0HN3oTM0MAAGE++UHwLxqyD3G3KUl5GFD8YP7CwyMEGYW8DNSuyyS3j3/3GX4jKKwxuejW2jKFMQ1T8WDt8PASpjJMp1+h34VhLYvp9H+jG1S/c8WksFcidCT6pjQSrWQMz3rbmOsAkdtmIt5E=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2807.namprd15.prod.outlook.com (2603:10b6:a03:15a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 02:33:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 02:33:57 +0000
Date:   Wed, 21 Oct 2020 19:33:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
Message-ID: <20201022023352.GC300658@carbon.dhcp.thefacebook.com>
References: <20201016225254.3853109-1-guro@fb.com>
 <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
X-Originating-IP: [2620:10d:c090:400::4:4b52]
X-ClientProxiedBy: MWHPR10CA0010.namprd10.prod.outlook.com (2603:10b6:301::20)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:4b52) by MWHPR10CA0010.namprd10.prod.outlook.com (2603:10b6:301::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 02:33:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ee7e03-05f1-4091-45cc-08d87632ecd2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2807DBC68E7B29C45B733972BE1D0@BYAPR15MB2807.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJ4UVtV3frGknRCVIMrSD+3XDVh9AUAE2AfiJfL3F3cKTjclMzMdbx5ZIk9HgwUmqdCrkuU99ub9U1Gn1TyIjhT6PosGw50MYl6In3mpbCVGmLDSwfHCmEFiMhqgvW3bWos7043U6DpDHgKHhMnYFnpASg5+dYSVsHpK2280ExM5oeuIpb8dX5cccTj+gKvW4U1B4q4ktHB38+ZP83vp37EvNVVfNKVZQblaz2KmYy/FliGFN5FAa7DHtPRmSgcB/lIYSbZc4QvVeamq8XgTiJXI49XVsdbucS+SK0INXGgONfR5FzqPX8NA2gjh9W5gti1o8M3zo+s2V8fxjgwRkW+oBwecZK1l0UZQ1iAW4TyqL6z0p4LmD1dc6B6Js9urf5X8qf4lFEoahGSAIGCN2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(346002)(376002)(2906002)(478600001)(6666004)(8936002)(33656002)(1076003)(8676002)(966005)(83380400001)(86362001)(9686003)(186003)(6506007)(54906003)(6916009)(66556008)(66476007)(66946007)(53546011)(316002)(55016002)(52116002)(16526019)(4326008)(7696005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: g8xwvwd/R524ODXLX43FEgYp1D956BE1zqaoNI7BTAJXSFEt7NrqbPwfCx86NSUWzbbO8cVSdsbl5H6s+O7x29wFWGeilJvfagvoi6dZFfxWl/qcAcba1jgpJje7ahu07uY/MqEipLlvh9oM02Q085U8148v+uxRpPGSgnrPq0hdMsJrI5X24vfSasFGNwmC24GwoJK/nlYwIYOFwyiuc3+zfWG7w8bU7CrEd/Vng0v231ESYWjuq0t9xm1H3XoR7myo2LqCGgKdbhScUa2tenGd4z2Xjmx5cT0tIVEQ1tAujAf4i0HZtMyGfYxDs5DmPPKkBgo+nyN35Ydov8+TqyOwxSArULl2UJg9wWOA0RgLRBOza9yMGcZmyhQE5V7aqZqhTQ3XJ+zpVkBTyF2YVbDScB7mlBTHlraSHHYGqC1UW8JW90+drj6MugivliMaN7trf/ZrNB49Plq1kobC/HQiMBt/xEl+5882EYSLG2THDh8FJEic+wiA1mPFqmQHLrDuHon8gx4Wop1NfOPb/EAV6/QfwYm1P/SqluU62KnYUXmTrBnNhN09xaVBiSrgmkImODLwP6cf0Jk32wkPrj7A/+sNrWjuEyrH8jMPMSQn+Y2rX7jwSx+lkxmTt2UZ0Pk1b8aTwV5/SzE2d0HdTwws6hWlUkkBChXor+g6GFciRJkxxmWtSi6pH5G4LeB6
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee7e03-05f1-4091-45cc-08d87632ecd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 02:33:56.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uskc9dyQPcRgj2ReMEHJlubLK9QW/NrHcIZ4GU0BpJuTWngyvTPHyB38tJJrXYAZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_01:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 05:15:53PM -0700, Mike Kravetz wrote:
> On 10/16/20 3:52 PM, Roman Gushchin wrote:
> > This small patchset makes cma_release() non-blocking and simplifies
> > the code in hugetlbfs, where previously we had to temporarily drop
> > hugetlb_lock around the cma_release() call.
> > 
> > It should help Zi Yan on his work on 1 GB THPs: splitting a gigantic
> > THP under a memory pressure requires a cma_release() call. If it's
> > a blocking function, it complicates the already complicated code.
> > Because there are at least two use cases like this (hugetlbfs is
> > another example), I believe it's just better to make cma_release()
> > non-blocking.
> > 
> > It also makes it more consistent with other memory releasing functions
> > in the kernel: most of them are non-blocking.
> 
> Thanks for looking into this Roman.

Hi Mike,

> 
> I may be missing something, but why does cma_release have to be blocking
> today?  Certainly, it takes the bitmap in cma_clear_bitmap and could
> block.  However, I do not see why cma->lock has to be a mutex.  I may be
> missing something, but I do not see any code protected by the mutex doing
> anything that could sleep?
> 
> Could we simply change that mutex to a spinlock?

I actually have suggested it few months ago, but the idea was
opposed by Joonsoo: https://lkml.org/lkml/2020/4/3/12 .

The time of a bitmap operation is definitely not an issue in my context,
but I can't speak for something like an embedded/rt case.

Thanks!
