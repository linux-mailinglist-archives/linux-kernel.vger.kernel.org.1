Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB02E728A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL2ROl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:14:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44898 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgL2ROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:14:40 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTH8OTc010569;
        Tue, 29 Dec 2020 09:13:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ooqZiLA8COB8SqxRFXsYsYyqB9p8rvCz7Mm2FDyAB14=;
 b=XEJD+EMf4xpIzGfE/PT11n8a9JLwqszVkKxGAqwwBxMZdBtYjG6T36HOH2FJYIt7kzBr
 ospO62/PUgt+cTt8vGLeWncZiAPAFal2/UG3K9e0qxYC8KBERCmmrMXq1c0RLzf5vqIQ
 gjRKEgPnM52gMqy+to9QFoCfiFSBu4TBwE8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35qykrsr3w-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 09:13:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 09:13:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN/EEeHEHFQsarZyozzjX1LBdKrHMl9wScSOPJdv03yB/6T/z1tisvLgNA7S+xjPIq4Qt4I+1gVmtsdedphaAkGoz8T/VsSrB4IZeZiOnYasM+LlTjp4lv6U05Mb/7xMdA3fclSll5I8DacX21ykjNi9TewPri4WpIKL6y37hhJkEc4MZjLAR83AFFEKPKCUuJbGqaLFRxk51KpiVM9BiFJYvnYpjQDL2sYI/JEJD8aXZNoZT/WFuh0eaj0cxHHYOoBBGMH7bQ3aIrvJoRDD2zUqg9ROMbRk6DGTK4gNGuHPe4GyWUUJUQyywzu8ZroQNtRQwLtFbQwtVW7zB+Sh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooqZiLA8COB8SqxRFXsYsYyqB9p8rvCz7Mm2FDyAB14=;
 b=Zjfkx2wPupal/03/Ww14ZoFgWpsKb7HNWTeD+TFd6Cas9cgl6cx3vyveXygSnu/7l/7B5/eWDhGMxlFe2s8E/tkmkE+AZRHiFwJDO02gjgTDUHfR+v1Cbj+LNZr+GoJABO8EKr92okRBh0tuiatkEL6YghvmHG+SIEBefE9r8fsIMDQt3Rc7/S2y7nP2XKGN91KuAkhuFtYOQy3vADtk+LqYMaxoF+nux+wil4YQrHI7d8UQc4iC/nUWBlXcJ2V8UaNokTVQijm/apu0nplwbhzI+UOJKuWPu+y0vhIvY2CUBOrDGpQkFLanMBsVTJsh5/ZSwuVkqJ8Z0sloswzosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooqZiLA8COB8SqxRFXsYsYyqB9p8rvCz7Mm2FDyAB14=;
 b=adN61b6EzxVIP68kif3MDABcwclShuM8AdO2drwGFOYol1LIOa4xR7mmhTWpKHsgsTWst4F/LXXn7EwdeH8La3a0f0t/sakzZJ34Ty2L+wvlIUNA4PwjjABOM2LzZZxG1KXHhDbF9ueNniXfO6/vkUrJ61JRwIhy5cHFT/r279s=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3397.namprd15.prod.outlook.com (2603:10b6:a03:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 17:13:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::ed8c:29c3:6ebf:3e66%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 17:13:32 +0000
Date:   Tue, 29 Dec 2020 09:13:27 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <andi.kleen@intel.com>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <ying.huang@intel.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <20201229171327.GB371241@carbon.dhcp.thefacebook.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609252514-27795-2-git-send-email-feng.tang@intel.com>
X-Originating-IP: [2620:10d:c090:400::5:56f5]
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:56f5) by MW4PR04CA0149.namprd04.prod.outlook.com (2603:10b6:303:84::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Tue, 29 Dec 2020 17:13:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acfc90cb-aea0-4b4b-4e9c-08d8ac1d11ee
X-MS-TrafficTypeDiagnostic: BYAPR15MB3397:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3397ECDBE467A2ED0162BA47BED80@BYAPR15MB3397.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOT13hgxuxTFw2GkWqoF0a+gzoqtOKugj81GfIyH2L4/jMIDswu5A0aF7pV7C0aCQ5nKeKMkOJqN1SObORmmWLCTKDJKlllKB93Ht4vX+FsDZGKL6cmq5IH+WQ1OeAJh+4dMcY7oQrDb4UEMAUgBNKgBUfR1iS+GLkYjJx7J1oLdXJpwpyD/pixYmCy0F+o63Rx+14fV8nsZ0zUN3K3SeyYNFTYr3v3wzAstSCNw1gWELGYD4Hk7VntLADoa+O40TpXlnQT+huMyKP+oPyEdI1UEgg6zFMxNbyys2JWGrWRzfzpoAa8dQFU3NKQLIFcn49CSyb8c2X1i71rRIQXC9dsUmQ4c362XRVytghpuoz/WUwxIBXG6Dz+6rrl4hJ1dui8mCCFbV4rdTOSJYfYGTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(39860400002)(366004)(5660300002)(1076003)(8936002)(7416002)(9686003)(55016002)(478600001)(2906002)(33656002)(4326008)(6916009)(54906003)(83380400001)(316002)(52116002)(8676002)(6666004)(7696005)(66946007)(186003)(66476007)(66556008)(16526019)(86362001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qx/xeKqgiQ0AGbSASmSSFhvU8hiBeuK+kLwWcWJVgFZKwy9v6aT5uI4hzW+w?=
 =?us-ascii?Q?xAWST39OVnCuhBaAyO2P9hZNBEeUO/77p67mMSTiWlYaM9IDqECBExdQHWSo?=
 =?us-ascii?Q?7FBToeTbIHnFcvvbnKVq8oS/FD29NrxjIMdKvFZLSd1IqUbCsfJf88iXKbWP?=
 =?us-ascii?Q?k97RPLI7Sdz+9LFmx8k4ZEScdayvAAaacAMuWAgpdAiMAMyl6C4zLvAvt9o3?=
 =?us-ascii?Q?8SGp7jx0zldsyfAYnN7apasLeBkIbd22be8zksjXAySnQ1+wvWnEwWZWA5KV?=
 =?us-ascii?Q?xE7H1PXb6l51nFVS+ehR89VfKy1iPEi8meNyhHfABFjfeSQGmW5XURzvyqZc?=
 =?us-ascii?Q?+KGG8pwp+FOYaGYHyZHIq2rFJunoKxDNGR7AXIP+rfuainTFr1jRhE7QciH1?=
 =?us-ascii?Q?SeoGfdS0uB/uziw3kbFNWmJIT+D7vAB6+ZdCX/gQ7LhRt+GzD++V9hsLPfIG?=
 =?us-ascii?Q?CIXULfGpdxNpvhSzxKIvJWgv/l63ZCzU09EwdyafkfVu9v8vE1XjA/5h/1zf?=
 =?us-ascii?Q?pcnM4ZDvN2cVnoEC87PftLTpYstwMZva34kIQw7WeM7H42u/iwgzljqCdAVf?=
 =?us-ascii?Q?rPuRitCXiXG/pPi9M4djT17pQGUA9qkce83BgMKhDTnH62LIQzWr43ZQZKP5?=
 =?us-ascii?Q?HsRLWWPL2JMz9sEI8IFCWes6kZV4vwg8EwZmTRFTAYiu+V0ucsnrHmMOP6Tx?=
 =?us-ascii?Q?zNaVFubbSEynUR9KfWhaJAB2LVQMH++dZg/jUPDiRY7w2DExW5RY+vI8Qzn4?=
 =?us-ascii?Q?vXgYmcbvG/Esz/tZSEaNSAp0R2225DVn6/b87963qy0eXzGzDhL77jLNT5Ly?=
 =?us-ascii?Q?MV6Z7RfJr27x7SvC0fNdzZD0kM47mZCQUOW99r0nAKD5YgH63/HYYPKY1dD/?=
 =?us-ascii?Q?DfggVXD43PJrGtupG+JCqA3YskaL1uOwTH0CXMpeLJ9j0rARZ9B6Wgy33k+O?=
 =?us-ascii?Q?HTV/8eZltLcS2u97zp2MVaSWQIGp1xZALe+2bSmIdWe5OLbHPM7X9qbxWIiL?=
 =?us-ascii?Q?VpK3rSC7Tey8Q6T/WLG8wxAkSA=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 17:13:32.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc90cb-aea0-4b4b-4e9c-08d8ac1d11ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCNOkZkWvH9F6VPYo59noD8UHEXFQ7yr5iOmpM/AW2JNvnKGnOiP0/v8noxPbvs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:35:14PM +0800, Feng Tang wrote:
> When profiling memory cgroup involved benchmarking, status update
> sometimes take quite some CPU cycles. Current MEMCG_CHARGE_BATCH
> is used for both charging and statistics/events updating, and is
> set to 32, which may be good for accuracy of memcg charging, but
> too small for stats update which causes concurrent access to global
> stats data instead of per-cpu ones.
> 
> So handle them differently, by adding a new bigger batch number
> for stats updating, while keeping the value for charging (though
> comments in memcontrol.h suggests to consider a bigger value too)
> 
> The new batch is set to 512, which considers 2MB huge pages (512
> pages), as the check logic mostly is:
> 
>     if (x > BATCH), then skip updating global data
> 
> so it will save 50% global data updating for 2MB pages
> 
> Following are some performance data with the patch, against
> v5.11-rc1, on several generations of Xeon platforms. Each category
> below has several subcases run on different platform, and only the
> worst and best scores are listed:
> 
> fio:				 +2.0% ~  +6.8%
> will-it-scale/malloc:		 -0.9% ~  +6.2%
> will-it-scale/page_fault1:	 no change
> will-it-scale/page_fault2:	+13.7% ~ +26.2%

I wonder if there are any wins noticeable in the real world?
Lowering the accuracy of statistics makes harder to interpret it,
so it should be very well justified.

512 * nr_cpus is a large number.

> 
> One thought is it could be dynamically calculated according to
> memcg limit and number of CPUs, and another is to add a periodic
> syncing of the data for accuracy reason similar to vmstat, as
> suggested by Ying.

It sounds good to me, but it's quite tricky to implement properly,
given that thee number of cgroups can be really big. It makes the
traversing of the whole cgroup tree and syncing stats quite expensive,
so it will not be easy to find a good balance.

Thanks!
