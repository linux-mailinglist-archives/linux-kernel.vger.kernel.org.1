Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF892ABDF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKIN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:57:54 -0500
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:19872
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729850AbgKIN5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZIguQPn0ITAs2JcTWVFzER8uca6pJ1qzQMM2RDgZdVi+YIB4VbmJIDbCH0w4Zx9inXU/Jr9H5nuwmQ8/QuYIJTDCDCq8vDNPNCGvVsVe1nOnV+ZWhEnjdY6tPBB1KSnE2f610ulohtRVT66/uxxVhS79bGZ5m+u7VuStWcWKnP7WT8qxffqNkM9A7i8ZsccTF0Dfbxy7qb1tFiwIF5cMh8aoJvS9JvQB7fU50eFdRUY5l1kP4Ag/Jr+sdeSkYcEIfj4fcWQUacsoLymVSVTbHVjHRrdqmHapdZOGyz+JJ65HRr5aRp7NpUldevJ4PocYRdhemoetXSNCxD7tqj7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zd+K5ZeA5bNMAAEdFT3B8AJV9bZzDaRV83ZeFGNXOo=;
 b=of5mBYc14ytguc2Qc9Ks/xQ+FMiDXEcGFkeXte4QOiHm201BgGACHgbGb8dveP7tnG18mJbyBsq0yQ7q6kbGgEeU7rT+An7cEqDVxvYoskZO3aPaN4OyPsYrEFa2t0uwpXDvDcBAmuXj63HoK5Wf0+rqQ/5tYIosIjD6pt4Dp7D9H2lFyFI4113Em72Owz5R81GVEvR87DdaThLKlvQEO9Xr0soEM9qYC2hbXCaaShHB5uF9LZ0IH3YysZsTbOuZ74qLKyNT/k/yzSSRGGdZq3uWaNF59Y8UlkRnkaENFp4WAJp9gpsf9fLJnWaAq88qZoF+wertM5wwrNDr+9QEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zd+K5ZeA5bNMAAEdFT3B8AJV9bZzDaRV83ZeFGNXOo=;
 b=GU0tI3Uha6BV6bHVdKv0Y2v1rSsg0F9bKPGYJLnpzw+QZ9Fz+B5S+nu6/nb/qt+vQ0/3O9IqhtS6AYOw+0kydMHK0rabg/dDZNHvWb50acBLGvIBshIhvCqfPx6USVsowJDQJOIVSasyjfgZ8lsvsf5q2tLidn5ATEuD2APe0tU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 13:57:51 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 13:57:50 +0000
Subject: Re: On disabling AGP without working alternative (PCI fallback is
 broken for years)
To:     =?UTF-8?B?VGhvbWFzIOKAnGlsbHdpZWNreuKAnCBEZWJlc3Nl?= 
        <dev@illwieckz.net>, LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>
