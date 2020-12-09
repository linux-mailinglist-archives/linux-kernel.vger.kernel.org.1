Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31B52D431D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgLINUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:20:52 -0500
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:21505
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732215AbgLINUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjGYCuP4yg+yI+9O4vVp2419j7BVCuV+lfvq3UyEdp7ny1+CgubzDGpcRxuETWAGJUmc3rofsUiDL6iicDYEOAlNu2ipIHFgNb9adm2ZX3C89Zoi3ftHU2IVjHI7wvVmD7gcNrXoco0/bY9El+L9xAMcFEMPwzyiG4mkoTcGiJPtRx3Uw/68V5C7cSxg6PtiHIDgdh+hSB/F+42Amd8CTeH3s0PTVfGf/fzi4dpEJPIi7YsSDDz4DjqTPOEMlKcNG66TUBn+suRGVTAeEU1fpZJP25SyER/fsHWxezROnDJiooavN4xSZcTwnMOHgnkYItixKczWdKI6lRcvLuTJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YvmQJB6de1eTxFqtRnGhb+Nxqia3MhBC+YkPpythlQ=;
 b=RqbQf7hHmJs4+/P64M3lqtvea6SaHBE162x6xF9IEhMuYi32aBkw7cOrYijoWtt/TbF0OL7EOJEJPiHthIrRdorG6u24yNqXFdd3/S4JsErwlYiZgX3g/YF0cMxvckDCd+hLWjrQ3D0SYqGlKFOOM6nAjSmHYKPgRCGCaP1N0YrJH0wne7H/eo8zN+PM72AEurvQChOtWOV9pnFD4FQlWu0RXcC/UqOJTjb0oORk7NpyOtiQBal2jAP7TPRw04GWXwuswQ4igCpUfrp1J0jfCP9uBAVn/FwlgQLyvxUhscM50ETtmhbL9Ga2RL3J/1WhQ4hu05gpaIZHkIqtK/bnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YvmQJB6de1eTxFqtRnGhb+Nxqia3MhBC+YkPpythlQ=;
 b=ViSRKxkxF+NzsrdWCd8B7UY4FySijIYQJWNVY1abot6d58k9Ep6gvBXQPDSb1Cv0jTFHBnjNmPAw+dwag3a/FFN3DvUp6+p38ep7oFD/2Gq9JbjFgYI11/71wURFQxitIK2qab0T6DL/Ny2pncAJaG+B54s1o5UV70WHxVyaZqM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 13:19:55 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 13:19:55 +0000
