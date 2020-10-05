Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D27283D30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgJERR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:17:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44478 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgJERR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:17:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095HGvgj019407;
        Mon, 5 Oct 2020 10:17:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=cKZ9+2uiIz/IhrPcGSamkohTa5LBuZH9bxzOfQU5n4I=;
 b=nL8a2UJ4aGl0/l1poaOrnJhTPioQmqT1W0iFGgy3ZdDUlity/t2q+hV3mfKombq0H6NL
 ri++rxLIIXGbidjdvnUa/Hw7LOsaRNuQ80JNMdplc3CLK5rU1ogektsLXPO/u4yD8JA2
 0eZYSVwhfVCAOgAP6t/7oZoCa374nLPnHPg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33y8t9nnqp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Oct 2020 10:17:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 10:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JihrO/nbu4SRjNwLbf+rKV7/Bjm0ecF1ss7DXvpLSQ/LbGzt0cAicxfD9OAYsk+pw5E0PNMwmeYACUPnctyeZlod6yDfPzCEVdDMpae63eIkaxQ2G/smdL/SnyhkzBKPCHE6vmyxFJZVV/TSRZ0gd1xuzUqV2EPTSJwU/jIxOSeBJr9tMHGN6ALT5BRJXCiBUQn0rDh89aeemU8WJV74GataiVK24zjIqoECVE7StpiLrpK/Z2+g2cal2UeiI7iBgw+oYpUtXIeIGVF9kl6KO0JILuf11ep4PQXyf+SnSm1GlH988xs5i1hDpMx+YrOV+6LhBUKTd+hsEfBAlY8f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKZ9+2uiIz/IhrPcGSamkohTa5LBuZH9bxzOfQU5n4I=;
 b=aOg2wMKdPoEqmoVmUm/Bgpnotsb8zGiB1ZYzemLWmk0FjFJbX4GpQQq5wsA3RvkT76WjCAJy91HY5uK18kiylRaPMO3qd22xk7a0CsH08AZyGvaxgZsUj2Ru7IgADmCZBjo2dTcLIgQGuwhq2AeiKGyaZ+cmtJUuHwEZ7jVXAYEKFX6J+/f0UtaRHheHcoIxksrUPqeiYxgJ8APMAGlW40is0RmUM78YSExM8g150lKatXbZRMfvD8rSnqJHGB5hrp10n7su+3yNMIRLtstrZKwJkkF9rUc5i/de16AVWJ2oE5biuJ+185mLwYkimmUnVg3/fCveJwuazVj33k2JXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKZ9+2uiIz/IhrPcGSamkohTa5LBuZH9bxzOfQU5n4I=;
 b=MWtm7yZa/yO936jTsVp2vI1R4Ujpu1WVBZI7KknMpX3xO0ZfjFD4XmY7itfuUkahLkg/RRERrEjm67Rdbdt7Z5X/NKUrFb1NHMSkG20GtH/DuCLftUabqgIoBoMvVLavIZF2LLU5rm47Co7HXF7W8f2ZQ+mhsqgWrONIEKypBcI=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2400.namprd15.prod.outlook.com
 (2603:10b6:805:24::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Mon, 5 Oct
 2020 17:16:38 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 17:16:38 +0000
Date:   Mon, 5 Oct 2020 10:16:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20201005171632.GB2990415@carbon.DHCP.thefacebook.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
X-Originating-IP: [2620:10d:c090:400::5:e6f7]
X-ClientProxiedBy: MWHPR10CA0059.namprd10.prod.outlook.com
 (2603:10b6:300:2c::21) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:e6f7) by MWHPR10CA0059.namprd10.prod.outlook.com (2603:10b6:300:2c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 5 Oct 2020 17:16:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bb7303-2cd1-46b9-13d0-08d869526b88
X-MS-TrafficTypeDiagnostic: SN6PR15MB2400:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2400099F8F7CA830CAADBAE5BE0C0@SN6PR15MB2400.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs9UVNrix84fBZvgORW+6BjqinJMC+R96sXkoaB+Clnlxs2TJlW8MBfXWuAQussouS0f7N0674RNh1j4yGUqeyCkul6XGHZk612cgxxkpDDzzv2X4gEYKa1OgqzhlJdGBv16TFA+sgudfP4rfVxDC1QYOJCvIWDaa0elpZTInqWXjKRJtVetMqN7MpyWc/G3wgyYA4MLXDUF54xDwX3YIlC3cmLsmmG0iIXcuOr/iAm7NXN50K4W6kuMLAfkxbYggUISbIutdAWhGxoixvHq73yqWwUCsKIN16IPkQYaHCeJFNrx2BmQ6cIC56D7JlmUOt+xlEbLLNJAqFWaSrWBbpv/9oShpN84NPzyRbCzxhsnSsRASaMx5eUOCih5kvFaqLUQIeHtC21GeSKiz1NU/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(83080400001)(966005)(83380400001)(55016002)(66946007)(52116002)(186003)(4326008)(7696005)(16526019)(6916009)(478600001)(2906002)(53546011)(6506007)(316002)(33656002)(5660300002)(6666004)(8676002)(1076003)(66476007)(66556008)(54906003)(8936002)(86362001)(9686003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: noylwfaJ740k9n3e7hunHKfKKz3XVQuBoVsF0I+1DKtCqDxGUrcsmVMqd69WjpVPtpUiBN0MPrD1oMH4ZO/pqtI89wrc3y0ViUBV6Dc+z2ezR9KIuOvfkWE/7Kd/YOvSKEfZX0K4Tt4HWpBXifRU+9hQOYs5H8l+331NXvvQJwO+2rEHy8WMOGOnGx0vQR+UxnumoBF6V6nDEzjUC/+nx4WQL2Xn40QlGTH3mlJqDpmGTBMEKZkgGmbhviYD6Xa8YpfWrt97o673iOrdA4GMJF4ZRkABtOV3EChb4w08JOk383Cxq26QP/IQJTjd0qqftUsafm8yHiJu62IKjZQLiB3+t5jVQ0Y/PNmCT6xk36K8hq8t3Rnczgg1OSQ3OZhaT4MrmtOHz/7Q+cfmoVC4ExVV0CxgyrG9YnkI1QlAa91VUasiyZF+KxzApW9OtK3RoYPph1jQLski6HbNFl3Lz2HmtD2VXi+LG9feu1JDbS2dhfRKNpN3RYHrtSZrqGhWAOes3CvQfq87nFBtwwDpT0JS9Zeclf14P3MJrH7BElAVsW0C0OV+neHIzCiDaKoL4TQewMhSH+MjtLL5Ko4QXT8CUmLyH1HseImUmV/4WiAmmyvso58hKxIcQRpnN/ItVal5kZfOXqnB0OuFDVCVXFYm1XymFRW1uRV7B8BAtN4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb7303-2cd1-46b9-13d0-08d869526b88
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 17:16:38.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtglNM1bI3kgZMFfNZINoO1GItF6wTF0DEppiZZH16ROSTGGgYzlVe56+5FkR2Vg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2400
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_12:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=888 bulkscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
> 
> > On 02.10.20 10:10, Michal Hocko wrote:
> >> On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
> >>>>>> - huge page sizes controllable by the userspace?
> >>>>>
> >>>>> It might be good to allow advanced users to choose the page sizes, so they
> >>>>> have better control of their applications.
> >>>>
> >>>> Could you elaborate more? Those advanced users can use hugetlb, right?
> >>>> They get a very good control over page size and pool preallocation etc.
> >>>> So they can get what they need - assuming there is enough memory.
> >>>>
> >>>
> >>> I am still not convinced that 1G THP (TGP :) ) are really what we want
> >>> to support. I can understand that there are some use cases that might
> >>> benefit from it, especially:
> >>
> >> Well, I would say that internal support for larger huge pages (e.g. 1GB)
> >> that can transparently split under memory pressure is a useful
> >> funtionality. I cannot really judge how complex that would be
> >
> > Right, but that's then something different than serving (scarce,
> > unmovable) gigantic pages from CMA / reserved hugetlbfs pool. Nothing
> > wrong about *real* THP support, meaning, e.g., grouping consecutive
> > pages and converting them back and forth on demand. (E.g., 1GB ->
> > multiple 2MB -> multiple single pages), for example, when having to
> > migrate such a gigantic page. But that's very different from our
> > existing gigantic page code as far as I can tell.
> 
> Serving 1GB PUD THPs from CMA is a compromise, since we do not want to
> bump MAX_ORDER to 20 to enable 1GB page allocation in buddy allocator,
> which needs section size increase. In addition, unmoveable pages cannot
> be allocated in CMA, so allocating 1GB pages has much higher chance from
> it than from ZONE_NORMAL.

s/higher chances/non-zero chances

Currently we have nothing that prevents the fragmentation of the memory
with unmovable pages on the 1GB scale. It means that in a common case
it's highly unlikely to find a continuous GB without any unmovable page.
As now CMA seems to be the only working option.

However it seems there are other use cases for the allocation of continuous
1GB pages: e.g. secretfd ( https://lwn.net/Articles/831628/ ), where using
1GB pages can reduce the fragmentation of the direct mapping.

So I wonder if we need a new mechanism to avoid fragmentation on 1GB/PUD scale.
E.g. something like a second level of pageblocks. That would allow to group
all unmovable memory in few 1GB blocks and have more 1GB regions available for
gigantic THPs and other use cases. I'm looking now into how it can be done.
If anybody has any ideas here, I'll appreciate a lot.

Thanks!