References: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3db81eda-c7b3-0a1f-786c-5946863895a3@amd.com>
Date:   Mon, 9 Nov 2020 14:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::44) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0139.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 13:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c34490c-bbd0-4eb9-0fc0-08d884b7721c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3999E38A4E835754083C79DD83EA0@MN2PR12MB3999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZXMkpxEgmnT5P1XTt6pOtR020V21gIEgar9YWKc8LU3ap2wAAgiVxCxMganBaqk8Fj5ZSRitmgnhUhOtO0q63uulPTFTezXkXh0LyaXVc4k5FzIrEOVq/aHfl8NTTqvOKHupRpwE/WgoBJD8CqCxHflztUWKCohzuzTZKwuvand7gnUjrTA2IqISiLADVqPiTLTTLKi4/zdTY3eB7xCeRnvGDZdsnDGkAiQnUEMemJrn1p9EQrsWibetz+Y488XzZKIqdNBCkDD7t6r0Zf3CeKn9zPyd/s4HGP5XKosEKKV1nqKI4+QlYMaeVBkTgNat93z11+PEapCvsO2/XSJAjSzN3dJzULrV4t5P7wQnQcZ6KhBEDGNxDz1zcdMuO9Zzm6k2xK6FqwqQqVN9/CtSG6Xysu0nwVtSJyxulBwOa0WLUJgD0bnAfw39RO9eXqMXqExxNQJJsiKe08jIC5Kog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(2616005)(6666004)(478600001)(316002)(6486002)(36756003)(4326008)(66476007)(66556008)(66946007)(52116002)(110136005)(186003)(8676002)(31696002)(83380400001)(966005)(66574015)(16526019)(8936002)(2906002)(31686004)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWtKWUdLVzUzazBqTjhFdUM2RGxxS0IwcEtIZGdFeTdSdXpQMElDWFkzdnUr?=
 =?utf-8?B?ZjNHV2Vpc1hTL2F5SXNsSE5pdzYwd250TURXWlYzZ1BBc3V6UFBlcjViWExx?=
 =?utf-8?B?OWFKMzNhRjByTGJscDVYaFYyN3d6OGxLOWtKRCtNTmYxdFMrOVgrUm4xUGdL?=
 =?utf-8?B?UEwxbytCdlZuck1TRURnK2F3MlN6eTRJSDJzUnlkTzFqVElUaGNXSUV4dkwy?=
 =?utf-8?B?OHZaTXI0YVZIbloxVGxlcWg4a1FqVWd4NStSY0taZ0Ixd1FraUZnVk81YVBB?=
 =?utf-8?B?aDI0ck1FTzFjczdUN2RKa01TenFWcUVMVm5ZeEJZVDBIc2hSczM1Z1RMYytF?=
 =?utf-8?B?bmluemxaSjhZejlLaEdxeGdhOWgrRGlHLzRYZVRVMDk5MDB5Y3VWRmc1V0VN?=
 =?utf-8?B?SHRzR1ZWWTNPdFB3ZE1WbHVHSmhWaWJNQ213RHJFNWFIR1ZOUlg0dHRjc05S?=
 =?utf-8?B?QjJjWFdHaUkrd1BHQjhXbkRFaEQ4MVBWWGJwc3RqZi9JekRJa1lEZnFiZTJT?=
 =?utf-8?B?UU9lUXQwZUpod1F0aUw5bXFrdFJQSlllK3FBSUtCMUh2VGROQVYya045Mkpv?=
 =?utf-8?B?WFV4cWM0OHQ1V2NTUEhhT1g5dUNUTjd5M2hScHEzcVE4Q0xWeTBlN3RwVTNy?=
 =?utf-8?B?Q2o1L1hySUgyR1oyWDliRnpjaGNjSXlnRHNxQ1VSQjA1ME5HUStpM1hWa1F6?=
 =?utf-8?B?L1paOFNEMEZ2TGpGVERyY2h5Zmt1Z0NNVDh1MDIvMHFUeVZlTE1mcHpSMm1i?=
 =?utf-8?B?L29SRGNIOHBVbjZwSm1GQkFaTWNjSkJ5SkkyTE5RS1VzSUtUSUlFS0hSOFJE?=
 =?utf-8?B?SXIyd3dhODhESm05dGFRNnBEQUlvaG1peXJQRzMyQzhqUDY0cHFVYSsxTncy?=
 =?utf-8?B?U3ZaU2NjVWZUTjBtV2RvaXFmZlN0K0JsRlFVMjR0Zk1hZllIRVNEV2FObWVw?=
 =?utf-8?B?TVV0SUMwY1IrYm14bC9QVmEwdnhPenVIV1B4c3F1L2Z5QzlGUnJOTENqVW1p?=
 =?utf-8?B?MU80ZDdrVFZ4WmkreHdOdWFvTDRLTVM5bmk4dGJ2L2xNY1JZbkQ4ZmVVYmta?=
 =?utf-8?B?bUNMMk1TQXJqRktEbVoxcXhQQWdYMCtnc21oZWhvQVhFV29KaitVOEhNV1Fx?=
 =?utf-8?B?bjFsc24xbjMrQ0s4WDlXek45NHl1d1BXa2pVOFlWTUxTeG5QUGZHaWxDYVZx?=
 =?utf-8?B?Z1EzK3dFWDBqaUhGRDNkYkhYMm84UDRNaE9uZ2RIVmc0THFnUzhsWnZQeTBD?=
 =?utf-8?B?bGVGM0g2MlJOcExWUG9aVjRJblc0ZlpPeW81ZHFkVUZSdmNSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c34490c-bbd0-4eb9-0fc0-08d884b7721c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 13:57:50.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5oKXVt2858diaCT9b8XwBiMtWLc4s72Nu3Lbob1PxiaroTJONQigvStsRy4t2h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Am 09.11.20 um 12:40 schrieb Thomas “illwieckz“ Debesse:
