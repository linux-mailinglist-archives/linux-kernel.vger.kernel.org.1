Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2582C8FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgK3VLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:11:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgK3VLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:11:47 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUKxQGB002776;
        Mon, 30 Nov 2020 13:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Iucvid06T1CCFBeFuAyShheoNzUv5K4Y4dvAs71I1PI=;
 b=gMvJjN8V0WPeOo88cAMLxRfbn/WvjWdm3KsrH0i7wIkPSu27+oWxwH2toS+V3GiY2wAQ
 7SH9C16ueiwjgiMRZ6Vi7Y6E21uTfivkgouIIB9YYpGxxVCVD6LiMRShEAc/DsWgbuhq
 P6T/LwOc8uchqzUXuA72uDHfM8ig4g77AP4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3542bng1ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 13:10:58 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 13:10:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNyg2MsXOj9MWJA3BbNputKf4jSeWiuNGcrETKSNt2IKJbMCXGJW9YoGb+y+h8uNVSeaa62chzIge99k4ndIpM8v/TEUg81yVD6NcF9YztPBTxMXoEvhBPUcIs4rgFNAKiPTvSq9aODCEyyzCLHSnwVPiYEZ0OTFyMj9EmGbHGdDRAurTAXR4sy35BYKciCS6oVAC0EXocT7DVcoLWJlTf+wGo4+c0oCcGDxhcJK/jC2AMh34qiQaLBXoSBHNCiHtVBWOjyit/+Frrh/mzZhg60YlmpDUMSWkJ7JwUMRTriumzohZ0pccreWANyIWSG7DryjHb58028SJqC9DW5O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iucvid06T1CCFBeFuAyShheoNzUv5K4Y4dvAs71I1PI=;
 b=AfgyXw8+sJntMmUjm+UZt5PsTwA0wb2gKlDgqADQXdYDCQ1QSsaPVFuB4b14godUJmxsMMJKQitJ9921+fec3rkzKz7iYHnzcQY3YvGRCsUQ0qJIR6pd8+A6FUuIitPdkxTp3Ci4sKfsJ4sf22eLMx6EJRVMbNJ4EtFReEzetVW9eKGbsjNxdTm//+6tgJBcLyp42cPmh+ZzaKnOVFG7peH6s7UFkH888XOho3VnxN7og+nROfTzK5jHITbLh2/bE8LH+4Ucoa0NQr2BONVgPP42ZmF/nmCpDhL5ibN0c5/vdj6rhFeM/PmX1Rzy3/S7RJaFyqdwT+1P+VMLvbRNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iucvid06T1CCFBeFuAyShheoNzUv5K4Y4dvAs71I1PI=;
 b=Dnuo7YGa85QASa58d1340CC9kMcc94EzVNXmZON+FED5os7hQj01k2llGl8m8I5qD8efa2pxMCnudoJNSrb4oBQExpYYoYBgbIa78EI7ecdONwBfmwW3gYfyB5YGEjIG+M8m0A9ipxlGMs8evPd2+aZtOeOVYB8t5CdSBhyMcgU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 21:10:55 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 21:10:55 +0000
Date:   Mon, 30 Nov 2020 13:10:50 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] memcg: add pagetable comsumption to memory.stat
Message-ID: <20201130211050.GB1360286@carbon.DHCP.thefacebook.com>
References: <20201126005603.1293012-1-shakeelb@google.com>
 <20201130203425.GA1360286@carbon.DHCP.thefacebook.com>
 <CALvZod4qiFuiByjh0+fwRoVw_EYVzqADNsiThf42-zDiXyYvpg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4qiFuiByjh0+fwRoVw_EYVzqADNsiThf42-zDiXyYvpg@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:3d22]
