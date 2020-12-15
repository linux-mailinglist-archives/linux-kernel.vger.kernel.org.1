Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD42DA80C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgLOGRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:17:01 -0500
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:64996
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgLOGQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:16:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlZcsf0i9zfWEcS3Cr4BgQjstgf5dUO+O0lzdsvv0sllCnhNEKN97pzBuKNs7uTo0VbaujqKu6GzE7zz1hkra586d0PzTd4eYBGscBeqIbALOoR6gDSaZ9acn0tlnf2fPSesgTITsMEv6WOT1Mo2d0sueO2qIeq+mu10rF3mqFZe9KWwdzblAIuloiV42PPqiNtJYEr+rT3QFjLRyJfW0YR6F9/U8t44BGMY8sMN4LlvA6JzZ9P+LjGPgJb1RwffTw3EpGHbWuyrMaX8VfNm8nzjTudqYD95fYGRw2zdQ9SWrR5kZ9aBZgM+3TLoLiSiqUwbZJiTvGmw3yiyeh2RBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Iy5Edsg6cDLtL14Li1Tssjyncjp2QoTvG/uEup3QD4=;
 b=VtOjWE/RSI6dqmKdN8WL11YgViZQCrngOQIaf5RmDctDNm6ARMEKBZkShFtErhPQk4rxCmLPRCfljMZQvLd4nqby5gLC+PTmvgjDy6mr7PJtthMuKtfbfcVhYrSOxP7MOXIqCls5sQ9AQdhUTCxvZ3MqrxetJN0xpSQZ6Gj/pU0nzNwH0xwBCQsNy1ll/djRDMBirYBIQiCte/FmkPDoOYz+LktKJvURZo8vb5NJndXRZxi7xQ0QkQQMlGbkpQ1QjE93I8Rh3udvM1OebZeFC25/eNBm+4tpIavzR0JPDTpJS6iJ2rb8qV6YTcpupdnuDskDRYD4fwcMew721fGcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Iy5Edsg6cDLtL14Li1Tssjyncjp2QoTvG/uEup3QD4=;
 b=Yod7mkD/tNrLhK51pdRv7dqTnfI8FgL2B8SQRco0zoQ89sTGjCo67i0j9YnOAyjv25brKjweWdp65jzKQjuCK6fBsIr/HWez++saY8S8Z3j7lBa/JO7yUlg6wttjOAhAbOAFcJ3fjWdZJ3embKGfNo/r0Apszp/UUANuFwhRu/A=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 by BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 06:15:53 +0000
Received: from BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::e920:46d3:92b:9450]) by BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::e920:46d3:92b:9450%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 06:15:51 +0000
Date:   Tue, 15 Dec 2020 14:16:48 +0800 (CST)
From:   "Huang, Ying-Tsun" <ying-tsun.huang@amd.com>
X-X-Sender: amd@ytubuntu20
To:     Borislav Petkov <bp@alien8.de>
cc:     Ying-Tsun Huang <ying-tsun.huang@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org,
        Dmitry Lapik <dmitry.kolyadintsev@nyriad.com>,
        James Lee <James.Lee@amd.com>
Subject: Re: [PATCH] x86/mtrr: Correct the returned MTRR type of
 mtrr_type_lookup.