> Hi, on May 12 2020, a commit (ba806f9) was merged disabling AGP
> in default build.
>
> It was signed-off by Christian König and Reviewed by Alex Deucher.
> Distributions started to backport this commit, and it seems to have
> happened with 5.4.0-48-generic on Ubuntu 20.04 LTS side, which was
> built on Sep 10 2020.
>
> Around that time I noticed AGP computers experiencing lock-ups and
> other problems making them unusable after the upgrade. After
> investigating what was happening bisecting Linux versions,
> I reverted the commit and those computers were working again.
>
> Commit message was:
>
>> This means a performance regression for some GPUs,
>> but also a bug fix for some others.
> Unfortunately, this commit does not only introduce a performance
> regression but makes some computers unusable, maybe all computers
> with AMD CPUs.
>
> One of the root cause may be that PCI GPUs are broken for years on
> AMD platforms, it was tested and verified on:
>
> - K8-based computer with AGP
> - K8-based computer with PCI Express
> - K10-based computer with AGP
> - Piledriver-based computer with PCI Express

That is interesting but doesn't make much sense from the technical 
perspective.

See AGP is build on top of PCI, if PCI doesn't work AGP won't work 
either. So why should AGP work while PCI doesn't?

If I'm not completely mistaken I should have a system from that time 
somewhere here.

> The breakage was tested and reproduced from Linux 4.4 to Linux
> 5.10-rc2 (I have not tried older than 4.4).
>
> PCI GPUs may be broken on some other platforms, but I have found
> that testing on an Intel PC (with PCI Express) does not reproduce
> the issue when the PCI GPU hardware is plugged in.
>
> There is two patches I'm requesting comments for:
>
> ## drm/radeon: make all PCI GPUs use 32 bits DMA bit mask
>
> https://lkml.org/lkml/2020/11/5/307
>
> This one is not enough to fix PCI GPUs but it is enough to prevent
> to fail r600_ring_test on ATI PCI devices. Note that Nvidia PCI GPUs
> can't be fixed by this, and this uncovers other bug with AGP GPUs when
> AGP is disabled at build time. Also, this patch may makes PCI GPUs
> working on a non-optimal way on platform that accepts them with 40-bit
> DMA bit mask (like Intel-based computers that already work without any
> patch).
>
> This patch is inspired from the patch made to solve that issue from
> 2012 on kernel 3.5: https://bugzilla.redhat.com/show_bug.cgi?id=785375
>
> At the time, such change may have been enough to fix the issue, it's
> not true any more. More breakage may have been introduced since.
>
> Also, maybe this patch becomes useless when other PCI bugs are fixed,
> who knows? At least, this is an entry-point for investigations.
>
> ## Revert "drm/radeon: disable AGP by default"
>
> https://lkml.org/lkml/2020/11/5/308
>
> This is the simple fix but currently only solution to make AMD hosts
> with AGP port to get a display again, as without this reverts, those
> computers do not have any alternative to run a display (even not PCI
> GPUs).