Date:   Wed, 9 Dec 2020 13:19:46 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209131946.GA6495@ashkalra_ubuntu_server>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
 <20201209122907.GA6258@ashkalra_ubuntu_server>
 <20201209125442.GC18203@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209125442.GC18203@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CH2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:610:58::40) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 13:19:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38ba3745-a1a5-4892-8ef9-08d89c451e7b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416584A1E362E7D58457BB48ECC0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGunzsuMDnsRF30ql6Y5J93DxDe/syvgWDnKPsklQCoYyGXvBUcjS7ZXFehnTkXFNBdVy/updh3NDmMsobscGGwfZ8X+bbZNmoVjI0SbQjFwnUewNr1bYk5AVaNgxoJXUKMpK+WxurENet6fRaeo3vAZha0us/lmUdRdGN0pXSDUSKTG9I9qiKjGiFvuHJe0nYumDbOlnIo4qgRMhH4YAXGAT6bP7j3NY22tE+17mNNHKOH7n5SPJp7T3h6TAE3T8YoCFCMH2Wqr8zsfUlRLnhLJnwdIncGPWQFnpO6U0I6wH3RkS7POOcG0FsogQBXVA73hdHJnF/GjzBjr5TgkodNtQMI9OYKfUxYAeSfgY/62VA7qyLSGdaHrJl1BNUJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(8936002)(2906002)(8676002)(33656002)(83380400001)(5660300002)(16526019)(52116002)(508600001)(4326008)(9686003)(6916009)(86362001)(956004)(1076003)(44832011)(33716001)(55016002)(26005)(6666004)(7416002)(6496006)(66946007)(186003)(66556008)(34490700003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E08KMGFOBsVuBzDGelwUDrIxjTjbf+SzXwV4T2A3BxSNI6V+cJBfeQh/t7aO?=
 =?us-ascii?Q?ACIrNqpKyW0HUvFJLrXeZKrYnP2k9OoHx7o6jFbR/d1gFQPSoEB1TkwMKHNe?=
 =?us-ascii?Q?VWUY6OOV2bt5I+oOjL2WVfyqRzbVZDvGJ2XvVjTHTtyHqoVuGSA0clJxxxQv?=
 =?us-ascii?Q?Zfb8jo5Lns1h6pfunU6ZwsftL4gUXyzA8vNL5BwNQOvAmd+U9GxZUdA/NRGQ?=
 =?us-ascii?Q?7MZgggYczyhtv7jYGHgZfSX+N+8488b1nnW5dCY37frI2wW2veS8Rcl6edse?=
 =?us-ascii?Q?2VT7Mdvwyl10NEEoMWLtoiRgdSS7Bh1o+kQuL2AHiohcMUQQlcXcd3grlHyU?=
 =?us-ascii?Q?jNfK/EXJooqm7ACL7wk6S4SSFX6CdRqpYR6pmlnHCQAQ7g9vkWXMIRnQwjl1?=
 =?us-ascii?Q?noCPeDx8itpAHg7zxAtNF2wrUQGAfG/xMj5sILoRc0HRp/TzLZDi3pfhSPof?=
 =?us-ascii?Q?iM8HUgy6azbcHlNAv66vAqVLwvyAUyBRJGH0I5r32WE/+mXrmpZilvJh8+jW?=
 =?us-ascii?Q?0Ptcm+1MrjxOSkE/sM/O7RUs9cLNB8QQ/VJFZ7s1JSBPaLcHtEVj13o8DUpo?=
 =?us-ascii?Q?CwlLXzE0sYkU3fOIIMwFfHciroFLVYbSpC2muPBLW2YczUQhPhXs0HU/SDWS?=
 =?us-ascii?Q?k+l8sFJCeWfYtriiITQpOKlyA62qPqzUBuoJFqNurbU7lwV4nx4bTKI8X54K?=
 =?us-ascii?Q?L2b5d0sfhJ6AN3N9n2w8sX60qSW+u5JUZ26grsVj3Cgt8+wXSayJ4NfNLkOz?=
 =?us-ascii?Q?53fkwmw3eLyP3IXW9WETzskZOF5pN6M+Rs56NjsL7s6wTPjLqzXj0MTw3EUi?=
 =?us-ascii?Q?+83rVShoyojVMds36DKM3XI1Jg3gXtIWIVd1skn9QrosFNW8KOQxMPv0GmVB?=
 =?us-ascii?Q?jOtXsGmNEPsYyneDLMAlef5Dp9jcB35zbUHteg9DQz1PZSfaJVOZGl7Eeaoc?=
 =?us-ascii?Q?ua+19ckLL1SVF+WKpmEQJyH4e9W5ayYvVrGL2rnO1staGmQ2+yZ5XixliL0f?=
 =?us-ascii?Q?u64l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 13:19:54.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba3745-a1a5-4892-8ef9-08d89c451e7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQRhB7EGaj2ahcEpUlJiZE8Y8L/FWD1uXyPh4EYy5DnlF+7qYXfWMHieshX5VJUl/ygZBvEikOSrKOKP0sbhSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:54:42PM +0100, Borislav Petkov wrote:
> On Wed, Dec 09, 2020 at 12:29:07PM +0000, Ashish Kalra wrote:
> > As i mentioned in the main comments above, this cannot be called in
> > mem_encrypt_init() as that breaks reserve_crashkernel() which depends
> > on SWIOTLB buffer size
> 
> Please elaborate how does it break.
> 

reserve_crashkernel() calls swiotlb_size_or_default() to get SWIOTLB
buffer size and then accordingly allocates low memory for crashkernel. 
If SWIOTLB buffer size is adjusted after reserve_crashkernel() and
swiotlb_size_or_default(), then SWIOTLB buffers will overlap the memory
reserved for crashkernel. Hence any SWIOTLB buffer adjustment needs to
be done before or in swiotlb_size_or_default(), but Konrad is not in
favor of modifying swiotlb_size_or_default(), hence this separate
swiotlb_adjust() interface is introduced. 

> > and is called before mem_encrypt_init(), therefore, it needs to be
> > called from setup_atch() before reserve_crashkernel().
> 
> I know you have your requirements what needs to be called when like all
> the other vendors who want to run stuff early in a particular order but
> our boot init order is a single fragile mess. So this better be done
> right!
> 
> Also,
> 
> [    0.016630] software IO TLB: swiotlb_adjust:
> [    0.017005] reserve_crashkernel:
> [    0.050523] software IO TLB: swiotlb_init:
> 
> this looks strange - we're doing a swiotlb size adjust before init.
> 
> It probably makes sense as in: adjust the size before the SWIOTLB is
> initialized so that it uses the correct size but this better be spelled
> out.
> 

Yes the adjustment is done before init. 

> > I believe that other memory encryption architectures such as s390 are
> > also looking for something similar to be available.
> 
> Until you have something more palpable than belief, "let the others
> extend it when they really need it." as I already mentioned.

There is a need to introduce an architecture specific callback
for swiotlb_adjust() because of the following reason :

The sev_active() function is only available to x86, so this will break
other archs, if we use this function in generic swiotlb code.

Therefore, we need arch-specific callback/interface to be invoked from
generic swiotlb code to do the SEV specific actions such as SWIOTLB
buffer size adjustment.

Thanks,
Ashish

