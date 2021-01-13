Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0210C2F52E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbhAMS7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:59:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51872 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbhAMS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:59:10 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DIrE6k020026;
        Wed, 13 Jan 2021 10:58:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PSqo8hLoOz2eVRS0BVCs6SdzivtVRhVbPz4rDJaH57M=;
 b=F1vYKj1aMk+XYhVz6tOZi+ZR92IqGehh/vKGJWLcw4C7L+O9HZSzTWwMZWNNnySYsyfw
 uZ8gdAqYsNFifFq+9sYIHBomoO6XN7ouSeAX0GDQJpHmoVrrh2Wy6NP4sCEddLqaKTt2
 EzowXAiAGzb+svgmbryB2RqrYabm/WaCHA4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361fp56uk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 10:58:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 10:58:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D15BlvHw426JVehFeeedv86UiqeIw2ejKUOI5Agw2AyNlV6H3kXA044BotRwXXjN2ZcenFIaq42J/tvjaRvunGsh3s7COSyfyIo7ibpp3mhzJVFJb+FiUBzLcoNp73DxzK7PKGYXzg5eOElJwkjxChjvT2hgvbf8hmikx7obHod3MDE1Ku6divyrHWGa+fLzD17CPlzR9J2kCHjWQJBkau08dbB6BgZLhUxjXihl+Og3Ku77W+p7TOIicQ+67Kv968gZ2wZPK3Zs5kVQDix0x8KP2iNEdGaPKZWUqhPCV1neraMcOLyQ1EQRj+7h9GMvlJWz/7IZQa1mj19c9SxYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJHYJQYSMNDYFpePRT2B47/acab2I62AUHdhsd0Sano=;
 b=NdwTCdQzpiFqR2ew3pxTWG+zHhmhQTdZYAZCjCygapuYcJdh69qtweqBG+oKx8A6+O+gwIIDdNGGxRLM8QSWkRdnKo9VhWrVzcSz7hYXuVBjGSvWTX9lIY8tPvbs6LRfwAi9uALr6GFKHRAhr8MeMtnb66rYfEcpD1QpAuPSnIsD/M48r0XAcntCKXoGWooounmOM3RYlyJa9RiA33tseLugGKYCCFzGy1tRsuM0bXOdINz+wBsd5yogGAcHuroegCpYzUbJacqk9ETiiTfExwn4m1qz6UbLBiDVu6bdbKWJWE6C0IAdLc0pdA8qUSPbC36HTNB9V61MbbGL4dnXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJHYJQYSMNDYFpePRT2B47/acab2I62AUHdhsd0Sano=;
 b=HV5FotDm7H+te91C88YA18qWkwRtU7IQ/ZAEiN0eK+ErHClGpqWvqwuASiAbNpp8yzYmpmO16T8Z7RuM2PKstIWXUkC3zgY14cijsuhHfnXvH5EbYzVmRPsaMhlhtXIASOh1hdAjnWnSuoRwGBDGadj62Wq8iO/aJxFNT5yxBLQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB1998.namprd15.prod.outlook.com
 (2603:10b6:805:11::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 18:58:21 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::65cb:e5a9:2b4c:ceba]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::65cb:e5a9:2b4c:ceba%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 18:58:21 +0000