Well you can still use the agpmode parameter to override the default 
setting.

We simply don't have the time to support that older GPU and disabling 
AGP fixed quite a number of them.

> I'm asking for comments on those patches. I may have reached my own
> skill cap on kernel development anyway. I can repurpose hardware to
> test any other patch and can contribute time for such testing. Unlike
> AGP GPUs, PCI GPUs are hard to find, so you may appreciate the time and
> availability offered.
>
> The PCI GPU on AMD CPU issue was verified with both Nvidia
> (GS 8400GS rev.2) and ATI (Radeon HD 4350) PCI GPUs, such GPU
> sample not being old cards from the previous millennial but capable
> ones: TeraScale RV710 architecture on ATI side and Tesla 1.0 NV98
> on Nvidia side. They can both do OpenGL 3.3 and feature both
> 512M of VRAM. The ATI one had HDMI port, and it is known some variant
> of the Nvidia one (not the one I own but same specification) had HDMI
> port too.

To be honest I think we will completely drop AGP support in the next 5 
years or so, this includes both Nouveau as well as Radeon based GPUs.

We simply can't invest time maintaining a technology which is deprecated 
for nearly 15 years now.

Regards,
Christian.

>
> Also, fixing PCI GPUs may not be enough to fix AGP GPUs running
> as PCI ones, since fixing some issues (not all) on PCI side raises
> new issues with AGP GPUs running as PCI ones but not on native PCI
> GPUs (see below).
>
> Bugs aside, one thing that is important to consider against the AGP
> disablement is that there is such hardware that is very capable and
> not that old out there. For example the ATI Radeon HD 4670 AGP
> (RV730 XT) was still sold brand new after 2010 and is a powerful
> and featureful GPUs with 1GB of VRAM and HDMI port. Performance with
> it is still pretty decent on competitive games. To compare with other
>   open source drivers mainlined in Linux, to outperform this GPU an
>   user has to get an Intel UHD 600 or an Nvidia GTX 1060 from 2016.
>
> Also, yet another thing that is important to consider against AGP
> disablement is that if PCI Express was introduced in 2004, there
> was still AGP compatible hardware being designed, produced and sold
> very lately, especially on AMD side. Computers with quad core 64-bit
> CPUs with virtualisation, 16GB of RAM and AGPs exist, and this is
> widely distributed consumer hardware, not specific esoteric hardware.
>
> So, not only powerful AGP GPUs were still sold brand new in the current
> decade, but there was also very capable computers to host them. Because
> of those AGP computers, fixing PCI GPUs fallback is not a solution
> because PCI fallback is not a solution.
>
> All that range of hardware became unusable with that commit disabling
> AGP, without alternative.
>
> Not only those AGP GPUs don't work with kernel's PCI fallback, but
> unplugging those AGP GPUs and plugging physical PCI-native GPUs
> instead does not work.
>
> You'll find more details about the various issues on those bugs, I've
> invested multiple full time day to test and reproduce bugs on a wide
> range of hardware, I've attached, quoted and commented a lot of logs:
>
> - https://bugs.launchpad.net/bugs/1899304
>> AGP disablement leaves GPUs without working alternative
>> (PCI fallback is broken), makes very-capable ATI TeraScale GPUs
>> unusable
> - https://bugs.launchpad.net/bugs/1902981
>> AGP GPUs driven as PCI ones (when AGP is disabled at kernel build
>> time) are known to fail on K8 and K10 platforms
> - https://bugs.launchpad.net/bugs/1902795
>> PCI graphics broken on AMD K8/K10/Piledriver platform (while it
>> works on Intel) verified from Linux 4.4 to 5.10-rc2
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to my posting.
>
> Thank you for your attention.
>
> -- 
> Thomas “illwieckz” Debesse