In-Reply-To: <20201211105239.GA25974@zn.tnic>
Message-ID: <alpine.DEB.2.22.394.2012141717490.6150@ytubuntu20>
References: <20201207061227.131580-1-ying-tsun.huang@amd.com> <20201211105239.GA25974@zn.tnic>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HKAPR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:c9::13) To BY5PR12MB4163.namprd12.prod.outlook.com
 (2603:10b6:a03:202::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ytubuntu20.amd.com (165.204.134.251) by HKAPR03CA0026.apcprd03.prod.outlook.com (2603:1096:203:c9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Tue, 15 Dec 2020 06:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f3f04ce-26ba-4f5d-7398-08d8a0c0df84
X-MS-TrafficTypeDiagnostic: BYAPR12MB3285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB328590FBC925B0B71615A7ABAEC60@BYAPR12MB3285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltFUOAV5AYOh3TPjpVnmfWm4yYp+kalI3WbL31E0WQFZr53UEPMy2zO1CzHWewPuV8g2T3GPHKWQyxaSsRtt+dfAgJf/tm/A0BonhZy/8AC4Orw1tLQQE3Bmw1SB7ibwJOtFh5srAJUcTYJ7xDIaZbHwZ3tzmtdbAC9wpgj6hhGf2dDeolkNuQ4YHI646eFtbdVVWyH0UMo5Em+XD8fKCq0RK9fxaDpMOfZJ83F7Pof6u2d6JMX7sYSPD3uEMUJq3qxBwE6BLH5heDN1TAscqO1G+v3t2xBCrou3HAwXyzcmhFGaUNI0/VZ6V9yDc8CedD3xMl+XFq4DRMpSTvwqbuWuy5wwCRVdo9JgURUj5YtXP2+eay9wJlqZsDfJmUoTKpO3sHn79D77H5mNlfVnIL+TOqnjO4u5iTk4ly383e7zrhWt9lIA3ga4QiC/pfc60rIK6jVBEP+wD2K1cFcPVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(956004)(26005)(66556008)(54906003)(5660300002)(66476007)(7416002)(52116002)(86362001)(66946007)(45080400002)(9576002)(9686003)(6916009)(6486002)(8936002)(16526019)(508600001)(966005)(8676002)(4326008)(33716001)(34490700003)(186003)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VepGPFeV/omnFI0Xp+8JoyhxU5gOEvmtPC85/ytk1ws9JspMAfWNB2AO7McR?=
 =?us-ascii?Q?ySLiPu7eFRf52taGlbfDjTHuN7E7YltMPB81avsm55zaB5P72jb9wzsmtB/A?=
 =?us-ascii?Q?2N5mpoSL8VDMyiJsSugQTCaUjwaDXbTteKwZSjzLqsLkXjaGYlIOtB8v7uED?=
 =?us-ascii?Q?vkJwgnND4VO+nhYBVcGJALblEuyqfm8ejIF8YD+2EMbrn8C8grSwr3341zUb?=
 =?us-ascii?Q?4lEnvZ+fFao3Lhv+CxM9P/kSqvKASFYqLQNnIkivWLE8z8ew3f9wqDPC7tqB?=
 =?us-ascii?Q?A5T/Cej2D2AFife1Q/pLSeRSrsZBYw/bNh7lO21myQhjfuDJ+UEpo3Ukk1mk?=
 =?us-ascii?Q?ZYWcaUo0ovrdpFaKjVvdlHhFpryOalr6ZTZATvpDtFgAnElrNvTyZa1yBGo0?=
 =?us-ascii?Q?kERHKK/v6GsksYW4EDkLL+tvm/yPBEsC24vZTLVjCdglUASHXIbSo7SywIYJ?=
 =?us-ascii?Q?ZNnzjL/lzXZ511+2zQoGwG+UWJSNQooqDAcI+my2d9ggIKLTYzLKH/xvbPHz?=
 =?us-ascii?Q?5ppi1HpVc4R58AnuNDcZZRQM61t5xIu/hQv//D0/PtU90CeIT1zjfvSVvMFt?=
 =?us-ascii?Q?PNzaEAalyUtxwcvltjDZKCZSZyGpLiE//koQQyzpc9WvNgWBbbeav4kdzNYb?=
 =?us-ascii?Q?mHJhrVtOLG5CApncl8TBv86rHE/j8yGqyhTr9+jrz1G6t72IA++0S0PKlpVQ?=
 =?us-ascii?Q?N+uin8NFKB2ju9DQCWju7OGGoQVfmHWYULEPuhoIS6jVPlgGIbwPtb7pkvLm?=
 =?us-ascii?Q?ywgDviKAOwbahbwp4juKum4vIf10gKdErFtR5N8h3B7mrG1cpIki3+GyXa+Y?=
 =?us-ascii?Q?oWXNIwprD7xwEuaPCXS2S2p6jniImwCiqenrv/qP0amiVfoAZNhTfq//CHtN?=
 =?us-ascii?Q?X3N/3dV/MUdTX+z8D2mfrM8pGmQDl+2lCO70E95sD8hglN0XPzyUM7qsUJyf?=
 =?us-ascii?Q?Q+Ia0WeFNrCO9+Cm1djHdk4xoj4snUa8cPepkwj1a3OlzYn5xLF6EJp5CaDk?=
 =?us-ascii?Q?MP+1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 06:15:51.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3f04ce-26ba-4f5d-7398-08d8a0c0df84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8r8T6SRGb9IHxZxzMJeE7X8shp7/Y5+Qj01mI6jExjHQsfFOLchrIoAW4MWn6fq39TGHUaejXMEiAGLCdWeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Dec 2020, Borislav Petkov wrote:

> [CAUTION: External Email]
> 
> On Mon, Dec 07, 2020 at 02:12:26PM +0800, Ying-Tsun Huang wrote:
> > In mtrr_type_lookup, if the input memory address region is not in the
> > MTRR, over 4GB, and not over the top of memory, write-back attribute
> > is returned. These condition checks are for ensuring the input memory
> > address region is mapped to the physical memory actually.
> >
> > However, if the end address is just aligned with the top of memory,
> > the condition check treats the address is over the top of memory, and
> > write-back attribute is not returned.
> 
> Oh fun. So to make sure I understand this correctly end ends up equal to
> TOM2?
> 

Yes, it's equal to TOM2.

> > There is a real case of NVDIMM. The nd_pmem module tries to map
> > NVDIMMs as cacheable memories when NVDIMMs are connected. If a NVDIMM
> > is the last of the DIMMs, the performance of this NVDIMM becomes very
> > low since it aligned with the top of memory and its memory type is
> > uncached-minus.
> >
> > To check the top of memory should use "<=" instead of "<" since both the
> > input end address and the value of top of memory are actually the start
> > of next region.
> 
> Right, so looking at that function, it calls
> mtrr_type_lookup_variable(), among others, and that does:
> 
>         /* Make end inclusive instead of exclusive */
>         end--;
> 
> which sounds to me like it expects ranges with exclusive end.
> 
> So maybe it would be better to do something like:
> 
>         /*
>          * Blurb about end address being == tom2, perhaps give your example
>          */
>         end--;
> 
> above the check so that it is absolutely obvious why this is done.
> 
> But but, looking at this more, the PPR says about TOM2:
> 
> "This value is normally placed above 4G. From 4G to TOM2 - 1 is DRAM;
> TOM2 and above is MMIO."
> 
> So the check is *actually* correct - TOM2 - 1 is DRAM so you need '<'.
> 
> Unless you do end-- before, which would make sense and suggest the end
> decrement to be the proper fix.
> 
> Hmm?
> 

I think your comment makes sense, "TOM2 - 1" is the last DRAM address, we 
should make the end be included in the DRAM range, and the condition check 
becomes more precise to use "<", even the both codes are with the same
result.

> > Fixes: b73522e0c1be ("x86/mm/mtrr: Enhance MTRR checks in kernel mapping
> > helpers")
> 
> I think you mean:
> 
> 35605a1027ac ("x86: enable PAT for amd k8 and fam10h")
> 
> which first added that check.
> 
> Btw, while doing git archeology, I saw that mtrr_type_lookup() used to do end--
> on function entry, see
> 
> 2e5d9c857d4e ("x86: PAT infrastructure patch")
> 

With your above comments, the bug should come from
0cc705f56e40 ("x86/mm/mtrr: Clean up mtrr_type_lookup()"

Before this commit, the "end--" is in __mtrr_type_lookup(), and the end 
address is not used in mtrr_type_lookup, so the condition check is 
correct.

After the commit, the end address is started to be used in 
mtrr_type_lookup(), but the "end--" is in the mtrr_type_lookup_variable(), 
it makes the check mtrr_type_lookup() become incorrect.

> Thx.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cying-tsun.huang%40amd.com%7C2e57de535baf40ff480f08d89dc2e51d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432807709717408%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tM5ww%2F96JirsAsDZyImHHtsR3L8TQyr%2B5xWeaGbdwH4%3D&amp;reserved=0
> 