Date:   Wed, 13 Jan 2021 10:58:16 -0800
From:   Roman Gushchin <guro@fb.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: Re: [bpf]  755e5d5536: BUG:Bad_page_map_in_process
Message-ID: <20210113185816.GA359892@carbon.DHCP.thefacebook.com>
References: <20210112132751.GB30747@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112132751.GB30747@xsang-OptiPlex-9020>
X-Originating-IP: [2620:10d:c090:400::5:31a8]
X-ClientProxiedBy: MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24)
 To SN6PR1501MB4141.namprd15.prod.outlook.com (2603:10b6:805:e3::14)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:31a8) by MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Wed, 13 Jan 2021 18:58:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3afb213-7f4f-4b5f-acb0-08d8b7f5327a
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB199838929D75DCBD614952FBBEA90@SN6PR1501MB1998.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnDc2f6v3jotzrLsei38Kcdg6kbRJa65bCmogKYIPbGSfBu0sMD4JzWlMVWuE4HFCgBno2Hvq2NTmaiHLlNDs+8IwR5IGFMPG+QIAbd5aErwBri/n9bYK8Mc840OzoR/vsY/n113MdgNodCaAYJG2SWI0ZT3SSSjgTT8AAwHPU07+EFQMWUhWU1IzeDAC6wOukd4+VjfNuywYd4ZvLfU6ob0wdpQGtnFPVDyTKzfXkTc140ScKJpWrhe8sSU6C6JQQ6n5x1SXVtBXQkworFrbDZpsGJPVwouixX9PxUR1ru5eFq2WcE/QpwEp5jWp8T4jlgO4/JM4yBI092kygFbEh4qtjIe0CR5xwOAQ1n/J+l6HT2HG4aB47oqp+CiJEXH6C5lccPSseh9xH6S7GG8PixAfruJicqaONSZ3hNiRPG06Mo1h9rer6vl2RsOS27ul5wD7eg++jdmAOc+EEvT/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(55016002)(8936002)(6916009)(52116002)(4326008)(54906003)(316002)(9686003)(7696005)(83380400001)(1076003)(2906002)(16526019)(33656002)(6506007)(186003)(6666004)(8676002)(478600001)(66946007)(966005)(66476007)(86362001)(5660300002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zWMjrpyOdgkQQjBYZc+fUPLxxUOYm0WRbHo+Sp2m59+mJxzqKgcieLT8qPMb?=
 =?us-ascii?Q?RJPxe0m3G0h3vceM62OS4jfVTsoUJecA0pMXCWpnn+13oNmw8bTO40zybpV5?=
 =?us-ascii?Q?26FZQnrrs95C6Oz+5XSUZoP4Mt9Nt8fNXKfI0UUGiYHmM3XDCayYA/AH0pYn?=
 =?us-ascii?Q?Xm8mK+xItFv/KMGkQSx2RxQpn82vR3oZs2CCZ26G6DfDv/XcMP1lp3VuiuLK?=
 =?us-ascii?Q?mHeuF/+cMZQRhdpQuZTUtS7Rr5FlssyAeR3QBC+Ihc9CvR7flWu42aoT/EXk?=
 =?us-ascii?Q?sy1LWTSqPuDgmTN1XqdMztPwieUwLRk/fC3WwGjCgILE3qfdnv+Ic++tUcsX?=
 =?us-ascii?Q?P1IQpsfdgq6aqRnrEUguCvUMJwqaovthC4niS+nZ139J06JB7OC1y3RroMLc?=
 =?us-ascii?Q?QErwzNvOJMwgdxV3/C6jzsmwtpAVUrx6jpnv38H9XM24AhSBBK1dtFrwBeVh?=
 =?us-ascii?Q?oT6AfaIUemRSlBQC6tulapQapMe8PPs0up3CG5b48nIJKqjz7DPp/GLv3OoH?=
 =?us-ascii?Q?2Iuu/lOmYdS/SgGpo3dTugsZdAYstpdRUSydYSfGPkkFCXerrfoAWZ5zN6ch?=
 =?us-ascii?Q?95cHWurdITckt++xyV/mWxIiCaV/U11ijIuwMJf25doO1HzMuK6R8kWs5z/U?=
 =?us-ascii?Q?S88S9goiQn8blK4BTG4jZAAnoaoXuNo22wefbheEZmBjQojUzyIza+kh5Tfm?=
 =?us-ascii?Q?k0CT1WSL7J9Lb/pLyd8GgUYECknJ2nQVNqsJVupFUs74CZn92Qfmng8x5TKJ?=
 =?us-ascii?Q?A/bZ2soFvQZQO15lh0hVOYBdBqHipb8EXPUeOwUfCCGZbt8GEW/bE15q8iQq?=
 =?us-ascii?Q?V1z36B0rNOD6ZMCPpU+ZnOouUea9+pT/GSnBNMyMbFDdL6gCvbrGDTtyugHE?=
 =?us-ascii?Q?wWZK1V+SF+NTlVuBXD9sn/BJrkRYlObMKHkFp/qsnepZ5JaMmaGNv69rvGef?=
 =?us-ascii?Q?D7lQh3cMHMzzy0ZYDMFby8iDF6ULFlOE2WXrNW6lI9hHv7IpCm3BdG+bORMF?=
 =?us-ascii?Q?ZxopI6C3PB/uFen2G+Sb3FCeSg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 18:58:21.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: d3afb213-7f4f-4b5f-acb0-08d8b7f5327a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mSlCGYZCz5BigcLXbLHlWobkEXeQP9pIP0RXh4nEzfteQPZoyUCJWZMVo2ndSzr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1998
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_09:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:27:51PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 755e5d55367af5ff75a4db9b6cf439416878e2c7 ("bpf: Eliminate rlimit-based memory accounting for hashtab maps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: trinity-i386-4d2343bd-1_20200320
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/ 
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------------------+------------+------------+
> |                                                            | 844f157f6c | 755e5d5536 |
> +------------------------------------------------------------+------------+------------+
> | BUG:Bad_page_map_in_process                                | 0          | 9          |
> | BUG:Bad_page_state_in_process                              | 0          | 9          |
> | BUG:Bad_rss-counter_state_mm:(ptrval)type:MM_FILEPAGES_val | 0          | 1          |
> | BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val        | 0          | 8          |
> | WARNING:at_mm/vmalloc.c:#vmap_pte_range                    | 0          | 3          |
> | EIP:vmap_pte_range                                         | 0          | 3          |
> | BUG:unable_to_handle_page_fault_for_address                | 0          | 1          |
> | Oops:#[##]                                                 | 0          | 1          |
> | EIP:free_percpu                                            | 0          | 1          |
> | EIP:__rb_reserve_next                                      | 0          | 1          |
> | WARNING:at_mm/percpu-vm.c:#__pcpu_balance_workfn           | 0          | 1          |
> | EIP:__pcpu_balance_workfn                                  | 0          | 1          |
> | WARNING:at_mm/vmalloc.c:#unmap_kernel_range_noflush        | 0          | 1          |
> | EIP:unmap_kernel_range_noflush                             | 0          | 1          |
> +------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

I've tried to reproduce the problem on two different machines running the test case many times,
but haven't succeed yet. I wonder though, if it's the same problem as described and fixed by
commit e1868b9e36d0 ("bpf: Avoid overflows involving hash elem_size").

Thanks!