X-ClientProxiedBy: MW4PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:303:114::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:3d22) by MW4PR03CA0388.namprd03.prod.outlook.com (2603:10b6:303:114::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Mon, 30 Nov 2020 21:10:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669b579b-4a9b-402d-7b2e-08d895746ce8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB221473D448B911C1035C5D25BEF50@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YALKt/q7zCt4GIXiW4ZxA8Z86tdAwllZJou5h2/Gvhkgg+EJ/70X1OYOUhtxo9KVLupgUyV0E15vj1Y9t8uAPnWwwe+PY31obQLWtlIg/QJClxqT2bgwp/pZ7s5YQnOJBnXojm3jVDZ+95rMtS2F7UG4B32I/TmJV1DLPitYQo5EUfGK2777tt6ZveoPqTPeMZ+AaycwsZy4zwPZ71TtnLWQQ7MptYsspyvh7ZiWSHd3gzxFaaafmd1h7Bdab1jsCCaWjVfFHsqtdksfllQVCiij/WKvwFRGhNYjBqHCtZcuK8k+SsdFieezQeUARwHHiWbgh5g9BTy5lCZy44qBwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(83380400001)(53546011)(6506007)(33656002)(5660300002)(86362001)(7696005)(2906002)(6666004)(316002)(6916009)(186003)(9686003)(16526019)(8676002)(4326008)(55016002)(1076003)(8936002)(52116002)(54906003)(66946007)(478600001)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/LgMglsILMoDddMIcRaeZLuhgEc1OlX50EyV31qwq8JPa265LTzHdAaxYO0v?=
 =?us-ascii?Q?AmXnU51Sc2u8l5KTPyMzjWri7Y7fk1AtzQUp3ad5Pe6VA0ewB+4v/Fq1ZAV9?=
 =?us-ascii?Q?5lkPAkw/dmPUbtgkZMRhZ2Q0N24Dk0MerHFrNt32Y3/n0APcUJ3GXcTF7gat?=
 =?us-ascii?Q?g6+XzIINa6Ydyac+pwJ/uh7Iqocu843CQ23KC2aG2ll2E1CqqYh9iSWffPo4?=
 =?us-ascii?Q?VuDvpLJaQafvxhMRuh6p2jT9uvCf/qGvjCSz990TjpCkkDSlvewAXsA4/ud9?=
 =?us-ascii?Q?+vSTbRR3PiMzJnVoYdeLM1PF6EeHTTSENmUeNGQ1VdTrcwgEYSF8zL1Rn7Cm?=
 =?us-ascii?Q?lx8aHhPkPQjTfHD4QohCvGrNRqsCWzPXyRvxeafCBGlGKvnfbatqE6z/jpk6?=
 =?us-ascii?Q?HiFVhVwbAKb9l4KYD/FY9HKr+WSn/xK+gfW3QNK6ukY+Gv/aRcHNaXK71B5d?=
 =?us-ascii?Q?Nh1J6u5vNigWic1BRzh/8nSWShHrLswoErRljXfapPmLc8O3AN8N42IXhiSR?=
 =?us-ascii?Q?xfN2TSp3S5c1yl+yUn1CDweCT2voOsj59Lw3YWV5bJyAepyl+nlcV9IWdpXy?=
 =?us-ascii?Q?OjDL8A6tcfMpw39g5aopPbN9+SGaJpR1j5pWRczGSYXnwGuPN+ByqHhjF9Gp?=
 =?us-ascii?Q?xvxdSazFWayGn8sPCn9MOv4IKz8QtcorRQZ08qADLPZyVdPIZdJMd5+FTmmh?=
 =?us-ascii?Q?eOb0J6/QcxcP+jyPYq0oCQMzzObH/hvz0mAAvmqTkskzr2IykKQwPhbtG2Zm?=
 =?us-ascii?Q?8KJytbJkQ6C3aweBOmEJNZRAk2TFoWTDYivhRhDTjUIFRs6rdg/dqCEuKPX/?=
 =?us-ascii?Q?cGYhmfiNaOME3qPbMy1DKeC1mclGrhNUJzz0l2+l60OfbkF5gkTR8kSFSLac?=
 =?us-ascii?Q?VdtTVqZ9Jo2sLn7y4B9/Vi0QQz2zIDv9qGc/EssuCH+hrO3GULfBhbuzNmWW?=
 =?us-ascii?Q?3r/phWbVorZ/K0ygdHU/j0w+3nBHQRmOgfz+ay29mXoMiWsFWhuTg42NjwAM?=
 =?us-ascii?Q?DYOwhO8JrATq7fMR5exeqY3Wcg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 669b579b-4a9b-402d-7b2e-08d895746ce8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 21:10:55.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNq64a4odBb9OrQWJRnS92YSpc4lwQqdF53k4VS5TpUsJEOx35V5beOYdfCDGfYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_11:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=1
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:01:18PM -0800, Shakeel Butt wrote:
> On Mon, Nov 30, 2020 at 12:34 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Nov 25, 2020 at 04:56:01PM -0800, Shakeel Butt wrote:
> > > Many workloads consumes significant amount of memory in pagetables. This
> > > patch series exposes the pagetable comsumption for each memory cgroup.
> >
> > Hi Shakeel!
> >
> > The code looks good to me. However I'm not sure I understand what's the
> > use case for the new statistics? Can you, please, elaborate a bit more here?
> >
> > From a very first glance, the size of pagetables should be _roughly_ equal
> > to the size_of(pte)/PAGE_SIZE*(size of a cgroup) and should not exceed 1%
> > of the cgroup size. So for all but very large cgroups the value will be
> > in the noise of per-cpu counters. Perhaps I'm missing some important cases?
> >
> 
> I think this is in general a good metric to have but one specific
> use-case we have is the user space network driver which mmaps the
> memory of the applications for zero copy data transfers. This driver
> can consume a large amount of memory in page tables. So, this metric
> becomes really useful here.

Got it, thank you for the explanation!
Would you mind to add this text to the cover letter as an example?

Acked-by: Roman Gushchin <guro@fb.com>
for the series.

Thanks!
