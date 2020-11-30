Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571D2C86F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgK3OkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:40:25 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:39264
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgK3OkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:40:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljbBN6vxsVNKW8gD3WkXqFECdVnC9v+VUW5dVVsA/6QGuNRLzOX0Lx3eMghH8ciqMwg6mSWIVd+20f/0gUxanMGseC/3qg2ILv2CQPA0VKGxwMrmrUfQiVw4L62g2a//0Ri9NLDLKCsZP8nYc3zeZTEuCICaPMRLr23Y9bMRwfZEhsK1cPPvnMEBp70rz9IO37b01Q1fseLqa+g8x+wVOc8asVw9Xd5YMB+i+o9K/lRAAuraSJDw7u2ZrBsnM+FH16PbyZmrQhxcAcMigkkljAkSK8UF6ajlRNPnkGD/zC7J5w+FtR/oPHx3bK07e0zejQQul9iDiapYd/VV7eFS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wfh+4STqPkLNPJvPtrIKaQSBoqQcrwpNDPewkuCik0=;
 b=fvD11hpy25Eb1GSx5Y6tallTDZDizQAGGnBVBA6skrK/70EQZbMEAjC+h4AkiTQIp9D0b4LI0nJLNvRqhvGKundhl0mIwVpgYXGNL3czUuiHtUgT1/EodfcVf+cqMnzqIiV3RCm14sBWsK1DFaij3AloDnY2MdYOC6ocjbVJhJWQyBG0YKNH+J+dLfYQ23O6Y/xDMUYUXmLMqxIPxopcdmvqcyFb4dGOB/PjRE8fmfAgm6N/ciDLWVWHFf1Ku5nstejcdfnMyPuOL798KcZYHnQsO3Br2lYUClpw8Qgvtgf/FesWC1dg+98fIycbIyoRDrFsQI+ln6o5qRzqkxPZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wfh+4STqPkLNPJvPtrIKaQSBoqQcrwpNDPewkuCik0=;
 b=Oy3Sykwb8Ng8U3IlXoH3jhi6dpqMKHDv6k3gDBqtm/Rv9DjlDTP1Ag17PslLisPxTwBCAhjPBrWw/lbchI/zA8tST+pOowc9gvdAsGdKdYQLF+8fQmDk00QQJcVieZ6+TI4sbIwQEimIp1fy4Dxvt9bTXdMTEsGQo5vjfHq+QNE=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2461.namprd12.prod.outlook.com (2603:10b6:802:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 30 Nov
 2020 14:39:30 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::d877:baf6:9425:ece%3]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 14:39:30 +0000
Subject: RE: [PATCH v2] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <160589301962.26308.4728709200492788764.stgit@bmoger-ubuntu>
 <cd932b15-4094-7f97-a019-057af2aa577c@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <b4aa6ba0-e2f4-ecca-7087-1a3fa0277290@amd.com>
