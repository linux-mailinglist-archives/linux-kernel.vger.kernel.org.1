Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E94295680
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895200AbgJVCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 22:46:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895194AbgJVCqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:46:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 09M2R60C023944;
        Wed, 21 Oct 2020 19:45:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5ukFwDvFdXTj7aCZiCkktD4MDly04k2UAmKYLOnYoe0=;
 b=HmitFtan1M7WnzfboHLNootB3xJyzqeewolL+Uwj0N/RoXlfXyKyeq6TU68GasoN3/Zs
 iRYNj72c4UDK4C0j09Hj++i4IyN6u5iAxhEE2zB0SYpOeKVe3GbeUIsojMEYvuAMjRoE
 MwbLTJprEClbN9PKBT8uX1M8DUIwy4ZqN84= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34a41mrv8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Oct 2020 19:45:47 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 21 Oct 2020 19:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQmIScivOSJa6TbgD7qH8d9HarHIs0sDJTgaqgei28BAYDBSiM4liGwSfxjIMUYf1uz28giPMNJu48zglUadBACQr1s6Ob0Se+Pp/JU0nR6ap29tBIIzo/CtAWA6bNcZmS/sW7DYi3VCCrDrrU1IHaxJoS7PPlO4TApWbwFepbdtwVTN841w0bLLXAAyKROkl6OnipKZcifqcwiukRyzBzcSDlSXLi0b64WQ7njgFYV3iOscSwWDLz463s3iL8YfDj28uDxBUOSqFbk+7lGf52rV3WHp32MqmnNfm4A4L2UmCHHyzEC4LSu4urcvvYDskKOtwuU6SLf3moOsaNRVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ukFwDvFdXTj7aCZiCkktD4MDly04k2UAmKYLOnYoe0=;
 b=huiRXNQ9b+3HrX/GMJyjLUmkw7t5/BZweRKhQZsArEAyOoiJNrDFUZ/rhBsfJbDKnfyQ+VQ9dgVS/bIWga1BLeXzZ/dKGQNjF08uQwyvTMuZndcAcUfNyCPQo+gOHZUPdEx3mmRTqnlpBD1Ztsjy/4dQ3O7YiTwKPEo9WdOPWkLx9sgBt+8HUCTucDu3EbU/B83IwH+GBIK93zgo5BQwe4HYLJX4t2lsymvikvQr2tSD223pAkPY468MrzunsXcndi0yhOAgr3WC17tn8CkD1fyC+4w3Z0/KQO2GcFt9q5UqM9ptZh43ZWi7Pri78IrW3E3alnJEJZVjDQ3LKd6F4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ukFwDvFdXTj7aCZiCkktD4MDly04k2UAmKYLOnYoe0=;
 b=EaUWYUzh5LhHU77CYRSXol1XncJpol3a1+xvWTpfO1x3i8qYGi3zYaBC0MAPY4BblcQX/MuWshi5f32ZwMaR9jiQtExsbwjaInxVe5tOu+u2qCWfgp4/jyjRUjjf+fuBlvtsgOOA9BiAk/mxgITjrDpVfgeK2AzzIHkxSrzFuoM=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2807.namprd15.prod.outlook.com (2603:10b6:a03:15a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 02:45:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 02:45:31 +0000
Date:   Wed, 21 Oct 2020 19:45:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Xiaqing (A)" <saberlily.xia@hisilicon.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
Message-ID: <20201022024526.GD300658@carbon.dhcp.thefacebook.com>
References: <20201016225254.3853109-1-guro@fb.com>
 <a94644b5-5867-0518-34e9-30fa6c510f81@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94644b5-5867-0518-34e9-30fa6c510f81@hisilicon.com>
X-Originating-IP: [2620:10d:c090:400::4:4b52]
X-ClientProxiedBy: MWHPR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:300:39::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:4b52) by MWHPR18CA0055.namprd18.prod.outlook.com (2603:10b6:300:39::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24 via Frontend Transport; Thu, 22 Oct 2020 02:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e325f6-dbfb-4051-8cff-08d876348aeb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2807C59938CAE36DDD75B250BE1D0@BYAPR15MB2807.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JJzNY1x7EyTljHPiKWpf6LHklq3ouFv15PchSUdQFn6pLWzdxmYDYsgLcYa7mmvwVQigW2Hri5uEvOWekOAZ3W9Pwo8O5u98T5E7xIqJvp8wF4wlPnJJiROsTNw9jOLzBz+2vVpfywwxhZoOcRDDk2xan2zy6pOTdW3RZGGNh/jAwoSh3zG+sn4aijX+MOFUjULw31+1wd06aNdYEvc83xB5dPOAkE7lN8PHDQ1dIZUja7ikhzpLG9WPHZzC3U9WAVo6gg8kQf8I6yRjUMD+xvDGMK/9LuuTBid2I5yNX5Mv9Zt3Vz7CfkAtRUP3fD7ofCXa19B4xrxlpwoy5XXiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(396003)(136003)(54906003)(316002)(186003)(6506007)(66556008)(66476007)(66946007)(53546011)(6916009)(86362001)(9686003)(4326008)(16526019)(7696005)(5660300002)(52116002)(55016002)(83380400001)(6666004)(2906002)(478600001)(8676002)(1076003)(8936002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Mbdgs+zsH2PSKRT/GLLAk9jC8cgkUkrRiEmllikJa3W/RhLgplZJZAo7n3hZmy00eFUz5iJOZX4M4IQ/679UZmHHwJMfla4jf6eHBwwbx6DZoUELfrvom7CCZ8ZQXQH8DeWEsnFJQFVuzMUmYmfj3zGBecpdP6vazRiTPBgy7+Vqk/0WO6aXzQT4vwPH63kqcZl72Dz21ojSN5H8Z9Uu4rXIDgmW2Sm0FVz9A21sWvOVn7+IVQFLGRlaRypL4CCdIm0lBuvsm6zUaMosrceykiE2bUEjYYveW73UXWeFwW9qADXro77X301LAUIrCBU4T1mFMtz37VxRdKaX10hQYDl+N8tP81S25/RH7HPiWTh3sXCZePNua7vSkYiVUPyXPkjgHrCJJA8ju48VrddsQQKkHEYOjX99gFqLXnAxr1Lq9yHjH8xy0mvh+Dvb5Gdav4rErbj0Fly4+xIo3oZquXZ0xh3PxEX2mRN+SIfNG+5DLJcKQtfuvNS/KdEpMCJxoRa42QYCOeJInb7FSqdV236PR0PVst2zhSryT7sDTdzFJzL3XHsmJtU3BcPJgcF1VE1v1Ja7GDHXtUSb9DPCogao0HVDcRjNV2V6fqNH/F6lu9UMEla5zUbRU/lkA1rsUyE0a8apIQln/yu6HwpvZ+/v/31/IGBhxo3pWoNL8Rw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e325f6-dbfb-4051-8cff-08d876348aeb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 02:45:31.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR++40+zSvdy7kEeaQYyr8E2EPN5dofK9mGqKSOFQ2oT2xU5Lq2Eknn2nQHvJ9j8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_01:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=2 adultscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:54:53AM +0800, Xiaqing (A) wrote:
> 
> 
> On 2020/10/17 6:52, Roman Gushchin wrote:
> 
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
> > 
> > 
> > Roman Gushchin (2):
> >    mm: cma: make cma_release() non-blocking
> >    mm: hugetlb: don't drop hugetlb_lock around cma_release() call
> > 
> >   mm/cma.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
> >   mm/hugetlb.c |  6 ------
> >   2 files changed, 49 insertions(+), 8 deletions(-)
> > 
> I don't think this patch is a good idea.It transfers part or even all of the time of
> cma_release to cma_alloc, which is more concerned by performance indicators.

I'm not quite sure: if cma_alloc() is racing with cma_release(), cma_alloc() will
wait for the cma_lock mutex anyway. So we don't really transfer anything to cma_alloc().

> On Android phones, CPU resource competition is intense in many scenarios,
> As a result, kernel threads and workers can be scheduled only after some ticks or more.
> In this case, the performance of cma_alloc will deteriorate significantly,
> which is not good news for many services on Android.

Ok, I agree, if the cpu is heavily loaded, it might affect the total execution time.

If we aren't going into the mutex->spinlock conversion direction (as Mike suggested),
we can address the performance concerns by introducing a cma_release_nowait() function,
so that the default cma_release() would work in the old way.
cma_release_nowait() can set an atomic flag on a cma area, which will cause following
cma_alloc()'s to flush the release queue. In this case there will be no performance
penalty unless somebody is using cma_release_nowait().
Will it work for you?

Thank you!