Date:   Mon, 30 Nov 2020 08:39:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <cd932b15-4094-7f97-a019-057af2aa577c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 14:39:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad6b4a32-56f7-4fab-4b34-08d8953dbec7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2461:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2461014C9938BE756662BDB395F50@SN1PR12MB2461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5JH8ygF4Rhi23wGv1dsnROvAmkVmH/j+n4//zEPyKyB5TOuOlZmaJegv1cLTtVwEV7myA/dgnqEF6Et1vBGU1n57J9enIjxSJHtSV9ocumpRzGd19XndTV0hxTSs/ndxcwmVWbqBBwAprY9NtrugLwq/O3050dHNMCdjIWxUeVRuu7ZohAblgJ9Gi3zSGoUbBDMxOGGGqKwl1/eq0RMnPFAPHrcBKSxSO5S+1uCjTYLjFokqU7HHdWnJZE12qse3bNoO5A53VOA5G8pKMnfn1SXD73Qtuenav52WinZ+KFQ085heT0B1ykUN4fV8ng6QMpxpalX6FBg900mJFAE0DJiYGoFdg6BHqlciAwS06E0QZYICak35CMAPDSzpvSnbbJnOatYG+r5OgJjCjXrs0QUIlrBPXmPZYTgrTmBGLD5XaRaXATL1pvRnN6Hbdd4QWSp9M2sRz9bPZQ6RZ0fkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(6486002)(83380400001)(316002)(110136005)(54906003)(53546011)(31686004)(16576012)(52116002)(45080400002)(966005)(186003)(478600001)(5660300002)(31696002)(16526019)(26005)(66476007)(4326008)(8936002)(2906002)(2616005)(8676002)(66556008)(66946007)(956004)(44832011)(36756003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGFvMTZINCtDMnVRSEwwZE9GbG0rR0svMzV4aGhSTFJLMGd3REkwVlZsUGV1?=
 =?utf-8?B?OWd4OGMyb0x0dHJqdExwNDFQMk16Ym9TNTZram03Y1IwbzV6SFAyRG1XcEJn?=
 =?utf-8?B?L3VZcWNQeE5HZzFHTXhHQW9rQ051dlh6bFhFRllueXRrQUhBQWxBenQ1Wlpv?=
 =?utf-8?B?L3ZrcnNyaXRkSUgxdERhZzVMTEdPOC9FRnk4c1FMaHIxSUhobGpOSzBZM29N?=
 =?utf-8?B?b1NCV0xsOHpCNHhFRUVZNmJielJIWjUwTWRmVFQ1d1NNRXhLWjU4U3E5YXpD?=
 =?utf-8?B?SXovK1FlZDdEM0hYNE5GTll0NjRycXpQeGkyN3FBRmYrVU1vcGFlTzJEbEMz?=
 =?utf-8?B?Tkx5RDdYelQreGpydjBjTktyYlFTRC9KZUdXamIxcHJUeFhweUNOckJ6SW0v?=
 =?utf-8?B?VVNvOUlBazIzQXRnUUdCcHNvZ0tKWUtrbTVNaTh1QVFaVmFoZ0lFMHNnWUZ3?=
 =?utf-8?B?TGREeDlIUGRva0tPUmxqSmp4TElmQ2NxVEI4MUx4SC9xYmJUbm13MHp4SWp5?=
 =?utf-8?B?MjhrMWdCT2VwVlRIUjZCWWhsaGRWNjhtYTJXQXJjNU9HdkwrdFZYa3JJYnF2?=
 =?utf-8?B?QjZHbG52V0ErUWhDWEtkM0xJbU1KVnBUREJwUG5oNFFtcGp6dUovL2ErME1M?=
 =?utf-8?B?MWVuZ2luN2V5cUZNNmpxcXcwQVQ4VHNDWk1qOHlpZVRNbzJ5QlhjUjVyYlNm?=
 =?utf-8?B?R1MvWGVCQ3FWTXAwbGVtYnBlalcvMzFVd1lqNHQ3blBYbks5VGZJODNFWDB1?=
 =?utf-8?B?Vmk2SFREdExSeUtrV1E1MFo4RGJ1ZHMwSCttQ1FRT3FueXNYQmk2cTRIaEhL?=
 =?utf-8?B?ckxacUt1RmNrMTA4U3Fyd2FVTERTVWM0UTVQbGt4YTJWSE52ejhwQ1B3WkZW?=
 =?utf-8?B?dTMzdFdKb2ZYKzcyazE3eXBVNERJRzI2ZzU1Z1l5enlQS2Z1QWFhekovSG44?=
 =?utf-8?B?OWtNUHFKMDY3RHZ2Y0c1SlpSRXNhUklMRTBBU3ZhYllMMGU4TUIvRzIrNFVi?=
 =?utf-8?B?aURWQ3VUaUNDK0pwcS8vUGhsUmJtcW5QaHo0TW1zL2VHaGg1b3RzbmlycGU5?=
 =?utf-8?B?ZGlNRGVWaGFsQVN1TDk5MWVxbHhBQnAzcytNZXBoalNORTQ0RzdldGZoZjBk?=
 =?utf-8?B?MGRYVU91MFNIQUpmc3E2djBsOSsyUFhvQUw1cW1aSFRXVDVqaVNuUWIvUzNw?=
 =?utf-8?B?cWZGdFNVaTArZSs2SDYxT1VNcTVxN0ttcWFOdDBaazhZS2pZOFB1Umlud0ZQ?=
 =?utf-8?B?WGhMVWNCeUIvakQxVnNEVThXWmFVY2JGSFFRUTZucW5walRYenlVQVQvUUVQ?=
 =?utf-8?Q?yJQIElHfVTKc1mFfQqdlDuX4RrTNBhDlTa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6b4a32-56f7-4fab-4b34-08d8953dbec7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 14:39:30.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCJC1GMlaWYORIFmDEaiAYZsuemQGK83ZqMpAx4iq//RL1JL6XdHWmNhf0shRGJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2461
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Tuesday, November 24, 2020 11:23 AM
> To: Moger, Babu <Babu.Moger@amd.com>; bp@alien8.de
> Cc: fenghua.yu@intel.com; x86@kernel.org; linux-kernel@vger.kernel.org;
> mingo@redhat.com; hpa@zytor.com; tglx@linutronix.de
> Subject: Re: [PATCH v2] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
> 
> Hi Babu,
> 
> On 11/20/2020 9:25 AM, Babu Moger wrote:
> > When the AMD QoS feature CDP(code and data prioritization) is enabled
> > or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
> > CPUs in L3 domain(core complex). That is not correct. The CDP bit
> > needs to be updated all the logical CPUs in the domain.
> >
> > This was not spelled out clearly in the spec earlier. The
> > specification has been updated. The updated specification, "AMD64
> > Technology Platform Quality of Service Extensions Publication # 56375
> > Revision: 1.02 Issue
> > Date: October 2020" is available now. Refer the section: Code and Data
> > Prioritization.
> >
> > Fix the issue by adding a new flag arch_has_per_cpu_cfg in rdt_cache
> > data structure.
> >
> > The documentation can be obtained at the links below:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdeve
> > loper.amd.com%2Fwp-
> content%2Fresources%2F56375.pdf&amp;data=04%7C01%7C
> >
> babu.moger%40amd.com%7C5dd411c029da43716aad08d8909daa39%7C3dd89
> 61fe488
> >
> 4e608e11a82d994e183d%7C0%7C1%7C637418354605231589%7CUnknown%7
> CTWFpbGZs
> >
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> >
> %7C1000&amp;sdata=uhSBwxk%2BvcdCjgkq%2B0ew%2Fx1abL32KJEoe7Dil1CF
> qX4%3D
> > &amp;reserved=0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=04%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7C5dd411c029da43716aad08d8909daa39%7C3dd8961fe48
> 84e608e
> >
> 11a82d994e183d%7C0%7C1%7C637418354605231589%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 100
> >
> 0&amp;sdata=5LWDsBKkTmKfKrDfALJQlo6PySMtBVX2iVna9KaiWwE%3D&amp;r
> eserve
> > d=0
> >
> > Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > v2: Taken care of Reinette's comments. Changed the field name to
> >      arch_has_per_cpu_cfg to be bit more meaningful about the CPU scope.
> >      Also fixed some wordings.
> >
> > v1:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> >
> .kernel.org%2Flkml%2F160469365104.21002.2901190946502347327.stgit%40b
> m
> > oger-
> ubuntu%2F&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C5dd411c029
> da4
> >
> 3716aad08d8909daa39%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C1%
> 7C63741
> >
> 8354605241539%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2lu
> >
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VNVZzPr9IvV4Hp
> tYI9
> > VqCN8uXLtlKBVtG%2FUaGEavRLM%3D&amp;reserved=0
> >
> >   arch/x86/kernel/cpu/resctrl/core.c     |    4 ++++
> >   arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
> >   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> >
> 
> ...
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> > b/arch/x86/kernel/cpu/resctrl/internal.h
> > index 80fa997fae60..bcd9b517c765 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -360,6 +360,8 @@ struct msr_param {
> >    *			executing entities
> >    * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
> >    * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
> > + * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
> > + * 				level has CPU scope.
> 
> Please fixup the spacing to not have spaces before tabs. This will make
> checkpatch happy and fit with in with the rest of the comments for this struct.

Sure. Will fix it.
> 
> >    */
> >   struct rdt_cache {
> >   	unsigned int	cbm_len;
> > @@ -369,6 +371,7 @@ struct rdt_cache {
> >   	unsigned int	shareable_bits;
> >   	bool		arch_has_sparse_bitmaps;
> >   	bool		arch_has_empty_bitmaps;
> > +	bool		arch_has_per_cpu_cfg;
> >   };
> >
> >   /**
> 
> ...
> 
> This patch looks good to me.
> 
> With the one style comment addressed you can add:
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
Thanks
-Babu
